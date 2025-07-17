package com.scaffold.scaffoldinitialization.service;

import com.scaffold.scaffoldinitialization.entity.TableInfo;

import java.util.ArrayList;

public class CodeGenerator {

    // SQL文件路径
    public static final String SQL_PATH = "demo.sql";
    public static final String OUTPUT_DIR = "D:\\project\\";

    public static void main(String[] args) throws Exception {
        ArrayList<TableInfo> tableInfos = SqlParser.parseSql(SQL_PATH);
        AdminScaffoldService.generateAdminScaffold("hy",
                "com.hy",
                tableInfos,
                OUTPUT_DIR,
                false);
        FrontScaffoldService.generateFrontScaffold("hy-ui",
                tableInfos,
                OUTPUT_DIR,
                true);
        System.out.println("✅ 项目代码生成完成！");
    }


}
