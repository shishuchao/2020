<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>
	<body>
		<center>

			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property
							escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/bpm/taskinstance/finished.action')" />
					</td>
				</tr>
			</table>

			<display:table name="taskInstanceList" id="row" export="false"
				requestURI="/bpm/taskinstance/finished.action" pagesize="10"
				class="its" cellpadding="1">
				<display:column property="processName" title="流程名称" sortable="true" headerClass="center" class="center" style="WHITE-SPACE: nowrap"></display:column>
				<display:column property="formName" title="任务名称" sortable="true" style="WHITE-SPACE: nowrap"
					headerClass="center" class="center"></display:column>
				<!-- LIHAIFENG 2007-08-01 -->
				<display:column title="流程状态" headerClass="center" class="center" style="WHITE-SPACE: nowrap">
					<s:set name="formState_bool" value="${row.formState}"
						scope="action" />
					<s:if test="#formState_bool==1">正在执行</s:if>
					<s:elseif test="#formState_bool==2">已挂起</s:elseif>
					<s:else>已完成</s:else>
				</display:column>
				<display:column title="操作" media="html" headerClass="center" style="WHITE-SPACE: nowrap"
					class="center">
					<a href="${contextPath}${row.viewLink}">查 看</a>
				</display:column>
				<%-- 注意下面的标签不要换行 --%>
				<%--				<display:setProperty name="export.excel.filename"><%=new String("导出已办.xls".getBytes("GBK"),"ISO-8859-1") %></display:setProperty>--%>
			</display:table>

		</center>
	</body>
</html>
