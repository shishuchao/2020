<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>
			本级报表
		</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>	
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>	
		<s:head theme="simple" />
	</head>
	<body>
		<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
						<div style="display: inline;width:80%;">
							<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/cell/thisLevelList.action')"/>
						</div>
						<div style="display: inline;width:20%;text-align: right;">
							<a href="javascript:;" onclick="triggerSearchTable();">&nbsp;&nbsp;</a>
						</div>
					</td>
				</tr>
		</table>
		<s:form action="thisLevelList" namespace="/report/cell" method="post">
			<table id="searchTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center" ">
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						调整状态：
					</td>
					<td align="left" class="listtabletr22">
						<s:select name="helper.adjustStatus" list="#@java.util.LinkedHashMap@{0:'未调整',1:'已调整'}" 
						 	listKey="key" listValue="value"
							emptyOption="true" cssStyle="width:100"/>
					</td>
					<td align="left" class="listtabletr11">
						上报状态：
					</td>
					<td align="left" class="listtabletr22">
						<s:select name="helper.uploadStatus" list="#@java.util.LinkedHashMap@{0:'未上报',1:'已上报',2:'允许上报'}" 
							listKey="key" listValue="value"
							emptyOption="true" cssStyle="width:150"/>
					</td>

				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						报表类型：
					</td>
					<td align="left" class="listtabletr22">
						<s:select name="helper.reportType" list="#@java.util.LinkedHashMap@{1:'本级报表',2:'汇总报',3:'下级上报报表'}" 
							listKey="key" listValue="value"
							emptyOption="true"/>
					</td>
					<td align="left" class="listtabletr11">
						季度：
					</td>
					<td align="left" class="listtabletr22">
						<s:select list="seasonList" listKey="code" listValue="name" emptyOption="true"
								name="helper.season" id="season" cssStyle="WIDTH: 150px; HEIGHT: 23px"></s:select>
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right">
							<s:submit value="查询"/>
							&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/report/cell/thisLevelList.action'" />
						</DIV>
					</td>
				</tr>
			</table>
		</s:form>
		<center>
		
			<display:table requestURI="thisLevelList.action" name="stores" id="row" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				class="its" >
				<display:column title="报表名称" headerClass="center" sortable="false" sortName="reportCode" style="height:23px;text-align:center">
					${row.reportCode}
				</display:column>
				<display:column title="调整状态" headerClass="center" style="text-align:center" sortName="false">
					<s:if test="${row.adjustStatus==1}">
						已调整
					</s:if>
					<s:else>未调整</s:else>
				</display:column>
				<display:column title="上报状态" headerClass="center" style="text-align:center" sortName="false">
					<s:if test="${row.uploadStatus==1}">
						<s:if test="${row.allowUpdate==1}">
							要求重报
						</s:if>
						<s:else>已上报</s:else>
					</s:if><s:else>未上报</s:else>
				</display:column>
				<display:column title="报表类型" sortName="false" headerClass="center" style="text-align:center">
					<s:if test="${row.reportType==1}">本级报表</s:if>
					<s:elseif test="${row.reportType==2}">汇总报表</s:elseif>
				</display:column>
				<display:column title="报表期间" sortable="false" headerClass="center" style="text-align:center">
					${row.periodStart} 至 ${row.periodEnd}
				</display:column>
				<display:column title="操作" headerClass="center" style="text-align:center">
					<a href="view.action?condition.id=${row.id}">查看</a>
					<s:if test="${row.adjustStatus==0}">
						<a href="adjust.action?condition.id=${row.id}">调整</a>
					</s:if>
					<s:if test="${row.uploadStatus!=1}">
						<s:if test="${row.adjustStatus==1}">
							<a href="delete.action?condition.id=${row.id}&condition.isAdjust=1">删除调整</a>
							<a href="upload.action?condition.id=${row.id}">上报</a>
						</s:if>
						<a href="delete.action?condition.id=${row.id}&condition.reportType=1">删除</a>
					</s:if>
				</display:column>
			</display:table>
			<br>
			<div align="right">
				<input type="button" value="新增报表" onclick="javascript:document.location='mainCR.action?templateType=2'">
				<input type="button" value="下级报表" onclick="javascript:document.location='lowerLevelList.action'">
				<input type="button" value="汇总报表" onclick="showPopWin('${contextPath}/report/cell/searchSum4ReportList.action',600,350)">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</center>
	</body>
	<script type="text/javascript">
		function sumTotal(){
			var season = document.getElementById('season').value;
			if(season != ''){
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/report/cell', action:'checkIsEnableSum', executeResult:'false' }, 
					{'season':season},
					xxx
				);
				function xxx(data){
					isEnableSum = data['isEnableSum'];
					alert(isEnableSum);
					if(isEnableSum=="true"){
						document.location="sum.action?season="+season;
					}else{
						alert("已经存在当前季度的汇总报表了,不能重复汇总.");
					}
				}
			}
			
		}
	</script>
</html>
