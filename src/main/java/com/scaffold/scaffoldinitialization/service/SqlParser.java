package com.scaffold.scaffoldinitialization.service;

import com.scaffold.scaffoldinitialization.entity.TableInfo;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.Statements;
import net.sf.jsqlparser.statement.create.table.ColumnDefinition;
import net.sf.jsqlparser.statement.create.table.CreateTable;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SqlParser {
    private static final String[] NOT_APPEND_FIELDS = {
            "id", "createdAt", "updatedAt", "state", "deleted", "sortedNum"
    };

    /**
     * 解析 SQL
     *
     * @param filePath 文件路径
     * @return {@link ArrayList }<{@link TableInfo }>
     */
    public static ArrayList<TableInfo> parseSql(String filePath) {
        // 预设初始容量（假设平均每个文件有20张表）
        ArrayList<TableInfo> tableInfos = new ArrayList<>(20);
        String sql;
        try {
            sql = Files.readString(Paths.get(filePath));
            sql = sql.replaceAll("\\bUNIQUE\\b", ""); // 简单去除 UNIQUE 关键字
        } catch (IOException e) {
            // 使用日志框架替换 System.err
            System.err.println("无法读取SQL文件: " + filePath);
            throw new RuntimeException("读取SQL文件失败: " + filePath, e);
        }
        // 解析SQL
        parse(sql, tableInfos);
        return tableInfos;
    }

    /**
     * 解析
     *
     * @param sql        SQL
     * @param tableInfos 表格信息
     */
    private static void parse(String sql, ArrayList<TableInfo> tableInfos) {
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
                tableInfo.setServiceName(toLowerCamelCase(tableName, true));
                //获取表注释
                List<String> comment = createTable.getTableOptionsStrings();
                tableInfo.setClassComment(getTableComment(comment));
                //列转字段信息
                List<ColumnDefinition> columnDefinitions = createTable.getColumnDefinitions();
                tableInfo.setFields(mapColumnsToFieldInfos(columnDefinitions));
                tableInfos.add(tableInfo);
            }
        }
    }

    /**
     * 从 Stream 解析 SQL
     *
     * @param inputStream 输入流
     * @return {@link ArrayList }<{@link TableInfo }>
     */
    public static ArrayList<TableInfo> parseSqlFromStream(InputStream inputStream) {
        // 预设初始容量（假设平均每个文件有5张表）
        ArrayList<TableInfo> tableInfos = new ArrayList<>(20);
        StringBuilder sqlBuilder = new StringBuilder();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                sqlBuilder.append(line).append("\n");
            }
        } catch (IOException e) {
            System.err.println("无法读取输入流");
            throw new RuntimeException("读取输入流失败", e);
        }

        String sql = sqlBuilder.toString();
        sql = sql.replaceAll("\\bUNIQUE\\b", ""); // 简单去除 UNIQUE 关键字
        // 解析 SQL
        parse(sql, tableInfos);
        return tableInfos;
    }


    private static List<TableInfo.FieldInfo> mapColumnsToFieldInfos(List<ColumnDefinition> columnDefinitions) {
        List<TableInfo.FieldInfo> fieldInfos = new ArrayList<>(columnDefinitions.size());
        for (ColumnDefinition columnDefinition : columnDefinitions) {
            String lowerCamelCase = toLowerCamelCase(columnDefinition.getColumnName(), false);
            String type = convertToJavaType(columnDefinition.getColDataType().getDataType());

            List<String> columnSpecs = columnDefinition.getColumnSpecs();
            if (columnSpecs == null || columnSpecs.isEmpty() || Arrays.asList(NOT_APPEND_FIELDS).contains(lowerCamelCase)) {
                continue;
            }

            fieldInfos.add(new TableInfo.FieldInfo(
                    lowerCamelCase,
                    type,
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
     * 将javaType转换为ts类型
     *
     * @param javaType java类型
     * @return ts类型
     */
    public static String convertToTsType(String javaType) {
        return switch (javaType) {
            case "Long", "Integer", "Short", "Byte", "Double", "Float" -> "number";
            case "String" -> "string";
            case "Boolean" -> "boolean";
            default -> "any";
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
     * @param input  输入的下划线格式字符串
     * @param prefix 是否去前缀
     * @return lowerCamelCase 格式的字符串
     */
    public static String toLowerCamelCase(String input, Boolean prefix) {
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
            //如果part数量大于等2个，第一个不要
            if (parts.length >= 2 && i == 0 && prefix) {
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
