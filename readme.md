# Scaffold Initialization 代码生成器

## 简介

基于SQL表结构自动生成Spring Boot后端接口与前端React代码的脚手架工具，通过解析SQL文件实现快速项目初始化。

## 功能特性

1. SQL表结构解析（支持CREATE TABLE语句）
2. 自动生成Spring Boot Admin服务代码
3. 生成React前端CRUD页面模板
4. 自定义包名/模块名配置
5. 支持字段类型自动映射（MySQL -> Java -> TypeScript）
6. 支持Swagger文档, RESTFUL API

## 使用步骤

### 1. 准备SQL文件

确保SQL文件包含完整建表语句，示例：

```sql
CREATE TABLE sys_user
(
    id       BIGINT PRIMARY KEY COMMENT '用户ID',
    username VARCHAR(50) COMMENT '用户名'
) COMMENT ='系统用户表';
```

如果需要基础模块，请执行：
demo.sql
基础模块包含完整的后台模块，包含用户管理、权限管理、角色管理、菜单管理、字典管理、系统配置等。

### 2. 配置参数

修改[CodeGenerator.java](file:https://github.com/sunjin0/scaffold-initialization/blob/d21bdfb941fda7253ddd0d8e5f9fa7fdf1a8ccc2/src/main/java/com/scaffold/scaffoldinitialization/service/CodeGenerator.java)
中的常量配置：

```java
// SQL文件路径
public static final String SQL_PATH = "your_sql_file.sql";
// 输出根目录
public static final String OUTPUT_DIR = "your_output_dir/";
```

### 3. 运行生成

执行main方法：

### 4. 查看生成内容

- 后端：`{OUTPUT_DIR}/admin-scaffold/`
- 前端：`{OUTPUT_DIR}/front-scaffold/`

## 注意事项

1. 依赖JDK17+运行环境
2. SQL文件需使用UTF-8编码
3. 当前不支持视图/存储过程解析

## 贡献指南

欢迎提交PR改进：

1. 扩展SQL解析器支持更多DDL语句
2. 完善字段约束处理（如NOT NULL）
3. 完善字段注释处理
4. 完善代码生成逻辑



