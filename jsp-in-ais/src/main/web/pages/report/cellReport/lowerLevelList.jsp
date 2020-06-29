<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>
			下级上报
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
							决策支持==>审计报表==>下级报表 
					</td>
				</tr>
			</table>
		<s:form action="lowerLevelList" namespace="/report/cell" method="post">
			<table id="searchTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center">
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						上报单位：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="helper.reportDeptName" cssStyle="width:98%"></s:textfield>
					</td>
					<td align="left" class="listtabletr11">
						报表期间：
					</td>
					<td align="left" class="listtabletr22">
						<s:select list="seasonList" listKey="code" listValue="name" emptyOption="true"
								name="helper.season" id="season" cssStyle="WIDTH: 150px; HEIGHT: 23px"></s:select>
					</td>
					</td>

				</tr>
			
				<tr class="listtablehead">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right">
							<s:submit value="查询"/>
							&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='lowerLevelList.action'" />
						</DIV>
					</td>
				</tr>
			</table>
		</s:form>
		<center>
			<display:table requestURI="list.action" name="stores" id="row" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				class="its" >
				<display:column title="报表名称" headerClass="center" sortable="false" sortName="reportCode" style="height:23px;text-align:center">
					${row.reportCode}
				</display:column>
				<display:column title="上报单位" property="reportDeptName" headerClass="center" sortable="false" style="height:23px;text-align:center">
				</display:column>
				<display:column title="报表类型" sortable="false" headerClass="center" style="text-align:center">
					下级上报
				</display:column>
				<display:column title="报表期间" sortable="false" headerClass="center" style="text-align:center">
					${row.periodStart} 至 ${row.periodEnd}
				</display:column>
				<display:column title="操作"  headerClass="center" style="text-align:center">
					<a href="view.action?condition.id=${row.id}&isUpload=1">查看</a>
					<a href="bohui.action?condition.id=${row.id}">驳回</a>
					
				</display:column>
			</display:table>
			<br>
			<div align="right">
				<input type="button" onclick="javascript:document.location='thisLevelList.action'" value="返回">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</center>
	</body>
</html>
