<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title> </title>
	</head>
	<body>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/main/ais.css">
		<!-- <table style="padding: 0;border-spacing: 0;border-collapse: 0;width:97%;"> -->
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/system/userindex4per.jsp?p_issel=0')"/>
					 
					 <!-- =new String(request.getParameter("headstr").getBytes("ISO8859-1"),"utf-8")%> -->
				</td>
			</tr>
		</table>
	</body>
<!-- 其它页面也引用此页面 -->
</html>