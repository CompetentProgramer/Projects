#!/usr/bin/env bash
# dbwatch.sh - run on blackbox-t (Linux Mint). Keeps a read-only baseline of the
# plinkcom database from manifest-t and reports rows/schema that change.
#
#   ./dbwatch.sh setup      one-time: save the monitor account's connection details
#   ./dbwatch.sh init       copy the database to blackbox as the baseline
#   ./dbwatch.sh check      compare once
#   ./dbwatch.sh watch      compare every INTERVAL seconds (default 600 = 10 min)
#   ./dbwatch.sh accept     adopt the current DB as the new baseline (after a legit inject change)
#   ./dbwatch.sh restore    put the baseline back into the DB (asks first)
#   ./dbwatch.sh genpass [n]  print a random alphanumeric password
#
# Settings (environment variables): DB_NAME (plinkcom), INTERVAL (600),
# MAX_LINES (40), IGNORE_TABLES (comma list, e.g. sessions,logs), DUMP_EXTRA (e.g. --routines).

set -uo pipefail

HOME_DIR="${DBWATCH_HOME:-$HOME/.dbwatch}"
CNF="$HOME_DIR/client.cnf"
BASE="$HOME_DIR/baseline.sql"
LOG="$HOME_DIR/alerts.log"
DB_NAME="${DB_NAME:-plinkcom}"
INTERVAL="${INTERVAL:-600}"
MAX_LINES="${MAX_LINES:-40}"
IGNORE_TABLES="${IGNORE_TABLES:-}"
DUMP_EXTRA="${DUMP_EXTRA:-}"

mkdir -p "$HOME_DIR"
chmod 700 "$HOME_DIR"

log() { printf '%s %s\n' "$(date '+%F %T')" "$*" | tee -a "$LOG"; }

need() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing '$1'. Try: sudo apt install mariadb-client (ask Black Team if the network blocks it)." >&2
    exit 2
  }
}

cmd_setup() {
  local team host user pass
  read -r -p "Team number: " team
  read -r -p "manifest IP [172.16.${team}.40]: " host
  host="${host:-172.16.${team}.40}"
  read -r -p "Monitor DB user [monitor]: " user
  user="${user:-monitor}"
  read -r -s -p "Password for $user (letters and digits only): " pass
  echo
  ( umask 077
    { echo "[client]"; echo "host=$host"; echo "user=$user"; echo "password=\"$pass\""; } > "$CNF" )
  chmod 600 "$CNF"
  echo "Saved $CNF"
  echo
  echo "Now create that account on manifest (mysql> as an admin account):"
  echo "  CREATE USER '$user'@'172.16.${team}.5' IDENTIFIED BY '<the password>';"
  echo "  GRANT SELECT, SHOW VIEW, TRIGGER, EVENT, LOCK TABLES ON ${DB_NAME}.* TO '$user'@'172.16.${team}.5';"
  echo "Make sure the Windows firewall and bind-address allow blackbox to reach port 3306."
}

# dump_to FILE: one INSERT per row, ordered by primary key, so diffs are per row.
dump_to() {
  local args=(--defaults-extra-file="$CNF" --single-transaction --skip-comments
              --skip-extended-insert --order-by-primary --triggers --events --hex-blob)
  local t tl
  if [ -n "$IGNORE_TABLES" ]; then
    IFS=',' read -ra tl <<< "$IGNORE_TABLES"
    for t in "${tl[@]}"; do args+=(--ignore-table="$DB_NAME.$t"); done
  fi
  if [ -n "$DUMP_EXTRA" ]; then
    # shellcheck disable=SC2206
    args+=($DUMP_EXTRA)
  fi
  mysqldump "${args[@]}" "$DB_NAME" > "$1"
}

