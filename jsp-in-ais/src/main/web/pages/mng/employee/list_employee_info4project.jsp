<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>审计人员基本信息列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body >
		<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					<div style="display: inline;width:80%;">
						<s:if test="${listStatus == 'edit'}">
							<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/employee/employeeInfoList.action?listStatus=edit')"/>
						</s:if>
						<s:else>
							<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/employee/employeeInfoList.action')"/>
						</s:else>
					</div>
					<div style="display: inline;width:20%;text-align: right;">
					</div>
				</td>
			</tr>
		</table>
		<center>
		<display:table requestURI="${contextPath}/mng/employee/employeeInfoList4Project.action" name="list" id="row" class="its"
		 	pagesize="${baseHelper.pageSize}" partialList="true" 
			size="${baseHelper.totalRows}" sort="external"
			defaultsort="2" defaultorder="descending">
			<display:column title="姓名" headerClass="center" sortable="true">
				<a href="${contextPath}/mng/employee/employeeInfoView.action?employeeInfo.id=${row.id}&listStatus=${listStatus}">${row.name}</a>
			</display:column>
			<display:column property="sex" title="性别" sortable="true" headerClass="center" style="height:23px"/>
			<display:column property="type" title="人员类型" sortable="true" headerClass="center"/>
			<display:column property="graduateAcademy" title="毕业院校" headerClass="center" sortable="true"/>
			<display:column property="speciality" title="专业" sortable="true" headerClass="center"/>
			<display:column property="diploma" title="最高学历" sortable="true" headerClass="center"/>
			<display:column property="technicalPost" title="职称级别" headerClass="center" sortable="true"/>
			<display:column property="competence" title="职业资格" sortable="true" headerClass="center"/>
			<display:column property="company" title="所属单位" headerClass="center" sortable="true"/>
			<display:column property="duty" title="职务" headerClass="center" sortable="true"/>
			<display:column property="incumbencyState" title="在职状态" headerClass="center" sortable="true"/>
			<display:column property="isSysAccounts" title="是否为系统用户" headerClass="center" sortable="true"/>
		</display:table>
		<br>
		</center>
	</body>
</html>
