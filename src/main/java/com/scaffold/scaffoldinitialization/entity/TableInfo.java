package com.scaffold.scaffoldinitialization.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
public class TableInfo {
    private String packageName;
    private String prefix;
    private String tableName;
    private String className;
    private String serviceName;
    private String classComment;
    private List<FieldInfo> fields;

    @Data
    @AllArgsConstructor
    public static class FieldInfo {
        private String name;
        private String type;
        private String comment;
    }
}
