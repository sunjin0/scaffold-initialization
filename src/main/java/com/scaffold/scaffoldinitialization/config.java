package com.scaffold.scaffoldinitialization;

import org.apache.velocity.app.VelocityEngine;

import java.util.Properties;

public class config {
    /**
     * 初始化 Velocity 引擎
     */
    public static VelocityEngine getVelocityEngine() {
        Properties props = new Properties();
        props.setProperty("resource.loader", "class");
        props.setProperty("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        props.setProperty("input.encoding", "UTF-8");
        props.setProperty("output.encoding", "UTF-8");
        VelocityEngine ve = new VelocityEngine(props);
        ve.init();
        return ve;
    }
}
