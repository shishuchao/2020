<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script language="javascript">
	function back(){
	   window.top.location.href="/ais/operate/template/listMain.action";
	}
	
	function test(){
	  window.open('${contextPath}/pages/operate/task/excel_redirect.jsp?pro_id=62AC552B-1366-BBB4-8198-A4DF4F584884','export','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	</script>
</head>
<body>
                <s:button value="返回" onclick="back();" />
                
<body>
	
</html>