<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>中介机构合作项目列表--在审</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
	</head>
	<body>
		<display:table
			requestURI="${contextPath}/resmngt/integory/proList_ing.action"
			name="proList" id="row" class="its" pagesize="5">
			<display:column property="projectstatus" title="项目状态"
				headerClass="center" sortable="true"></display:column>
			<display:column property="projectcode" title="工程项目编号"
				headerClass="center" style="WHITE-SPACE: nowrap" sortable="true">
			</display:column>
			<display:column property="auditplancode" title="计划编号"
				headerClass="center" style="WHITE-SPACE: nowrap" sortable="true">
			</display:column>
			<display:column property="projecttypeName" title="项目类别"
				headerClass="center" sortable="true"></display:column>
			<display:column title="项目名称" headerClass="center" class="center"
				style="WHITE-SPACE: nowrap">
			</display:column>
			<display:column title="建设单位"
				headerClass="center" class="center"></display:column>
			<display:column  title="审计单位"
				headerClass="center" class="center" sortable="true"></display:column>
			<display:column title="项目组长"
				headerClass="center" class="center" sortable="true"></display:column>
			<display:setProperty name="paging.banner.placement" value="bottom" />
		</display:table>




	</body>
</html>