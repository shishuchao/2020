<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>角色列表</title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body>
	<center>
		<s:form action="xxxx" namespace="/system" method="post"
			name="authForm">
			<display:table name="list" id="row" class="its" pagesize="10"
				size="listSize" requestURI="/system/authAuthorityAction!authAllRoleSet.action?p_floginname=${p_floginname}"
				 defaultorder="descending">
				<display:column title="角色名称" property="frolename" sortable="true" headerClass="center" class="center"></display:column>
				<display:column title="公司名称" property="fcompanyname" sortable="true" headerClass="center" class="center"></display:column>
			</display:table>
			
		</s:form>
	</center>
	</body>
</html>