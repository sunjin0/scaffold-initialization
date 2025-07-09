CREATE TABLE `user_member`
(
    `id`         bigint primary key NOT NULL COMMENT '主键',
    `name`       varchar(255)            DEFAULT NULL COMMENT '名称',
    `username`   varchar(255)            DEFAULT NULL COMMENT '用户名',
    `password`   varchar(255)            DEFAULT NULL COMMENT '密码',
    `phone`      varchar(255)            DEFAULT NULL COMMENT '电话',
    `email`      varchar(255)            DEFAULT NULL COMMENT '邮件',
    `avatar`     varchar(255)            DEFAULT NULL COMMENT '头像',
    `state`      bit(1)             NULL DEFAULT NULL COMMENT '状态',
    `deleted`    bit(1)             NULL DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at` bigint             NULL DEFAULT NULL COMMENT '修改时间',
    `sort_num` int                NULL DEFAULT 1 COMMENT '排序号'
) comment '用户表';
# 1.系统模块
# 系统用户表
CREATE TABLE `sys_user`
(
    `id`         bigint PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键',
    `username`   varchar(255)       NOT NULL COMMENT '用户名',
    `sex`        varchar(255)       NULL DEFAULT NULL COMMENT '性别',
    `type`       varchar(255)       NULL DEFAULT NULL COMMENT '用户类型',
    `email`      varchar(255)       NULL DEFAULT NULL COMMENT '邮箱',
    `phone`      varchar(255)       NULL DEFAULT NULL COMMENT '手机号',
    `avatar`     varchar(255)       NULL DEFAULT NULL COMMENT '头像',
    `password`   varchar(255)       NOT NULL COMMENT '密码',
    `state`     int(1)             NOT NULL COMMENT '状态',
    `deleted`    bit(1)             NULL DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at` bigint             NULL DEFAULT NULL COMMENT '修改时间',
    `sort_num` int                NULL DEFAULT 1 COMMENT '排序号'
) comment '系统用户表';
# 系统角色表
CREATE TABLE `sys_role`
(
    `id`          bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `name`        varchar(255)       NOT NULL COMMENT '名称',
    `description` varchar(255)       NOT NULL COMMENT '描述',
    `state`     int(1)             NOT NULL COMMENT '状态',
    `deleted`     bit(1)             NULL DEFAULT false COMMENT '逻辑删除',
    `created_at`  bigint             NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at`  bigint             NULL DEFAULT NULL COMMENT '修改时间',
    `sort_num`  int                NULL DEFAULT 1 COMMENT '排序号'
) comment '系统角色表';
# 系统用户角色表
CREATE TABLE `sys_user_role`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `user_id`    bigint             NOT NULL COMMENT '用户ID',
    `role_id`    bigint             NOT NULL COMMENT '角色ID',
    `state`     int(1)             NOT NULL COMMENT '状态',
    `deleted`    bit(1)             NULL DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at` bigint             NULL DEFAULT NULL COMMENT '修改时间',
    `sort_num` int                NULL DEFAULT 1 COMMENT '排序号'
) comment '系统用户角色表';
# 系统权限表
CREATE TABLE `sys_resource`
(
    `id`          bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `name`        varchar(255)       NOT NULL COMMENT '权限名称',
    `name_cn`     varchar(255)       NOT NULL COMMENT '权限中文名称',
    `path`        varchar(255)       NOT NULL COMMENT '权限路径',
    `type`        varchar(255)       NOT NULL COMMENT '权限类型',
    `icon`        varchar(255)       NOT NULL COMMENT '权限图标',
    `parent_id`   bigint             NOT NULL COMMENT '父权限ID',
    `description` varchar(255)       NOT NULL COMMENT '权限描述',
    `state`     int(1)             NOT NULL COMMENT '状态',
    `deleted`     bit(1)             NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at`  bigint             NOT NULL COMMENT '创建时间',
    `updated_at`  bigint             NOT NULL COMMENT '修改时间',
    `sort_num`  int                NOT NULL DEFAULT 1 COMMENT '排序号'
) comment '系统权限表';
# 系统角色权限表
CREATE TABLE `sys_role_resource`
(
    `id`          bigint NOT NULL PRIMARY KEY COMMENT '主键',
    `role_id`     bigint NOT NULL COMMENT '角色ID',
    `resource_id` bigint NOT NULL COMMENT '权限ID',
    `state`     int(1)             NOT NULL COMMENT '状态',
    `deleted`     bit(1) NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at`  bigint NOT NULL COMMENT '创建时间',
    `updated_at`  bigint NOT NULL COMMENT '修改时间',
    `sort_num`  int    NOT NULL DEFAULT 1 COMMENT '排序号'
) comment '系统角色权限表';
# 系统字典表
CREATE TABLE `sys_dict`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `code`       varchar(255)       NOT NULL COMMENT '编码',
    `parent`     varchar(255)       NOT NULL COMMENT '父编码',
    `name`       varchar(255)       NOT NULL COMMENT '名称',
    `name_cn`    varchar(255)       NOT NULL COMMENT '中文名称',
    `val`        varchar(255) COMMENT '值',
    `remark`     varchar(255)       NOT NULL COMMENT '备注',
    `state`     int(1)             NOT NULL COMMENT '状态',
    `deleted`    bit(1)             NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NOT NULL COMMENT '创建时间',
    `updated_at` bigint             NOT NULL COMMENT '修改时间',
    `sort_num` int                NOT NULL DEFAULT 1 COMMENT '排序号'
) COMMENT = '系统字典表';
# 2.消息模块
# 系统邮件消息表
CREATE TABLE `msg_email`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `userId`     bigint             NOT NULL COMMENT '接收用户ID',
    `email`      varchar(255)       NOT NULL COMMENT '接收邮箱',
    `type`       varchar(255)       NOT NULL COMMENT '消息类型',
    `code`       varchar(255) COMMENT '消息编码',
    `subject`    varchar(255)       NOT NULL COMMENT '邮件主题',
    `body`       text               NOT NULL COMMENT '邮件内容',
    `state`     int(1)             NOT NULL COMMENT '消息状态（0：未读，1：已读）',
    `created_at` bigint             NOT NULL COMMENT '创建时间',
    `updated_at` bigint             NOT NULL COMMENT '修改时间',
    `deleted`    bit(1)             NOT NULL COMMENT '逻辑删除',
    `sort_num` int                NOT NULL COMMENT '排序序号'
) COMMENT = '系统邮件消息表';
# 系统短信消息表
CREATE TABLE `msg_sms`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `userId`     bigint             NOT NULL COMMENT '用户ID',
    `phone`      varchar(255)       NOT NULL COMMENT '手机号码',
    `code`       varchar(255)       NOT NULL COMMENT '验证码',
    `type`       varchar(255)       NOT NULL COMMENT '验证码类型',
    `subject`    varchar(255)       NOT NULL COMMENT '主题',
    `body`       text               NOT NULL COMMENT '内容',
    `state`     int(1)             NOT NULL COMMENT '状态',
    `deleted`    timestamp          NULL COMMENT '逻辑删除',
    `created_at` timestamp          NOT NULL COMMENT '创建时间',
    `updated_at` timestamp          NOT NULL COMMENT '更新时间',
    `sort_num` int                NOT NULL COMMENT '排序号'
) COMMENT = '系统短信消息表'
