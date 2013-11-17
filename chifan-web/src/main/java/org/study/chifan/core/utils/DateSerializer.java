
/*
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on Mar 8, 2013 2:46:28 PM
 */
package org.study.chifan.core.utils;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

/**
 * @author <a href="mailto:huangli@conversant.com.cn">huangli</a>
 *
 *
 *
 */
public class DateSerializer extends JsonSerializer<Date> {

	@Override
	public void serialize(Date value, JsonGenerator jgen,
			SerializerProvider provider) throws IOException,
			JsonProcessingException {
		 DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    jgen.writeString(formatter.format(value));

	}


}

