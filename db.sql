-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: localhost    Database: portefeuille_db
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `positions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_fond` int DEFAULT NULL,
  `id_instrument` int DEFAULT NULL,
  `quantite` decimal(10,2) DEFAULT NULL,
  `prix_achat` decimal(10,2) DEFAULT NULL,
  `date_achat` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_fond` (`id_fond`),
  KEY `id_instrument` (`id_instrument`),
  CONSTRAINT `positions_ibfk_1` FOREIGN KEY (`id_fond`) REFERENCES `referentiel_fonds` (`id`),
  CONSTRAINT `positions_ibfk_2` FOREIGN KEY (`id_instrument`) REFERENCES `referentiel_instruments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (10,7,6,20.00,150.00,'2023-08-22'),(11,7,8,10.00,1000.00,'2010-02-20'),(12,8,6,10.00,200.00,'2016-10-12'),(13,8,7,5.00,100.00,'2018-10-22'),(14,8,8,45.00,200.00,'2019-10-12'),(15,9,8,50.00,200.00,'1989-12-10'),(16,9,6,12.00,100.00,'2002-12-18'),(17,10,6,100.00,20.00,'2010-10-10'),(18,11,9,20.00,10.00,'2010-10-10'),(19,11,7,20.00,20.00,'1920-02-20');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referentiel_fonds`
--

DROP TABLE IF EXISTS `referentiel_fonds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referentiel_fonds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_fond` varchar(100) NOT NULL,
  `description` text,
  `date_creation` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referentiel_fonds`
--

LOCK TABLES `referentiel_fonds` WRITE;
/*!40000 ALTER TABLE `referentiel_fonds` DISABLE KEYS */;
INSERT INTO `referentiel_fonds` VALUES (7,'Fond d\'exemple A','Un fond d\'exemple','2024-08-22'),(8,'Fond d\'exemple B','Un fond d\'exemple','2024-08-09'),(9,'Fond d\'exemple C','Un fond d\'exemple','2024-08-11'),(10,'Fond d\'exemple D','Un fond d\'exemple','2020-05-20'),(11,'Fond d\'exemple E','Un fond d\'exemple','2024-08-11');
/*!40000 ALTER TABLE `referentiel_fonds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referentiel_instruments`
--

DROP TABLE IF EXISTS `referentiel_instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referentiel_instruments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_instrument` varchar(100) NOT NULL,
  `type_instrument` varchar(50) DEFAULT NULL,
  `date_introduction` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referentiel_instruments`
--

LOCK TABLES `referentiel_instruments` WRITE;
/*!40000 ALTER TABLE `referentiel_instruments` DISABLE KEYS */;
INSERT INTO `referentiel_instruments` VALUES (6,'Instrument A','Type A','2018-06-08'),(7,'Instrument B','Type A','2020-10-28'),(8,'Instrument C','Type B','1999-02-20'),(9,'Instrument D','Type C','1900-12-12');
/*!40000 ALTER TABLE `referentiel_instruments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-22  0:53:54
