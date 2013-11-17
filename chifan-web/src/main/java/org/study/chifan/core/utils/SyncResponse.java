package org.study.chifan.core.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author Bruce
 *         Created on 12/25/12.
 */
public class SyncResponse {
    private int statusCode;

    private InputStream is;

    public SyncResponse(int statusCode, InputStream is) {
        this.statusCode = statusCode;
        this.is = is;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public String getResponseBody() {
        return streamToString(is);
    }

    public InputStream getResponseStream() {
        return is;
    }

    public static String streamToString(InputStream is) {
        try {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int count = 0;
            while ((count = is.read(buffer)) != -1) {
                bos.write(buffer, 0, count);
            }

            return new String(bos.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
