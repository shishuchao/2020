<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title></title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
</head>
<body>
<center>
<display:table name="list" id="row" requestURI="" class="its" pagesize="5" size="100%">
	<display:column property="doubt_name" title="疑点名称" sortable="true" headerClass="center" ></display:column>
	<display:column property="founder" title="发现人" sortable="true" headerClass="center" ></display:column>
	<display:column property="founder_date" title="发现日期" sortable="true" headerClass="center"  class="center"></display:column>
	<display:column property="is_verify" title="是否核实" sortable="true" headerClass="center" class="center"></display:column>

	<display:column title="操作" headerClass="center" class="center">
		<a href="${contextPath}/mng/audobj/doubt/detail.action?auditDoubt.doubt_id=${row.doubt_id}&auditDoubt.object_id=${row.object_id}">详情</a>	
		<a href="${contextPath}/mng/audobj/doubt/edit.action?auditDoubt.doubt_id=${row.doubt_id}">修改</a>&nbsp&nbsp
		<s:if test="status!='view'">
			<s:if test="@row@is_verify=='是'">
				<a href="${contextPath}/mng/audobj/doubt/delete.action?auditDoubt.doubt_id=${row.doubt_id}&auditDoubt.object_id=${row.object_id}">删除</a>		
			</s:if>
		</s:if>		
	</display:column>		
</display:table>

<s:form action="add" namespace="/mng/audobj/doubt">
<s:hidden name="auditDoubt.object_id"/>
<br><br>
<s:submit value="增加"/>
</s:form>

</center>
</body>
</html>
