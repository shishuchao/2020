<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="ais.framework.util.NavigationUtil" />
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目详细信息111</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${pageContext.request.contextPath}/styles/main/ais.css"
			rel="stylesheet" type="text/css">
		<s:head theme="ajax" />
	</head>
	<body>
		<table width="100%">
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					<%
					out.print(NavigationUtil.getNavigation("/ais/bpm/taskinstance/frame.action"));
				%>
				</td>
			</tr>
		</table>
		<s:tabbedPanel id='test' theme='ajax'>
			<s:div id='penddingDiv' label='待办信息' theme='ajax' labelposition='top'
				loadingText="正在加载内容......">
				<iframe id="penddingFrame"
					src="${pageContext.request.contextPath}/bpm/taskinstance/pending.action"
					frameborder="0" width="100%" height="500"></iframe>
			</s:div>
			<s:div id='selectedDiv' label='催办信息' theme='ajax' labelposition='top'
				loadingText="正在加载内容......">
				<iframe id="selectedFrame"
					src="${pageContext.request.contextPath}/bpm/reminder/list.action"
					frameborder="0" width="100%" height="500"></iframe>
			</s:div>
		</s:tabbedPanel>
	</body>
</html>
