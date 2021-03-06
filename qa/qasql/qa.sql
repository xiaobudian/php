CREATE DATABASE  IF NOT EXISTS `qa` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `qa`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: qa
-- ------------------------------------------------------
-- Server version	5.7.9-log

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
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer` longtext NOT NULL,
  `votes` int(11) NOT NULL,
  `ct` datetime NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_7aa0f6ee` (`question_id`),
  KEY `answer_e8701ad4` (`user_id`),
  CONSTRAINT `answer_question_id_79aaa5e2_fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `answer_user_id_177a444f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,'<p><a href=\"http://www.zbj.com/?pmcode=149720&fromcode=11726814&utm_source=bdpz&utm_medium=SEM\" target=\"_blank\" title=\"猪八戒网\" style=\"white-space: normal; margin: 0px; padding: 0px; border: 0px; text-decoration: none; cursor: pointer; color: rgb(12, 101, 165);\">http://www.zbj.com/</a></p>',1,'2016-01-12 10:34:20',8,3);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add tag',7,'add_tag'),(20,'Can change tag',7,'change_tag'),(21,'Can delete tag',7,'delete_tag'),(22,'Can add question',8,'add_question'),(23,'Can change question',8,'change_question'),(24,'Can delete question',8,'delete_question'),(25,'Can add question_ vote',9,'add_question_vote'),(26,'Can change question_ vote',9,'change_question_vote'),(27,'Can delete question_ vote',9,'delete_question_vote'),(28,'Can add answer',10,'add_answer'),(29,'Can change answer',10,'change_answer'),(30,'Can delete answer',10,'delete_answer'),(31,'Can add answer_ vote',11,'add_answer_vote'),(32,'Can change answer_ vote',11,'change_answer_vote'),(33,'Can delete answer_ vote',11,'delete_answer_vote'),(34,'Can add favorite_ question',12,'add_favorite_question'),(35,'Can change favorite_ question',12,'change_favorite_question'),(36,'Can delete favorite_ question',12,'delete_favorite_question'),(37,'Can add profile',13,'add_profile'),(38,'Can change profile',13,'change_profile'),(39,'Can delete profile',13,'delete_profile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$hGI9UVj3Srf2$F2zNKx/27cqnFsRQCTpNBCeatwQFHZ1wd3mUb3L9CYA=','2016-01-11 09:44:49',1,'admin','','','849351660@qq.com',1,1,'2016-01-11 07:20:34'),(3,'eb2fd1d67822609f695909bce2b971ec',NULL,0,'1032371668@qq.com','','','1032371668@qq.com',1,0,'2016-01-11 15:21:33');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_30a071c9_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_30a071c9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_24702650_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_7cd7acb6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avote`
--

DROP TABLE IF EXISTS `avote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ct` datetime NOT NULL,
  `vote_type` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `avote_user_id_9bbdcfd_uniq` (`user_id`,`answer_id`),
  KEY `avote_answer_id_2f3778ae_fk_answer_id` (`answer_id`),
  CONSTRAINT `avote_answer_id_2f3778ae_fk_answer_id` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`id`),
  CONSTRAINT `avote_user_id_351f558d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avote`
--

