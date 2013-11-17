package org.study.chifan.core.utils;

import java.text.NumberFormat;

/**
 * @author Bruce
 *         Created on 13-4-11.
 */
public class PercentUtil {
    public static String calculatePercent(double divisor, double dividend) {
        NumberFormat numberFormat = NumberFormat.getPercentInstance();
        if (dividend == divisor) {
            numberFormat.setMinimumFractionDigits(0);
            return numberFormat.format(1);
        }
        if (dividend == 0 || divisor == 0) {
            numberFormat.setMinimumFractionDigits(0);
            return numberFormat.format(0);
        }
        numberFormat.setMinimumFractionDigits(2);
        final double result = divisor / dividend;
        return numberFormat.format(result);
    }
}
