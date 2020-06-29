<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<s:text id="title" name="'行政收文'"></s:text>
		<title><s:property value="#title" />列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" class="edithead"
						style="text-align: left; width: 100%;">
						<div style="display: inline; width: 80%;">
							<s:property escape="false"
								value="@ais.framework.util.NavigationUtil@getNavigation('/ais/executive/recfile/list.action')" />
						</div>
					</td>
				</tr>
			</table>
			<display:table name="list" id="row"
				requestURI="${contextPath}/executive/recfile/list.action"
				class="its" pagesize="15" cellpadding="1">
				<display:column property="signerName" title="签发人" sortable="true"></display:column>

				<display:column property="writerName" title="拟稿人" sortable="true"></display:column>

				<display:column property="writerDept" title="拟稿人部门" sortable="true"></display:column>

				<display:column property="sendFileNO" title="发文字号" sortable="true"></display:column>

				<display:column property="refeDate" title="编号日期" sortable="true"></display:column>

				<display:column property="signerDate" title="签发日期" sortable="true"></display:column>

				<display:column property="title" title="标题" sortable="true"></display:column>

				<display:column property="publishUnit" title="印发单位" sortable="true"></display:column>

				<display:column property="createTime" title="创建时间" sortable="true"></display:column>
				<display:column title="操作">
					<a
						href="${contextPath}/executive/sendfile/view.action?crudId=${row.formId}"
						target="_blank">查看</a>&nbsp;&nbsp;
					<!-- <a href="${contextPath}/executive/sendfile/delete.action?crudId=${row.formId}">删除</a>&nbsp;&nbsp; -->
				</display:column>
			</display:table>
			<br>
			<br>
		</center>
	</body>
</html>
