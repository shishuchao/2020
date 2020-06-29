<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title></title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
	</head>
	<table>
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/system/authRoleAction!allRolesIndex.action')"/>
			</td>
		</tr>
	</table>
</html>