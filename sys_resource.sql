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