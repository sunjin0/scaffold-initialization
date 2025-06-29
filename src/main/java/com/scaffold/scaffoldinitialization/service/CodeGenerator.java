package com.scaffold.scaffoldinitialization.service;

import com.scaffold.scaffoldinitialization.entity.TableInfo;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Properties;

public class CodeGenerator {
    // 模板目录
    private static final String TEMPLATE_DIR = "templates";
    // 项目根目录
    private static final String PROJECT_ROOT = "hy";
    // 包名
    private static final String PACKAGE_NAME = "com.example.demo";
    // 输出目录
    private static final String OUTPUT_DIR = "C:\\Users\\Administrator\\IdeaProjects\\";
    // SQL文件路径
    public static final String SQL_PATH = "huayou_3.9.sql";

    public static void main(String[] args) throws Exception {
        // 1. 解析 SQL 获取所有表结构
        List<TableInfo> tables = SqlParser.parseSql(SQL_PATH);
        if (tables.isEmpty()) {
            System.out.println("SQL解析失败");
            return;
        }

        // 2. 初始化Velocity引擎
        VelocityEngine ve = getVelocityEngine();
        // 3. 创建基础项目结构
        createProjectStructure();
        // 4. 生成全局配置文件
        generateGlobalFiles(ve);

        // 5. 为每个表生成代码
        for (TableInfo table : tables) {
            table.setPackageName(PACKAGE_NAME);
            String entityPath = String.format("%s/src/main/java/%s/entity/%s.java", PROJECT_ROOT, table.getPackageName(), table.getClassName());
            String mapperPath = String.format("%s/src/main/java/%s/mapper/%sMapper.java", PROJECT_ROOT, table.getPackageName(), table.getClassName());
            String servicePath = String.format("%s/src/main/java/%s/service/%sService.java", PROJECT_ROOT, table.getPackageName(), table.getClassName());
            String serviceImplPath = String.format("%s/src/main/java/%s/service/impl/%sServiceImpl.java", PROJECT_ROOT, table.getPackageName(), table.getClassName());
            String controllerPath = String.format("%s/src/main/java/%s/controller/%sController.java", PROJECT_ROOT, table.getPackageName(), table.getClassName());

            if (table.getPrefix() != null) {
                entityPath = String.format("%s/src/main/java/%s/%s/entity/%s.java", PROJECT_ROOT, table.getPackageName(), table.getPrefix(), table.getClassName());
                mapperPath = String.format("%s/src/main/java/%s/%s/mapper/%sMapper.java", PROJECT_ROOT, table.getPackageName(), table.getPrefix(), table.getClassName());
                servicePath = String.format("%s/src/main/java/%s/%s/service/%sService.java", PROJECT_ROOT, table.getPackageName(), table.getPrefix(), table.getClassName());
                serviceImplPath = String.format("%s/src/main/java/%s/%s/service/impl/%sServiceImpl.java", PROJECT_ROOT, table.getPackageName(), table.getPrefix(), table.getClassName());
                controllerPath = String.format("%s/src/main/java/%s/%s/controller/%sController.java", PROJECT_ROOT, table.getPackageName(), table.getPrefix(), table.getClassName());
            }
            generateFile(ve, "Entity.vm", table, entityPath);
            generateFile(ve, "Mapper.vm", table, mapperPath);
            generateFile(ve, "Service.vm", table, servicePath);
            generateFile(ve, "ServiceImpl.vm", table, serviceImplPath);
            generateFile(ve, "Controller.vm", table, controllerPath);
        }

        System.out.println("✅ 项目代码生成完成！");
    }

    /**
     * 初始化 Velocity 引擎
     */
    private static VelocityEngine getVelocityEngine() {
        Properties props = new Properties();
        props.setProperty("resource.loader", "class");
        props.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        props.setProperty("input.encoding", "UTF-8");
        props.setProperty("output.encoding", "UTF-8");
        VelocityEngine ve = new VelocityEngine(props);
        ve.init();
        return ve;
    }

    /**
     * 创建基础项目结构（src, pom.xml等）
     */
    private static void createProjectStructure() {
        new File(PROJECT_ROOT).mkdirs();
        new File(OUTPUT_DIR + PROJECT_ROOT + "/src/main/java/" + PACKAGE_NAME).mkdirs();
        new File(OUTPUT_DIR + PROJECT_ROOT + "/src/main/resources").mkdirs();
    }

    /**
     * 生成全局配置文件
     */
    private static void generateGlobalFiles(VelocityEngine ve) throws Exception {
        TableInfo tableInfo = new TableInfo();
        tableInfo.setPackageName(PACKAGE_NAME);
        String projectName = SqlParser.convertToCamelCase(PROJECT_ROOT);
        tableInfo.setClassName(PROJECT_ROOT);
        tableInfo.setServiceName(projectName);
        generateFile(ve, "Application.vm", tableInfo, PROJECT_ROOT + String.format("/src/main/java/%s/%sApplication.java", PACKAGE_NAME, projectName));
        generateFile(ve, "pom.vm", tableInfo, PROJECT_ROOT + "/pom.xml");
        generateFile(ve, "application.yml.vm", tableInfo, PROJECT_ROOT + "/src/main/resources/application.yml");
    }

    /**
     * 使用模板生成文件
     */
    private static void generateFile(VelocityEngine ve, String tplName, TableInfo table, String outPath) throws Exception {
        String templates = TEMPLATE_DIR + "/" + tplName;
        Template tpl = ve.getTemplate(templates, "UTF-8");
        VelocityContext ctx = new VelocityContext();
        if (table.getPrefix() != null)
            ctx.put("packageName", table.getPackageName() + "." + table.getPrefix());
        else
            ctx.put("packageName", table.getPackageName());
        ctx.put("tableName", table.getTableName());
        ctx.put("className", table.getClassName());
        ctx.put("serviceName", table.getServiceName());
        ctx.put("classComment", table.getClassComment());
        ctx.put("fields", table.getFields());

        File outFile = new File(OUTPUT_DIR + outPath);
        outFile.getParentFile().mkdirs();
        try (Writer writer = new OutputStreamWriter(new FileOutputStream(outFile), StandardCharsets.UTF_8)) {
            tpl.merge(ctx, writer);
        }
        System.out.println("📄 生成文件：" + outPath);
    }
}
