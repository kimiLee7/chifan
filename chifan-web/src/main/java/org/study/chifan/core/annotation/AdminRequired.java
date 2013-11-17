/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 13-5-8.
 */
package org.study.chifan.core.annotation;

import java.lang.annotation.*;

/**
 * TODO
 *
 * @author allen.zhang
 */

@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AdminRequired {
}
