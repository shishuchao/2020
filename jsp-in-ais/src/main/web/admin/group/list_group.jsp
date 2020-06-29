
<jsp:directive.page import="ais.framework.acegi.SecurityContextUtil"/><%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title></title>
	<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css">
</head>
<body>
<display:table  name="list"  id="row" class="its" pagesize="10" requestURI="virtualGroupAction!list.action"  excludedParams="*">
		<display:column property="name" title="群组名称" sortable="true" headerClass="center"></display:column>
		<display:column property="vgdNames" title="人员" sortable="true" headerClass="center"></display:column>
		<display:column style="width:10%;">
			<a href="<%=request.getContextPath()%>/admin/virtualGroupAction!edit.action?group.id=${row.id}">修改</a>
			<a href="<%=request.getContextPath()%>/admin/virtualGroupAction!delete.action?group.id=${row.id}">删除</a>
		</display:column>
</display:table>
<table style="width:97%;border:0">
	<tr>
		<td>
			<span style="float:right;">
				<input type="button" name="add" value="增加" onclick="javascript:window.location='<%=request.getContextPath()%>/admin/virtualGroupAction!edit.action?group.id='">
			</span>
		</td>
	</tr>
</table>
</body>
</html>
<%--
<display:column property="typeName" title="类别" sortable="true"></display:column>
		<display:column property="company" title="公司" sortable="true"></display:column>
--%>