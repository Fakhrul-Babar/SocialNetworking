-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.7.17-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema socialsite
--

CREATE DATABASE IF NOT EXISTS socialsite;
USE socialsite;

--
-- Definition of table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL,
  `comment_time` datetime NOT NULL,
  `comment_content` longtext NOT NULL,
  `comment_parent_id` int(1) unsigned NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `fk1_idx` (`user_id`),
  KEY `fk2_idx` (`post_id`),
  CONSTRAINT `fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk2` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comment`
--

/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;


--
-- Definition of table `comment_likes`
--

DROP TABLE IF EXISTS `comment_likes`;
CREATE TABLE `comment_likes` (
  `comment_likes_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`comment_likes_id`),
  KEY `fk1_idx` (`comment_id`),
  KEY `fk2_idx` (`user_id`),
  CONSTRAINT `comment_likes_fk1` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_likes_fk2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comment_likes`
--

/*!40000 ALTER TABLE `comment_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_likes` ENABLE KEYS */;


--
-- Definition of table `conversation`
--

DROP TABLE IF EXISTS `conversation`;
CREATE TABLE `conversation` (
  `conversation_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_from` bigint(20) unsigned NOT NULL,
  `user_id_to` bigint(20) unsigned NOT NULL,
  `ip` varchar(15) NOT NULL,
  `time` datetime NOT NULL,
  `text` longtext NOT NULL,
  `status` int(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`conversation_id`),
  KEY `conversation_fk1_idx` (`user_id_from`),
  KEY `conversation_fk2_idx` (`user_id_to`),
  CONSTRAINT `conversation_fk1` FOREIGN KEY (`user_id_from`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `conversation_fk2` FOREIGN KEY (`user_id_to`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conversation`
--

/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;


--
-- Definition of table `conversation_reply`
--

