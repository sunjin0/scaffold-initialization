package com.scaffold.scaffoldinitialization.service;

import com.scaffold.scaffoldinitialization.entity.TableInfo;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

import static com.scaffold.scaffoldinitialization.utils.config.getVelocityEngine;

public class AdminScaffoldService {
    // 多模块名称
    private static final String MODULE_API = "api";
    private static final String MODULE_BIZ = "biz";
    private static final String MODULE_COMMON = "common";
    private static final String MODULE_ADMIN = "admin";
    private static final String MODULE_FRONT = "front";
    // 模板目录
    private static final String TEMPLATE_DIR = "templates";
    // 项目根目录
    private static String PROJECT_ROOT = "hy";
    // 包名
    private static String PACKAGE_NAME = "com.example.demo";
    // 输出目录
    private static String OUTPUT_DIR = "C:\\Users\\Administrator\\IdeaProjects\\";


    /**
     * 生成 Admin Scaffold
     *
     * @param projectName 项目名称
     * @param packageName 包名称
     * @param tables      表
     * @param outputDir   输出目录 比如D:\\project
     * @throws Exception 例外
     */
    public static void generateAdminScaffold(String projectName,
                                             String packageName,
                                             ArrayList<TableInfo> tables,
                                             String outputDir) throws Exception {
        PROJECT_ROOT = projectName;
        OUTPUT_DIR = outputDir;
        PACKAGE_NAME = packageName;

        // 1. 初始化Velocity引擎
        VelocityEngine ve = getVelocityEngine();
        // 2. 创建基础项目结构
        createProjectStructure();
        // 3. 生成全局配置文件
        generateGlobalFiles(ve);

        // 4. 为每个表生成代码
        for (TableInfo table : tables) {
            CodeGenerator(table, ve);
        }
        // 5.权限邮件基础代码
        generateBaseFiles(ve);
        // 6.创建启动 文件
        TableInfo tableOne = tables.get(0);
        TableInfo table = new TableInfo();
        table.setPackageName(tableOne.getPackageName());
        table.setClassName(tableOne.getClassName());
        // 创建后端启动文件
        String admin = SqlParser.capitalizeFirstLetter(MODULE_ADMIN);
        table.setServiceName(admin);
        generateFile(ve, "Application.vm", table, MODULE_ADMIN, String.format("%s/%sApplication.java", PACKAGE_NAME.replace(".", "/"), admin));
        // 生成前端启动文件
        String front = SqlParser.capitalizeFirstLetter(MODULE_FRONT);
        table.setServiceName(front);
        generateFile(ve, "Application.vm", table, MODULE_FRONT, String.format("%s/%sApplication.java", PACKAGE_NAME.replace(".", "/"), front));

        //7.test  文件
        Template template = ve.getTemplate(TEMPLATE_DIR + "/admin/ApplicationTests.vm");
        table.setServiceName(admin);
        generateTestFile(table, template, MODULE_ADMIN);
        table.setServiceName(front);
        generateTestFile(table, template, MODULE_FRONT);
        System.out.println("✅ 后台项目代码生成完成！");
    }

    private static void generateTestFile(TableInfo tableOne, Template template, String moduleName) throws IOException {
        VelocityContext ctx = new VelocityContext();
        ctx.put("packageName", tableOne.getPackageName());
        ctx.put("className", tableOne.getClassName());
        ctx.put("serviceName", tableOne.getServiceName());
        String outputFilePath = OUTPUT_DIR + PROJECT_ROOT + "/" + moduleName + "/src/main/test/java/" + PACKAGE_NAME.replace(".", "/") + "/" + SqlParser.capitalizeFirstLetter(moduleName) + "ApplicationTests.java";
        File outFile = new File(outputFilePath);
        outFile.getParentFile().mkdirs();

        try (Writer writer = new OutputStreamWriter(new FileOutputStream(outFile), StandardCharsets.UTF_8)) {
            template.merge(ctx, writer);
        }
    }

    /**
     * 生成 SYS 文件
     *
     * @param ve ve
     */
    private static void generateSysFiles(VelocityEngine ve) {
        String[][] sysTemplateMapping = getSysTemplateMapping();
        VelocityContext context = new VelocityContext();
        context.put("packageName", PACKAGE_NAME + ".sys");
        context.put("packageName2", PACKAGE_NAME);
        String packageName = PACKAGE_NAME.replace('.', '/');
        String targetSubDir = "src/main/java/" + packageName + "/sys/";

        generateBaseFiles(ve, sysTemplateMapping, targetSubDir, context, packageName);

    }

