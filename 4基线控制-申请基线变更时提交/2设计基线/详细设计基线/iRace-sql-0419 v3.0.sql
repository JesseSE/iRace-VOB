/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50616
Source Host           : localhost:3306
Source Database       : race

Target Server Type    : MYSQL
Target Server Version : 50616
File Encoding         : 65001

Date: 2015-04-19 14:21:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for advertisment
-- ----------------------------
DROP TABLE IF EXISTS `advertisment`;
CREATE TABLE `advertisment` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `publisher` smallint(6) NOT NULL,
  `link` varchar(255) NOT NULL,
  `pic_url` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_ad` (`publisher`),
  CONSTRAINT `FK_user_ad` FOREIGN KEY (`publisher`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告';

-- ----------------------------
-- Records of advertisment
-- ----------------------------

-- ----------------------------
-- Table structure for apply
-- ----------------------------
DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `user` smallint(6) DEFAULT NULL,
  `race` smallint(6) DEFAULT NULL,
  `group` smallint(6) DEFAULT NULL,
  `team` smallint(6) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Relationship_20` (`team`),
  KEY `FK_apply_group` (`group`),
  KEY `FK_apply_race` (`race`),
  KEY `FK_user_fill_apply` (`user`),
  CONSTRAINT `FK_apply_group` FOREIGN KEY (`group`) REFERENCES `grouprace` (`id`),
  CONSTRAINT `FK_apply_race` FOREIGN KEY (`race`) REFERENCES `race` (`id`),
  CONSTRAINT `FK_Relationship_20` FOREIGN KEY (`team`) REFERENCES `team` (`id`),
  CONSTRAINT `FK_user_fill_apply` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报名表';

-- ----------------------------
-- Records of apply
-- ----------------------------

-- ----------------------------
-- Table structure for apply_info
-- ----------------------------
DROP TABLE IF EXISTS `apply_info`;
CREATE TABLE `apply_info` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `apply` smallint(6) NOT NULL,
  `property` smallint(6) DEFAULT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Relationship_16` (`apply`),
  KEY `FK_Relationship_17` (`property`),
  CONSTRAINT `FK_Relationship_16` FOREIGN KEY (`apply`) REFERENCES `apply` (`id`),
  CONSTRAINT `FK_Relationship_17` FOREIGN KEY (`property`) REFERENCES `property` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of apply_info
-- ----------------------------

-- ----------------------------
-- Table structure for grouprace
-- ----------------------------
DROP TABLE IF EXISTS `grouprace`;
CREATE TABLE `grouprace` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `race` smallint(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `require` longtext,
  PRIMARY KEY (`id`),
  KEY `FK_race_has_group` (`race`),
  CONSTRAINT `FK_race_has_group` FOREIGN KEY (`race`) REFERENCES `race` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛组别';

-- ----------------------------
-- Records of grouprace
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `sender` smallint(6) NOT NULL,
  `receiver` smallint(6) DEFAULT NULL,
  `time` datetime NOT NULL,
  `content` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Relationship_19` (`receiver`),
  KEY `FK_message_to` (`sender`),
  CONSTRAINT `FK_message_to` FOREIGN KEY (`sender`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_Relationship_19` FOREIGN KEY (`receiver`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `race` smallint(6) DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  `time` datetime NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_race_has_notice` (`race`),
  CONSTRAINT `FK_race_has_notice` FOREIGN KEY (`race`) REFERENCES `race` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛公告';

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for organizer
-- ----------------------------
DROP TABLE IF EXISTS `organizer`;
CREATE TABLE `organizer` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `comment` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='赛事举办方';

-- ----------------------------
-- Records of organizer
-- ----------------------------

-- ----------------------------
-- Table structure for property
-- ----------------------------
DROP TABLE IF EXISTS `property`;
CREATE TABLE `property` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `race` smallint(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `require` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_race_has_property` (`race`),
  CONSTRAINT `FK_race_has_property` FOREIGN KEY (`race`) REFERENCES `race` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛的资料属性';

-- ----------------------------
-- Records of property
-- ----------------------------

-- ----------------------------
-- Table structure for race
-- ----------------------------
DROP TABLE IF EXISTS `race`;
CREATE TABLE `race` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `organizer` smallint(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `grade` varchar(50) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `pic_url` varchar(255) DEFAULT NULL,
  `num_rest` int(11) DEFAULT NULL,
  `content` longtext,
  PRIMARY KEY (`id`),
  KEY `FK_own` (`organizer`),
  CONSTRAINT `FK_own` FOREIGN KEY (`organizer`) REFERENCES `organizer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛实体';

-- ----------------------------
-- Records of race
-- ----------------------------

-- ----------------------------
-- Table structure for reward
-- ----------------------------
DROP TABLE IF EXISTS `reward`;
CREATE TABLE `reward` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `group` smallint(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_race_has_reward` (`group`),
  CONSTRAINT `FK_race_has_reward` FOREIGN KEY (`group`) REFERENCES `grouprace` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='奖项';

-- ----------------------------
-- Records of reward
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `privileges` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限，角色';

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for stage
-- ----------------------------
DROP TABLE IF EXISTS `stage`;
CREATE TABLE `stage` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `group` smallint(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_group_have_stage` (`group`),
  CONSTRAINT `FK_group_have_stage` FOREIGN KEY (`group`) REFERENCES `grouprace` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛阶段';

-- ----------------------------
-- Records of stage
-- ----------------------------

-- ----------------------------
-- Table structure for submit
-- ----------------------------
DROP TABLE IF EXISTS `submit`;
CREATE TABLE `submit` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `stage` smallint(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `content` varchar(255) NOT NULL,
  `file_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_stage_has_submit` (`stage`),
  CONSTRAINT `FK_stage_has_submit` FOREIGN KEY (`stage`) REFERENCES `stage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每阶段提交产物';

-- ----------------------------
-- Records of submit
-- ----------------------------

-- ----------------------------
-- Table structure for team
-- ----------------------------
DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `leader` smallint(6) NOT NULL,
  `group` smallint(6) NOT NULL,
  `reward` smallint(6) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `pic_url` varchar(255) NOT NULL,
  `slogan` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_group_have` (`group`),
  KEY `FK_has_leader` (`leader`),
  KEY `FK_team_reward` (`reward`),
  CONSTRAINT `FK_group_have` FOREIGN KEY (`group`) REFERENCES `grouprace` (`id`),
  CONSTRAINT `FK_has_leader` FOREIGN KEY (`leader`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_team_reward` FOREIGN KEY (`reward`) REFERENCES `reward` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of team
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `role` smallint(6) NOT NULL,
  `username` varchar(50) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `tel` decimal(8,0) DEFAULT NULL,
  `qq` decimal(8,0) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pic_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_role` (`role`),
  CONSTRAINT `FK_user_role` FOREIGN KEY (`role`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表格，可以参加比赛';

-- ----------------------------
-- Records of user
-- ----------------------------
