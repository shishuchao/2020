<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<s:if test="id == 0">
	<s:text id="title" name="'添加工程台账'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改工程台账'"></s:text>
</s:else>

<html>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
<script type='text/javascript'
	src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript'
	src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<head>
<title><s:property value="#title" /></title>
<style type="text/css">
<!--
td {
	white-space:nowrap;
	overflow: hidden;
}
-->
</style>
<s:head />
</head>

<body>
<center>
<table>
	<tr class="listtablehead">
		<td colspan="5" align="left" class="edithead">&nbsp;<s:property
			value="#title" /></td>
	</tr>
</table>

<s:form id="myform" action="save" namespace="/ledger/ledgerEngineer">
	<table id="tab1" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">

		<tr>
			<td class="ListTableTr11">审计项目编号:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.a_project_code" cssStyle="width:90%" /></td>
			<td class="ListTableTr11">送审日期:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.deliver_time" cssStyle="width:90%" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11">审计单位编号:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.auditedDeptCode" cssStyle="width:90%" /></td>
			<td class="ListTableTr11">审计单位:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.auditedDept" cssStyle="width:90%" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">审计单位性质编号:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.auditedKindCode" cssStyle="width:90%" /></td>
			<td class="ListTableTr11">施工承包单位:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.contract_company" cssStyle="width:90%" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">工程项目编号:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.w_project_code" cssStyle="width:90%" /></td>
			<td class="ListTableTr11">工程项目名称:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.w_project_name" cssStyle="width:90%" /></td>
		</tr>


		<tr>
			<td class="ListTableTr11">审计项目投资总额:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.w_invest_sum" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11">项目期间:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.w_starttime" title="单击选择日期"
				onclick="calendar()" readonly="true" />至 <s:textfield
				name="ledgerEngineer.w_endtime" title="单击选择日期" onclick="calendar()"
				readonly="true" /></td>
		</tr>


		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>送审金额:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.deliver_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>审定金额:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.shending_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>
		<tr>
			<td class="ListTableTr11">核减率:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.hejian_ratio" cssStyle="width:90%" /></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>核减金额:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.hejian_jine" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>
	</table><!--
	<table id="tab2" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr>
			<td class="ListTableTr11" colspan="4"><p align="center">查处问题</p></td>
		</tr>
		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>超规模超标准金额:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.cgmcbz_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>资金不落实金额:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.zjbls_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>

		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>多列概算金额:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.dlgs_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>投资完成额不实:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.tzwcebz_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>

		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>交付资产不实:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.jfzcbs_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>损失浪费:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.sslf_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>

		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>转移侵占挪用资金:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.zyqzny_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>挤占建设成本金额:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.jzjszb_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>

		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>多结工程款:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.djgc_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>截留基本建设收入:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.jljbjc_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>

		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>偷漏税金:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.tshlsh_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>其他:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.other_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>
	</table>

	<table id="tab3" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>核减工程结算资金:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.hjgcjs_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11">审计意见建议:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.a_audit_idea" cssStyle="width:90%"/></td>
		</tr>
		<tr>
			<td class="ListTableTr11">审计意见条数:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.a_audit_idea_num" id="a_audit_idea_num" cssStyle="width:90%" /></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>应补交各项税费:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.ybjgxsf_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>
		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>应归还原渠道资金:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.yghyqd_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>减少项目投资:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.jshxmtz_money" cssStyle="width:90%" doubles="true" maxlength="15"/></td>
		</tr>

		<tr>
			<td class="ListTableTr11">审计项目性质:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.audited_kind" cssStyle="width:90%" /></td>
			<td class="ListTableTr11">审计时间:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.audit_start"
				title="单击选择日期" onclick="calendar()" readonly="true" />至<s:textfield
				name="ledgerEngineer.audit_end" title="单击选择日期"
				onclick="calendar()" readonly="true" /></td>

		</tr>
		<tr>
			<td class="ListTableTr11">内部审计实施单位:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.inside_company" cssStyle="width:90%" /></td>
			<td class="ListTableTr11">外部审计单位:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.outside_company" cssStyle="width:90%" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">录入人员:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.creator" cssStyle="width:90%"
				value="%{user.fname}" /></td>
			<td class="ListTableTr11">录入时间:</td>
			<td class="ListTableTr22"><s:textfield
				name="ledgerEngineer.creat_date" title="单击选择日期" onclick="calendar()"
				readonly="true" /></td>
		</tr>
		<tr>
			<td class="ListTableTr11"><s:button
				onclick="Upload('ledgerEngineer.annex_id',fjList)" value="上传附件"></s:button></td>
			<td class="ListTableTr22" colspan="3">
			<div id="fjList" align="center"><s:property escape="false"
				value="accessoryList" /></div>
			</td>

		</tr>


	</table>

	--><s:hidden name="ledgerEngineer.annex_id" id="ledgerEngineer.annex_id" />
	<s:hidden name="ledgerEngineer.id" />
	<s:hidden name="id" />
	<s:button value="保存" onclick="saveForm();" />&nbsp;&nbsp;

<s:button value="返回列表" onclick="backList();" />
</s:form></center>
<script type="text/javascript">
/*
* 删除附件
*/
function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
	var boolFlag=window.confirm("确认删除吗?");
	if(boolFlag==true){
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
			{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
			xxx);
		function xxx(data){
		  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
		} 
	}
}

/*
* 附件上传
*/
function Upload(id,filelist,delete_flag,edit_flag){
	var guid=document.getElementById(id).value;
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=ledger_engineer&table_guid=annex_id&guid='+guid+'&param='+rnm+'&deletePermission=true&isEdit=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
}
     
function backList(){
	window.location.href="${contextPath}/ledger/ledgerEngineer/list.action";
}



//模板生成----------保存表单
function saveForm(){
	if(frmCheckMoney(document.forms[0],'tab1')==false){
		return false;
	}
	<%--
	if(frmCheckMoney(document.forms[0],'tab2')==false){
		return false;
	}
	if(frmCheckMoney(document.forms[0],'tab3')==false){
		return false;
	}

var a_audit_idea_num=document.getElementById("a_audit_idea_num").value;
if(!isPlusInteger(a_audit_idea_num)){
	alert("审计意见条数输入错误!");
	return false;
}
	--%>
var bool = true;//提交表单判断参数
	//保存表单
	if(bool){
	var flag=window.confirm('确认操作吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/ledger/ledgerEngineer/save.action";
	myform.action = url;
	myform.submit();
	}else{
		 	return false;
		 }
	}
}

</script>
</body>
</html>
