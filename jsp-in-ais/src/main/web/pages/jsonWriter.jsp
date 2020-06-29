<%@page import="ais.framework.util.StringUtil"%>
<%@page import="com.googlecode.jsonplugin.JSONUtil"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String encoding = request.getAttribute("jsonplugin_encoding")==null?"":(String)request.getAttribute("jsonplugin_encoding");
boolean isWrapWithComments = request.getAttribute("jsonplugin_isWrapWithComments")==null? false :((Boolean)request.getAttribute("jsonplugin_isWrapWithComments")).booleanValue();
String json = request.getAttribute("jsonplugin_json")==null?"":(String)request.getAttribute("jsonplugin_json");
boolean gzip = request.getAttribute("jsonplugin_gzip")==null?false:((Boolean)request.getAttribute("jsonplugin_gzip")).booleanValue();
boolean noCache = request.getAttribute("jsonplugin_noCache")==null?false:((Boolean)request.getAttribute("jsonplugin_noCache")).booleanValue();
int statusCode = request.getAttribute("jsonplugin_statusCode")==null?200:((Integer)request.getAttribute("jsonplugin_statusCode")).intValue();
int errorCode = request.getAttribute("jsonplugin_errorCode")==null?500:((Integer)request.getAttribute("jsonplugin_errorCode")).intValue();
boolean prefix = request.getAttribute("jsonplugin_prefix")==null?false:((Boolean)request.getAttribute("jsonplugin_prefix")).booleanValue();
String contentType = request.getAttribute("jsonplugin_contentType")==null?"":(String)request.getAttribute("jsonplugin_contentType");
JSONUtil.writeJSONToResponse(response, encoding,
		isWrapWithComments, json, false, gzip, noCache,
		statusCode, errorCode, prefix, contentType);
%>