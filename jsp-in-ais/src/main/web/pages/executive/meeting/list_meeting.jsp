<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<s:text id="title" name="'会议通知'"></s:text>
		<title><s:property value="#title" />列表</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>

	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" class="edithead"
						style="text-align: left; width: 100%;">
						<div style="display: inline; width: 80%;">
							<s:property escape="false"
								value="@ais.framework.util.NavigationUtil@getNavigation('/ais/executive/meeting/list.action')" />
						</div>
						
					</td>
				</tr>
			</table>
			<display:table name="list" id="row"
				requestURI="${contextPath}/executive/meeting/list.action"
				class="its" pagesize="15" cellpadding="1">
				<display:column property="draftsmanName" title="起草人" sortable="true"></display:column>

				<display:column property="pubDate" title="发布日期" sortable="true"></display:column>

				<display:column property="callDate" title="召开日期" sortable="true"></display:column>

				<display:column property="startTime" title="开始时间" sortable="true"></display:column>

				<display:column property="sumUnit" title="召集单位" sortable="true"></display:column>

				<display:column property="compereName" title="主持人" sortable="true"></display:column>

				<display:column property="locate" title="地点" sortable="true"></display:column>

				<display:column property="joiner" title="参加人员" sortable="true"></display:column>

				<display:column property="meetingName" title="会议名称" sortable="true"></display:column>

				<display:column property="meetingTitle" title="会议议题" sortable="true"></display:column>

				<display:column title="操作">
					<!-- 		<a href="${contextPath}/executive/meeting/edit.action?crudId=${row.formId}">编辑</a>&nbsp;&nbsp;
		<a href="${contextPath}/executive/meeting/view.action?crudId=${row.formId}"target="_blank">查看</a>&nbsp;&nbsp;
		<a href="${contextPath}/executive/meeting/delete.action?crudId=${row.formId}">删除</a>&nbsp;&nbsp;
-->
					<s:if test="${row.taskStatsId ==''||row.taskStatsId==null}">
						<a
							href="${contextPath}/executive/meeting/edit.action?crudId=${row.formId}"
							onclick="return confirm('确认要启动项目吗?');">启动</a>&nbsp;&nbsp;
					</s:if>
					<s:elseif test="${row.taskStatsId=='10'}">
						<a
							href="${contextPath}/executive/meeting/edit.action?crudId=${row.formId}">处理</a>&nbsp;&nbsp;
					</s:elseif>
					<a
						href="${contextPath}/executive/meeting/view.action?crudId=${row.formId}"
						target="_blank">查看</a>&nbsp;&nbsp;
	</display:column>
			</display:table>
			<br>
			<br>
			<div align="right">
				<input type="button" name="add" value="添加"
					onclick="javascript:window.location='<s:url action="edit"><s:param name="id" value="0"/></s:url>'">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</center>
	</body>
</html>