    /**
     * 生成基本文件
     *
     * @param ve                 ve
     * @param sysTemplateMapping SYS 模板映射
     * @param targetSubDir       目标子目录
     * @param context            上下文
     * @param packageName        包名称
     */
    private static void generateBaseFiles(VelocityEngine ve, String[][] sysTemplateMapping, String targetSubDir, VelocityContext context, String packageName) {
        for (String[] mapping : sysTemplateMapping) {
            String templatePath = mapping[0];
            String targetFileName = mapping[1];
            if (templatePath.contains("entity")
                    || templatePath.contains("vo")
                    || templatePath.contains("service")
                    || templatePath.contains("mapper")) {
                generateConfigFileFromTemplate(ve,
                        MODULE_API,
                        templatePath,
                        targetSubDir,
                        targetFileName,
                        context);
            } else if (templatePath.contains("impl")) {
                generateConfigFileFromTemplate(ve,
                        MODULE_BIZ,
                        templatePath,
                        targetSubDir,
                        targetFileName,
                        context);
            } else if (templatePath.contains("controller")) {
                generateConfigFileFromTemplate(ve,
                        MODULE_ADMIN,
                        templatePath,
                        targetSubDir,
                        targetFileName,
                        context);
            } else {
                generateConfigFileFromTemplate(ve,
                        MODULE_COMMON,
                        templatePath,
                        "src/main/java/" + packageName,
                        targetFileName,
                        context);
            }
        }
    }

    /**
     * 生成消息文件
     *
     * @param ve ve
     */
    private static void generateMessageFile(VelocityEngine ve) {
        String[][] msgTemplateMapping = getMessageTemplateMapping();
        VelocityContext context = new VelocityContext();
        context.put("packageName", PACKAGE_NAME + ".msg");
        context.put("packageName2", PACKAGE_NAME);
        String packageName = PACKAGE_NAME.replace('.', '/');
        String targetSubDir = "src/main/java/" + packageName + "/msg/";
        generateBaseFiles(ve, msgTemplateMapping, targetSubDir, context, packageName);
    }

    /**
     * 生成基本文件
     *
     * @param ve ve
     */
    private static void generateBaseFiles(VelocityEngine ve) {
        generateSysFiles(ve);
        generateMessageFile(ve);
    }

    /**
     * 获取消息模板映射
     *
     * @return {@link String[][] }
     */
    private static String[][] getMessageTemplateMapping() {
        return new String[][]{
                //entity
                {"admin/base/msg/entity/Email.java.vm", "entity/Email.java"},
                {"admin/base/msg/entity/Sms.java.vm", "entity/Sms.java"},
                // vo
                {"admin/base/msg/vo/EmailVo.java.vm", "vo/EmailVo.java"},
                {"admin/base/msg/vo/SmsVo.java.vm", "vo/SmsVo.java"},
                //mapper
                {"admin/base/msg/mapper/EmailMessageMapper.java.vm", "mapper/EmailMessageMapper.java"},
                {"admin/base/msg/mapper/SmsMessageMapper.java.vm", "mapper/SmsMessageMapper.java"},
                //service
                {"admin/base/msg/service/EmailMessageService.java.vm", "service/EmailMessageService.java"},
                {"admin/base/msg/service/SmsMessageService.java.vm", "service/SmsMessageService.java"},
                //impl
                {"admin/base/msg/impl/EmailMessageServiceImpl.java.vm", "service/impl/EmailMessageServiceImpl.java"},
                {"admin/base/msg/impl/SmsMessageServiceImpl.java.vm", "service/impl/SmsMessageServiceImpl.java"},
                //controller
                {"admin/base/msg/controller/EmailController.java.vm", "controller/EmailController.java"},
                {"admin/base/msg/controller/SmsController.java.vm", "controller/SmsController.java"},
        };
    }

