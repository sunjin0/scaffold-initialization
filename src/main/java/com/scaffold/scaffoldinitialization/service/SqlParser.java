package com.scaffold.scaffoldinitialization.service;

import com.scaffold.scaffoldinitialization.entity.TableInfo;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statements;
import net.sf.jsqlparser.statement.create.table.CreateTable;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.create.table.ColumnDefinition;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class SqlParser {

    public static ArrayList<TableInfo> parseSql(String filePath) {
        // 预设初始容量（假设平均每个文件有5张表）
        ArrayList<TableInfo> tableInfos = new ArrayList<>(10);
        String sql;
        try {
            sql = Files.readString(Paths.get(filePath));
            sql = sql.replaceAll("\\bUNIQUE\\b", ""); // 简单去除 UNIQUE 关键字
        } catch (IOException e) {
            // 使用日志框架替换 System.err
            System.err.println("无法读取SQL文件: " + filePath);
            throw new RuntimeException("读取SQL文件失败: " + filePath, e);
        }

        Statements statements;
        try {
            statements = CCJSqlParserUtil.parseStatements(sql);
        } catch (Exception e) {
            System.err.println("无法解析SQL");
            throw new RuntimeException("解析SQL失败", e);
        }

        for (Statement statement : statements) {
            if (statement instanceof CreateTable createTable) {
                TableInfo tableInfo = new TableInfo();
                Table table = createTable.getTable();
                String tableName = table.getName();

                tableInfo.setTableName(getString(tableName));
                String[] names = tableName.split("_");
                if (names.length >= 2)
                    tableInfo.setPrefix(getString(names[0]));
                // 表名转类名
                tableInfo.setClassName(convertToCamelCase(tableName));
                //设置服务名
                tableInfo.setServiceName(toLowerCamelCase(tableName));
                //获取表注释
                List<String> comment = createTable.getTableOptionsStrings();
                tableInfo.setClassComment(getTableComment(comment));
                tableInfo.setFields(mapColumnsToFieldInfos(createTable.getColumnDefinitions()));
                tableInfos.add(tableInfo);
            }
        }
        return tableInfos;
    }

    private static List<TableInfo.FieldInfo> mapColumnsToFieldInfos(List<ColumnDefinition> columnDefinitions) {
        List<TableInfo.FieldInfo> fieldInfos = new ArrayList<>(columnDefinitions.size());
        for (ColumnDefinition columnDefinition : columnDefinitions) {
            List<String> columnSpecs = columnDefinition.getColumnSpecs();
            fieldInfos.add(new TableInfo.FieldInfo(
                    toLowerCamelCase(columnDefinition.getColumnName()),
                    convertToJavaType(columnDefinition.getColDataType().getDataType()),
                    getString(columnSpecs.get(columnSpecs.size() - 1))
            ));
        }
        return fieldInfos;
    }

    /**
     * 从sql数组获取注释
     * 比如 [common,=,名称]
     *
     * @param sql SQL
     * @return String
     */
    private static String getTableComment(List<String> sql) {
        for (int i = 0; i < sql.size(); i++) {
            String key = sql.get(i);
            if ("COMMENT".equals(key)) {
                return getString(sql.get(i + 2));
            }
        }
        return "";
    }

    /**
     * mysql类型转换为java类型
     *
     * @param type mysql字段类型
     * @return java类型
     */
    private static String convertToJavaType(String type) {
        if (type == null || type.isBlank()) {
            return "Object";
        }

        return switch (type.toLowerCase()) {
            case "int", "tinyint", "smallint", "mediumint", "bigint", "date", "datetime", "timestamp" -> "Long";
            case "float", "double", "decimal" -> "Double";
            case "char", "varchar", "text" -> "String";
            case "boolean", "bit", "tiny" -> "Boolean";
            default -> "Object";
        };
    }


    /**
     * 将下划线分隔的名称转换为驼峰命名格式，首字母大写
     * 例如: sys_user_role -> UserRole
     *
     * @param input 输入的下划线格式字符串
     * @return 驼峰命名格式的字符串
     */
    public static String convertToCamelCase(String input) {
        if (input == null || input.isEmpty()) {
            return input;
        }
        StringBuilder result = new StringBuilder();
        String[] parts;
        if (input.contains("_")) {
            parts = input.split("_");
        } else if (input.contains("-")) {
            parts = input.split("-");
        } else {
            return getString(input);
        }
        if (parts.length == 0) {
            return input;
        }
        for (int i = 0; i < parts.length; i++) {
            String part = parts[i];
            //如果part数量大于等3个，第一个不要
            if (parts.length >= 2 && i == 0) {
                continue;
            }
            if (!part.isEmpty()) {
                result.append(Character.toUpperCase(part.charAt(0)));
                result.append(part.substring(1).toLowerCase());
            }
        }
        return getString(result.toString());
    }

    /**
     * 将下划线分隔的名称转换为 lowerCamelCase 格式
     * 例如: sys_user_role -> userRole
     *
     * @param input 输入的下划线格式字符串
     * @return lowerCamelCase 格式的字符串
     */
    public static String toLowerCamelCase(String input) {
        if (input == null || input.isEmpty()) {
            return input;
        }
        if (!input.contains("_")) {
            return getString(input);
        }
        StringBuilder result = new StringBuilder();
        String[] parts = input.split("_");
        boolean first = true;
        for (int i = 0; i < parts.length; i++) {
            String part = parts[i];
            if (part.isEmpty()) {
                continue;
            }
            //如果part数量大于等3个，第一个不要
            if (parts.length >= 2 && i == 0) {
                continue;
            }
            if (first) {
                result.append(part.toLowerCase());
                first = false;
            } else {
                result.append(Character.toUpperCase(part.charAt(0)));
                result.append(part.substring(1).toLowerCase());
            }
        }
        return getString(result.toString());
    }


    private static String getString(String string) {
        if (string == null || string.isEmpty())
            return string;
        // 去除单引号
        return string.replace("`", "").replace("'", "").replace("'", "");
    }


}
