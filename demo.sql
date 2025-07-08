CREATE TABLE `user_member`
(
    `id`         bigint primary key NOT NULL COMMENT '主键',
    `name`       varchar(255) DEFAULT NULL COMMENT '名称',
    `username`   varchar(255) DEFAULT NULL COMMENT '用户名',
    `password`   varchar(255) DEFAULT NULL COMMENT '密码',
    `phone`      varchar(255) DEFAULT NULL COMMENT '电话',
    `email`      varchar(255) DEFAULT NULL COMMENT '邮件',
    `avatar`     varchar(255) DEFAULT NULL COMMENT '头像',
    `state`     bit(1) NULL  DEFAULT NULL COMMENT '状态',
    `deleted`    bit(1) NULL  DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint NULL  DEFAULT NULL COMMENT '创建时间',
    `updated_at` bigint NULL  DEFAULT NULL COMMENT '修改时间',
    `sorted_num` int    NULL  DEFAULT 1 COMMENT '排序号'
) comment '用户表';
