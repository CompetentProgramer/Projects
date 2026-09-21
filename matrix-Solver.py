# pip install sympy
from sympy import symbols, Matrix, solve, simplify

def analyze_system(matrix):
    row_length = len(matrix[0])
    num_vars = row_length - 1

    # Build matrices
    A = Matrix([row[:-1] for row in matrix])
    b = Matrix([row[-1] for row in matrix])
    Aug = A.row_join(b)

    print("Coefficient matrix A:")
    print(A)
    print("\nAugmented matrix [A | b]:")
    print(Aug)

    # RREF
    ref_matrix, pivots = Aug.rref()
    print("\nAugmented matrix in Row Echelon Form (REF):")
    print(ref_matrix)
    print("Pivot columns:", pivots)

    # Rank
    rank_A = A.rank()
    rank_Aug = Aug.rank()
    print("\nRank of A:", rank_A)
    print("Rank of [A | b]:", rank_Aug)

    # Determinant
    if A.rows == A.cols:
        det_A = A.det()
        print("\nDeterminant of A:", det_A)

        if det_A == 0:
            print("Det(A) = 0: Matrix is singular (not invertible)")
        else:
            print("Det(A) != 0: Matrix is invertible")
    else:
        print("\nDeterminant not defined (A is not square)")

    # Linear independence
    if rank_A == A.cols:
        print("The columns of A are linearly independent")
    else:
        print("The columns of A are linearly dependent")

    # Geometric interpretation
    if rank_A == 0:
        geom = "The vectors do not span any space (all zero vectors)"
    elif rank_A == 1:
        geom = "The vectors span a line"
    elif rank_A == 2:
        geom = "The vectors span a plane"
    elif rank_A == 3:
        geom = "The vectors span 3D space"
    else:
        geom = f"The vectors span a {rank_A}-dimensional space"
    print("Geometric interpretation:", geom)

    # Detect symbols in A
    symbols_in_matrix = set()
    for entry in A:
        symbols_in_matrix.update(entry.free_symbols)
    for entry in b:
        symbols_in_matrix.update(entry.free_symbols)

    if symbols_in_matrix:
        print(f"\nSystem contains symbolic parameters: {symbols_in_matrix}")

    # Check if the system is consistent
    if rank_A != rank_Aug:
        print("\nNo solution for generic parameter values")
        return

    # If full rank, unique solution
    if rank_A == num_vars and not symbols_in_matrix:
        print("\nUnique solution:")
        print(A.LUsolve(b))
        return

    # Infinite solutions
    print("\nInfinite solutions (generic case)")
    particular = A.gauss_jordan_solve(b)[0]
    nullspace = A.nullspace()
    params = symbols(f't1:{len(nullspace)+1}')
    general_solution = particular
    for t, v in zip(params, nullspace):
        general_solution += t*v

    print("\nGeneral solution (equation form):")
    for i in range(num_vars):
        print(f"x{i+1} = {simplify(general_solution[i])}")

    # Check special cases for symbolic parameters
    if symbols_in_matrix:
        for symb in symbols_in_matrix:
            # Solve det(A) = 0 if square
            if A.rows == A.cols:
                det_poly = A.det()
                if det_poly.has(symb):
                    special_values = solve(det_poly, symb)
                    if special_values:
                        for val in special_values:
                            print(f"\nSpecial case: {symb} = {val}")
                            A_sub = A.subs(symb, val)
                            b_sub = b.subs(symb, val)
                            Aug_sub = A_sub.row_join(b_sub)
                            rank_A_sub = A_sub.rank()
                            rank_Aug_sub = Aug_sub.rank()
                            if rank_A_sub != rank_Aug_sub:
                                print("No solution")
                            elif rank_A_sub == num_vars:
                                print("Unique solution:")
                                print(A_sub.LUsolve(b_sub))
                            else:
                                # Infinite solutions
                                print("Infinite solutions")
                                particular_sub = A_sub.gauss_jordan_solve(b_sub)[0]
                                nullspace_sub = A_sub.nullspace()
                                params_sub = symbols(f's1:{len(nullspace_sub)+1}')
                                general_sub = particular_sub
                                for t, v in zip(params_sub, nullspace_sub):
                                    general_sub += t*v
                                print("General solution:")
                                for i in range(num_vars):
                                    print(f"x{i+1} = {simplify(general_sub[i])}")

