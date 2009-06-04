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

-- Dump completed on 2009-06-01 22:43:46
