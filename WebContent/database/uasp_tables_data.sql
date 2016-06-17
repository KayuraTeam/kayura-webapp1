/*
Navicat MySQL Data Transfer

Source Server         : localhost_mysql
Source Server Version : 50615
Source Host           : localhost:3306
Source Database       : kayura_db

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2016-05-24 23:15:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for uasp_aliveapps
-- ----------------------------
DROP TABLE IF EXISTS `uasp_aliveapps`;
CREATE TABLE `uasp_aliveapps` (
  `Tenant_Id` varchar(32) NOT NULL COMMENT '编号',
  `SubApp_Id` char(32) NOT NULL,
  `ActiveTime` datetime NOT NULL,
  `ExpireTime` datetime DEFAULT NULL,
  `Enabled` smallint(6) NOT NULL COMMENT '0 启用；1 禁用；',
  PRIMARY KEY (`Tenant_Id`,`SubApp_Id`),
  KEY `FK_UASP_AliveApp_Ref_SubApp` (`SubApp_Id`),
  CONSTRAINT `FK_UASP_AliveApp_Ref_SubApp` FOREIGN KEY (`SubApp_Id`) REFERENCES `uasp_subapps` (`SubApp_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_AliveApp_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_aliveapps
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_autologins
-- ----------------------------
DROP TABLE IF EXISTS `uasp_autologins`;
CREATE TABLE `uasp_autologins` (
  `Series_Id` char(32) NOT NULL,
  `User_Id` char(32) NOT NULL,
  `Token` varchar(64) NOT NULL,
  `LastUsed` datetime NOT NULL,
  PRIMARY KEY (`Series_Id`),
  KEY `FK_UASP_AutoLogin_Ref_User` (`User_Id`),
  CONSTRAINT `FK_UASP_AutoLogin_Ref_User` FOREIGN KEY (`User_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uasp_autonumbers
-- ----------------------------
DROP TABLE IF EXISTS `uasp_autonumbers`;
CREATE TABLE `uasp_autonumbers` (
  `AutoNumber_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Code` varchar(16) NOT NULL,
  `Description` varchar(1024) DEFAULT NULL,
  `Expression` varchar(1024) DEFAULT NULL COMMENT '${类型}-${年}-${月}-${日}-${计数}',
  `Handler` varchar(256) DEFAULT NULL COMMENT 'java 类型',
  `IsFillLack` bit(1) NOT NULL,
  `Increment` smallint(6) NOT NULL,
  `UpdatedTime` datetime NOT NULL,
  `CustomCycle` varchar(1024) DEFAULT NULL COMMENT '${类型}-${年}-${月}-${日}',
  `CountType` smallint(6) NOT NULL COMMENT '按总计数，年计数，季计数，月计数，周计数，天计数',
  PRIMARY KEY (`AutoNumber_Id`),
  KEY `FK_UASP_AutoNumber_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_AutoNumber_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_autonumbers
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_companies
-- ----------------------------
DROP TABLE IF EXISTS `uasp_companies`;
CREATE TABLE `uasp_companies` (
  `Company_Id` char(32) NOT NULL,
  `Parent_Id` char(32) DEFAULT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Code` varchar(32) NOT NULL,
  `ShortName` varchar(64) NOT NULL,
  `FullName` varchar(1024) DEFAULT NULL,
  `Description` varchar(4096) DEFAULT NULL,
  `IndustryType_Id` varchar(32) DEFAULT NULL,
  `Address` varchar(1024) DEFAULT NULL,
  `Postcode` varchar(8) DEFAULT NULL,
  `Telephone` varchar(128) DEFAULT NULL,
  `Email` varchar(1024) DEFAULT NULL,
  `Fax` varchar(64) DEFAULT NULL,
  `Linkman` varchar(32) DEFAULT NULL,
  `EstaDate` datetime DEFAULT NULL,
  `Serial` int(11) NOT NULL DEFAULT '0',
  `Status` smallint(6) NOT NULL DEFAULT '0',
  `UpdatedTime` datetime NOT NULL,
  PRIMARY KEY (`Company_Id`),
  KEY `FK_UASP_Company_Parent_Ref_ID` (`Parent_Id`),
  KEY `FK_UASP_Company_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Company_Parent_Ref_ID` FOREIGN KEY (`Parent_Id`) REFERENCES `uasp_companies` (`Company_Id`),
  CONSTRAINT `FK_UASP_Company_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_companies
-- ----------------------------
INSERT INTO `uasp_companies` VALUES ('1A1BD4C9259D4E05A16B8B6116B2E682', null, 'DB9611E', 'JTJT', '交通集团', '广东省交通集团有限公司', '', null, null, null, null, null, null, null, null, '0', '1', '2016-05-24 20:59:37');
INSERT INTO `uasp_companies` VALUES ('CB192295EF994D25BA5D8029C5FA69BE', '1A1BD4C9259D4E05A16B8B6116B2E682', 'DB9611E', 'JTJT_DFSW', '东方思维', '广东东方思维科技有限公司', '', null, null, null, null, null, null, null, null, '0', '1', '2016-05-24 21:05:21');

-- ----------------------------
-- Table structure for uasp_departments
-- ----------------------------
DROP TABLE IF EXISTS `uasp_departments`;
CREATE TABLE `uasp_departments` (
  `Department_Id` char(32) NOT NULL,
  `Parent_Id` char(32) DEFAULT NULL,
  `Company_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Code` varchar(32) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Description` varchar(4096) DEFAULT NULL,
  `Serial` int(11) NOT NULL DEFAULT '0',
  `Status` smallint(6) NOT NULL DEFAULT '0',
  `UpdatedTime` datetime NOT NULL,
  PRIMARY KEY (`Department_Id`),
  KEY `FK_UASP_Department_Parent_Ref_ID` (`Parent_Id`),
  KEY `FK_UASP_Department_Ref_Company` (`Company_Id`),
  KEY `FK_UASP_Department_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Department_Parent_Ref_ID` FOREIGN KEY (`Parent_Id`) REFERENCES `uasp_departments` (`Department_Id`),
  CONSTRAINT `FK_UASP_Department_Ref_Company` FOREIGN KEY (`Company_Id`) REFERENCES `uasp_companies` (`Company_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_Department_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_departments
-- ----------------------------
INSERT INTO `uasp_departments` VALUES ('CDA6447F75304382959EBCC2C7739459', null, 'CB192295EF994D25BA5D8029C5FA69BE', 'DB9611E', 'JTJT_DFSW_BB', '本部', '', '0', '1', '2016-05-24 21:05:37');
INSERT INTO `uasp_departments` VALUES ('E1540D75A5C14D68A1B344FC441CFC9A', null, '1A1BD4C9259D4E05A16B8B6116B2E682', 'DB9611E', 'JTJT_BB', '本部', '', '0', '1', '2016-05-24 20:59:54');
INSERT INTO `uasp_departments` VALUES ('09DF9136E8244A0282A65E04F06D7290', 'CDA6447F75304382959EBCC2C7739459', 'CB192295EF994D25BA5D8029C5FA69BE', 'DB9611E', 'DFSW_CWB', '财务部', '', '0', '1', '2016-05-24 21:05:50');
INSERT INTO `uasp_departments` VALUES ('C88484A98E6D4EE7A7BB184FFC94CE83', 'CDA6447F75304382959EBCC2C7739459', 'CB192295EF994D25BA5D8029C5FA69BE', 'DB9611E', 'DFSW_JSZX', '技术中心', '', '0', '1', '2016-05-24 21:08:21');
INSERT INTO `uasp_departments` VALUES ('E2C1213016CE4372A739BE6B5FA21576', 'CDA6447F75304382959EBCC2C7739459', 'CB192295EF994D25BA5D8029C5FA69BE', 'DB9611E', 'DFSW_SCB', '市场部', '', '0', '1', '2016-05-24 21:06:13');

-- ----------------------------
-- Table structure for uasp_dictitems
-- ----------------------------
DROP TABLE IF EXISTS `uasp_dictitems`;
CREATE TABLE `uasp_dictitems` (
  `Item_Id` char(32) NOT NULL,
  `Parent_Id` char(32) DEFAULT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Dict_Id` char(32) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Value` varchar(1024) NOT NULL,
  `Serial` int(11) NOT NULL DEFAULT '0',
  `IsFixed` bit(1) NOT NULL,
  PRIMARY KEY (`Item_Id`),
  KEY `FK_UASP_DictItem_Parent_Ref_ID` (`Parent_Id`),
  KEY `FK_UASP_DictItem_Ref_DictDefine` (`Dict_Id`),
  KEY `FK_UASP_DictItem_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_DictItem_Parent_Ref_ID` FOREIGN KEY (`Parent_Id`) REFERENCES `uasp_dictitems` (`Item_Id`),
  CONSTRAINT `FK_UASP_DictItem_Ref_DictDefine` FOREIGN KEY (`Dict_Id`) REFERENCES `usap_dictdefine` (`Dict_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_DictItem_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_dictitems
-- ----------------------------
INSERT INTO `uasp_dictitems` VALUES ('07C4DD821B0F47558CF950037F614B51', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '广东', 'S01', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('1359C28A2BC64E40B40559BF15598BEA', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '山西', 'S02', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('16FA10FB0DC74124883836112C03CA9C', null, 'DB9611E', 'DBF4DC05D94411E5943F10BF48BBBEC9', '日本', 'JP', '3', '');
INSERT INTO `uasp_dictitems` VALUES ('1B1D8D3CA53642B2A9783B74940094B6', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '安徽', 'S03', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('1C8A9F40E317448081F1C5EA8F9760EF', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '广西', 'Q05', '4', '\0');
INSERT INTO `uasp_dictitems` VALUES ('2193ADE8C63C44F99F48D669BD9336D1', null, 'DB9611E', 'DBF4DC05D94411E5943F10BF48BBBEC9', '中国', 'ZH', '1', '');
INSERT INTO `uasp_dictitems` VALUES ('2706E212622F4659BB88449741503C6A', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '江苏', 'S05', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('30C5FAF026C6485ABCE26BA52BE8620C', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '北京', 'Z01', '2', '\0');
INSERT INTO `uasp_dictitems` VALUES ('313E5CAAB9E44B63A5A3599EF30909C9', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '辽宁', 'S06', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('3ADB586CA492445798323C1C7DBF6336', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '山东', 'S07', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('46491CCBD5EF11E58D5F00163E003262', null, null, '2A8DDB30D5EF11E58D5F00163E003262', '国企', '01', '0', '\0');
INSERT INTO `uasp_dictitems` VALUES ('4DA69EF51F2E4521AC8263AF87856192', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '甘肃', 'S08', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('4F1149D8929A4C079D2D723C60B46ABD', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '湖南', 'S09', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('50B41B91264044DDAFF464A4ED84136E', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '澳门', 'T02', '3', '\0');
INSERT INTO `uasp_dictitems` VALUES ('5C446A35058449F994989897B3CCF995', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '新疆', 'Q01', '4', '\0');
INSERT INTO `uasp_dictitems` VALUES ('6130AD100B934354AC5CDCB5B85F2754', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '浙江', 'S10', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('65A1C2AA5F0A41C9878FCB579E10431A', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '河北', 'S11', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('669CE589D5EF11E58D5F00163E003262', null, null, '2A8DDB30D5EF11E58D5F00163E003262', '私企', '02', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('67AD03B15F59474AB5E42B72AF2BF334', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '青海', 'S11', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('6968AB7C582A4718B2E88D8791AA0CF5', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '江西', 'S12', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('6D9390542F0A44AFB2844DEFB5F8FC3C', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '四川', 'S13', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('6EE1D698B2C04900A542E09357BB4CF0', null, 'DB9611E', 'DBF4DC05D94411E5943F10BF48BBBEC9', '美国', 'US', '2', '');
INSERT INTO `uasp_dictitems` VALUES ('70078BC56C8C40519566CE8516FE3B96', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '云南', 'S14', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('7715DFC3CDED44F0B9855DA15D03525C', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '西藏', 'Q04', '4', '\0');
INSERT INTO `uasp_dictitems` VALUES ('7D2C1DAD584545DC986798051A1001E8', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '宁夏', 'Q02', '4', '\0');
INSERT INTO `uasp_dictitems` VALUES ('7F737034D2C04725967E5332D02014E4', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '河南', 'S15', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('80E70E13C11B4550BB5CBAF522179B0C', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '海南', 'S16', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('86E5C63DA8294E04A8D38DD12012ADAD', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '吉林', 'S17', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('8F872EC2724845948572AA70BA238E53', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '福建', 'S18', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('930DCA4C9392470CBA12F9A83B8ED982', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '香港', 'T01', '3', '\0');
INSERT INTO `uasp_dictitems` VALUES ('93A73FFB492C42CE92FC65D3AA02E38F', null, 'DB9611E', 'DBF4DC05D94411E5943F10BF48BBBEC9', '德国', 'GE', '5', '');
INSERT INTO `uasp_dictitems` VALUES ('9F966C8E44814F59A0C997536B95483F', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '内蒙古', 'Q03', '4', '\0');
INSERT INTO `uasp_dictitems` VALUES ('AF1F9CEEFDAF49ECB5F9FC91CBB89871', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '湖北', 'S19', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('CC70B85161B446709901602DD054D876', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '陕西', 'S20', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('D061BE3577F5419BB1C5843832567500', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '天津', 'Z03', '2', '\0');
INSERT INTO `uasp_dictitems` VALUES ('D42BADAC7F6147F69327D5378DE1CB44', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '台湾', 'S21', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('D6AD00DDD5764A229D018F0FBFEA103A', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '贵州', 'S22', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('D80E8822ECB349A9A1E0BE11642C78C6', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '上海', 'Z02', '2', '\0');
INSERT INTO `uasp_dictitems` VALUES ('E611900B68764077AE94FB462437F281', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '黑龙江', 'S23', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('E715B055EB214A71AEFDADF6F742C2DD', null, 'DB9611E', 'DBF4DC05D94411E5943F10BF48BBBEC9', '英国', 'EN', '4', '');
INSERT INTO `uasp_dictitems` VALUES ('EE7BBE2428D248A3B6F8A5ED294F57AF', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '四川', 'S04', '1', '\0');
INSERT INTO `uasp_dictitems` VALUES ('F6FE6CC20E7F40B38455342FE3018A78', null, null, '745F9DDCD94411E5943F10BF48BBBEC9', '重庆', 'Z04', '2', '\0');

-- ----------------------------
-- Table structure for uasp_employees
-- ----------------------------
DROP TABLE IF EXISTS `uasp_employees`;
CREATE TABLE `uasp_employees` (
  `Employee_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Code` varchar(32) DEFAULT NULL,
  `Name` varchar(64) NOT NULL,
  `Sex` varchar(16) DEFAULT NULL COMMENT '词典',
  `BirthDay` datetime DEFAULT NULL,
  `Phone` varchar(64) DEFAULT NULL,
  `Mobile` varchar(64) DEFAULT NULL,
  `Email` varchar(1024) DEFAULT NULL,
  `Status` smallint(6) NOT NULL,
  `UpdatedTime` datetime NOT NULL,
  PRIMARY KEY (`Employee_Id`),
  KEY `FK_UASP_Employee_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Employee_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_employees
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_filefolders
-- ----------------------------
DROP TABLE IF EXISTS `uasp_filefolders`;
CREATE TABLE `uasp_filefolders` (
  `Folder_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Parent_Id` char(32) DEFAULT NULL,
  `Creator_Id` char(32) DEFAULT NULL,
  `Group_Id` char(32) DEFAULT NULL,
  `Name` varchar(32) NOT NULL,
  `Hidden` bit(1) NOT NULL,
  PRIMARY KEY (`Folder_Id`),
  KEY `FK_UASP_FileFolder_Ref_Creator` (`Creator_Id`),
  KEY `FK_UASP_FileFolder_Ref_Group` (`Group_Id`),
  KEY `FK_UASP_FileFolder_Ref_Parent` (`Parent_Id`),
  KEY `FK_UASP_FileFolder_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_FileFolder_Ref_Creator` FOREIGN KEY (`Creator_Id`) REFERENCES `uasp_users` (`User_Id`),
  CONSTRAINT `FK_UASP_FileFolder_Ref_Group` FOREIGN KEY (`Group_Id`) REFERENCES `uasp_groups` (`Group_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_FileFolder_Ref_Parent` FOREIGN KEY (`Parent_Id`) REFERENCES `uasp_filefolders` (`Folder_Id`),
  CONSTRAINT `FK_UASP_FileFolder_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_filefolders
-- ----------------------------
INSERT INTO `uasp_filefolders` VALUES ('F732A19CDF7511E58D5F00163E003262', null, null, 'BD817FA7716E11E586C6D8CB8A43F8DD', null, '培训文档', '\0');
INSERT INTO `uasp_filefolders` VALUES ('B1900536E04011E59888D8CB8A43F8DD', null, 'F732A19CDF7511E58D5F00163E003262', 'BD817FA7716E11E586C6D8CB8A43F8DD', null, '教学视频', '\0');
INSERT INTO `uasp_filefolders` VALUES ('D8FCD6DBE04011E59888D8CB8A43F8DD', null, 'F732A19CDF7511E58D5F00163E003262', 'BD817FA7716E11E586C6D8CB8A43F8DD', null, '操作手册', '\0');
INSERT INTO `uasp_filefolders` VALUES ('0B360E55DF8211E58D5F00163E003262', 'DB9611E', null, 'ED5591AB52CC489F8A52445CF6125CD8', null, '个人照片', '\0');
INSERT INTO `uasp_filefolders` VALUES ('0F2D7BE1E02011E59888D8CB8A43F8DD', 'DB9611E', null, '18C5BD7D457647ECB3F688D4ECF1C0C8', null, '大广高速', '\0');
INSERT INTO `uasp_filefolders` VALUES ('2E5421CDDF7611E58D5F00163E003262', 'DB9611E', null, '18C5BD7D457647ECB3F688D4ECF1C0C8', null, '工作文档', '\0');
INSERT INTO `uasp_filefolders` VALUES ('43D97ADADF7611E58D5F00163E003262', 'DB9611E', null, 'ED5591AB52CC489F8A52445CF6125CD8', 'EFA7A76EDF7111E58D5F00163E003262', '招头标', '\0');
INSERT INTO `uasp_filefolders` VALUES ('72523D23DF7C11E58D5F00163E003262', 'DB9611E', null, 'ED5591AB52CC489F8A52445CF6125CD8', '3FAA7E74DF7C11E58D5F00163E003262', '招头标', '\0');
INSERT INTO `uasp_filefolders` VALUES ('A8E0231EDF8D11E58FA3D8CB8A43F8DD', 'DB9611E', null, 'ED5591AB52CC489F8A52445CF6125CD8', 'EFA7A76EDF7111E58D5F00163E003262', '合同文件', '\0');

-- ----------------------------
-- Table structure for uasp_fileinfos
-- ----------------------------
DROP TABLE IF EXISTS `uasp_fileinfos`;
CREATE TABLE `uasp_fileinfos` (
  `File_Id` char(32) NOT NULL,
  `FileSize` int(11) NOT NULL,
  `ContentType` varchar(512) NOT NULL,
  `LogicPath` varchar(2048) DEFAULT NULL,
  `MD5` varchar(512) DEFAULT NULL,
  `AllowChange` bit(1) NOT NULL,
  `IsEncrypted` bit(1) NOT NULL,
  `Salt` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`File_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_fileinfos
-- ----------------------------
INSERT INTO `uasp_fileinfos` VALUES ('2525C99402D5485499596CA1BE5FD1E1', '3823760', 'image/jpeg', '{DiskA}\\20160301\\', 'f0955a39207a7477ddc29da7033ce457', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('508D598327C247CAABF3B18F59E561D3', '1974609', 'application/pdf', '{DiskA}\\20160522\\', '107c8f3697e2bca4df990d1a2789898a', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('5362C80A155A4D7294CA8362F81D0EC1', '1239040', 'application/msword', '{DiskA}\\20160301\\', '9a52a7126400a031724d5651bc147757', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('59D2CC56D9D54AC0A48B405233B87E48', '190464', 'application/octet-stream', '{DiskA}\\20160301\\', 'e718c1bcf01ac0fd8fd3f8a98f6a3e33', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('65D2737FAC8E4F5E85FE292FA9DB46B1', '58368', 'application/vnd.ms-excel', '{DiskA}\\20160522\\', '8fac5bc58399ce20604f4e2d6bb471b5', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('87F95AB9319E486CAB12C0B1F923FF7F', '2737738', 'application/pdf', '{DiskA}\\20160522\\', '2f77bb1d49db2baf37df606e230b3cb4', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('959E582E017046319F7F26F09E51AE00', '107', 'application/octet-stream', '{DiskA}\\20160522\\', '9cea42ee3fe28272b7d2c7becedcd67d', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('A2E0FC89C71B46BFB30159F1F9D7206E', '641', 'application/octet-stream', '{DiskA}\\20160522\\', 'd9ed476a26bdc9e2fa9f87ea2655e8d1', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('A9737667B1914C7BA28685B64020E970', '439844', 'application/octet-stream', '{DiskA}\\20160301\\', '402d25834a42765139237ad05f4792f9', '\0', '', 'OgkVFJ1wD3z7rvMx0rCOyg==');
INSERT INTO `uasp_fileinfos` VALUES ('CC1E4A50429C4D2B839CBF1306BD4638', '11264', 'application/vnd.ms-excel', '{DiskA}\\20160301\\', 'e4e63ce98ce9e6c6a23763138c5b675d', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('CDDDDC3A6CB84BDDAD4B46BC1191A6B6', '565248', 'application/vnd.ms-excel', '{DiskA}\\20160522\\', '508c065b8f1559f9273adbc5e6362587', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('DF26878045CC40DA8EAF5E1484D82D35', '4936', 'text/xml', '{DiskA}\\20160522\\', 'ad1429497581d315f85b5ff76b79300c', '\0', '\0', null);

-- ----------------------------
-- Table structure for uasp_filerelations
-- ----------------------------
DROP TABLE IF EXISTS `uasp_filerelations`;
CREATE TABLE `uasp_filerelations` (
  `Fr_Id` char(32) NOT NULL,
  `File_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Folder_Id` char(32) DEFAULT NULL,
  `BizId` varchar(64) DEFAULT NULL,
  `Category` varchar(1024) DEFAULT NULL,
  `FileName` varchar(1024) NOT NULL,
  `Postfix` varchar(32) DEFAULT NULL,
  `UploaderId` varchar(64) DEFAULT NULL,
  `UploaderName` varchar(64) DEFAULT NULL,
  `UploadTime` datetime DEFAULT NULL,
  `Downloads` int(11) NOT NULL DEFAULT '0',
  `Serial` int(11) NOT NULL DEFAULT '0',
  `Tags` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`Fr_Id`),
  KEY `FK_UASP_FileRelation_Ref_FileInfo` (`File_Id`),
  KEY `FK_UASP_FileRelation_Ref_Folder` (`Folder_Id`),
  KEY `FK_UASP_FileRelation_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_FileRelation_Ref_FileInfo` FOREIGN KEY (`File_Id`) REFERENCES `uasp_fileinfos` (`File_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_FileRelation_Ref_Folder` FOREIGN KEY (`Folder_Id`) REFERENCES `uasp_filefolders` (`Folder_Id`) ON DELETE SET NULL,
  CONSTRAINT `FK_UASP_FileRelation_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_filerelations
-- ----------------------------
INSERT INTO `uasp_filerelations` VALUES ('1E83E94063EA4B4497BF9BC60207FF8A', '5362C80A155A4D7294CA8362F81D0EC1', null, null, 'C3CD06B2-1AE5-481F-A3BF-ADC177CD586F', '', '利通企业应用开发平台EADP集成开发手册.doc', 'doc', 'BD817FA7716E11E586C6D8CB8A43F8DD', '根管理员', '2016-03-01 10:09:12', '2', '0', '');
INSERT INTO `uasp_filerelations` VALUES ('21D8CA024D0F4E53B0F7A324CDFFB4B1', '508D598327C247CAABF3B18F59E561D3', 'DB9611E', null, '8F6528BEEAB411E5AD4E10BF48BBBEC9', '合同', '软件成熟度_CMM.pdf', 'pdf', 'ED5591AB52CC489F8A52445CF6125CD8', null, '2016-05-22 20:51:31', '1', '0', null);
INSERT INTO `uasp_filerelations` VALUES ('244D0CD2113349488A987ECAE2199285', '87F95AB9319E486CAB12C0B1F923FF7F', 'DB9611E', '0B360E55DF8211E58D5F00163E003262', null, null, '统一建模语言(UML)参考手册——基本概念.pdf', 'pdf', 'ED5591AB52CC489F8A52445CF6125CD8', null, '2016-05-22 19:33:14', '0', '0', null);
INSERT INTO `uasp_filerelations` VALUES ('27A23C77B50740D4BE57AAD451E12B7A', 'A9737667B1914C7BA28685B64020E970', null, null, 'C3CD06B2-1AE5-481F-A3BF-ADC177CD586F', '', 'kayura_uasp_data.sql', 'sql', 'BD817FA7716E11E586C6D8CB8A43F8DD', '根管理员', '2016-03-01 10:17:19', '0', '0', '');
INSERT INTO `uasp_filerelations` VALUES ('3CB72C5F3AEC4B3F9BB6D7EEA2AE4699', '65D2737FAC8E4F5E85FE292FA9DB46B1', 'DB9611E', '0B360E55DF8211E58D5F00163E003262', null, null, '隆驰JOQ地图链接及指导.xls', 'xls', 'ED5591AB52CC489F8A52445CF6125CD8', null, '2016-05-22 19:33:21', '0', '0', null);
INSERT INTO `uasp_filerelations` VALUES ('4A02B887E7C84DE4B53570B28CBE8BFC', 'CDDDDC3A6CB84BDDAD4B46BC1191A6B6', 'DB9611E', null, '8F6528BEEAB411E5AD4E10BF48BBBEC9', '归档', '20151014090412469.xls', 'xls', 'ED5591AB52CC489F8A52445CF6125CD8', null, '2016-05-22 20:51:39', '1', '0', null);
INSERT INTO `uasp_filerelations` VALUES ('74BAD8838C4C4C639E6693FE4E111205', 'CC1E4A50429C4D2B839CBF1306BD4638', null, null, 'C3CD06B2-1AE5-481F-A3BF-ADC177CD586F', '', '工作流待完善功能.xls', 'xls', 'BD817FA7716E11E586C6D8CB8A43F8DD', '根管理员', '2016-03-01 10:03:55', '7', '0', '');
INSERT INTO `uasp_filerelations` VALUES ('7A7976D2A6504938B557BD4148066C23', 'DF26878045CC40DA8EAF5E1484D82D35', 'DB9611E', null, '8F6528BEEAB411E5AD4E10BF48BBBEC9', '归档', 'java_codetemplates.xml', 'xml', 'ED5591AB52CC489F8A52445CF6125CD8', null, '2016-05-22 20:52:10', '1', '0', null);
INSERT INTO `uasp_filerelations` VALUES ('8DDE35DDB3714842B5327C0BE9F55F16', '65D2737FAC8E4F5E85FE292FA9DB46B1', 'DB9611E', null, '8F6528BEEAB411E5AD4E10BF48BBBEC9', '归档', '隆驰JOQ地图链接及指导.xls', 'xls', 'ED5591AB52CC489F8A52445CF6125CD8', null, '2016-05-22 20:51:37', '1', '0', null);
INSERT INTO `uasp_filerelations` VALUES ('9B997D9AB50349F4A3D818E165A787B6', '59D2CC56D9D54AC0A48B405233B87E48', null, null, 'C3CD06B2-1AE5-481F-A3BF-ADC177CD586F', '', 'serf-1.2.1.tar.bz2', 'bz2', 'BD817FA7716E11E586C6D8CB8A43F8DD', '根管理员', '2016-03-01 10:12:01', '3', '0', '');
INSERT INTO `uasp_filerelations` VALUES ('A359445F4867461E9378A264706E693E', '2525C99402D5485499596CA1BE5FD1E1', null, null, 'C3CD06B2-1AE5-481F-A3BF-ADC177CD586F', '', 'IMG_20150117_184544.jpg', 'jpg', 'BD817FA7716E11E586C6D8CB8A43F8DD', '根管理员', '2016-03-01 10:11:30', '2', '0', '');

-- ----------------------------
-- Table structure for uasp_fileshares
-- ----------------------------
DROP TABLE IF EXISTS `uasp_fileshares`;
CREATE TABLE `uasp_fileshares` (
  `FileShare_Id` char(32) NOT NULL,
  `Sharer_Id` char(32) NOT NULL,
  `Receiver_Id` char(32) NOT NULL,
  `Folder_Id` char(32) DEFAULT NULL,
  `Fr_Id` char(32) DEFAULT NULL,
  `CreateTime` datetime NOT NULL,
  PRIMARY KEY (`FileShare_Id`),
  KEY `FK_UASP_FileShare_Ref_Folder` (`Folder_Id`),
  KEY `FK_UASP_FileShare_Ref_Receiver` (`Receiver_Id`),
  KEY `FK_UASP_FileShare_Ref_Relation` (`Fr_Id`),
  KEY `FK_UASP_FileShare_Ref_Sharer` (`Sharer_Id`),
  CONSTRAINT `FK_UASP_FileShare_Ref_Folder` FOREIGN KEY (`Folder_Id`) REFERENCES `uasp_filefolders` (`Folder_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_FileShare_Ref_Receiver` FOREIGN KEY (`Receiver_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_FileShare_Ref_Relation` FOREIGN KEY (`Fr_Id`) REFERENCES `uasp_filerelations` (`Fr_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_FileShare_Ref_Sharer` FOREIGN KEY (`Sharer_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_fileshares
-- ----------------------------
INSERT INTO `uasp_fileshares` VALUES ('97867ABCDF8B11E58FA3D8CB8A43F8DD', '18C5BD7D457647ECB3F688D4ECF1C0C8', 'ED5591AB52CC489F8A52445CF6125CD8', '2E5421CDDF7611E58D5F00163E003262', null, '2016-03-01 16:58:12');
INSERT INTO `uasp_fileshares` VALUES ('ED083B30E01F11E59888D8CB8A43F8DD', '18C5BD7D457647ECB3F688D4ECF1C0C8', 'ED5591AB52CC489F8A52445CF6125CD8', '0F2D7BE1E02011E59888D8CB8A43F8DD', null, '2016-03-02 10:41:32');

-- ----------------------------
-- Table structure for uasp_grouproles
-- ----------------------------
DROP TABLE IF EXISTS `uasp_grouproles`;
CREATE TABLE `uasp_grouproles` (
  `Group_Id` char(32) NOT NULL,
  `Role_Id` char(32) NOT NULL,
  PRIMARY KEY (`Group_Id`,`Role_Id`),
  KEY `FK_UASP_GroupRole_Ref_Role` (`Role_Id`),
  CONSTRAINT `FK_UASP_GroupRole_Ref_Group` FOREIGN KEY (`Group_Id`) REFERENCES `uasp_groups` (`Group_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_GroupRole_Ref_Role` FOREIGN KEY (`Role_Id`) REFERENCES `uasp_roles` (`Role_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_grouproles
-- ----------------------------
INSERT INTO `uasp_grouproles` VALUES ('3FAA7E74DF7C11E58D5F00163E003262', '5870A5B5DF7C11E58D5F00163E003262');
INSERT INTO `uasp_grouproles` VALUES ('EFA7A76EDF7111E58D5F00163E003262', 'B879FD7CDF7211E58D5F00163E003262');

-- ----------------------------
-- Table structure for uasp_groups
-- ----------------------------
DROP TABLE IF EXISTS `uasp_groups`;
CREATE TABLE `uasp_groups` (
  `Group_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Name` varchar(64) NOT NULL,
  `Enabled` bit(1) NOT NULL COMMENT '0 禁用；1 启用；',
  PRIMARY KEY (`Group_Id`),
  KEY `FK_UASP_Group_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Group_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_groups
-- ----------------------------
INSERT INTO `uasp_groups` VALUES ('3FAA7E74DF7C11E58D5F00163E003262', 'DB9611E', '项目小组B', '');
INSERT INTO `uasp_groups` VALUES ('EFA7A76EDF7111E58D5F00163E003262', 'DB9611E', '项目小组A', '');

-- ----------------------------
-- Table structure for uasp_groupusers
-- ----------------------------
DROP TABLE IF EXISTS `uasp_groupusers`;
CREATE TABLE `uasp_groupusers` (
  `Group_Id` char(32) NOT NULL,
  `User_Id` char(32) NOT NULL,
  PRIMARY KEY (`Group_Id`,`User_Id`),
  KEY `FK_UASP_GroupUser_Ref_User` (`User_Id`),
  CONSTRAINT `FK_UASP_GroupUser_Ref_Group` FOREIGN KEY (`Group_Id`) REFERENCES `uasp_groups` (`Group_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_GroupUser_Ref_User` FOREIGN KEY (`User_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_groupusers
-- ----------------------------
INSERT INTO `uasp_groupusers` VALUES ('EFA7A76EDF7111E58D5F00163E003262', '18C5BD7D457647ECB3F688D4ECF1C0C8');

-- ----------------------------
-- Table structure for uasp_identities
-- ----------------------------
DROP TABLE IF EXISTS `uasp_identities`;
CREATE TABLE `uasp_identities` (
  `Identity_Id` char(32) NOT NULL,
  `Department_Id` char(32) DEFAULT NULL,
  `Position_Id` char(32) DEFAULT NULL,
  `Employee_Id` char(32) DEFAULT NULL,
  PRIMARY KEY (`Identity_Id`),
  KEY `FK_UASP_Identity_Ref_Department` (`Department_Id`),
  KEY `FK_UASP_Identity_Ref_Employee` (`Employee_Id`),
  KEY `FK_UASP_Identity_Ref_Position` (`Position_Id`),
  CONSTRAINT `FK_UASP_Identity_Ref_Department` FOREIGN KEY (`Department_Id`) REFERENCES `uasp_departments` (`Department_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_Identity_Ref_Employee` FOREIGN KEY (`Employee_Id`) REFERENCES `uasp_employees` (`Employee_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_Identity_Ref_Position` FOREIGN KEY (`Position_Id`) REFERENCES `uasp_positions` (`Position_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_identities
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_menuitems
-- ----------------------------
DROP TABLE IF EXISTS `uasp_menuitems`;
CREATE TABLE `uasp_menuitems` (
  `MenuItem_Id` char(32) NOT NULL,
  `Parent_Id` char(32) DEFAULT NULL,
  `MenuPlan_Id` char(32) NOT NULL,
  `Module_Id` char(32) DEFAULT NULL,
  `Type` smallint(6) NOT NULL COMMENT '1 菜单分类；2 菜单项；',
  `DisplayName` varchar(64) DEFAULT NULL,
  `Description` varchar(1024) DEFAULT NULL,
  `Icon` varchar(2048) DEFAULT NULL,
  `Serial` int(11) DEFAULT NULL,
  `Enabled` bit(1) NOT NULL COMMENT '0 禁用；1 启用；',
  PRIMARY KEY (`MenuItem_Id`),
  KEY `FK_UASP_MenuItem_Parent_Ref_ID` (`Parent_Id`),
  KEY `FK_UASP_MenuItem_Ref_MenuScheme` (`MenuPlan_Id`),
  KEY `FK_UASP_MenuItem_Ref_Module` (`Module_Id`),
  CONSTRAINT `FK_UASP_MenuItem_Parent_Ref_ID` FOREIGN KEY (`Parent_Id`) REFERENCES `uasp_menuitems` (`MenuItem_Id`),
  CONSTRAINT `FK_UASP_MenuItem_Ref_MenuScheme` FOREIGN KEY (`MenuPlan_Id`) REFERENCES `uasp_menuschemes` (`MenuScheme_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_MenuItem_Ref_Module` FOREIGN KEY (`Module_Id`) REFERENCES `uasp_modules` (`Module_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_menuitems
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_menuschemes
-- ----------------------------
DROP TABLE IF EXISTS `uasp_menuschemes`;
CREATE TABLE `uasp_menuschemes` (
  `MenuScheme_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '此值为NULL时，为公共菜单方案',
  `Code` varchar(32) NOT NULL,
  `Name` varchar(64) NOT NULL,
  PRIMARY KEY (`MenuScheme_Id`),
  KEY `FK_UASP_MenuScheme_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_MenuScheme_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_menuschemes
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_modules
-- ----------------------------
DROP TABLE IF EXISTS `uasp_modules`;
CREATE TABLE `uasp_modules` (
  `Module_Id` char(32) NOT NULL,
  `SubApp_Id` char(32) DEFAULT NULL,
  `Parent_Id` char(32) DEFAULT NULL,
  `Type` smallint(6) NOT NULL COMMENT '1 模块分类；2 模块项；',
  `Code` varchar(32) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Description` varchar(1024) DEFAULT NULL,
  `Icon` varchar(2048) DEFAULT NULL,
  `URI` varchar(2048) DEFAULT NULL,
  `Serial` int(11) NOT NULL,
  `Actions` varchar(4096) DEFAULT NULL,
  `Enabled` bit(1) NOT NULL COMMENT '0 禁用；1 可用；',
  PRIMARY KEY (`Module_Id`),
  KEY `FK_UASP_Module_Parent_Ref_ID` (`Parent_Id`),
  KEY `FK_UASP_Module_Ref_SubApp` (`SubApp_Id`),
  CONSTRAINT `FK_UASP_Module_Parent_Ref_ID` FOREIGN KEY (`Parent_Id`) REFERENCES `uasp_modules` (`Module_Id`),
  CONSTRAINT `FK_UASP_Module_Ref_SubApp` FOREIGN KEY (`SubApp_Id`) REFERENCES `uasp_subapps` (`SubApp_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_modules
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_numbercount
-- ----------------------------
DROP TABLE IF EXISTS `uasp_numbercount`;
CREATE TABLE `uasp_numbercount` (
  `NumberCount_Id` char(32) NOT NULL,
  `AutoNumber_Id` char(32) DEFAULT NULL,
  `CountCycle` varchar(1024) DEFAULT NULL,
  `Count` int(11) DEFAULT NULL,
  `Remark` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`NumberCount_Id`),
  KEY `FK_UASP_NumberCount_Ref_AutoNumber` (`AutoNumber_Id`),
  CONSTRAINT `FK_UASP_NumberCount_Ref_AutoNumber` FOREIGN KEY (`AutoNumber_Id`) REFERENCES `uasp_autonumbers` (`AutoNumber_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_numbercount
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_positions
-- ----------------------------
DROP TABLE IF EXISTS `uasp_positions`;
CREATE TABLE `uasp_positions` (
  `Position_Id` char(32) NOT NULL,
  `Department_Id` char(32) DEFAULT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Code` varchar(32) DEFAULT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Level` int(11) DEFAULT NULL COMMENT '0-9 等级由高至低. 如：0 经理级别, 1 主管级别. 可由业务需要定义.',
  `Description` varchar(4096) DEFAULT NULL,
  `Serial` int(11) NOT NULL DEFAULT '0',
  `Status` smallint(6) NOT NULL DEFAULT '0',
  `UpdatedTime` datetime NOT NULL,
  PRIMARY KEY (`Position_Id`),
  KEY `FK_UASP_Position_Ref_Department` (`Department_Id`),
  KEY `FK_UASP_Position_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Position_Ref_Department` FOREIGN KEY (`Department_Id`) REFERENCES `uasp_departments` (`Department_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_Position_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_positions
-- ----------------------------
INSERT INTO `uasp_positions` VALUES ('108755A4660F473D8AFB95008E7FD09A', 'C88484A98E6D4EE7A7BB184FFC94CE83', 'DB9611E', 'JSZX_XM', '项目经理', '2', '', '0', '1', '2016-05-24 21:36:10');
INSERT INTO `uasp_positions` VALUES ('2E23DBEBDF2A4008A3207002863201E8', 'C88484A98E6D4EE7A7BB184FFC94CE83', 'DB9611E', 'JSZX_JL', '部门经理', '1', '', '0', '1', '2016-05-24 21:35:20');
INSERT INTO `uasp_positions` VALUES ('3F4A8DD0C14F4487B7E1514631719FD8', 'C88484A98E6D4EE7A7BB184FFC94CE83', 'DB9611E', 'JSZX_YG', '部门员工', '3', '', '0', '1', '2016-05-24 21:36:59');
INSERT INTO `uasp_positions` VALUES ('8FA541F5119D4F07BF77589C309BF7B4', 'C88484A98E6D4EE7A7BB184FFC94CE83', 'DB9611E', 'JSZX_ZG', '部门主管', '1', '', '0', '1', '2016-05-24 21:37:14');
INSERT INTO `uasp_positions` VALUES ('F3CBD65CD1A840C1A232A63548E965DE', 'C88484A98E6D4EE7A7BB184FFC94CE83', 'DB9611E', 'JSZX_JS', '技术经理', '2', '', '0', '1', '2016-05-24 21:36:34');

-- ----------------------------
-- Table structure for uasp_profiles
-- ----------------------------
DROP TABLE IF EXISTS `uasp_profiles`;
CREATE TABLE `uasp_profiles` (
  `Profile_Id` char(32) NOT NULL,
  `User_Id` char(32) NOT NULL,
  `Category` varchar(2048) NOT NULL,
  `ObjectType` varchar(2048) NOT NULL,
  `ValueType` varchar(2048) NOT NULL COMMENT 'xml, json',
  `Content` text NOT NULL,
  PRIMARY KEY (`Profile_Id`),
  KEY `FK_UASP_Profiles_Ref_User` (`User_Id`),
  CONSTRAINT `FK_UASP_Profiles_Ref_User` FOREIGN KEY (`User_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_profiles
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_recyclenumbers
-- ----------------------------
DROP TABLE IF EXISTS `uasp_recyclenumbers`;
CREATE TABLE `uasp_recyclenumbers` (
  `RecycleNumber_Id` char(32) NOT NULL,
  `NumberCount_Id` char(32) NOT NULL,
  `RecycleNo` varchar(1024) NOT NULL,
  PRIMARY KEY (`RecycleNumber_Id`),
  KEY `FK_UASP_RecycleNumber_Ref_NumberCount` (`NumberCount_Id`),
  CONSTRAINT `FK_UASP_RecycleNumber_Ref_NumberCount` FOREIGN KEY (`NumberCount_Id`) REFERENCES `uasp_numbercount` (`NumberCount_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_recyclenumbers
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_rolemodules
-- ----------------------------
DROP TABLE IF EXISTS `uasp_rolemodules`;
CREATE TABLE `uasp_rolemodules` (
  `Role_Id` char(32) NOT NULL,
  `Module_Id` char(32) NOT NULL,
  `Actions` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`Role_Id`,`Module_Id`),
  KEY `FK_UASP_RoleModule_Ref_Module` (`Module_Id`),
  CONSTRAINT `FK_UASP_RoleModel_Ref_Role` FOREIGN KEY (`Role_Id`) REFERENCES `uasp_roles` (`Role_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_RoleModule_Ref_Module` FOREIGN KEY (`Module_Id`) REFERENCES `uasp_modules` (`Module_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_rolemodules
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_roles
-- ----------------------------
DROP TABLE IF EXISTS `uasp_roles`;
CREATE TABLE `uasp_roles` (
  `Role_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Name` varchar(64) NOT NULL,
  `Enabled` bit(1) NOT NULL COMMENT '0 禁用；1 启用；',
  PRIMARY KEY (`Role_Id`),
  KEY `FK_UASP_Role_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Role_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_roles
-- ----------------------------
INSERT INTO `uasp_roles` VALUES ('5870A5B5DF7C11E58D5F00163E003262', 'DB9611E', '系统管理员', '');
INSERT INTO `uasp_roles` VALUES ('B879FD7CDF7211E58D5F00163E003262', 'DB9611E', '所有成员', '');

-- ----------------------------
-- Table structure for uasp_settings
-- ----------------------------
DROP TABLE IF EXISTS `uasp_settings`;
CREATE TABLE `uasp_settings` (
  `Registry_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Path` varchar(4096) NOT NULL,
  `ItemKey` varchar(64) NOT NULL,
  `ItemValue` text,
  PRIMARY KEY (`Registry_Id`),
  KEY `FK_UASP_Settings_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Settings_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_settings
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_subapps
-- ----------------------------
DROP TABLE IF EXISTS `uasp_subapps`;
CREATE TABLE `uasp_subapps` (
  `SubApp_Id` char(32) NOT NULL,
  `Code` varchar(32) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Enabled` smallint(6) NOT NULL COMMENT '0 禁用；1 启动',
  PRIMARY KEY (`SubApp_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_subapps
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_tablemeta
-- ----------------------------
DROP TABLE IF EXISTS `uasp_tablemeta`;
CREATE TABLE `uasp_tablemeta` (
  `Meta_Id` int(11) NOT NULL AUTO_INCREMENT,
  `TableName` varchar(1024) NOT NULL,
  `TableKey` varchar(64) NOT NULL,
  `MetaKey` varchar(64) NOT NULL,
  `MetaValue` text,
  PRIMARY KEY (`Meta_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_tablemeta
-- ----------------------------

-- ----------------------------
-- Table structure for uasp_tenants
-- ----------------------------
DROP TABLE IF EXISTS `uasp_tenants`;
CREATE TABLE `uasp_tenants` (
  `Tenant_Id` varchar(32) NOT NULL COMMENT '编号',
  `DisplayName` varchar(256) NOT NULL,
  `Company` varchar(256) DEFAULT NULL,
  `Telephone` varchar(128) DEFAULT NULL,
  `ActiveTime` datetime NOT NULL,
  `ExpireTime` datetime DEFAULT NULL,
  `Enabled` smallint(6) NOT NULL COMMENT '0 启用；1 禁用；',
  PRIMARY KEY (`Tenant_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_tenants
-- ----------------------------
INSERT INTO `uasp_tenants` VALUES ('DB9611E', '开发测试租户', null, null, '2016-03-01 09:33:16', null, '1');

-- ----------------------------
-- Table structure for uasp_userroles
-- ----------------------------
DROP TABLE IF EXISTS `uasp_userroles`;
CREATE TABLE `uasp_userroles` (
  `Role_Id` char(32) NOT NULL,
  `User_Id` char(32) NOT NULL,
  PRIMARY KEY (`Role_Id`,`User_Id`),
  KEY `FK_UASP_UserRole_Ref_User` (`User_Id`),
  CONSTRAINT `FK_UASP_UserRole_Ref_Role` FOREIGN KEY (`Role_Id`) REFERENCES `uasp_roles` (`Role_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_UserRole_Ref_User` FOREIGN KEY (`User_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_userroles
-- ----------------------------
INSERT INTO `uasp_userroles` VALUES ('B879FD7CDF7211E58D5F00163E003262', '18C5BD7D457647ECB3F688D4ECF1C0C8');
INSERT INTO `uasp_userroles` VALUES ('5870A5B5DF7C11E58D5F00163E003262', 'ED5591AB52CC489F8A52445CF6125CD8');
INSERT INTO `uasp_userroles` VALUES ('B879FD7CDF7211E58D5F00163E003262', 'ED5591AB52CC489F8A52445CF6125CD8');

-- ----------------------------
-- Table structure for uasp_users
-- ----------------------------
DROP TABLE IF EXISTS `uasp_users`;
CREATE TABLE `uasp_users` (
  `User_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `UserName` varchar(64) NOT NULL,
  `DisplayName` varchar(64) NOT NULL,
  `Salt` varchar(32) DEFAULT NULL,
  `Password` varchar(256) NOT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `MobileNo` varchar(32) DEFAULT NULL,
  `Keyword` varchar(2048) DEFAULT NULL,
  `CreateTime` datetime NOT NULL,
  `ExpireTime` datetime DEFAULT NULL COMMENT 'NULL 表时不过期.',
  `Roles` varchar(128) NOT NULL COMMENT 'USER 员工；ADMIN 业务管理员；ROOT 根管理员；',
  `IsEnabled` bit(1) NOT NULL,
  `IsLocked` bit(1) NOT NULL,
  `Employee_Id` char(32) DEFAULT NULL,
  PRIMARY KEY (`User_Id`),
  KEY `FK_UASP_User_Ref_Employee` (`Employee_Id`),
  KEY `FK_UASP_User_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_User_Ref_Employee` FOREIGN KEY (`Employee_Id`) REFERENCES `uasp_employees` (`Employee_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_User_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_users
-- ----------------------------
INSERT INTO `uasp_users` VALUES ('18C5BD7D457647ECB3F688D4ECF1C0C8', 'DB9611E', 'user1', '开发租户1', 'Zi51tN1IIjMslOaf5IAl5A==', '0f0c533e26b7d5183c6ab8f88619d0c9fca109312b226d1acfa0548dc7c5a289', 'user1@kayura.org', '13912345678', '', '2016-03-01 09:36:14', null, 'USER', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('BD817FA7716E11E586C6D8CB8A43F8DD', null, 'root', '根管理员', 'DI9JGSpp2M8gQ/tDVUQBuQ==', '18529aa9bc0764394e88e1ceb0c153e6ff621d18f377eb977e299bb66dbab5b0', 'root@kayura.org', '13556090295', 'root', '2015-10-13 13:54:32', null, 'ROOT', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('ED5591AB52CC489F8A52445CF6125CD8', 'DB9611E', 'admin', '系统管理员', 'Xwlr0vzshaiErUAisk608Q==', '864b2551ec36a375bcd095a9bb18897d71a7a5e52e76c8947f43c0984ab666dc', 'admin@kayura.org', '13712345678', '', '2016-03-01 09:35:45', null, 'ADMIN', '', '\0', null);

-- ----------------------------
-- Table structure for usap_dictdefine
-- ----------------------------
DROP TABLE IF EXISTS `usap_dictdefine`;
CREATE TABLE `usap_dictdefine` (
  `Dict_Id` char(32) NOT NULL,
  `Code` varchar(32) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Catetory` varchar(64) DEFAULT NULL,
  `DataType` smallint(6) NOT NULL DEFAULT '0' COMMENT '0 列表；1 树型；',
  `Description` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`Dict_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usap_dictdefine
-- ----------------------------
INSERT INTO `usap_dictdefine` VALUES ('2A8DDB30D5EF11E58D5F00163E003262', 'Tndustry', '企业类型', '业务', '0', null);
INSERT INTO `usap_dictdefine` VALUES ('745F9DDCD94411E5943F10BF48BBBEC9', 'Province', '省份', '地域', '0', null);
INSERT INTO `usap_dictdefine` VALUES ('DBF4DC05D94411E5943F10BF48BBBEC9', 'Country', '国家', '地域', '0', null);
