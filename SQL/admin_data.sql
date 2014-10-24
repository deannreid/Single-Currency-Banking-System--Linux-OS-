
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin_data`
-- ----------------------------
DROP TABLE IF EXISTS `admin_data`;
CREATE TABLE `admin_data` (
  `PlayerUID` varchar(20) NOT NULL DEFAULT '0',
  `PlayerName` varchar(128) NOT NULL DEFAULT 'Null',
  `AdminLevel` int(1) NOT NULL DEFAULT '0',
  `Instance` int(11) NOT NULL DEFAULT '11',
  PRIMARY KEY (`PlayerUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
