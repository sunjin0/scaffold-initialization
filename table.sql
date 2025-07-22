CREATE TABLE `user_member`(
    `id` bigint NOT NULL COMMENT '主键',
    `username` varchar(255) NOT NULL  DEFAULT '' COMMENT '用户名',
    `password` varchar(255) NOT NULL  DEFAULT '' COMMENT '密码',
    `nickname` varchar(255) NOT NULL  DEFAULT '' COMMENT '昵称',
    `email` varchar(255) NOT NULL  DEFAULT '' COMMENT '邮箱',
    `phone` varchar(255) NOT NULL  DEFAULT '' COMMENT '手机号',
    `status` tinyint NOT NULL  DEFAULT 1 COMMENT '状态',
    `created_at` bigint NOT NULL  DEFAULT 0 COMMENT '创建时间',
    `updated_at` bigint NOT NULL  DEFAULT 0 COMMENT '修改时间',
    `deleted` bit(1) NOT NULL  DEFAULT b'0' COMMENT '逻辑删除',
    `sort_num` int NOT NULL  DEFAULT 1 COMMENT '排序号'
) comment '用户表';
