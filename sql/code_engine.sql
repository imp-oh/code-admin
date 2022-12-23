/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : localhost:3306
 Source Schema         : code_engine

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 23/12/2022 10:09:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for base_article
-- ----------------------------
DROP TABLE IF EXISTS `base_article`;
CREATE TABLE `base_article`  (
  `article_id` bigint(25) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `user_id` bigint(30) NOT NULL COMMENT '用户ID',
  `category_id` bigint(25) NULL DEFAULT NULL COMMENT '所属栏目ID',
  `article_sort` int(4) NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章标题',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签名称',
  `description` longblob NULL COMMENT '编辑摘要',
  `cover_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章封面（图片）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1草稿 2审核 3 停用）',
  `views_count` int(10) NULL DEFAULT 0 COMMENT '查看数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of base_article
-- ----------------------------

-- ----------------------------
-- Table structure for base_article_data
-- ----------------------------
DROP TABLE IF EXISTS `base_article_data`;
CREATE TABLE `base_article_data`  (
  `data_id` bigint(25) NOT NULL AUTO_INCREMENT COMMENT '文章内容ID',
  `article_id` bigint(25) NOT NULL COMMENT '文章ID',
  `mark_content` longblob NULL COMMENT '主要内容',
  PRIMARY KEY (`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of base_article_data
-- ----------------------------

-- ----------------------------
-- Table structure for base_category
-- ----------------------------
DROP TABLE IF EXISTS `base_category`;
CREATE TABLE `base_category`  (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '所属栏目ID',
  `category_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目名称',
  `category_sort` int(4) NOT NULL COMMENT '显示顺序',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `category_image` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '栏目图片',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of base_category
-- ----------------------------

-- ----------------------------
-- Table structure for base_images
-- ----------------------------
DROP TABLE IF EXISTS `base_images`;
CREATE TABLE `base_images`  (
  `image_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片id',
  `image_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片类型（1）',
  `article_id` bigint(25) NOT NULL COMMENT '文章ID',
  `image_size` int(10) NULL DEFAULT NULL COMMENT '图片大小',
  `image_mime_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'MIME类型',
  `image_path` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片路径',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`image_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of base_images
-- ----------------------------

-- ----------------------------
-- Table structure for code_engine_appletstore
-- ----------------------------
DROP TABLE IF EXISTS `code_engine_appletstore`;
CREATE TABLE `code_engine_appletstore`  (
  `id` bigint(50) NOT NULL,
  `appid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint(50) NOT NULL COMMENT '作者id',
  `versionid` bigint(50) NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '简单描述',
  `downloads` int(255) NULL DEFAULT NULL COMMENT '下载数',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '软件名称',
  `readme_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '软件介绍',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '软件icon地址',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'icon 目录文件地址',
  `state` int(255) NOT NULL DEFAULT 1 COMMENT '0.停止 1.启动',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `authority` int(10) NOT NULL DEFAULT 1 COMMENT '1.默认可下载 2.用户登录下载',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of code_engine_appletstore
-- ----------------------------
INSERT INTO `code_engine_appletstore` VALUES (1599651395777204224, 'cenzhouramyz75zvgw', 1, 1599651395777204224, 'admin', '啊实打', NULL, 'cetest', 'as的', '', '', 1, '2022-12-05 14:26:27', 1);

-- ----------------------------
-- Table structure for code_engine_appletstore_version
-- ----------------------------
DROP TABLE IF EXISTS `code_engine_appletstore_version`;
CREATE TABLE `code_engine_appletstore_version`  (
  `id` bigint(50) NOT NULL,
  `storeid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商场id',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '软件版本',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件目录',
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `size` double NULL DEFAULT NULL COMMENT '文件大小',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of code_engine_appletstore_version
-- ----------------------------
INSERT INTO `code_engine_appletstore_version` VALUES (1479365670381686784, '1479365670381686784', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/cf5f1bdee354169cca030f203.codeengine', '2022-01-07 16:13:55', 26937);
INSERT INTO `code_engine_appletstore_version` VALUES (1480346251470966784, '1480346251470966784', '0.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/ae2d39c71963b30387d9d2f01.codeengine', '2022-01-10 09:10:28', 9182581);
INSERT INTO `code_engine_appletstore_version` VALUES (1480381014491664384, '1479363889585065984', '0.0.2', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/ae2d39c71963b30387d9d2f03.codeengine', '2022-01-10 11:28:32', 37236);
INSERT INTO `code_engine_appletstore_version` VALUES (1481081027588919296, '1481081027588919296', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/34a4ddea82d51d4b696c2ee05.codeengine', '2022-01-12 09:50:12', 4696430);
INSERT INTO `code_engine_appletstore_version` VALUES (1481094870612447232, '1481094870612447232', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/3f75437885a4b6d810a1c0e01.codeengine', '2022-01-12 10:45:09', 2292);
INSERT INTO `code_engine_appletstore_version` VALUES (1481190256723234816, '1481190256723234816', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/4c5b4e8b58f13621cd7855601.codeengine', '2022-01-12 17:04:11', 2319525);
INSERT INTO `code_engine_appletstore_version` VALUES (1481190842768166912, '1481190842768166912', '1.0.2', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/34a4ddea82d51d4b696c2ee01.codeengine', '2022-01-12 17:06:31', 2319532);
INSERT INTO `code_engine_appletstore_version` VALUES (1481821370903040000, '1481821370903040000', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/34a4ddea82d51d4b696c2ee07.codeengine', '2022-01-14 10:52:02', 4696430);
INSERT INTO `code_engine_appletstore_version` VALUES (1481821632950571008, '1481821632950571008', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/5f6faea9bd9bd45e8d63f0e01.codeengine', '2022-01-14 10:53:05', 4696430);
INSERT INTO `code_engine_appletstore_version` VALUES (1481821880783605760, '1481821880783605760', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/5f6faea9bd9bd45e8d63f0e03.codeengine', '2022-01-14 10:54:03', 4696430);
INSERT INTO `code_engine_appletstore_version` VALUES (1481824391112298496, '1481824391112298496', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/5f6faea9bd9bd45e8d63f0e07.0.0.codeengine', '2022-01-14 11:04:04', 4696430);
INSERT INTO `code_engine_appletstore_version` VALUES (1481826223515635712, '1481826223515635712', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/5f6faea9bd9bd45e8d63f0e0d.0.0.codeengine', '2022-01-14 11:11:21', 4696430);
INSERT INTO `code_engine_appletstore_version` VALUES (1481827920451342336, '1481827920451342336', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/5f6faea9bd9bd45e8d63f0e0f.codeengine', '2022-01-14 11:18:06', 9391028);
INSERT INTO `code_engine_appletstore_version` VALUES (1481828217823301632, '1481828217823301632', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/5f6faea9bd9bd45e8d63f0e11.codeengine', '2022-01-14 11:19:17', 9391028);
INSERT INTO `code_engine_appletstore_version` VALUES (1481882318774865920, '1481882318774865920', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/5f6faea9bd9bd45e8d63f0e15.codeengine', '2022-01-14 14:54:15', 9391028);
INSERT INTO `code_engine_appletstore_version` VALUES (1481887105830490112, '1481887105830490112', '1.0.2', 'C:\\www\\ce.codeee.top\\public', '/applet/20222/138f7b87446164b2bc0577103.codeengine', '2022-01-14 15:13:17', 3926426);
INSERT INTO `code_engine_appletstore_version` VALUES (1484038825998159872, '1484038825998159872', '1.0.3', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/5159bddce54c9a75bb70e4605.codeengine', '2022-01-20 13:43:23', 1214222);
INSERT INTO `code_engine_appletstore_version` VALUES (1486536759469805568, '1486536759469805568', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20221/138f7b87446164b2bc0577101.codeengine', '2022-01-27 11:09:16', 211015);
INSERT INTO `code_engine_appletstore_version` VALUES (1492026373273948160, '1492026373273948160', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20222/138f7b87446164b2bc0577105.codeengine', '2022-02-11 14:43:02', 12266);
INSERT INTO `code_engine_appletstore_version` VALUES (1492027986340352000, '1492027986340352000', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20222/138f7b87446164b2bc0577107.codeengine', '2022-02-11 14:49:27', 7752);
INSERT INTO `code_engine_appletstore_version` VALUES (1492032096024268800, '1492032096024268800', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20222/138f7b87446164b2bc0577109.codeengine', '2022-02-11 15:05:47', 14101);
INSERT INTO `code_engine_appletstore_version` VALUES (1492032116396003328, '1492032116396003328', '1.0.0', 'C:\\www\\ce.codeee.top\\public', '/applet/20222/138f7b87446164b2bc057710b.codeengine', '2022-02-11 15:05:51', 13525);
INSERT INTO `code_engine_appletstore_version` VALUES (1492347561510572032, '1492347561510572032', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20222/138f7b87446164b2bc057710c.codeengine', '2022-02-12 11:59:19', 1140);
INSERT INTO `code_engine_appletstore_version` VALUES (1493052602554912768, '1493052602554912768', '1.0.2', 'C:\\www\\ce.codeee.top\\public', '/applet/20222/138f7b87446164b2bc0577110.codeengine', '2022-02-14 10:40:56', 3926426);
INSERT INTO `code_engine_appletstore_version` VALUES (1493053535007412224, '1493053535007412224', '1.0.2', 'C:\\www\\ce.codeee.top\\public', '/applet/20222/138f7b87446164b2bc0577112.codeengine', '2022-02-14 10:44:38', 3926426);
INSERT INTO `code_engine_appletstore_version` VALUES (1500652935154110464, '1500652935154110464', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20223/27cffc8a7fbfa065eb8541d01.codeengine', '2022-03-07 10:01:55', 364693);
INSERT INTO `code_engine_appletstore_version` VALUES (1512065170233495552, '1512065170229301248', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20224/27cffc8a7fbfa065eb8541d02.codeengine', '2022-04-07 21:50:04', 922);
INSERT INTO `code_engine_appletstore_version` VALUES (1535618910467002368, '1535618910467002368', '0.0.1', 'C:\\www\\ce.codeee.top\\public', '/applet/20226/27cffc8a7fbfa065eb8541d04.codeengine', '2022-06-11 21:44:13', 1910);
INSERT INTO `code_engine_appletstore_version` VALUES (1564172165765533696, '1564172165765533696', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/20228/d3b10f7112e754bf60c4eee01.codeengine', '2022-08-29 16:44:39', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564491543333703680, '1564491543333703680', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/7be56091aa8d29cc8ed308601.codeengine', '2022-08-30 13:53:45', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564511433033650176, '1564511433033650176', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/cd9cac0d4ff7bdbd80589de01.codeengine', '2022-08-30 15:12:47', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564511599576879104, '1564511599576879104', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/356eb1ea09a4b4b9388ffb401.codeengine', '2022-08-30 15:13:27', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564513423545470976, '1564513423545470976', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/c2637618afc1fb6f2befb5003.codeengine', '2022-08-30 15:20:42', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564520794413993984, '1564520794413993984', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/99d94c7e490ddf192bee5ce08.codeengine', '2022-08-30 15:49:59', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564522816223711232, '1564522816223711232', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/99d94c7e490ddf192bee5ce0a.codeengine', '2022-08-30 15:58:01', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564525263923056640, '1564525263923056640', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/99d94c7e490ddf192bee5ce0c.codeengine', '2022-08-30 16:07:45', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564526938259853312, '1564526938259853312', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/99d94c7e490ddf192bee5ce0d.codeengine', '2022-08-30 16:14:24', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1564537925251764224, '1564537925251764224', '0.0.1', 'D:\\Hui\\Github\\blog\\ce-admin\\public', '/applet/202208/c8ccf486e4176dfbb04b7d307.codeengine', '2022-08-30 16:58:03', 10568);
INSERT INTO `code_engine_appletstore_version` VALUES (1599650279165399040, '1599650279152816128', '0.0.1', 'D:\\Hui\\Github\\CodeEngine\\ce-admin\\public', '/applet/202212/40b8f906e9aa554977a0cea00.codeengine', '2022-12-05 14:22:27', 1728);
INSERT INTO `code_engine_appletstore_version` VALUES (1599651395777204224, '1599651395777204224', '0.0.1', 'D:\\Hui\\Github\\CodeEngine\\ce-admin\\public', '/applet/202212/7921be220a44fcaa41e5fd000.codeengine', '2022-12-05 14:26:27', 1728);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'base_article', '', NULL, NULL, 'BaseArticle', 'crud', 'com.ruoyi.system', 'system', 'article', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2022-04-27 10:19:19', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (2, 'base_category', '', NULL, NULL, 'BaseCategory', 'crud', 'com.ruoyi.system', 'system', 'category', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2022-04-27 10:19:20', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (3, 'base_images', '', NULL, NULL, 'BaseImages', 'crud', 'com.ruoyi.system', 'system', 'images', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2022-04-27 10:19:20', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (4, 'monthly_task', '', NULL, NULL, 'MonthlyTask', 'crud', 'com.ruoyi.system', 'system', 'task', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2022-05-09 13:04:13', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'article_id', '文章ID', 'bigint(25)', 'Long', 'articleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (2, '1', 'user_id', '用户ID', 'bigint(30)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (3, '1', 'category_id', '所属栏目ID', 'bigint(25)', 'Long', 'categoryId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (4, '1', 'article_sort', '显示顺序', 'int(4)', 'Integer', 'articleSort', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (5, '1', 'title', '文章标题', 'varchar(255)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (6, '1', 'tags', '标签名称[\'前端\',\'自定义\']', 'varchar(255)', 'String', 'tags', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (7, '1', 'description', '编辑摘要', 'varchar(255)', 'String', 'description', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (8, '1', 'cover_img', '文章封面（图片）', 'varchar(255)', 'String', 'coverImg', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (9, '1', 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 9, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (10, '1', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 12, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (11, '1', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 13, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (12, '1', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', NULL, 14, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (13, '1', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', NULL, 15, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (14, '1', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 11, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (15, '1', 'views_count', '查看数量', 'int(10)', 'Integer', 'viewsCount', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 15:37:37');
INSERT INTO `gen_table_column` VALUES (16, '2', 'category_id', '所属栏目ID', 'bigint(20)', 'Long', 'categoryId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (17, '2', 'category_name', '栏目名称', 'varchar(30)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (18, '2', 'category_sort', '显示顺序', 'int(4)', 'Integer', 'categorySort', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (19, '2', 'status', '状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (20, '2', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 5, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (21, '2', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 6, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (22, '2', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', NULL, 7, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (23, '2', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', NULL, 8, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (24, '2', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 9, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (25, '2', 'category_image', '栏目图片', 'varchar(300)', 'String', 'categoryImage', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 10, 'admin', '2022-04-27 10:19:20', NULL, '2022-04-27 10:34:59');
INSERT INTO `gen_table_column` VALUES (26, '3', 'image_id', '图片id', 'varbinary(100)', 'String', 'imageId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', NULL, '', 1, 'admin', '2022-04-27 10:19:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (27, '3', 'image_type', '图片类型（1）', 'char(1)', 'String', 'imageType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 2, 'admin', '2022-04-27 10:19:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (28, '3', 'article_id', '文章ID', 'bigint(25)', 'Long', 'articleId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-04-27 10:19:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (29, '3', 'image_siez', '图片大小', 'int(10)', 'Integer', 'imageSiez', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-04-27 10:19:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (30, '3', 'image_mime_type', 'MIME类型', 'varchar(30)', 'String', 'imageMimeType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2022-04-27 10:19:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (31, '3', 'image_path', '图片路径', 'varchar(300)', 'String', 'imagePath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-04-27 10:19:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (32, '4', 'task_id', '任务id', 'bigint(30)', 'Long', 'taskId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (33, '4', 'task_name', '任务名称', 'varchar(255)', 'String', 'taskName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (34, '4', 'dept_id', '部门id', 'bigint(30)', 'Long', 'deptId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (35, '4', 'status', '部门状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (36, '4', 'begin_time', '开始时间', 'datetime', 'Date', 'beginTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (37, '4', 'end_time', '结束时间', 'datetime', 'Date', 'endTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (38, '4', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (39, '4', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (40, '4', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-05-09 13:04:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (41, '4', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-05-09 13:04:13', '', NULL);

-- ----------------------------
-- Table structure for monthly_table
-- ----------------------------
DROP TABLE IF EXISTS `monthly_table`;
CREATE TABLE `monthly_table`  (
  `monthly_id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '月报id',
  `user_id` bigint(30) NOT NULL COMMENT '用户id',
  `year_month` datetime NULL DEFAULT NULL COMMENT '年月',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '3' COMMENT '状态（0通过 1草稿  2失败 3待完成 4变更  5审核',
  `history_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '2' COMMENT '历史状态',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`monthly_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of monthly_table
-- ----------------------------
INSERT INTO `monthly_table` VALUES (1, 101, '2022-06-01 08:00:00', '4', '2', 'jiang', '2022-06-01 09:29:14', 'jiang', '2022-06-01 09:37:23');
INSERT INTO `monthly_table` VALUES (2, 101, '2022-05-01 08:00:00', '3', '2', 'jiang', '2022-06-01 09:29:14', '', NULL);
INSERT INTO `monthly_table` VALUES (3, 1, '2022-06-01 00:00:00', '3', '2', 'admin', '2022-06-01 15:16:31', '', NULL);

-- ----------------------------
-- Table structure for monthly_table_column
-- ----------------------------
DROP TABLE IF EXISTS `monthly_table_column`;
CREATE TABLE `monthly_table_column`  (
  `column_id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `monthly_id` bigint(30) NOT NULL COMMENT '月报id',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '状态（0正常 1 变更)',
  `task_id` bigint(30) NULL DEFAULT NULL COMMENT '任务清单id',
  `workload` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工作量(%)',
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `before_id` bigint(30) NULL DEFAULT NULL COMMENT '变更前的编号id',
  `target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作目标',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `actual_begin_time` datetime NULL DEFAULT NULL COMMENT '实际开始时间',
  `actual_end_time` datetime NULL DEFAULT NULL COMMENT '实际结束时间',
  `work_done` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '完成工作量(%)',
  `job_rating` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作目标评价',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of monthly_table_column
-- ----------------------------
INSERT INTO `monthly_table_column` VALUES (1, 1, '0', NULL, '77', '2022-06-01 08:00:00', '2022-06-30 08:00:00', NULL, '修复bug', 'asdasdas', '2022-06-13 00:00:00', '2022-06-27 00:00:00', NULL, NULL);
INSERT INTO `monthly_table_column` VALUES (2, 2, '0', NULL, '50', '2022-05-01 08:00:00', '2022-05-31 08:00:00', NULL, '自定义嘎斯回到i是的', 'a啊大苏打阿松大', NULL, NULL, NULL, NULL);
INSERT INTO `monthly_table_column` VALUES (3, 2, '0', NULL, '50', '2022-05-01 08:00:00', '2022-05-31 08:00:00', NULL, '我是变更后的任务黑暗时代', '阿松大', NULL, NULL, NULL, NULL);
INSERT INTO `monthly_table_column` VALUES (4, 1, '0', 2, '23', '2022-06-01 00:00:00', '2022-06-30 00:00:00', NULL, 'diy', '222', '2022-06-12 00:00:00', '2022-06-28 00:00:00', NULL, NULL);
INSERT INTO `monthly_table_column` VALUES (5, 3, '0', 1, '1', '2022-06-01 00:00:00', '2022-06-30 00:00:00', NULL, 'd嘀嘀嘀', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for monthly_task
-- ----------------------------
DROP TABLE IF EXISTS `monthly_task`;
CREATE TABLE `monthly_task`  (
  `task_id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `dept_id` bigint(30) NOT NULL COMMENT '部门id',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '任务状态（0正常 1停用）',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`task_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of monthly_task
-- ----------------------------
INSERT INTO `monthly_task` VALUES (1, '质监项目组', 103, '0', NULL, NULL, 'admin', '2022-05-09 15:20:27', 'admin2', '2022-05-09 16:12:52');
INSERT INTO `monthly_task` VALUES (2, '自定义', 103, '0', NULL, NULL, 'admin2', '2022-05-09 16:15:40', '', NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-04-24 15:48:41', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', 'gitce', 'Y', 'admin', '2022-04-24 15:48:41', 'admin', '2022-06-18 21:25:52', '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-04-24 15:48:41', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'false', 'Y', 'admin', '2022-04-24 15:48:41', 'admin', '2022-04-26 13:08:55', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-04-24 15:48:41', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '月报申请修改有效天数', 'monthly.valid.time', '6', 'Y', 'admin', '2022-05-09 13:42:16', 'admin', '2022-05-11 15:11:38', '设置用户修改有效天数，当用户超过天数后，数据修改择变成数据变更');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '代码引擎', 0, 'gitce', '15888888888', 'gitce@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', 'admin', '2022-06-18 21:28:24');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '综合应用事业部', 1, '江', '15888888888', 'fz@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', 'admin', '2022-05-07 13:08:59');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '综合应用事业部业务一组', 1, '李小八', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', 'admin2', '2022-05-11 16:03:16');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-04-24 15:48:41', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-24 15:48:41', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (29, 1, '成功', '0', 'article_status', NULL, 'primary', 'N', '0', 'admin', '2022-04-28 09:46:55', 'admin', '2022-06-09 23:44:45', '成功状态');
INSERT INTO `sys_dict_data` VALUES (30, 2, '停用', '1', 'article_status', NULL, 'danger', 'N', '0', 'admin', '2022-04-28 09:47:26', 'admin', '2022-06-09 23:44:52', '停用状态');
INSERT INTO `sys_dict_data` VALUES (31, 3, '草稿', '2', 'article_status', NULL, 'success', 'N', '0', 'admin', '2022-04-28 09:48:07', 'admin', '2022-06-09 23:42:12', '草稿状态');
INSERT INTO `sys_dict_data` VALUES (32, 4, '审核', '3', 'article_status', NULL, 'warning', 'N', '0', 'admin', '2022-05-05 16:01:40', 'admin', '2022-06-09 23:42:24', '审核状态');
INSERT INTO `sys_dict_data` VALUES (33, 0, '通过', '0', 'monthly_common_status', NULL, 'primary', 'N', '0', 'admin', '2022-05-07 16:03:13', '', NULL, '通过');
INSERT INTO `sys_dict_data` VALUES (34, 0, '草稿', '1', 'monthly_common_status', NULL, 'success', 'N', '0', 'admin', '2022-05-07 16:03:35', 'admin', '2022-05-09 16:39:06', NULL);
INSERT INTO `sys_dict_data` VALUES (35, 0, '失败', '2', 'monthly_common_status', NULL, 'danger', 'N', '0', 'admin', '2022-05-07 16:03:51', 'admin', '2022-05-09 16:40:40', NULL);
INSERT INTO `sys_dict_data` VALUES (36, 0, '待完成', '3', 'monthly_common_status', '', 'default', 'N', '0', 'admin', '2022-05-07 16:28:22', 'admin', '2022-05-10 13:27:52', NULL);
INSERT INTO `sys_dict_data` VALUES (37, 0, '变更', '4', 'monthly_common_status', '', 'info', 'N', '0', 'admin', '2022-05-07 16:30:11', 'admin', '2022-05-09 16:41:23', NULL);
INSERT INTO `sys_dict_data` VALUES (40, 0, '审核', '5', 'monthly_common_status', NULL, 'warning', 'N', '0', 'admin', '2022-05-10 13:28:14', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '文章状态', 'article_status', '0', 'admin', '2022-04-28 09:45:42', 'admin', '2022-04-28 09:46:17', NULL);
INSERT INTO `sys_dict_type` VALUES (12, '月报申报状态', 'monthly_common_status', '0', 'admin', '2022-05-07 16:01:38', '', NULL, '月报申报状态');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-04-24 15:48:41', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-04-26 10:48:47');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-26 10:48:54');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-04-26 13:07:19');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-26 13:07:37');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-04-26 13:10:53');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-26 13:10:56');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-04-26 13:10:59');
INSERT INTO `sys_logininfor` VALUES (107, 'ry', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-26 13:11:04');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-26 13:43:08');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-26 16:06:01');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-27 09:57:09');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-27 15:34:33');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-28 10:36:38');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-09 13:02:35');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '192.168.8.93', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-09 14:51:22');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-11 11:11:15');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-12 14:39:32');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2027 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-04-24 15:48:41', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-04-24 15:48:41', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-04-24 15:48:41', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-04-24 15:48:41', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-04-24 15:48:41', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-04-24 15:48:41', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-04-24 15:48:41', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-04-24 15:48:41', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-04-24 15:48:41', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-04-24 15:48:41', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-04-24 15:48:41', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-04-24 15:48:41', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-04-24 15:48:41', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-04-24 15:48:41', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-04-24 15:48:41', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-04-24 15:48:41', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-04-24 15:48:41', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-04-24 15:48:41', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-04-24 15:48:41', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-04-24 15:48:41', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-04-24 15:48:41', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-04-24 15:48:41', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '文章管理', 0, 0, 'article', NULL, NULL, 1, 0, 'M', '0', '0', '', 'github', 'admin', '2022-04-27 10:29:04', 'admin', '2022-05-09 14:49:27', '');
INSERT INTO `sys_menu` VALUES (2001, '栏目管理', 2000, 1, 'category', 'article/category/index', NULL, 1, 0, 'C', '0', '0', 'article:category:list', 'component', 'admin', '2022-04-27 10:31:48', 'admin', '2022-04-28 15:44:14', '');
INSERT INTO `sys_menu` VALUES (2002, '文章管理', 2000, 2, 'page', 'article/page/index', NULL, 1, 0, 'C', '0', '0', 'article:page:list', 'log', 'admin', '2022-04-27 15:39:48', 'admin', '2022-04-28 15:44:20', '');
INSERT INTO `sys_menu` VALUES (2003, '审核', 2002, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'article:page:review', '#', 'admin', '2022-04-28 09:57:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '文章查询', 2002, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'article:page:query', '#', 'admin', '2022-04-28 10:32:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '文章添加', 2002, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'article:page:add', '#', 'admin', '2022-04-28 11:12:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '文章编辑', 2000, 0, 'editor', 'article/editor/index', NULL, 1, 1, 'C', '0', '0', 'article:editor', 'edit', 'admin', '2022-04-28 15:40:50', 'admin', '2022-05-12 15:27:07', '');
INSERT INTO `sys_menu` VALUES (2007, '月报管理', 0, 0, 'monthly', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'druid', 'admin', '2022-05-07 10:08:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '待办', 2007, 0, 'backlog', 'monthly/backlog/index', NULL, 1, 0, 'C', '0', '0', 'monthly:backlog:list', 'time', 'admin', '2022-05-07 10:13:29', 'admin', '2022-05-07 23:33:23', '');
INSERT INTO `sys_menu` VALUES (2009, '我的申报', 2007, 1, 'form', 'monthly/form/index', NULL, 1, 0, 'C', '0', '0', 'monthly:form:list', 'edit', 'admin', '2022-05-07 10:14:34', 'admin', '2022-05-08 21:34:40', '');
INSERT INTO `sys_menu` VALUES (2010, '申报添加', 2009, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:form:add', '#', 'admin', '2022-05-07 20:13:15', 'admin', '2022-05-07 20:13:32', '');
INSERT INTO `sys_menu` VALUES (2011, '申报修改', 2009, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:form:edit', '#', 'admin', '2022-05-07 20:14:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '申报查询', 2009, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:form:query', '#', 'admin', '2022-05-07 20:23:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '申报删除', 2009, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:form:remove', '#', 'admin', '2022-05-07 20:23:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '申报导出', 2009, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:form:export', '#', 'admin', '2022-05-07 20:24:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '申报导入', 2009, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:form:import', '#', 'admin', '2022-05-07 20:24:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '申报管理', 2007, 2, 'manage', 'monthly/manage/index', NULL, 1, 0, 'C', '0', '0', 'monthly:manage:list', 'chart', 'admin', '2022-05-08 21:38:43', 'admin', '2022-05-08 22:22:50', '');
INSERT INTO `sys_menu` VALUES (2017, '待办查看', 2008, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:backlog:query', '#', 'admin', '2022-05-09 10:58:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '待办修改', 2008, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:backlog:edit', '#', 'admin', '2022-05-09 10:59:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '待办审核', 2008, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:backlog:review', '#', 'admin', '2022-05-09 11:01:21', 'admin', '2022-05-09 11:01:30', '');
INSERT INTO `sys_menu` VALUES (2020, '任务清单', 2007, 0, 'task', 'monthly/task/index', NULL, 1, 0, 'C', '0', '0', 'monthly:task:list', 'form', 'admin', '2022-05-09 13:08:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '任务查询', 2020, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:task:query', '#', 'admin', '2022-05-09 14:22:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '任务新增', 2020, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:task:add', '#', 'admin', '2022-05-09 14:24:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '任务修改', 2020, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:task:edit', '#', 'admin', '2022-05-09 14:24:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '任务删除', 2020, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:task:remove', '#', 'admin', '2022-05-09 14:25:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '申报导出', 2016, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:manage:export', '#', 'admin', '2022-05-11 14:07:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '申报导入', 2016, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'monthly:manage:import', '#', 'admin', '2022-05-11 14:07:41', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-04-24 15:48:41', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-04-24 15:48:41', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (10, 'ddd', '1', 0x3C6F6C3E3C6C693EE58EBBE68E89E998BFE890A8E5A4A7E58EA63C2F6C693E3C6C693EE68993E7AE973C2F6C693E3C2F6F6C3E3C70726520636C6173733D22716C2D73796E74617822207370656C6C636865636B3D2266616C7365223E6C65742069203D20303B0A636F6E736F6C652E6C6F672869290A3C2F7072653E, '0', 'admin', '2022-04-25 16:51:32', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":1,\"admin\":true,\"dataScope\":\"1\",\"params\":{},\"roleSort\":\"1\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"status\":\"0\"}],\"phonenumber\":\"15888888888\",\"admin\":true,\"loginDate\":1650786521000,\"remark\":\"管理员\",\"delFlag\":\"0\",\"loginIp\":\"127.0.0.1\",\"email\":\"ry@163.com\",\"nickName\":\"若依1\",\"sex\":\"1\",\"deptId\":103,\"avatar\":\"\",\"dept\":{\"deptName\":\"研发部门\",\"leader\":\"若依\",\"deptId\":103,\"orderNum\":\"1\",\"params\":{},\"parentId\":101,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"admin\",\"userId\":1,\"createBy\":\"admin\",\"createTime\":1650786521000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-26 10:51:58');
INSERT INTO `sys_oper_log` VALUES (101, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":2,\"admin\":false,\"dataScope\":\"2\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"status\":\"0\"}],\"phonenumber\":\"15666666666\",\"admin\":false,\"loginDate\":1650786521000,\"remark\":\"测试员\",\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[2],\"loginIp\":\"127.0.0.1\",\"email\":\"ry@qq.com\",\"nickName\":\"若依\",\"sex\":\"1\",\"deptId\":105,\"avatar\":\"\",\"dept\":{\"deptName\":\"测试部门\",\"leader\":\"若依\",\"deptId\":105,\"orderNum\":\"3\",\"params\":{},\"parentId\":101,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"ry\",\"userId\":2,\"createBy\":\"admin\",\"roleIds\":[2,100],\"createTime\":1650786521000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-26 11:36:58');
INSERT INTO `sys_oper_log` VALUES (102, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":2,\"admin\":false,\"dataScope\":\"2\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"status\":\"0\"},{\"flag\":false,\"roleId\":100,\"admin\":false,\"dataScope\":\"1\",\"params\":{},\"roleSort\":\"0\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"diysss\",\"roleName\":\"diy\",\"status\":\"0\"}],\"phonenumber\":\"15666666666\",\"admin\":false,\"loginDate\":1650786521000,\"remark\":\"测试员111\",\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[2],\"loginIp\":\"127.0.0.1\",\"email\":\"ry@qq.com\",\"nickName\":\"若依\",\"sex\":\"1\",\"deptId\":105,\"avatar\":\"\",\"dept\":{\"deptName\":\"测试部门\",\"leader\":\"若依\",\"deptId\":105,\"orderNum\":\"3\",\"params\":{},\"parentId\":101,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"ry\",\"userId\":2,\"createBy\":\"admin\",\"roleIds\":[2],\"createTime\":1650786521000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-26 12:04:56');
INSERT INTO `sys_oper_log` VALUES (103, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', NULL, '/system/config', '127.0.0.1', '内网IP', '{\"configName\":\"账号自助-验证码开关\",\"configKey\":\"sys.account.captchaOnOff\",\"createBy\":\"admin\",\"createTime\":1650786521000,\"updateBy\":\"admin\",\"configId\":4,\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"configType\":\"Y\",\"configValue\":\"false\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-26 13:07:59');
INSERT INTO `sys_oper_log` VALUES (104, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '123 123123', '{\"msg\":\"修改密码失败，旧密码错误\",\"code\":500}', 0, NULL, '2022-04-26 14:01:04');
INSERT INTO `sys_oper_log` VALUES (105, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', 'admin123 admin123', '{\"msg\":\"新密码不能与旧密码相同\",\"code\":500}', 0, NULL, '2022-04-26 14:08:25');
INSERT INTO `sys_oper_log` VALUES (106, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', 'admin123 123456', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-26 14:08:34');
INSERT INTO `sys_oper_log` VALUES (107, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', NULL, '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '123456 admin123', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-26 14:08:54');
INSERT INTO `sys_oper_log` VALUES (108, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2022/04/26/blob_20220426142210A001.jpeg\",\"code\":200}', 0, NULL, '2022-04-26 14:22:10');
INSERT INTO `sys_oper_log` VALUES (109, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2022/04/26/blob_20220426142440A002.jpeg\",\"code\":200}', 0, NULL, '2022-04-26 14:24:40');
INSERT INTO `sys_oper_log` VALUES (110, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', NULL, '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2022/04/26/blob_20220426160616A003.jpeg\",\"code\":200}', 0, NULL, '2022-04-26 16:06:16');
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'base_article,base_category,base_images', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-27 10:19:20');
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-04-27 10:21:32');
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/base_article', '127.0.0.1', '内网IP', '{tableName=base_article}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-27 10:21:35');
INSERT INTO `sys_oper_log` VALUES (114, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-04-27 10:21:36');
INSERT INTO `sys_oper_log` VALUES (115, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/base_category', '127.0.0.1', '内网IP', '{tableName=base_category}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-27 10:34:59');
INSERT INTO `sys_oper_log` VALUES (116, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-04-27 10:34:59');
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/base_article', '127.0.0.1', '内网IP', '{tableName=base_article}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-27 15:37:37');
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"log\",\"orderNum\":0,\"menuName\":\"文章管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"/\",\"createBy\":\"admin\",\"children\":[],\"isFrame\":\"1\",\"menuType\":\"C\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-27 15:39:48');
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"log\",\"orderNum\":0,\"menuName\":\"文章管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"/\",\"children\":[],\"createTime\":1651045188000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2002,\"menuType\":\"C\",\"perms\":\"article:page:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-27 15:40:24');
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"visible\":\"0\",\"icon\":\"log\",\"orderNum\":0,\"menuName\":\"文章管理\",\"params\":{},\"parentId\":2000,\"isCache\":\"0\",\"path\":\"/\",\"component\":\"article/page/index\",\"children\":[],\"createTime\":1651045188000,\"updateBy\":\"admin\",\"isFrame\":\"1\",\"menuId\":2002,\"menuType\":\"C\",\"perms\":\"article:page:list\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-04-27 15:40:49');
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-04-27 15:47:04');
INSERT INTO `sys_oper_log` VALUES (122, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-04-27 15:49:54');
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'monthly_task', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-09 13:04:14');
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-05-09 13:06:50');
INSERT INTO `sys_oper_log` VALUES (125, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":2,\"admin\":false,\"dataScope\":\"5\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"status\":\"0\"},{\"flag\":false,\"roleId\":100,\"admin\":false,\"dataScope\":\"2\",\"params\":{},\"roleSort\":\"0\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"diysss\",\"roleName\":\"diy\",\"status\":\"0\"}],\"phonenumber\":\"15666666666\",\"admin\":false,\"loginDate\":1650949864000,\"remark\":\"测试员111\",\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[2],\"loginIp\":\"127.0.0.1\",\"email\":\"ry@qq.com\",\"nickName\":\"若依\",\"sex\":\"1\",\"avatar\":\"\",\"dept\":{\"deptName\":\"测试部门\",\"leader\":\"若依\",\"deptId\":105,\"orderNum\":\"3\",\"params\":{},\"parentId\":101,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"ry\",\"userId\":2,\"createBy\":\"admin\",\"roleIds\":[2,100],\"createTime\":1650786521000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-11 11:11:32');
INSERT INTO `sys_oper_log` VALUES (126, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":2,\"admin\":false,\"dataScope\":\"5\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"status\":\"0\"},{\"flag\":false,\"roleId\":100,\"admin\":false,\"dataScope\":\"2\",\"params\":{},\"roleSort\":\"0\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"diysss\",\"roleName\":\"diy\",\"status\":\"0\"}],\"phonenumber\":\"15666666666\",\"admin\":false,\"loginDate\":1650949864000,\"remark\":\"测试员111\",\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[2],\"loginIp\":\"127.0.0.1\",\"email\":\"ry@qq.com\",\"nickName\":\"若依\",\"sex\":\"1\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"测试部门\",\"leader\":\"若依\",\"deptId\":105,\"orderNum\":\"3\",\"params\":{},\"parentId\":101,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"ry\",\"userId\":2,\"createBy\":\"admin\",\"roleIds\":[2,100],\"createTime\":1650786521000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-11 11:12:13');
INSERT INTO `sys_oper_log` VALUES (127, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":2,\"admin\":false,\"dataScope\":\"5\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"status\":\"0\"},{\"flag\":false,\"roleId\":100,\"admin\":false,\"dataScope\":\"2\",\"params\":{},\"roleSort\":\"0\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"diysss\",\"roleName\":\"diy\",\"status\":\"0\"}],\"phonenumber\":\"15666666666\",\"admin\":false,\"loginDate\":1650949864000,\"remark\":\"测试员111\",\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[2],\"loginIp\":\"127.0.0.1\",\"email\":\"ry@qq.com\",\"nickName\":\"若依\",\"sex\":\"1\",\"avatar\":\"\",\"dept\":{\"deptName\":\"致讯\",\"leader\":\"致讯\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"ry\",\"userId\":2,\"createBy\":\"admin\",\"roleIds\":[2,100],\"createTime\":1650786521000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-11 11:12:18');
INSERT INTO `sys_oper_log` VALUES (128, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":2,\"admin\":false,\"dataScope\":\"5\",\"params\":{},\"roleSort\":\"2\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"status\":\"0\"},{\"flag\":false,\"roleId\":100,\"admin\":false,\"dataScope\":\"2\",\"params\":{},\"roleSort\":\"0\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"diysss\",\"roleName\":\"diy\",\"status\":\"0\"}],\"phonenumber\":\"15666666666\",\"admin\":false,\"loginDate\":1650949864000,\"remark\":\"\",\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[2],\"loginIp\":\"127.0.0.1\",\"email\":\"ry@qq.com\",\"nickName\":\"若依\",\"sex\":\"1\",\"deptId\":100,\"avatar\":\"\",\"dept\":{\"deptName\":\"致讯\",\"leader\":\"致讯\",\"deptId\":100,\"orderNum\":\"0\",\"params\":{},\"parentId\":0,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"ry\",\"userId\":2,\"createBy\":\"admin\",\"roleIds\":[2,100],\"createTime\":1650786521000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 14:40:02');
INSERT INTO `sys_oper_log` VALUES (129, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"password\":\"$2a$10$vGW8LpQEEHDMi4/FkrcGb.KUECMenhqWzV0TtvbNcUTkrBM/NNQxi\",\"postIds\":[],\"nickName\":\"ddddd\",\"params\":{},\"userName\":\"diy2\",\"userId\":107,\"createBy\":\"admin\",\"roleIds\":[],\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 14:52:15');
INSERT INTO `sys_oper_log` VALUES (130, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"roles\":[{\"flag\":false,\"roleId\":101,\"admin\":false,\"dataScope\":\"3\",\"params\":{},\"roleSort\":\"0\",\"deptCheckStrictly\":false,\"menuCheckStrictly\":false,\"roleKey\":\"dd\",\"roleName\":\"管理员\",\"status\":\"0\"}],\"phonenumber\":\"15123112121\",\"admin\":false,\"loginDate\":0,\"remark\":\"1\",\"delFlag\":\"0\",\"password\":\"\",\"updateBy\":\"admin\",\"postIds\":[1],\"loginIp\":\"\",\"email\":\"\",\"nickName\":\"asdasd\",\"sex\":\"0\",\"deptId\":103,\"avatar\":\"\",\"dept\":{\"deptName\":\"综合应用事业部业务一组\",\"leader\":\"李小八\",\"deptId\":103,\"orderNum\":\"1\",\"params\":{},\"parentId\":101,\"children\":[],\"status\":\"0\"},\"params\":{},\"userName\":\"diy1\",\"userId\":106,\"createBy\":\"admin\",\"roleIds\":[101],\"createTime\":1652338134000,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-05-12 15:02:28');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-04-24 15:48:41', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-04-24 15:48:41', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-04-24 15:48:41', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '5', 1, 1, '0', '0', 'admin', '2022-04-24 15:48:41', 'admin', '2022-05-10 15:25:57', '普通角色');
INSERT INTO `sys_role` VALUES (100, 'diy', 'diysss', 0, '2', 1, 1, '0', '0', 'admin', '2022-04-26 11:22:32', 'admin', '2022-05-12 15:25:17', '');
INSERT INTO `sys_role` VALUES (101, '管理员', 'dd', 0, '3', 1, 1, '0', '0', 'admin', '2022-05-07 14:02:46', 'admin', '2022-05-11 14:09:35', NULL);
INSERT INTO `sys_role` VALUES (102, 'dasdas', 'asd', 1, '3', 1, 1, '0', '2', 'admin', '2022-05-12 15:26:27', 'admin', '2022-05-12 15:26:50', '');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (100, 100);
INSERT INTO `sys_role_dept` VALUES (100, 101);
INSERT INTO `sys_role_dept` VALUES (100, 103);
INSERT INTO `sys_role_dept` VALUES (100, 104);
INSERT INTO `sys_role_dept` VALUES (100, 105);
INSERT INTO `sys_role_dept` VALUES (100, 106);
INSERT INTO `sys_role_dept` VALUES (100, 107);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2011);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (2, 2013);
INSERT INTO `sys_role_menu` VALUES (2, 2014);
INSERT INTO `sys_role_menu` VALUES (2, 2015);
INSERT INTO `sys_role_menu` VALUES (2, 2017);
INSERT INTO `sys_role_menu` VALUES (2, 2018);
INSERT INTO `sys_role_menu` VALUES (100, 1);
INSERT INTO `sys_role_menu` VALUES (100, 100);
INSERT INTO `sys_role_menu` VALUES (100, 101);
INSERT INTO `sys_role_menu` VALUES (100, 102);
INSERT INTO `sys_role_menu` VALUES (100, 103);
INSERT INTO `sys_role_menu` VALUES (100, 104);
INSERT INTO `sys_role_menu` VALUES (100, 105);
INSERT INTO `sys_role_menu` VALUES (100, 106);
INSERT INTO `sys_role_menu` VALUES (100, 107);
INSERT INTO `sys_role_menu` VALUES (100, 108);
INSERT INTO `sys_role_menu` VALUES (100, 500);
INSERT INTO `sys_role_menu` VALUES (100, 501);
INSERT INTO `sys_role_menu` VALUES (100, 1001);
INSERT INTO `sys_role_menu` VALUES (100, 1002);
INSERT INTO `sys_role_menu` VALUES (100, 1003);
INSERT INTO `sys_role_menu` VALUES (100, 1004);
INSERT INTO `sys_role_menu` VALUES (100, 1005);
INSERT INTO `sys_role_menu` VALUES (100, 1006);
INSERT INTO `sys_role_menu` VALUES (100, 1007);
INSERT INTO `sys_role_menu` VALUES (100, 1008);
INSERT INTO `sys_role_menu` VALUES (100, 1009);
INSERT INTO `sys_role_menu` VALUES (100, 1010);
INSERT INTO `sys_role_menu` VALUES (100, 1011);
INSERT INTO `sys_role_menu` VALUES (100, 1012);
INSERT INTO `sys_role_menu` VALUES (100, 1013);
INSERT INTO `sys_role_menu` VALUES (100, 1014);
INSERT INTO `sys_role_menu` VALUES (100, 1015);
INSERT INTO `sys_role_menu` VALUES (100, 1016);
INSERT INTO `sys_role_menu` VALUES (100, 1017);
INSERT INTO `sys_role_menu` VALUES (100, 1018);
INSERT INTO `sys_role_menu` VALUES (100, 1019);
INSERT INTO `sys_role_menu` VALUES (100, 1020);
INSERT INTO `sys_role_menu` VALUES (100, 1021);
INSERT INTO `sys_role_menu` VALUES (100, 1022);
INSERT INTO `sys_role_menu` VALUES (100, 1023);
INSERT INTO `sys_role_menu` VALUES (100, 1024);
INSERT INTO `sys_role_menu` VALUES (100, 1025);
INSERT INTO `sys_role_menu` VALUES (100, 1026);
INSERT INTO `sys_role_menu` VALUES (100, 1027);
INSERT INTO `sys_role_menu` VALUES (100, 1028);
INSERT INTO `sys_role_menu` VALUES (100, 1029);
INSERT INTO `sys_role_menu` VALUES (100, 1030);
INSERT INTO `sys_role_menu` VALUES (100, 1031);
INSERT INTO `sys_role_menu` VALUES (100, 1032);
INSERT INTO `sys_role_menu` VALUES (100, 1033);
INSERT INTO `sys_role_menu` VALUES (100, 1034);
INSERT INTO `sys_role_menu` VALUES (100, 1035);
INSERT INTO `sys_role_menu` VALUES (100, 1036);
INSERT INTO `sys_role_menu` VALUES (100, 1037);
INSERT INTO `sys_role_menu` VALUES (100, 1038);
INSERT INTO `sys_role_menu` VALUES (100, 1039);
INSERT INTO `sys_role_menu` VALUES (100, 1040);
INSERT INTO `sys_role_menu` VALUES (100, 1041);
INSERT INTO `sys_role_menu` VALUES (100, 1042);
INSERT INTO `sys_role_menu` VALUES (100, 1043);
INSERT INTO `sys_role_menu` VALUES (100, 1044);
INSERT INTO `sys_role_menu` VALUES (100, 1045);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (100, 2009);
INSERT INTO `sys_role_menu` VALUES (100, 2010);
INSERT INTO `sys_role_menu` VALUES (100, 2011);
INSERT INTO `sys_role_menu` VALUES (100, 2012);
INSERT INTO `sys_role_menu` VALUES (100, 2013);
INSERT INTO `sys_role_menu` VALUES (100, 2014);
INSERT INTO `sys_role_menu` VALUES (100, 2015);
INSERT INTO `sys_role_menu` VALUES (100, 2016);
INSERT INTO `sys_role_menu` VALUES (100, 2017);
INSERT INTO `sys_role_menu` VALUES (100, 2018);
INSERT INTO `sys_role_menu` VALUES (100, 2019);
INSERT INTO `sys_role_menu` VALUES (100, 2020);
INSERT INTO `sys_role_menu` VALUES (100, 2021);
INSERT INTO `sys_role_menu` VALUES (100, 2022);
INSERT INTO `sys_role_menu` VALUES (100, 2023);
INSERT INTO `sys_role_menu` VALUES (100, 2024);
INSERT INTO `sys_role_menu` VALUES (100, 2025);
INSERT INTO `sys_role_menu` VALUES (100, 2026);
INSERT INTO `sys_role_menu` VALUES (101, 2007);
INSERT INTO `sys_role_menu` VALUES (101, 2009);
INSERT INTO `sys_role_menu` VALUES (101, 2010);
INSERT INTO `sys_role_menu` VALUES (101, 2011);
INSERT INTO `sys_role_menu` VALUES (101, 2012);
INSERT INTO `sys_role_menu` VALUES (101, 2013);
INSERT INTO `sys_role_menu` VALUES (101, 2014);
INSERT INTO `sys_role_menu` VALUES (101, 2015);
INSERT INTO `sys_role_menu` VALUES (101, 2016);
INSERT INTO `sys_role_menu` VALUES (101, 2025);
INSERT INTO `sys_role_menu` VALUES (101, 2026);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, NULL, 'admin', '小鬼😀', '00', 'impoh@qq.com', '15555555555', '2', '\\profile\\avatar\\3f75b19385203155e0d9a8100.jpeg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-05-12 14:39:33', 'admin', '2022-04-24 15:48:41', 'admin', '2022-12-06 14:32:22', NULL);
INSERT INTO `sys_user` VALUES (2, 100, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-04-26 13:11:04', 'admin', '2022-04-24 15:48:41', 'admin', '2022-11-14 15:26:58', '');
INSERT INTO `sys_user` VALUES (100, NULL, '12', '12', '00', '', '', '0', '', '$2b$10$ZM0u3V0SzFrjbyNNuLowE.03EVkZIab1hJM41E4cnN49L35xNZTm6', '0', '2', '', NULL, 'admin', '2022-04-26 11:47:55', 'admin', '2022-04-26 13:56:27', NULL);
INSERT INTO `sys_user` VALUES (101, 103, 'jiang', '江耗', '00', NULL, NULL, '0', '', '$2b$10$GQBQqWojUZRXVEoscP/3JuHrVbz.jZe64.gSInmZht5OgrYIt9U1a', '0', '2', '127.0.0.1', NULL, 'admin', '2022-05-07 13:10:23', 'admin', '2022-06-18 21:26:23', NULL);
INSERT INTO `sys_user` VALUES (102, 103, 'admin1', '管理员', '00', '', '', '0', '', '$2b$10$RPHhbxpvYXGEKqp65sGY9uP5rWIGbZ7VjUO9bHqMvahJ2hN7mfale', '0', '2', '127.0.0.1', '1970-01-01 08:00:00', 'admin', '2022-05-07 14:14:37', 'admin', '2022-06-01 09:19:30', NULL);
INSERT INTO `sys_user` VALUES (103, 101, 'admin2', '李小红', '00', NULL, NULL, '0', '', '$2b$10$Tyf.JYNs6FiXJ20lmfEH4ObtniMmn.DS8tR7unXUotTiu3rYxRhNK', '0', '2', '127.0.0.1', '1970-01-01 08:00:00', 'admin', '2022-05-07 15:30:04', 'admin', '2022-06-01 09:21:13', NULL);
INSERT INTO `sys_user` VALUES (104, 103, 'jiang2', '罗C', '00', '3222@qq.com', '15123123111', '0', '', '$2b$10$frZ26QJ/gxn2Wad8GxE7leJLKG8kfK10y1Ud86AXgsbJtrqKLQR2K', '0', '2', '127.0.0.1', '1970-01-01 08:00:00', 'admin', '2022-05-08 12:23:05', 'jiang2', '2022-05-18 14:13:10', '');
INSERT INTO `sys_user` VALUES (105, NULL, 'asdas', 'asd', '00', '', '15412321122', '0', '', '$2b$10$t45B8E7l7CUJ28svTayfye2XL3boNNXeaTT26pqI5cbyssxlliIl2', '0', '2', '', '1970-01-01 08:00:00', 'admin', '2022-05-09 19:55:03', 'admin', '2022-05-09 19:55:13', 'asdasd');
INSERT INTO `sys_user` VALUES (106, 103, 'diy1', 'asdasd', '00', '', '15123112121', '0', '', '', '0', '2', '', '1970-01-01 08:00:00', 'admin', '2022-05-12 14:48:54', 'admin', '2022-05-12 15:18:23', '');
INSERT INTO `sys_user` VALUES (107, NULL, 'diy2', 'ddddd', '00', '', '', '0', '', '$2b$10$VBTJ6behnrESxIcXa24dKe0I.WoJ8bP8Nr.ILrVFFErxbXxhmpNgu', '0', '2', '', NULL, 'admin', '2022-05-12 14:52:15', 'admin', '2022-05-12 15:20:20', NULL);
INSERT INTO `sys_user` VALUES (108, 100, 'yang', '老杨', '00', '', '', '0', '', '$2b$10$u1jV7ITC2vzGRZj8CzpsiuBrf0mC8gIbV28N/bHHrq7mrZuYTKaBW', '0', '0', '127.0.0.1', NULL, 'admin', '2022-06-18 21:29:41', '', '2022-06-18 21:33:55', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (2, 100);
INSERT INTO `sys_user_role` VALUES (108, 2);

SET FOREIGN_KEY_CHECKS = 1;
