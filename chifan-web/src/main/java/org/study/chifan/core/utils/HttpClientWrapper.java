package org.study.chifan.core.utils;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.Consts;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.FileEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.http.HttpMethod;


/**
 * @author Bruce
 *         Created on 12/24/12.
 */
public class HttpClientWrapper {
//    protected Logger log = LoggerFactory.getLogger(getClass());

    private String url;

    private String token;

    private String username;

    private String password;

    private String loginType;

    private Map<String, String> headers;

    private Map<String, String> params;

    private File data;

    public HttpClientWrapper(String url, String token) {
        this.url = url;
        this.token = token;
    }

    /**
     * @param method
     * @param route
     */
    public SyncResponse request(HttpMethod method, String route) {

        if (headers == null) {
            headers = new HashMap<String, String>();
        }

        headers.put("User-Agent", "Hydra Client");
        headers.put("Connection", "close");

        DefaultHttpClient client = new DefaultHttpClient();

        if (StringUtils.isNotBlank(username) && StringUtils.isNotBlank(password)) {
            client.getCredentialsProvider().setCredentials(new AuthScope(AuthScope.ANY),
                    new UsernamePasswordCredentials(username, password));

            if (StringUtils.isNotBlank(loginType)) {
                headers.put("Usersource", Base64.encodeBase64String(loginType.getBytes()));
            }
        } else {
            headers.put("x-hydra-token", token);
        }

        try {
            if (StringUtils.isNotBlank(route)) {
                url = getRequestURL(url, route);
            }

            HttpUriRequest request = getMethod(url, method, headers, params, data);
            HttpResponse response = client.execute(request);

            /*if (log.isDebugEnabled()) {
                log.debug("====================================Response Headers ================================");
                log.debug(response.getStatusLine().toString());

                Map<String, String> respHeader = headersToMap(response.getAllHeaders());
            }*/

            InputStream is = response.getEntity().getContent();

            return new SyncResponse(response.getStatusLine().getStatusCode(), is);
        } catch (Exception e) {
            e.printStackTrace();

            throw new RuntimeException(e);
        }

    }

    /**
     * get request method
     *
     * @param requestMethod
     * @param url
     * @return
     */
    private HttpRequestBase getMethod(String url, HttpMethod requestMethod, Map<String, String> headers,
                                      Map<String, String> params, File data) {

        if (requestMethod == HttpMethod.POST) {
            HttpPost httpPost = new HttpPost(url);
            setReqHeaders(httpPost, headers);

            if (params != null) {
                httpPost.setEntity(getParamEntity(params));
            }

            if (data != null) {
                httpPost.setEntity(getFileEntity(data));
            }

            return httpPost;
        } else if (requestMethod == HttpMethod.PUT) {
            HttpPut httpPut = new HttpPut(url);
            setReqHeaders(httpPut, headers);

            if (params != null) {
                httpPut.setEntity(getParamEntity(params));
            }

            if (data != null) {
                httpPut.setEntity(getFileEntity(data));
            }

            return httpPut;
        } else if (requestMethod == HttpMethod.DELETE) {
            if (params != null) {
                url = appendParams(url, mapToQueryString(params));
            }

            HttpDelete httpDelete = new HttpDelete(url);
            setReqHeaders(httpDelete, headers);

            return httpDelete;

        } else {
            if (params != null) {
                url = appendParams(url, mapToQueryString(params));
            }

            HttpGet httpGet = new HttpGet(url);
            setReqHeaders(httpGet, headers);

            return httpGet;
        }
    }

    private HttpEntity getFileEntity(File data) {
        return new FileEntity(data);
    }

    private void setReqHeaders(HttpRequestBase request, Map<String, String> headers) {
        // set headers
        if (headers != null && headers.keySet().size() > 0) {

            /* if (log.isDebugEnabled()) {
                log.debug("====Request Headers ====");
                log.debug(request.getRequestLine().toString());
            }*/

            Iterator<String> it = headers.keySet().iterator();
            while (it.hasNext()) {
                String key = it.next();
                String value = headers.get(key);

                if (StringUtils.isNotBlank(key)) {
                    request.setHeader(key, value);
                }
            }
        }
    }

    private static HttpEntity getParamEntity(Map<String, String> params) {
        // set parameter
        if (params != null && params.keySet().size() > 0) {
            /*if (LogUtil.isDebug()) {
                log.debug("====================================Request Body ================================");
            }*/

            Iterator<String> it = params.keySet().iterator();
            List<BasicNameValuePair> reqParams = new ArrayList<BasicNameValuePair>();
            while (it.hasNext()) {
                String key = it.next();
                String value = params.get(key);

                if (StringUtils.isNotBlank(key)) {
                    reqParams.add(new BasicNameValuePair(key, value));
                }
            }

            return new UrlEncodedFormEntity(reqParams, Consts.UTF_8);
        }

        return null;
    }

    private static Map<String, String> headersToMap(Header[] headers) {
        Map<String, String> map = new HashMap<String, String>();

        for (int i = 0; headers != null && i < headers.length; i++) {
            Header respHeader = headers[i];
            map.put(respHeader.getName(), respHeader.getValue());

        }

        return map;
    }

    private static String mapToQueryString(Map<String, String> params) {
        // set parameter
        if (params != null && params.keySet().size() > 0) {
            /*if (log.isDebugEnabled()) {
                log.debug("===========Request Body ===========");
            }*/

            Iterator<String> it = params.keySet().iterator();
            int total = params.keySet().size();
            int count = 0;
            StringBuilder builder = new StringBuilder();
            while (it.hasNext()) {
                String key = it.next();
                String value = params.get(key);

                if (StringUtils.isNotBlank(key)) {
                    builder.append(key).append("=").append(value);
                }

                if (count != total - 1) {
                    builder.append("&");
                }

                count++;
            }

            return builder.toString();
        }

        return "";
    }

    public void setCredential(String username, String password, String loginType) {
        this.username = username;
        this.password = password;
        this.loginType = loginType;
    }

    public void setData(File data) {
        this.data = data;
    }

    public void addHeader(String name, String value) {
        if (headers == null) {
            headers = new HashMap<String, String>();
        }

        headers.put(name, value);
    }

    public void addParam(String name, String value) {
        if (params == null) {
            params = new HashMap<String, String>();
        }

        params.put(name, value);
    }

    private static String appendParams(String url, String params) {
        if (StringUtils.isBlank(url) || StringUtils.isBlank(params)) {
            return url;
        }

        if (!url.endsWith("?")) {
            url = url + "?";
        }

        return url + params;
    }

    public static String getRequestURL(String url, String route) {
        if (StringUtils.isBlank(url) || StringUtils.isBlank(route)) {
            return url;
        }

        if (route.startsWith("/")) {
//            route = StringUtil.substring(route, 2, route.length());
            route = StringUtils.substring(route, 1, route.length());
        }

        if (!url.endsWith("/")) {
            url = url + "/";
        }

        return url + route;
    }
}
