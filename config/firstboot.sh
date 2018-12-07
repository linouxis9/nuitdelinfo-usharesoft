#!/bin/bash

# Secure MariaDB
mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE nuitinfo;
CREATE USER 'nuitinfo'@'localhost' IDENTIFIED BY 'nuitinfo'; # To Change
GRANT ALL PRIVILEGES ON nuitinfo.* TO 'nuitinfo'@'localhost';
FLUSH PRIVILEGES;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Area`
--

DROP TABLE IF EXISTS `Area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(50) DEFAULT NULL,
  `area_description` text,
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Area`
--

LOCK TABLES `Area` WRITE;
/*!40000 ALTER TABLE `Area` DISABLE KEYS */;
INSERT INTO `Area` VALUES (1,'Montagne','Nécessite un equipement d\'escalade et des vêtements chauds'),(2,'Glaciers','Nécessite un équipement de randonnées extrême et des vêtements très 
chauds'),(3,'Désert','Nécessite des reserves d\'eau et des vêtements très légers'),(4,'Jungle','Nécessite des outils tranchants, des reserves d\'eau et des armes');
/*!40000 ALTER TABLE `Area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CheckList`
--

DROP TABLE IF EXISTS `CheckList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CheckList` (
  `checklist_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`checklist_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `CheckList_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CheckList`
--

LOCK TABLES `CheckList` WRITE;
/*!40000 ALTER TABLE `CheckList` DISABLE KEYS */;
INSERT INTO `CheckList` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1);
/*!40000 ALTER TABLE `CheckList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CheckListOption`
--

DROP TABLE IF EXISTS `CheckListOption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CheckListOption` (
  `checklistoption_id` int(11) NOT NULL AUTO_INCREMENT,
  `weather_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `duration_id` int(11) DEFAULT NULL,
  `checklist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`checklistoption_id`),
  KEY `area_id` (`area_id`),
  KEY `weather_id` (`weather_id`),
  KEY `duration_id` (`duration_id`),
  KEY `checklist_id` (`checklist_id`),
  CONSTRAINT `CheckListOption_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `Area` (`area_id`),
  CONSTRAINT `CheckListOption_ibfk_2` FOREIGN KEY (`weather_id`) REFERENCES `Weather` (`weather_id`),
  CONSTRAINT `CheckListOption_ibfk_3` FOREIGN KEY (`duration_id`) REFERENCES `Duration` (`duration_id`),
  CONSTRAINT `CheckListOption_ibfk_4` FOREIGN KEY (`checklist_id`) REFERENCES `CheckList` (`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CheckListOption`
--

LOCK TABLES `CheckListOption` WRITE;
/*!40000 ALTER TABLE `CheckListOption` DISABLE KEYS */;
INSERT INTO `CheckListOption` VALUES 
(1,1,1,1,1),(2,1,2,1,2),(3,1,3,1,3),(4,1,4,1,4),(5,2,1,1,5),(6,2,2,1,6),(7,2,3,1,7),(8,2,4,1,8),(9,3,1,1,9),(10,3,2,1,10),(11,3,3,1,11),(12,3,4,1,12),(13,4,1,1,13),(14,4,2,1,14),(15,4,3,1,15),(16,4,4,1,16);
/*!40000 ALTER TABLE `CheckListOption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CheckListStuff`
--

DROP TABLE IF EXISTS `CheckListStuff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CheckListStuff` (
  `checkliststuff_id` int(11) NOT NULL AUTO_INCREMENT,
  `stuff_id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `checklist_id` int(11) DEFAULT NULL,
  `checked` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`checkliststuff_id`),
  KEY `stuff_id` (`stuff_id`),
  KEY `checklist_id` (`checklist_id`),
  CONSTRAINT `CheckListStuff_ibfk_1` FOREIGN KEY (`stuff_id`) REFERENCES `Stuff` (`stuff_id`),
  CONSTRAINT `CheckListStuff_ibfk_2` FOREIGN KEY (`checklist_id`) REFERENCES `CheckList` (`checklist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CheckListStuff`
--

LOCK TABLES `CheckListStuff` WRITE;
/*!40000 ALTER TABLE `CheckListStuff` DISABLE KEYS */;
INSERT INTO `CheckListStuff` VALUES 
(1,1,1,1,NULL),(2,2,1,1,NULL),(3,3,1,1,NULL),(4,4,1,1,NULL),(5,6,1,1,NULL),(6,7,1,1,NULL),(7,8,3,1,NULL),(8,16,1,1,NULL),(9,1,1,2,NULL),(10,2,1,2,NULL),(11,4,1,2,NULL),(12,9,1,2,NULL),(13,12,2,2,NULL),(14,14,1,2,NULL),(15,17,1,3,NULL),(16,10,2,3,NULL),(17,13,6,3,NULL),(18,15,3,3,NULL),(19,11,1,4,NULL),(20,14,2,4,NULL),(21,10,1,4,NULL),(22,16,1,4,NULL),(23,9,1,5,NULL),(24,7,1,5,NULL),(25,8,2,5,NULL),(26,2,2,5,NULL),(27,1,1,5,NULL),(28,5,1,5,NULL),(29,12,2,5,NULL),(30,5,1,6,NULL),(31,1,1,6,NULL),(32,9,1,6,NULL),(33,12,2,6,NULL),(34,11,1,6,NULL),(35,8,2,6,NULL),(36,13,2,7,NULL),(37,12,3,7,NULL),(38,10,1,7,NULL),(39,9,1,7,NULL),(40,3,1,8,NULL),(41,2,1,8,NULL),(42,1,1,8,NULL),(43,4,1,8,NULL),(44,11,1,8,NULL),(45,8,1,8,NULL),(46,9,1,8,NULL),(47,5,1,8,NULL),(48,5,1,9,NULL),(49,11,1,9,NULL),(50,10,1,9,NULL),(51,9,1,9,NULL),(52,4,1,9,NULL),(53,5,1,10,NULL),(54,11,1,10,NULL),(55,10,1,10,NULL),(56,9,1,10,NULL),(57,4,2,10,NULL),(58,12,2,11,NULL),(59,13,2,11,NULL),(60,9,1,11,NULL),(61,12,2,12,NULL),(62,17,1,12,NULL),(63,14,2,12,NULL),(64,9,1,12,NULL),(65,5,1,13,NULL),(66,11,1,13,NULL),(67,10,1,13,NULL),(68,9,1,13,NULL),(69,7,1,13,NULL),(70,12,1,13,NULL),(71,5,1,14,NULL),(72,11,1,14,NULL),(73,10,1,14,NULL),(74,9,1,14,NULL),(75,7,1,14,NULL),(76,13,1,14,NULL),(77,16,1,15,NULL),(78,17,1,15,NULL),(79,10,1,15,NULL),(80,9,1,15,NULL),(81,13,3,15,NULL),(82,12,1,15,NULL),(83,15,1,16,NULL),(84,16,1,16,NULL),(85,17,1,16,NULL),(86,10,1,16,NULL),(87,13,2,16,NULL),(88,9,1,16,NULL);
/*!40000 ALTER TABLE `CheckListStuff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Duration`
--

DROP TABLE IF EXISTS `Duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Duration` (
  `duration_id` int(11) NOT NULL AUTO_INCREMENT,
  `duration_value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`duration_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Duration`
--

LOCK TABLES `Duration` WRITE;
/*!40000 ALTER TABLE `Duration` DISABLE KEYS */;
INSERT INTO `Duration` VALUES (1,'10'),(2,'25'),(3,'30'),(4,'50'),(5,'60'),(6,'120'),(7,'360'),(8,'1440');
/*!40000 ALTER TABLE `Duration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stuff`
--

DROP TABLE IF EXISTS `Stuff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stuff` (
  `stuff_id` int(11) NOT NULL AUTO_INCREMENT,
  `stuff_name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`stuff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stuff`
--

LOCK TABLES `Stuff` WRITE;
/*!40000 ALTER TABLE `Stuff` DISABLE KEYS */;
INSERT INTO `Stuff` VALUES (1,'bonnet'),(2,'gants'),(3,'grosses chausettes'),(4,'pull'),(5,'blouson de ski'),(6,'chaussures d\'esclade'),(7,'baudrier'),(8,'cordes'),(9,'chaussures de marche'),(10,'tenue de 
sport'),(11,'sous pull'),(12,'gourdes'),(13,'bouteille d\'eau'),(14,'couteau'),(15,'scie'),(16,'pistolet'),(17,'carabine');
/*!40000 ALTER TABLE `Stuff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_firstname` varchar(25) DEFAULT NULL,
  `user_lastname` varchar(25) DEFAULT NULL,
  `user_mail` varchar(50) DEFAULT NULL,
  `user_password` varchar(50) DEFAULT NULL,
  `user_login` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'nicolas','gervasi','angeltiger156@gmail.com','gervasin','gervasin');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Weather`
--

DROP TABLE IF EXISTS `Weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Weather` (
  `weather_id` int(11) NOT NULL AUTO_INCREMENT,
  `weather_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`weather_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Weather`
--

LOCK TABLES `Weather` WRITE;
/*!40000 ALTER TABLE `Weather` DISABLE KEYS */;
INSERT INTO `Weather` VALUES (1,'Nuage'),(2,'Soleil'),(3,'Pluie'),(4,'Brume');
/*!40000 ALTER TABLE `Weather` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;"


# Configure the website
cd /tmp
git clone https://github.com/linouxis9/nuitinfo

cp -r nuitinfo /var/www/html/
cd /var/www/html
chown -R www-data:www-data *


sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
a2enmod rewrite
service apache2 restart
