/*
 Navicat Premium Data Transfer

 Source Server         : dev
 Source Server Type    : MySQL
 Source Server Version : 80025 (8.0.25)
 Source Host           : localhost:3306
 Source Schema         : huayou

 Target Server Type    : MySQL
 Target Server Version : 80025 (8.0.25)
 File Encoding         : 65001

 Date: 09/03/2025 13:08:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for com_attach
-- ----------------------------
DROP TABLE IF EXISTS `com_attach`;
CREATE TABLE `com_attach`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `realName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `fileType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件类型',
  `attachSize` double NULL DEFAULT NULL COMMENT '附件尺寸',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `user` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '线上路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '附件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_buyer
-- ----------------------------
DROP TABLE IF EXISTS `com_buyer`;
CREATE TABLE `com_buyer`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `cityId` bigint NULL DEFAULT NULL COMMENT '城市ID',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮件',
  `portId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '港口',
  `status` bit(1) NULL DEFAULT NULL COMMENT '买家状态（1：Active，0：Inactive）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '买家表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_city
-- ----------------------------
DROP TABLE IF EXISTS `com_city`;
CREATE TABLE `com_city`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `nameEn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名称',
  `provinceId` bigint NULL DEFAULT NULL COMMENT '省份ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '城市表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_company
-- ----------------------------
DROP TABLE IF EXISTS `com_company`;
CREATE TABLE `com_company`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `nameEn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名称',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标志',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'dict 内部公司  外部公司(0内部，1外部)',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `fax` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '传真',
  `cityId` bigint NULL DEFAULT NULL COMMENT '城市ID',
  `emergencyName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人',
  `emergencyPhone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人电话',
  `departurePort` bigint NULL DEFAULT NULL COMMENT '发货港',
  `tradeRegisterNum` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '税号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '网址',
  `externalType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外部公司类型：SHIPPER、CONSIGNEE、NOTIFY PARTY',
  `first` bit(1) NULL DEFAULT b'0' COMMENT '第一个中转公司',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态（未激活：0，激活：1）',
  `postalCode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮政编码',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '语言',
  `registration` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工商登记号',
  `license` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生产经营许可证',
  `creditCode` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `abbreviation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司简称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公司表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_country
-- ----------------------------
DROP TABLE IF EXISTS `com_country`;
CREATE TABLE `com_country`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `nameEn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名称',
  `parent` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父节点',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '国家表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_customer_address
-- ----------------------------
DROP TABLE IF EXISTS `com_customer_address`;
CREATE TABLE `com_customer_address`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `locationCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地点编码',
  `deliveryDirection` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '送货方向',
  `detailedAddress` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '详细地址',
  `transportLeadTime` int NULL DEFAULT NULL COMMENT '运输提前期(天)',
  `contactPerson` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contactPhone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `mobilePhone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '移动电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `defaultDeliveryAddress` int NULL DEFAULT NULL COMMENT '默认收货地址(0：否，1：是)',
  `defaultInvoicingAddress` int NULL DEFAULT NULL COMMENT '默认开票地址(0：否，1：是)',
  `defaultPaymentAddress` int NULL DEFAULT NULL COMMENT '默认付款地址(0：否，1：是)',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态（1：Active，0：Inactive）',
  `customerId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家Id/公司Id',
  `unitNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '门牌号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_forwarder
-- ----------------------------
DROP TABLE IF EXISTS `com_forwarder`;
CREATE TABLE `com_forwarder`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `supplierId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '供应商ID',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `cityId` bigint NULL DEFAULT NULL COMMENT '城市',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态（未激活：0，激活：1）'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代运人表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_forwarder_supplier
-- ----------------------------
DROP TABLE IF EXISTS `com_forwarder_supplier`;
CREATE TABLE `com_forwarder_supplier`  (
  `id` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '改变',
  `forwarderId` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货代id',
  `supplierId` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '船舱公司id',
  `deleted` bit(1) NULL DEFAULT NULL COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_hs_code
-- ----------------------------
DROP TABLE IF EXISTS `com_hs_code`;
CREATE TABLE `com_hs_code`  (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `minOD` double NULL DEFAULT NULL COMMENT '最小外径',
  `maxOD` double NULL DEFAULT NULL COMMENT '最大外径',
  `minWT` double NULL DEFAULT NULL COMMENT '最小内径',
  `maxWT` double NULL DEFAULT NULL COMMENT '最大内径',
  `sizeId` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'SizeId',
  `specId` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'SpecId',
  `countryId` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '国家Id',
  `grade` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `make` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `end` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `uses` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `surface` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `steelTariff` bit(1) NULL DEFAULT NULL COMMENT '关税',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态（未激活：0，激活：1）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_order_forwarder
-- ----------------------------
DROP TABLE IF EXISTS `com_order_forwarder`;
CREATE TABLE `com_order_forwarder`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `supplierId` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '船舱公司ID',
  `forwarderId` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '代运人ID',
  `status` bit(1) NULL DEFAULT b'0' COMMENT '状态（0 已生成，1 已通知）',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '动态密码',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '填价链接',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单-代运人关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_origin_place
-- ----------------------------
DROP TABLE IF EXISTS `com_origin_place`;
CREATE TABLE `com_origin_place`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `fullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '全称',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态（1：Active，0：Inactive）',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '始发地表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_port
-- ----------------------------
DROP TABLE IF EXISTS `com_port`;
CREATE TABLE `com_port`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `nameEn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名称',
  `country` bigint NULL DEFAULT NULL COMMENT '国家',
  `city` bigint NULL DEFAULT NULL COMMENT '城市',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货币',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '港口类型(Departure Port   Destination Port)',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_province
-- ----------------------------
DROP TABLE IF EXISTS `com_province`;
CREATE TABLE `com_province`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `nameEn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名称',
  `countryId` bigint NULL DEFAULT NULL COMMENT '国家ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '省份表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_size
-- ----------------------------
DROP TABLE IF EXISTS `com_size`;
CREATE TABLE `com_size`  (
  `id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `nameEn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名称',
  `odMM` double NULL DEFAULT NULL COMMENT '管子外径（公制）',
  `wtMM` double NULL DEFAULT NULL COMMENT '管子内径（公制）',
  `uses` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典配置：  Line Pipe /OCTG Casing/ OCTG Tubing/Piling/Mechanical',
  `odInch` double NULL DEFAULT NULL COMMENT '管子外径（英制）',
  `wtInch` double NULL DEFAULT NULL COMMENT '管子内径（英制）',
  `lable1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签1',
  `lable2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签2',
  `price` bigint NULL DEFAULT NULL COMMENT '预估价格',
  `kgm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'kg/m',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态（未激活：0，激活：1）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '尺寸表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_size_use
-- ----------------------------
DROP TABLE IF EXISTS `com_size_use`;
CREATE TABLE `com_size_use`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编码',
  `foreignTradeDays` int NULL DEFAULT NULL COMMENT '外贸免息天数',
  `domestiCtradeDays` int NULL DEFAULT NULL COMMENT '内贸免息天数',
  `interestGroup` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '扣息分组(普管/特管)',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态（1：Active，0：Inactive）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Size类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_spec
-- ----------------------------
DROP TABLE IF EXISTS `com_spec`;
CREATE TABLE `com_spec`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `uses` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字典配置：  Line Pipe /OCTG Casing/ OCTG Tubing/Piling/Mechanical',
  `make` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `grade1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `grade2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `spec` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL COMMENT '买家状态（1：Active，0：Inactive）',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '规格表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for com_supplier
-- ----------------------------
DROP TABLE IF EXISTS `com_supplier`;
CREATE TABLE `com_supplier`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态（1：Active，0：Inactive）',
  `cityId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '城市Id',
  `forwarderId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货代id',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '供应商表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for flyway_schema_history
-- ----------------------------
DROP TABLE IF EXISTS `flyway_schema_history`;
CREATE TABLE `flyway_schema_history`  (
  `installed_rank` int NOT NULL,
  `version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `script` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `checksum` int NULL DEFAULT NULL,
  `installed_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`) USING BTREE,
  INDEX `flyway_schema_history_s_idx`(`success` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mem_member
-- ----------------------------
DROP TABLE IF EXISTS `mem_member`;
CREATE TABLE `mem_member`  (
  `id` bigint NOT NULL,
  `areaCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区号',
  `phoneNum` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `userId` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nickName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `firstName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名',
  `lastName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓',
  `pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '语言，默认zh',
  `wechatOpenId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信openID',
  `wechatUnionId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信UnionID，如果需要和app，PC网站联合需要，暂时不用',
  `stripeCustomer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态，默认0',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `verified` bit(1) NULL DEFAULT b'1' COMMENT '邮箱是否验证',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `bio` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个人简介',
  `address` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个人地址',
  `zipCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮编号码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid`(`wechatOpenId` ASC) USING BTREE,
  UNIQUE INDEX `phoneNum`(`phoneNum` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  UNIQUE INDEX `userId`(`userId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mem_token
-- ----------------------------
DROP TABLE IF EXISTS `mem_token`;
CREATE TABLE `mem_token`  (
  `id` bigint NOT NULL,
  `memberId` bigint NOT NULL COMMENT '用户id',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备对应的token',
  `device` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '对应的设备,如ios',
  `userAgent` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '登录信息表;' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for msg_client
-- ----------------------------
DROP TABLE IF EXISTS `msg_client`;
CREATE TABLE `msg_client`  (
  `id` bigint NOT NULL,
  `memberId` bigint NULL DEFAULT NULL,
  `deviceId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备ID',
  `deviceType` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备类型',
  `alias` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '别名',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `memberId`(`memberId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客户端列表;' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for msg_message
-- ----------------------------
DROP TABLE IF EXISTS `msg_message`;
CREATE TABLE `msg_message`  (
  `id` bigint NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'URL',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息;' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for msg_message_record
-- ----------------------------
DROP TABLE IF EXISTS `msg_message_record`;
CREATE TABLE `msg_message_record`  (
  `id` bigint NOT NULL,
  `memberId` bigint NULL DEFAULT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'URL',
  `hasRead` bit(1) NULL DEFAULT NULL COMMENT '是否已读',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `memberId`(`memberId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息发送记录;' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for msg_sms_message
-- ----------------------------
DROP TABLE IF EXISTS `msg_sms_message`;
CREATE TABLE `msg_sms_message`  (
  `id` bigint NOT NULL,
  `areaCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区号',
  `mobile` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `contentType` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '短信类型',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `verifyCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '验证码',
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态',
  `ip` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发送ip',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '短信记录;' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_beneficiary
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_beneficiary`;
CREATE TABLE `order_attach_beneficiary`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买方',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  `companyId` bigint NULL DEFAULT NULL COMMENT '公司ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_booking_inquiry
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_booking_inquiry`;
CREATE TABLE `order_attach_booking_inquiry`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订舱询价单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_certificate_origin
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_certificate_origin`;
CREATE TABLE `order_attach_certificate_origin`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `companyId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attach1` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '正本',
  `attach2` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '草本',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_confirm_order
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_confirm_order`;
CREATE TABLE `order_attach_confirm_order`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `companyId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `tiDanAtth` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '提单',
  `baoDanAtth` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报单',
  `refuseDesc` varchar(1048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `retiDanAtth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_customs_auth
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_customs_auth`;
CREATE TABLE `order_attach_customs_auth`  (
  `id` bigint NOT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买方',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  `companyId` bigint NULL DEFAULT NULL COMMENT '公司ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_customs_sample
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_customs_sample`;
CREATE TABLE `order_attach_customs_sample`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  `companyId` bigint NULL DEFAULT NULL COMMENT '公司ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_declaration
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_declaration`;
CREATE TABLE `order_attach_declaration`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买方',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  `companyId` bigint NULL DEFAULT NULL COMMENT '公司ID',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_freight
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_freight`;
CREATE TABLE `order_attach_freight`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买方',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  `companyId` bigint NULL DEFAULT NULL COMMENT '公司ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_invoice
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_invoice`;
CREATE TABLE `order_attach_invoice`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `companyId` bigint NULL DEFAULT NULL COMMENT '公司ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家',
  `port` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '港口',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目的地',
  `message` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '信息',
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  `payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '付款方式',
  `shippingMarking` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '装运标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_lading
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_lading`;
CREATE TABLE `order_attach_lading`  (
  `id` bigint NOT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `companyId` bigint NULL DEFAULT NULL COMMENT '公司ID',
  `vessel` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `lNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(2028) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `consignee` varchar(2028) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人公司',
  `notifyParty` varchar(2028) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '通知人公司',
  `port` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '港口',
  `discharge` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卸货港',
  `quantity` int NULL DEFAULT NULL,
  `delivery` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kindNum` int NULL DEFAULT NULL,
  `weight` double NULL DEFAULT NULL,
  `measurement` double NULL DEFAULT NULL,
  `containerNotes` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '集装箱描述',
  `salesNotes` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '销售描述',
  `marks` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标志和号码',
  `goodsDesc` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `freightClause` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `wayBill` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家',
  `shipper` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '托运人公司',
  `container` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '集装箱类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_pl
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_pl`;
CREATE TABLE `order_attach_pl`  (
  `id` bigint NOT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单ID',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `companyId` bigint NULL DEFAULT NULL COMMENT '公司ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家',
  `port` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '港口',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目的地',
  `message` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_ship
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_ship`;
CREATE TABLE `order_attach_ship`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家',
  `companyId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '船证' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for order_attach_shipping
-- ----------------------------
DROP TABLE IF EXISTS `order_attach_shipping`;
CREATE TABLE `order_attach_shipping`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家',
  `companyId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态',
  `attachId` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '附件ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '舱单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qt_item
-- ----------------------------
DROP TABLE IF EXISTS `qt_item`;
CREATE TABLE `qt_item`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `sizeId` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '尺寸ID',
  `length` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '长度类型   R1  R2  R3  TRL  SRL  DRL  Fixed',
  `minLength` double NULL DEFAULT NULL COMMENT '最小长度',
  `maxLength` double NULL DEFAULT NULL COMMENT '最大长度',
  `make` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `spec` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `end` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `finish` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quotePcs` int NULL DEFAULT NULL,
  `quoteMton` double NULL DEFAULT NULL,
  `quoteMeter` double NULL DEFAULT NULL,
  `quoteFt` double NULL DEFAULT NULL COMMENT '报价英尺',
  `price` double NULL DEFAULT NULL COMMENT '预估价格',
  `externalSurface` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `internalSurface` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ItemDesc` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `quoteId` bigint NULL DEFAULT NULL COMMENT '报价ID',
  `quantityRequire` int NULL DEFAULT NULL COMMENT '数量公差要求',
  `outDiameterRequire` int NULL DEFAULT NULL COMMENT '外径公差要求',
  `lengthRequire` int NULL DEFAULT NULL COMMENT '长度公差要求',
  `deliveryDays` int NULL DEFAULT NULL COMMENT '交货天数',
  `overdueDays` int NULL DEFAULT NULL COMMENT '超期天数',
  `wallRequire` int NULL DEFAULT NULL COMMENT '壁厚公差要求',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qt_order
-- ----------------------------
DROP TABLE IF EXISTS `qt_order`;
CREATE TABLE `qt_order`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `quoteId` bigint NULL DEFAULT NULL COMMENT '报价ID',
  `orderDesc` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货计划',
  `requirements` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '要求',
  `port` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '离岸港口',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目的地',
  `attachId` bigint NULL DEFAULT NULL COMMENT '顶舱',
  `portAtth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '进仓/进港通知单',
  `manifestAtth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '定舱单',
  `packing` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '打包方式',
  `conditions` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '条件',
  `orderTime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '下单时间',
  `status` bigint NULL DEFAULT NULL COMMENT '状态（0:未完成，1:完成）',
  `despositRate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '定金比例',
  `incoterm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运输类型 FCA   FOB  CIF  EXW',
  `orderNo` int NOT NULL AUTO_INCREMENT,
  `container` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '集装箱  20  40  45 散货船',
  `containerNum` int NULL DEFAULT NULL COMMENT '集装箱数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orderNo`(`orderNo` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qt_order_item
-- ----------------------------
DROP TABLE IF EXISTS `qt_order_item`;
CREATE TABLE `qt_order_item`  (
  `id` bigint NOT NULL COMMENT '主键',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `pcs` int NULL DEFAULT NULL,
  `mton` double NULL DEFAULT NULL,
  `ft` double NULL DEFAULT NULL COMMENT '英尺',
  `meter` double NULL DEFAULT NULL COMMENT '米',
  `bdlsNum` int NULL DEFAULT NULL,
  `bdlsDesc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` bigint NULL DEFAULT NULL COMMENT '价格',
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单元',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货币',
  `poNo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'PO#',
  `itemId` bigint NULL DEFAULT NULL COMMENT '询单ID',
  `isComplete` bit(1) NULL DEFAULT NULL COMMENT '是否完成（0：未完成，1: 完成）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品订单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qt_order_item_value
-- ----------------------------
DROP TABLE IF EXISTS `qt_order_item_value`;
CREATE TABLE `qt_order_item_value`  (
  `id` bigint NOT NULL,
  `deleted` tinyint(1) NULL DEFAULT NULL COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT NULL COMMENT '排序号',
  `heat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pcs` int NULL DEFAULT NULL,
  `ft` double NULL DEFAULT NULL,
  `meter` double NULL DEFAULT NULL,
  `mTon` double NULL DEFAULT NULL,
  `itemId` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'qt_order_item_value' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qt_order_price
-- ----------------------------
DROP TABLE IF EXISTS `qt_order_price`;
CREATE TABLE `qt_order_price`  (
  `id` bigint NOT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `orderId` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `seaFee` bigint NULL DEFAULT NULL COMMENT '海运费',
  `containerFee` bigint NULL DEFAULT NULL COMMENT '订舱费',
  `thcFee` bigint NULL DEFAULT NULL COMMENT 'THC',
  `pickFee` bigint NULL DEFAULT NULL COMMENT '装箱费',
  `reinforceFee` bigint NULL DEFAULT NULL COMMENT '加固费',
  `foreignFee` bigint NULL DEFAULT NULL COMMENT '洋提进洋',
  `vgmFee` bigint NULL DEFAULT NULL COMMENT '箱铅+VGM',
  `unloadingFee` bigint NULL DEFAULT NULL COMMENT '卸货费',
  `documentFee` bigint NULL DEFAULT NULL COMMENT '文件费',
  `electricityFee` bigint NULL DEFAULT NULL COMMENT '电放费',
  `ediFee` bigint NULL DEFAULT NULL COMMENT 'EDI',
  `container` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '集装箱  20  40  45 散货船',
  `isCheck` bit(1) NULL DEFAULT NULL COMMENT '是否是选中',
  `supplierId` bigint NULL DEFAULT NULL COMMENT '船舱公司',
  `shipDate` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '船期',
  `ensFee` bigint NULL DEFAULT NULL COMMENT 'ENS',
  `frightTotal` bigint NULL DEFAULT NULL COMMENT '海运合计',
  `portTotal` bigint NULL DEFAULT NULL COMMENT '海港合计',
  `total` bigint NULL DEFAULT NULL COMMENT '合计',
  `voyage` bigint NULL DEFAULT NULL COMMENT '航程',
  `isTransit` bit(1) NULL DEFAULT NULL COMMENT '是否中转',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `containerNum` int NULL DEFAULT NULL COMMENT '集装箱数量',
  `amendmentFee` bigint NULL DEFAULT NULL COMMENT '改单费',
  `customsFee` bigint NULL DEFAULT NULL COMMENT '报关费',
  `transitTime` double NULL DEFAULT NULL COMMENT '目的港免箱时间（天）',
  `forwarderId` bigint NULL DEFAULT NULL COMMENT '报价货代Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单价格表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qt_quote
-- ----------------------------
DROP TABLE IF EXISTS `qt_quote`;
CREATE TABLE `qt_quote`  (
  `id` bigint NOT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `buyerId` bigint NULL DEFAULT NULL COMMENT '买家ID',
  `sales` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '销售ID',
  `uses` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Line Pipe    OCTG Casing  OCTG Tubing  Piling  Mechical',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单类型 直接buyer  ,   有中间商 转给buyer  ,  TSP 订货',
  `incoterm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运输类型 FCA   FOB  CIF  EXW',
  `port` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '离岸港口',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目的地',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货币',
  `despositRate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '定金比例',
  `ros` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交货日',
  `orderDesc` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单描述',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单状态（0:未提交1:已提交2:已通过3:已拒绝4.已结束）',
  `qId` bigint NOT NULL AUTO_INCREMENT COMMENT '订单Id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `qId`(`qId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '报价表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for qt_quote_company
-- ----------------------------
DROP TABLE IF EXISTS `qt_quote_company`;
CREATE TABLE `qt_quote_company`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `companyId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司ID',
  `quoteId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '询单ID',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '询单-公司关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_constant
-- ----------------------------
DROP TABLE IF EXISTS `sys_constant`;
CREATE TABLE `sys_constant`  (
  `id` bigint NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `vals` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `remarks` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `createdAt` bigint NULL DEFAULT NULL,
  `updatedAt` bigint NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0',
  `sortedNum` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '常量表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nameEnus` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nameZhcn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nameZhtw` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `vals` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `remarks` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `createdAt` bigint NULL DEFAULT NULL,
  `updatedAt` bigint NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0',
  `sortedNum` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource`  (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parentId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `nameCh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资源表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `roleCode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource`  (
  `id` bigint NOT NULL,
  `roleId` bigint NULL DEFAULT NULL,
  `resourceId` bigint NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_sys_role_resource_sys_resource_2`(`resourceId` ASC) USING BTREE,
  INDEX `fk_sys_role_resource_sys_role_1`(`roleId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_snap
-- ----------------------------
DROP TABLE IF EXISTS `sys_snap`;
CREATE TABLE `sys_snap`  (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '描述',
  `scripts` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '原始数据',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '格式化后的数据，前端使用',
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `loginName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  `fingerprint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `workNum` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint NOT NULL,
  `roleId` bigint NULL DEFAULT NULL,
  `userId` bigint NULL DEFAULT NULL,
  `deleted` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除',
  `createdAt` bigint NULL DEFAULT NULL COMMENT '创建时间',
  `updatedAt` bigint NULL DEFAULT NULL COMMENT '修改时间',
  `sortedNum` int NULL DEFAULT 1 COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_sys_user_role_sys_role_1`(`roleId` ASC) USING BTREE,
  INDEX `fk_sys_user_role_sys_user_1`(`userId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