# Subspace Functions
def null_space_info(matrix):
    """
    Computes basis and dimension of the Null Space of A
    """
    A = Matrix([row[:-1] for row in matrix])
    null_basis = A.nullspace()
    null_dim = len(null_basis)

    print("\n--- Null Space ---")

    if null_dim == 0:
        print("Basis: {0} (only the trivial solution)")
    else:
        print("Basis vectors:")
        for v in null_basis:
            print(v)

    print("Dimension (Nullity):", null_dim)
    return null_basis, null_dim


def column_space_info(matrix):
    """
    Computes basis and dimension of the Column Space of A
    """
    A = Matrix([row[:-1] for row in matrix])
    col_basis = A.columnspace()
    col_dim = len(col_basis)

    print("\n--- Column Space ---")
    print("Basis vectors:")
    for v in col_basis:
        print(v)

    print("Dimension (Rank):", col_dim)
    return col_basis, col_dim


def rank_nullity_check(matrix):
    #Verifies Rank-Nullity Theorem
    A = Matrix([row[:-1] for row in matrix])
    rank = A.rank()
    nullity = len(A.nullspace())

    print("\n--- Rank-Nullity Theorem Check ---")
    print("Rank:", rank)
    print("Nullity:", nullity)
    print("Rank + Nullity =", rank + nullity)
    print("Number of columns =", A.cols)

    return rank, nullity

def eigen_info(matrix):
    A = Matrix([row[:-1] for row in matrix])

    print("\n--- Eigenvalues and Eigenvectors ---")

    if A.rows != A.cols:
        print("Eigenvalues are only defined for square matrices.")
        return None
    
    eigenvalues = A.eigenvals()
    eigenvectors = A.eigenvects()

    print("Characteristic polynomial:")
    lam = symbols('lambda')
    char_poly = (A - lam * A.eye(A.rows)).det()
    print(f"det(A - lambda I) = {simplify(char_poly)}")

    print("\nEigenvalues (with algebraic multiplicity):")
    for val, alg_mult in eigenvalues.items():
        print(f"lambda = {val}  (algebraic multiplicity: {alg_mult})")

    print("\nEigenvectors (grouped by eigenvalue):")
    is_diagonalizable = True
    for val, alg_mult, vecs in eigenvectors:
        geo_mult = len(vecs)
        print(f"lambda = {val}")
        print(f"Algebraic multiplicity : {alg_mult}")
        print(f"Geometric multiplicity : {geo_mult}")
        print(f"Eigenvectors (basis for eigenspace):")
        for v in vecs:
            print(f"{v.T}\n")
        if geo_mult < alg_mult:
            is_diagonalizable = False

    print("Diagonalizability:")
    if is_diagonalizable:
        print("A is diagonalizable (geo. mult == alg. mult for every eigenvalue)")
        P, D = A.diagonalize()
        print("Modal matrix P (columns are eigenvectors):")
        print(f"{P}")
        print("Diagonal matrix D (eigenvalues on diagonal):")
        print(f"{D}")
    else:
        print("A is NOT diagonalizable (geo. mult < alg. mult for at least one eigenvalue)")

    return eigenvalues, eigenvectors

# You can add symbols as nesesary, may crash you system
k, d = symbols('k d')

# Input problem here, last row is the constants
system = [
    (1, 2, 0, 1, 0),
    (0, 1, 3, 2, 0),
    (2, 0, 1, 1, 0),
    (1, 1, 2, 0, 0)

]

analyze_system(system)
null_space_info(system)
column_space_info(system)
rank_nullity_check(system)
eigen_info(system)