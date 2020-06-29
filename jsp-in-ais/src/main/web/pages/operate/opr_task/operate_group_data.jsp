<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@page import="net.sf.json.JSONObject"%> 
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="ais.operate.task.service.ITaskService"%>
<%@ page import="java.util.List"%>
<%
 	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
	ITaskService service = (ITaskService) ctx
					.getBean("operate-taskService");
    String  pro_id = request.getParameter("project_id");
	JSONObject json = service.getGroupSelectJSONList(pro_id,"");
	
	//out.print("[{user:'Jack Slocum',iconCls:'task',task:'Abstract rendering in TreeNodeUI',uiProvider:'col',duration:'15 min'}]");
	System.out.println(json.get("root"));
	out.print(json.get("root"));
	 
	
	
 
%>