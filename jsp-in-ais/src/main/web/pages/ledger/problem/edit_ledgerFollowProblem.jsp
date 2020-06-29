<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'后续审计问题统计台账'"></s:text>
<html>
<script language="javascript">
function saveForm(){
	var url = "${contextPath}/proledger/problem/updateLedgerFollowProblem.action";
	myform.action = url;
	myform.submit();
}

function back(){
  window.location.href="${contextPath}/proledger/problem/listEditFollowProblem.action?project_id=${project_id}&isView=${isView}";
}

</script>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
<script type="text/javascript"
	src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<head>
<title><s:property value="#title" /></title>
<s:head />
</head>
<body>
<center>
<table>
	<tr class="listtablehead">
		<td colspan="5" align="left" class="edithead"><s:property
			value="#title" /></td>
	</tr>
</table>
<s:form id="myform" action="updateLedgerFollowProblem"
	namespace="/proledger/problem">
	<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr>
			<td class="ListTableTr11">项目编号:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.project_code" /></td>
			<td class="ListTableTr11">项目名称:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.project_name" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">工作底稿编号:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.manuscript_code" /></td>
			<td class="ListTableTr11">被审计单位:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.m_audit_dept" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">发现人:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.manuscript_creator_name" /></td>
			<td class="ListTableTr11">问题定性:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.problem_grade_name" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">问题类别:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.sort_big_name" /></td>
			<td class="ListTableTr11">问题子类别:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.sort_small_name" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">问题点:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.problem_name" /></td>
			<td class="ListTableTr11">问题金额:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.problem_money" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">问题所属开始日期：</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.creater_startdate" /></td>
			<td class="ListTableTr11">问题所属结束日期：</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.creater_enddate" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">问题描述:</td>
			<td class="ListTableTr22" colspan="3"><s:textarea
				name="ledgerProblem.problem_desc" title="问题描述" cssStyle="width:90%;height:60"
				readonly="true" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">是否整改:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.isNotMend" /></td>
			<td class="ListTableTr11">整改期限开始日期:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.mend_term" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">整改期限结束日期:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.mend_term_enddate" /></td>
			<td class="ListTableTr11">整改方式:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.mend_method" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">检查方式:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.examine_method" /></td>
			<td class="ListTableTr11">检查人:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.examine_creater_name" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">整改结果:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.mend_result" /></td>
			<td class="ListTableTr11">检查结果:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.examine_result" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">实际整改方式</td>
			<td class="ListTableTr22"><s:select
				list="basicUtil.mendMethodList" listKey="code" listValue="name"
				emptyOption="true" name="ledgerProblem.f_fact_mend_method_code"></s:select>
			</td>
			<td class="ListTableTr11">整改评价</td>
			<td class="ListTableTr22"><s:select
				list="basicUtil.fllowOpinionList" listKey="code" listValue="name"
				emptyOption="true" name="ledgerProblem.f_mend_opinion_code"></s:select>
			</td>
		</tr>
		<tr>
			<td class="ListTableTr11">实际整改情况</td>
			<td class="ListTableTr22" colspan="3"><s:textarea
				name="ledgerProblem.f_fact_mend_thing" title="实际整改情况"></s:textarea>
			<input type="hidden" id="ledgerProblem.f_fact_mend_thing.maxlength"
				value="250"></td>
		</tr>
	</table>
	<s:hidden name="project_id" />
	<s:hidden name="ledgerProblem.project_id" value="%{project_id}" />
	<s:hidden name="ledgerProblem.id" />
	<s:if test="view=='true'">
	</s:if>
	<s:else>
		<s:button value="保存" onclick="saveForm();" />&nbsp;&nbsp;
				</s:else>
	<s:button value="返回" onclick="back();" />
</s:form></center>
</body>
</html>
