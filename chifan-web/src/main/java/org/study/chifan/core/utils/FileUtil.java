package org.study.chifan.core.utils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.FileNameMap;
import java.net.URLConnection;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.study.chifan.core.model.BaseConstants;

/**
 * @author Bruce
 *         Created on 13-5-20.
 */
public class FileUtil {
    private static Logger log = LoggerFactory.getLogger(FileUtil.class);

    private static final String DEFAULT_FILE_NAME="default";
    private static final String IMAGE_FILE_TYPE="png";

    public static void writeFile(InputStream inStream, String descPath) {
        BufferedOutputStream output = null;
        File storeFile = new File(descPath);
        try {
            output = new BufferedOutputStream(new FileOutputStream(storeFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        byte buff[] = new byte[4096];
        long size = 0l;
        int count = 0;
        try {
            while ((count = inStream.read(buff)) != -1) {
                output.write(buff, 0, count);
                output.flush();
                size = size + count;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (output != null) {
                try {
                    output.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (output != null) {
                try {
                    inStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }


    public static void downloadFile(String filePath, String defaultFilePath, String fileName, String fileType, HttpServletResponse response) {
        FileNameMap fileNameMap = URLConnection.getFileNameMap();
        if (StringUtils.isBlank(fileName)) {
            fileName = DEFAULT_FILE_NAME;
        }
        if (StringUtils.isBlank(fileType)) {
            fileType = IMAGE_FILE_TYPE;
        }
        String mimeType = fileNameMap.getContentTypeFor(fileName + "." + fileType);

        File fileToDownload = new File(filePath);
        if (!fileToDownload.exists()) {
            fileToDownload = new File(defaultFilePath);
            if (!fileToDownload.exists()) {
                log.error("file " + fileName + " not found.");
                return;
            }
        }
        response.setHeader(BaseConstants.CONTENT_DISPOSITION,"attachment;filename=\"" + fileName.replace(" ", "_") + "\"");
        response.setHeader(BaseConstants.APPLICATION, fileType);
        response.setContentType(mimeType);
        response.setContentLength((int) fileToDownload.length());
        InputStream inputStream = null;

        try {
            inputStream = new FileInputStream(fileToDownload);
            IOUtils.copy(inputStream, response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            IOUtils.closeQuietly(inputStream);
        }

    }


    public static void deleteUploadFile(String filePath, String fileName, String fileType) {

        if (StringUtils.isBlank(fileName)) {
            fileName = DEFAULT_FILE_NAME;
        }
        if (StringUtils.isBlank(fileType)) {
            fileType = IMAGE_FILE_TYPE;
        }


        File fileToDeleted = new File(filePath);
        if (fileToDeleted.exists()) {
        	fileToDeleted.delete();
        }




    }
}

