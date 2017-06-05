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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cover_photo_album`
--

/*!40000 ALTER TABLE `cover_photo_album` DISABLE KEYS */;
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
  `user_id_from` bigint(20) unsigned NOT NULL,
  `user_id_to` bigint(20) unsigned NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`friend_requst_id`),
  KEY `u_id_1_fk_idx` (`user_id_from`),
  KEY `friend_request_fk2_idx` (`user_id_to`),
  CONSTRAINT `friend_request_fk1` FOREIGN KEY (`user_id_from`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_request_fk2` FOREIGN KEY (`user_id_to`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friend_request`
--

/*!40000 ALTER TABLE `friend_request` DISABLE KEYS */;
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
  `post_title` varchar(45) NOT NULL,
  `post_context` longtext NOT NULL,
  `post_type` varchar(45) NOT NULL,
  `post_time` datetime NOT NULL,
  `tags` varchar(100) NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `post_fk1_idx` (`user_id`),
  CONSTRAINT `post_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post`
--

/*!40000 ALTER TABLE `post` DISABLE KEYS */;
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
  PRIMARY KEY (`profile_photo_id`),
  KEY `profile_photo_album_fk1_idx` (`user_id`),
  CONSTRAINT `profile_photo_album_fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `profile_photo_album`
--

/*!40000 ALTER TABLE `profile_photo_album` DISABLE KEYS */;
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
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`,`firstName`,`lastName`,`email`,`password`,`day`,`month`,`year`,`sex`,`status`) VALUES 
 (1,'dd','fff','ggg','ttt','dd','1','1','gg',1),
 (3,'sdfqw','ww','ww','w','w','2','1','w',0),
 (4,'q','q','q','q','q','1','1','q',1),
 (5,'jkj','jhj','hjihjkh','hgjhj','d','1','1','sdfsd',1),
 (6,'ghjig','q','abu','123','da','1','1','sdfsd',1),
 (7,'sdfqw','r','a','1','da','1','1','sdfsd',1),
 (8,'w','w','w','w','da','1','1','sdfsd',1),
 (9,'sdfasd','asd','asd','asd','1','1','1','sdfsd',1),
 (10,'as','asdasd','asd','asd','1','1','1','sdfsd',1),
 (11,'v','v','v','v','02','mar','1990','v',1),
 (12,'2','2','2','2','02','mar','1990','3',1),
 (13,'3','3','3@ded.dd','3','02','mar','1990','3',1),
 (14,'4','4','4@sdfsd.dfg','4','16','Jan','2001','Male',1),
 (15,'4','4','4@sdfsd.dfg','4','16','Jan','2001','Male',1),
 (16,'5','5','5@sdf.dfg','5','18','Mar','2001','Female',1),
 (17,'6','6','6@dfg.dfg','6','16','App','2002','Male',1);
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
