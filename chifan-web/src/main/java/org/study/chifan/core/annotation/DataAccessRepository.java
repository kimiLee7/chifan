/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12/6/12.
 */
package org.study.chifan.core.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface DataAccessRepository {

}