DROP TABLE IF EXISTS `conversation_reply`;
CREATE TABLE `conversation_reply` (
  `conversation_reply_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` bigint(20) unsigned NOT NULL,
  `user_id_from` bigint(20) unsigned NOT NULL,
  `user_id_to` bigint(20) unsigned NOT NULL,
  `reply_text` longtext NOT NULL,
  `ip` varchar(15) NOT NULL,
  `time` datetime NOT NULL,
  `status` int(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`conversation_reply_id`),
  KEY `conversation_reply_fk1_idx` (`conversation_id`),
  KEY `conversation_reply_fk2_idx` (`user_id_from`),
  KEY `conversation_reply_fk3_idx` (`user_id_to`),
  CONSTRAINT `conversation_reply_fk1` FOREIGN KEY (`conversation_id`) REFERENCES `conversation` (`conversation_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `conversation_reply_fk2` FOREIGN KEY (`user_id_from`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `conversation_reply_fk3` FOREIGN KEY (`user_id_to`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conversation_reply`
--

/*!40000 ALTER TABLE `conversation_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation_reply` ENABLE KEYS */;


--
-- Definition of table `cover_photo_album`
--

DROP TABLE IF EXISTS `cover_photo_album`;
CREATE TABLE `cover_photo_album` (
  `cover_photo_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `added_date` date NOT NULL,
  `file_link` varchar(45) NOT NULL,
  PRIMARY KEY (`cover_photo_id`),
  KEY `cover_photo_fk1_idx` (`user_id`),
  CONSTRAINT `cover_photo_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cover_photo_album`
--

/*!40000 ALTER TABLE `cover_photo_album` DISABLE KEYS */;
INSERT INTO `cover_photo_album` (`cover_photo_id`,`user_id`,`added_date`,`file_link`) VALUES 
 (1,21,'2017-06-18','Heart.jpg'),
 (2,22,'2017-06-18','book.jpg'),
 (3,93,'2017-06-18','summer.jpg'),
 (4,94,'2017-06-18','cat.jpg'),
 (5,95,'2017-06-18','cute_kitty.jpg'),
 (6,96,'2017-06-18','alone.jpg'),
 (7,97,'2017-06-18','car.jpg'),
 (8,98,'2017-06-18','Cookie.jpg');
/*!40000 ALTER TABLE `cover_photo_album` ENABLE KEYS */;


--
-- Definition of table `friend`
--

DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `friend_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_1` bigint(20) unsigned NOT NULL,
  `user_id_2` bigint(20) unsigned NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`friend_id`),
  KEY `friend_fk1_idx` (`user_id_1`),
  KEY `friend_fk2_idx` (`user_id_2`),
  CONSTRAINT `friend_fk1` FOREIGN KEY (`user_id_1`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_fk2` FOREIGN KEY (`user_id_2`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friend`
--

/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;


--
-- Definition of table `friend_request`
--

DROP TABLE IF EXISTS `friend_request`;
CREATE TABLE `friend_request` (
  `friend_requst_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `user_id_to` bigint(20) unsigned NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`friend_requst_id`),
  KEY `u_id_1_fk_idx` (`user_id`),
  KEY `friend_request_fk2_idx` (`user_id_to`),
  CONSTRAINT `friend_request_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_request_fk2` FOREIGN KEY (`user_id_to`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friend_request`
--

/*!40000 ALTER TABLE `friend_request` DISABLE KEYS */;
INSERT INTO `friend_request` (`friend_requst_id`,`user_id`,`user_id_to`,`status`) VALUES 
 (25,21,22,0),
 (26,21,93,2),
 (27,21,94,0),
 (28,21,96,0),
 (29,21,98,0),
 (30,21,106,1),
 (31,21,97,0),
 (32,21,95,2),
 (34,93,21,0),
 (35,22,21,2),
 (36,94,21,2),
 (37,96,21,2),
 (38,93,22,2),
 (39,94,22,2),
 (40,22,96,0),
 (41,22,106,1),
 (42,22,98,2),
 (43,22,95,2),
 (44,22,97,2),
 (45,93,94,2),
 (46,93,95,2),
 (47,94,95,2);
/*!40000 ALTER TABLE `friend_request` ENABLE KEYS */;


--
-- Definition of table `person`
--

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `pid` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `person`
--

/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` (`pid`,`name`,`location`) VALUES 
 (1,'nazz','jdd'),
 (2,'sgsfghhfd','fff');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;


--
-- Definition of table `photo`
--

DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo` (
  `photo_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `photo_title` varchar(45) DEFAULT NULL,
  `photo_file_link` varchar(45) NOT NULL,
  `description` mediumtext,
  `added_date` date NOT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `photo_fk1_idx` (`user_id`),
  CONSTRAINT `photo_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `photo`
--

/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;


--
-- Definition of table `photo_album`
--

DROP TABLE IF EXISTS `photo_album`;
CREATE TABLE `photo_album` (
  `photo_album_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `photo_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `added_date` date NOT NULL,
  `desricption` mediumtext,
  `location` varchar(45) DEFAULT NULL,
  `modified_date` date NOT NULL,
  `album_title` varchar(45) NOT NULL,
  PRIMARY KEY (`photo_album_id`),
  KEY `photo_album_fk1_idx` (`photo_id`),
  KEY `photo_album_fk2_idx` (`user_id`),
  CONSTRAINT `photo_album_fk1` FOREIGN KEY (`photo_id`) REFERENCES `photo` (`photo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `photo_album_fk2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `photo_album`
--

/*!40000 ALTER TABLE `photo_album` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo_album` ENABLE KEYS */;


--
-- Definition of table `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `post_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `user_id_to` bigint(20) unsigned NOT NULL,
  `post_title` varchar(45) NOT NULL,
  `post_context` longtext NOT NULL,
  `post_type` varchar(45) NOT NULL,
  `post_time` datetime NOT NULL,
  `tags` varchar(100) NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `post_fk1_idx` (`user_id`),
  KEY `p2_idx` (`user_id_to`),
  CONSTRAINT `post_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pp5` FOREIGN KEY (`user_id_to`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post`
--

/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` (`post_id`,`user_id`,`user_id_to`,`post_title`,`post_context`,`post_type`,`post_time`,`tags`) VALUES 
 (7,22,22,'sample','q','text','2017-05-22 15:52:36','n/a'),
 (8,22,22,'sample','rrr','text','2017-05-22 15:53:14','n/a'),
 (9,21,22,'sample','jhkhjkh','text','2017-05-22 16:15:53','n/a'),
 (10,22,22,'sample','profile','text','2017-05-22 16:22:58','n/a'),
 (11,21,21,'sample','dd','text','2017-05-25 16:02:59','n/a'),
 (12,21,21,'sample','pp','text','2017-05-25 16:03:26','n/a'),
 (17,21,21,'from home','1','test','2017-06-12 01:54:36','n/a'),
 (18,21,21,'from profile','2','test','2017-06-12 01:54:59','n/a'),
 (19,22,21,'df','no','test','2017-06-17 04:11:13','n/a'),
 (20,21,21,'lp','lp','test','2017-06-17 04:12:17','n/a'),
 (22,21,21,'rttyrtyertyrety','rttyrtyrtyrttyrty','test','2017-06-17 21:38:41','n/a'),
 (24,21,21,'rtr','rrtr','test','2017-06-17 21:47:40','n/a'),
 (25,21,21,'tr','tr','test','2017-06-17 21:48:08','n/a'),
 (26,21,22,'hi','nazrul vai','test','2017-06-17 21:54:39','n/a'),
 (27,21,21,'pst update','ok','test','2017-06-17 22:39:34','n/a'),
 (28,21,22,'oop','nazrul vai again','test','2017-06-17 22:44:06','n/a'),
 (29,22,22,'me','my post','test','2017-06-17 22:44:58','n/a'),
 (30,22,21,'hi','im nazrul','test','2017-06-17 22:45:37','n/a'),
 (31,96,96,'oo','ghhg','test','2017-06-17 22:45:37','n/a'),
 (32,21,21,'123','123','test','2017-06-18 00:16:39','n/a'),
 (34,21,21,'title','my my','test','2017-06-18 00:24:11','n/a'),
 (35,21,21,'title','my2','test','2017-06-18 00:31:02','n/a'),
 (36,21,21,'title','my home','test','2017-06-18 00:31:29','n/a'),
 (37,22,21,'title','hi','test','2017-06-18 02:41:46','n/a');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;


--
-- Definition of table `post_likes`
--

DROP TABLE IF EXISTS `post_likes`;
CREATE TABLE `post_likes` (
  `post_likes_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`post_likes_id`),
  KEY `post_likes_fk1_idx` (`post_id`),
  KEY `post_likes_fk2_idx` (`user_id`),
  CONSTRAINT `post_likes_fk1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `post_likes_fk2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post_likes`
--

/*!40000 ALTER TABLE `post_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_likes` ENABLE KEYS */;


--
-- Definition of table `profile_photo_album`
--

DROP TABLE IF EXISTS `profile_photo_album`;
CREATE TABLE `profile_photo_album` (
  `profile_photo_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `added_date` date NOT NULL,
  `file_link` varchar(45) NOT NULL,
  `status` int(10) unsigned NOT NULL,
  PRIMARY KEY (`profile_photo_id`),
  KEY `profile_photo_album_fk1_idx` (`user_id`),
  CONSTRAINT `profile_photo_album_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `profile_photo_album`
--

/*!40000 ALTER TABLE `profile_photo_album` DISABLE KEYS */;
INSERT INTO `profile_photo_album` (`profile_photo_id`,`user_id`,`added_date`,`file_link`,`status`) VALUES 
 (18,21,'2017-06-11','sample.png',0),
 (19,21,'2017-06-11','me.jpg',0),
 (20,21,'2017-06-11','sample.png',0),
 (21,21,'2017-06-11','me.jpg',0),
 (22,22,'2017-06-11','sample.png',0),
 (23,22,'2017-06-11','nazrul.jpg',0),
 (24,22,'2017-06-11','sample.png',0),
 (25,22,'2017-06-11','nazrul.jpg',1),
 (26,21,'2017-06-11','sample.png',0),
 (27,21,'2017-06-11','me.jpg',1),
 (28,93,'2017-06-11','sample.png',1),
 (29,94,'2017-06-11','sample.png',1),
 (30,95,'2017-06-11','sample.png',1),
 (31,96,'2017-06-11','sample.png',1),
 (32,97,'2017-06-11','sample.png',1),
 (33,98,'2017-06-11','sample.png',1),
 (34,106,'2017-06-12','sample.png',1);
/*!40000 ALTER TABLE `profile_photo_album` ENABLE KEYS */;


--
-- Definition of table `share`
--

DROP TABLE IF EXISTS `share`;
CREATE TABLE `share` (
  `share_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `share_text` longtext NOT NULL,
  PRIMARY KEY (`share_id`),
  KEY `share_fk1_idx` (`post_id`),
  KEY `share_fk2_idx` (`user_id`),
  CONSTRAINT `share_fk1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `share_fk2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `share`
--

/*!40000 ALTER TABLE `share` DISABLE KEYS */;
/*!40000 ALTER TABLE `share` ENABLE KEYS */;


--
-- Definition of table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `profile_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `school` varchar(100) DEFAULT NULL,
  `college` varchar(100) DEFAULT NULL,
  `varsity` varchar(100) DEFAULT NULL,
  `degree` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  KEY `fk_1_idx` (`user_id`),
  CONSTRAINT `fk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_profile`
--

/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(15) NOT NULL,
  `lastName` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(45) NOT NULL,
  `day` varchar(2) NOT NULL,
  `month` varchar(3) NOT NULL,
  `year` varchar(4) NOT NULL,
  `sex` varchar(6) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  `regDate` date NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`,`firstName`,`lastName`,`email`,`password`,`day`,`month`,`year`,`sex`,`status`,`regDate`) VALUES 
 (21,'Md','Hridoy','hridoy@yahoo.com','1234','8','Apr','1991','Male',1,'2017-06-11'),
 (22,'Nazrul','Islam','nazrul@gmail.com','1234','15','Feb','2002','Male',1,'2017-06-06'),
 (93,'Arefin','Hossain','arefin@gmail.com','1234','17','Mar','2002','Male',1,'2017-05-22'),
 (94,'Nusrat','Nila','nila@gmail.com','1234','2','Mar','2014','Male',1,'2017-05-22'),
 (95,'Jannat','Jannat','jannat@gmail.com','1234','3','Mar','2016','Male',1,'2017-05-22'),
 (96,'Giash','Uddin','giash@gmail.com','1234','4','Apr','2015','Female',1,'2017-05-22'),
 (97,'Ibrahim','Sheik','ibrahim@gmail.com','1234','19','Jan','2000','Male',1,'2017-05-22'),
 (98,'Almir','Hossain','almir@gmail.com','1234','18','Feb','2001','Male',1,'2017-05-22'),
 (106,'3','3','33@ghj.fg','3','18','Feb','2000','Male',1,'2017-06-12');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `video`
--

DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `video_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `video_title` varchar(45) DEFAULT NULL,
  `video_file_link` varchar(45) NOT NULL,
  `description` mediumtext,
  `added_date` date NOT NULL,
  PRIMARY KEY (`video_id`),
  KEY `video_fk1_idx` (`user_id`),
  CONSTRAINT `video_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `video`
--

/*!40000 ALTER TABLE `video` DISABLE KEYS */;
/*!40000 ALTER TABLE `video` ENABLE KEYS */;


--
-- Definition of table `video_album`
--

DROP TABLE IF EXISTS `video_album`;
CREATE TABLE `video_album` (
  `video_album_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `video_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `added_date` date NOT NULL,
  `desricption` mediumtext,
  `location` varchar(45) DEFAULT NULL,
  `modified_date` date NOT NULL,
  `album_title` varchar(45) NOT NULL,
  PRIMARY KEY (`video_album_id`),
  KEY `video_album_fk1_idx` (`video_id`),
  KEY `video_album_fk2_idx` (`user_id`),
  CONSTRAINT `video_album_fk1` FOREIGN KEY (`video_id`) REFERENCES `video` (`video_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `video_album_fk2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `video_album`
--

/*!40000 ALTER TABLE `video_album` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_album` ENABLE KEYS */;


--
-- Definition of table `wall_photo_album`
--

DROP TABLE IF EXISTS `wall_photo_album`;
CREATE TABLE `wall_photo_album` (
  `wall_photo_album_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `added_date` date NOT NULL,
  `file_link` varchar(45) NOT NULL,
  PRIMARY KEY (`wall_photo_album_id`),
  KEY `wall_photo_fk1_idx` (`post_id`),
  KEY `wall_photo_fk2_idx` (`user_id`),
  CONSTRAINT `wall_photo_fk1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wall_photo_fk2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wall_photo_album`
--

/*!40000 ALTER TABLE `wall_photo_album` DISABLE KEYS */;
/*!40000 ALTER TABLE `wall_photo_album` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
