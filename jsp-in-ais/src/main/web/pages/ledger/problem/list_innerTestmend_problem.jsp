<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>汇总控制缺陷问题列表</title>
	   <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<s:text id="title" name="'汇总控制缺陷问题表'"></s:text>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body>
		<center>
			<table class="its">
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<display:table name="list" id="row"
				requestURI="${contextPath}/proledger/problem/inTestmendLedgerList.action"
				class="its" pagesize="15">
                <display:column property="sort_big_name" title="管理类别" sortable="true" class="center" headerClass="center"></display:column>
                 <display:column value="${row_rowNum}" title="序号" sortable="true" class="center" headerClass="center"></display:column>
                <display:column property="sort_small_name" title="管理子类别" sortable="true" class="center" headerClass="center"></display:column>
                <%--
                <display:column property="p_unit" title="未达标单位比例" sortable="true" class="center" headerClass="center"></display:column>
                 --%>
                 <display:column property="problem_money" title="未达标单位数" sortable="true" class="center" headerClass="center"></display:column>
                <display:column property="audit_object_name" title="涉及单位" sortable="true" class="center" headerClass="center"></display:column>
				<display:column property="problem_name" title="存在问题" sortable="true" class="center" headerClass="center"></display:column>
			</display:table>
		</center>
	</body>
</html>
