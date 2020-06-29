<jsp:directive.page
	import="org.springframework.web.context.WebApplicationContext" />
<jsp:directive.page
	import="org.springframework.web.context.support.WebApplicationContextUtils" />
<jsp:directive.page import="ais.framework.acegi.SecurityContextUtil" />
<%@page import="ais.bpm.model.AudTaskInstance"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>待办事项1</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
		<SCRIPT type="text/javascript">
			function comUrl(process_id,group_id,fromNode)
			{
				var url=window.location.href;
				url=url.substr(url.indexOf('${pageContext.request.contextPath}'),url.length);
				window.location.href="${pageContext.request.contextPath}/plan/listTobeSubmited.action?adjustType=2000&&definition_id="+process_id+"&&group_id="+group_id+"&&fromNode="+fromNode+"&&backUrl="+url;
			}
		</SCRIPT>
	</head>
	<body>
		<center>
			<h2></h2>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property
							escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/bpm/taskinstance/pending.action')" />
					</td>
				</tr>
			</table>
			<%
						WebApplicationContext ctx = WebApplicationContextUtils
						.getWebApplicationContext(application);
						SecurityContextUtil.isGrantedAuthority("PLAN_ADJUST_PERMISSION");
			%>
			<display:table name="taskInstanceList" id="row"
				requestURI="${contextPath}/bpm/taskinstance/pending.action"
				class="its" export="false" pagesize="10" size="100%">
				<display:column property="processName" title="流程名称" sortable="true"
					headerClass="center" class="center"></display:column>
				<display:column property="formNameDetail" title="表单名称"
					sortable="true" headerClass="center" class="center"></display:column>
				<display:column property="name" title="任务名称" sortable="true"
					headerClass="center" class="center"></display:column>
				<display:column title="创建时间" sortable="true" headerClass="center"
					class="center">
					<c:set var="create" value="${row.create}" scope="request"></c:set>
					<s:date name="#request.create" format="yyyy-MM-dd HH:mm:ss" />
				</display:column>
				<display:column title="上一步处理人" sortable="true" headerClass="center" class="center" property="fromActorName" />
				<display:column title="催办时间" sortable="true" headerClass="center" class="center">
					<s:if test="${empty row.reminderTimes}">
						-
					</s:if>
					<s:else>
						${row.reminderTimes}
					</s:else>
				</display:column>
				<display:column title="操作" media="html" headerClass="center"
					class="center">
					<c:choose>
						<c:when test="${row.plan_code!=null&&row.plan_code!=''}">
							<a href="${contextPath}${row.editUrl}&code=${row.plan_code}">处理</a>&nbsp;&nbsp;</c:when>
						<c:otherwise>
							<a href="${contextPath}${row.editUrl}">处理</a>&nbsp;&nbsp;</c:otherwise>
					</c:choose>
				</display:column>
				<%-- 注意下面的标签不要换行 --%>
				<%--				<display:setProperty name="export.excel.filename"><%=new String("导出待办.xls".getBytes("GBK"),"ISO-8859-1")%></display:setProperty>--%>
			</display:table>
			<br>
		</center>
	</body>
</html>
