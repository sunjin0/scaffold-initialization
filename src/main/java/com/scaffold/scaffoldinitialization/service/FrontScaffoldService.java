package com.scaffold.scaffoldinitialization.service;

import com.scaffold.scaffoldinitialization.entity.Routes;
import com.scaffold.scaffoldinitialization.entity.TableInfo;
import com.scaffold.scaffoldinitialization.utils.FileCopyUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.scaffold.scaffoldinitialization.config.getVelocityEngine;

/**
 * 前端脚手架服务
 *
 * @author sun
 * @since 2025/07/01
 */
public class FrontScaffoldService {
    // 模板目录
    private static final String TEMPLATE_DIR = "templates/front";
    // 项目根目录
    private static final String PROJECT_ROOT = "hy-ui";
    // 输出目录
    private static final String OUTPUT_DIR = "D:\\project\\";
    // SQL文件路径
    private final static String SQL_PATH = "huayou_3.9.sql";

    public static void main(String[] args) throws Exception {
        ArrayList<TableInfo> tableInfos = SqlParser.parseSql(SQL_PATH);
        generateFrontScaffold(tableInfos);
    }

    /**
     * 生成前脚手架
     *
     * @param tableInfos 表格信息
     * @throws Exception 例外
     */
    public static void generateFrontScaffold(ArrayList<TableInfo> tableInfos) throws Exception {
        VelocityEngine ve = getVelocityEngine();
        for (TableInfo table : tableInfos) {
            //将基础文件复制到目标目录，覆盖已存在的文件，比如template/front/base->PROJECT_ROOT目录下
            FileCopyUtil.copyDirectory(new File("D:\\porject\\scaffold-initialization\\src\\main\\resources\\templates\\front\\base"), new File(OUTPUT_DIR + "/" + PROJECT_ROOT));
            //生成页面文件，表单文件
            generateForm(table, ve);
        }
        //路由生成
        generateRouter(tableInfos, ve);
        System.out.println("✅ 项目代码生成完成！");

    }

    /**
     * 生成路由器
     *
     * @param tables 表
     * @param ve     ve
     * @throws Exception 例外
     */
    private static void generateRouter(ArrayList<TableInfo> tables, VelocityEngine ve) throws Exception {
        String templates = TEMPLATE_DIR + "/routes.ts.vm";
        Template tpl = ve.getTemplate(templates, "UTF-8");
        VelocityContext ctx = new VelocityContext();
        //根据前缀生成路由文件
        //1. 获取前缀:子类的map
        Map<String, List<TableInfo>> map = tables.stream()
                .filter(table -> table.getPrefix() != null).
                collect(Collectors
                        .groupingBy(TableInfo::getPrefix));
        //2. 根据前缀生成路由文件,字段要，path，name，component，routes,父子路由
        ArrayList<Routes> routesList = new ArrayList<>();
        for (Map.Entry<String, List<TableInfo>> entry : map.entrySet()) {
            String prefix = entry.getKey();
            List<TableInfo> table = entry.getValue();
            Routes routes = new Routes();
            String path = "/" + prefix;
            routes.setPath(path);
            routes.setName(prefix);
            routes.setComponent("Layout");
            routes.setRoutes(table.stream().map(tableInfo -> {
                Routes routes2 = new Routes();
                routes2.setPath("./" + prefix + "/" + StringUtils.uncapitalize(tableInfo.getClassName()));
                routes2.setName(tableInfo.getClassName());
                routes2.setComponent(prefix + "/" + tableInfo.getClassName());
                return routes2;
            }).collect(Collectors.toList()));
            routesList.add(routes);
        }
        ctx.put("routes", routesList);
        String outputFilePath = OUTPUT_DIR + PROJECT_ROOT + "/config/routes.ts";
        File outFile = new File(outputFilePath);
        outFile.getParentFile().mkdirs();
        try (Writer writer = new OutputStreamWriter(new FileOutputStream(outFile), StandardCharsets.UTF_8)) {
            tpl.merge(ctx, writer);
        }
        System.out.println("📄 生成文件：" + outputFilePath);
    }

    /**
     * 生成表单
     *
     * @param table 桌子
     * @param ve    ve
     * @throws Exception 例外
     */
    private static void generateForm(TableInfo table, VelocityEngine ve) throws Exception {
        String path = String.format("%s/index.tsx", table.getServiceName());
        if (table.getPrefix() != null)
            path = String.format("%s/%s/index.tsx", table.getPrefix(), table.getServiceName());
        generateFile(ve, "index.vm", table, path);
        path = path.replace("index.tsx", String.format("%sForm.tsx", table.getClassName()));
        generateFile(ve, "Form.tsx.vm", table, path);
    }

    /**
     * 使用模板生成文件到指定模块中
     */
    private static void generateFile(VelocityEngine ve, String tplName, TableInfo table, String outPath) throws Exception {
        String templates = TEMPLATE_DIR + "/" + tplName;
        Template tpl = ve.getTemplate(templates, "UTF-8");
        VelocityContext ctx = new VelocityContext();
        ctx.put("className", table.getClassName());
        ctx.put("serviceName", table.getServiceName());
        ctx.put("classComment", table.getClassComment());
        ctx.put("fields", table.getFields());
        ctx.put("since", System.currentTimeMillis());
        if (!tplName.equals("Form.tsx.vm")) {
            ctx.put("packName", table.getPrefix() + "/" + table.getServiceName());
        }
        String outputFilePath = OUTPUT_DIR + PROJECT_ROOT + "/src/pages/" + outPath;
        File outFile = new File(outputFilePath);
        outFile.getParentFile().mkdirs();

        try (Writer writer = new OutputStreamWriter(new FileOutputStream(outFile), StandardCharsets.UTF_8)) {
            tpl.merge(ctx, writer);
        }
        System.out.println("📄 生成文件：" + outputFilePath);
    }


}