# report BASELINE CURRENT: prints a per-table summary; returns 0 if identical, 1 if not.
report() {
  local changes
  changes="$(diff "$1" "$2" | grep -E '^[<>] ' || true)"
  [ -z "$changes" ] && return 0
  printf '%s\n' "$changes" | awk '
    { side = substr($1, 1, 1)
      if (match($0, /INSERT INTO `[^`]+`/)) t = substr($0, RSTART + 13, RLENGTH - 14)
      else t = "(schema/triggers/other)"
      if (side == "<") gone[t]++; else added[t]++
      seen[t] = 1 }
    END { for (t in seen)
            printf "  %-28s baseline-only: %d   current-only: %d\n", t, gone[t] + 0, added[t] + 0 }'
  echo "  --- first $MAX_LINES differing lines (< baseline, > current) ---"
  printf '%s\n' "$changes" | cut -c1-170 | head -n "$MAX_LINES"
  return 1
}

cmd_init() {
  [ -f "$CNF" ] || { echo "Run '$0 setup' first." >&2; return 2; }
  if [ -f "$BASE" ] && [ "${1:-}" != "--force" ]; then
    echo "A baseline already exists ($BASE). Use 'init --force' to replace it." >&2
    return 2
  fi
  local tmp
  tmp="$(mktemp "$HOME_DIR/base.XXXXXX")"
  if ! dump_to "$tmp"; then
    echo "Dump failed: check the host, user, grants and firewall." >&2
    rm -f "$tmp"
    return 3
  fi
  if [ -f "$BASE" ]; then mv "$BASE" "$HOME_DIR/baseline.$(date +%Y%m%d-%H%M%S).sql"; fi
  mv "$tmp" "$BASE"
  chmod 400 "$BASE"
  log "Baseline saved: $BASE ($(grep -c '^CREATE TABLE' "$BASE") tables, $(grep -c '^INSERT INTO' "$BASE") rows, sha256 $(sha256sum "$BASE" | cut -c1-16))"
  echo
  echo "A baseline is only as clean as the moment you took it. The Red Team may have planted"
  echo "things before the start, so skim for triggers/events you don't recognise:"
  grep -niE 'trigger|create.*event' "$BASE" | cut -c1-160 | head -20 || true
}

cmd_check() {
  [ -f "$BASE" ] || { echo "No baseline yet. Run: $0 init" >&2; return 2; }
  local cur out
  cur="$(mktemp "$HOME_DIR/cur.XXXXXX")"
  if ! dump_to "$cur"; then
    log "ERROR dump failed (DB down, password changed, or firewall?). Treat this as an alert."
    rm -f "$cur"
    return 3
  fi
  if out="$(report "$BASE" "$cur")"; then
    log "OK   no differences from baseline"
    rm -f "$cur"
    return 0
  fi
  printf '\a'
  log "CHANGED the database differs from the baseline:"
  printf '%s\n' "$out" | tee -a "$LOG"
  mv "$cur" "$HOME_DIR/changed-$(date +%Y%m%d-%H%M%S).sql"
  return 1
}

cmd_watch() {
  log "Watching '$DB_NAME' every ${INTERVAL}s (Ctrl-C to stop). Ignoring tables: ${IGNORE_TABLES:-none}"
  trap 'log "Stopped."; exit 0' INT TERM
  while true; do
    cmd_check || true
    sleep "$INTERVAL"
  done
}

cmd_accept() {
  [ -f "$BASE" ] || { echo "No baseline yet. Run: $0 init" >&2; return 2; }
  local cur a
  cur="$(mktemp "$HOME_DIR/cur.XXXXXX")"
  if ! dump_to "$cur"; then echo "Dump failed." >&2; rm -f "$cur"; return 3; fi
  report "$BASE" "$cur" || true
  read -r -p "Make the current database the new baseline? [y/N] " a
  if [ "$a" = "y" ]; then
    mv "$BASE" "$HOME_DIR/baseline.$(date +%Y%m%d-%H%M%S).sql"
    mv "$cur" "$BASE"
    chmod 400 "$BASE"
    log "Baseline replaced (accepted by operator)"
  else
    rm -f "$cur"
    echo "Unchanged."
  fi
}

cmd_restore() {
  [ -f "$BASE" ] || { echo "No baseline." >&2; return 2; }
  local host adm c
  host="$(awk -F= '$1 == "host" { print $2 }' "$CNF")"
  echo "This DROPS and recreates the tables of '$DB_NAME' on $host from the baseline."
  echo "Anything the app wrote since the baseline (sessions, logs, new rows) is lost."
  read -r -p "Admin DB user to restore with: " adm
  read -r -p "Type RESTORE to continue: " c
  [ "$c" = "RESTORE" ] || { echo "Aborted."; return 1; }
  mysql -h "$host" -u "$adm" -p "$DB_NAME" < "$BASE" && log "Restored the baseline into $DB_NAME on $host (as $adm)"
}

cmd_genpass() {
  LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c "${1:-20}"
  echo
}

case "${1:-}" in
  setup)   cmd_setup ;;
  init)    need mysqldump; shift; cmd_init "$@" ;;
  check)   need mysqldump; cmd_check ;;
  watch)   need mysqldump; cmd_watch ;;
  accept)  need mysqldump; cmd_accept ;;
  restore) need mysql; cmd_restore ;;
  genpass) shift; cmd_genpass "$@" ;;
  *) sed -n '2,15p' "$0" | sed 's/^# \{0,1\}//' ;;
esac