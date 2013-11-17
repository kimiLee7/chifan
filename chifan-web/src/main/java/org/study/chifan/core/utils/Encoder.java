package org.study.chifan.core.utils;

/**
 * @author Bruce
 *         Created on 12/31/12.
 */

import java.security.MessageDigest;

/**
 * blog www.micmiu.com
 *
 * @author Michael
 */
public class Encoder {

    private static final char[] HEX_DIGITS = {'0', '1', '2', '3', '4', '5',
            '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

    public static String encodeToString(String algorithm, String str) {
        final byte[] bytes = encodeToByte(algorithm, str);
        return getFormattedText(bytes);
    }

    public static byte[] encodeToByte(String algorithm, String str) {
        if (str == null) {
            return null;
        }
        try {
            MessageDigest messageDigest = MessageDigest.getInstance(algorithm);
            messageDigest.update(str.getBytes());
            return messageDigest.digest();
//            return getFormattedText(messageDigest.digest());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    /**
     * Takes the raw bytes from the digest and formats them correct.
     *
     * @param bytes the raw bytes from the digest.
     * @return the formatted bytes.
     */
    private static String getFormattedText(byte[] bytes) {
        int len = bytes.length;
        StringBuilder buf = new StringBuilder(len * 2);
        for (int j = 0; j < len; j++) {
            buf.append(HEX_DIGITS[(bytes[j] >> 4) & 0x0f]);
            buf.append(HEX_DIGITS[bytes[j] & 0x0f]);
        }
        return buf.toString();
    }

    public static void main(String[] args) {
        System.out.println("good SHA1 :" + Encoder.getFormattedText(encodeToByte("MD5", "good11")));
        System.out.println("good SHA1 :" + Encoder.getFormattedText(encodeToByte("SHA1", "good11")));
        System.out.println("good SHA1 :" + Encoder.byte2Hex(encodeToByte("SHA1", "good11")));
        System.out.println("good SHA1 :" + Encoder.byte2Hex2(encodeToByte("SHA1", "good11")));
        System.out.println("good SHA1 :" + Encoder.encodeHex(encodeToByte("SHA1", "good11")));
    }

    private static String byte2Hex(byte[] b) {
        String hs = "";
        String stmp = "";
        for (int n = 0; n < b.length; n++) {
            stmp = (Integer.toHexString(b[n] & 0xFF));
            if (stmp.length() == 1) {
                hs = hs + "0" + stmp;
            } else {
                hs = hs + stmp;
            }
        }
        return hs;
    }

    private static String byte2Hex2(byte[] bin) {
        StringBuffer buf = new StringBuffer();
        for (int i = 0; i < bin.length; ++i) {
            int x = bin[i] & 0xFF, h = x >>> 4, l = x & 0x0F;
            buf.append((char) (h + ((h < 10) ? '0' : 'a' - 10)));
            buf.append((char) (l + ((l < 10) ? '0' : 'a' - 10)));
        }
        return buf.toString();
    }

    private static final String encodeHex(byte bytes[]) {
        StringBuffer buf = new StringBuffer(bytes.length * 2);
        for (int i = 0; i < bytes.length; i++) {
            if ((bytes[i] & 0xff) < 16) {
                buf.append("0");
            }
            buf.append(Long.toString(bytes[i] & 0xff, 16));
        }

        return buf.toString();
    }
}
