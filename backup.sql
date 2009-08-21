-- MySQL dump 10.11
--
-- Host: localhost    Database: jgc_development
-- ------------------------------------------------------
-- Server version	5.0.77-community-nt-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `activities` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `resources` text,
  `cost` text,
  `comments` text,
  `duration` varchar(255) default NULL,
  `instructions` text,
  `programs` varchar(255) default NULL,
  `age_group` varchar(255) default NULL,
  `category` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `visible` tinyint(1) default '0',
  `created_by` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (1,'Test Activity','This is where the description go','This is where the resources go','$0-$20','These are the comments of the program director who created the activitiy','30min-60min','Instructions on how to perform the activity',NULL,'8-10',NULL,'2009-05-25 04:05:41','2009-05-25 04:05:41',0,'testpd'),(2,'Test','this is my test','','$0-$20','','','',NULL,'8-10',NULL,'2009-05-27 02:13:27','2009-05-27 02:13:27',0,'testpd'),(3,'Aaa','','','','','0-30min','',NULL,'',NULL,'2009-06-01 06:43:40','2009-06-01 06:43:40',0,'No Name'),(4,'Ab','','','','','','',NULL,'',NULL,'2009-06-01 06:44:22','2009-06-01 06:44:22',0,'No Name');
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activities_comments`
--

DROP TABLE IF EXISTS `activities_comments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `activities_comments` (
  `id` int(11) NOT NULL auto_increment,
  `activity_id` varchar(255) default NULL,
  `comment_text` text,
  `email` varchar(255) default NULL,
  `visible` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `activities_comments`
--

LOCK TABLES `activities_comments` WRITE;
/*!40000 ALTER TABLE `activities_comments` DISABLE KEYS */;
INSERT INTO `activities_comments` VALUES (1,'1','This is comment we like','nipunb@stanford.edu',0);
/*!40000 ALTER TABLE `activities_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asps`
--

DROP TABLE IF EXISTS `asps`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `asps` (
  `id` int(11) NOT NULL auto_increment,
  `organization_id` varchar(255) default NULL,
  `program_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `asps`
--

LOCK TABLES `asps` WRITE;
/*!40000 ALTER TABLE `asps` DISABLE KEYS */;
INSERT INTO `asps` VALUES (1,NULL,'YELL'),(2,NULL,'YELL 1'),(4,'5','YELL 1'),(5,'6','Program 1'),(6,'6','Program 2');
/*!40000 ALTER TABLE `asps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL auto_increment,
  `activity_id` varchar(255) default NULL,
  `category_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'1','Icebreakers'),(2,'1','General'),(3,'2',''),(4,'3',''),(5,'4','');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL auto_increment,
  `comment_text` text,
  `email` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'testing feedback','nipunb@stanford.edu','Nipun Bhatia'),(2,'testing feedback','nipunb@stanford.edu','Nipun Bhatia'),(3,'testing feedback again','nipunb@stanford.edu','Nipun Bhatia'),(4,'testing feedback again','nipunb@stanford.edu','Nipun Bhatia'),(5,'this is awesome','nipunb@stanford.edu',''),(6,'This is a test','nipunb@stanford.edu','');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `emails` (
  `id` int(11) NOT NULL auto_increment,
  `from` text,
  `to` text,
  `mail` text,
  `subject` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
INSERT INTO `emails` VALUES (2,'helpjgc@gmail.com','jgcstanford@gmail.com','A new User: activitiesadmin has joined the network.Contact the new user at jgcactivities@gmail.com','New User has joined the network ','2009-05-25 02:04:35','2009-05-25 02:04:35'),(3,'helpjgc@gmail.com','jgcactivities@gmail.com','A new Program Director: testpd1 has joined the network.Contact the new user at testpd1@stanford.edu','New Program Director has joined the network ','2009-05-25 02:08:19','2009-05-25 02:08:19'),(4,'helpjgc@gmail.com','jgcstanford@gmail.com','A new Organization: Test organization has been created by nipunb .Kindly review and approve the organization','New organization has been created','2009-05-25 03:48:13','2009-05-25 03:48:13'),(5,'helpjgc@gmail.com','jgcstanford@gmail.com','A new User: testorg has joined the network.Contact the new user at testorg@stanford.edu','New User has joined the network ','2009-05-26 18:49:43','2009-05-26 18:49:43'),(6,'helpjgc@gmail.com','jgcstanford@gmail.com','A new User: newuser has joined the network.Contact the new user at newuser@stanford.edu','New User has joined the network ','2009-05-27 00:17:05','2009-05-27 00:17:05'),(7,'helpjgc@gmail.com','jgcstanford@gmail.com','A new User: aspuser has joined the network.Contact the new user at asp@stanford.edu','New User has joined the network ','2009-05-28 01:02:40','2009-05-28 01:02:40'),(8,'helpjgc@gmail.com','jgcstanford@gmail.com','A new Organization: Test Program has been created by aspuser .Kindly review and approve the organization','New organization has been created','2009-05-28 01:48:33','2009-05-28 01:48:33'),(9,'helpjgc@gmail.com','jgcstanford@gmail.com','A new User: neworguser has joined the network.Contact the new user at neworg@stanford.edu','New User has joined the network ','2009-06-01 04:37:35','2009-06-01 04:37:35'),(10,'helpjgc@gmail.com','jgcstanford@gmail.com','A new Organization: New Org has been created by neworguser .Kindly review and approve the organization','New organization has been created','2009-06-01 04:38:20','2009-06-01 04:38:20'),(11,'helpjgc@gmail.com','jgcstanford@gmail.com','A new User: neworgedit has joined the network.Contact the new user at edit@stanford.edu','New User has joined the network ','2009-06-01 04:39:58','2009-06-01 04:39:58'),(12,'helpjgc@gmail.com','jgcstanford@gmail.com','A new User: testprogram has joined the network.Contact the new user at testprogram@stanford.edu','New User has joined the network ','2009-06-01 05:46:45','2009-06-01 05:46:45'),(13,'helpjgc@gmail.com','jgcstanford@gmail.com','A new Organization: Test New has been created by testprogram .Kindly review and approve the organization','New organization has been created','2009-06-01 05:47:24','2009-06-01 05:47:24'),(14,'helpjgc@gmail.com','jgcactivities@gmail.com','A new Activity Aaa has been created .Kindly review  the Activity.','New Activity has been created','2009-06-01 06:43:40','2009-06-01 06:43:40'),(15,'helpjgc@gmail.com','jgcactivities@gmail.com','A new Activity Ab has been created .Kindly review  the Activity.','New Activity has been created','2009-06-01 06:44:22','2009-06-01 06:44:22'),(16,'helpjgc@gmail.com','jgcstanford@gmail.com','A new User: rakshit has joined the network.Contact the new user at rakshit@stanford.edu','New User has joined the network ','2009-06-01 20:11:28','2009-06-01 20:11:28'),(17,'helpjgc@gmail.com','jgcstanford@gmail.com','A new Organization: Organization has been created by rakshit .Kindly review and approve the organization','New organization has been created','2009-06-01 20:13:22','2009-06-01 20:13:22');
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `organizations` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `website` varchar(255) default NULL,
  `description` text,
  `resources` text,
  `contact` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `partners` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `visible` tinyint(1) default '0',
  `asp` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
INSERT INTO `organizations` VALUES (1,'John Gardner Center','http://gardnercenter.stanford.edu/','Community and youth development go hand in hand: a community only prospers when its young people prosper, and young people only flourish in a flourishing community. At the John W. Gardner Center (JGC) at Stanford University, we partner with local communities to support their efforts to continually renew themselves, by way of developing well-rounded young people who are successful—intellectually, emotionally, physically and socially—and who in turn are motivated to contribute to their communities, both as leaders and as responsible participants.','','Katrina Brink','kbrink@stanford.edu',NULL,'2009-05-25 03:43:17','2009-05-25 03:45:08',1,NULL),(2,'Test organization','test.com','This is where the description goes','This where resources go','Don\'t leave contact blank','nipunb@stanford.edu',NULL,'2009-05-25 03:48:12','2009-06-01 04:39:01',1,NULL),(3,'Test Program','','','','alphabeta','alpha@stanford.edu',NULL,'2009-05-28 01:48:32','2009-06-01 04:38:58',1,NULL),(4,'New Org','neworg.com','','','Nipun','nipunbh@stanford.edu',NULL,'2009-06-01 04:38:19','2009-06-01 05:33:59',1,NULL),(5,'Test New','testnew.com','','','Nipun','nipun@stanford.edu',NULL,'2009-06-01 05:47:23','2009-06-01 06:06:21',1,NULL),(6,'Organization','organization.website.com','This is where the description of the organization goes.','This is where the resources of the organization go.','Test','test@stanford.edu',NULL,'2009-06-01 20:13:21','2009-06-01 20:15:54',1,NULL);
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partners`
--

DROP TABLE IF EXISTS `partners`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `partners` (
  `id` int(11) NOT NULL auto_increment,
  `organization_id` varchar(255) default NULL,
  `partner_org_id` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `partners`
--

LOCK TABLES `partners` WRITE;
/*!40000 ALTER TABLE `partners` DISABLE KEYS */;
INSERT INTO `partners` VALUES (10,'2','1'),(13,'3','0'),(14,'4','1'),(15,'5','3'),(17,'5','2'),(18,'5','4'),(19,'5','1'),(20,'6','1');
/*!40000 ALTER TABLE `partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pd_users`
--

DROP TABLE IF EXISTS `pd_users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pd_users` (
  `id` int(11) NOT NULL auto_increment,
  `login_name` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `authorization_token` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `pd_users`
--

LOCK TABLES `pd_users` WRITE;
/*!40000 ALTER TABLE `pd_users` DISABLE KEYS */;
INSERT INTO `pd_users` VALUES (1,'testpd','testpd@stanford.edu','testpd',NULL),(2,'testpd1','testpd1@stanford.edu','testpd1',NULL);
/*!40000 ALTER TABLE `pd_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_lives`
--

DROP TABLE IF EXISTS `personal_lives`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `personal_lives` (
  `id` int(11) NOT NULL auto_increment,
  `pd_user_id` int(11) NOT NULL,
  `bio` text,
  `academic_background` text,
  `interests` text,
  `other_info` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `personal_lives`
--

LOCK TABLES `personal_lives` WRITE;
/*!40000 ALTER TABLE `personal_lives` DISABLE KEYS */;
INSERT INTO `personal_lives` VALUES (1,1,'This is my bio','','','');
/*!40000 ALTER TABLE `personal_lives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professional_lives`
--

DROP TABLE IF EXISTS `professional_lives`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `professional_lives` (
  `id` int(11) NOT NULL auto_increment,
  `pd_user_id` int(11) NOT NULL,
  `current_employee` text,
  `start_date` date default NULL,
  `past_work_experience` text,
  `num_of_work_experience_years` int(11) default NULL,
  `social_activities` text,
  `skills` text,
  `future_plans` text,
  `desired_job_description` text,
  `desired_job_salary` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `professional_lives`
--

LOCK TABLES `professional_lives` WRITE;
/*!40000 ALTER TABLE `professional_lives` DISABLE KEYS */;
INSERT INTO `professional_lives` VALUES (1,1,'',NULL,'',NULL,'','','','',NULL);
/*!40000 ALTER TABLE `professional_lives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `programs` (
  `id` int(11) NOT NULL auto_increment,
  `activity_id` varchar(255) default NULL,
  `program_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES (1,'1','YELL'),(2,'2',''),(3,'3',''),(4,'4','');
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('2'),('20090227000327'),('20090301221130'),('20090308004047'),('20090308004757'),('20090308010800'),('20090413232041'),('20090421234634'),('20090423082204'),('20090425232827'),('20090427005206'),('20090428024927'),('20090428085038'),('20090503224603'),('20090504213831'),('20090512223055'),('20090513211955'),('20090514215613'),('20090518221040'),('20090528003339'),('20090528013136'),('20090601042121'),('20090601054017'),('3'),('4'),('5'),('6');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'6960c29015434a2631375bce8c5d22cb','BAh7CToJdXNlcjA6DnJldHVybl90bzA6D3BkX3VzZXJfaWQwIgpmbGFzaElD\nOidBY3Rpb25Db250cm9sbGVyOjpGbGFzaDo6Rmxhc2hIYXNoewY6C25vdGlj\nZSIeVW5hYmxlIHRvIHByb2Nlc3MgY29tbWVudAY6CkB1c2VkewY7CVQ=\n','2009-05-25 03:30:13','2009-05-25 06:10:54'),(2,'5fbb3b2e771d691781457ca241e6848f','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-26 06:55:06','2009-05-26 06:55:06'),(3,'666cbdba559e3549d95dcd1dd6edc167','BAh7BzoJdXNlcjAiCmZsYXNoSUM6J0FjdGlvbkNvbnRyb2xsZXI6OkZsYXNo\nOjpGbGFzaEhhc2h7BjoMbWVzc2FnZSIPTG9nZ2VkIG91dAY6CkB1c2VkewY7\nB1Q=\n','2009-05-26 06:56:44','2009-05-26 06:56:55'),(4,'ffff4905eabcc9477143d4d4dedefa8c','BAh7BzoJdXNlcjAiCmZsYXNoSUM6J0FjdGlvbkNvbnRyb2xsZXI6OkZsYXNo\nOjpGbGFzaEhhc2h7BjoMbWVzc2FnZSIPTG9nZ2VkIG91dAY6CkB1c2VkewY7\nB1Q=\n','2009-05-26 06:57:17','2009-05-26 08:27:15'),(5,'8215cebb99af01c36f4977ae2c29deca','BAh7CDoJdXNlcjA6D3BkX3VzZXJfaWQwIgpmbGFzaElDOidBY3Rpb25Db250\ncm9sbGVyOjpGbGFzaDo6Rmxhc2hIYXNoewY6C25vdGljZSIeVW5hYmxlIHRv\nIHByb2Nlc3MgY29tbWVudAY6CkB1c2VkewY7CFQ=\n','2009-05-26 18:49:15','2009-05-26 19:51:16'),(6,'15dd0339e8dc14a5fdf6805db58904cb','BAh7BzoJdXNlcjAiCmZsYXNoSUM6J0FjdGlvbkNvbnRyb2xsZXI6OkZsYXNo\nOjpGbGFzaEhhc2h7BjoMbWVzc2FnZSIPTG9nZ2VkIG91dAY6CkB1c2VkewY7\nB1Q=\n','2009-05-27 00:16:37','2009-05-27 00:17:09'),(7,'dbc077c9902099d98ebc70d26030b283','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-27 00:38:14','2009-05-27 00:38:14'),(8,'d557846e3cabd4bfd2941ff9ba57fbc0','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-27 00:38:30','2009-05-27 00:38:30'),(9,'2b903f6a87a4d5cb793da353d0efec47','BAh7BiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo\nSGFzaHsABjoKQHVzZWR7AA==\n','2009-05-27 01:58:51','2009-05-27 01:58:51'),(10,'7e23cb5098384754539e22250406e92f','BAh7CDoPcGRfdXNlcl9pZDA6CXVzZXIwIgpmbGFzaElDOidBY3Rpb25Db250\ncm9sbGVyOjpGbGFzaDo6Rmxhc2hIYXNoewY6EW5vdGlmaWNhdGlvbiIPTG9n\nZ2VkIG91dAY6CkB1c2VkewY7CFQ=\n','2009-05-27 01:58:51','2009-05-27 02:05:37'),(11,'f9a1caecc0a6f72d7d74f1675f64ef4f','BAh7CToPcGRfdXNlcl9pZDA6E3Byb3RlY3RlZF9wYWdlIg0vcGRfdXNlcjoJ\ndXNlcm86CVVzZXIIOhhAY2hhbmdlZF9hdHRyaWJ1dGVzewA6EEBhdHRyaWJ1\ndGVzew8iCXNhbHQiD0hrS2hyekxUQkwiEWFmZmlsaWF0ZU9yZyIRVGVzdCBQ\ncm9ncmFtIhNhY3Rpdml0ZXNhZG1pbiIGMCIUaGFzaGVkX3Bhc3N3b3JkIi02\nNGI3YzAzMTQzNzk1MzQ0ODM2MTYyOTU0MDI2NTBmM2Y2ZjJjOGM1IgphZG1p\nbiIGMCIHaWQiBjYiDW1haWxwcmVmIgYxIgpsb2dpbiIMYXNwdXNlciIKZW1h\naWwiFWFzcEBzdGFuZm9yZC5lZHUiD2NyZWF0ZWRfYXQiGDIwMDktMDUtMjgg\nMDE6MDI6NDA6FkBhdHRyaWJ1dGVzX2NhY2hlewAiCmZsYXNoSUM6J0FjdGlv\nbkNvbnRyb2xsZXI6OkZsYXNoOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA=\n','2009-05-27 02:05:46','2009-05-28 06:46:06'),(12,'2b7bbd73eb422a6013fe571c6621e399','BAh7CDoJdXNlcjAiCmZsYXNoSUM6J0FjdGlvbkNvbnRyb2xsZXI6OkZsYXNo\nOjpGbGFzaEhhc2h7AAY6CkB1c2VkewA6E3Byb3RlY3RlZF9wYWdlIg0vcGRf\ndXNlcg==\n','2009-06-01 04:36:57','2009-06-01 21:29:57');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specs`
--

DROP TABLE IF EXISTS `specs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `specs` (
  `id` int(11) NOT NULL auto_increment,
  `pd_user_id` int(11) NOT NULL,
  `first_name` varchar(255) default '',
  `last_name` varchar(255) default '',
  `gender` varchar(255) default NULL,
  `birthdate` date default NULL,
  `occupation` varchar(255) default '',
  `city` varchar(255) default '',
  `state` varchar(255) default '',
  `zip_code` varchar(255) default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `specs`
--

LOCK TABLES `specs` WRITE;
/*!40000 ALTER TABLE `specs` DISABLE KEYS */;
INSERT INTO `specs` VALUES (1,1,'Test','PD','Male','2000-01-01','Student','Stanford','CA','94305');
/*!40000 ALTER TABLE `specs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(255) default NULL,
  `hashed_password` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `salt` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `admin` tinyint(1) default '0',
  `affiliateOrg` varchar(255) default NULL,
  `activitesadmin` tinyint(1) default '0',
  `mailpref` tinyint(1) default '1',
  `edit_perms` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','1fcd29014dc575b36289cb3067bc148427861e8c','jgcstanford@gmail.com','KADd78NrHV','2009-05-23 21:19:05',1,'New Org',0,1,1),(2,'nipunb','7372c1189418eb698de05559fd3f4f68fb83edbe','nipunb@stanford.edu','0bR7vzEwVY','2009-05-23 22:46:26',0,'Test organization',0,1,1),(3,'activitiesadmin','fd766a51b90853b21b97036e3522b0d0aae35bae','jgcactivities@gmail.com','KKtdeuDsIG','2009-05-25 02:04:34',0,NULL,1,1,0),(4,'testorg','85b1f8d851f34d06f3f6de728229ba48a3af4f21','testorg@stanford.edu','T6T2shQHQZ','2009-05-26 18:49:42',0,NULL,0,1,0),(5,'newuser','65c3e8017ef8d387e15dd6226f9edffb1c8ad048','newuser@stanford.edu','aTC00ZeF5o','2009-05-27 00:17:05',0,NULL,0,1,0),(6,'aspuser','64b7c0314379534483616295402650f3f6f2c8c5','asp@stanford.edu','HkKhrzLTBL','2009-05-28 01:02:40',0,'Test Program',0,1,1),(7,'neworguser','cbc66e6aeea8167cbc033625b66aa7f0f9c13b03','neworg@stanford.edu','yirmpr3lDg','2009-06-01 04:37:35',0,'New Org',0,1,1),(8,'neworgedit','53aa01186367fd3adc86ddc8160ecbbf6c3fdfa6','edit@stanford.edu','ZDohlM7SF3','2009-06-01 04:39:57',0,'New Org',0,1,1),(9,'testprogram','ebedd42cb19fc9b41762b53cf15b1997ea6a00d4','testprogram@stanford.edu','PpwMteoOFh','2009-06-01 05:46:45',0,'Test New',0,1,1),(10,'rakshit','fc61fca43d2942f4097a64808a663313275caf8f','rakshit@stanford.edu','2wvd67E333','2009-06-01 20:11:28',0,'Organization',0,1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-06-01 21:45:40
