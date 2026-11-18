-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: Hospitals
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.22.04.5

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
-- Table structure for table `Hospitals`
--

DROP TABLE IF EXISTS `Hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Hospitals` (
  `Name` varchar(150) NOT NULL,
  `Address` varchar(150) NOT NULL,
  `Size` int unsigned NOT NULL,
  `Type` varchar(150) NOT NULL,
  `Accreditation` tinyint(1) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hospitals`
--

LOCK TABLES `Hospitals` WRITE;
/*!40000 ALTER TABLE `Hospitals` DISABLE KEYS */;
INSERT INTO `Hospitals` VALUES ('Ashford Children Hospital','44 Ash Street, Chester, CH1 5GH',145,'Children\'s',1),('Bluebell Children Hospital','4 Bluebell Close, Exeter, EX3 3UV',95,'Children\'s',0),('Brookside General Hospital','42 Brook Avenue, Derby, DE1 3LM',350,'General',0),('Cedar Grove Psychiatric Hospital','11 Cedar Lane, Liverpool, L1 8EF',250,'Psychiatric',1),('Central City Teaching Hospital','45 High Street, Birmingham, B1 7LM',850,'Teaching',1),('Crescent Mental Health Hospital','12 Crescent Road, Bradford, BD1 5YZ',210,'Psychiatric',1),('Eastgate Specialist Hospital','38 East Street, Exeter, EX2 8WX',170,'Specialist',1),('Elmwood Rehabilitation Hospital','16 Elm Street, Nottingham, NG1 4WX',140,'Specialist',0),('Fairview Psychiatric Hospital','20 Fair Lane, Worcester, WR1 6JK',230,'Psychiatric',1),('Grand Central Hospital','88 Central Road, London, EC1 7LM',900,'Teaching',1),('Greenfield General Hospital','19 Green Road, Manchester, M1 6JK',380,'General',1),('Harbourview General Hospital','21 Harbour Road, Plymouth, PL1 9QR',320,'General',1),('Hawthorn General Hospital','22 Hawthorn Road, Ipswich, IP1 2ST',360,'General',1),('Highland Specialist Hospital','26 Highland Street, Inverness, IV1 7CD',155,'Specialist',0),('Hillcrest Specialist Hospital','18 Hill Road, Brighton, BN1 2JK',130,'Specialist',1),('Kingsbridge General Hospital','55 Kings Road, London, SW1 3UV',600,'General',1),('Lakeside General Hospital','24 Lake Drive, Coventry, CV1 6ST',290,'General',1),('Little Oaks Children Hospital','9 Oak Close, Oxford, OX1 6AB',160,'Children\'s',1),('Maple Leaf Specialist Hospital','31 Maple Street, Milton Keynes, MK1 9QR',125,'Specialist',1),('Meadowlands Psychiatric Hospital','14 Meadow Lane, York, YO1 4EF',220,'Psychiatric',0),('Millbrook General Hospital','49 Mill Road, Peterborough, PE1 8EF',330,'General',1),('Mountain View General Hospital','29 Mountain Road, Lancaster, LA1 4EF',310,'General',1),('Northgate Teaching Hospital','25 Northgate Street, Leeds, LS1 2AB',720,'Teaching',1),('Oakwood Mental Health Hospital','7 Oak Avenue, Sheffield, S1 8NP',200,'Psychiatric',0),('Parkview Teaching Hospital','17 Park Avenue, Edinburgh, EH1 2AB',620,'Teaching',1),('Pinewood Children Hospital','5 Pine Road, Reading, RG1 5QR',110,'Children\'s',1),('Redwood Teaching Hospital','63 Redwood Avenue, Aberdeen, AB1 4WX',580,'Teaching',1),('Riverside General Hospital','12 River Road, Exeter, EX1 1AA',450,'General',1),('Rosewood Psychiatric Hospital','13 Rose Lane, Leicester, LE1 7UV',190,'Psychiatric',0),('Royal Meadow Hospital','30 Meadow Street, Cambridge, CB1 9GH',680,'Teaching',1),('Seaview General Hospital','15 Seaside Road, Torquay, TQ1 8NP',275,'General',0),('Silverstone General Hospital','51 Silver Road, Glasgow, G1 9YZ',480,'General',1),('Southside General Hospital','72 South Road, Southampton, SO1 7CD',400,'General',0),('Springfield General Hospital','37 Spring Road, Chelmsford, CM1 6AB',420,'General',1),('St Andrews Specialist Hospital','33 Church Street, Norwich, NR1 5GH',150,'Specialist',1),('Sunrise Maternity Hospital','10 Sunrise Drive, Cardiff, CF1 2ST',120,'Specialist',1),('Valley View Teaching Hospital','28 Valley Road, Bath, BA1 5YZ',510,'Teaching',1),('Westbrook Children Hospital','8 Westbrook Lane, Bristol, BS1 3CD',180,'Children\'s',1),('Westfield Teaching Hospital','66 West Street, Newcastle, NE1 4NP',750,'Teaching',1),('Willowbrook Maternity Hospital','6 Willow Lane, Swansea, SA1 3CD',100,'Specialist',0);
/*!40000 ALTER TABLE `Hospitals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-18  9:56:52
