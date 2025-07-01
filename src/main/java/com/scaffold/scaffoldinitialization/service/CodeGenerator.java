package com.scaffold.scaffoldinitialization.service;

import com.scaffold.scaffoldinitialization.entity.TableInfo;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Properties;

import static com.scaffold.scaffoldinitialization.config.getVelocityEngine;

public class CodeGenerator {
    // 多模块名称
    private static final String MODULE_API = "api";
    private static final String MODULE_BIZ = "biz";
    private static final String MODULE_COMMON = "common";
    private static final String MODULE_ADMIN = "admin";
    private static final String MODULE_FRONT = "front";
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
            // Entity 放入 api 模块
            String entityPath = String.format("%s/entity/%s.java", PACKAGE_NAME.replace(".", "/"), table.getClassName());
            if (table.getPrefix() != null)
                entityPath = String.format("%s/%s/entity/%s.java", PACKAGE_NAME.replace(".", "/"), table.getPrefix(), table.getClassName());
            generateFile(ve, "Entity.vm", table, MODULE_API, entityPath);

            // Mapper 放入 api 模块
            String mapperPath = String.format("%s/mapper/%sMapper.java", PACKAGE_NAME.replace(".", "/"), table.getClassName());
            if (table.getPrefix() != null)
                mapperPath = String.format("%s/%s/mapper/%sMapper.java", PACKAGE_NAME.replace(".", "/"), table.getPrefix(), table.getClassName());
            generateFile(ve, "Mapper.vm", table, MODULE_API, mapperPath);

            // Service 放入 biz 模块
            String servicePath = String.format("%s/service/%sService.java", PACKAGE_NAME.replace(".", "/"), table.getClassName());
            if (table.getPrefix() != null)
                servicePath = String.format("%s/service/%sService.java", PACKAGE_NAME.replace(".", "/"), table.getPrefix() + table.getClassName());
            generateFile(ve, "Service.vm", table, MODULE_API, servicePath);

            // ServiceImpl 放入 biz 模块
            String serviceImplPath = String.format("%s/service/impl/%sServiceImpl.java", PACKAGE_NAME.replace(".", "/"), table.getClassName());
            if (table.getPrefix() != null)
                serviceImplPath = String.format("%s/service/impl/%s%sServiceImpl.java", PACKAGE_NAME.replace(".", "/"), table.getPrefix(), table.getClassName());
            generateFile(ve, "ServiceImpl.vm", table, MODULE_BIZ, serviceImplPath);

            // Controller 放入 admin 模块
            String controllerPath = String.format("%s/controller/%sController.java", PACKAGE_NAME.replace(".", "/"), table.getClassName());
            if (table.getPrefix() != null)
                controllerPath = String.format("%s/controller/%sController.java", PACKAGE_NAME.replace(".", "/"), table.getPrefix());
            generateFile(ve, "Controller.vm", table, MODULE_ADMIN, controllerPath);
        }

        System.out.println("✅ 项目代码生成完成！");
    }



    /**
     * 创建基础项目结构（src, pom.xml等）
     */
    /**
     * 创建多模块项目结构（api, biz, common, admin, front）
     */
    private static void createProjectStructure() {
        new File(PROJECT_ROOT).mkdirs();

        // 创建各模块源码目录
        createModuleStructure(MODULE_API);
        createModuleStructure(MODULE_BIZ);
        createModuleStructure(MODULE_COMMON);
        createModuleStructure(MODULE_ADMIN);
        createModuleStructure(MODULE_FRONT);

        // resources 目录统一放在根模块下
        new File(OUTPUT_DIR + PROJECT_ROOT + "/src/main/resources").mkdirs();
    }

    private static void createModuleStructure(String moduleName) {
        String modulePath = OUTPUT_DIR + PROJECT_ROOT + "/" + moduleName;
        new File(modulePath).mkdirs();
        new File(modulePath + "/src/main/java").mkdirs();
        new File(modulePath + "/src/main/resources").mkdirs();
    }


    /**
     * 生成全局配置文件（如根 pom.xml）
     */
    private static void generateGlobalFiles(VelocityEngine ve) throws Exception {
        TableInfo tableInfo = new TableInfo();
        tableInfo.setPackageName(PACKAGE_NAME);
        String projectName = SqlParser.convertToCamelCase(PROJECT_ROOT);
        tableInfo.setClassName(PROJECT_ROOT);
        tableInfo.setServiceName(projectName);

        // 生成根 pom.xml
        generateFile(ve, "pom.vm", tableInfo, PROJECT_ROOT + "/pom.xml");

        // 生成各模块的 pom.xml
        generateModulePom(ve, MODULE_API);
        generateModulePom(ve, MODULE_BIZ);
        generateModulePom(ve, MODULE_COMMON);
        generateModulePom(ve, MODULE_ADMIN);
        generateModulePom(ve, MODULE_FRONT);

    }

    private static void generateModulePom(VelocityEngine ve, String moduleName) throws Exception {
        VelocityContext ctx = new VelocityContext();
        ctx.put("groupId", CodeGenerator.PACKAGE_NAME);
        ctx.put("projectName", PROJECT_ROOT);
        ctx.put("version", "1.0-SNAPSHOT");
        ctx.put("module", moduleName);
        ctx.put("java.version", "17");

        Template tpl = ve.getTemplate(TEMPLATE_DIR + "/" + "module-pom.vm", "UTF-8");
        File outFile = new File(OUTPUT_DIR + PROJECT_ROOT + "/" + moduleName + "/pom.xml");
        outFile.getParentFile().mkdirs();

        try (Writer writer = new OutputStreamWriter(new FileOutputStream(outFile), StandardCharsets.UTF_8)) {
            tpl.merge(ctx, writer);
        }
    }

    /**
     * 使用模板生成文件到指定模块中
     */
    private static void generateFile(VelocityEngine ve, String tplName, TableInfo table, String module, String outPath) throws Exception {
        String templates = TEMPLATE_DIR + "/" + tplName;
        Template tpl = ve.getTemplate(templates, "UTF-8");
        VelocityContext ctx = new VelocityContext();
        String fullPackageName = (table.getPrefix() != null)
                ? table.getPackageName() + "." + table.getPrefix()
                : table.getPackageName();
        ctx.put("packageName", fullPackageName);
        ctx.put("tableName", table.getTableName());
        ctx.put("className", table.getClassName());
        ctx.put("serviceName", table.getServiceName());
        ctx.put("classComment", table.getClassComment());
        ctx.put("fields", table.getFields());

        String outputFilePath = OUTPUT_DIR + PROJECT_ROOT + "/" + module + "/src/main/java/" + outPath;
        File outFile = new File(outputFilePath);
        outFile.getParentFile().mkdirs();

        try (Writer writer = new OutputStreamWriter(new FileOutputStream(outFile), StandardCharsets.UTF_8)) {
            tpl.merge(ctx, writer);
        }
        System.out.println("📄 生成文件：" + outputFilePath);
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
