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
 
<frameset rows="40,*" cols="*" frameborder="1" border="1" framespacing="1">
  <frame src="showContentTop.action?project_id=<%=request.getParameter("project_id")%>" name="topFrame" scrolling="NO" >
  <frameset id="sidebar_content" cols="400, *" frameborder="1" border="6" framespacing="5" bordercolor="#A1C7F9">
    <frame name="f_left" id="f_left" src="showTreeList.action?project_id=<%=request.getParameter("project_id")%>" scrolling="no" frameborder="1" />
    <frame name="childBasefrm" src="showContent.action?project_id=<%=request.getParameter("project_id")%>" frameborder="1" />
</frameset>
</frameset>
	
</html>