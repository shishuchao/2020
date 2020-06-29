<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<title>审计分工-总体布局</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
</head>
<body class="easyui-layout" fit="true" border="0" style="padding:0px;margin:0px;overflow:hidden;">
	<div region="west" split="true"  border="0" style="width:60%;padding:0px;margin:0px;overflow:hidden;">
		<iframe name="f_left"  frameborder="0" scrolling="no" marginheight="0" style='height:100%;width:100%'
		src="${contextPath}/operate/task/project/showTreeListBatchEdit.action?project_id=<%=request.getParameter("project_id")%>&gm=<%=request.getParameter("gm")%>"></iframe>
	</div>
	<div region="center" border="0" style="padding:0px;margin:0px;overflow:hidden;">
		<iframe name="childBasefrm"  frameborder="0" scrolling="no" marginheight="0" style='height:100%;width:100%'
		src="${contextPath}/operate/task/project/showContentEditGroupOrMember.action?project_id=<%=request.getParameter("project_id")%>&gm=<%=request.getParameter("gm")%>"></iframe>
	</div>
</body>
</html>


