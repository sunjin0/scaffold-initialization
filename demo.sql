CREATE TABLE `user_member`
(
    `id`         bigint primary key NOT NULL COMMENT '主键',
    `name`       varchar(255)            DEFAULT NULL COMMENT '名称',
    `username`   varchar(255)            DEFAULT NULL COMMENT '用户名',
    `password`   varchar(255)            DEFAULT NULL COMMENT '密码',
    `phone`      varchar(255)            DEFAULT NULL COMMENT '电话',
    `email`      varchar(255)            DEFAULT NULL COMMENT '邮件',
    `avatar`     varchar(255)            DEFAULT NULL COMMENT '头像',
    `state`      bit(1)             NULL DEFAULT 0 COMMENT '状态',
    `deleted`    bit(1)             NULL DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at` bigint             NULL DEFAULT NULL COMMENT '修改时间',
    `sort_num`   int                NULL DEFAULT 1 COMMENT '排序号'
) comment '用户表';
# 1.系统模块
# 系统用户表
CREATE TABLE `sys_user`
(
    `id`         bigint PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键',
    `username`   varchar(255)       NOT NULL COMMENT '用户名',
    `sex`        varchar(255)       NULL     DEFAULT NULL COMMENT '性别',
    `type`       varchar(255)       NULL     DEFAULT NULL COMMENT '用户类型',
    `email`      varchar(255)       NULL     DEFAULT NULL COMMENT '邮箱',
    `phone`      varchar(255)       NULL     DEFAULT NULL COMMENT '手机号',
    `avatar`     varchar(255)       NULL     DEFAULT NULL COMMENT '头像',
    `password`   varchar(255)       NOT NULL COMMENT '密码',
    `state`      int(1)             NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`    bit(1)             NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NOT NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at` bigint             NOT NULL DEFAULT NULL COMMENT '修改时间',
    `sort_num`   int                NOT NULL DEFAULT 1 COMMENT '排序号'
) comment '系统用户表';
# 系统token表
CREATE TABLE `sys_token`
(
    `id`            bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `user_id`       bigint             NOT NULL COMMENT '用户ID',
    `token`         varchar(255)       NOT NULL COMMENT 'token',
    `refresh_token` varchar(255)       NOT NULL COMMENT '刷新token',
    `state`         int(1)             NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`       bit(1)             NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at`    bigint             NOT NULL COMMENT '创建时间',
    `updated_at`    bigint             NOT NULL COMMENT '修改时间',
    `sort_num`      int                NOT NULL DEFAULT 1 COMMENT '排序号'
) comment '系统token表';
# 系统角色表
CREATE TABLE `sys_role`
(
    `id`          bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `name`        varchar(255)       NOT NULL COMMENT '名称',
    `description` varchar(255)       NOT NULL COMMENT '描述',
    `state`       int(1)             NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`     bit(1)             NULL     DEFAULT false COMMENT '逻辑删除',
    `created_at`  bigint             NULL     DEFAULT NULL COMMENT '创建时间',
    `updated_at`  bigint             NULL     DEFAULT NULL COMMENT '修改时间',
    `sort_num`    int                NULL     DEFAULT 1 COMMENT '排序号'
) comment '系统角色表';
# 系统用户角色表
CREATE TABLE `sys_user_role`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `user_id`    bigint             NOT NULL COMMENT '用户ID',
    `role_id`    bigint             NOT NULL COMMENT '角色ID',
    `state`      int(1)             NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`    bit(1)             NULL     DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NULL     DEFAULT NULL COMMENT '创建时间',
    `updated_at` bigint             NULL     DEFAULT NULL COMMENT '修改时间',
    `sort_num`   int                NULL     DEFAULT 1 COMMENT '排序号'
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
    `state`       int(1)             NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`     bit(1)             NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at`  bigint             NOT NULL COMMENT '创建时间',
    `updated_at`  bigint             NOT NULL COMMENT '修改时间',
    `sort_num`    int                NOT NULL DEFAULT 1 COMMENT '排序号'
) comment '系统权限表';
# 系统角色权限表
CREATE TABLE `sys_role_resource`
(
    `id`          bigint NOT NULL PRIMARY KEY COMMENT '主键',
    `role_id`     bigint NOT NULL COMMENT '角色ID',
    `resource_id` bigint NOT NULL COMMENT '权限ID',
    `state`       int(1) NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`     bit(1) NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at`  bigint NOT NULL COMMENT '创建时间',
    `updated_at`  bigint NOT NULL COMMENT '修改时间',
    `sort_num`    int    NOT NULL DEFAULT 1 COMMENT '排序号'
) comment '系统角色权限表';
# 系统字典表
CREATE TABLE `sys_dict`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `code`       varchar(255)       NOT NULL COMMENT '编码',
    `parent`     varchar(255) COMMENT '父编码',
    `name`       varchar(255)       NOT NULL COMMENT '名称',
    `name_cn`    varchar(255)       NOT NULL COMMENT '中文名称',
    `val`        varchar(255) COMMENT '值',
    `remark`     varchar(255) COMMENT '备注',
    `state`      int(1)             NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`    bit(1)             NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NOT NULL COMMENT '创建时间',
    `updated_at` bigint             NOT NULL COMMENT '修改时间',
    `sort_num`   int                NOT NULL DEFAULT 1 COMMENT '排序号'
) COMMENT = '系统字典表';
# 系统配置
CREATE TABLE `sys_config`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `code`       varchar(255)       NOT NULL COMMENT '编码',
    `name`       varchar(255)       NOT NULL COMMENT '名称',
    `parent`     varchar(255) COMMENT '父编码',
    `value`      varchar(255)       NOT NULL COMMENT '值',
    `remark`     varchar(255)       NOT NULL COMMENT '备注',
    `state`      int(1)             NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`    bit(1)             NOT NULL DEFAULT false COMMENT '逻辑删除',
    `created_at` bigint             NOT NULL COMMENT '创建时间',
    `updated_at` bigint             NOT NULL COMMENT '修改时间',
    `sort_num`   int                NOT NULL DEFAULT 1 COMMENT '排序号'
) comment '系统配置表';
# 2.消息模块
# 系统邮件消息表
CREATE TABLE `msg_email`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `user_id`    bigint             NOT NULL COMMENT '接收用户ID',
    `email`      varchar(255)       NOT NULL COMMENT '接收邮箱',
    `type`       varchar(255)       NOT NULL COMMENT '消息类型',
    `code`       varchar(255) COMMENT '消息编码',
    `subject`    varchar(255)       NOT NULL COMMENT '邮件主题',
    `body`       text               NOT NULL COMMENT '邮件内容',
    `state`      int(1)             NOT NULL DEFAULT 0 COMMENT '消息状态（0：未读，1：已读）',
    `created_at` bigint             NOT NULL COMMENT '创建时间',
    `updated_at` bigint             NOT NULL COMMENT '修改时间',
    `deleted`    bit(1)             NOT NULL DEFAULT false COMMENT '逻辑删除',
    `sort_num`   int                NOT NULL DEFAULT 1 COMMENT '排序序号'
) COMMENT = '系统邮件消息表';
# 系统短信消息表
CREATE TABLE `msg_sms`
(
    `id`         bigint PRIMARY KEY NOT NULL COMMENT '主键',
    `user_id`    bigint             NOT NULL COMMENT '用户ID',
    `phone`      varchar(255)       NOT NULL COMMENT '手机号码',
    `code`       varchar(255)       NOT NULL COMMENT '验证码',
    `type`       varchar(255)       NOT NULL COMMENT '验证码类型',
    `subject`    varchar(255)       NOT NULL COMMENT '主题',
    `body`       text               NOT NULL COMMENT '内容',
    `state`      int(1)             NOT NULL DEFAULT 0 COMMENT '状态',
    `deleted`    bit(1)             NULL     DEFAULT false COMMENT '逻辑删除',
    `created_at` timestamp          NOT NULL COMMENT '创建时间',
    `updated_at` timestamp          NOT NULL COMMENT '更新时间',
    `sort_num`   int                NOT NULL DEFAULT 1 COMMENT '排序号'
) COMMENT = '系统短信消息表';
# 字典基础数据
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (3, 'Message_Constant', 'Message', 'Message Constant', '消息常量', NULL, NULL, 1726196324, 1726196324, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (4, 'Message_Email_From', 'Message_Constant', 'System Mailbox', '系统邮箱', 'sun.summer.day@qq.com', NULL,
        1726196324, 1731994580433, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (5, 'Captcha', NULL, 'Whether the email verification code is enabled', '邮箱验证码是否开启', 'true',
        'true，不发送验证码，也不校验', 1726196324, 1734922204343, 1, 99);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (6, 'Resource_Type', NULL, 'Resource Type', '资源类型', NULL, NULL, 1726196324, 1726196324, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (7, 'Resource_Type_Route', 'Resource_Type', 'Route', '路由', NULL, NULL, 1726196324, 1726196324, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (8, 'Resource_Type_Permission', 'Resource_Type', 'Permission', '权限', NULL, NULL, 1726196324, 1726196324, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (10, 'Gender_Type', NULL, 'Gender Type', '性别类型', NULL, NULL, 1732157196914, 1732157196914, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (11, 'Gender_Type_Man', 'Gender_Type', 'Man', '男', NULL, NULL, 1732157246505, 1732157246505, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (12, 'Gender_Type_Woman', 'Gender_Type', 'Woman', '女', '', NULL, 1732157288146, 1732506856975, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (13, 'Gender_Type_Other', 'Gender_Type', 'Other', '其他', '', NULL, 1732157317983, 1732157883949, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (14, 'System_Role', NULL, 'System Role', '系统角色', NULL, NULL, 1732157975145, 1732157975145, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (15, 'System_Role_User', 'System_Role', 'System', '系统', '', NULL, 1732158021058, 1732162929093, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (16, 'System_Role_Tenant', 'System_Role', 'Tenant', '租户', NULL, NULL, 1732158093374, 1732158093374, 1, 2);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (22, 'email_template_login_subject', 'email_template', 'Login Verification Code', '登录验证码', '',
        '登录邮件标题', 1734682294, 1734682294, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (23, 'email_template_login_content', 'email_template', 'Login Verification Code: ${code}',
        '您的验证码是：${code}', '', '登录邮件内容', 1734682294, 1734682294, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (24, 'email_template', NULL, 'Email Template', '邮件模板', '', '邮件模板', 1734686432, 1734686432, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (28, 'Message', NULL, 'Message Dict', '消息字典', NULL, NULL, 1734921807446, 1734921807446, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (29, 'Message_Type', 'Message', 'Message Type', '消息类型', NULL, NULL, 1734922178599, 1734922178599, 1, 0);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (30, 'Message_Type_Notification', 'Message_Type', 'Notification', '通知', NULL, NULL, 1734922283133,
        1734922939573, 1, 1);
INSERT INTO `sys_dict`(`id`, `code`, `parent`, `name`, `name_cn`, `val`, `remark`, `created_at`, `updated_at`, `state`,
                       `sort_num`)
VALUES (31, 'Message_Type_Verification', 'Message_Type', 'Verification Code', '验证码', NULL, NULL, 1734922363145,
        1734922950949, 1, 1);
