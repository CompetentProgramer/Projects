-- MySQL dump 10.13  Distrib 9.6.0, for macos15.7 (arm64)
--
-- Host: centerbeam.proxy.rlwy.net    Database: railway
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CRM_PROFILE`
--

DROP TABLE IF EXISTS `CRM_PROFILE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CRM_PROFILE` (
  `crm_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `preferred_channel` varchar(100) DEFAULT NULL,
  `lifetime_value` decimal(12,2) DEFAULT NULL,
  `total_orders` int DEFAULT NULL,
  `last_purchase_date` timestamp NULL DEFAULT NULL,
  `compliance_flag` varchar(100) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`crm_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `CRM_PROFILE_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMER` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CRM_PROFILE`
--

LOCK TABLES `CRM_PROFILE` WRITE;
/*!40000 ALTER TABLE `CRM_PROFILE` DISABLE KEYS */;
INSERT INTO `CRM_PROFILE` VALUES (1,1,'IronGrid Online Store',4250.00,12,'2024-11-20 14:00:00','CLEAR','Loyal repeat buyer'),(2,2,'IronGrid Retail',1800.50,6,'2024-10-05 10:00:00','CLEAR','Prefers in-store pickup'),(3,3,'GunBroker Marketplace',9800.00,28,'2024-12-01 09:30:00','CLEAR','High-volume collector'),(4,4,'IronGrid Online Store',450.00,2,'2024-09-14 16:00:00','CLEAR','New customer'),(5,5,'IronGrid Wholesale',6500.00,19,'2024-11-30 08:00:00','CLEAR','Dealer account');
/*!40000 ALTER TABLE `CRM_PROFILE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER`
--

DROP TABLE IF EXISTS `CUSTOMER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `loyalty_tier` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_customer_loyalty` (`loyalty_tier`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER`
--

LOCK TABLES `CUSTOMER` WRITE;
/*!40000 ALTER TABLE `CUSTOMER` DISABLE KEYS */;
INSERT INTO `CUSTOMER` VALUES (1,'James','Hartwell','james.hartwell@email.com','813-555-0201','1985-03-14','2022-01-10 09:00:00','Gold'),(2,'Maria','Delgado','maria.delgado@email.com','813-555-0202','1990-07-22','2022-03-15 10:30:00','Silver'),(3,'Tyler','Brooks','tyler.brooks@email.com','813-555-0203','1978-11-05','2021-06-20 08:00:00','Platinum'),(4,'Sandra','Nguyen','sandra.nguyen@email.com','813-555-0204','1995-02-18','2023-02-01 11:00:00','Bronze'),(5,'Derek','Coleman','derek.coleman@email.com','813-555-0205','1982-09-30','2020-09-05 07:30:00','Gold');
/*!40000 ALTER TABLE `CUSTOMER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER_ADDRESS`
--

DROP TABLE IF EXISTS `CUSTOMER_ADDRESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER_ADDRESS` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(100) NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `CUSTOMER_ADDRESS_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMER` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER_ADDRESS`
--

LOCK TABLES `CUSTOMER_ADDRESS` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_ADDRESS` DISABLE KEYS */;
INSERT INTO `CUSTOMER_ADDRESS` VALUES (1,1,'101 Oak Lane','Brandon','FL','33511','USA',1),(2,2,'202 Palm Ave','Tampa','FL','33601','USA',1),(3,3,'303 Maple Dr','Orlando','FL','32801','USA',1),(4,4,'404 Cedar Blvd','Miami','FL','33101','USA',1),(5,5,'505 Birch St','Jacksonville','FL','32099','USA',1);
/*!40000 ALTER TABLE `CUSTOMER_ADDRESS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DIGITAL_PRODUCT`
--

DROP TABLE IF EXISTS `DIGITAL_PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DIGITAL_PRODUCT` (
  `product_id` int NOT NULL,
  `download_url` varchar(500) DEFAULT NULL,
  `max_downloads` int DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `compatible_platform` varchar(255) DEFAULT NULL,
  `file_format` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `DIGITAL_PRODUCT_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DIGITAL_PRODUCT`
--

LOCK TABLES `DIGITAL_PRODUCT` WRITE;
/*!40000 ALTER TABLE `DIGITAL_PRODUCT` DISABLE KEYS */;
INSERT INTO `DIGITAL_PRODUCT` VALUES (10,'https://irongrid.com/dl/train001',3,'2025-12-31','Web/iOS/Android','MP4/PDF');
/*!40000 ALTER TABLE `DIGITAL_PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INVENTORY`
--

DROP TABLE IF EXISTS `INVENTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INVENTORY` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `quantity_on_hand` int NOT NULL,
  `reorder_threshold` int NOT NULL,
  `quantity_on_order` int NOT NULL,
  `last_updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `product_id` (`product_id`,`warehouse_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `INVENTORY_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`),
  CONSTRAINT `INVENTORY_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `WAREHOUSE` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INVENTORY`
--

LOCK TABLES `INVENTORY` WRITE;
/*!40000 ALTER TABLE `INVENTORY` DISABLE KEYS */;
INSERT INTO `INVENTORY` VALUES (1,1,1,25,10,0,'2026-04-25 23:54:24'),(2,1,2,10,5,5,'2026-04-25 23:54:24'),(3,2,1,8,3,0,'2026-04-25 23:54:24'),(4,2,3,5,2,2,'2026-04-25 23:54:24'),(5,3,1,200,50,0,'2026-04-25 23:54:24'),(6,3,4,150,50,100,'2026-04-25 23:54:24'),(7,4,1,12,5,0,'2026-04-25 23:54:24'),(8,4,2,6,3,0,'2026-04-25 23:54:24'),(9,5,1,40,10,0,'2026-04-25 23:54:24'),(10,5,3,20,10,0,'2026-04-25 23:54:24'),(11,6,1,18,8,0,'2026-04-25 23:54:24'),(12,7,2,6,2,0,'2026-04-25 23:54:24'),(13,8,1,75,20,0,'2026-04-25 23:54:24'),(14,9,1,22,5,0,'2026-04-25 23:54:24'),(15,10,1,999,100,0,'2026-04-25 23:54:24');
/*!40000 ALTER TABLE `INVENTORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INVOICE`
--

DROP TABLE IF EXISTS `INVOICE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INVOICE` (
  `invoice_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `channel_id` int NOT NULL,
  `address_id` int NOT NULL,
  `invoice_date` timestamp NULL DEFAULT NULL,
  `transfer_type` varchar(100) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `surcharge_amount` decimal(12,2) DEFAULT NULL,
  `tax_amount` decimal(12,2) DEFAULT NULL,
  `shipping_cost` decimal(12,2) DEFAULT NULL,
  `total_amount` decimal(12,2) GENERATED ALWAYS AS (((`surcharge_amount` + `tax_amount`) + `shipping_cost`)) STORED,
  `payment_method` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `customer_id` (`customer_id`),
  KEY `channel_id` (`channel_id`),
  KEY `address_id` (`address_id`),
  KEY `idx_invoice_status_transfer` (`status`,`transfer_type`),
  CONSTRAINT `INVOICE_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMER` (`customer_id`),
  CONSTRAINT `INVOICE_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `SALES_CHANNEL` (`channel_id`),
  CONSTRAINT `INVOICE_ibfk_3` FOREIGN KEY (`address_id`) REFERENCES `CUSTOMER_ADDRESS` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INVOICE`
--

LOCK TABLES `INVOICE` WRITE;
/*!40000 ALTER TABLE `INVOICE` DISABLE KEYS */;
INSERT INTO `INVOICE` (`invoice_id`, `customer_id`, `channel_id`, `address_id`, `invoice_date`, `transfer_type`, `status`, `surcharge_amount`, `tax_amount`, `shipping_cost`, `payment_method`) VALUES (1,1,1,1,'2024-11-01 10:00:00','FFL','Completed',0.00,48.00,15.00,'Credit Card'),(2,2,2,2,'2024-11-05 14:00:00','Pickup','Completed',0.00,88.00,0.00,'Cash'),(3,3,3,3,'2024-11-10 09:00:00','FFL','Completed',50.00,180.00,25.00,'Credit Card'),(4,4,1,4,'2024-11-15 11:30:00','Direct','Completed',0.00,11.20,8.99,'PayPal'),(5,5,4,5,'2024-12-01 08:00:00','FFL','Completed',0.00,52.00,0.00,'Wire Transfer'),(6,1,1,1,'2024-12-10 13:00:00','Direct','Completed',0.00,11.20,5.00,'Credit Card'),(7,3,1,3,'2024-12-15 10:00:00','FFL','Pending',0.00,80.00,15.00,'Credit Card'),(8,2,2,2,'2026-04-26 00:21:35','FFL','Pending',0.00,52.00,0.00,'Credit Card'),(9,2,2,2,'2026-04-27 03:35:20','FFL','Pending',0.00,52.00,0.00,'Credit Card');
/*!40000 ALTER TABLE `INVOICE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INVOICE_HISTORY`
--

DROP TABLE IF EXISTS `INVOICE_HISTORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INVOICE_HISTORY` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `invoice_id` int NOT NULL,
  `old_status` varchar(50) NOT NULL,
  `new_status` varchar(50) NOT NULL,
  `changed_at` timestamp NOT NULL,
  `changed_by` varchar(100) NOT NULL,
  `change_reason` text,
  PRIMARY KEY (`history_id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `INVOICE_HISTORY_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `INVOICE` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INVOICE_HISTORY`
--

LOCK TABLES `INVOICE_HISTORY` WRITE;
/*!40000 ALTER TABLE `INVOICE_HISTORY` DISABLE KEYS */;
INSERT INTO `INVOICE_HISTORY` VALUES (1,1,'Pending','Completed','2024-11-01 12:00:00','system','FFL transfer confirmed'),(2,2,'Pending','Completed','2024-11-05 15:00:00','admin','In-store pickup completed'),(3,3,'Pending','Completed','2024-11-12 09:00:00','system','FFL transfer confirmed'),(4,4,'Pending','Completed','2024-11-15 13:00:00','system','Digital delivery confirmed'),(5,5,'Pending','Completed','2024-12-01 10:00:00','admin','Wholesale order fulfilled'),(7,9,'None','Pending','2026-04-27 03:35:20','system','New invoice created at point of sale');
/*!40000 ALTER TABLE `INVOICE_HISTORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INVOICE_LINE_ITEM`
--

DROP TABLE IF EXISTS `INVOICE_LINE_ITEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INVOICE_LINE_ITEM` (
  `line_item_id` int NOT NULL AUTO_INCREMENT,
  `invoice_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `surcharge_applied` decimal(12,2) DEFAULT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `line_total` decimal(12,2) GENERATED ALWAYS AS ((((`unit_price` * `quantity`) + `surcharge_applied`) - `discount_amount`)) STORED,
  PRIMARY KEY (`line_item_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `product_id` (`product_id`),
  KEY `idx_lineitem_price` (`unit_price`),
  CONSTRAINT `INVOICE_LINE_ITEM_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `INVOICE` (`invoice_id`),
  CONSTRAINT `INVOICE_LINE_ITEM_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INVOICE_LINE_ITEM`
--

LOCK TABLES `INVOICE_LINE_ITEM` WRITE;
/*!40000 ALTER TABLE `INVOICE_LINE_ITEM` DISABLE KEYS */;
INSERT INTO `INVOICE_LINE_ITEM` (`line_item_id`, `invoice_id`, `product_id`, `quantity`, `unit_price`, `surcharge_applied`, `discount_amount`) VALUES (1,1,1,1,599.99,0.00,0.00),(2,1,5,1,139.99,0.00,0.00),(3,2,2,1,1099.99,0.00,0.00),(4,3,4,1,1249.99,50.00,0.00),(5,3,3,4,17.99,0.00,0.00),(6,4,3,8,17.99,0.00,5.00),(7,5,6,1,649.99,0.00,0.00),(8,6,5,1,139.99,0.00,0.00),(9,6,3,2,17.99,0.00,0.00),(10,7,9,1,479.99,0.00,0.00),(11,7,8,1,89.99,0.00,0.00),(12,8,6,1,649.99,0.00,0.00),(13,8,9,1,479.99,0.00,0.00),(14,9,6,1,649.99,0.00,0.00),(15,9,9,1,479.99,0.00,0.00);
/*!40000 ALTER TABLE `INVOICE_LINE_ITEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manufacturer`
--

DROP TABLE IF EXISTS `Manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Manufacturer` (
  `vendor_id` int NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `export_license_num` varchar(100) DEFAULT NULL,
  `license_expiry` date DEFAULT NULL,
  `is_preferred` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manufacturer`
--

LOCK TABLES `Manufacturer` WRITE;
/*!40000 ALTER TABLE `Manufacturer` DISABLE KEYS */;
INSERT INTO `Manufacturer` VALUES (1,'Glock GmbH','sales@glock.com','555-0101','1 Glock Blvd, Deutch','EXP-001','2027-12-31',1),(2,'Smith & Wesson','sales@sw.com','555-0102','2100 Roosevelt Ave, MA','EXP-002','2026-06-30',1),(3,'Magpul Industries','contact@magpul.com','555-0103','407 Laker Pkwy, CO','EXP-003','2025-09-15',0),(4,'Trijicon Inc','info@trijicon.com','555-0104','49385 Shafer Ave, MI','EXP-004','2028-01-01',1),(5,'Streamlight','support@streamlight.com','555-0105','30 Meridian Blvd, PA','EXP-005','2026-11-30',0);
/*!40000 ALTER TABLE `Manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PHYSICAL_PRODUCT`
--

DROP TABLE IF EXISTS `PHYSICAL_PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PHYSICAL_PRODUCT` (
  `product_id` int NOT NULL,
  `item_type` varchar(100) DEFAULT NULL,
  `weight_lbs` decimal(8,2) DEFAULT NULL,
  `dimensions` varchar(100) DEFAULT NULL,
  `caliber_or_spec` varchar(100) DEFAULT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `PHYSICAL_PRODUCT_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PHYSICAL_PRODUCT`
--

LOCK TABLES `PHYSICAL_PRODUCT` WRITE;
/*!40000 ALTER TABLE `PHYSICAL_PRODUCT` DISABLE KEYS */;
INSERT INTO `PHYSICAL_PRODUCT` VALUES (1,'Pistol',1.48,'7.36x5.04x1.26 in','9mm','Glock GmbH'),(2,'Rifle',6.54,'35x10x3 in','5.56 NATO','Smith & Wesson'),(3,'Magazine',0.33,'7.6x2.4x1.1 in','5.56/.223','Magpul Industries'),(4,'Optic',0.99,'5.8x2.4x2.4 in','4x32','Trijicon Inc'),(5,'Light',0.36,'3.39x1.5x1.5 in','1000 lumen','Streamlight'),(6,'Pistol',1.67,'8.03x5.47x1.26 in','9mm','Glock GmbH'),(7,'Revolver',2.60,'9.5x5.5x1.5 in','.44 Mag','Smith & Wesson'),(8,'Stock',0.53,'10x3x2 in','Mil-Spec','Magpul Industries'),(9,'Optic',0.29,'2.6x1.7x1.4 in','2 MOA','Trijicon Inc'),(11,'Optic',0.41,'2.9x1.8x1.6 in','1x38mm','Trijicon Inc');
/*!40000 ALTER TABLE `PHYSICAL_PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCT`
--

DROP TABLE IF EXISTS `PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRODUCT` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `sku` varchar(100) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text,
  `product_category` varchar(100) NOT NULL,
  `base_price` decimal(12,2) NOT NULL,
  `delivery_method` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `idx_product_category` (`product_category`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCT`
--

LOCK TABLES `PRODUCT` WRITE;
/*!40000 ALTER TABLE `PRODUCT` DISABLE KEYS */;
INSERT INTO `PRODUCT` VALUES (1,'GLK-G19-9MM','Glock 19 Gen5 9mm','Compact 9mm pistol, Gen5','Handgun',599.99,'FFL Transfer',1),(2,'SW-MP-556','S&W M&P15 5.56mm Rifle','Semi-auto AR platform rifle','Rifle',1099.99,'FFL Transfer',1),(3,'MPL-PMAG-30','Magpul PMAG 30rd Magazine','30-round polymer magazine for AR-15','Accessory',17.99,'Direct Ship',1),(4,'TRJ-ACOG-4X','Trijicon ACOG 4x32','4x magnified combat optic','Optic',1249.99,'Direct Ship',1),(5,'STL-TLR1-HL','Streamlight TLR-1 HL','High-lumen weapon-mounted light','Accessory',139.99,'Direct Ship',1),(6,'GLK-G17-9MM','Glock 17 Gen5 9mm','Full-size 9mm duty pistol','Handgun',649.99,'FFL Transfer',1),(7,'SW-629-44','S&W Model 629 .44 Magnum','Stainless steel .44 Mag revolver','Handgun',999.99,'FFL Transfer',1),(8,'MPL-STK-CTR','Magpul CTR Carbine Stock','Mil-spec carbine stock for AR-15','Accessory',89.99,'Direct Ship',1),(9,'TRJ-MRO-RED','Trijicon MRO Red Dot','Miniature rifle optic, 2 MOA dot','Optic',479.99,'Direct Ship',1),(10,'DIG-TRAIN-001','IronGrid Training Course','Online firearms safety certification','Digital',99.99,'Download',1),(11,'TRJ-SRS-1X','Trijicon SRS 1x38mm Red Dot','Full-size sealed reflex sight with solar power backup','Optic',899.99,'Direct Ship',1);
/*!40000 ALTER TABLE `PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SALES_CHANNEL`
--

DROP TABLE IF EXISTS `SALES_CHANNEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SALES_CHANNEL` (
  `channel_id` int NOT NULL AUTO_INCREMENT,
  `channel_name` varchar(255) NOT NULL,
  `channel_type` varchar(100) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `commission_rate` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SALES_CHANNEL`
--

LOCK TABLES `SALES_CHANNEL` WRITE;
/*!40000 ALTER TABLE `SALES_CHANNEL` DISABLE KEYS */;
INSERT INTO `SALES_CHANNEL` VALUES (1,'IronGrid Online Store','E-Commerce','https://irongrid.com',1,2.50),(2,'IronGrid Retail','In-Store',NULL,1,0.00),(3,'GunBroker Marketplace','Marketplace','https://gunbroker.com',1,5.00),(4,'IronGrid Wholesale','B2B','https://wholesale.irongrid.com',1,1.50),(5,'Amazon Storefront','Marketplace','https://amazon.com/irongrid',0,8.00);
/*!40000 ALTER TABLE `SALES_CHANNEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHIPPING_RESTRICTION`
--

DROP TABLE IF EXISTS `SHIPPING_RESTRICTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHIPPING_RESTRICTION` (
  `restriction_id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `surcharge_pct` decimal(5,2) NOT NULL DEFAULT '0.00',
  `restriction_reason` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`restriction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHIPPING_RESTRICTION`
--

LOCK TABLES `SHIPPING_RESTRICTION` WRITE;
/*!40000 ALTER TABLE `SHIPPING_RESTRICTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `SHIPPING_RESTRICTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUBSCRIPTION_PRODUCT`
--

DROP TABLE IF EXISTS `SUBSCRIPTION_PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUBSCRIPTION_PRODUCT` (
  `product_id` int NOT NULL,
  `billing_cycle` varchar(50) DEFAULT NULL,
  `discount_pct` decimal(5,2) DEFAULT NULL,
  `auto_renew` tinyint(1) NOT NULL,
  `tier_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `SUBSCRIPTION_PRODUCT_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUBSCRIPTION_PRODUCT`
--

LOCK TABLES `SUBSCRIPTION_PRODUCT` WRITE;
/*!40000 ALTER TABLE `SUBSCRIPTION_PRODUCT` DISABLE KEYS */;
/*!40000 ALTER TABLE `SUBSCRIPTION_PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VENDOR_PRODUCT`
--

DROP TABLE IF EXISTS `VENDOR_PRODUCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VENDOR_PRODUCT` (
  `vendor_id` int NOT NULL,
  `product_id` int NOT NULL,
  `vendor_cost` decimal(12,2) DEFAULT NULL,
  `lead_time_days` int DEFAULT NULL,
  `min_order_qty` int DEFAULT NULL,
  `is_primary_vendor` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`vendor_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `VENDOR_PRODUCT_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `Manufacturer` (`vendor_id`),
  CONSTRAINT `VENDOR_PRODUCT_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `PRODUCT` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VENDOR_PRODUCT`
--

LOCK TABLES `VENDOR_PRODUCT` WRITE;
/*!40000 ALTER TABLE `VENDOR_PRODUCT` DISABLE KEYS */;
INSERT INTO `VENDOR_PRODUCT` VALUES (1,1,480.00,7,5,1),(1,6,520.00,7,5,1),(2,2,880.00,14,2,1),(2,7,800.00,14,2,1),(3,3,10.50,5,50,1),(3,8,55.00,5,20,1),(4,4,950.00,10,1,1),(4,9,360.00,10,1,1),(5,5,95.00,7,5,1);
/*!40000 ALTER TABLE `VENDOR_PRODUCT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WAREHOUSE`
--

DROP TABLE IF EXISTS `WAREHOUSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WAREHOUSE` (
  `warehouse_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `region` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WAREHOUSE`
--

LOCK TABLES `WAREHOUSE` WRITE;
/*!40000 ALTER TABLE `WAREHOUSE` DISABLE KEYS */;
INSERT INTO `WAREHOUSE` VALUES (1,'Tampa Main','1000 Industrial Blvd','Tampa','FL','Southeast',1),(2,'Orlando Hub','500 Commerce Way','Orlando','FL','Southeast',1),(3,'Atlanta South','200 Freight Ln','Atlanta','GA','Southeast',1),(4,'Dallas Central','750 Logistics Dr','Dallas','TX','South',1),(5,'Phoenix West','300 Desert Rd','Phoenix','AZ','West',0);
/*!40000 ALTER TABLE `WAREHOUSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_customer_purchase_summary`
--

DROP TABLE IF EXISTS `vw_customer_purchase_summary`;
/*!50001 DROP VIEW IF EXISTS `vw_customer_purchase_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_customer_purchase_summary` AS SELECT 
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `email`,
 1 AS `loyalty_tier`,
 1 AS `total_invoices`,
 1 AS `total_items_bought`,
 1 AS `total_spent`,
 1 AS `avg_item_price`,
 1 AS `last_purchase_date`,
 1 AS `preferred_channel`,
 1 AS `lifetime_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_customer_purchase_summary`
--

/*!50001 DROP VIEW IF EXISTS `vw_customer_purchase_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_customer_purchase_summary` AS select `c`.`customer_id` AS `customer_id`,concat(`c`.`first_name`,' ',`c`.`last_name`) AS `customer_name`,`c`.`email` AS `email`,`c`.`loyalty_tier` AS `loyalty_tier`,count(distinct `i`.`invoice_id`) AS `total_invoices`,sum(`li`.`quantity`) AS `total_items_bought`,sum(`li`.`line_total`) AS `total_spent`,avg(`li`.`unit_price`) AS `avg_item_price`,max(`i`.`invoice_date`) AS `last_purchase_date`,`crm`.`preferred_channel` AS `preferred_channel`,`crm`.`lifetime_value` AS `lifetime_value` from (((`CUSTOMER` `c` left join `CRM_PROFILE` `crm` on((`c`.`customer_id` = `crm`.`customer_id`))) left join `INVOICE` `i` on((`c`.`customer_id` = `i`.`customer_id`))) left join `INVOICE_LINE_ITEM` `li` on((`i`.`invoice_id` = `li`.`invoice_id`))) group by `c`.`customer_id`,`c`.`first_name`,`c`.`last_name`,`c`.`email`,`c`.`loyalty_tier`,`crm`.`preferred_channel`,`crm`.`lifetime_value` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-26 23:48:59
