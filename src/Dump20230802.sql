-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: prisma_migrate_shadow_db_ec4a6b0b-e8a8-48bf-8308-184dbc8fc27e
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `Answer`
--

DROP TABLE IF EXISTS `Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answer` (
  `driveId` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `questionId` int NOT NULL,
  `candidateId` int NOT NULL,
  `answer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Answer_driveId_key` (`driveId`),
  KEY `Answer_questionId_fkey` (`questionId`),
  CONSTRAINT `Answer_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answer`
--

LOCK TABLES `Answer` WRITE;
/*!40000 ALTER TABLE `Answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mcqs`
--

DROP TABLE IF EXISTS `Mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mcqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `difficultLevel` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `optionType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `option1` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageLink` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snippet` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mcqs`
--

LOCK TABLES `Mcqs` WRITE;
/*!40000 ALTER TABLE `Mcqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rounds`
--

DROP TABLE IF EXISTS `Rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rounds` (
  `driveId` int NOT NULL,
  PRIMARY KEY (`driveId`),
  CONSTRAINT `Rounds_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rounds`
--

LOCK TABLES `Rounds` WRITE;
/*!40000 ALTER TABLE `Rounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `id` int NOT NULL,
  `campusYear` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details`
--

DROP TABLE IF EXISTS `candidate_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `candidateName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobileNumber` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registerNumber` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `candidate_details_driveId_fkey` (`driveId`),
  CONSTRAINT `candidate_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details`
--

LOCK TABLES `candidate_details` WRITE;
/*!40000 ALTER TABLE `candidate_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_details`
--

DROP TABLE IF EXISTS `college_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college_details` (
  `driveId` int NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `collegeId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`collegeId`),
  UNIQUE KEY `college_details_driveId_key` (`driveId`),
  CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_details`
--

LOCK TABLES `college_details` WRITE;
/*!40000 ALTER TABLE `college_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `college_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_major`
--

DROP TABLE IF EXISTS `department_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_major` (
  `departmentMajorId` int NOT NULL AUTO_INCREMENT,
  `departmentMajor` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`departmentMajorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_major`
--

LOCK TABLES `department_major` WRITE;
/*!40000 ALTER TABLE `department_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `departments` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departmentId` int NOT NULL AUTO_INCREMENT,
  `departmentMajorId` int NOT NULL,
  PRIMARY KEY (`departmentId`),
  UNIQUE KEY `departments_departmentId_key` (`departmentId`),
  KEY `departments_departmentMajorId_fkey` (`departmentMajorId`),
  CONSTRAINT `departments_departmentMajorId_fkey` FOREIGN KEY (`departmentMajorId`) REFERENCES `department_major` (`departmentMajorId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drive_details`
--

DROP TABLE IF EXISTS `drive_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drive_details` (
  `campusId` int NOT NULL,
  `driveId` int NOT NULL AUTO_INCREMENT,
  `driveDate` datetime(3) NOT NULL,
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `drive_details_driveId_key` (`driveId`),
  KEY `drive_details_campusId_fkey` (`campusId`),
  CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drive_details`
--

LOCK TABLES `drive_details` WRITE;
/*!40000 ALTER TABLE `drive_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `drive_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructions`
--

DROP TABLE IF EXISTS `instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructions` (
  `instruction_id` int NOT NULL AUTO_INCREMENT,
  `instruction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`instruction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructions`
--

LOCK TABLES `instructions` WRITE;
/*!40000 ALTER TABLE `instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment_team`
--

DROP TABLE IF EXISTS `recruitment_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment_team` (
  `driveId` int NOT NULL,
  `teamMembers` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `recruitment_team_driveId_key` (`driveId`),
  CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment_team`
--

LOCK TABLES `recruitment_team` WRITE;
/*!40000 ALTER TABLE `recruitment_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `recruitment_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_privilege`
--

DROP TABLE IF EXISTS `round_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_privilege` (
  `driveId` int NOT NULL,
  `IsSkipped` tinyint(1) DEFAULT NULL,
  `IsPrev` tinyint(1) DEFAULT NULL,
  `skipQuestions` tinyint(1) DEFAULT NULL,
  `SubmitOnAnswered` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `round_privilege_driveId_key` (`driveId`),
  CONSTRAINT `round_privilege_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_privilege`
--

LOCK TABLES `round_privilege` WRITE;
/*!40000 ALTER TABLE `round_privilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `round_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_departments`
--

DROP TABLE IF EXISTS `sub_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_departments` (
  `departmentId` int NOT NULL,
  `subDepartment` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subDepartmentId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`subDepartmentId`),
  UNIQUE KEY `sub_departments_subDepartmentId_key` (`subDepartmentId`),
  KEY `sub_departments_departmentId_fkey` (`departmentId`),
  CONSTRAINT `sub_departments_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `departments` (`departmentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_departments`
--

LOCK TABLES `sub_departments` WRITE;
/*!40000 ALTER TABLE `sub_departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_departments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-02 17:21:12
-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: prisma_migrate_shadow_db_f27b5331-bfde-4855-b1be-e8515863331c
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `Answer`
--

DROP TABLE IF EXISTS `Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answer` (
  `driveId` int NOT NULL,
  `questionId` int NOT NULL,
  `candidateId` int NOT NULL,
  `answer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answerId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`answerId`),
  UNIQUE KEY `Answer_answerId_key` (`answerId`),
  KEY `Answer_questionId_fkey` (`questionId`),
  CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answer`
--

LOCK TABLES `Answer` WRITE;
/*!40000 ALTER TABLE `Answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mcqs`
--

DROP TABLE IF EXISTS `Mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mcqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `difficultLevel` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `optionType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `option1` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageLink` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snippet` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mcqs`
--

LOCK TABLES `Mcqs` WRITE;
/*!40000 ALTER TABLE `Mcqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rounds`
--

DROP TABLE IF EXISTS `Rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rounds` (
  `driveId` int NOT NULL,
  PRIMARY KEY (`driveId`),
  CONSTRAINT `Rounds_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rounds`
--

LOCK TABLES `Rounds` WRITE;
/*!40000 ALTER TABLE `Rounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `id` int NOT NULL,
  `campusYear` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details`
--

DROP TABLE IF EXISTS `candidate_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `candidateName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobileNumber` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registerNumber` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `candidate_details_driveId_fkey` (`driveId`),
  CONSTRAINT `candidate_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details`
--

LOCK TABLES `candidate_details` WRITE;
/*!40000 ALTER TABLE `candidate_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details_college`
--

DROP TABLE IF EXISTS `candidate_details_college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details_college` (
  `studentId` int NOT NULL AUTO_INCREMENT,
  `registerNumber` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateOfBirth` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenthPercentage` int NOT NULL,
  `tenthYOP` int NOT NULL,
  `twelthPercentage` int DEFAULT NULL,
  `twelthYOP` int DEFAULT NULL,
  `diplomaPercentage` int DEFAULT NULL,
  `diplomaYOP` int DEFAULT NULL,
  `UG_CGPA` int DEFAULT NULL,
  `UG_YOP` int DEFAULT NULL,
  `PG_CGPA` int DEFAULT NULL,
  `PG_YOP` int DEFAULT NULL,
  `arrearStatus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrearCount` int DEFAULT NULL,
  `mobileNumber` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driveId` int NOT NULL,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `candidate_details_college_studentId_key` (`studentId`),
  KEY `candidate_details_college_driveId_fkey` (`driveId`),
  CONSTRAINT `candidate_details_college_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details_college`
--

LOCK TABLES `candidate_details_college` WRITE;
/*!40000 ALTER TABLE `candidate_details_college` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_details_college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_details`
--

DROP TABLE IF EXISTS `college_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college_details` (
  `driveId` int NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `collegeId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`collegeId`),
  UNIQUE KEY `college_details_driveId_key` (`driveId`),
  CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_details`
--

LOCK TABLES `college_details` WRITE;
/*!40000 ALTER TABLE `college_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `college_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_major`
--

DROP TABLE IF EXISTS `department_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_major` (
  `departmentMajorId` int NOT NULL AUTO_INCREMENT,
  `departmentMajor` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`departmentMajorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_major`
--

LOCK TABLES `department_major` WRITE;
/*!40000 ALTER TABLE `department_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `departments` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departmentId` int NOT NULL AUTO_INCREMENT,
  `departmentMajorId` int NOT NULL,
  PRIMARY KEY (`departmentId`),
  UNIQUE KEY `departments_departmentId_key` (`departmentId`),
  KEY `departments_departmentMajorId_fkey` (`departmentMajorId`),
  CONSTRAINT `departments_departmentMajorId_fkey` FOREIGN KEY (`departmentMajorId`) REFERENCES `department_major` (`departmentMajorId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drive_details`
--

DROP TABLE IF EXISTS `drive_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drive_details` (
  `campusId` int NOT NULL,
  `driveId` int NOT NULL AUTO_INCREMENT,
  `driveDate` datetime(3) NOT NULL,
  `answerAnswerId` int DEFAULT NULL,
  `driveStatus` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`driveId`),
  KEY `drive_details_campusId_fkey` (`campusId`),
  KEY `drive_details_answerAnswerId_fkey` (`answerAnswerId`),
  CONSTRAINT `drive_details_answerAnswerId_fkey` FOREIGN KEY (`answerAnswerId`) REFERENCES `Answer` (`answerId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drive_details`
--

LOCK TABLES `drive_details` WRITE;
/*!40000 ALTER TABLE `drive_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `drive_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructions`
--

DROP TABLE IF EXISTS `instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructions` (
  `instruction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructionId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`instructionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructions`
--

LOCK TABLES `instructions` WRITE;
/*!40000 ALTER TABLE `instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment_team`
--

DROP TABLE IF EXISTS `recruitment_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment_team` (
  `driveId` int NOT NULL,
  `teamMembers` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `recruitment_team_driveId_key` (`driveId`),
  CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment_team`
--

LOCK TABLES `recruitment_team` WRITE;
/*!40000 ALTER TABLE `recruitment_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `recruitment_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_privileges`
--

DROP TABLE IF EXISTS `round_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_privileges` (
  `driveId` int NOT NULL,
  `IsSkipped` tinyint(1) DEFAULT NULL,
  `IsPrev` tinyint(1) DEFAULT NULL,
  `skipQuestions` tinyint(1) DEFAULT NULL,
  `SubmitOnAnswered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`driveId`),
  CONSTRAINT `round_privileges_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_privileges`
--

LOCK TABLES `round_privileges` WRITE;
/*!40000 ALTER TABLE `round_privileges` DISABLE KEYS */;
/*!40000 ALTER TABLE `round_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_departments`
--

DROP TABLE IF EXISTS `sub_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_departments` (
  `departmentId` int NOT NULL,
  `subDepartment` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subDepartmentId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`subDepartmentId`),
  UNIQUE KEY `sub_departments_subDepartmentId_key` (`subDepartmentId`),
  KEY `sub_departments_departmentId_fkey` (`departmentId`),
  CONSTRAINT `sub_departments_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `departments` (`departmentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_departments`
--

LOCK TABLES `sub_departments` WRITE;
/*!40000 ALTER TABLE `sub_departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_departments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-02 17:21:12
-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: prisma_migrate_shadow_db_9da2283e-58a8-4ffd-b4fe-ccaa21891a58
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `Answer`
--

DROP TABLE IF EXISTS `Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answer` (
  `driveId` int NOT NULL,
  `questionId` int NOT NULL,
  `candidateId` int NOT NULL,
  `answer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answerId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`answerId`),
  UNIQUE KEY `Answer_answerId_key` (`answerId`),
  KEY `Answer_questionId_fkey` (`questionId`),
  CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answer`
--

LOCK TABLES `Answer` WRITE;
/*!40000 ALTER TABLE `Answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mcqs`
--

DROP TABLE IF EXISTS `Mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mcqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `difficultLevel` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `optionType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `option1` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageLink` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snippet` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mcqs`
--

LOCK TABLES `Mcqs` WRITE;
/*!40000 ALTER TABLE `Mcqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rounds`
--

DROP TABLE IF EXISTS `Rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rounds` (
  `driveId` int NOT NULL,
  PRIMARY KEY (`driveId`),
  CONSTRAINT `Rounds_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rounds`
--

LOCK TABLES `Rounds` WRITE;
/*!40000 ALTER TABLE `Rounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `id` int NOT NULL,
  `campusYear` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details`
--

DROP TABLE IF EXISTS `candidate_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `candidateName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobileNumber` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registerNumber` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `candidate_details_driveId_fkey` (`driveId`),
  CONSTRAINT `candidate_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details`
--

LOCK TABLES `candidate_details` WRITE;
/*!40000 ALTER TABLE `candidate_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details_college`
--

DROP TABLE IF EXISTS `candidate_details_college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details_college` (
  `studentId` int NOT NULL AUTO_INCREMENT,
  `registerNumber` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateOfBirth` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenthPercentage` int NOT NULL,
  `tenthYOP` int NOT NULL,
  `twelthPercentage` int DEFAULT NULL,
  `twelthYOP` int DEFAULT NULL,
  `diplomaPercentage` int DEFAULT NULL,
  `diplomaYOP` int DEFAULT NULL,
  `UG_CGPA` int DEFAULT NULL,
  `UG_YOP` int DEFAULT NULL,
  `PG_CGPA` int DEFAULT NULL,
  `PG_YOP` int DEFAULT NULL,
  `arrearStatus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrearCount` int DEFAULT NULL,
  `mobileNumber` int DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driveId` int NOT NULL,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `candidate_details_college_studentId_key` (`studentId`),
  KEY `candidate_details_college_driveId_fkey` (`driveId`),
  CONSTRAINT `candidate_details_college_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details_college`
--

LOCK TABLES `candidate_details_college` WRITE;
/*!40000 ALTER TABLE `candidate_details_college` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_details_college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_details`
--

DROP TABLE IF EXISTS `college_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college_details` (
  `driveId` int NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `collegeId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`collegeId`),
  UNIQUE KEY `college_details_driveId_key` (`driveId`),
  CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_details`
--

LOCK TABLES `college_details` WRITE;
/*!40000 ALTER TABLE `college_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `college_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_major`
--

DROP TABLE IF EXISTS `department_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_major` (
  `departmentMajorId` int NOT NULL AUTO_INCREMENT,
  `departmentMajor` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`departmentMajorId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_major`
--

LOCK TABLES `department_major` WRITE;
/*!40000 ALTER TABLE `department_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `departments` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departmentId` int NOT NULL AUTO_INCREMENT,
  `departmentMajorId` int NOT NULL,
  PRIMARY KEY (`departmentId`),
  UNIQUE KEY `departments_departmentId_key` (`departmentId`),
  KEY `departments_departmentMajorId_fkey` (`departmentMajorId`),
  CONSTRAINT `departments_departmentMajorId_fkey` FOREIGN KEY (`departmentMajorId`) REFERENCES `department_major` (`departmentMajorId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drive_details`
--

DROP TABLE IF EXISTS `drive_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drive_details` (
  `campusId` int NOT NULL,
  `driveId` int NOT NULL AUTO_INCREMENT,
  `driveDate` datetime(3) NOT NULL,
  `answerAnswerId` int DEFAULT NULL,
  `driveStatus` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`driveId`),
  KEY `drive_details_campusId_fkey` (`campusId`),
  KEY `drive_details_answerAnswerId_fkey` (`answerAnswerId`),
  CONSTRAINT `drive_details_answerAnswerId_fkey` FOREIGN KEY (`answerAnswerId`) REFERENCES `Answer` (`answerId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drive_details`
--

LOCK TABLES `drive_details` WRITE;
/*!40000 ALTER TABLE `drive_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `drive_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructions`
--

DROP TABLE IF EXISTS `instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructions` (
  `instruction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructionId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`instructionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructions`
--

LOCK TABLES `instructions` WRITE;
/*!40000 ALTER TABLE `instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment_team`
--

DROP TABLE IF EXISTS `recruitment_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment_team` (
  `driveId` int NOT NULL,
  `teamMembers` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `recruitment_team_driveId_key` (`driveId`),
  CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment_team`
--

LOCK TABLES `recruitment_team` WRITE;
/*!40000 ALTER TABLE `recruitment_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `recruitment_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_privilege`
--

DROP TABLE IF EXISTS `round_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_privilege` (
  `driveId` int NOT NULL,
  `IsSkipped` tinyint(1) DEFAULT NULL,
  `IsPrev` tinyint(1) DEFAULT NULL,
  `skipQuestions` tinyint(1) DEFAULT NULL,
  `SubmitOnAnswered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `round_privilege_driveId_key` (`driveId`),
  CONSTRAINT `round_privilege_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_privilege`
--

LOCK TABLES `round_privilege` WRITE;
/*!40000 ALTER TABLE `round_privilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `round_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_departments`
--

DROP TABLE IF EXISTS `sub_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_departments` (
  `departmentId` int NOT NULL,
  `subDepartment` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subDepartmentId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`subDepartmentId`),
  UNIQUE KEY `sub_departments_subDepartmentId_key` (`subDepartmentId`),
  KEY `sub_departments_departmentId_fkey` (`departmentId`),
  CONSTRAINT `sub_departments_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `departments` (`departmentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_departments`
--

LOCK TABLES `sub_departments` WRITE;
/*!40000 ALTER TABLE `sub_departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_departments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-02 17:21:12
-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: prisma_migrate_shadow_db_67cc3e08-1b70-4b58-a31d-e93297ef3cb9
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `Answer`
--

DROP TABLE IF EXISTS `Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answer` (
  `driveId` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `questionId` int NOT NULL,
  `candidateId` int NOT NULL,
  `answer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Answer_driveId_key` (`driveId`),
  KEY `Answer_questionId_fkey` (`questionId`),
  CONSTRAINT `Answer_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answer`
--

LOCK TABLES `Answer` WRITE;
/*!40000 ALTER TABLE `Answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Instructions`
--

DROP TABLE IF EXISTS `Instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Instructions` (
  `instruction_id` int NOT NULL AUTO_INCREMENT,
  `instruction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`instruction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Instructions`
--

LOCK TABLES `Instructions` WRITE;
/*!40000 ALTER TABLE `Instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mcqs`
--

DROP TABLE IF EXISTS `Mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mcqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `difficultLevel` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `optionType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `option1` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageLink` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snippet` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mcqs`
--

LOCK TABLES `Mcqs` WRITE;
/*!40000 ALTER TABLE `Mcqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rounds`
--

DROP TABLE IF EXISTS `Rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rounds` (
  `driveId` int NOT NULL,
  PRIMARY KEY (`driveId`),
  CONSTRAINT `Rounds_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rounds`
--

LOCK TABLES `Rounds` WRITE;
/*!40000 ALTER TABLE `Rounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `id` int NOT NULL,
  `campusYear` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details`
--

DROP TABLE IF EXISTS `candidate_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `candidateName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobileNumber` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registerNumber` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `candidate_details_driveId_fkey` (`driveId`),
  CONSTRAINT `candidate_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details`
--

LOCK TABLES `candidate_details` WRITE;
/*!40000 ALTER TABLE `candidate_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_details`
--

DROP TABLE IF EXISTS `college_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college_details` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `college_details_driveId_fkey` (`driveId`),
  CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_details`
--

LOCK TABLES `college_details` WRITE;
/*!40000 ALTER TABLE `college_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `college_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drive_details`
--

DROP TABLE IF EXISTS `drive_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drive_details` (
  `campusId` int NOT NULL,
  `driveId` int NOT NULL AUTO_INCREMENT,
  `driveDate` datetime(3) NOT NULL,
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `drive_details_driveId_key` (`driveId`),
  KEY `drive_details_campusId_fkey` (`campusId`),
  CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drive_details`
--

LOCK TABLES `drive_details` WRITE;
/*!40000 ALTER TABLE `drive_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `drive_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment_team`
--

DROP TABLE IF EXISTS `recruitment_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment_team` (
  `driveId` int NOT NULL,
  `teamMembers` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `recruitment_team_driveId_key` (`driveId`),
  CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment_team`
--

LOCK TABLES `recruitment_team` WRITE;
/*!40000 ALTER TABLE `recruitment_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `recruitment_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_privilege`
--

DROP TABLE IF EXISTS `round_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_privilege` (
  `driveId` int NOT NULL,
  `IsSkipped` tinyint(1) DEFAULT NULL,
  `IsPrev` tinyint(1) DEFAULT NULL,
  `skipQuestions` tinyint(1) DEFAULT NULL,
  `SubmitOnAnswered` tinyint(1) DEFAULT NULL,
  UNIQUE KEY `round_privilege_driveId_key` (`driveId`),
  CONSTRAINT `round_privilege_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_privilege`
--

LOCK TABLES `round_privilege` WRITE;
/*!40000 ALTER TABLE `round_privilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `round_privilege` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-02 17:21:12
-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: prisma_migrate_shadow_db_76c93351-ba3b-4548-8b3b-93739b98d00c
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `Answer`
--

DROP TABLE IF EXISTS `Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answer` (
  `driveId` int NOT NULL,
  `questionId` int NOT NULL,
  `candidateId` int NOT NULL,
  `answer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answerId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`answerId`),
  UNIQUE KEY `Answer_answerId_key` (`answerId`),
  KEY `Answer_questionId_fkey` (`questionId`),
  KEY `Answer_driveId_fkey` (`driveId`),
  CONSTRAINT `Answer_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answer`
--

LOCK TABLES `Answer` WRITE;
/*!40000 ALTER TABLE `Answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mcqs`
--

DROP TABLE IF EXISTS `Mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mcqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `difficultLevel` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `optionType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `option1` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageLink` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snippet` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mcqs`
--

LOCK TABLES `Mcqs` WRITE;
/*!40000 ALTER TABLE `Mcqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `id` int NOT NULL,
  `campusYear` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details_college`
--

DROP TABLE IF EXISTS `candidate_details_college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details_college` (
  `studentId` int NOT NULL AUTO_INCREMENT,
  `registerNumber` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateOfBirth` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenthPercentage` int NOT NULL,
  `tenthYOP` int NOT NULL,
  `twelthPercentage` int DEFAULT NULL,
  `twelthYOP` int DEFAULT NULL,
  `diplomaPercentage` int DEFAULT NULL,
  `diplomaYOP` int DEFAULT NULL,
  `UG_CGPA` int DEFAULT NULL,
  `UG_YOP` int DEFAULT NULL,
  `PG_CGPA` int DEFAULT NULL,
  `PG_YOP` int DEFAULT NULL,
  `arrearStatus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrearCount` int DEFAULT NULL,
  `mobileNumber` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driveId` int NOT NULL,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `candidate_details_college_studentId_key` (`studentId`),
  KEY `candidate_details_college_driveId_fkey` (`driveId`),
  CONSTRAINT `candidate_details_college_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details_college`
--

LOCK TABLES `candidate_details_college` WRITE;
/*!40000 ALTER TABLE `candidate_details_college` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_details_college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_tracking`
--

DROP TABLE IF EXISTS `candidate_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_tracking` (
  `driveId` int NOT NULL,
  `studentId` int NOT NULL,
  `startTime` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loginAttempts` int DEFAULT '0',
  `roundOneDurationTaken` int DEFAULT '0',
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `candidate_tracking_studentId_key` (`studentId`),
  CONSTRAINT `candidate_tracking_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `candidate_tracking_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college` (`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_tracking`
--

LOCK TABLES `candidate_tracking` WRITE;
/*!40000 ALTER TABLE `candidate_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_details`
--

DROP TABLE IF EXISTS `college_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college_details` (
  `driveId` int NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `collegeId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`collegeId`),
  UNIQUE KEY `college_details_driveId_key` (`driveId`),
  CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_details`
--

LOCK TABLES `college_details` WRITE;
/*!40000 ALTER TABLE `college_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `college_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drive_details`
--

DROP TABLE IF EXISTS `drive_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drive_details` (
  `campusId` int NOT NULL,
  `driveId` int NOT NULL AUTO_INCREMENT,
  `driveDate` datetime(3) NOT NULL,
  `answerAnswerId` int DEFAULT NULL,
  `driveStatus` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`driveId`),
  KEY `drive_details_campusId_fkey` (`campusId`),
  CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drive_details`
--

LOCK TABLES `drive_details` WRITE;
/*!40000 ALTER TABLE `drive_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `drive_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructions`
--

DROP TABLE IF EXISTS `instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructions` (
  `instruction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructionId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`instructionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructions`
--

LOCK TABLES `instructions` WRITE;
/*!40000 ALTER TABLE `instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionSet`
--

DROP TABLE IF EXISTS `questionSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionSet` (
  `driveId` int NOT NULL,
  `questionId` int NOT NULL,
  `roundName` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`driveId`),
  KEY `questionSet_questionId_fkey` (`questionId`),
  CONSTRAINT `questionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `questionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionSet`
--

LOCK TABLES `questionSet` WRITE;
/*!40000 ALTER TABLE `questionSet` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionSet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment_team`
--

DROP TABLE IF EXISTS `recruitment_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment_team` (
  `driveId` int NOT NULL,
  `teamMembers` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `recruitment_team_driveId_key` (`driveId`),
  CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment_team`
--

LOCK TABLES `recruitment_team` WRITE;
/*!40000 ALTER TABLE `recruitment_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `recruitment_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_details`
--

DROP TABLE IF EXISTS `round_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_details` (
  `driveId` int NOT NULL,
  `round1` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `round1Duration` int NOT NULL,
  `round1TotalQuestions` int NOT NULL,
  `round2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round2Duration` int DEFAULT NULL,
  `round2TotalQuestions` int DEFAULT NULL,
  `round3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round3Duration` int DEFAULT NULL,
  `round3TotalQuestions` int DEFAULT NULL,
  `round4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round4Duration` int DEFAULT NULL,
  `round5` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round5Duration` int DEFAULT NULL,
  `round1Difficulty` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round1Topics` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `round_details_driveId_key` (`driveId`),
  CONSTRAINT `round_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_details`
--

LOCK TABLES `round_details` WRITE;
/*!40000 ALTER TABLE `round_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `round_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_privileges`
--

DROP TABLE IF EXISTS `round_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_privileges` (
  `driveId` int NOT NULL,
  `IsSkipped` tinyint(1) DEFAULT NULL,
  `IsPrev` tinyint(1) DEFAULT NULL,
  `SubmitOnAnswered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `round_privileges_driveId_key` (`driveId`),
  CONSTRAINT `round_privileges_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_privileges`
--

LOCK TABLES `round_privileges` WRITE;
/*!40000 ALTER TABLE `round_privileges` DISABLE KEYS */;
/*!40000 ALTER TABLE `round_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentQuestionSet`
--

DROP TABLE IF EXISTS `studentQuestionSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentQuestionSet` (
  `driveId` int NOT NULL,
  `studentId` int NOT NULL,
  `questionId` int NOT NULL,
  PRIMARY KEY (`driveId`),
  KEY `studentQuestionSet_questionId_fkey` (`questionId`),
  KEY `studentQuestionSet_studentId_fkey` (`studentId`),
  CONSTRAINT `studentQuestionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `studentQuestionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `studentQuestionSet_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college` (`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentQuestionSet`
--

LOCK TABLES `studentQuestionSet` WRITE;
/*!40000 ALTER TABLE `studentQuestionSet` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentQuestionSet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-02 17:21:12
-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: prisma_migrate_shadow_db_b21ccdd5-a24f-4897-b7e3-6893537a1f8d
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `Answer`
--

DROP TABLE IF EXISTS `Answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answer` (
  `driveId` int NOT NULL,
  `questionId` int NOT NULL,
  `candidateId` int NOT NULL,
  `answer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answerId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`answerId`),
  UNIQUE KEY `Answer_answerId_key` (`answerId`),
  KEY `Answer_questionId_fkey` (`questionId`),
  KEY `Answer_driveId_fkey` (`driveId`),
  CONSTRAINT `Answer_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answer`
--

LOCK TABLES `Answer` WRITE;
/*!40000 ALTER TABLE `Answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mcqs`
--

DROP TABLE IF EXISTS `Mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mcqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `difficultLevel` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `optionType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `option1` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageLink` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snippet` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mcqs`
--

LOCK TABLES `Mcqs` WRITE;
/*!40000 ALTER TABLE `Mcqs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campus`
--

DROP TABLE IF EXISTS `campus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus` (
  `id` int NOT NULL,
  `campusYear` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus`
--

LOCK TABLES `campus` WRITE;
/*!40000 ALTER TABLE `campus` DISABLE KEYS */;
/*!40000 ALTER TABLE `campus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidateQuestionSet`
--

DROP TABLE IF EXISTS `candidateQuestionSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidateQuestionSet` (
  `driveId` int NOT NULL,
  `studentId` int NOT NULL,
  `questionId` int NOT NULL,
  PRIMARY KEY (`driveId`,`studentId`,`questionId`),
  KEY `candidateQuestionSet_questionId_fkey` (`questionId`),
  KEY `candidateQuestionSet_studentId_fkey` (`studentId`),
  CONSTRAINT `candidateQuestionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `candidateQuestionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `candidateQuestionSet_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college` (`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidateQuestionSet`
--

LOCK TABLES `candidateQuestionSet` WRITE;
/*!40000 ALTER TABLE `candidateQuestionSet` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidateQuestionSet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details_college`
--

DROP TABLE IF EXISTS `candidate_details_college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details_college` (
  `studentId` int NOT NULL AUTO_INCREMENT,
  `registerNumber` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateOfBirth` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenthPercentage` int NOT NULL,
  `tenthYOP` int NOT NULL,
  `twelthPercentage` int DEFAULT NULL,
  `twelthYOP` int DEFAULT NULL,
  `diplomaPercentage` int DEFAULT NULL,
  `diplomaYOP` int DEFAULT NULL,
  `UG_CGPA` int DEFAULT NULL,
  `UG_YOP` int DEFAULT NULL,
  `PG_CGPA` int DEFAULT NULL,
  `PG_YOP` int DEFAULT NULL,
  `arrearStatus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrearCount` int DEFAULT NULL,
  `mobileNumber` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driveId` int NOT NULL,
  PRIMARY KEY (`driveId`,`studentId`),
  UNIQUE KEY `candidate_details_college_studentId_key` (`studentId`),
  CONSTRAINT `candidate_details_college_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details_college`
--

LOCK TABLES `candidate_details_college` WRITE;
/*!40000 ALTER TABLE `candidate_details_college` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_details_college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_tracking`
--

DROP TABLE IF EXISTS `candidate_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_tracking` (
  `driveId` int NOT NULL,
  `studentId` int NOT NULL,
  `startTime` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loginAttempts` int DEFAULT '0',
  `roundOneDurationTaken` int DEFAULT '0',
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `candidate_tracking_studentId_key` (`studentId`),
  CONSTRAINT `candidate_tracking_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `candidate_tracking_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college` (`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_tracking`
--

LOCK TABLES `candidate_tracking` WRITE;
/*!40000 ALTER TABLE `candidate_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_details`
--

DROP TABLE IF EXISTS `college_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college_details` (
  `driveId` int NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `collegeId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`collegeId`),
  UNIQUE KEY `college_details_driveId_key` (`driveId`),
  CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_details`
--

LOCK TABLES `college_details` WRITE;
/*!40000 ALTER TABLE `college_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `college_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drive_details`
--

DROP TABLE IF EXISTS `drive_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drive_details` (
  `campusId` int NOT NULL,
  `driveId` int NOT NULL AUTO_INCREMENT,
  `driveDate` datetime(3) NOT NULL,
  `answerAnswerId` int DEFAULT NULL,
  `driveStatus` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`driveId`),
  KEY `drive_details_campusId_fkey` (`campusId`),
  CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drive_details`
--

LOCK TABLES `drive_details` WRITE;
/*!40000 ALTER TABLE `drive_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `drive_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructions`
--

DROP TABLE IF EXISTS `instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructions` (
  `instruction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructionId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`instructionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructions`
--

LOCK TABLES `instructions` WRITE;
/*!40000 ALTER TABLE `instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionSet`
--

DROP TABLE IF EXISTS `questionSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionSet` (
  `driveId` int NOT NULL,
  `questionId` int NOT NULL,
  `roundName` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`driveId`,`questionId`),
  UNIQUE KEY `questionSet_questionId_key` (`questionId`),
  CONSTRAINT `questionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `questionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionSet`
--

LOCK TABLES `questionSet` WRITE;
/*!40000 ALTER TABLE `questionSet` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionSet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment_team`
--

DROP TABLE IF EXISTS `recruitment_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment_team` (
  `driveId` int NOT NULL,
  `teamMembers` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `recruitment_team_driveId_key` (`driveId`),
  CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment_team`
--

LOCK TABLES `recruitment_team` WRITE;
/*!40000 ALTER TABLE `recruitment_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `recruitment_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_details`
--

DROP TABLE IF EXISTS `round_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_details` (
  `driveId` int NOT NULL,
  `round1` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `round1Duration` int NOT NULL,
  `round1TotalQuestions` int NOT NULL,
  `round2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round2Duration` int DEFAULT NULL,
  `round2TotalQuestions` int DEFAULT NULL,
  `round3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round3Duration` int DEFAULT NULL,
  `round3TotalQuestions` int DEFAULT NULL,
  `round4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round4Duration` int DEFAULT NULL,
  `round5` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round5Duration` int DEFAULT NULL,
  `round1Difficulty` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `round1Topics` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `round_details_driveId_key` (`driveId`),
  CONSTRAINT `round_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_details`
--

LOCK TABLES `round_details` WRITE;
/*!40000 ALTER TABLE `round_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `round_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_privileges`
--

DROP TABLE IF EXISTS `round_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_privileges` (
  `driveId` int NOT NULL,
  `IsSkipped` tinyint(1) DEFAULT NULL,
  `IsPrev` tinyint(1) DEFAULT NULL,
  `SubmitOnAnswered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`driveId`),
  UNIQUE KEY `round_privileges_driveId_key` (`driveId`),
  CONSTRAINT `round_privileges_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_privileges`
--

LOCK TABLES `round_privileges` WRITE;
/*!40000 ALTER TABLE `round_privileges` DISABLE KEYS */;
/*!40000 ALTER TABLE `round_privileges` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-02 17:21:13
-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: campus_hiring
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `Answers`
--

DROP TABLE IF EXISTS `Answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Answers` (
  `answerId` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `roundId` int NOT NULL,
  `questionId` int NOT NULL,
  `candidateId` int NOT NULL,
  `answer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`answerId`),
  UNIQUE KEY `Answers_answerId_key` (`answerId`),
  KEY `Answers_driveId_fkey` (`driveId`),
  KEY `Answers_questionId_fkey` (`questionId`),
  CONSTRAINT `Answers_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Answers_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answers`
--

LOCK TABLES `Answers` WRITE;
/*!40000 ALTER TABLE `Answers` DISABLE KEYS */;
INSERT INTO `Answers` VALUES (66,16,1,1060,145,'3'),(67,16,1,1147,145,'5'),(68,15,1,1135,118,'5'),(69,15,1,1175,118,'4');
/*!40000 ALTER TABLE `Answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mcqs`
--

DROP TABLE IF EXISTS `Mcqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mcqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `difficultLevel` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `optionType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'text',
  `option1` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imageLink` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snippet` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mcqs`
--

LOCK TABLES `Mcqs` WRITE;
/*!40000 ALTER TABLE `Mcqs` DISABLE KEYS */;
INSERT INTO `Mcqs` VALUES (1004,'What is rows of a relation known as?','easy',NULL,'Degree','Entity','Tuple','None','3','sql',NULL,NULL),(1005,'Which of the following is not a command of DDL?','easy',NULL,'Alter','Delete','Create','All of the above','2','sql',NULL,NULL),(1006,'Which of the following SQL command is used for removing (or deleting) a relation from the database?','easy',NULL,'Drop','Delete','Rollback','Remove','1','sql',NULL,NULL),(1007,'Select the correct definition of relation.','easy',NULL,'Subset of a cartesian product of list of domains','Subset of a cartesian product of list of tuple','Subset of a cartesian product of list of attributes','Subset of a cartesian product of list of relations','1','sql',NULL,NULL),(1008,'Which of the following is known as minimal super key?','easy',NULL,'Primary key','Candidate key','Foreign key','None','2','sql',NULL,NULL),(1009,'Which is AS clause used for?','easy',NULL,'Rename','Selection','Join','Projection','1','sql',NULL,NULL),(1010,'How many levels are there in architecture of database?','easy',NULL,'2','3','4','5','2','sql',NULL,NULL),(1011,'Which of the following is not a SQL command?','easy',NULL,'DELETE','ORDER BY','SELECT','WHERE','1','sql',NULL,NULL),(1012,'Which of the following can replace the below query?\r\n\r\nSELECT name, course_id  \r\nFROM instructor, teaches  \r\nWHERE instructor_ID= teaches_ID;','medium',NULL,'Select name, course_id from instructor natural join teaches;','Select name,course_id from teaches,instructor where instructor_id=course_id;','Select name, course_id from instructor;','Select course_id from instructor join teaches;','1','sql',NULL,NULL),(1013,'Select the definition of the correct key which is used to represent relation between two tables?','medium',NULL,'Candidate key','Foreign key','Primary key','Super key','2','sql',NULL,NULL),(1014,'Primary key can be?','easy',NULL,'NULL','NOT NULL','Both NULL and NOT NULL','Depends on situation','2','sql',NULL,NULL),(1015,'NATURAL JOIN can also be termed as -','easy',NULL,'Combination of Union and cartesian product','Combination of Selection and cartesian product','Combination of Projection and cartesian product','None','3','sql',NULL,NULL),(1016,'Select the valid SQL type.','easy',NULL,'NUMERIC','CHARACTER','FLOAT','All of the above','4','sql',NULL,NULL),(1017,'Which of the following set should be associated with weak entity set for weak entity to be meaningful?','medium',NULL,'Neighbour set','Strong entity set','Owner set','Identifying set','4','sql',NULL,NULL),(1018,'_________________ operations do not preserve non-matched tuples.','medium',NULL,'Left outer join','Inner join','Natural join','Right outer join','2','sql',NULL,NULL),(1019,'Why the following statement is erroneous?\r\n\r\nSELECT dept_name, ID, avg (salary)\r\nFROM instructor\r\nGROUP BY dept_name;','medium',NULL,'ID should not be used in group by clause','Group by clause is not valid in this query','Avg(salary) should not be selected','None','1','sql',NULL,NULL),(1020,'After groups have been established, SQL applies predicates in the ___________ clause, allowing aggregate functions to be used.','medium',NULL,'Where','Having','Group by','With','4','sql',NULL,NULL),(1021,'What is the function of the following command?\r\nDelete from r where P;','easy',NULL,'Clears entries from relation','Deletes relation','Deletes particular tuple from relation','All of the mentioned','3','sql',NULL,NULL),(1022,'The query specifying the SQL view is said to be updatable if it meets which of the following conditions?','medium',NULL,'select clause contains relation attribute names but not have expressions, aggregates, or distinct specification','from clause has 1 relation','query does not have group by or having clause','All of the mentioned','4','sql',NULL,NULL),(1023,'__________ command is used in SQL to issue multiple CREATE TABLE, CREATE VIEW and GRANT statements in a single transaction.','easy',NULL,'CREATE CLUSTER','CREATE PACKAGE','CREATE SCHEMA','All of the mentioned','3','sql',NULL,NULL),(1024,'A major goal of the db system is to minimize the number of block transfers between the disk and memory. Which of the following helps in achieving this goal?','easy',NULL,'Secondary storage','Storage','Catalog','Buffer','4','sql',NULL,NULL),(1025,'What happens if a piece of data is stored in two places in the db?','medium',NULL,'Storage space is wasted & Changing the data in one spot will cause data inconsistency','In can be more easily accessed','Changing the data in one spot will cause data inconsistency','Storage space is wasted','1','sql',NULL,NULL),(1026,'Which is a bottom-up approach to database design that design by examining the relationship between attributes:','medium',NULL,'Functional dependency','Database modeling','Normalization','Decomposition','3','sql',NULL,NULL),(1027,'Which formal method that locates and analyses relation schemas on the basis of their primary, candidate keys, and the FD\'s that are present among the attributes of these schemas:','medium',NULL,'Functional dependency','Database modeling','Normalization','Decomposition','3','sql',NULL,NULL),(1028,'Which is a duplicate copy of a file program that is stored on a different storage media than the original location:','medium',NULL,'Concurrency','Deadlock','Backup','Recovery','3','sql',NULL,NULL),(1029,'Which one of the following given statements possibly contains the error?','medium',NULL,'select * from emp where empid = 10003;','select empid from emp where empid = 10006;','select empid from emp;','select empid where empid = 1009 and Lastname = \'GELLER\';','4','sql',NULL,NULL),(1030,'The given Query can be replaced with ____________\r\nSELECT name  \r\nFROM instructor1  \r\nWHERE salary <= 100000 AND salary >= 90000;','medium',NULL,'SELECT name\r\nFROM instructor1\r\nWHERE salary BETWEEN 100000 AND 90000','SELECT name  \r\nFROM instructor|  \r\nWHERE salary BETWEEN 90000 AND 100000;','SELECT name  \r\nFROM instructor1  \r\nWHERE salary BETWEEN 90000 AND 100000;','SELECT name  \r\nFROM instructor!  \r\nWHERE salary <= 90000 AND salary>=100000;','3','sql',NULL,NULL),(1031,'Which one of the following refers to the \"data about data\"?','easy',NULL,'Directory','Sub Data','Warehouse','Meta Data','4','sql',NULL,NULL),(1032,'The part of SQL that deals with the SQL support constructs are called _______.','medium',NULL,'Persistent Construct Dealer','Persistent Supports Centre','Primary Storage Medium','Persistent Storage Module','4','sql',NULL,NULL),(1033,'A transaction starts when','easy',NULL,'A COMMIT statement is issued','A ROLLBACK statement is issued','A CREATE statement is used','All of the above','4','sql',NULL,NULL),(1034,'In the data type TIME(p), what does p stands for?','easy',NULL,'The amount of delay required to be added to the time','The maximum number of allowed hours','The number of fractional digits for the seconds','None','3','sql',NULL,NULL),(1035,'In SQL, Which of the following  is not a DDL commands','easy',NULL,'RENAME','REVOKE','GRANT','UPDATE','4','sql',NULL,NULL),(1036,'Which of the SQL statements is correct?','medium',NULL,'SELECT Username AND Password FROM Users','SELECT Username, Password FROM Users','SELECT Username, Password WHERE Username = \'user1\'','None','2','sql',NULL,NULL),(1037,'How to select all data from student table starting the name from letter \'r\'?','easy',NULL,'SELECT * FROM student WHERE name LIKE \'r%\';','SELECT * FROM student WHERE name LIKE \'%r%\';','SELECT * FROM student WHERE name LIKE \'%r\';','SELECT * FROM student WHERE name LIKE \'_r%\';','1','sql',NULL,NULL),(1038,'The HAVING clause does which of the following?','medium',NULL,'Acts EXACTLY like a WHERE clause.','Acts like a WHERE clause but is used for columns rather than groups.','Acts like a WHERE clause but is used for groups rather than rows.','Acts like a WHERE clause but is used for rows rather than columns.','3','sql',NULL,NULL),(1039,'Which one is the guideline of Referential integrity in a relationship ?','medium',NULL,'Do not enter a value in the primary key field of chield table if that value does not exist inthe primary key of the parent table','Do not enter a value in the foreign key field of a parent table if that value doesnot exist in the primary key of the child table','Do not enter a value in the foreign key field of a child table if that value does not exist in the primary key of the parent table','Do not enter a value in the foreign key field of child table if that value does not exist inthe foreign key of the parent table','3','sql',NULL,NULL),(1040,'Which of the following fields has width of 8 bytes?','easy',NULL,'Memo','Number','Date/time','Hyperlink','3','sql',NULL,NULL),(1041,'In a database Table, the each category of information Is called __________','easy',NULL,'Tuple','Field','Record','All Of Above','2','sql',NULL,NULL),(1042,'MongoDB stores documents in ___.','easy',NULL,'Store','Collections','Indexes','None of the mentioned','2','sql',NULL,NULL),(1043,'The Collections screen displays ___ for each collection in the selected database.','easy',NULL,'Collection name','Number of documents in the collection','Both collection Name and number of documents','None of the mentioned','3','sql',NULL,NULL),(1044,'Amongst which of the following is / are true about the authentication ___.','medium',NULL,'It is a process of verifying the identity of a client','It is a process of verifying network','It is a process of verifying the database','None of the mentioned','1','sql',NULL,NULL),(1045,'Cursor is a pointer to the result set of a ___.','easy',NULL,'Query','Table','Dataset','None of the mentioned','1','sql',NULL,NULL),(1046,'Which of the following are TCL commands?','easy',NULL,'COMMIT and ROLLBACK','UPDATE and TRUNCATE','SELECT and INSERT','GRANT and REVOKE','1','sql',NULL,NULL),(1047,'Which of the following is not a valid aggregate function?','easy',NULL,'COUNT','COMPUTE','SUM','MAX','2','sql',NULL,NULL),(1048,'What operator tests column for absence of data','easy',NULL,'NOT Operator','Exists Operator','IS NULL Operator','None','3','sql',NULL,NULL),(1049,'If we have not specified ASC or DESC after a SQL ORDER BY clause, the following is used by default','easy',NULL,'DESC','ASC','There is no default value','None','2','sql',NULL,NULL),(1050,'What is returned by INSTR (\'JAVAT POINT\', \'P\')?','medium',NULL,'6','7','POINT','JAVAT','2','sql',NULL,NULL),(1051,'SELECT ROUND (65.726, -1) FROM DUAL;\r\nPrints:','medium',NULL,'is illegal','garbage','726','70','4','sql',NULL,NULL),(1052,'How can you change \"Thomas\" into \"Michel\" in the \"LastName\" column in the Users table?','medium',NULL,'UPDATE User SET LastName = \'Thomas\' INTO LastName = \'Michel\'','MODIFY Users SET LastName = \'Michel\' WHERE LastName = \'Thomas\'','MODIFY Users SET LastName = \'Thomas\' INTO LastName = \'Michel\'','UPDATE Users SET LastName = \'Michel\' WHERE LastName = \'Thomas\'','4','sql',NULL,NULL),(1053,'Find the cities name with the condition and temperature from table \'whether\' where condition = sunny or cloudy but temperature >= 60.','medium',NULL,'SELECT city, temperature, condition FROM weather WHERE condition = \'cloudy\' AND condition = \'sunny\' OR temperature >= 60','SELECT city, temperature, condition FROM weather WHERE condition = \'cloudy\' OR condition = \'sunny\' OR temperature >= 60','SELECT city, temperature, condition FROM weather WHERE condition = \'sunny\' OR condition = \'cloudy\' AND temperature >= 60','SELECT city, temperature, condition FROM weather WHERE condition = \'sunny\' AND condition = \'cloudy\' AND temperature >= 60','3','sql',NULL,NULL),(1054,'Convert infix expression to postfix expression using stack  A+B-C*D','medium',NULL,'AB+CD*-','AB+CD-*','AB-CD+*','AB-CD*+','1','DS',NULL,NULL),(1055,'What is the time complexity of the following code  ','medium','','O(N*N)','O(N/2 log(N))','O(N log(N))','O(N^2 log(N))','3','DS',NULL,'int i,j,k=0,n;    \nfor(i=n/2;i<=n;i++){    for(j=2;j<=n;j=j*2)  {            \n         k=k+n/2;       \n }    \n}'),(1056,'How is the 4th element in an array accessed based on  pointer notation','medium',NULL,'*a+4','*(a+4)','a+4','*(*a+4)','2','DS',NULL,NULL),(1058,'Given the input 1,2,3,4,5, What is the functionality  of the following code','medium',NULL,'Inserting a node at the begining of the list','Deleting a node at the begining of the list','Inserting a node at the end of the list','Deleting a node at the end of the list','1','DS',NULL,'struct Node {\n    int data;\n    struct Node * next;\n};\nstruct Node * head;\nvoid funct(int data) {\n    struct Node * newnode;\n    newnode = (struct Node * ) malloc(sizeof(struct Node));\n    newnode -> data = data;\n    newnode -> next = head;\n    head = newnode;\n}'),(1059,'Which of these is not an application of a BST(Binary Search Tree)','medium',NULL,'Indexing and multi-level indexing','Random access of elements','Huffman coding algorithm','Managing virtual memory Areas (VMA\'s)','2','DS',NULL,NULL),(1060,'Which among these, heap sort uses to sort an array in O(log n)','medium',NULL,'Min heap','Binary heap','Max heap','Quick sort','2','DS',NULL,NULL),(1061,'Consider a sapnning tree with n=4 vertices. What is the maximum  number of spanning tree can be formed','medium',NULL,'n^(n+2)','n^(n+1)','n^(n-1)','n^(n-2)','4','DS',NULL,NULL),(1062,'Consider a BST (Binary search tree)of values 50,30,20,10,40,70,60,80  what is the functionality of the following code  node *funct(node* root, int n1, int n2) {     if (root == NULL) return NULL;       if (root->data > n1 && root->data > n2)         return funct(root->left, n1, n2);       if (root->data < n1 && root->data < n2)         return funct(root->right, n1, n2);       return root; }','medium',NULL,'Finds a lowest comman ancestor of a given BST(Binary search tree)','Finds a diameter of a BST(Binary search tree)','Checks if two nodes are cousins are not','Checks whether the given BST(Binary search tree) is balanced or not','1','DS',NULL,NULL),(1063,'Which of the following is true on measuring the efficiency of the  algorithm based on timing factor','medium',NULL,'Counting microseconds','Counting the number of declarations','Counting the number of iterations','Counting  the number of operations','4','DS',NULL,NULL),(1064,'which data structure is supporting insertion and deletion can be performed at both the ends?','medium',NULL,'Doubly linked list','Stack','Dequeue','Queue','3','DS',NULL,NULL),(1065,'which of the following data struture is not suitable when implementing priority queue','medium',NULL,'array','linked list','heap','graph','4','DS',NULL,NULL),(1066,'Sorting algorithm which adapts to single linked list','easy',NULL,'merge sort','insertion sort','heap sort','none of the above','2','DS',NULL,NULL),(1069,'Given a  linked list with values 10,20,30 which of the following snippet code will insert a node between 10 & 20','medium','snippet','void insert(int d){\n    struct Node*temp=head;\n    struct Node*newnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    temp->next->next=newnode;\n    newnode->next=temp->next;\n}','void insert(int d){\n    struct Node*temp=head;\n    struct Node*newnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    temp->next=newnode->next;\n    newnode->next=temp;\n}','void insert(int d){\n    struct Node*temp=head;\n    struct Node*newnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    temp->next=newnode;\n    newnode->next=temp->next;\n}','void insert(int d){\n    struct Node*temp=head;\n    struct Node*newnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    newnode->next=temp->next;\n    temp->next=newnode;\n} ','4','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/graph3.jpg',NULL),(1071,'What is the diameter of the given BST?','medium',NULL,'12','14','13','15','3','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/graph4.jpg',NULL),(1075,'Which of the following can\'t be solved using dynamic programming','medium',NULL,'Longest alternating subsequence problem','0-1 Knapsack problem','Wildcard pattern matching','Graph coloring problem','4','DS',NULL,NULL),(1078,'Given a  linked list with values 10,20,30 which of the following snippet code will delete a node 20','medium','snippet','void listDelete()\n{\n    struct Node*temp=head;\n    struct Node*p=temp->next;\n    temp->next=p\n    p->next=NULL;\n}','void listDelete()\n{\n    struct Node*temp=head;\n    struct Node*p=temp->next;\n    temp->next=p->next;\n    p->next=NULL;\n}','void listDelete()\n{\n    struct Node*temp=head;\n    struct Node*p=temp->next;\n    p->next=NULL;\n    temp->next=p->next;\n}','void listDelete()\n{\n    struct Node*temp=head;\n    struct Node*p=temp->next;\n    temp->next=p->next;\n}','2','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1078.jpg',NULL),(1079,'Consider a Doubly Linked list of values 10,20,30,40,50,60. what is the functionality of the following code\n','medium','','Prints all  nodes of Linked list except first node','Prints all nodes of Linked list in reverse order','Prints all nodes of Linked list in reverse order except last node','Prints alternate nodes in reverse order','2','DS',NULL,'void display()\n{\n    struct Node*temp=head;\n    while(temp->right!=NULL)\n    {\n        temp=temp->right;\n    }\n    while(temp!=NULL)\n    {\n        cout<<temp->data<<\" \";\n        temp=temp->left;\n    }\n    cout<<endl;\n}'),(1082,'In an undirected connected graph G,there are 7 Vertices and 11 Edges. The number of Faces in G is','medium',NULL,'5','7','6','4','3','DS',NULL,NULL),(1083,'Given Binary expression tree, find the infix expression','medium',NULL,'a*b/c + f/e * g+k - y*x','a*b/c + e/f * k+g-x*y','a*c/b +e/f *g+k-y*x','a*b/c +e/f*g+k-x*y','4','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1084.jpg',NULL),(1086,'What is the time complexity of rotating a linked list by some places clockwise?','medium',NULL,'O(N)','O(N^2)','O(N*log(N))','O(2N)','1','DS',NULL,NULL),(1088,'The following function mirror() is supposed to convert a BST(Binary Search Tree) into its mirror tree. There is one line missing at the end of the function\n<br>\nWhat should be added in place of  /* ADD A STATEMENT HERE */ so that the function correctly convert a BST(Binary Search Tree) into its mirror tree','medium','snippet','node->right=node->left','node->left = node->right','node->left=temp','temp=node->left','2','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1088.png','void mirror(struct Node* node) \n{\n    if (node == NULL) \n        return; \n    else\n    {\n        struct Node* temp;\n          \n        mirror(node->left);\n        mirror(node->right);\n     \n        temp = node->left;\n       /* ADD A STATEMENT HERE */\n        node->right = temp;\n    }\n} \n'),(1089,'Consider a following BST(Binary Search Tree) of values 50 30 70 20 60 90 25 80 which of the following snippet code will find the sum of parent node which is having a single child','medium','snippet','void sum(struct Node*root)\n{\n    if(root==NULL)\n        return;\n    if((root->left==NULL&&root->right!=NULL) ||( root->left!=NULL && root->right==NULL))\n    {\n        s+=root->data;\n    }\n    sum(root->left);\n    sum(root->right);\n    \n}','void sum(struct Node*root)\n{\n    if(root==NULL)\n        return;\n    if((root->left!=NULL&&root->right!=NULL) ||( root->left==NULL && root->right==NULL))\n    {\n        s+=root->data;\n    }\n    sum(root->left);\n    sum(root->right);\n    \n}','void sum(struct Node*root)\n{\n    if(root==NULL)\n        return;\n    if((root->left==NULL || root->right!=NULL) &&( root->left!=NULL || root->right==NULL))\n    {\n        s+=root->data;\n    }\n    sum(root->left);\n    sum(root->right);\n    \n}','void sum(struct Node*root)\n{\n    if(root==NULL)\n        return;\n    if((root->left==NULL&&root->right!=NULL) &&( root->left!=NULL && root->right==NULL))\n    {\n        s+=root->data;\n    }\n    sum(root->left);\n    sum(root->right);\n    \n}','1','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1089.png',NULL),(1090,'What is the time complexity of the following code\n','medium','','O(N^3)','O(N*(N(N+1)/2))','O(N*log(n))','O(N^2)','1','DS',NULL,'for(int i=1;i<=n;i++)\n    {\n        for(int j=1;j<=i;j++)\n        {\n            print(j)\n        }\n    }'),(1091,'Suppose the numbers 50,30,70,20,10,25,23,27,21,40,35,45,47,46,49,48,60,90,80,100,95,97,98  are inserted in that order into an initially empty binary search tree. From what node to  node will have the longest diameter','medium',NULL,'Node 10 to Node 98','Node 48 to Node 98','Node 21 to Node 98','Node 21 to Node 10\n','2','DS',NULL,NULL),(1092,'What is the time complexity of the following code ','medium','','O(N*(2*sqrt(N))','O(N*(2*log(N)))','O(2N*(log(N)))','O(N*sqrt(N))','4','DS',NULL,'int k=1;\n    for(int i=1;i<=n;i++)\n    {\n        for(int j=1;j<=sqrt(n);j++)x`\n        {\n            k+=1;\n        }\n        \n        for(int j=1;j<=sqrt(n);j++)\n        {\n            k+=1;\n        }\n    }\n'),(1095,'Given Inorder traversal and Postorder traversal of a Binary search tree(BST). Find Preorder traversal\n<br>Inorder traversal: A,B,C,D,E,F,G,H,I,J,K\n<br>Postorder traversal: B,A,E,D,C,H,G,K,J,I,F\n','medium',NULL,'F,C,A,B,D,E,I,G,H,J,K','F,C,A,D,B,E,I,G,J,H,K','F,C,A,B,D,E,I,H,G,J,K','F,C,A,B,D,E,G,I,H,J,K','1','DS',NULL,NULL),(1099,'Given the val[]={60, 100, 120 } , wt[]={10, 20, 30}, n=3 and W=50\nTrace the below code and predict the output','medium','','200','210','220','230','3','DS',NULL,'int function(int W, int wt[], int val[], int n) {\n    int i, w;\n    int K[n+1][W+1];\n    for (i = 0; i <= n; i++) {\n        for (w = 0; w <= W; w++) {\n            if (i==0 || w==0)\n                K[i][w] = 0;\n            else if (wt[i-1] <= w)\n                K[i][w] = max(val[i-1] + K[i-1][w-wt[i-1]], K[i-1][w]);\n            else\n                K[i][w] = K[i-1][w];\n        }\n    }\n\n    return K[n][W];\n}'),(1100,'What is the time complexity of the following code','medium','snippet','O( C^(N-1)   +   1)','O(log(C^n))','O(C^n)','O( C^(n-1)  -1 )','3','DS',NULL,'pow(c,n)\n{\n    if(n==0)\n        return 1;\n    return c*pow(c,n-1)\n}'),(1101,'What is the functionality of the following snippet code','medium','','Find the maximum sum of contiguous sub array in a given vector of integer ','Find the maximum sum of Non-contiguous sub array in a given vector of integer','Find the maximum value of contiguous sub array in a given vector of integer','Find the maximum value of Non-contiguous sub array in a given vector of integer ','1','DS',NULL,'int function(vector<int>& arr) {\n    int m_sum = arr[0];\n    int c_sum = arr[0];\n    for (int i = 1; i < arr.size(); i++) {\n        c_sum = max(arr[i], c_sum + arr[i]);\n        m_sum = max(m_sum, c_sum);\n    }\n    return m_sum;\n}'),(1102,'Below  function is supposed to find the GCD of two numbers. However, the code contains several logical faults that prevent it from producing the required results. To obtain the output, correct the code','medium','','error 1 should be changed to n>m,error 2 should be changed to m==n','error 1 should be changed to m!=n, error 2 should be changed to m>n','error 1 should be changed to m%n==0, error 2 should be changed m==n','error 1 should be changed to n<m, error 2 should be changed to m!=n','2','DS',NULL,'int function(int x,int y)  /*x>0 and y>0 */\n{\n   int m, n; \n   m = x; n = y; \n   while (m==n) /*error 1*/\n   { \n      if(m!=n)    /*error 2*/\n         m = m-n;   \n      else\n         n = n - m; \n   } \n   return n;\n}'),(1103,'The program attempts to locate an element x in an array Y[] using binary search. However, there is an error in the program that causes it to not work correctly.. On which of the following contents of Y[]  and x does the program fail?','medium','','Y[2,2,2,2,2,2,2,2,2,2] x>2','Y[1,2,3,4,5,6,7,8,9,10] x<10','Y is [1 3 5 7 9 11 13 15 17 19] and x <1','Y is [2 4 6 8 10 12 14 16 18 20] and 2 < x < 20 and x is even','1','DS',NULL,'f(int Y[10], int x) \n{\n    int i, j, k;\n    i=0; j=9;\n    do {\n     k=(i+j)/2;\n     if(Y[k]<x)i=k;else j=k;\n        }while(Y[k]!=x&&i<j);\n    if(Y[k]==x) \n        printf (\"x is in the array \") ;\n    else \n        printf (\" x is not in the array \") ;\n}'),(1104,'Which of the following algorithm implementations is similar to that of a Binary heap?','medium','','Merge sort','Quick sort','Insertion sort','Radix sort','3','DS',NULL,NULL),(1105,'Which of the following sorting algorithms doesn\'t use the divide and conquer technique','easy','','Merge sort','Insertion sort','Quick sort','Heap sort','2','DS',NULL,NULL),(1106,'What is the functionality of the following snippet code','medium','','rotates the array in a cyclic left shift by moving each element one position to the left','rotates the array in a Non-cyclic left shift by moving each element one position to the left','rotates the array in a Non-cyclic right shift by moving each element one position to the right','rotates the array in a cyclic right shift by moving each element one position to the right','4','DS',NULL,'void function(int arr[], int n) {\n    int last = arr[n-1];\n    for(int i = n-1; i > 0; i--) {\n        arr[i] = arr[i-1]; \n    }\n    arr[0] = last; \n}'),(1107,'What is the space complexity of the following snippet code','medium','','O(m)','O(m*n)','O(n)','O(m^2)','2','DS',NULL,'int** arr = new int*[m];\nfor (int i = 0; i < m; i++) {\n    arr[i] = new int[n];\n}'),(1108,'Consider arr1[1,5,10,20,40,80],arr2[6,7,20,80,100],\narr3[3,4,15,20,30,70,80,120] Predict the output of the below code','medium','','20,80','100,120','1,3','20,20','1','DS',NULL,'void function(int ar1[], int ar2[], int ar3[])\n{\n    int i=0,j=0,k=0;\n    while (i<arr1.size()&&j<arr2.size()&&k< rr3.size()) {\n        if (ar1[i]==ar2[j]&&ar2[j]==ar3[k]) {\n            printf(arr1[i])\n            i++;\n            j++;\n            k++;\n        }\n        else if (ar1[i]<ar2[j])\n            i++;\n        else if (ar2[j]<ar3[k])\n            j++;\n        else\n            k++;\n    }\n}'),(1109,'Which of the following is a disadvantage of binary search algorithm','easy','','It only works on sorted array','It has a high time complexity','Difficult to search element if the size of an array is very large','It has a high space complexity','1','DS',NULL,NULL),(1110,'The below snippet code is suppose to generate the following series\n0 2 8 14 24 34 48..... \nThe code contains logical errors that prevent it from producing the desired output. Choose the option which corrects the error.','medium','','n%i==1 instead of i%2==1','i%2==0 instead of i%2==1','(i*i)-2 instead of (i*i)-3','i*i instead of (i*i)-1','3','DS',NULL,'void function(int n){\n    for(int i=1;i<=n;i++)\n        printf((i%2==1)?((i*i)-1)+\" \":((i*i)-3)+\" \");\n}'),(1111,'Which of the following algorithms provide the best time complexity in the worst-case scenario','medium','text','Quick sort','Heap sort','Selection sort','Merge sort','4','DS',NULL,NULL),(1112,'What is the time complexity of the following code','medium','','O(N)','O(n^2)','O(log(n))','O(1)','2','DS',NULL,'void function(){\n    string s = \"scaler\";\n    int n = s.size();\n    for(int i = 0; i < n; i++) {\n        s = s + s[i];\n    }\n    print(s+\" \")\n}'),(1113,'Consider n=10, Predict the output of the below code','easy','','10 9 8 .... 1','9 8 7 ....1','1 2 3 ....10','10','1','DS',NULL,'void function(int n)\n{\n    if(n == 0)\n    return;\n    printf(\"%d \",n);\n    function(n-1);\n}'),(1114,'What is the maximum number of swaps that can be performed in the selection sort?','medium','text','N','1','N-1','Depends on the maximum value of an array','3','DS',NULL,NULL),(1115,'In general, Backtracking is used to solve?','easy','text','Numerical problems','Exhaustive search','Combinatorial problems','Graph coloring problems','3','DS',NULL,NULL),(1116,'Predict the output of the below code if set={\'a\',\'b\',\'c\'} set_size=3','medium','','a,b,ab,c,ac,bc,abc,',',a,b,ab,c,ac,bc,abc,','a,b,ab,c,ac,bc,abc',',abc,bc,ac,c,ab,b,a,','2','DS',NULL,'void PowerSet(char *set, int set_size) \n{ \nunsigned int pow_size = pow(2, set_size); \nint count, j; \nfor(count = 0; count < pow_size; count++) \n{ \n     for(j = 0; j < set_size; j++) \n     { \n \nif(count & (1<<j)) \nprintf(\"%c\", set[j]); \n     } \n     printf(\",\"); \n} \n}\n'),(1117,'Given 6 items  A,B,C,D,E & F are pushed in a stack S1, one after another starting from A. The stack is popped 3 items and each element is inserted in queue Q1. Again the stack S1 is popped 3 items and pushed to another stack S2. The  two elements are deleted from the queue Q1 and pushed back to stack S1. Then three elements popped from stack S2 and each element is inserted in a queue Q1, then two elements from stack S1 are popped and inserted to queue Q1. What is the true statement \nStatement 1: both stacks S1 and S2 are equal\nStatement 2: All the elements (A,B,C,D,E,F) are present in queue Q1\nStatement 3: both stacks S1 and S2  are empty\nStatement 4: Queue Q1 is empty','medium','','Statement 1 and Statement 2 are false','Statement 1 and Statement 2 are true','Statement 3 is false','Statement 3 and 4 are true','2','DS',NULL,NULL),(1120,'The Information stored in Node which are used to implement binary search tree','easy','text','Left child address','Right child address','Value of the node','All of the above','4','DS',NULL,NULL),(1121,'Given the postfix binary expression \"a b - c d * + f + g h / -\". Which of the following expression represents infix binary expression','hard','text','a - b + c * d + f - g / h','a + b - c * d + f - g / h','a - b + c * d - f + g / h','a - b + c / d + f - g * h','1','DS',NULL,NULL),(1122,'Given a  linked list with values 10,20,30 which of the following snippet code will insert a node between 10 & 20','medium','snippet','void insert(int d){\n    struct Node*temp=head;\n    struct Node*newnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    temp->next->next=newnode;\n    newnode->next=temp->next;\n}\n',' void insert(int d){\n    struct Node*temp=head;\n    struct Node*newnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    temp->next=newnode->next;\n    newnode->next=temp;\n}\n','void insert(int d){\n    struct Node*temp=head;\n    struct Node*newnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    temp->next=newnode;\n    newnode->next=temp->next;\n}\n','void insert(int d){\n    struct Node*temp=head;\n    struct Node*newnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    newnode->next=temp->next;\n    temp->next=newnode;\n}\n','4','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1122.png',NULL),(1124,'Which of the following is a common technique used to avoid collisions in hash table ','mdeium','text','Linear Probing','Chaining ','Resizing','All of the above','2','DS',NULL,NULL),(1126,'How AVL tree differs from Binary search tree(BST)','easy','text','Left subtree and right subtree differ in height by at most 1','Left subtree and right subtree differ in height by at least 1','Diameter of left subtree should be greater than right subtree','Diameter of right subtree should be greater than left subtree','1','DS',NULL,NULL),(1127,'Given the hash function H(k)=k%8 and pseudo random i=(i+5)%8 with a hash table of size 8. We want to insert the following keys one by one from left to right 15,11,25,10,12,14. What will be the position of the key 51 if we use random probing','medium','text','6','4','0','2','3','DS',NULL,NULL),(1129,'Given a  linked list with values 10,20,30 which of the following snippet code will delete a node “20”','medium','snippet','void listDelete()\n{\n    struct Node*temp=head;\n    struct Node*p=temp->next;\n    temp->next=p\n    p->next=NULL;\n}\n','void listDelete()\n{\n    struct Node*temp=head;\n    struct Node*p=temp->next;\n    temp->next=p->next;\n    p->next=NULL;\n}\n','void listDelete()\n{\n    struct Node*temp=head;\n    struct Node*p=temp->next;\n    p->next=NULL;\n    temp->next=p->next;\n}\n','void listDelete()\n{\n    struct Node*temp=head;\n    struct Node*p=temp->next;\n    temp->next=p->next;\n}\n','2','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1129.png',NULL),(1131,'The following function append() is supposed to create Circular linked list(singly). There is one line missing at the end of the function....What should be added in place of  /* ADD A STATEMENT HERE */ so that the function correctly creates circular linked list','medium','snippet','newnode->next=head;','newnode->next=temp;','newnode->next=temp->next;','newnode->next=head->next;','1','DS',NULL,'void append(int d)\n{\n    struct Node*newnode,*temp;\nnewnode=(struct Node*)malloc(sizeof(struct Node));\n    newnode->data=d;\n    newnode->next=NULL;\n    temp=head;\n    if(head==NULL)\n    {\n        head=newnode;\n        newnode->next=head;\n    }else{\n        while(temp->next!=head)\n        {\n            temp=temp->next;\n        }\n        temp->next=newnode;\n        /* ADD A STATEMENT HERE */\n    }\n}\n'),(1132,'Consider a Linked list of values 1,2,3,4,5,6,7,8,9,10. what is the functionality of the following code','medium','','Reverse alternate kth node in a singly linked list','Finds kth node in given linked list','Finds kth node from end of linked list','Rotate linked list from Kth node','1','DS',NULL,'Node *function(Node *head, int k) \n{ \n    Node* current = head; \n    Node* next; \n    Node* prev = NULL; \n    int count = 0; \n  \n    while (current != NULL && count < k) \n    { \n    next = current->next; \n    current->next = prev; \n    prev = current; \n    current = next; \n    count++; \n    } \n      \n    if(head != NULL) \n    head->next = current; \n  \n    count = 0; \n    while(count < k-1 && current != NULL ) \n    { \n    current = current->next; \n    count++; \n    } \n    if(current != NULL) \n    current->next = function(current->next, k); \n    return prev; \n} \n'),(1133,'Given Hash function h(k) = K%M, where k is the key value,  M is the size of the hashtable.\nWhat type of hash function is used ','easy','text','Folding Method','Multiplication method','Modulus method','Division method','4','DS',NULL,NULL),(1134,'Consider 0 (Zero) as root node, find the BFS of a given graph','medium','text','0 1 5 6 4 2 3','0 1 3 2 5 6 4','0 3 2 6 5 4 1','0 3 2 4 5 6 1','2','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1134.png',NULL),(1135,'Find the vertical order traversal for the given Binary Search tree (BST)','hard','text','-3 ->10, -2-> 20, -1 -> 30  35, 0 -> 50 40 60, 1 -> 70, 2 ->80, 3 -> 90','-3 ->10, -2-> 20, -1 -> 30  35, 0 ->  40 60, 1 -> 70, 2 ->90, 3 -> 80','-3 ->10, -2-> 20, -1 -> 33 , 0 -> 40 60 50 , 1 -> 70, 2 ->80, 3 -> 90','none','1','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1135.png',NULL),(1136,'Which of the following problems can be solved with the help of two pointers on a linked list?','easy','text','Finding  middle element in a linked list','Removing the duplicate elements in a linked list','Detecting cycle in a linked list','All of the above\n','4','DS',NULL,NULL),(1137,'Below mentioned graph represents','easy','text','Directed graph','Weighted graph','Complete graph','Pseudo graph','3','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1137.png',NULL),(1138,'The Algorithm which is used to find the shortest path between two nodes in a weighted graph','medium','text','Prim\'s Algorithm','Flood fill algorithm','KMP algorithm','Dijkstra\'s algorithm ','4','DS',NULL,NULL),(1140,'what is the functionality of the following code','easy','','Post order traversal','Pre order traversal','In order traversal','Level order traversal ','1','DS',NULL,'void func(Node root)\n{\nfunc(root.left());\nfunc(root.right());\nSystem.out.println(root.data());\n}\n'),(1141,'What is the hash function used in linear probing?','medium','text','H(x)= key mod table size','H(x)= (key+ F(i2)) mod table size','H(x)= X mod 17','H(x)= (key+ F(i)) mod table size','4','DS',NULL,NULL),(1142,'What is the worst-case time complexity of performing an arbitrary insertion or deletion operation in a binary heap of size N?','hard','text','O(log N)','O(N)','O(N log N)','O(N^2)','1','DS',NULL,NULL),(1143,'Which of the following data structures is best suited for implementing a LIFO (last-in-first-out) queue?','easy','text','Binary search tree','Linked list','Hash table','Priority queue','2','DS',NULL,NULL),(1144,'Samantha is organizing a party and wants to create name tags for her guests using the letters A, B, and C. She decides to use a stack-based system to print the name tags. Samantha has Stack S1 has the entries A, B, and C (with \'A\' on top). Stack S2 is empty. An entry popped out of stack S1 can be printed immediately or pushed to stack S2. An entry popped out of stack S2 can only be printed. In this arrangement, Which of the following permutations of A, B, and C are not possible','medium','text','C A B','B A C','C B A','A B C','2','DS',NULL,NULL),(1145,'876-4*/83*+4+5/    -   The evaluation of above postfix expression is','medium','text','8','12','6','0','3','DS',NULL,NULL),(1146,'Which type of data structure stack is it?','easy','text','Linear','Non-Linear','Quadratic','None of the above','1','DS',NULL,NULL),(1147,'To toggle a particular bit, which of the following bitwise operator would be used?','medium','text','AND operator','OR  operator','NOT operator','XOR operator','4','DS',NULL,NULL),(1148,'What is the maximum number of nodes at level k in a binary tree?','medium','text','2^k-1','2^k','2k','k^2','2','DS',NULL,NULL),(1149,'what will be the output of above code if the binary search tree values are [50 30 40 20 10 70 60 80 90]   low=30 and high=90 (function push_back adds values at the end of the vector)',NULL,'text','[30,40,50,60,70,80]','[80,70,60,50,40,30]','[30,50,70,90]','[40,60,80]','1','DS',NULL,'void function(Node* root, int low, int high, vector<int>& result) {\n    if (root == NULL) {\n        return;\n    }\n    if (root->data > low) {\n        function(root->left, low, high, result);\n    }\n    if (root->data >= low && root->data <= high) {\n        result.push_back(root->data);\n    }\n    if (root->data < high) {\n        function(root->right, low, high, result);\n    }\n}'),(1150,'Given a graph with values graph = {{1, 2}, {0, 3}, {0, 3}, {1, 2}} and source=0 what is the output of above code','medium','text','0 2 1 3','0 2 3 1','0 3 1 2','0 1 2 3','4',NULL,NULL,'void function(vector<vector<int>>& graph, int source) {\n    int n = graph.size();\n    vector<bool> visited(n, false);\n    queue<int> q;\n    q.push(source);\n    visited[source] = true;\n    while (!q.empty()) {\n        int u = q.front();\n        q.pop();\n        cout << u << \" \";\n        for (int v : graph[u]) {\n            if (!visited[v]) {\n                q.push(v);\n                visited[v] = true;\n            }\n        }\n    }\n}\n'),(1151,'What is the worst-case time complexity for inserting, searching, and deleting in a hash table using chaining?','easy','text','O(N)','O(N logN)','O(1)','O(N^2)','3',NULL,NULL,NULL),(1152,'Which of the following is an advantage of using a hash table over a binary search tree?',NULL,'text','Hash tables are faster for large data sets','Hash tables require less memory','Hash tables can be sorted more easily','Hash tables are more flexible','1','DS',NULL,NULL),(1153,'Given a weighted graph,Using Kruskal\'s algorithm find the minimum cost spanning tree (apply greedy approach)','medium','text','B->D,D->E,A->C,C->D,A->F','B->D,B->E,A->C,C->D,A->F','B->D,B->E,A->C,C->D,C->F','B->D,D->E,A->C,C->D,C->F','1','DS','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1153.png',NULL),(1154,'Suppose you have a B-tree of order 5 and you need to insert a new element in the tree. Which of the following is true about the time complexity of this operation?','medium','text','It takes O(log n) time, where n is the number of elements in the tree','It takes O(log m) time, where m is the order of the tree.','It takes O(1) time, regardless of the order or size of the tree.','It takes O(m) time, regardless of the order or size of the tree.','2','ds',NULL,NULL),(1155,'What would be the output of the following C++ program if the given input graph G[5][5] is \n\n','medium','text','0 3 4 1 2','0 4 3 1 2','0 3 2 4 1','0 1 3 2 4','3','ds',NULL,'0 0 0 1 1\n0 0 0 0 1\n0 0 0 1 0\n1 0 1 0 0\n1 1 0 0 0\n\nthe initial value of i=0 in the below code:\n\nvoid fun(int i)\n{\n    cout << i << \" \";\n    visited[i] = true;\n    for (int j = 0; j < 5; j++)\n        if (!visited[j] && G[i][j] == 1)\n            fun(j);\n}'),(1156,'A social media platform wants to recommend friends to its users based on common interests. The platform represents users as nodes in a graph, and the friendships between users as edges. The recommendation algorithm aims to suggest friends who have a high number of mutual friends.Which algorithm is most suitable for recommending friends based on mutual friends in the graph?','medium','text','Breadth-first search (BFS)','Depth-first search (DFS)','Dijkstra\'s algorithm','Kruskal\'s algorithm','2','ds',NULL,NULL),(1157,'Given a BST(Binary Search Tree) with values 10,50,150,37,7 and minVal=-9999 maxVal=9999 what is the functionality of the following function','medium','text','Checks the given BST is valid BST or not','Checks the root element is maximum or minimum','Checks all the BST values are within minVal to maxVal','Checks largest child node in the BST','1','ds',NULL,'bool function(Node* root, int minVal, int maxVal) {\n    if (root == null) {\n        return true;\n    }\n    \n    if (root->data <= minVal || root->data >= maxVal) {\n        return false;\n    }\n    \n    return function(root->left, minVal, root->data) && function(root->right, root->data, maxVal);\n}\n'),(1158,'Given a weighted graph, find the minimum cuts to get maximum flow using minimum cut maximum flow algorithm','hard','text','{d->z,e->z,c->z}','{d->z,b->e,c->z,c->e}','{b->d,c->z,e->z}','{b->e,c->b,a->c}','3','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1158.jpg',NULL),(1159,'Given a weighted graph, Apply Bellman ford algorithm to find the single source shortest path of all the vertices using dynamic programming','hard','text','A->0,B->6,C->4,D->5,E->5,F->4','A->0,B->1,C->3,D->5,E->0,F->3','A->0,B->1,C->4,D->5,E->5,F->3','A->0,B->6->C->3,D->0,E->0,F->3','2','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1159.jpg',NULL),(1160,'The below snippet code is suppose to find the sum of the digits of the given number (1234 = 1+2+3+4=10)\nThe code contains logical errors that prevent it from producing the desired output. Choose the option which corrects the error.','medium','text','num/=10 should be changed to num/=2','sum+=num/10 should be changed to sum+=num/2','sum+=num/10 should be changed to sum+=num%10','num!=0 should be changed to num!=sum','3','ds',NULL,'int calculateSumOfDigits(int num) {\n    int sum = 0;\n    while (num != 0) {\n        sum += num / 10;\n        num /= 10;\n    }\n    return sum;\n}'),(1161,'Trace the below c++ code and predict the output','medium','text','LEARN TO EASY IS CODING','CNIDOG IS ESAY TO LRAEN','CODING IS EASY TO LEARN','GODINC SI YASE OT NEARL','4','ds',NULL,'int main()\n{\n    string str=\"CODING IS EASY TO LEARN\";\n    int first=0,last;\n    char temp;\n    for(int i=0;i<=str.length();i++)\n    {\n        if(str[i]==\' \'|| i==str.length())\n        {\n            temp=str[i-1];\n            str[i-1]=str[first];\n            str[first]=temp;\n            first=i+1;\n        }\n        \n    }\n    cout<<str;\n    return 0;\n}'),(1162,'Imagine you are designing a countdown timer application for a cooking competition. The timer needs to display the countdown from 10 seconds to 1 second. To implement this functionality, you decide to use a recursive function. You need to determine the number of times the recursive function will be called when the countdown timer is initiated using the provided code.','medium','text','9','10','11','12','3','ds',NULL,'void my_recursive_function(int n)\n{\n     if(n == 0)\n     return;\n     printf(\"%d \",n);\n     my_recursive_function(n-1);\n}\nint main()\n{\n     my_recursive_function(10);\n     return 0;\n}'),(1163,'Below snippet code finds the minimum number of jumps required to reach the end of the array. Which of the following input gives minimum jump as 1','medium','text','[8,1,4,3,5,6,7,2]','[1,8,4,3,5,6,7,2]','[1,2,4,3,5,6,7,8]','[2,8,4,3,5,1,6,7]','1','ds',NULL,'int function(std::vector<int>& nums) {\n    int n = nums.size();\n    int jumps = 0;\n    int currEnd = 0;\n    int currFarthest = 0;\n    \n    for (int i = 0; i < n - 1; i++) {\n        currFarthest = std::max(currFarthest, i + nums[i]);\n        if (i == currEnd) {\n            jumps++;\n            currEnd = currFarthest;\n        }\n    }\n    \n    return jumps;\n}'),(1164,'Given a=50,b=10,c=3=,d=5,e=3,f=2 (frequencies). What are the total bits required to convert a given message \"abcdef\" to huffman coding? Refer  below huffman tree and apply huffman coding(greedy technique) ','medium','text','180 bits','185 bits','175 bits','160 bits','2','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1164.jpg',NULL),(1165,'You are playing a board game with your friends called \"Mystery Dice.\" In this game,you are given three dice. The goal is to find the numbers on each die when it is rolled based on a set of clues. You are given the following clues to determine the numbers on your set of dice:\nThe sum of the numbers on the three dice facing up is X. \nThe number on the first die is double the number on the second die.\nThe number on the third die is half the number on the first die.\nTo calculate X use the formula\n3^N+C=X+G\nWhere:\nN: No of dies\nG: The sum of all the faces on a die(1+2+3+4+5+6=21)\nC:Constant (6)\n','medium','text','First die:8,second die:4,third die:4','First die:6,second die:3,third die:3','First die:6,second die:4,third die:2','First die:6,second die:3,third die:2','2','logical',NULL,NULL),(1166,'Trace the below c++ code for input array [2, 4, 5, 6, 3, 7, 8] a=9','easy','text','(2, 7) (4, 5) (6, 3)','(2, 7) (4, 3) (6, 3)','(1, 8) (4, 5) (6, 3)','(2, 7) (4, 5) (8, 1)','1','ds',NULL,'function(int arr[], int size, int a) {\n    for (int i = 0; i < size; i++) {\n        for (int j = i + 1; j < size; j++) {\n            if (arr[i] + arr[j] ==a) {\n               cout<<arr[i]<<\" \"<<arr[j]<<endl;\n            }\n        }\n    }\n}\n'),(1167,'What is the time complexity of the jump search?','medium','text','O(logN)','O(N)','O(sqrt(N))','O(NlogN)','3','ds',NULL,NULL),(1168,'There are four trains named A, B, C, and D that arrive and depart from a station. The schedule information is as follows:\nTrain A arrives before Train B.\nTrain C departs after Train B.\nTrain D departs before Train C.\nTrain B departs at 10:30 AM.\nTrain A arrives at 9:45 AM.\nBased on this information, Which of the following statement is not true \n','medium','text','Train A arrives at 9:45 AM and departs later.','Train B arrives at 10:00 AM and departs at 10:30 AM.','Train C arrives after 10:30 AM and departs later.','Train C departs at 9:00AM','4','logical',NULL,NULL),(1169,'The Atbash cipher is a simple substitution cipher that replaces each letter with its mirror image in the alphabet. For example, the letter \'A\' is replaced by \'Z\', \'B\' by \'Y\', \'C\' by \'X\', and so on. The cipher is symmetric, meaning that encoding and decoding are performed using the same process.\nYour task is to encode a given string using the Atbash cipher.\nstring:\"THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG\"\n','easy','text','GSV JFRXP YILDM ULC QFNKH LEVI GSV OZAB WLT','GSV JFRWQ YILDM ULC QFNKH LEVI GSV OZAB WLT','GSV JFRXP YILDM UMB QFNKH LEVI GSV OZAB WLT','GSV JFRXP YILDM ULC QFNKH LEVI GSV OZAB WLS','1','ds',NULL,NULL),(1170,'A computer system is using a Hamming code to detect and correct errors in a sequence of bits. In this code, 4 bits of data are encoded into 7 bits, where the additional 3 bits are parity bits for error detection and correction. Each bit is assigned a position from 1 to 7.\nGiven Data 1001, find the parity bits(p1,p2,p4) \nUse the formula  2^r >=m+r+1(where r is the redundant bit with values 1,2,3....so on) to find the parity bits\n','hard','text','p1=0,p2=0,p3=1','p1=1,p2=0,p3=1','p1=0,p2=1,p3=1','p1=0,p2=1,p3=0','1','ds',NULL,NULL),(1171,'In a bag, there are X red balls and Y green balls. You randomly draw a K number of  balls from the bag without replacement .In below c++ code Function  calculateProbability finds the probability of getting red balls(drawCount times) Given the integer inputs totalRed , totalGreen and drawCount. Which of the following inputs will fail to get desired output.\nNote: probabilty should lie between 0 and 1)','medium','text','totalRed=5,totalGreen=3,drawCount=2','totalRed=3,totalGreen=5,drawCount=2','totalRed=5,totalGreen=3,drawCount=9','totalRed=3,totalGreen=5,drawCount=3','3','ds',NULL,'double calculateProbability(int totalRed, int totalGreen, int drawCount) {\n    int totalBalls = totalRed + totalGreen;\n    double probability = (double)(totalRed) / totalBalls;\n    \n    for (int i = 1; i < drawCount; ++i) {\n        totalRed--;\n        totalBalls--;\n        probability *= (double)(totalRed) / totalBalls;\n    }\n    \n    return probability;\n}\n'),(1172,'Apply Quick sort on a given sequence 7 11 14 6 9 4 3 12. What is the sequence after the first phase, pivot is the first element?','medium','text','6 4 3 7 11 9 14 12','6 3 4 7 9 14 11 12','7 6 14 11 9 4 3 12','7 6 4 3 9 14 11 12','2','ds',NULL,NULL),(1173,'Below c++ code print numbers from 1 to 1000 which are both palindrome and prime number (ex:131 is palindrome and prime number). There are two functions, function isPrime() checks if the number is prime or not, function isPalindrome() checks if the number is palindrome or not. The code is incomplete, What should be added in place of /* Complete the code */so that the code runs perfectly fine.','medium','snippet','remainder = tempNum % 10; reversedNum = reversedNum * 10 + remainder;\ntempNum /= 10;','remainder = tempNum % 2;\nreversedNum = reversedNum * 2 + remainder;\ntempNum /= 2;','remainder = tempNum / 10;\nreversedNum = reversedNum * 10 + remainder;\ntempNum %= 10;','remainder = tempNum % 10;\nreversedNum = reversedNum * 10 + remainder;','1','ds',NULL,'bool isPrime(int num) {\n    if (num <= 1) {\n        return false;\n    }\n    \n    int sqrtNum = sqrt(num);\n    \n    for (int i = 2; i <= sqrtNum; ++i) {\n        if (num % i == 0) {\n            return false;\n        }\n    }\n    \n    return true;\n}\n\n\nbool isPalindrome(int num) {\n    int reversedNum = 0;\n    int tempNum = num;\n    int remainder;\n    \n\n\nwhile (tempNum > 0) {\n         /* Complete the code */\n    }\n    \n    return (num == reversedNum);\n}\n\n\nint main() {\n    for (int num = 1; num <= 1000; ++num) {\n        if (isPrime(num) && isPalindrome(num)) {\n            cout << num << endl;\n        }\n    }\n\n\n    return 0;\n}\n\n\n'),(1174,'Given N number of chalk pieces, you are allowed to use one chalk piece per day, when the size of a chalk piece becomes 1/SQRT(N) you are not allowed to use that chalk. Every day the size of 1/SQRT(n) will be left over in a chalk after use. The leftover chalk (1/SQRT(N)) can be combined and you can make new chalk out of this. This process will be continued until all the chalk pieces are getting used. Calculate the number of days taken for all the chalk pieces getting used.\nGiven No of chalk pieces(N): 16\n','medium','text','22','20','21','16','3','logical',NULL,NULL),(1175,'Total how many iterations are required to find the sum of elements in a given range of (l,r) in an array of size n when we use square root optimization?\n','hard','text','SQRT(n)','2*SQRT(n)','3*SQRT(n)','n*SQRT(n)','3','ds',NULL,NULL),(1176,'Four people, (A, B, C, and D) need to get across a river, and there is only one boat. The boat can only hold two people at a time. A takes one minute to cross, B two minutes, C five minutes, and D ten minutes, Boat will only go as fast as the slowest person in the boat(Ex if A,D goes together. Boat will take 10 min to cross the river ). What is the shortest time for all 4 people to cross the river? ','medium','text','17 mins','18 mins','16 mins','20 mins','1','logical',NULL,NULL),(1177,'You have a pile of 3,000 bananas. You wish to transport them to a place 1,000Kms away on the back of a camel; however, the camel can only carry a maximum of 1,000 bananas, and will eat one banana every KM it travels (and will not go anywhere if it does not have any bananas). However, you can load and unload as many bananas as you want anywhere. What are the most bananas you can bring over to your destination? ','medium','text','2000','1000','533','627','3','logical',NULL,NULL),(1178,'Initially, 100 bulbs are turned off. There are 100 rounds. Round 1: turn on all the bulbs. Round 2: toggle all the bulbs that are multiples of 2 (2,4,6...), Round 3: toggle all the bulbs that are multiples of 3 (3,6,9..). Likewise continue till 100 rounds, In Round100 only the 100th bulb will be toggled \nNote:Toggle means that if any bulb is turned on, it should be turned off, and if any bulb is turned off, it should be turned on.(ON->OFF, OFF->ON)\nWhat is the total number of bulbs that turned on after the 100th round\n','medium','text','25','50','10','15','3','logical',NULL,NULL),(1179,'You are given a rod of length 5 and the profit of each length are given in table:\n\n\nWhat is the maximum profit that you can get after cutting the rod and selling the pieces?\n','medium','text','13','12','14','15','3','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1179.png',NULL),(1180,' Consider a mathematical puzzle where we have three rods (A, B, and C) and 4 disks(D1,D2,D3 and D4). Initially, all the disks are stacked in decreasing value of diameter (D1 on top )i.e., the smallest disk is placed on the top and they are on rod A. The objective of the puzzle is to move the entire stack to another rod (either B or C)\n\nObeying the following simple rules: \nOnly one disk can be moved at a time.\nEach move consists of taking the upper disk from one of the stacks and placing it on top of another stack i.e. a disk can only be moved if it is the uppermost disk on a stack.\nNo disk may be placed on top of a smaller disk\n\n\nWhat is the total number of moves  to be held to move all the disks from one rod to another.\n','medium','text','16','14','13','15','4','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1180.png',NULL),(1181,'Given a graph which of the following is not a Hamiltonian cycle:\n','medium','text','[1,2,3,4,5,6,1]','[1,2,6,5,4,3,1]','[1,6,2,5,4,3,1]','[1,3,2,5,6,2,1]','4','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1181.png',NULL),(1182,'Consider a directed graph with 4 vertices labeled A, B, C and D. Which of the following formulas will help finding the shortest path distances between all pairs of vertices in the graph (Floyd-Warshall algorithm).','medium','text','A[i,j]=min{A[i,j],A[i,k]+A[k,j]}','A[i,j]=min{A[i,k],A[i,j]+A[k,j]}','A[i,j]=min{A[i,j],A[i,j]+A[k,j]}','A[i,j]=min{A[i,k],A[i,k]+A[k,j]}','1','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1182.png',NULL),(1183,'There are 13 caves arranged in a circle. There is a thief  in one of the caves. Each day the thief can move to any one of adjacent caves or can stay in the same cave in which he was staying the previous day. And each day, cops are allowed to enter any two caves of their choice.\n\n\nWhat is the minimum number of days to guarantee in which cops can catch the thief?\n','medium','text','13','12','11','10','2','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1183.png',NULL),(1184,'Below C++ code finds the loop in a linked list,A loop in a linked list occurs when any node points to a previously visited node \nfor example: 1 2 3 4 3 (3->4->3 makes a loop).\nWhich of the following inputs will have no loop.\n','medium','text','[1,2,3,4,5,7,8,3,5]','[1,2,3,4,3,7,4,3,5]','[10,18,17,16,15,19,16,18,15,16,19]','[10,18,17,16,18,19,10]','4','ds',NULL,'void hasCycle() {\n    struct Node *slow = head;\n    struct Node *fast = head;\n    int flag=0;\n    while (fast != nullptr && fast->next != nullptr) {\n        slow = slow->next;\n        fast = fast->next->next;\n        if (slow->data==fast->data) {\n            cout<<\"loop detected from: \"<<slow->data<<\"to \"<<fast->data<<endl;\n            flag=1;\n        }\n    }\n    if(flag==0)\n        cout<<\"No loop detected\"<<endl;\n\n}\n'),(1185,'Which of the following combination gives minimum number of multiplication\n(calculate using dynamic programming)\nGiven an Arr={1,2,3,4,5} which indicates the indices of matrix \n','hard','text',' (A*B)*(C*D)','(((A*B)*C)*D)','(A*(B*(C*D)))','None of the above','2','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1185.png',NULL),(1186,'Below code finds the Kth smallest number in the binary search tree. But the code contains small logical faults that prevent it from producing the required results. To obtain the output, correct the code','medium','text','if (count != k) should be changed to if (count == k) ','if (count != k) should be changed to if (count > k)','if (count != k) should be changed to if (count < k)','if (count != k) should be changed to if (count >=k)   ','1','ds',NULL,'int findKthSmallest(TreeNode* root, int k) {\n    stack<TreeNode*> stack;\n    TreeNode* current = root;\n    int count = 0;\n\n    while (current != nullptr || !stack.empty()) {\n        while (current != nullptr) {\n            stack.push(current);\n            current = current->left;\n        }\n\n        current = stack.top();\n        stack.pop();\n        count++;\n\n        if (count != k) {                 /* error */\n            return current->val;\n        }\n\n        current = current->right;\n    }\n\n    return -1; \n}\n'),(1187,'Consider an AVL tree with the following values inserted in the given order: 7, 3, 10, 5, 15, 12, 20. After performing the necessary rotations to maintain the AVL tree balance, what will be the maximum number of rotations performed?\n','medium','text','1','2','3','4','2','ds',NULL,NULL),(1188,'Consider a hash table that uses chaining with linked lists to resolve collisions. The hash table has a size of 11 and uses a hash function h(x)=key%N (N is the size of hash table)that maps keys to indices in the range of 0 to 10.\nSuppose we have a set of 7 distinct keys that are inserted into the hash table. The keys are hashed and stored in the table using chaining. Each slot in the hash table can hold multiple elements through linked lists. determine the number of linked lists present in the hash table.\nKeys: 14, 23, 37, 42, 55, 61, 77\n','easy','text','4','6','5','3','3','ds',NULL,NULL),(1189,'Given an undirected weighted graph, apply Prim\'s algorithm to find the minimum spanning tree. The minimum spanning tree is a subset of the graph\'s edges that connects all vertices with the minimum total weight.','medium','text','22','21','32','23','4','ds','https://cdm-campus.s3.ap-southeast-1.amazonaws.com/questions/1189.png',NULL),(1192,'Given array elements [3, 2, 4, 5, 7, 8] What is the functionality of the below code','medium','text','Checks given array is non-decreasing order','Checks given array is non-Increasing order','Checks given array is unsorted order','Checks given array is empty after performing stack operations','1','ds',NULL,'bool function(vector<int>& sequence) {\n    int n = sequence.size();\n    int count = 0;\n    stack<int> stk;\n\n\n    for (int i = 0; i < n; i++) {\n        while (!stk.empty() && stk.top() > sequence[i]) {\n            stk.pop();\n            count++;\n            if (count > 1) {\n                return false;\n            }\n        }\n        stk.push(sequence[i]);\n    }\n\n\n    return true;\n}\n'),(1193,'You are given a queue of characters representing the instructions for a robot. The robot can move forward (\'F\') or turn around (\'T\'). The initial position of the robot is facing right and position with coordinates (0,0). Your task is to determine the final position and direction of the robot after executing all the instructions.\n\nHint:Create variables to keep track of the current position (X, Y coordinates) and the current direction (right, left, up, down). Initialize these variables accordingly. If the instruction is \'F\', update the position based on the current direction. If the instruction is \'T\', update the direction based on the current position and the turning rules  right -> down -> left -> up -> right(Eg:if the current direction is right, instruction T is given, it will turn down). For instruction \'T\' the robot should only turn around in the same position, but it should not move.\nInstruction:[F, T, F, F, T, T, F, F, F]\n','easy','text','Position :(-1,3) direction:UP','Position :(1,1) direction:UP','Position :(-1,-1) direction:LEFT','Position :(1,1) direction:DOWN','2','ds',NULL,NULL);
/*!40000 ALTER TABLE `Mcqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Results`
--

DROP TABLE IF EXISTS `Results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Results` (
  `driveId` int NOT NULL,
  `round` int NOT NULL,
  `score` int NOT NULL DEFAULT '0',
  `candidateId` int NOT NULL,
  PRIMARY KEY (`driveId`,`candidateId`,`round`),
  KEY `Results_candidateId_fkey` (`candidateId`),
  KEY `Results_round_driveId_fkey` (`round`,`driveId`),
  CONSTRAINT `Results_candidateId_fkey` FOREIGN KEY (`candidateId`) REFERENCES `candidate_details_college` (`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Results_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Results_round_driveId_fkey` FOREIGN KEY (`round`, `driveId`) REFERENCES `round_details` (`round`, `driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Results`
--

LOCK TABLES `Results` WRITE;
/*!40000 ALTER TABLE `Results` DISABLE KEYS */;
INSERT INTO `Results` VALUES (7,1,0,10),(7,1,0,43),(15,1,1,116),(16,1,0,145);
/*!40000 ALTER TABLE `Results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('00343789-90b0-434f-93bc-24b1f9754eae','1ee5859c2ebc03c337e678417b1f0adb3c64aa4aae60dd5fc4c18c568ce6162a','2023-07-31 10:57:04.572','20230727101455_modified_feedback',NULL,NULL,'2023-07-31 10:57:04.561',1),('02ce2759-81b7-4f78-b64a-a356bd3249be','804e347b1697c327fe60e51fe946a9fd9acc66543326e20a74cbb082184de062','2023-07-31 10:57:04.246','20230717104127_updated_results_table',NULL,NULL,'2023-07-31 10:57:04.227',1),('03cc0fd2-f1dc-4159-a7b8-7a1f5b091ab7','6f7d59abc3d944f59a84320042a0962b560357e3e72b715acca9096824252868','2023-07-31 10:57:03.445','20230711132511_added_unique_student_idin_candidate_tracking',NULL,NULL,'2023-07-31 10:57:03.432',1),('04546eeb-d652-4da6-a358-c50404deb33c','5876d769eb048f82cd08589ef658515c242f8e459d6278632744cfed089f4463','2023-07-31 10:57:04.430','20230720064053_modified_admin_credentials',NULL,NULL,'2023-07-31 10:57:04.414',1),('06498b4f-7205-4af2-b4ad-96a8d91cdd14','723d6d1303402b0fc9b068b50984e7abeb6d1327953c5c088f0a9eb9f6bb9b44','2023-07-31 10:57:04.200','20230717100253_modified_round_table',NULL,NULL,'2023-07-31 10:57:04.138',1),('0656e6c0-73c9-413f-b0ed-f3937040570b','0eeccf23d1a1e76110443ccc5c8fb2f64925f7bca1926f21625fe1d934c9bf3b','2023-07-31 10:57:02.660','20230705123916_added_department_major',NULL,NULL,'2023-07-31 10:57:02.541',1),('091484d1-dbd7-4862-b01b-0a667aab4132','f133c9792a9a343853f69064cdaa7bb9f235d1dcd6532243472c47c2d06a94da','2023-07-31 10:57:05.435','20230731051725_modifiedcandidate_questionid_string',NULL,NULL,'2023-07-31 10:57:05.407',1),('0a969869-d32d-4a3b-b608-09f831123f51','cc6bea8d003d4f70b97082da95ad6afd0d030769c12296455c87d7105de57578','2023-07-31 10:57:04.560','20230724103256_modified_round_privileges',NULL,NULL,'2023-07-31 10:57:04.549',1),('0c3a2fd9-70cc-4129-b6c2-1f3ebbc9606b','ea90aa51ae85e965eea488dcb4e8bf94ca29b2931bf8463fea42f314631a81ed','2023-07-31 10:57:04.955','20230729173432_modified_names',NULL,NULL,'2023-07-31 10:57:04.805',1),('0d27b13c-0206-4acf-b333-080d8f32022a','c2f48b3f2b54b3352661686ff1c91dc8a82d22b9befe4951b35f3ffadf37c5bc','2023-07-31 10:57:04.996','20230729174112_modified_round_privileges',NULL,NULL,'2023-07-31 10:57:04.968',1),('0e556889-b9cc-47e2-92e2-9e862c20426c','57f17f3b5d6e986af94f6600dd291db396733154283e4c3fa05a2cc40318bcbc','2023-07-31 10:57:02.965','20230706100909_candidate_details_college_updated',NULL,NULL,'2023-07-31 10:57:02.883',1),('1d6aa608-233a-4ccd-9a4a-f2a6af0751c4','8c29bfcfe619104140923472bc898a16e4869d8b6b7703520c18d27acf0bfe3d','2023-07-31 10:57:04.803','20230729165716_modfied_drive_table',NULL,NULL,'2023-07-31 10:57:04.772',1),('1dbde771-e787-433d-969c-41eaa64e7a0c','fa345a919234bdc6530b4c2c2e42eb132273a50353f525b0a735f02dade67c88','2023-07-31 10:57:04.728','20230728115618_recruitment_team',NULL,NULL,'2023-07-31 10:57:04.712',1),('249427e1-0ae3-48d4-9103-87e6bf8dfb9f','92ae942084c9543bb094557027faa680237cb9790483a552b2444107c03c8aa2','2023-07-31 10:57:02.986','20230706102158_added_drive_status',NULL,NULL,'2023-07-31 10:57:02.967',1),('259266e9-ed22-40dd-83df-50845b8d8015','859ca4bd0fc5dadb43573a0b5c97fdee93262c91bc22bbbb103d3c683106ad3d','2023-07-31 10:57:04.226','20230717100549_modified_r_ounds',NULL,NULL,'2023-07-31 10:57:04.201',1),('27553a56-8d16-4fbf-a7e6-56931d70be7d','568b695458eb4e00ac17dd17d592f960327cb9b81f5c7a46ba5c9b094a85a557','2023-07-31 10:57:04.110','20230713183756_changed_model_name',NULL,NULL,'2023-07-31 10:57:04.034',1),('2835a984-37e1-4497-b039-5bc3469019a2','6e0390bd084679c5a747b686da9d6385c6d751fe99062395a245ccf65fb151dd','2023-07-31 10:57:02.424','20230703173954_roundprivilege',NULL,NULL,'2023-07-31 10:57:02.244',1),('2875d2b6-420d-4918-b2db-3bf20c9c67bf','9dfafdf3646096bebed5fc263981566f53b201d2358447ec16d5c2f717324052','2023-07-31 10:57:03.591','20230713053942_question_set_model_added',NULL,NULL,'2023-07-31 10:57:03.513',1),('28ee687e-e27a-43d7-abd9-17672467a244','64173d60931f83fe576d529dd9934a8c31d477042bec5daf556b0a8aae7a1986','2023-07-31 10:57:05.524','20230731070406_candidate_trackingunique_error_drive_id',NULL,NULL,'2023-07-31 10:57:05.504',1),('293680d7-9b50-47f1-9a83-82a3df87ce69','b83d07e1766f19dc10ec6295745b9ee1dab0e6caac3f5bc8130d9b3b4b1c5553','2023-07-31 10:57:05.056','20230729174442_added_round_privileges',NULL,NULL,'2023-07-31 10:57:05.017',1),('2a03414d-4e3c-406c-ba5a-19ce9f5f39ea','8db39ea9da0fbe978f0a844d863176a4b4c0248b92b5ef3f8020797a0989e158','2023-07-31 10:57:03.719','20230713091632_compositeidkeyquestionset',NULL,NULL,'2023-07-31 10:57:03.699',1),('311ee2e5-3c06-45bb-b487-6ac0e8d08bd5','2135f7e4f5b5af473b5b414e5830fe809ceba41b70ba63b94fe0dd4e3a9809ee','2023-07-31 10:57:03.137','20230709162120_unique_drive_id_rounds',NULL,NULL,'2023-07-31 10:57:03.122',1),('3409ca6a-6b2e-45f8-861a-b4a316804540','990f3bc5403840e0e1cfdc7ef861ea2b13be2a1920651bcc04497721677282d5','2023-07-31 10:57:05.353','20230730153647_modified_candidate_question_set',NULL,NULL,'2023-07-31 10:57:05.324',1),('3642d768-caa4-4aad-8dc1-cf5284dbd24d','d0e02b6af4ed8027d53c7bb3fa90ce8fcffb52e5ac0a5d7d9fd28534f08b1006','2023-07-31 10:57:03.768','20230713091917_compositekeycandidatedetilscollege',NULL,NULL,'2023-07-31 10:57:03.721',1),('38cf4edf-0af3-4b8a-99c7-299ae2275b97','65f2e92ac2fa874315060b8fd96c6cfe7c14bfa7147e39b8f0f2672d77a8c9bf','2023-07-31 10:57:05.015','20230729174332_removedround_privilegesduetoerrorandadded',NULL,NULL,'2023-07-31 10:57:04.998',1),('3daa58d6-5850-4faf-b265-70165e18fe53','33bb59bb1ddd4bc0b5f148c51682d7464bcd9e09432a69e0bdb06ce8ca7b854b','2023-07-31 10:57:02.460','20230703182106_',NULL,NULL,'2023-07-31 10:57:02.446',1),('3e5699ec-e1db-4830-b939-89f5153a2cc8','dc8e3351c259ec847e0680c4def10bd8ed40e36cbf75d54157f361b810cde097','2023-07-31 10:57:05.405','20230731043230_modifiedcandidate_question_setid_int',NULL,NULL,'2023-07-31 10:57:05.377',1),('410a64f3-de07-449b-a50b-fcbfae1ec121','9872daa3ac338a858e34f6943131978e7e3bab980de5395ecf6ca8fa5238079f','2023-07-31 10:57:03.378','20230710121139_modified_login_attemptsduration_takento_optional',NULL,NULL,'2023-07-31 10:57:03.354',1),('4406a8e1-af8a-4291-9c0b-f389b296fc83','490649941d5c25f4e4b4d56e8b8439865f7c4a4fe6baa82e2f08eba1060bc54d','2023-07-31 10:57:02.243','20230703162119_campus_insertion',NULL,NULL,'2023-07-31 10:57:02.201',1),('4bcef292-91c6-4b45-abe1-2d9fa6e595fd','8ed3ec20b05333c50a0412e59efe99124510186eb00b8abfec1ae75e8e745739','2023-07-31 10:57:04.617','20230728054252_addedjob_roles_modified_feedback',NULL,NULL,'2023-07-31 10:57:04.573',1),('55b4447d-20f8-40cd-9695-7bea6e7d691a','004993ce867ad6e58931b875d55f647083c03f29caf0ef919fed6d3dc3a69b76','2023-07-31 10:57:04.536','20230724070650_added_submit_test',NULL,NULL,'2023-07-31 10:57:04.478',1),('58dd8944-1141-4c23-a484-0bb93077e918','fabe6ea3f7052412b1406ff16651be72a675eae46b76509bf7958204276b7ff7','2023-07-31 10:57:03.697','20230713063705_addedquestion_id_unique',NULL,NULL,'2023-07-31 10:57:03.685',1),('5a304f10-7e52-496b-8ab5-b260d09c141e','4527ab82425ac9e0c230e70153433ae444097c9e4f9c9c8448ffd0b1ccf29323','2023-07-31 10:57:04.273','20230717130242_modified_results',NULL,NULL,'2023-07-31 10:57:04.248',1),('5ad8e411-45d8-4674-8366-99e81f37a40e','b2df6fdd07a51e664bc00a6ea95d996d9d7a8a97706fb157800f3a292cc16509','2023-07-31 10:57:03.078','20230709075510_unique_drive_idround_privilege',NULL,NULL,'2023-07-31 10:57:03.067',1),('5afafdea-beed-450b-8efa-b2a9879b4eec','04d236fe73529a5d23d667e89fae6fea49c80d233db123c6cddaaf49116d2ea9','2023-07-31 10:57:03.940','20230713115301_removedidcolumnincandidatequestionset',NULL,NULL,'2023-07-31 10:57:03.923',1),('6322b2fd-169d-4f5e-b46d-7fdd8b00dbea','549e66c6ee8cf81617ebcf776bcd4e7a6792092281da80021a1fea4e1ad4a3c0','2023-07-31 10:57:03.091','20230709154328_added_rounds',NULL,NULL,'2023-07-31 10:57:03.080',1),('641f394a-23f2-417b-b865-0b5ed83d02fc','4d17d0ac4a171e7b3d6adcfe28f52ad57a513216b73617aebdfc290323c20808','2023-07-31 10:57:03.276','20230710085626_added_candidate_tracking',NULL,NULL,'2023-07-31 10:57:03.198',1),('64e8ebb1-e965-4645-9698-d6777db0c7e4','eee6f172ddf7298bd197cea17bf19204533c56f8693527ed3815a9a3b758cb26','2023-07-31 10:57:05.502','20230731065916_candidate_tracking_round_primaryadded',NULL,NULL,'2023-07-31 10:57:05.480',1),('667b6728-756c-4d49-bced-71d7d82d7f9a','a14ea39a44388095c7f8364ef681ba5284cc6bebfd98be5fdc2e5593081e5aac','2023-07-31 10:57:04.633','20230728080438_uniqueid_campus',NULL,NULL,'2023-07-31 10:57:04.618',1),('66be1060-5c20-4324-8d0f-fc1f230d1393','998d22afc0796a4e478fafbbb0f969052307c4b16295c0198ca427022f431c80','2023-07-31 10:57:02.485','20230704184039_reverted_unique_changes',NULL,NULL,'2023-07-31 10:57:02.476',1),('6c4f8bde-5821-4e30-a625-6d7af31e98fc','dd7f1b655873adf1e9428952f5914a645ebbc3121d02faac854ebed8a1d1f4a3','2023-07-31 10:57:05.129','20230729182627_modifiedcampus',NULL,NULL,'2023-07-31 10:57:05.113',1),('6f2c34d5-3046-4fcd-88d4-a525f3b902b4','7c3fa4c1c77632a992728f1abb28896bf159e62b484b27a924271583cb0787db','2023-07-31 10:57:05.152','20230729192644_added_round_question_set',NULL,NULL,'2023-07-31 10:57:05.131',1),('6fc033e3-22a3-4fce-b534-bd1cc824b579','15fbeaa40eb03ce7684ae722a2f66833b9ae8bdeb532895c6fa71c6aef3e16a2','2023-07-31 10:57:02.540','20230705121311_added_departments_subdepartments',NULL,NULL,'2023-07-31 10:57:02.487',1),('71ed3cad-3227-4eb5-b6b2-ce4c154f98c6','b84b23b2f23d89d3670b945fc5613a356a439149bdb738d5c8d393ffed2cdcef','2023-07-31 10:57:03.921','20230713112454_candidate_questionset',NULL,NULL,'2023-07-31 10:57:03.900',1),('7431137b-ed69-4785-99fd-ebb4605e7c98','5e0abe2195f804ec2eb0cec7fe456aae799bddf7b1f8ed283422e0de1440f88f','2023-07-31 10:57:03.512','20230712133756_added_topics_difficultyin_rounds',NULL,NULL,'2023-07-31 10:57:03.500',1),('74eb3a44-995c-4d41-89c8-c1c231fdb3c4','b36e7c3d7f691acfbe048d9221c831bf83acaec5bcf48eb06e03aa18818aba04','2023-07-31 10:57:03.065','20230709075352_changed_r_oundprivilege_name',NULL,NULL,'2023-07-31 10:57:03.021',1),('7574bdfc-25c3-4f4a-8382-0cbd1bd1b16b','3252eb65bfe9abba9a5b656de5c65928b0889eb81b67977b22230776b9fa6a52','2023-07-31 10:57:04.357','20230718052652_modified_results',NULL,NULL,'2023-07-31 10:57:04.309',1),('76722638-4286-47b9-95e7-20fe8fdc3a08','d38bd1a32f4f0b652ea76885772b48c904c12ba39e4837d7a1dca58b0d242b9e','2023-07-31 10:57:05.112','20230729175408_added_rounds',NULL,NULL,'2023-07-31 10:57:05.077',1),('7a01c32f-4952-4a29-bbea-84a7cf141809','eba9d527af4a64a6079c85e2332f79fad5bd17226d63f07cf6ba4e2afa4c4bdd','2023-07-31 10:57:03.197','20230709162246_round_detailsnamemodified',NULL,NULL,'2023-07-31 10:57:03.139',1),('7da723c1-ef00-4576-b4cf-8da4b512e475','e8c6ad534ba49a4e272fb91639c76e42ec33ece01daf2ba3b5fc0b4d9122a436','2023-07-31 10:57:03.352','20230710115017_mcqquestiondbvarchar_1024',NULL,NULL,'2023-07-31 10:57:03.338',1),('7db248f1-8227-4145-b20a-5223dd70b354','008d92619516671414ef67d9354a8b9e3247ad7db3bca8479320cab02ac89e1c','2023-07-31 10:57:03.498','20230712103803_deleted_candidate_details_oldtable',NULL,NULL,'2023-07-31 10:57:03.483',1),('7e7076ba-a99b-4b80-9d72-2c2a4dee6b6b','29394d326206782608e584a6be545020c392097a3b4dbab77291edc9e030e335','2023-07-31 10:57:01.931','20230702153840_mcq_model',NULL,NULL,'2023-07-31 10:57:01.920',1),('7f038bf8-f20a-4dae-aded-f043823b3b0e','25a24fec0d2af5d0b67226d322edb994f2c8797775a26efde7f27b98f691c7ea','2023-07-31 10:57:05.587','20230731070459_added_candidate_tracking',NULL,NULL,'2023-07-31 10:57:05.526',1),('84dc2353-6257-437e-991b-49ece053430c','3cfedfd445c90b85d6814a5f4088aed0bbe3d7326dbdeeebb301584daf72e35b','2023-07-31 10:57:03.020','20230709072108_modified_mobilenoin_candidate_collge',NULL,NULL,'2023-07-31 10:57:02.988',1),('87a5287f-f189-446d-b90b-e9c30540a224','d1cf0e850c6bbff3bad61e5f9fc6b9408733b50e78c1f6c5e5f31feda676b8ed','2023-07-31 10:57:04.287','20230718044359_round_in_answers',NULL,NULL,'2023-07-31 10:57:04.275',1),('89f6b333-d7d8-417a-9ea5-b1cec7b07820','dd729684fe9a1bc5eee2fe69c8f55d8630d5b266b43d3f86bcfcd245b1a0c63a','2023-07-31 10:57:04.771','20230728120134_added_recruitment_team',NULL,NULL,'2023-07-31 10:57:04.729',1),('8d93d6cc-e5c2-478a-ab6b-63eeb8b8a47d','640866dcc95f1b2ef602a73ac355895bd4b6fb4a7b6a36768a9c51ba91207159','2023-07-31 10:57:03.419','20230711094522_removed_skip_questions',NULL,NULL,'2023-07-31 10:57:03.407',1),('8dbee398-786e-417b-9cf9-74932ebe38c4','a1559d41d67314b3385121bef434eda57726a9c6e7fbddf8afd150523114a183','2023-07-31 10:57:03.684','20230713055315_added_student_question_adminquestion_set',NULL,NULL,'2023-07-31 10:57:03.593',1),('988c3fd7-ed1a-4cea-acc9-e94a45484522','db4e1b43433299dfc6887cd78ef1c28dcfd5222ebaee406e257fa932d4b7fd47','2023-07-31 10:57:03.431','20230711113329_changed_primary_keyto_student_idin_candidate_tracking',NULL,NULL,'2023-07-31 10:57:03.420',1),('992a4643-2b7e-433f-89e0-f173985c9f1c','0c636b6494207ea91dde8f19d67ea285a0786226cebfabe02a1087796e4808e6','2023-07-31 10:57:01.951','20230702163555_mcqs_model',NULL,NULL,'2023-07-31 10:57:01.933',1),('9f79ee4e-13a8-415b-b5bf-8846b832a559','66079715673e9d8ba6f4d52e306452c4e8c1426604af2171c41da6156565fa6d','2023-07-31 10:57:04.413','20230720063645_added_admin_credentials',NULL,NULL,'2023-07-31 10:57:04.401',1),('a3841343-b732-4593-9eec-5fb18b6d0850','152087c9d825fbb8b5b6e1693922648e42fb2b74cae3e03113c13a53b048eb1f','2023-07-31 10:57:04.400','20230718094231_modified_results_table',NULL,NULL,'2023-07-31 10:57:04.380',1),('a882e397-4dd0-42cb-a190-952601e68c8b','b8ab73e4458b4346618135a23ae7dc7e45ff6694e1296e2b8f92a508eb47b42b','2023-07-31 10:57:01.960','20230702164517_mcqs_model_answer',NULL,NULL,'2023-07-31 10:57:01.952',1),('aecaf38f-847d-40f4-a636-f96e8eba5eac','6166f4e83327996a4b3c83a8e2bd75c3b881f1052eed43d24e9ea3bd2f0fc3db','2023-07-31 10:57:05.376','20230730154202_modified_candiate_question_set',NULL,NULL,'2023-07-31 10:57:05.354',1),('af7a87ec-da2e-47d9-89f5-e495165f1c05','65acac6f526f1b0f9180a2e4ca08be6c38864252a4d69e2c4d127947260e4287','2023-07-31 10:57:04.477','20230724065232_modified_results',NULL,NULL,'2023-07-31 10:57:04.465',1),('b8e0dc4a-f189-4069-986c-60d92274f2f8','f33b5ace3b139ddb7b354968aede3a3be4c2510a0e607012e72a4f1cdae85b46','2023-07-31 10:57:03.899','20230713102255_student_idcompositekeycandiate_questionset',NULL,NULL,'2023-07-31 10:57:03.877',1),('bdb36b47-e60e-4555-901a-55956af05284','b70b3094682bc57459227cc51e617f917c69fa0aea87a49c4dda6da782298f54','2023-07-31 10:57:02.105','20230703090948_campus_added',NULL,NULL,'2023-07-31 10:57:02.024',1),('c003d0b8-d0f9-4670-a58b-d35e915ff0f5','0fcc7968349c7322a45582b7904a49ac27027f073cfe3b96fa12fb8827b00e85','2023-07-31 10:57:03.482','20230712103700_deleted_departments',NULL,NULL,'2023-07-31 10:57:03.446',1),('c37208a7-5343-4c9e-8a8c-5b8eb57ca7cd','faa7ea310dfa3d3fdfc811c66036b5ef43d668db277fedc38c922bb57f390113','2023-07-31 10:57:02.445','20230703174242_college',NULL,NULL,'2023-07-31 10:57:02.425',1),('c39a166b-a65c-4cf5-b413-251c323e1c8f','7ea469ea3b73e5a86d2621fee01c9aa600af3e36486f48a628373f0babeba20a','2023-07-31 10:57:02.475','20230704183324_unique_email_drive_id',NULL,NULL,'2023-07-31 10:57:02.461',1),('c924667a-ee32-4805-bf25-85f895b8c743','c72f11aa9e392c41c744d3b7bb099b1acb656780c6c1cdbef84bbcf5b85fdabe','2023-07-31 10:57:04.464','20230721045218_added_feedback',NULL,NULL,'2023-07-31 10:57:04.431',1),('cbfbd865-07c8-46e7-a03c-a2a1d50416e2','e803b19b618534674d027ae3d0b054ba25333e2a369a228d23bed90fd2fb8487','2023-07-31 10:57:03.876','20230713102048_changedcandidate_questionsettablename',NULL,NULL,'2023-07-31 10:57:03.769',1),('ce72ec79-b4fe-49fd-8c00-ced9dda35e0d','07e935caa4a85dbabd96ed194f6e353df4b75ee4791ccb17fef542cb06c0d1a3','2023-07-31 14:56:18.908','20230731145618_round_status_rounds',NULL,NULL,'2023-07-31 14:56:18.895',1),('ced941bc-b3c2-45f2-9773-6697a2597276','a37098b25f62a47119bb116389acd70b69a7cb803d62972a3845050b6d900de4','2023-07-31 10:57:04.308','20230718050240_modified_results_table',NULL,NULL,'2023-07-31 10:57:04.289',1),('cfd7c75d-72be-4a04-a2f5-80f82659d511','ddec6a7ae91c611836bf9449b689abb8ec80a5f1f6232efbfc2301eddc092069','2023-07-31 10:57:04.966','20230729173746_modified_r_ound_privileges',NULL,NULL,'2023-07-31 10:57:04.956',1),('d03e8c26-452e-4ffe-a914-09656b41530e','b2ca20260a953b247d5aa6d16906a90e31f37845c4dcd4ef05b9e984275469a4','2023-07-31 10:57:03.405','20230710121951_modified_start_time_date_timeto_stringin_candidate_tracking',NULL,NULL,'2023-07-31 10:57:03.379',1),('d1313b98-5d6e-4849-9f46-726763da3003','9d7cafbeb816bfb92f8fc08b316b4d7a3ca3d308b8c705ef3d5ce5cd29b23900','2023-07-31 10:57:02.881','20230706100141_added_campus_college_details',NULL,NULL,'2023-07-31 10:57:02.777',1),('d559273d-cd1c-48ed-a995-48a71cde69f8','50de0b0f5e37a52f077c20939452bd06dd558ee8e6b12fa7d0d4e47ed31558b2','2023-07-31 10:57:04.711','20230728105350_removedrecteammemberstable',NULL,NULL,'2023-07-31 10:57:04.673',1),('d580a05e-3db6-43f6-b074-4bd92b0d33f0','6ad64bac8d03fb5a67f75fdbd76096870b81711224f1fd5a48b21363f111cc0e','2023-07-31 10:57:05.323','20230729201215_added_question_set',NULL,NULL,'2023-07-31 10:57:05.203',1),('d5ba597d-f190-4e0a-84dd-601b4558f80b','e6eda4a33a8faffea13de44c8c19ff5009130088847bebb4249269bb3638a784','2023-07-31 10:57:02.200','20230703091115_updated_campus',NULL,NULL,'2023-07-31 10:57:02.107',1),('d6507ac1-ed86-4f47-887e-f97e7cb244bb','02d856ad8082abb405299d5c11b4f759dec351fed4cbf2c748d953c7fadbf5b5','2023-07-31 10:57:03.954','20230713131610_candidate_question_set',NULL,NULL,'2023-07-31 10:57:03.941',1),('dc1f270f-849b-49f0-83ac-e7b0de6a14db','953ca62cc01de1b58786b9fbb3661cf00f6322a2b40f371b11df55c8f5b82937','2023-07-31 10:57:02.022','20230703073650_candiate_details',NULL,NULL,'2023-07-31 10:57:01.962',1),('dc4f227b-b863-4db4-93fa-606107becb7b','9d72c38c0ec511d47a65f6a382be5fcc4c914d6ccc0f886113b6a118cbe06a40','2023-07-31 10:57:04.672','20230728104630_job_role_created',NULL,NULL,'2023-07-31 10:57:04.635',1),('ddaa526c-6b51-4328-ae1a-9621a533e17d','0f89cea256015260ae1ec10a142e94a9dae12d149af2641b67de56f806e36f9c','2023-07-31 10:57:04.137','20230717065915_changed_round_one_duration_taken_candidate_tracking',NULL,NULL,'2023-07-31 10:57:04.111',1),('e1df942d-4808-4d54-b645-3d988a6a4e69','4304d1dab9c227992c9623811c5b697e53143e6e5ae343ad5a574beedabd8105','2023-07-31 10:57:05.464','20230731061153_candidate_question_setid_int_round',NULL,NULL,'2023-07-31 10:57:05.436',1),('e3df78c4-4bcb-4174-ae3d-171f38052842','35845d69731a927ef30e1bbb68ba57d625a4dee82d6d5ca2b0c3f3cb9a101603','2023-07-31 10:57:03.121','20230709160528_modified_rounds',NULL,NULL,'2023-07-31 10:57:03.093',1),('eaba157c-7366-4117-aec4-d26cc01d5f0f','1ead9ddc5764e167c0714e91fdb11219bdb67cd1c45ff0cf351f3f694fce4e07','2023-07-31 10:57:05.076','20230729175217_removed_r_ounds_tableuniqueindexerror',NULL,NULL,'2023-07-31 10:57:05.058',1),('eb58c4f3-a88e-4e81-b51d-3f68c88156b7','8def1872f6277ad375827bc97b31fbc138b0273c7c84a6643d81ac89c425f37d','2023-07-31 10:57:04.379','20230718080340_modified_results',NULL,NULL,'2023-07-31 10:57:04.359',1),('ecdb2870-58e1-4a6b-ac15-fc1f554ae3f4','06eea22976d020f3b1aed4ebd56bea2d046761170fe65fa4694338cbb9803720','2023-07-31 10:57:03.337','20230710114617_modified_mcq_tablesnippetdb_varchar_1024',NULL,NULL,'2023-07-31 10:57:03.278',1),('f17783f8-a6e8-4326-8e9f-01c503db7bc2','d47a11d0a7c12e06e119d29555f3169e825b5211f977dd34babbefc03dd0cedf','2023-07-31 10:57:05.479','20230731063854_added_candidate_tracking_round',NULL,NULL,'2023-07-31 10:57:05.465',1),('f3e68aa7-c94e-4a50-87ad-2e7a5d634f08','64d8bbf94a7e87e51f1d600b6ac14e635084b4d8da3297fac7226c828c96c7f7','2023-07-31 10:57:05.201','20230729201114_modified_question_s_et',NULL,NULL,'2023-07-31 10:57:05.153',1),('f49a3a32-0aa0-42e4-98c8-23e80b97759d','585f06d579fbac92204fce82dfec98a71af749724f229a8a738ed823ff87be32','2023-07-31 10:57:04.548','20230724070739_modifiedsubmit_test',NULL,NULL,'2023-07-31 10:57:04.538',1),('f6e1fdb4-a359-4746-b09c-d554fa8f0589','cda28e1b5d123fa64db3a45e70fb60f3913fb0e174f4fde80b075da252ff6052','2023-07-31 10:57:02.776','20230706094151_new_migration2_jul6',NULL,NULL,'2023-07-31 10:57:02.661',1),('fefd9f48-0e0b-45c0-a9bd-67d90f7abe6f','6804f58a2a99e63f0e10bac4faba342b6c249b0bd4e40a8230b71210d53f765c','2023-07-31 10:57:04.033','20230713183635_candidate_tacking',NULL,NULL,'2023-07-31 10:57:03.956',1),('ff4d682c-347f-489a-bb0e-e2e54d96771e','d0d1b26669c496cb1c55d8c9ec221cfd5a9834ecf9d806aa842c1d444df968f0','2023-07-31 10:57:23.104','20230731105723_addedindexin_roundandresults',NULL,NULL,'2023-07-31 10:57:23.062',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_details`
--

DROP TABLE IF EXISTS `admin_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_details`
--

LOCK TABLES `admin_details` WRITE;
/*!40000 ALTER TABLE `admin_details` DISABLE KEYS */;
INSERT INTO `admin_details` VALUES (1,'sneka.s@codingmart.com');
/*!40000 ALTER TABLE `admin_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campus_details`
--

DROP TABLE IF EXISTS `campus_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campus_details` (
  `id` int NOT NULL,
  `campusYear` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `campus_details_id_key` (`id`),
  UNIQUE KEY `campus_details_campusYear_key` (`campusYear`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campus_details`
--

LOCK TABLES `campus_details` WRITE;
/*!40000 ALTER TABLE `campus_details` DISABLE KEYS */;
INSERT INTO `campus_details` VALUES (1,'2023-2024'),(2,'2024-2025'),(3,'2025-2026'),(4,'2026-2027'),(5,'2027-2028'),(6,'2028-2029'),(7,'2029-2030'),(8,'2030-2031'),(9,'2031-2032'),(10,'2032-2033'),(11,'2033-2034'),(12,'2034-2035');
/*!40000 ALTER TABLE `campus_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidateQuestionSet`
--

DROP TABLE IF EXISTS `candidateQuestionSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidateQuestionSet` (
  `id` int NOT NULL,
  `driveId` int NOT NULL,
  `studentId` int NOT NULL,
  `questionId` int NOT NULL,
  `round` int NOT NULL,
  PRIMARY KEY (`driveId`,`studentId`,`questionId`,`id`,`round`),
  KEY `candidateQuestionSet_questionId_fkey` (`questionId`),
  KEY `candidateQuestionSet_studentId_fkey` (`studentId`),
  CONSTRAINT `candidateQuestionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `candidateQuestionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `candidateQuestionSet_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college` (`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidateQuestionSet`
--

LOCK TABLES `candidateQuestionSet` WRITE;
/*!40000 ALTER TABLE `candidateQuestionSet` DISABLE KEYS */;
INSERT INTO `candidateQuestionSet` VALUES (1,16,116,1007,2),(1,16,145,1007,2),(19,15,116,1008,2),(8,15,116,1009,2),(4,15,116,1010,2),(5,15,116,1011,2),(2,16,116,1012,2),(7,16,145,1012,2),(2,15,116,1014,2),(3,16,116,1014,2),(3,16,145,1014,2),(7,15,116,1015,2),(17,15,116,1020,2),(10,15,116,1022,2),(9,16,116,1022,2),(2,16,145,1022,2),(10,16,116,1024,2),(9,16,145,1024,2),(13,15,116,1032,2),(4,16,116,1032,2),(6,16,145,1032,2),(6,15,116,1035,2),(1,15,116,1037,2),(7,16,116,1040,2),(8,16,145,1040,2),(18,15,116,1042,2),(8,16,116,1042,2),(5,16,145,1042,2),(15,15,116,1043,2),(6,16,116,1043,2),(4,16,145,1043,2),(3,15,116,1048,2),(16,15,116,1049,2),(20,15,116,1050,2),(5,16,116,1052,2),(10,16,145,1052,2),(9,15,116,1053,2),(3,16,145,1058,1),(2,7,10,1060,1),(1,16,145,1060,1),(5,7,10,1064,1),(10,16,145,1069,1),(6,7,10,1071,1),(15,16,145,1078,1),(17,16,145,1086,1),(4,16,145,1091,1),(14,16,145,1095,1),(9,16,145,1103,1),(9,7,10,1111,1),(18,16,145,1111,1),(10,7,10,1112,1),(1,15,116,1121,1),(3,15,118,1121,1),(19,16,145,1126,1),(6,16,145,1129,1),(11,16,145,1131,1),(20,16,145,1134,1),(2,15,116,1135,1),(1,15,118,1135,1),(16,16,145,1145,1),(2,16,145,1147,1),(7,7,10,1162,1),(8,16,145,1162,1),(13,16,145,1163,1),(14,15,116,1165,2),(5,16,145,1167,1),(12,15,116,1168,2),(12,16,145,1171,1),(1,7,10,1174,1),(3,15,116,1175,1),(2,15,118,1175,1),(3,7,10,1178,1),(11,15,116,1178,2),(4,7,10,1180,1),(7,16,145,1184,1),(8,7,10,1189,1);
/*!40000 ALTER TABLE `candidateQuestionSet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_details_college`
--

DROP TABLE IF EXISTS `candidate_details_college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_details_college` (
  `studentId` int NOT NULL AUTO_INCREMENT,
  `registerNumber` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `college` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateOfBirth` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenthPercentage` int NOT NULL,
  `tenthYOP` int NOT NULL,
  `twelthPercentage` int DEFAULT NULL,
  `twelthYOP` int DEFAULT NULL,
  `diplomaPercentage` int DEFAULT NULL,
  `diplomaYOP` int DEFAULT NULL,
  `UG_CGPA` int DEFAULT NULL,
  `UG_YOP` int DEFAULT NULL,
  `PG_CGPA` int DEFAULT NULL,
  `PG_YOP` int DEFAULT NULL,
  `arrearStatus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrearCount` int DEFAULT NULL,
  `mobileNumber` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driveId` int NOT NULL,
  PRIMARY KEY (`driveId`,`studentId`),
  UNIQUE KEY `candidate_details_college_studentId_key` (`studentId`),
  CONSTRAINT `candidate_details_college_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_details_college`
--

LOCK TABLES `candidate_details_college` WRITE;
/*!40000 ALTER TABLE `candidate_details_college` DISABLE KEYS */;
INSERT INTO `candidate_details_college` VALUES (9,'Reg-1','Student 1','College 1','Degree 1','Branch 1','DOB-1','Gender 1',80,2010,85,2012,90,2014,8,2018,9,2020,'Arrear Status 1',0,'1234567890','nisanth@codingmart.com','Address 1',6),(10,'Reg-2','Student 2','College 2','Degree 2','Branch 2','DOB-2','Gender 2',81,2011,86,2013,91,2015,9,2019,10,2021,'Arrear Status 2',1,'1234567891','sneka.s@codingmart.com','Address 2',6),(30,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',7),(31,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',7),(32,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',7),(33,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',7),(34,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',7),(35,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',7),(36,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',7),(37,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',7),(38,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',7),(39,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',7),(40,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',7),(41,'1912127','PRIYADHARSHINI M','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','priyadharshini0182@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',7),(42,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',7),(43,'1912401','Sneka','KSRCT','B.E','EEE','37116','Male',89,2017,NULL,NULL,93,2020,8,2023,NULL,NULL,'NHA',NULL,'7904273681','sneka.s@codingmart.com','1/493,A1,Kongu Nagar, paramathi road, Periyapatti,Namakkal-637002',7),(44,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',7),(45,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',7),(46,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',7),(47,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',7),(48,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',7),(49,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',7),(50,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',7),(51,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',7),(52,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',7),(53,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',7),(54,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',7),(55,'1912127','PRIYADHARSHINI M','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','priyadharshini0182@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',7),(56,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',7),(57,'1912401','Sneka','KSRCT','B.E','EEE','37116','Male',89,2017,NULL,NULL,93,2020,8,2023,NULL,NULL,'NHA',NULL,'7904273681','sneka.s@codingmart.com','1/493,A1,Kongu Nagar, paramathi road, Periyapatti,Namakkal-637002',7),(58,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',7),(59,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',7),(60,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',7),(61,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',7),(62,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',7),(63,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',7),(64,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',7),(65,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',7),(66,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',7),(67,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',7),(68,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',7),(69,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',7),(70,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',7),(71,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',7),(72,'1912127','PRIYADHARSHINI M','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','priyadharshini0182@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',7),(73,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',7),(74,'1912401','Sneka','KSRCT','B.E','EEE','37116','Male',89,2017,NULL,NULL,93,2020,8,2023,NULL,NULL,'NHA',NULL,'7904273681','sneka.s@codingmart.com','1/493,A1,Kongu Nagar, paramathi road, Periyapatti,Namakkal-637002',7),(75,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',7),(76,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',7),(77,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',7),(78,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',7),(79,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',7),(80,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',7),(81,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',7),(82,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',7),(83,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',7),(84,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',7),(85,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',7),(86,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',7),(87,'1912127','PRIYADHARSHINI M','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','priyadharshini0182@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',7),(88,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',7),(89,'1912401','Sneka','KSRCT','B.E','EEE','37116','Male',89,2017,NULL,NULL,93,2020,8,2023,NULL,NULL,'NHA',NULL,'7904273681','sneka.s@codingmart.com','1/493,A1,Kongu Nagar, paramathi road, Periyapatti,Namakkal-637002',7),(90,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',14),(91,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',14),(92,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',14),(93,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',14),(94,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',14),(95,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',14),(96,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',14),(97,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',14),(98,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',14),(99,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',14),(100,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',14),(101,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',14),(102,'1912127','PRIYADHARSHINI M','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','priyadharshini0182@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',14),(103,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',14),(104,'1912401','Sneka','KSRCT','B.E','EEE','37116','Male',89,2017,NULL,NULL,93,2020,8,2023,NULL,NULL,'NHA',NULL,'7904273681','sneka.s@codingmart.com','1/493,A1,Kongu Nagar, paramathi road, Periyapatti,Namakkal-637002',14),(105,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',15),(106,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',15),(107,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',15),(108,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',15),(109,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',15),(110,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',15),(111,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',15),(112,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',15),(113,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',15),(114,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',15),(115,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',15),(116,'1912127','sneka','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','snekasekar333@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',15),(117,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',15),(118,'1912401','Sneka','KSRCT','B.E','EEE','37116','Male',89,2017,NULL,NULL,93,2020,8,2023,NULL,NULL,'NHA',NULL,'7904273681','sneka.s@codingmart.com','1/493,A1,Kongu Nagar, paramathi road, Periyapatti,Namakkal-637002',15),(119,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',15),(120,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',15),(121,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',15),(122,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',15),(123,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',15),(124,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',15),(125,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',15),(126,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',15),(127,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',15),(128,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',15),(129,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',15),(130,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',15),(131,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',15),(132,'1912127','sneka','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','snekasekar333@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',15),(133,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',15),(135,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',16),(136,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',16),(137,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',16),(138,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',16),(139,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',16),(140,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',16),(141,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',16),(142,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',16),(143,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',16),(144,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',16),(145,'1912127','sneka','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','snekasekar333@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',16),(146,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',16),(147,'1912401','Sneka','KSRCT','B.E','EEE','37116','Male',89,2017,NULL,NULL,93,2020,8,2023,NULL,NULL,'NHA',NULL,'7904273681','sneka.s@codingmart.com','1/493,A1,Kongu Nagar, paramathi road, Periyapatti,Namakkal-637002',16),(148,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',16),(149,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',16),(150,'1911101','ABISHEK M','KSRCT','B.E','MECH','37333','Male',75,2017,53,2019,NULL,NULL,7,2023,NULL,NULL,'NHA',NULL,'9566528797','abishek1832002@gmail.com','33/112, Veppampattipudur Elur road Veppampattipudur post,Namakkal (tk),(dt) ,pin code:637018',16),(151,'1911102','AJAY GOKUL P M','KSRCT','B.E','MECH','37219','Male',93,2017,75,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9487151892','ajaygokulpm@gmail.com','49, Bhuvana illam, Periyar salai 3rd street, Uzhavan Nagar, Erode. 638 009.',16),(152,'1911104','ARJUN S','KSRCT','B.E','MECH','37224','Male',71,2017,57,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9750492652','arjunsakthivel44@gmail.com','4/29,MARIYAMMAN KOVIL,STREET,POTTIREDDYPATTI(PO),POTTIREDDYPATTI.',16),(153,'1911108','BALAMURUGAN S','KSRCT','B.E','MECH','37378','Male',95,2017,62,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9677993983','mvbsbalamurugan@gmail.com','Ladies Hostel Campus, K.S.R Educational Institutions, Tiruchengode - 637215',16),(154,'1911125','LOGESH K','KSRCT','B.E','MECH','37388','Male',73,2017,64,2019,NULL,NULL,7,2023,NULL,NULL,'NSA',NULL,'6374542835','logeshkvs12@gmail.com','Anna Nagar, Pappambadi (Post), pappireddipatti (Tk), Dharmapuri (Dt).636905 no',16),(155,'1911139','RAKSHAN S V','KSRCT','B.E','MECH','37345','Male',95,2017,79,2019,NULL,NULL,9,2023,NULL,NULL,'NHA',NULL,'9360367585','appurakshan88@gmail.com','13/209,SAKTHI NAGA, INGUR WEST ,INGUR POST, INGUR,PERUNDURAI TALUK, 638 052.',16),(156,'1912109','GOWSHICKRAAJ R','KSRCT','B.E','EEE','37257','Male',98,2017,90,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385452397','gowshickraaj8@gmail.com','8/191, Veerapandiyar Nagar, Vembadithalam, Salem',16),(157,'1912112','HARINI M','KSRCT','B.E','EEE','37065','Female',91,2017,72,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9361662347','harinisundar0786@gmail.com','9-2/20,Kullapan Street,Dadagapatty ,Salem-6',16),(158,'1912117','KAMALAKANNAN E','KSRCT','B.E','EEE','37160','Male',86,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9344576143','kamalakannan207269@gmail.com','5/234Pethampatti,Murungapatti(Po),Sivathapuram(via),salem(Dt),636307',16),(159,'1912120','KEERTHIVAASAN D','KSRCT','B.E','EEE','37299','Male',78,2017,61,2019,NULL,NULL,8,2023,NULL,NULL,'NSA',NULL,'9600281163','keerthivasu0212@gmail.com','plot no. 28 Galaxy layout mathamm road Hosur',16),(160,'1912121','KOWSHIKA E','KSRCT','B.E','EEE','37256','Female',96,2017,81,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360261291','e.s.kowshika2001@gmail.com','95/33-B , Avaniyur, V. N. Palayam(po), Idappadi (tk), Salem (dt)',16),(161,'1912126','PRADEEPRAJ P','KSRCT','B.E','EEE','37504','Male',90,2017,67,2019,NULL,NULL,8,2023,NULL,NULL,'SA',1,'9500855476','pradeepraj21052002@gmail.com','18 west Street, Koneripatti, Rasipuram, Namakkal Tamil Nadu, 637408',16),(162,'1912127','sneka','KSRCT','B.E','EEE','37425','Female',95,2017,74,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'6385254916','snekasekar333@gmail.com','236,Anna nagar, Vellandivalasu Idappadi Salem',16),(163,'1912136','NISANTH','KSRCT','B.E','EEE','37390','Male',98,2017,85,2019,NULL,NULL,8,2023,NULL,NULL,'NHA',NULL,'9360609097','nisanth@codingmart.com','2/275-1, ATC Colony, Kumaran Nagar, Varappalayam, Thokkavadi(P.O), Tiruchengode(T.K), Namakkal(D.T)- 637215',16),(164,'1912401','Sneka','KSRCT','B.E','EEE','37116','Male',89,2017,NULL,NULL,93,2020,8,2023,NULL,NULL,'NHA',NULL,'7904273681','sneka.s@codingmart.com','1/493,A1,Kongu Nagar, paramathi road, Periyapatti,Namakkal-637002',16);
/*!40000 ALTER TABLE `candidate_details_college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_tracking`
--

DROP TABLE IF EXISTS `candidate_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_tracking` (
  `driveId` int NOT NULL,
  `studentId` int NOT NULL,
  `round` int NOT NULL,
  `startTime` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loginAttempts` int DEFAULT '0',
  `roundOneDurationTaken` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  PRIMARY KEY (`driveId`,`studentId`,`round`),
  KEY `candidate_tracking_studentId_fkey` (`studentId`),
  CONSTRAINT `candidate_tracking_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `candidate_tracking_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `candidate_details_college` (`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_tracking`
--

LOCK TABLES `candidate_tracking` WRITE;
/*!40000 ALTER TABLE `candidate_tracking` DISABLE KEYS */;
INSERT INTO `candidate_tracking` VALUES (7,10,1,'13:15:44',4,'30:00'),(14,104,1,'14:39:36',2,'30:00'),(15,116,0,'16:52:27',1,'undefined:00'),(15,116,1,'14:50:53',1,'30:00'),(15,116,2,'14:54:03',14,'30:00'),(15,118,1,'14:45:20',1,'30:00'),(16,116,2,'16:06:37',1,'30:00'),(16,145,1,'15:45:47',1,'30:00'),(16,145,2,'16:03:18',8,'30:00');
/*!40000 ALTER TABLE `candidate_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_details`
--

DROP TABLE IF EXISTS `college_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college_details` (
  `driveId` int NOT NULL,
  `college` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `collegeId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`collegeId`),
  UNIQUE KEY `college_details_driveId_key` (`driveId`),
  CONSTRAINT `college_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_details`
--

LOCK TABLES `college_details` WRITE;
/*!40000 ALTER TABLE `college_details` DISABLE KEYS */;
INSERT INTO `college_details` VALUES (6,'MIT',5),(7,'CIT',6),(14,'NIT',7),(15,'MCET',14),(16,'SIET',15);
/*!40000 ALTER TABLE `college_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drive_details`
--

DROP TABLE IF EXISTS `drive_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drive_details` (
  `campusId` int NOT NULL,
  `driveId` int NOT NULL AUTO_INCREMENT,
  `driveDate` datetime(3) NOT NULL,
  `driveStatus` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`driveId`),
  KEY `drive_details_campusId_fkey` (`campusId`),
  CONSTRAINT `drive_details_campusId_fkey` FOREIGN KEY (`campusId`) REFERENCES `campus_details` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drive_details`
--

LOCK TABLES `drive_details` WRITE;
/*!40000 ALTER TABLE `drive_details` DISABLE KEYS */;
INSERT INTO `drive_details` VALUES (1,6,'2023-11-10 18:30:00.000','completed'),(1,7,'2001-01-31 18:30:00.000','completed'),(1,14,'2023-08-16 00:00:00.000','completed'),(1,15,'2023-08-17 00:00:00.000','pending'),(1,16,'2023-08-03 00:00:00.000','completed');
/*!40000 ALTER TABLE `drive_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `driveId` int NOT NULL,
  `labFacilityRating` int NOT NULL,
  `hospitalityRating` int NOT NULL,
  `internetBandwidthRating` int NOT NULL,
  `studentAbility` int NOT NULL,
  `overallFeedBack` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`driveId`),
  CONSTRAINT `feedback_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructions`
--

DROP TABLE IF EXISTS `instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructions` (
  `instruction` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instructionId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`instructionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructions`
--

LOCK TABLES `instructions` WRITE;
/*!40000 ALTER TABLE `instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_roles`
--

DROP TABLE IF EXISTS `job_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `jobRole` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_roles_id_key` (`id`),
  KEY `job_roles_driveId_fkey` (`driveId`),
  CONSTRAINT `job_roles_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_roles`
--

LOCK TABLES `job_roles` WRITE;
/*!40000 ALTER TABLE `job_roles` DISABLE KEYS */;
INSERT INTO `job_roles` VALUES (11,7,'Engineers'),(12,7,'QA'),(25,15,'BA'),(26,15,'Engineers'),(27,16,'BA'),(28,16,'Engineers');
/*!40000 ALTER TABLE `job_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionSet`
--

DROP TABLE IF EXISTS `questionSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionSet` (
  `driveId` int NOT NULL,
  `questionId` int NOT NULL,
  `round` int NOT NULL,
  PRIMARY KEY (`driveId`,`questionId`,`round`),
  KEY `questionSet_questionId_fkey` (`questionId`),
  CONSTRAINT `questionSet_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `questionSet_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Mcqs` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionSet`
--

LOCK TABLES `questionSet` WRITE;
/*!40000 ALTER TABLE `questionSet` DISABLE KEYS */;
INSERT INTO `questionSet` VALUES (7,1007,2),(16,1007,2),(15,1008,2),(15,1009,2),(15,1010,2),(7,1011,2),(15,1011,2),(16,1012,2),(15,1014,2),(16,1014,2),(15,1015,2),(7,1016,2),(15,1020,2),(15,1022,2),(16,1022,2),(7,1023,2),(16,1024,2),(7,1025,2),(7,1028,2),(15,1032,2),(16,1032,2),(7,1035,2),(15,1035,2),(15,1037,2),(7,1040,2),(16,1040,2),(7,1041,2),(15,1042,2),(16,1042,2),(7,1043,2),(15,1043,2),(16,1043,2),(15,1048,2),(15,1049,2),(15,1050,2),(16,1052,2),(15,1053,2),(16,1058,1),(7,1060,1),(16,1060,1),(7,1064,1),(16,1069,1),(7,1071,1),(16,1078,1),(16,1086,1),(16,1091,1),(16,1095,1),(16,1103,1),(7,1111,1),(16,1111,1),(7,1112,1),(15,1121,1),(16,1126,1),(16,1129,1),(16,1131,1),(16,1134,1),(15,1135,1),(16,1145,1),(16,1147,1),(7,1162,1),(16,1162,1),(16,1163,1),(15,1165,2),(16,1167,1),(15,1168,2),(16,1171,1),(7,1174,1),(15,1175,1),(7,1178,1),(15,1178,2),(7,1180,1),(16,1184,1),(7,1189,1);
/*!40000 ALTER TABLE `questionSet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment_team`
--

DROP TABLE IF EXISTS `recruitment_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment_team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `teamMembers` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recruitment_team_id_key` (`id`),
  KEY `recruitment_team_driveId_fkey` (`driveId`),
  CONSTRAINT `recruitment_team_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment_team`
--

LOCK TABLES `recruitment_team` WRITE;
/*!40000 ALTER TABLE `recruitment_team` DISABLE KEYS */;
INSERT INTO `recruitment_team` VALUES (13,7,'abc'),(24,15,'xyz'),(25,15,'abc'),(26,16,'xyz'),(27,16,'abc');
/*!40000 ALTER TABLE `recruitment_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment_team_members`
--

DROP TABLE IF EXISTS `recruitment_team_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment_team_members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment_team_members`
--

LOCK TABLES `recruitment_team_members` WRITE;
/*!40000 ALTER TABLE `recruitment_team_members` DISABLE KEYS */;
INSERT INTO `recruitment_team_members` VALUES (1,'xyz','xyz@codingmart.com'),(2,'abc','abc@codingmart.com'),(4,'mem3','abcd@codingmart.com');
/*!40000 ALTER TABLE `recruitment_team_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_details`
--

DROP TABLE IF EXISTS `round_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_details` (
  `driveId` int NOT NULL,
  `round` int NOT NULL,
  `roundName` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roundDuration` int NOT NULL,
  `roundTotalQuestions` int NOT NULL,
  `roundDifficulty` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roundTopics` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roundStatus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`driveId`,`round`),
  KEY `round_details_round_driveId_idx` (`round`,`driveId`),
  CONSTRAINT `round_details_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_details`
--

LOCK TABLES `round_details` WRITE;
/*!40000 ALTER TABLE `round_details` DISABLE KEYS */;
INSERT INTO `round_details` VALUES (7,1,'MCQ',30,10,'medium','ds,logical','completed'),(7,2,'SQL',30,10,'easy,medium','sql','completed'),(15,1,'MCQ',30,3,'hard','ds,logical','completed'),(15,2,'SQL',45,20,'easy,medium,hard','logical,sql','completed'),(16,1,'SQL',30,20,'easy,medium','ds,logical','completed'),(16,2,'SQL',20,10,'easy,medium,hard','sql','completed');
/*!40000 ALTER TABLE `round_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round_privileges`
--

DROP TABLE IF EXISTS `round_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round_privileges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `driveId` int NOT NULL,
  `IsSkipped` tinyint(1) DEFAULT NULL,
  `round` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `round_privileges_id_key` (`id`),
  KEY `round_privileges_driveId_fkey` (`driveId`),
  CONSTRAINT `round_privileges_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round_privileges`
--

LOCK TABLES `round_privileges` WRITE;
/*!40000 ALTER TABLE `round_privileges` DISABLE KEYS */;
INSERT INTO `round_privileges` VALUES (13,7,1,1),(14,7,1,2),(22,15,1,1),(23,15,1,2),(24,16,1,1),(25,16,1,2);
/*!40000 ALTER TABLE `round_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submitTest`
--

DROP TABLE IF EXISTS `submitTest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submitTest` (
  `driveId` int NOT NULL,
  `candidateId` int NOT NULL,
  `round` int NOT NULL,
  `submitted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`driveId`,`candidateId`,`round`),
  KEY `submitTest_candidateId_fkey` (`candidateId`),
  CONSTRAINT `submitTest_candidateId_fkey` FOREIGN KEY (`candidateId`) REFERENCES `candidate_details_college` (`studentId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `submitTest_driveId_fkey` FOREIGN KEY (`driveId`) REFERENCES `drive_details` (`driveId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submitTest`
--

LOCK TABLES `submitTest` WRITE;
/*!40000 ALTER TABLE `submitTest` DISABLE KEYS */;
INSERT INTO `submitTest` VALUES (7,10,1,1),(7,43,1,1),(15,116,1,1),(15,118,1,1),(16,145,1,1),(16,145,2,1);
/*!40000 ALTER TABLE `submitTest` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-02 17:21:13