    /**
     * 获取 SYS 模板映射
     *
     * @return {@link String[][] }
     */
    private static String[][] getSysTemplateMapping() {
        return new String[][]{
                //entity
                {"admin/base/sys/entity/Dict.java.vm", "entity/Dict.java"},
                {"admin/base/sys/entity/Resource.java.vm", "entity/Resource.java"},
                {"admin/base/sys/entity/Role.java.vm", "entity/Role.java"},
                {"admin/base/sys/entity/User.java.vm", "entity/User.java"},
                {"admin/base/sys/entity/UserRole.java.vm", "entity/UserRole.java"},
                {"admin/base/sys/entity/RoleResource.java.vm", "entity/RoleResource.java"},
                //vo
                {"admin/base/sys/vo/DictVo.java.vm", "vo/DictVo.java"},
                {"admin/base/sys/vo/RoleVo.java.vm", "vo/RoleVo.java"},
                {"admin/base/sys/vo/ResourceVo.java.vm", "vo/ResourceVo.java"},
                {"admin/base/sys/vo/UserVo.java.vm", "vo/UserVo.java"},
                {"admin/base/sys/vo/RoleResourceVo.java.vm", "vo/RoleResourceVo.java"},
                // service
                {"admin/base/sys/service/DictService.java.vm", "service/DictService.java"},
                {"admin/base/sys/service/ResourceService.java.vm", "service/ResourceService.java"},
                {"admin/base/sys/service/RoleService.java.vm", "service/RoleService.java"},
                {"admin/base/sys/service/RoleResourceService.java.vm", "service/RoleResourceService.java"},
                {"admin/base/sys/service/UserService.java.vm", "service/UserService.java"},
                {"admin/base/sys/service/UserRoleService.java.vm", "service/UserRoleService.java"},
                {"admin/base/sys/service/TokenService.java.vm", "service/TokenService.java"},
                //impl
                {"admin/base/sys/impl/DictServiceImpl.java.vm", "service/impl/DictServiceImpl.java"},
                {"admin/base/sys/impl/ResourceServiceImpl.java.vm", "service/impl/ResourceServiceImpl.java"},
                {"admin/base/sys/impl/RoleServiceImpl.java.vm", "service/impl/RoleServiceImpl.java"},
                {"admin/base/sys/impl/RoleResourceServiceImpl.java.vm", "service/impl/RoleResourceServiceImpl.java"},
                {"admin/base/sys/impl/UserServiceImpl.java.vm", "service/impl/UserServiceImpl.java"},
                {"admin/base/sys/impl/UserRoleServiceImpl.java.vm", "service/impl/UserRoleServiceImpl.java"},
                {"admin/base/sys/impl/TokenServiceImpl.java.vm", "service/impl/TokenServiceImpl.java"},
                //mapper
                {"admin/base/sys/mapper/DictMapper.java.vm", "mapper/DictMapper.java"},
                {"admin/base/sys/mapper/ResourceMapper.java.vm", "mapper/ResourceMapper.java"},
                {"admin/base/sys/mapper/RoleMapper.java.vm", "mapper/RoleMapper.java"},
                {"admin/base/sys/mapper/RoleResourceMapper.java.vm", "mapper/RoleResourceMapper.java"},
                {"admin/base/sys/mapper/UserMapper.java.vm", "mapper/UserMapper.java"},
                {"admin/base/sys/mapper/UserRoleMapper.java.vm", "mapper/UserRoleMapper.java"},
                {"admin/base/sys/mapper/TokenMapper.java.vm", "mapper/TokenMapper.java"},
                //controller
                {"admin/base/sys/controller/DictController.java.vm", "controller/DictController.java"},
                {"admin/base/sys/controller/ResourceController.java.vm", "controller/ResourceController.java"},
                {"admin/base/sys/controller/RoleController.java.vm", "controller/RoleController.java"},
                {"admin/base/sys/controller/RoleResourceController.java.vm", "controller/RoleResourceController.java"},
                {"admin/base/sys/controller/UserController.java.vm", "controller/UserController.java"},
                {"admin/base/sys/controller/LoginController.java.vm", "controller/LoginController.java"},

        };
    }

