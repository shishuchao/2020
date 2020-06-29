<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>

<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<script type="text/javascript">
/*
*  打开或关闭查询面板
*/
function triggerSearchTable(){
	var isDisplay = document.getElementById('searchTable').style.display;
	if(isDisplay==''){
		document.getElementById('searchTable').style.display='none';
	}else{
		document.getElementById('searchTable').style.display='';
	}
}
</script>
<body>
<CENTER>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead"
					style="text-align: left; width: 100%;">
					<div style="display: inline; width: 80%;">
						审计作业==>被审计单位历史年度问题
					</div>
					<div style="display: inline; width: 100%; text-align: right;">
						<a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a>
					</div>
				</td>
			</tr>
		</table>
			<s:form namespace="/auditAccessoryList" action="historyaduProlist" method="post">
				<table id="searchTable" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center" style="display: none;">
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						被审计单位名称
					</td>
					<td align="left" class="listtabletr22">
					<s:textfield name="middleLedgerProblem.audit_object_name"></s:textfield>
					</td>
					<td align="left" class="listtabletr11">
						项目名称
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="middleLedgerProblem.project_name"></s:textfield>
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						底稿编号
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="middleLedgerProblem.manuscript_code" readonly="true"></s:textfield>
					</td>
					<td align="left" class="listtabletr11">
						问题发现人
					</td>
					<td align="left" class="listtabletr22">
							<s:textfield name="middleLedgerProblem.creater_name" readonly="true"></s:textfield>
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right" style="font: bold;">
							<s:submit value="查询" onclick="return declareExport('false');" />
							&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/auditAccessoryList/historyaduProlist.action'" />
						</DIV>
					</td>
				</tr>
				</table>
			</s:form>
	<display:table name="historyaduProlist" id="row"  class="its" pagesize="${baseHelper.pageSize}"   size="${baseHelper.totalRows}"
			 partialList="true"  requestURI="${contextPath}/auditAccessoryList/historyaduProlist.action" sort="external"
			defaultsort="2" defaultorder="descending" >
			<display:column title="被审计单位名称" property="audit_object_name" sortable="true" sortName="year"></display:column>
			<display:column title="项目名称" property="project_name" sortable="true" sortName="deptName"></display:column>
			<display:column title="底稿编号" property="manuscript_code" sortable="true" sortName="budger"></display:column>
			<display:column title="问题类别" property="problem_all_name" sortable="true" sortName="used"></display:column>
			<display:column title="问题点" property="problem_name" sortable="true" sortName="useRate"></display:column>
			<display:column title="发生金额" property="problem_money" sortable="true" sortName="useRate"></display:column>
			<display:column title="发生数量" property="problemCount" sortable="true" sortName="useRate"></display:column>
			<display:column title="审计发现类型" property="problem_grade_name" sortable="true" sortName="useRate"></display:column>
			<display:column title="定性依据" property="audit_law" sortable="true" sortName="useRate"></display:column>
			<display:column title="审计建议" property="aud_mend_advice" sortable="true" sortName="useRate"></display:column>
			<display:column title="问题发现人" property="creater_name" sortable="true" sortName="useRate"></display:column>
	</display:table>
</CENTER>
</body>
</html>