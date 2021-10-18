-- MySQL dump 10.13  Distrib 5.7.35, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: chatdb
-- ------------------------------------------------------
-- Server version	5.7.35-log

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
-- Table structure for table `banned_user_tb`
--

DROP TABLE IF EXISTS `banned_user_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banned_user_tb` (
  `u_id` varchar(32) NOT NULL COMMENT '用户id',
  `status` int(1) NOT NULL DEFAULT '2' COMMENT '2:禁用\n3:已删除',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `reason` varchar(255) DEFAULT NULL COMMENT '无法使用的原因',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '该表id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banned_user_tb`
--

LOCK TABLES `banned_user_tb` WRITE;
/*!40000 ALTER TABLE `banned_user_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `banned_user_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends_tb`
--

DROP TABLE IF EXISTS `friends_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends_tb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` varchar(32) NOT NULL COMMENT '主id',
  `f_id` varchar(32) NOT NULL COMMENT '需要答应的好友id',
  `desc` varchar(255) DEFAULT NULL COMMENT '添加好友的时候的说明',
  `f_nickname` varchar(20) DEFAULT NULL COMMENT '好友的备注',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态\n0.未接受\n1.已接收\n2.已拒绝\n3.已过期\n4.已删除\n5。已被删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends_tb`
--

LOCK TABLES `friends_tb` WRITE;
/*!40000 ALTER TABLE `friends_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `friends_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_tb`
--

DROP TABLE IF EXISTS `group_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_tb` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '群组id',
  `u_id` varchar(32) NOT NULL COMMENT '创建者的id',
  `name` varchar(20) DEFAULT NULL COMMENT '群名称',
  `limit` int(4) NOT NULL DEFAULT '1000' COMMENT '限制入群最大人数',
  `avatar` varchar(255) DEFAULT NULL COMMENT '群头像',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_tb`
--

LOCK TABLES `group_tb` WRITE;
/*!40000 ALTER TABLE `group_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_record`
--

DROP TABLE IF EXISTS `login_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_record` (
  `l_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '该表的id\n',
  `login_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录的时间',
  `login_device` varchar(20) DEFAULT NULL COMMENT '登录的设备',
  `login_ip` varchar(15) NOT NULL COMMENT '登录的ip',
  `u_id` varchar(32) NOT NULL COMMENT '登录的用户id',
  PRIMARY KEY (`l_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_record`
--

LOCK TABLES `login_record` WRITE;
/*!40000 ALTER TABLE `login_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `single_msg_tb`
--

DROP TABLE IF EXISTS `single_msg_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `single_msg_tb` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '该表id',
  `m_send_id` varchar(32) NOT NULL COMMENT '发送者id',
  `m_received_id` varchar(32) NOT NULL COMMENT '接收者id',
  `m_msg_type` int(1) NOT NULL DEFAULT '1' COMMENT '消息的类型\n1.文本\n2.链接\n3.图片\n4.视频\n5.文件',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '1.成功\n2.已撤销',
  `sender_status` int(1) NOT NULL DEFAULT '1' COMMENT '1.显示\n2.删除（不显示）',
  `receiver_status` int(1) NOT NULL COMMENT '1.显示\n2.删除（不显示）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `single_msg_tb`
--

LOCK TABLES `single_msg_tb` WRITE;
/*!40000 ALTER TABLE `single_msg_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `single_msg_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table_name`
--

DROP TABLE IF EXISTS `table_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_name` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '该表id',
  `group_id` int(11) NOT NULL COMMENT '群组id',
  `sender_id` varchar(32) NOT NULL COMMENT '发送者id',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '该消息的状态\n1.成功\n2.已撤销',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建的时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新的时间',
  `msg_type` int(1) NOT NULL DEFAULT '1' COMMENT '消息的类型\n1.文本\n2.链接\n3.图片\n4.视频\n5.文件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table_name`
--

LOCK TABLES `table_name` WRITE;
/*!40000 ALTER TABLE `table_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `table_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tb`
--

DROP TABLE IF EXISTS `user_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tb` (
  `u_id` varchar(32) NOT NULL COMMENT '用户id',
  `u_phone` char(11) DEFAULT NULL COMMENT '手机号码',
  `u_avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `u_nickname` varchar(15) NOT NULL COMMENT '昵称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `u_password` varchar(20) NOT NULL COMMENT '密码',
  `u_id_card` varchar(18) DEFAULT NULL COMMENT '身份证号码',
  `u_birth_day` date DEFAULT NULL COMMENT '出生日期',
  `u_sex` int(1) DEFAULT NULL COMMENT '性别',
  `u_status` int(1) NOT NULL DEFAULT '1' COMMENT '账号状态：0.不可用  1.可用',
  `is_received_request` int(1) DEFAULT '1' COMMENT '是否可以被发送好友请求\n0.不可已\n1.可以',
  `u_email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `u_username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `table_name_u_id_uindex` (`u_id`),
  UNIQUE KEY `table_name_u_phone_uindex` (`u_phone`),
  UNIQUE KEY `user_tb_u_id_card_uindex` (`u_id_card`),
  UNIQUE KEY `user_tb_u_email_uindex` (`u_email`),
  UNIQUE KEY `user_tb_u_username_uindex` (`u_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tb`
--

LOCK TABLES `user_tb` WRITE;
/*!40000 ALTER TABLE `user_tb` DISABLE KEYS */;
INSERT INTO `user_tb` VALUES ('1','11111111',NULL,'wzx的','2021-10-12 16:01:02','123',NULL,NULL,NULL,1,1,NULL,NULL,NULL),('29e209bjck06iicerj41iege5d383djj','111111112',NULL,'蜡笔小新','2021-10-12 18:16:41','1234qwer',NULL,NULL,NULL,1,1,NULL,NULL,NULL),('c13h4kh6cfa9ieh2ra4ei7g6a2464j2j',NULL,NULL,'蜡笔小新','2021-10-12 18:17:47','1234qwer',NULL,NULL,NULL,1,1,'111111112@qq.com',NULL,NULL);
/*!40000 ALTER TABLE `user_tb` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-18 18:19:11
