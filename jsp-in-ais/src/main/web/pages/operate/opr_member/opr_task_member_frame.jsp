<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<title>审计分工</title>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<meta http-equiv="X-UA-Compatible" content="IE=5">
<link href="<%=request.getContextPath()%>/styles/main/ais.css"
			rel="stylesheet" type="text/css">
			
 
 <frameset rows="*,0" cols="*" frameborder="1" border="1" framespacing="1" bordercolor="#A1C7F9">
 
  <frameset id="sidebar_content" cols="400, *" frameborder="1" border="1" framespacing="1" bordercolor="#A1C7F9">
    <frame name="f_left" src="showTreeListEdit.action?project_id=<%=request.getParameter("project_id")%>" scrolling="yes" frameborder="1" />
    <frame name="childBasefrm" src="showContentEdit.action?project_id=<%=request.getParameter("project_id")%>" frameborder="1" />
 </frameset>
</frameset>
	
</html>