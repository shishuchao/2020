<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>
			汇总报表
		</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>	
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<s:head theme="simple" />
		<script type="text/javascript">
		</script>
	</head>
	<body>
		<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
							<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/ct/list.action')" />
					</td>
				</tr>
			</table>
		<center>
			<display:table requestURI="list.action" name="stores" id="row" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				class="its" >
				<display:column title="报表名称" headerClass="center" sortable="true" sortName="reportCode" style="height:23px;text-align:center">
					${row.reportCode}
				</display:column>
				<display:column title="调整状态" headerClass="center" style="text-align:center" sortName="false">
					<s:if test="${row.adjustStatus==1}">已调整</s:if>
					<s:else>未调整</s:else>
				</display:column>
				<display:column title="上报状态" headerClass="center" style="text-align:center" sortName="false">
					<s:if test="${row.uploadStatus==1}">已上报</s:if><s:else>未上报</s:else>
				</display:column>
				<display:column title="报表类型" sortName="false" headerClass="center" style="text-align:center">
					<s:if test="${row.reportType==1}">本级报表</s:if>
					<s:elseif test="${row.reportType==2}">汇总报表</s:elseif>
				</display:column>
				<display:column title="报表期间" sortable="false" headerClass="center" style="text-align:center">
					${row.periodStart} 至 ${row.periodEnd}
				</display:column>
				<display:column title="操作" style="text-align:center">
					<s:if test="${row.reportType==1}">
						<s:if test="${row.adjustStatus==1}">
							重新调整
						</s:if>
						<s:else>
							调整
						</s:else>
					</s:if>
					<s:elseif test="${row.reportType==2}">
						<s:if test="${row.adjustStatus==1}">
							重新调整
						</s:if>
						<s:else>
							调整
						</s:else>
						｜删除
					</s:elseif>
				</display:column>
			</display:table>
			<br>
			<div align="right">
				<input type="button" value="汇总" onclick="alert(1)">
				<input type="button" value="删除" onclick="alert(1)">
				<s:if test="${condition.reportType==2}">
					<input type="button" value="批量上报" onclick="alert(1)">
				</s:if>
			</div>
		</center>
	</body>
</html>
