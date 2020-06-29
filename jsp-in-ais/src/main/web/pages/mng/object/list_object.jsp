<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title></title>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
	<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
</head>
<body>
<center>
<h1>对象列表</h1>
<s:form action="list" method="get">
<s:textfield label="城市" name="s_name"/>
<s:textfield label="地址" name="s_address"/>
<s:submit value="查询"/>
 </s:form>
		<display:table name="objectList" id="row" requestURI="${contextPath}/mng/object/list.action" class="its" pagesize="5" size="100%">
			
			<display:column property="id" title="级别" sortable="true"></display:column>
			<display:column property="objectName" title="级别" sortable="true"></display:column>
			<display:column property="objectAddress" title="岗位" sortable="true"></display:column>
			<display:column title="操作">
				<a href="<s:url action="edit"><s:param name="theObject.id" value="${row.id}"/></s:url>">修改</a>&nbsp&nbsp
				<a href="<s:url action="delete"><s:param name="theObject.id" value="${row.id}"/></s:url>">删除</a>
			</display:column>			
		</display:table>
<input type="button" name="add" value="增加" onclick="javascript:window.location='<s:url action="edit"><s:param name="theObject.id" value="0"/></s:url>'">
</center>
</body>
</html>
