<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'问题统计台账'"></s:text>
<html>
<script language="javascript">
function saveForm(){
	var url = "${contextPath}/proledger/problem/updateLedgerProblem.action";
	<s:if test="isrework!='true'">
	var mend_term= document.getElementById("mend_term").value;
	var mend_term_enddate= document.getElementById("mend_term_enddate").value;
	var isNotMend= document.getElementById("isNotMend").value;
	if(isNotMend=='是'){
		if(mend_term==null||mend_term==''){
            alert("整改期限开始日期不能为空!");
            return false;
		}
		if(mend_term_enddate==null||mend_term_enddate==''){
            alert("整改期限结束日期不能为空!");
            return false;
		}
	}
	</s:if>
	myform.action = url;
	myform.submit();
	
}

function back(){
  window.location.href="${contextPath}/proledger/problem/listEditProblem.action?project_id=${project_id}&isView=${isView}&isrework=${isrework}&isEdit=${isEdit}";
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
<s:form id="myform" action="updateLedgerProblem"
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
			<td class="ListTableTr11">底稿提交时间:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.manuscript_date" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">底稿提交人:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.manuscript_creator_name" /></td>
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
			<td class="ListTableTr11">发生数:</td>
			<td class="ListTableTr22"><s:property
				value="ledgerProblem.problem_money" doubles="true" /><s:property
				value="ledgerProblem.p_unit" /></td>
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
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.isNotMend" />
			</s:if> <s:else>
				<s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}"
					name="ledgerProblem.isNotMend" id="isNotMend" emptyOption="true"></s:select>
			</s:else></td>
			<td class="ListTableTr11">整改状态:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:select list="#@java.util.LinkedHashMap@{'未整改':'未整改','已整改':'已整改'}"
					name="ledgerProblem.mend_state" id="mend_state" emptyOption="true"></s:select>
			</s:if> <s:else>
						     ${ledgerProblem.mend_state}
						</s:else></td>
		</tr>
		<tr>
			<td class="ListTableTr11">整改期限开始日期:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.mend_term" />
			</s:if> <s:else>
				<s:textfield name="ledgerProblem.mend_term" id="mend_term"
					readonly="true" title="单击选择日期" onclick="calendar()"
					cssStyle="width:90%" maxlength="20" />
			</s:else></td>
			<td class="ListTableTr11">整改期限结束日期:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.mend_term_enddate" />
			</s:if> <s:else>
				<s:textfield name="ledgerProblem.mend_term_enddate"
					id="mend_term_enddate" readonly="true" title="单击选择日期"
					onclick="calendar()" cssStyle="width:90%" maxlength="20" />
			</s:else></td>
		</tr>
		<tr>
			<td class="ListTableTr11">整改方式:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.mend_method" />
			</s:if> <s:else>
				<s:select list="basicUtil.mendMethodList" listKey="code"
					listValue="name" emptyOption="true"
					name="ledgerProblem.mend_method_code"></s:select>
			</s:else></td>
			<td class="ListTableTr11">检查方式:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.examine_method" />
			</s:if> <s:else>
				<s:select list="basicUtil.examineMethodList" listKey="code"
					listValue="name" emptyOption="true"
					name="ledgerProblem.examine_method_code"></s:select>
			</s:else></td>
		</tr>
		<tr>
			<td class="ListTableTr11">检查人:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.examine_creater_name" />
			</s:if> <s:else>
				<s:select list="list" listKey="code" listValue="name"
					emptyOption="true" name="ledgerProblem.examine_creater_code"></s:select>
			</s:else></td>
			<td class="ListTableTr11">责任人:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.zeren_person" />
			</s:if> <s:else>
				<s:textfield name="ledgerProblem.zeren_person" />
			</s:else></td>
		</tr>
		<tr>
			<td class="ListTableTr11">责任部门:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.zeren_dept" />
			</s:if> <s:else>
				<s:textfield name="ledgerProblem.zeren_dept" />
			</s:else></td>
			<td class="ListTableTr11">责任单位:</td>
			<td class="ListTableTr22"><s:if test="isrework=='true'">
				<s:property value="ledgerProblem.zeren_company" />
			</s:if> <s:else>
				<s:textfield name="ledgerProblem.zeren_company" />
			</s:else></td>
		</tr>
		<s:if test="isrework=='true'">
			<tr>
				<td class="ListTableTr11">整改结果:</td>
				<td class="ListTableTr22"><s:textarea
					name="ledgerProblem.mend_result" title="整改结果" cssStyle="width:90%" />
				<input type="hidden" id="ledgerProblem.mend_result.maxlength"
					value="250"></td>
				<td class="ListTableTr11">检查结果:</td>
				<td class="ListTableTr22"><s:textarea
					name="ledgerProblem.examine_result" title="检查结果"
					cssStyle="width:90%" /> <input type="hidden"
					id="ledgerProblem.examine_result.maxlength" value="250"></td>
			</tr>
		</s:if>
		<s:else>
			<td class="ListTableTr11">整改结果:</td>
			<td class="ListTableTr22">${ledgerProblem.mend_result}</td>
			<td class="ListTableTr11">检查结果:</td>
			<td class="ListTableTr22">${ledgerProblem.examine_result}</td>
		</s:else>
		<tr>
			<td class="ListTableTr11">审计记录:</td>
			<td class="ListTableTr22" colspan="3"><s:property
				value="describe" /></td>
		</tr>

	</table>
	<s:hidden name="project_code" />
	<s:hidden name="project_id" />
	<s:hidden name="isrework" />
	<s:hidden name="ledgerProblem.project_id" value="%{project_id}" />
	<s:hidden name="ledgerProblem.id" />
	<s:hidden name="isView" />
	<s:if test="isView=='true'">
	</s:if>
	<s:else>
		<s:button value="保存" onclick="saveForm();" />&nbsp;&nbsp;
				</s:else>
	<s:button value="返回" onclick="back();" />
</s:form></center>
</body>
</html>
