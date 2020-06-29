<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	//System.out.println( request.getParameter("templateId"));
%>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="<%=request.getContextPath()%>/styles/main/ais.css"
			rel="stylesheet" type="text/css">
</head>
 
 
	
<frameset rows="0,*" cols="*" frameborder="1" border="1" framespacing="1">
  <frame src="showContentTopSelect.action?project_id=<%=request.getParameter("project_id")%>" name="topFrame" scrolling="NO" >
  <frameset  id="multi" cols="200, *" frameborder="1" border="6" framespacing="5" bordercolor="#A1C7F9">
    <frame name="f_left" src="showTreeListViewSelect.action?project_id=<%=request.getParameter("project_id")%>" scrolling="yes" frameborder="1" />
    <frame name="main" src="showContentViewSelect.action?project_id=<%=request.getParameter("project_id")%>" frameborder="1" />
</frameset>
</frameset>	
</html>