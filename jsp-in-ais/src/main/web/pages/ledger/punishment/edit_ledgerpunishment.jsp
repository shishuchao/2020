<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:if test="id == 0">
	<s:text id="title" name="'添加'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改'"></s:text>
</s:else>
<html>
	<script language="javascript">
function saveForm(){
	var audit_object=document.getElementById("audit_object").value;
	if(isEmpty(audit_object)){
		alert("被审计单位不能为空!");
		return false;
	}
	var adviseMoney= document.getElementById("adviseMoney").value;
	var practiceMoney= document.getElementById("practiceMoney").value;
	if(!isMoneyNum(adviseMoney)){
         alert("经济处罚-建议罚款金额输入错误!");
         return false;
    }
	if(!isMoneyNum(practiceMoney)){
        alert("经济处罚-实际罚款金额输入错误!");
        return false;
   }
	var url = "${contextPath}/proledger/punishment/save.action";
	myform.action = url;
	myform.submit();
}

function back(){
  window.location.href="${contextPath}/proledger/punishment/listEditPunishment.action?project_id=${project_id}";
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
	<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<head>
		<title><s:property value="#title" /></title>
		<s:head />
	</head>
	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<s:form id="myform" action="save" namespace="/proledger/punishment">
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr>
						<td class="listtabletr11">
							<font color="red">*</font>被审计单位:
						</td>
						<td class="ListTableTr22">
						<s:select name="ledgerPunishment.audit_object" id="audit_object" list="list" listKey="code" listValue="name"  emptyOption="true"></s:select>
			            </td>
						<td class="ListTableTr11">
							姓名:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerPunishment.audited_name"
								cssStyle="width:90%" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							是否移送纪检监察处理:
						</td>
						<td class="ListTableTr22">
							<s:select name="ledgerPunishment.isSupervise" listKey="key"
								listValue="value" labelposition="top" emptyOption="true"
								list="#@java.util.LinkedHashMap@{'N':'否','Y':'是'}" />
						</td>
						<td class="ListTableTr11">
							是否移送司法机关处理:
						</td>
						<td class="ListTableTr22">
							<s:select name="ledgerPunishment.isJudicatory" listKey="key"
								listValue="value" labelposition="top" emptyOption="true"
								list="#@java.util.LinkedHashMap@{'N':'否','Y':'是'}" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							行政处罚-建议处罚方式:
						</td>
						<td class="ListTableTr22">
							<s:select list="basicUtil.punishmentMethodList" listKey="name"
								listValue="name" emptyOption="true"
								name="ledgerPunishment.adviseMethod"></s:select>
						</td>
						<td class="ListTableTr11">
							<font color="red">*</font>经济处罚-建议罚款金额:
						</td>
						<td class="ListTableTr22">
						<s:textfield id="adviseMoney"  name="ledgerPunishment.adviseMoney"
								cssStyle="width:90%" doubles="true" maxlength="15" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							行政处罚-实际处罚方式:
						</td>
						<td class="ListTableTr22">
							<s:select list="basicUtil.punishmentMethodList" listKey="name"
								listValue="name" emptyOption="true"
								name="ledgerPunishment.practiceMethod"></s:select>
						</td>
						<td class="ListTableTr11">
							<font color="red">*</font>经济处罚-实际罚款金额:
						</td>
						<td class="ListTableTr22">
							<s:textfield id="practiceMoney" name="ledgerPunishment.practiceMoney"
								cssStyle="width:90%" doubles="true" maxlength="15" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							行政处罚-备注:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerPunishment.remark_1"
								cssStyle="width:90%" maxlength="100"/>
						</td>
						<td class="ListTableTr11">
							经济处罚-备注:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="ledgerPunishment.remark_2"
								cssStyle="width:90%" maxlength="100"/>
						</td>
					</tr>
				</table>
				<s:hidden name="project_id" />
				<s:hidden name="ledgerPunishment.project_id" value="%{project_id}" />
				<s:hidden name="ledgerPunishment.id" />
				<s:button value="保存" onclick="saveForm();" />&nbsp;&nbsp;
				<s:button value="返回" onclick="back();" />
			</s:form>

		</center>
	</body>
</html>
