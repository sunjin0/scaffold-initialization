package com.scaffold.scaffoldinitialization.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;

public class FileCopyUtil {

    /**
     * 复制目录内容到目标目录（递归复制，覆盖已有文件）
     *
     * @param sourceDir 源目录路径
     * @param targetDir 目标目录路径
     * @throws IOException
     */
    public static void copyDirectory(File sourceDir, File targetDir) throws IOException {
        if (!sourceDir.exists()) {
            throw new IllegalArgumentException("源目录不存在: " + sourceDir.getAbsolutePath());
        }

        if (!targetDir.exists() && !targetDir.mkdirs()) {
            throw new IOException("无法创建目标目录: " + targetDir.getAbsolutePath());
        }

        File[] files = sourceDir.listFiles();
        if (files != null) {
            for (File file : files) {
                File destFile = new File(targetDir, file.getName());

                if (file.isDirectory()) {
                    copyDirectory(file, destFile); // 递归复制子目录
                } else {
                    copyFile(file, destFile); // 复制文件
                }
            }
        }
    }

    /**
     * 复制单个文件，如果目标文件已存在则覆盖
     *
     * @param sourceFile 源文件
     * @param destFile   目标文件
     * @throws IOException
     */
    private static void copyFile(File sourceFile, File destFile) throws IOException {
        try (FileChannel sourceChannel = new FileInputStream(sourceFile).getChannel();
             FileChannel destChannel = new FileOutputStream(destFile).getChannel()) {
            destChannel.transferFrom(sourceChannel, 0, sourceChannel.size());
        }
    }
}
