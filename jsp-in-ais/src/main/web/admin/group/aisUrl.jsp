<%@page import="ais.framework.util.MyProperty"%>
<%@ page language="java"  pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%
	String ais_host=MyProperty.getProperties("ais.host");
	String ais_port=MyProperty.getProperties("ais.port");
	String ais_context=MyProperty.getProperties("ais.context");
	String ais_url="http://"+ais_host+":"+ais_port+"/"+ais_context;
	request.setAttribute("ais_url",ais_url);
 %>