    /**
     * 代码生成器
     *
     * @param table 桌子
     * @param ve    ve
     * @throws Exception 例外
     */
    private static void CodeGenerator(TableInfo table, VelocityEngine ve) throws Exception {
        table.setPackageName(PACKAGE_NAME);
        // Entity 放入 api 模块
        String packPath = PACKAGE_NAME.replace(".", "/");
        String entityPath = String.format("%s/entity/%s.java", packPath, table.getClassName());
        if (table.getPrefix() != null)
            entityPath = String.format("%s/%s/entity/%s.java", packPath, table.getPrefix(), table.getClassName());
        generateFile(ve, "Entity.vm", table, MODULE_API, entityPath);
        // vo
        String voPath = String.format("%s/vo/%sVo.java", packPath, table.getClassName());
        if (table.getPrefix() != null)
            voPath = String.format("%s/%s/vo/%sVo.java", packPath, table.getPrefix(), table.getClassName());
        generateFile(ve, "Vo.java.vm", table, MODULE_API, voPath);

        // Mapper 放入 api 模块
        String mapperPath = String.format("%s/mapper/%sMapper.java", packPath, table.getClassName());
        if (table.getPrefix() != null)
            mapperPath = String.format("%s/%s/mapper/%sMapper.java", packPath, table.getPrefix(), table.getClassName());
        generateFile(ve, "Mapper.vm", table, MODULE_API, mapperPath);

        // Service 放入 api 模块
        String servicePath = String.format("%s/service/%sService.java", packPath, table.getClassName());
        if (table.getPrefix() != null)
            servicePath = String.format("%s/%s/service/%sService.java", packPath, table.getPrefix(), table.getClassName());
        generateFile(ve, "Service.vm", table, MODULE_API, servicePath);

        // ServiceImpl 放入 biz 模块
        String serviceImplPath = String.format("%s/service/impl/%sServiceImpl.java", packPath, table.getClassName());
        if (table.getPrefix() != null)
            serviceImplPath = String.format("%s/%s/service/impl/%sServiceImpl.java", packPath, table.getPrefix(), table.getClassName());
        generateFile(ve, "ServiceImpl.vm", table, MODULE_BIZ, serviceImplPath);

        // Controller 放入 admin 模块
        String controllerPath = String.format("%s/controller/%sController.java", packPath, table.getClassName());
        if (table.getPrefix() != null)
            controllerPath = String.format("%s/%s/controller/%sController.java", packPath, table.getPrefix(), table.getClassName());
        generateFile(ve, "Controller.vm", table, MODULE_ADMIN, controllerPath);
    }


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
    }

    /**
     * 创建模块结构
     *
     * @param moduleName 模块名称
     */
    private static void createModuleStructure(String moduleName) {
        String modulePath = OUTPUT_DIR + PROJECT_ROOT + "/" + moduleName;
        new File(modulePath).mkdirs();
        new File(modulePath + "/src/main/java/" + PACKAGE_NAME.replace(".", "/")).mkdirs();
        new File(modulePath + "/src/main/resources").mkdirs();
    }


    /**
     * 生成全局配置文件（如根 pom.xml,common）
     *
     * @param ve ve
     * @throws Exception 例外
     */
    private static void generateGlobalFiles(VelocityEngine ve) throws Exception {
        TableInfo tableInfo = new TableInfo();
        tableInfo.setPackageName(PACKAGE_NAME);
        String projectName = SqlParser.convertToCamelCase(PROJECT_ROOT);
        tableInfo.setClassName(PROJECT_ROOT);
        tableInfo.setServiceName(projectName);

        // 生成根 pom.xml
        generateFile(ve, "admin/pom.vm", tableInfo, PROJECT_ROOT + "/pom.xml");
        // 生成各模块的 pom.xml
        generateModulePom(ve, MODULE_API);
        // 生成Api模块配置文件 api/application.yml,api/application-dev.yml,api/application-prod.yml
        VelocityContext ctx = new VelocityContext();
        String[][] templateMapping = new String[][]{
                //配置
                {"admin/api/application.yml.vm", "application.yml"},
                {"admin/api/application-dev.yml.vm", "application-dev.yml"},
                {"admin/api/application-prod.yml.vm", "application-prod.yml"},
                {"admin/api/application-test.yml.vm", "application-test.yml"},
                //i18n
                {"admin/api/i18n/api.properties.vm", "i18n/api.properties"},
                {"admin/api/i18n/api_zh_CN.properties.vm", "i18n/api_zh_CN.properties"},
                {"admin/api/i18n/api_en_US.properties.vm", "i18n/api_en_US.properties"},
        };
        generateMultipleConfigFiles(ve, MODULE_API, "src/main/resources", templateMapping, ctx);
        generateModulePom(ve, MODULE_BIZ);
        generateModulePom(ve, MODULE_COMMON);
        //将基础配置文件
        templateMapping = getBaseTemplateMapping();
        ctx.put("packageName", PACKAGE_NAME);
        generateMultipleConfigFiles(ve,
                MODULE_COMMON,
                "src/main/java/" + PACKAGE_NAME.replace(".", "/"),
                templateMapping,
                ctx);
        generateModulePom(ve, MODULE_ADMIN);
        generateModulePom(ve, MODULE_FRONT);

    }

    /**
     * 获取模板映射
     *
     * @return {@link String[][] }
     */
    private static String[][] getBaseTemplateMapping() {
        return new String[][]{
                {
                        "admin/common/config/AsyncConfig.java.vm", "config/AsyncConfig.java"
                },
                {
                        "admin/common/config/MyBatisPlusConfig.java.vm", "config/MyBatisPlusConfig.java"
                },
                {
                        "admin/common/config/MyLocaleResolver.java.vm", "config/MyLocaleResolver.java"
                },
                {
                        "admin/common/config/MyMetaObjectHandler.java.vm", "config/MyMetaObjectHandler.java"
                },
                {
                        "admin/common/config/WebConfig.java.vm", "config/WebConfig.java"
                },
                {
                        "admin/common/convert/Convert.java.vm", "convert/Convert.java"
                },
                //exception
                {
                        "admin/common/exception/GlobalException.java.vm", "exception/GlobalException.java"
                },
                {
                        "admin/common/exception/ServerException.java.vm", "exception/ServerException.java"
                },
                //i18
                {
                        "admin/common/i18n/I18nService.java.vm", "i18n/I18nService.java"
                },
                {
                        "admin/common/i18n/I18nServiceImpl.java.vm", "i18n/I18nServiceImpl.java"
                },
                {
                        "admin/common/i18n/I18nUtils.java.vm", "i18n/I18nUtils.java"
                },
                //interceptor
                {
                        "admin/common/interceptor/GlobalInterceptor.java.vm", "interceptor/GlobalInterceptor.java"
                },
                //local
                {
                        "admin/common/local/CurrentUser.java.vm", "local/CurrentUser.java"
                },
                //utils
                {
                        "admin/common/utils/AesUtils.java.vm", "utils/AesUtil.java"
                },
                {
                        "admin/common/utils/TokenUtils.java.vm", "utils/TokenUtils.java"
                },
                //validator
                {
                        "admin/common/validator/FieldRule.java.vm", "validator/FieldRule.java"
                },
                {
                        "admin/common/validator/GenericValidator.java.vm", "validator/GenericValidator.java"
                },
                {
                        "admin/common/validator/Type.java.vm", "validator/Type.java"
                },
                {
                        "admin/common/validator/ValidEntity.java.vm", "validator/ValidEntity.java"
                },
                //entity
                {
                        "admin/common/entity/BaseEntity.java.vm", "entity/BaseEntity.java"
                },
                {
                        "admin/common/entity/Option.java.vm", "entity/Option.java"
                },
                {
                        "admin/common/entity/Route.java.vm", "entity/Route.java"
                },
                {
                        "admin/common/entity/WebResponse.java.vm", "entity/WebResponse.java"
                },
                //token
                {
                        "admin/common/entity/Token.java.vm", "entity/Token.java"
                },
                //emums
                {
                        "admin/common/enums/State.java.vm", "enums/State.java"
                },
                {
                        "admin/common/enums/ResourceType.java.vm", "enums/ResourceType.java"
                },
                {
                        "admin/common/enums/EmailType.java.vm", "enums/EmailType.java"
                },
                //permission
                {
                        "admin/common/permission/Permission.java.vm", "permission/Permission.java"
                },
                {
                        "admin/common/permission/PermissionAop.java.vm", "permission/PermissionAop.java"
                }
        };
    }

    /**
     * 生成多个配置文件
     *
     * @param ve              模板引擎
     * @param moduleName      模块名称
     * @param targetSubDir    目标子目录
     * @param templateMapping 模板映射关系 [[模板路径, 目标文件路径]]
     * @throws Exception 异常
     */
    private static void generateMultipleConfigFiles(VelocityEngine ve, String moduleName, String targetSubDir, String[][] templateMapping, VelocityContext ctx) throws Exception {
        for (String[] mapping : templateMapping) {
            String sourceTemplate = mapping[0];
            String targetFile = mapping[1];
            generateConfigFileFromTemplate(ve, moduleName, sourceTemplate, targetSubDir, targetFile, ctx);
        }
    }

    /**
     * 使用 Velocity 模板引擎生成配置文件（支持变量替换）
     *
     * @param ve                 Velocity 引擎
     * @param moduleName         模块名（如 "api"、"biz"），null 表示项目根目录
     * @param sourceTemplatePath 模板路径（相对于 templates 的路径，如 "config/application-dev.yml.vm"）
     * @param targetSubDir       目标子目录（如 "src/main/resources"）
     * @param targetFileName     输出文件名（如 "application.yml"）
     * @param context            Velocity 上下文（用于变量替换）
     * @throws Exception 模板生成异常
     */
    private static void generateConfigFileFromTemplate(VelocityEngine ve,
                                                       String moduleName,
                                                       String sourceTemplatePath,
                                                       String targetSubDir,
                                                       String targetFileName,
                                                       VelocityContext context) {
        // 构建目标路径
        String basePath = OUTPUT_DIR + PROJECT_ROOT;
        if (moduleName != null && !moduleName.isEmpty()) {
            basePath += "/" + moduleName;
        }

        // ✅ 使用 File 对象构造路径（更安全，跨平台兼容性好）
        File targetDir = new File(basePath, targetSubDir); // C:\...\common\src\main\java
        File targetFile = new File(targetDir, targetFileName); // + com/example/demo/config/AsyncConfig.java

//        if (targetFile.exists()) {
//            System.out.println("⚠️ 文件已存在，跳过生成：" + targetFile.getAbsolutePath());
//            return;
//        }

        // ✅ 确保父目录存在（即 java 下的包路径）
        File parentDir = targetFile.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs(); // 会自动创建 com → example → demo → config 路径
        }

        // 加载模板
        Template template = ve.getTemplate(TEMPLATE_DIR + "/" + sourceTemplatePath, "UTF-8");

        // 写入输出文件
        try (Writer writer = new OutputStreamWriter(new FileOutputStream(targetFile), StandardCharsets.UTF_8)) {
            template.merge(context, writer);
        } catch (Exception e) {
            System.err.println("无法写入文件: " + targetFile);
            throw new RuntimeException("写入文件失败: " + targetFile, e);
        }

        System.out.println("📎 从模板生成配置文件完成：" + sourceTemplatePath + " → " + targetFile.getAbsolutePath());
    }

    /**
     * 获取相对于根目录的相对路径
     */
    private static String getRelativePath(File rootDir, File currentDir) {
        String rootPath = rootDir.getAbsolutePath();
        String currentPath = currentDir.getAbsolutePath();
        if (!currentPath.startsWith(rootPath)) {
            throw new IllegalArgumentException("currentDir 不在 rootDir 路径下");
        }
        return currentPath.substring(rootPath.length() + 1).replace("\\", "/");
    }

    /**
     * 生成模块 POM
     *
     * @param ve         ve
     * @param moduleName 模块名称
     * @throws Exception 例外
     */
    private static void generateModulePom(VelocityEngine ve, String moduleName) throws Exception {
        VelocityContext ctx = new VelocityContext();
        ctx.put("groupId", PACKAGE_NAME);
        ctx.put("projectName", PROJECT_ROOT);
        ctx.put("version", "1.0-SNAPSHOT");
        ctx.put("module", moduleName);
        ctx.put("java.version", "17");

        Template tpl = ve.getTemplate(TEMPLATE_DIR + "/admin/" + "module-pom.vm", "UTF-8");
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
        String templates = TEMPLATE_DIR + "/admin/" + tplName;
        Template tpl = ve.getTemplate(templates, "UTF-8");
        VelocityContext ctx = new VelocityContext();
        String packageName = table.getPackageName();
        String fullPackageName = (table.getPrefix() != null)
                ? packageName + "." + table.getPrefix()
                : packageName;
        ctx.put("packageName", fullPackageName);
        ctx.put("tableName", table.getTableName());
        ctx.put("className", table.getClassName());
        ctx.put("serviceName", table.getServiceName());
        ctx.put("classComment", table.getClassComment());
        ctx.put("fields", table.getFields());
        ctx.put("prefix", table.getPrefix() + "/");
        ctx.put("packageName2", packageName);

        String outputFilePath = OUTPUT_DIR + PROJECT_ROOT + "/" + module + "/src/main/java/" + outPath;
        File outFile = new File(outputFilePath);
//        if (outFile.exists()) {
//            System.out.println("⚠️ 文件已存在，跳过生成：" + outputFilePath);
//            return;
//        }
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
