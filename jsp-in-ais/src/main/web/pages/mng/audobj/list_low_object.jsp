<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title></title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<script>
<s:if test="refresh==1">
 	window.parent.parent.leftTree.location.reload();
</s:if>
</script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
</head>
<body>
<center>
			<display:table name="list" id="row" requestURI="" class="its" pagesize="5" size="100%">
			<display:column property="name" title="对象名称" sortable="true" headerClass="center"></display:column>
			<display:column property="createDate" title="成立时间" sortable="true" headerClass="center" class="center"></display:column>
			<display:column property="artificialPersion" title="法人代表" sortable="true" headerClass="center"></display:column>
			<display:column property="director" title="负责人" sortable="true" headerClass="center"></display:column>
			<display:column property="parentName" title="主管单位" sortable="true" headerClass="center"></display:column>
			<s:if test="status=='edit'">
			<display:column title="操作" headerClass="center" class="center">
				<a target="childBasefrm" href="${contextPath}/mng/audobj/object/edit.action?auditingObject.id=${row.id}">修改</a>&nbsp&nbsp
				<a href="<s:url action="delete"><s:param name="auditingObject.id" value="${row.id}"/><s:param name="auditingObject.parentId" value="${auditingObject.parentId}"/></s:url>">删除</a>
			</display:column>
			</s:if>			
			</display:table>
</center>
</body>
</html>
