/*
Navicat MySQL Data Transfer

Source Server         : localhost_MYSQL
Source Server Version : 50615
Source Host           : localhost:3306
Source Database       : kayura_db

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2016-07-28 17:54:22
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
-- Records of uasp_autologins
-- ----------------------------
INSERT INTO `uasp_autologins` VALUES ('ks15PWdBUWdpfqDUwxviRA==', '53C1D06102904C4482BD613EC7E49D0F', 'G3GFjqSJi1FZ5ugLBqyN/0cyonYzWlOGtWuFpdturRs=', '2016-07-21 14:03:49');
INSERT INTO `uasp_autologins` VALUES ('navKpA9wpXjJXxeihwHNpg==', '53C1D06102904C4482BD613EC7E49D0F', 'BqQGodp0nQevOV+vpJu4yRTFktIrqbNTHABiW8wD9fw=', '2016-07-20 16:08:21');
INSERT INTO `uasp_autologins` VALUES ('uLpAzIqnCEi3h2JVWp+T8Q==', '53C1D06102904C4482BD613EC7E49D0F', 'YfhfObfYLTUur5jFlxoS1s2whMHdQD3dBdFkHwha9qo=', '2016-07-20 16:03:51');

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
-- Table structure for uasp_bizform
-- ----------------------------
DROP TABLE IF EXISTS `uasp_bizform`;
CREATE TABLE `uasp_bizform` (
  `BizForm_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL,
  `Code` varchar(32) NOT NULL,
  `DisplayName` varchar(512) NOT NULL,
  `ProcessKey` varchar(64) NOT NULL,
  `Serial` int(11) NOT NULL,
  `Description` varchar(2048) DEFAULT NULL,
  `Type` smallint(6) NOT NULL COMMENT '0 业务表单；1 自定表单、2 自动表单；',
  `Status` smallint(6) NOT NULL COMMENT '0 设计；1 发布；2 作废；',
  PRIMARY KEY (`BizForm_Id`),
  KEY `FK_UASP_BizForm_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_BizForm_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_bizform
-- ----------------------------
INSERT INTO `uasp_bizform` VALUES ('268215121E194B968EB1EB0C37AD3CAD', 'DB9611E', 'Custom_Form', '自定义表单', 'custonTask', '0', '', '1', '1');
INSERT INTO `uasp_bizform` VALUES ('2D4D6351FB3E4F20B34B134394963890', 'DB9611E', 'Auto_Form', '自动表单', 'userLeaveTask', '0', '', '2', '1');
INSERT INTO `uasp_bizform` VALUES ('86C38FD55A6F41B6A9A9C8E4021DAB20', 'DB9611E', 'Biz_Form', '测试表单', 'userLeaveTask', '1', '', '0', '1');

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
INSERT INTO `uasp_companies` VALUES ('1A1BD4C9259D4E05A16B8B6116B2E682', null, 'DB9611E', 'ShangGuo', '三国集团', '华夏三国集团有限公司', '', null, null, null, null, null, null, null, null, '0', '1', '2016-06-01 14:25:59');

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
INSERT INTO `uasp_departments` VALUES ('354F28F6EEE745C89F8D428D3D1227B9', null, '1A1BD4C9259D4E05A16B8B6116B2E682', 'DB9611E', 'HR', '人事部', '', '0', '1', '2016-06-17 11:59:01');
INSERT INTO `uasp_departments` VALUES ('371462CA4DBB4E84B4AD0658696BB1E1', null, '1A1BD4C9259D4E05A16B8B6116B2E682', 'DB9611E', 'ZhonJingLi', '总经理', '', '0', '1', '2016-06-01 14:27:36');
INSERT INTO `uasp_departments` VALUES ('9286D03B22144F7FBBDDDC97FAA9F120', null, '1A1BD4C9259D4E05A16B8B6116B2E682', 'DB9611E', 'YeWu', '业务部', '', '0', '1', '2016-06-01 14:27:58');
INSERT INTO `uasp_departments` VALUES ('DD331306C36F4A5492CA27084D7E1B0E', null, '1A1BD4C9259D4E05A16B8B6116B2E682', 'DB9611E', 'IT', 'IT部', '', '0', '1', '2016-06-01 14:28:19');
INSERT INTO `uasp_departments` VALUES ('E1540D75A5C14D68A1B344FC441CFC9A', null, '1A1BD4C9259D4E05A16B8B6116B2E682', 'DB9611E', 'ShiChang', '市场部', '', '0', '1', '2016-06-01 14:26:43');

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
  `User_Id` varchar(32) DEFAULT NULL COMMENT '用户',
  `Code` varchar(32) DEFAULT NULL,
  `Name` varchar(64) NOT NULL,
  `Sex` smallint(16) DEFAULT NULL COMMENT '词典',
  `BirthDay` datetime DEFAULT NULL,
  `Phone` varchar(64) DEFAULT NULL,
  `Mobile` varchar(64) DEFAULT NULL,
  `Email` varchar(1024) DEFAULT NULL,
  `Status` smallint(6) NOT NULL,
  `UpdatedTime` datetime NOT NULL,
  PRIMARY KEY (`Employee_Id`),
  UNIQUE KEY `FK_UASP_Employee_Ref_User` (`User_Id`) USING BTREE,
  KEY `FK_UASP_Employee_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Employee_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_Employee_Ref_User` FOREIGN KEY (`User_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_employees
-- ----------------------------
INSERT INTO `uasp_employees` VALUES ('1563D1CD22074E6090F8E80E6124CF35', 'DB9611E', '54CB0067DBF84545B5B6BA3BD289EF05', 'andy', 'Andy Zhao', null, null, '', '', '', '1', '2016-06-01 15:53:17');
INSERT INTO `uasp_employees` VALUES ('16345160E0B04688B030369109D5983B', 'DB9611E', '9F88694FB54B4E6D81072718198BC1FC', 'tom', 'Tom Wang', null, null, '', '', '', '1', '2016-06-01 15:50:36');
INSERT INTO `uasp_employees` VALUES ('2951E00A31D0453DB6292E6990BC3CF4', 'DB9611E', '8B317331BD2543CD9A255DBAB7C2AC2A', 'jenny', 'Jenny Luo', null, '2003-06-11 00:00:00', '', '', '', '1', '2016-06-01 15:54:02');
INSERT INTO `uasp_employees` VALUES ('38E8B24AEF244B08AC8358AB0B0686C2', 'DB9611E', 'D8B257DEE38642C18F911D5BF24401F3', 'amy', 'Amy Zhang', null, null, '', '', '', '1', '2016-06-01 16:30:17');
INSERT INTO `uasp_employees` VALUES ('84ECDDDA4CE145DDAA66084B978AA31E', 'DB9611E', '53C1D06102904C4482BD613EC7E49D0F', 'kermit', 'Kermit Miao', null, null, '', '', '', '1', '2016-06-01 15:57:59');
INSERT INTO `uasp_employees` VALUES ('BF835AF352754B98B05E15E33D6E4AE7', 'DB9611E', '630D9C4BE8A74C49A7435A7333762EA6', 'bill', 'Bill Zheng', '1', null, '', '', '', '1', '2016-06-21 15:47:00');
INSERT INTO `uasp_employees` VALUES ('D13016E12A6C4132A74A93036A6D9D32', 'DB9611E', '6A29770F05C04C87B471A382607D3099', 'henry', 'Henry Yan', '1', null, '', '', '', '1', '2016-06-01 16:31:12');
INSERT INTO `uasp_employees` VALUES ('D79046C8C6E84E3C8130FD563F84BC96', 'DB9611E', '65DB25265852471D98C417FB01750137', 'eric', 'Eric Li', '0', '2016-06-01 00:00:00', '', '', '', '1', '2016-06-01 16:39:51');

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
INSERT INTO `uasp_filefolders` VALUES ('0B360E55DF8211E58D5F00163E003262', 'DB9611E', null, 'ED5591AB52CC489F8A52445CF6125CD8', null, '个人照片', '\0');
INSERT INTO `uasp_filefolders` VALUES ('0F2D7BE1E02011E59888D8CB8A43F8DD', 'DB9611E', null, '18C5BD7D457647ECB3F688D4ECF1C0C8', null, '大广高速', '\0');
INSERT INTO `uasp_filefolders` VALUES ('2E5421CDDF7611E58D5F00163E003262', 'DB9611E', null, '18C5BD7D457647ECB3F688D4ECF1C0C8', null, '工作文档', '\0');
INSERT INTO `uasp_filefolders` VALUES ('43D97ADADF7611E58D5F00163E003262', 'DB9611E', null, 'ED5591AB52CC489F8A52445CF6125CD8', 'EFA7A76EDF7111E58D5F00163E003262', '招头标', '\0');
INSERT INTO `uasp_filefolders` VALUES ('6F660CBCC3C34039A125A96AA1F5C282', 'DB9611E', null, '53C1D06102904C4482BD613EC7E49D0F', null, '常用文件', '\0');
INSERT INTO `uasp_filefolders` VALUES ('72523D23DF7C11E58D5F00163E003262', 'DB9611E', null, 'ED5591AB52CC489F8A52445CF6125CD8', '3FAA7E74DF7C11E58D5F00163E003262', '招头标', '\0');
INSERT INTO `uasp_filefolders` VALUES ('A8E0231EDF8D11E58FA3D8CB8A43F8DD', 'DB9611E', null, 'ED5591AB52CC489F8A52445CF6125CD8', 'EFA7A76EDF7111E58D5F00163E003262', '合同文件', '\0');
INSERT INTO `uasp_filefolders` VALUES ('B1900536E04011E59888D8CB8A43F8DD', null, 'F732A19CDF7511E58D5F00163E003262', 'BD817FA7716E11E586C6D8CB8A43F8DD', null, '教学视频', '\0');
INSERT INTO `uasp_filefolders` VALUES ('D8FCD6DBE04011E59888D8CB8A43F8DD', null, 'F732A19CDF7511E58D5F00163E003262', 'BD817FA7716E11E586C6D8CB8A43F8DD', null, '操作手册', '\0');
INSERT INTO `uasp_filefolders` VALUES ('F732A19CDF7511E58D5F00163E003262', null, null, 'BD817FA7716E11E586C6D8CB8A43F8DD', null, '培训文档', '\0');

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
INSERT INTO `uasp_fileinfos` VALUES ('13F07C60A4444A96A21E6E4256A75AEA', '35840', 'application/vnd.ms-excel', '{DiskA}\\20160707\\', 'a8d15b35cad50b30eacd04a01933b1c5', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('15E9D7BD88E94809A39C94FDED82B57F', '35328', 'application/vnd.ms-excel', '{DiskA}\\20160707\\', '7602960ff83f2c13ca7ed8fb821ac012', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('2525C99402D5485499596CA1BE5FD1E1', '3823760', 'image/jpeg', '{DiskA}\\20160301\\', 'f0955a39207a7477ddc29da7033ce457', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('508D598327C247CAABF3B18F59E561D3', '1974609', 'application/pdf', '{DiskA}\\20160522\\', '107c8f3697e2bca4df990d1a2789898a', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('5362C80A155A4D7294CA8362F81D0EC1', '1239040', 'application/msword', '{DiskA}\\20160301\\', '9a52a7126400a031724d5651bc147757', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('59D2CC56D9D54AC0A48B405233B87E48', '190464', 'application/octet-stream', '{DiskA}\\20160301\\', 'e718c1bcf01ac0fd8fd3f8a98f6a3e33', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('5B19198FCF8746C5B6EDF303A2AA9252', '828347', 'application/pdf', '{DiskA}\\20160707\\', '5e0df0291a474bb537e31152f3beee90', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('65D2737FAC8E4F5E85FE292FA9DB46B1', '58368', 'application/vnd.ms-excel', '{DiskA}\\20160522\\', '8fac5bc58399ce20604f4e2d6bb471b5', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('6DEBEAA6D69A42F58E5A10F00973F276', '72704', 'application/msword', '{DiskA}\\20160707\\', 'f22e3f8ca321054d1893fe4019cab008', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('87F95AB9319E486CAB12C0B1F923FF7F', '2737738', 'application/pdf', '{DiskA}\\20160522\\', '2f77bb1d49db2baf37df606e230b3cb4', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('88D5A08266314345B6285D27BEB97ABF', '15482', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', '{DiskA}\\20160707\\', '88f2740a6dbb43fb00ae9eb37ac4c3e9', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('959E582E017046319F7F26F09E51AE00', '107', 'application/octet-stream', '{DiskA}\\20160522\\', '9cea42ee3fe28272b7d2c7becedcd67d', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('A2E0FC89C71B46BFB30159F1F9D7206E', '641', 'application/octet-stream', '{DiskA}\\20160522\\', 'd9ed476a26bdc9e2fa9f87ea2655e8d1', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('A9737667B1914C7BA28685B64020E970', '439844', 'application/octet-stream', '{DiskA}\\20160301\\', '402d25834a42765139237ad05f4792f9', '\0', '', 'OgkVFJ1wD3z7rvMx0rCOyg==');
INSERT INTO `uasp_fileinfos` VALUES ('CC1E4A50429C4D2B839CBF1306BD4638', '11264', 'application/vnd.ms-excel', '{DiskA}\\20160301\\', 'e4e63ce98ce9e6c6a23763138c5b675d', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('CDDDDC3A6CB84BDDAD4B46BC1191A6B6', '565248', 'application/vnd.ms-excel', '{DiskA}\\20160522\\', '508c065b8f1559f9273adbc5e6362587', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('DF26878045CC40DA8EAF5E1484D82D35', '4936', 'text/xml', '{DiskA}\\20160522\\', 'ad1429497581d315f85b5ff76b79300c', '\0', '\0', null);
INSERT INTO `uasp_fileinfos` VALUES ('ED7AD48A0F6C4FCF8F8C668B97679396', '35841', 'application/msword', '{DiskA}\\20160707\\', '35c94875d5459f9b3e91b7bdefe538e0', '\0', '\0', null);

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
INSERT INTO `uasp_filerelations` VALUES ('A57EB85B16E448398DBF9430BAA2BAA7', '5B19198FCF8746C5B6EDF303A2AA9252', 'DB9611E', null, '8F6528BEEAB411E5AD4E10BF48BBBEC9', '归档', '员工手册[2016年修订版].pdf', 'pdf', '53C1D06102904C4482BD613EC7E49D0F', null, '2016-07-07 10:02:51', '0', '0', null);
INSERT INTO `uasp_filerelations` VALUES ('F3F7DC3DE6FE4CE8ABF850AF6ACB8583', '13F07C60A4444A96A21E6E4256A75AEA', 'DB9611E', null, '8F6528BEEAB411E5AD4E10BF48BBBEC9', '合同', '03B-新员工试用期工作评价表（夏亮）.xls', 'xls', '53C1D06102904C4482BD613EC7E49D0F', null, '2016-07-07 10:02:37', '0', '0', null);

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
  `Identity_Id` char(32) DEFAULT NULL,
  PRIMARY KEY (`Group_Id`,`User_Id`),
  KEY `FK_UASP_GroupUser_Ref_User` (`User_Id`),
  KEY `FK_UASP_GroupUser_Ref_Identity` (`Identity_Id`),
  CONSTRAINT `FK_UASP_GroupUser_Ref_Group` FOREIGN KEY (`Group_Id`) REFERENCES `uasp_groups` (`Group_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_GroupUser_Ref_Identity` FOREIGN KEY (`Identity_Id`) REFERENCES `uasp_identities` (`Identity_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_GroupUser_Ref_User` FOREIGN KEY (`User_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_groupusers
-- ----------------------------
INSERT INTO `uasp_groupusers` VALUES ('EFA7A76EDF7111E58D5F00163E003262', '53C1D06102904C4482BD613EC7E49D0F', null);
INSERT INTO `uasp_groupusers` VALUES ('3FAA7E74DF7C11E58D5F00163E003262', '630D9C4BE8A74C49A7435A7333762EA6', 'EC3B6EEE375A11E6A5730021CCC9FA7E');

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
INSERT INTO `uasp_identities` VALUES ('023F1AB9DC71435CBD4BEBC9F6406000', '9286D03B22144F7FBBDDDC97FAA9F120', '38E1E6CCFD4F4E39B9732D7D7AF50029', '38E8B24AEF244B08AC8358AB0B0686C2');
INSERT INTO `uasp_identities` VALUES ('09F3CC5E375A11E6A5730021CCC9FA7E', '354F28F6EEE745C89F8D428D3D1227B9', '8E29010D7BCC4A538536C21913282263', '84ECDDDA4CE145DDAA66084B978AA31E');
INSERT INTO `uasp_identities` VALUES ('6CAC5DDB375A11E6A5730021CCC9FA7E', 'E1540D75A5C14D68A1B344FC441CFC9A', '38E1E6CCFD4F4E39B9732D7D7AF50029', '84ECDDDA4CE145DDAA66084B978AA31E');
INSERT INTO `uasp_identities` VALUES ('98C7246FAA9B4D298D5CB93A433EC62A', '371462CA4DBB4E84B4AD0658696BB1E1', null, 'BF835AF352754B98B05E15E33D6E4AE7');
INSERT INTO `uasp_identities` VALUES ('C942358D5CE04707AE6C92599BC7816D', '9286D03B22144F7FBBDDDC97FAA9F120', '38E1E6CCFD4F4E39B9732D7D7AF50029', '16345160E0B04688B030369109D5983B');
INSERT INTO `uasp_identities` VALUES ('D5BE66B8A425407BA5211638BADCB707', '354F28F6EEE745C89F8D428D3D1227B9', '8E29010D7BCC4A538536C21913282263', 'D79046C8C6E84E3C8130FD563F84BC96');
INSERT INTO `uasp_identities` VALUES ('D6511017EFF146AE8C5383D4E96B5FE4', 'E1540D75A5C14D68A1B344FC441CFC9A', null, '16345160E0B04688B030369109D5983B');
INSERT INTO `uasp_identities` VALUES ('EC3B6EEE375A11E6A5730021CCC9FA7E', '354F28F6EEE745C89F8D428D3D1227B9', '8E29010D7BCC4A538536C21913282263', 'BF835AF352754B98B05E15E33D6E4AE7');
INSERT INTO `uasp_identities` VALUES ('F847C5C9784449A99F2B399693534947', 'DD331306C36F4A5492CA27084D7E1B0E', null, '16345160E0B04688B030369109D5983B');

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
-- Table structure for uasp_mockorders
-- ----------------------------
DROP TABLE IF EXISTS `uasp_mockorders`;
CREATE TABLE `uasp_mockorders` (
  `Order_Id` char(32) NOT NULL,
  `Tenant_Id` varchar(32) DEFAULT NULL COMMENT '编号',
  `Code` varchar(64) NOT NULL,
  `Title` varchar(512) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `Author` varchar(32) NOT NULL,
  `UpdateTime` datetime NOT NULL,
  PRIMARY KEY (`Order_Id`),
  KEY `FK_UPAS_AnalogOrder_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UPAS_AnalogOrder_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_mockorders
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
INSERT INTO `uasp_positions` VALUES ('38E1E6CCFD4F4E39B9732D7D7AF50029', '9286D03B22144F7FBBDDDC97FAA9F120', 'DB9611E', 'BMJL', '部门经理', '1', '', '0', '1', '2016-06-21 10:47:38');
INSERT INTO `uasp_positions` VALUES ('8E29010D7BCC4A538536C21913282263', '354F28F6EEE745C89F8D428D3D1227B9', 'DB9611E', 'HR', '人事经理', '1', '', '0', '1', '2016-06-21 14:34:00');

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
  `Type` varchar(8) DEFAULT NULL,
  `Enabled` bit(1) NOT NULL COMMENT '0 禁用；1 启用；',
  PRIMARY KEY (`Role_Id`),
  KEY `FK_UASP_Role_Ref_Tenant` (`Tenant_Id`),
  CONSTRAINT `FK_UASP_Role_Ref_Tenant` FOREIGN KEY (`Tenant_Id`) REFERENCES `uasp_tenants` (`Tenant_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_roles
-- ----------------------------
INSERT INTO `uasp_roles` VALUES ('146F28C1E9154417B47C59293C839A64', 'DB9611E', '工作流管理员', 'W', '');
INSERT INTO `uasp_roles` VALUES ('5870A5B5DF7C11E58D5F00163E003262', 'DB9611E', '系统管理员', null, '\0');
INSERT INTO `uasp_roles` VALUES ('A609DFE549684958B760C34CAB4FA923', 'DB9611E', '所有员工', 'W', '');

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
  `Identity_Id` char(32) DEFAULT '',
  PRIMARY KEY (`Role_Id`,`User_Id`),
  KEY `FK_UASP_UserRole_Ref_User` (`User_Id`),
  KEY `FK_UASP_UserRole_Ref_Identity` (`Identity_Id`),
  CONSTRAINT `FK_UASP_UserRole_Ref_Identity` FOREIGN KEY (`Identity_Id`) REFERENCES `uasp_identities` (`Identity_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_UserRole_Ref_Role` FOREIGN KEY (`Role_Id`) REFERENCES `uasp_roles` (`Role_Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_UASP_UserRole_Ref_User` FOREIGN KEY (`User_Id`) REFERENCES `uasp_users` (`User_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of uasp_userroles
-- ----------------------------
INSERT INTO `uasp_userroles` VALUES ('5870A5B5DF7C11E58D5F00163E003262', 'ED5591AB52CC489F8A52445CF6125CD8', null);
INSERT INTO `uasp_userroles` VALUES ('A609DFE549684958B760C34CAB4FA923', '53C1D06102904C4482BD613EC7E49D0F', null);
INSERT INTO `uasp_userroles` VALUES ('A609DFE549684958B760C34CAB4FA923', '630D9C4BE8A74C49A7435A7333762EA6', 'EC3B6EEE375A11E6A5730021CCC9FA7E');

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
INSERT INTO `uasp_users` VALUES ('53C1D06102904C4482BD613EC7E49D0F', 'DB9611E', 'kermit', 'Kermit Miao', 'UrXeUvaTTupYYnwHAKiQkg==', '0b680c8caf741d9c22c746177f5eedb62230023f0a66f1826828a6db5d602f67', 'kermit@kayura.org', '13500000003', 'kermit', '2016-06-01 14:19:46', null, 'USER', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('54CB0067DBF84545B5B6BA3BD289EF05', 'DB9611E', 'andy', 'Andy Zhao', 'J2E2Bepkgd7Gj3TfF+jZ0g==', 'bf0e38da5db4207effe5136fce43ddfb4ceeb847a947b471388f29e0171b9bc3', 'andy@kayura.org', '13500000005', 'andy', '2016-06-01 14:21:00', null, 'USER', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('630D9C4BE8A74C49A7435A7333762EA6', 'DB9611E', 'bill', 'Bill Zheng', 'MfHP6qhrZ73sGE+RWG+/Fw==', '7682a33089c457150185b9d9f987fc67360a816655ff6f9b81c26d6dc92e6428', 'bill@kayura.org', '13500000006', 'bill', '2016-06-01 14:22:02', null, 'USER', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('65DB25265852471D98C417FB01750137', 'DB9611E', 'eric', 'Eric Li', 'wFNw33q2B10avt1eBkTl7A==', '3ba97fcf7cdc031c0fb3f5280914419e0cdc26a48b0a5ee4f7e66e52475e09fd', 'eric@kayura.org', '13500000001', 'eric', '2016-06-01 14:18:31', null, 'USER', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('6A29770F05C04C87B471A382607D3099', 'DB9611E', 'henry', 'Henry Yan', 'f6YZXb37KTCXWsxYdv8hdQ==', '35e104b6029e999573bae2a76a397867d3a0cd352e55cf9cbb529bbd08556936', 'henry@kayura.org', '13500000008', 'henry', '2016-06-01 14:23:22', null, 'USER', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('8B317331BD2543CD9A255DBAB7C2AC2A', 'DB9611E', 'jenny', 'Jenny Luo', '5CawKz9jys+jC8yQO28Yhw==', 'd9c5ea102d0dc253aa3efc257262c9cfb90d8207300f1ae5b78b56caf700ddf2', 'jenny@kayura.org', '13500000007', '', '2016-06-01 14:22:27', null, 'USER', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('9F88694FB54B4E6D81072718198BC1FC', 'DB9611E', 'tom', 'Tom Wang', 'uVIFIsPBl+qmwjbZzMkBlA==', '1b71a06acf8bbd974733e6394acc6ec3e95e60ef90308b8aa579a059cf5b5fe2', 'tom@kayura.org', '13500000002', 'tom', '2016-06-01 14:19:14', null, 'USER', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('BD817FA7716E11E586C6D8CB8A43F8DD', null, 'root', '根管理员', 'DI9JGSpp2M8gQ/tDVUQBuQ==', '18529aa9bc0764394e88e1ceb0c153e6ff621d18f377eb977e299bb66dbab5b0', 'root@kayura.org', '13556090295', 'root', '2015-10-13 13:54:32', null, 'ROOT', '', '\0', null);
INSERT INTO `uasp_users` VALUES ('D8B257DEE38642C18F911D5BF24401F3', 'DB9611E', 'amy', 'Amy Zhang', '+FQUv9GZLLTTavbvNKaXkg==', 'f36c40fd7c299932b8b3bb3469afeeb1e02fa97c42dad3419cf54bbcccbe49b9', 'amy@kayura.org', '13500000004', 'amy', '2016-06-01 14:20:26', null, 'USER', '', '\0', null);
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

-- ----------------------------
-- View structure for act_id_group
-- ----------------------------
DROP VIEW IF EXISTS `act_id_group`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `act_id_group` AS SELECT
	d.Department_ID AS ID_,
	1 AS REV_,
	concat( d.Name, '（' ,c.ShortName , '）') AS NAME_,
	'D' AS TYPE_
FROM uasp_companies AS c
	INNER JOIN uasp_departments AS d ON d.Company_Id = c.Company_Id

UNION ALL

SELECT
	p.Position_Id AS ID_,
	1 AS REV_,
	concat(p.Name, '（' , c.ShortName, '.',d.Name , '）') AS NAME_,
	'P' AS TYPE_
FROM uasp_companies AS c
	INNER JOIN uasp_departments AS d ON d.Company_Id = c.Company_Id
	INNER JOIN uasp_positions AS p ON p.Department_Id = d.Department_Id 

UNION ALL

SELECT
	r.Role_Id AS ID_,
	1 AS REV_,
	r.Name AS NAME_,
	'R' AS TYPE_
FROM uasp_roles AS r
WHERE r.Type = 'W' 

UNION ALL

SELECT
	g.Group_Id AS ID_,
	1 AS REV_,
	g.Name AS NAME_,
	'G' AS TYPE_
FROM uasp_groups AS g ;

-- ----------------------------
-- View structure for act_id_membership
-- ----------------------------
DROP VIEW IF EXISTS `act_id_membership`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `act_id_membership` AS SELECT DISTINCT
	id.Identity_Id AS USER_ID_,
	id.Department_Id AS GROUP_ID_
FROM uasp_identities AS id

UNION ALL

SELECT
	ip.Identity_Id AS USER_ID_,
	ip.Position_Id AS GROUP_ID_
FROM uasp_identities AS ip 
WHERE ip.Position_Id IS NOT NULL

UNION ALL

SELECT
	ur.Identity_Id,
	ur.Role_Id
FROM uasp_userroles AS ur
	INNER JOIN uasp_roles AS r ON ur.Role_Id = r.Role_Id
WHERE
	ur.Identity_Id IS NOT NULL AND (
		r.Type = 'W' OR r.Role_Id IN (SELECT gr.Role_Id FROM UASP_GroupRoles gr)
	)

UNION ALL

SELECT
	i.Identity_Id,
	ur.Role_Id
FROM uasp_userroles AS ur
	INNER JOIN uasp_employees AS e ON e.User_Id = ur.User_Id
	INNER JOIN uasp_identities AS i ON i.Employee_Id = e.Employee_Id
	INNER JOIN uasp_roles AS r ON ur.Role_Id = r.Role_Id
WHERE
	ur.Identity_Id IS NULL AND (
		r.Type = 'W' OR r.Role_Id IN (SELECT gr.Role_Id FROM UASP_GroupRoles gr)
	) 

UNION ALL

SELECT
	gu.Identity_Id,
	gu.Group_Id
FROM uasp_groupusers AS gu
WHERE
	gu.Identity_Id IS NOT NULL 

UNION ALL

SELECT
	i.Identity_Id,
	gu.Group_Id
FROM uasp_groupusers AS gu
	INNER JOIN uasp_employees AS e ON e.User_Id = gu.User_Id
	INNER JOIN uasp_identities AS i ON i.Employee_Id = e.Employee_Id
WHERE
	gu.Identity_Id IS NULL ;

-- ----------------------------
-- View structure for act_id_user
-- ----------------------------
DROP VIEW IF EXISTS `act_id_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `act_id_user` AS SELECT
i.Identity_Id AS ID_,
1 AS REV_,
concat(d.Name,'.',p.Name) AS FIRST_,
e.Name AS LAST_,
e.Email AS EMAIL_,
null AS PWD_,
null AS PICTURE_ID_
FROM
uasp_identities AS i
INNER JOIN uasp_employees AS e ON i.Employee_Id = e.Employee_Id
INNER JOIN uasp_positions AS p ON i.Position_Id = p.Position_Id
INNER JOIN uasp_departments AS d ON i.Department_Id = d.Department_Id ;
