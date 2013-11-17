/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on Jun 5, 2012.
 */
package org.study.chifan.core.utils;

import org.apache.commons.lang3.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * <p>
 * </p>
 * <p>
 * Created: Jul 7, 2011 9:41:42 AM </br> Updated: Jul 7, 2011 9:41:42 AM
 * </p>
 *
 * @author Robin Ye
 * @version Release 1.0
 */
public class DateUtil {
    /**
     * data pattern yyyyMMdd
     */
    public static final String FULL_DATE_PATTERN = "yyyyMMdd";

    /**
     * part date pattern yyMMdd
     */
    public static final String PART_DATE_PATTERN = "yyMMdd";

    /**
     * data pattern for time stamp
     */
    public static final String TIME_STAMP_PATTERN = "yyyyMMddHHmmssSSS";

    /**
     * date time pattern
     */
    public static final String DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss,SSS";

    /**
     * get current date and time
     *
     * @return current date and time
     */
    public static Date getDate() {
        Calendar calendar = Calendar.getInstance();
        return calendar.getTime();
    }


    /**
     * get current date string
     *
     * @return current date string
     */
    public static String getDateString() {
        Date date = getDate();
        return getDateString(date);
    }

    /**
     * get current date time string
     *
     * @return current date time string
     */
    public static String getDateTimeString() {
        Date date = getDate();
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATETIME_PATTERN);
        return dateFormat.format(date);
    }

    /**
     * compare begin date to the current date
     *
     * @param beginDate begin date
     * @return milliseconds between begin date time and end date time
     */
    public static long compareDate(String beginDate) {
        if (StringUtils.isBlank(beginDate)) {
            return 0;
        }

        String date = beginDate.replace("T", " ");
        Date bDate = parseDate(date, DATETIME_PATTERN);
        return getDate().getTime() - bDate.getTime();
    }

    /**
     * get current date string
     *
     * @param date current date
     * @return current date string
     */
    public static String getDateString(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATETIME_PATTERN);
        return dateFormat.format(date).replace(' ', 'T');
    }

    /**
     * parse the given string value to date type
     *
     * @param value   given string value
     * @param pattern date time format pattern
     * @return produced date
     */
    public static Date parseDate(String value, String pattern) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        try {
            return dateFormat.parse(value);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * format a given date time to string value
     *
     * @param date    given date time
     * @param pattern date time format pattern
     * @return produced string value
     */
    public static String formatDate(Date date, String pattern) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        return dateFormat.format(date);
    }

    /**
     * convert a given string value to another string value with specific data format pattern
     *
     * @param value         given string value
     * @param sourcePattern source date time format pattern
     * @param targetPattern target date time format pattern
     * @return produced string value with target date format pattern
     */
    public static String convert(String value, String sourcePattern, String targetPattern) {
        Date date;
        if (StringUtils.isNotBlank(value))
            date = parseDate(value, sourcePattern);
        else
            date = new Date();
        return formatDate(date, targetPattern);
    }

    /**
     * verify if the given string value is the correct date format based on designated date format pattern
     *
     * @param value   given string value
     * @param pattern designated date format pattern
     * @return true if the given string value consists with designated date format, false otherwise
     */
    public static boolean isValid(String value, String pattern) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        try {
            dateFormat.parse(value);
        } catch (ParseException e) {
            return false;
        }

        return true;
    }

    /**
     * verify if the given string value does not consists with the designated date format pattern.
     *
     * @param value   given string value
     * @param pattern designated date format pattern
     * @return true if given string value consists with designated date format, false otherwise
     */
    public static boolean isInvalid(String value, String pattern) {
        return !isValid(value, pattern);
    }

    public static final String getTimestamp() {
        return formatDate(getDate(), TIME_STAMP_PATTERN);
    }
}
