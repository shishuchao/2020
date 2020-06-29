<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title></title>
<%
	String s=request.getParameter("headstr");
	if(s!=null&&s.length()!=0){
		request.setAttribute("headstr",s);
	}
 %>
</head>
<body>
	
	<link href="<%=request.getContextPath()%>/styles/main/ais.css"
			rel="stylesheet" type="text/css">
	<table style="padding: 0;border-spacing: 0;border-collapse: 0;width:96%;">
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				<s:if test="${headstr=='jcxx'}">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/basic/codename_index.jsp')"/>
				</s:if>
				<s:elseif test="${headstr=='zzjg'}">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/admin/orgindex.jsp')"/>
				</s:elseif>
				<s:elseif test="${headstr=='yhgl'}">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/admin/uuser_index.jsp')"/>
				</s:elseif>
				<s:elseif test="${headstr=='qzsz'}">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/system/userindex4per.jsp?p_issel=0')"/>
				</s:elseif>
				<s:elseif test="${headstr=='sysparam'}">
				<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/sysparam/sysParamAction!paramFrame.action')"/>
				</s:elseif>
			</td>
		</tr>
	</table>
</body>
<!-- 其它页面也引用此页面 -->
</html>
