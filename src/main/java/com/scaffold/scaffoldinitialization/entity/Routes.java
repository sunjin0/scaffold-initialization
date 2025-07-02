package com.scaffold.scaffoldinitialization.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Routes {
    /**
     * 名字
     */
    private String name;
    /**
     * 路径
     */
    private String path;
    /**
     * 元件
     */
    private String component;
    private List<Routes> routes;
}
