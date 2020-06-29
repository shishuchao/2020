<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
	   <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<s:text id="title" name="'问题统计台账'"></s:text>
		<title>台账列表</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
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
				requestURI="${contextPath}/proledger/problem/findLedgerProblemMendLedgerList.action"
				class="its" pagesize="20">

				<display:column property="project_code" title="项目编号" sortable="true"></display:column>
                <display:column property="project_name" title="项目名称" sortable="true"></display:column>
                <display:column property="audit_object_name" title="被审计单位" sortable="true"></display:column>
				<display:column property="problem_name" title="问题点" sortable="true"></display:column>
				<display:column property="problem_money" title="问题发生数" sortable="true"></display:column>
				<display:column property="p_unit" title="问题统计单位" sortable="true"></display:column>

			</display:table>
		</center>
	</body>
</html>