LOCK TABLES `avote` WRITE;
/*!40000 ALTER TABLE `avote` DISABLE KEYS */;
INSERT INTO `avote` VALUES (1,'2016-01-12 10:34:23',1,1,3);
/*!40000 ALTER TABLE `avote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_5151027a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_1c5f563_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_5151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_1c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-01-11 09:45:34','1','MYSQL_ATTR_INIT_COMMAND',3,'',8,1),(2,'2016-01-11 09:46:07','3','q1sssss',3,'',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_3ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(10,'qadmin','answer'),(11,'qadmin','answer_vote'),(12,'qadmin','favorite_question'),(13,'qadmin','profile'),(8,'qadmin','question'),(9,'qadmin','question_vote'),(7,'qadmin','tag'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-01-11 07:20:06'),(2,'auth','0001_initial','2016-01-11 07:20:06'),(3,'admin','0001_initial','2016-01-11 07:20:06'),(4,'contenttypes','0002_remove_content_type_name','2016-01-11 07:20:07'),(5,'auth','0002_alter_permission_name_max_length','2016-01-11 07:20:07'),(6,'auth','0003_alter_user_email_max_length','2016-01-11 07:20:07'),(7,'auth','0004_alter_user_username_opts','2016-01-11 07:20:07'),(8,'auth','0005_alter_user_last_login_null','2016-01-11 07:20:07'),(9,'auth','0006_require_contenttypes_0002','2016-01-11 07:20:07'),(10,'qadmin','0001_initial','2016-01-11 07:20:08'),(11,'qadmin','0002_auto_20151214_1645','2016-01-11 07:20:08'),(12,'qadmin','0003_auto_20151214_1655','2016-01-11 07:20:09'),(13,'qadmin','0004_auto_20151214_1657','2016-01-11 07:20:09'),(14,'qadmin','0005_auto_20151214_1658','2016-01-11 07:20:10'),(15,'qadmin','0006_auto_20151215_1403','2016-01-11 07:20:10'),(16,'qadmin','0007_question_summary','2016-01-11 07:20:10'),(17,'sessions','0001_initial','2016-01-11 07:20:10');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('lmb4l7lh2pqnxrbzagmrb3z7eieeqik3','MjY2ZmYwZGU0NDVmMjYxOTdkZDVlMDZkYmQ1MDY3ZThmYTM4ZWZmODp7Il9hdXRoX3VzZXJfaGFzaCI6IjZlYTZjNjg1ZjUyOGY5ZDEwYjAxYzgzMzdjZWUyMzQwNGZkZDllMDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-01-25 09:44:49');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fquestion`
--

DROP TABLE IF EXISTS `fquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fquestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ct` datetime NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fquestion_user_id_5acae384_uniq` (`user_id`,`question_id`),
  KEY `fquestion_7aa0f6ee` (`question_id`),
  KEY `fquestion_e8701ad4` (`user_id`),
  CONSTRAINT `fquestion_question_id_55abef05_fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `fquestion_user_id_54ab22c0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fquestion`
--

LOCK TABLES `fquestion` WRITE;
/*!40000 ALTER TABLE `fquestion` DISABLE KEYS */;
INSERT INTO `fquestion` VALUES (2,'2016-01-12 10:33:45',8,3),(5,'2016-01-15 19:15:45',19,3);
/*!40000 ALTER TABLE `fquestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic` varchar(100) NOT NULL,
  `reputation` int(11) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `aboutme` varchar(500) DEFAULT NULL,
  `realname` varchar(50) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_user_id_1c244c57_fk_auth_user_id` (`user_id`),
  CONSTRAINT `profile_user_id_1c244c57_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (2,'/Public/img/profile/20160111155235.png',0,'','','',NULL,3);
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `content` longtext NOT NULL,
  `ct` datetime NOT NULL,
  `votes` int(11) NOT NULL,
  `answers` int(11) NOT NULL,
  `views` int(11) NOT NULL,
  `favorite` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `summary` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_e8701ad4` (`user_id`),
  CONSTRAINT `question_user_id_2faf3d8d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (7,'nginx配置支持php pathinfo','<pre><span style=\"font-size: 10px;\">fastcgi_param PATH_INFO $path_info;</span><br/></pre>','2016-01-12 10:23:37',1,0,2,0,3,'fastcgi_param PATH_INFO $path_info;'),(8,'猪八戒网址','<p><a href=\"http://www.zbj.com/?pmcode=149720&fromcode=11726814&utm_source=bdpz&utm_medium=SEM\" target=\"_blank\" title=\"猪八戒网\">http://www.zbj.com/?pmcode=149720&amp;fromcode=11726814&amp;utm_source=bdpz&amp;utm_medium=SEM</a></p>','2016-01-12 10:25:46',1,1,2,1,3,'http://www.zbj.com/?pmcode=149720&fromcode=11726814&utm_source=bdpz&utm_medium=SEM'),(9,'c# 如何生成二维码？','<p>我尝试过使用 qrcode.dll 但是没有成功。 希望大神给我一份代码，谢谢</p>','2016-01-14 18:21:56',0,0,2,0,3,'我尝试过使用 qrcode.dll 但是没有成功。 希望大神给我一份代码，谢谢'),(10,'ssssssss','<p>ssss</p>','2016-01-14 19:45:41',-1,0,2,0,3,'ssss'),(18,'ssssssss','<p>feeeeeeeesfsefsef</p>','2016-01-14 20:00:45',0,0,2,0,3,'feeeeeeeesfsefsef'),(19,'sssssssssssssss','<p>seeeeeeeeffffffffffffsssssseeeeee</p>','2016-01-15 19:14:11',1,0,2,1,3,'seeeeeeeeffffffffffffsssssseeeeee');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_tags`
--

DROP TABLE IF EXISTS `question_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_id` (`question_id`,`tag_id`),
  KEY `question_tags_tag_id_2a5adaec_fk_tag_id` (`tag_id`),
  CONSTRAINT `question_tags_question_id_7ccad07f_fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `question_tags_tag_id_2a5adaec_fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_tags`
--

LOCK TABLES `question_tags` WRITE;
/*!40000 ALTER TABLE `question_tags` DISABLE KEYS */;
INSERT INTO `question_tags` VALUES (7,7,1),(8,8,2),(10,9,1),(9,9,3),(11,10,1),(12,18,1),(13,19,4);
/*!40000 ALTER TABLE `question_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qvote`
--

DROP TABLE IF EXISTS `qvote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qvote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ct` datetime NOT NULL,
  `vote_type` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qvote_user_id_5db968c1_uniq` (`user_id`,`question_id`),
  KEY `qvote_question_id_63e065be_fk_question_id` (`question_id`),
  CONSTRAINT `qvote_question_id_63e065be_fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `qvote_user_id_752bdf43_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qvote`
--

LOCK TABLES `qvote` WRITE;
/*!40000 ALTER TABLE `qvote` DISABLE KEYS */;
INSERT INTO `qvote` VALUES (45,'2016-01-14 19:36:20',1,7,3),(47,'2016-01-14 20:01:03',1,8,3),(48,'2016-01-14 20:02:05',2,10,3),(50,'2016-01-15 19:15:48',1,19,3);
/*!40000 ALTER TABLE `qvote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `desc` longtext,
  `reputation` int(11) NOT NULL,
  `ct` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_user_id_2220e8d4_fk_auth_user_id` (`user_id`),
  CONSTRAINT `tag_user_id_2220e8d4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'php','php',5,'2016-01-11 15:22:27',3),(2,'vm','vm',6,'2016-01-11 15:23:59',3),(3,'java','java',1,'2016-01-11 17:36:07',3),(4,'centos','centos',1,'2016-01-11 17:38:22',3),(5,'c#','c#',0,'2016-01-14 18:22:22',3);
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'qa'
--

--
-- Dumping routines for database 'qa'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc_question_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_question_details`(IN id INT)
BEGIN
    SELECT q.id,q.title,q.votes,q.content,q.answers,q.views,q.ct,
      u.username,q.user_id,q.favorite,qv.vote_type,
      CASE WHEN fq.id IS NOT NULL then 1 end as favorite,
      GROUP_CONCAT(t.name SEPARATOR ',') as tags
    FROM question q
      LEFT JOIN auth_user u ON q.user_id = u.id
      LEFT JOIN profile p ON u.id = p.user_id
      LEFT JOIN question_tags qt ON q.id = qt.question_id
      LEFT JOIN tag t ON t.id = qt.tag_id
      LEFT JOIN qvote qv ON q.id = qv.question_id
      LEFT JOIN fquestion fq on q.id = fq.question_id
    WHERE q.id = id
    GROUP BY q.id;
    UPDATE question SET views = views + 1;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_question_orderby_votes_desc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_question_orderby_votes_desc`(IN firstRow INT,IN listRows INT)
BEGIN
    SELECT q.*,u.username,p.pic, GROUP_CONCAT(t.name SEPARATOR ',') as tags
    FROM (
           SELECT id,title,summary,votes,answers,views,user_id,ct
           FROM question
           #             WHERE votes <= ( SELECT votes
           #                              FROM question
           #                              ORDER BY votes DESC,ct DESC
           #                              LIMIT firstRow,1)
           ORDER BY votes DESC,ct desc
           LIMIT firstRow,listRows
         ) q

      JOIN auth_user u ON q.user_id = u.id
      JOIN profile p ON u.id = p.user_id
      JOIN question_tags qt ON q.id = qt.question_id
      JOIN tag t ON t.id = qt.tag_id

    GROUP BY q.id
    ORDER BY votes DESC,ct DESC
    ;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_question_tagged` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_question_tagged`(
  in firstRow int,  -- 跳过行数
  in listRows int,  -- 分页大小
  in tag_name varchar(30))
BEGIN

    -- 根据tag name 查询id
    -- 后续查询根据id进行join 提高查询效率
    set @tag_id = (select id from tag where name = tag_name limit 1);
    select qu.* ,u.username
    from (
           select q.id,q.title,q.votes,q.answers,q.views,q.ct,q.user_id,
             GROUP_CONCAT(t.name SEPARATOR ',') as tags
           from question q
             JOIN question_tags qt on q.id = qt.question_id
             JOIN tag t on t.id = qt.tag_id
           WHERE t.id = @tag_id
           GROUP BY q.id
           ORDER BY q.votes DESC,q.ct DESC
           LIMIT firstRow,listRows
         )qu
      JOIN auth_user u on u.id = qu.user_id;

  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_question_vote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_question_vote`(
  IN uid INT,  -- 用户id
  IN qid INT, -- 问题编号
  IN vote_type INT, -- 投票类型
  IN add_new BOOL  -- 需要添加新的投票记录
)
BEGIN
    DECLARE t_error INTEGER DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET t_error = 1;
    START TRANSACTION;

    DELETE FROM qvote WHERE user_id = uid AND question_id = qid;
    IF add_new = true THEN
      INSERT INTO qvote(user_id,question_id,ct,vote_type)VALUES(uid,qid,now(),vote_type);
    END IF;
    SET @vote_up_count = (SELECT count(1) FROM qvote WHERE question_id = qid and vote_type = 1);
    SET @vote_down_count = (SELECT count(1) FROM qvote WHERE question_id = qid and vote_type = 2);
    UPDATE question SET votes = @vote_up_count - @vote_down_count WHERE id = qid;
    
    IF t_error = 1 THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
    SELECT votes FROM question WHERE id = qid;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-15 19:50:00
