<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<s:if test="id == 0">
	<s:text id="title" name="'添加合同台账'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改合同台账'"></s:text>
</s:else>
<title><s:property value="#title" /></title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
<script type='text/javascript'
	src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript'
	src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>

</head>
<body>
<center>
<table>
	<tr class="listtablehead">
		<td colspan="5" align="left" class="edithead">&nbsp;<s:property
			value="#title" /></td>
	</tr>
</table>

<s:form id="myform" action="save"
	namespace="/ledger/contract/ledgerContract">

	<table id="contract_table" cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr>
			<td class="ListTableTr11">合同编号:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.c_code" cssStyle="width:90%" />
			</td>
			<td class="ListTableTr11">合同名称:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.c_name" cssStyle="width:90%" />
			</td>
		</tr>
		<tr>
			<td class="ListTableTr11"><font color=red>*</font><font color=red
								style="visibility: hidden;">￥</font>合同金额:</td>
			<!--标题栏-->
			<td class="ListTableTr22" colspan="3"><s:textfield
				name="ledgerContract.c_money" cssStyle="width:60%"  doubles="true" maxlength="10" />(万元) <font
				color="red">请填写数字</font></td>
		</tr>
		<tr>
			<td class="ListTableTr11">合同内容:</td>
			<!--标题栏-->
			<td class="ListTableTr22" colspan="3"><s:textarea
				name="ledgerContract.c_context" cssStyle="width:90%" cols="3" />
			<input type="hidden" id="ledgerContract.c_context.maxlength" value="1000">
			</td>
		</tr>
		<tr>
			<td class="ListTableTr11">对方单位:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.other_company" cssStyle="width:90%" /></td>
			<td class="ListTableTr11">联系人:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.linkman" cssStyle="width:90%" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">评审意见:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.assess_idea" cssStyle="width:90%" maxlength="200" /></td>
			<td class="ListTableTr11">提出规范要求:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.criterion_ask" cssStyle="width:90%" maxlength="200"/></td>
		</tr>

		<tr>
			<td class="ListTableTr11">评审条数:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.assess_num" id="assess_num" cssStyle="width:50%" maxlength="10" /> <font
				color="red">请填写数字</font></td>
			<td class="ListTableTr11">提出规范要求条数:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.criterion_num" id="criterion_num" cssStyle="width:50%" maxlength="10" /> <font
				color="red">请填写数字</font></td>
		</tr>

		<tr>
			<td class="ListTableTr11"><s:button
				onclick="Upload('ledgerContract.annex_id',fjList)" value="上传附件"></s:button></td>
			<td class="ListTableTr22" colspan="3">
			<div id="fjList" align="center"><s:property escape="false"
				value="accessoryList" />
			</div>
			</td>

		</tr>

		<tr>
			<td class="ListTableTr11">评审部门:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.assess_dept" cssStyle="width:90%" /></td>
			<td class="ListTableTr11">评审人:</td>
			<!--标题栏-->
			<td class="ListTableTr22"><s:textfield
				name="ledgerContract.assess_person" cssStyle="width:90%" /></td>
		</tr>

		<tr>
			<td class="ListTableTr11">评审时间:</td>
			<td class="ListTableTr22" colspan="3"><s:textfield
				name="ledgerContract.assess_date" title="单击选择日期"
				onclick="calendar()" readonly="true" /></td>
		</tr>

	</table>

	<s:hidden name="id" />
	<s:hidden name="ledgerContract.id"/>
	<s:hidden name="ledgerContract.annex_id" id="ledgerContract.annex_id" />
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
	window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=ledger_contract&table_guid=annex_id&guid='+guid+'&param='+rnm+'&deletePermission=true&isEdit=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
}
     
function backList(){
	window.location.href="${contextPath}/ledger/contract/ledgerContract/list.action";
}

//模板生成----------保存表单
function saveForm(){
	if(frmCheckMoney(document.forms[0],'contract_table')==false){
		return false;
	}
	var assess_num=document.getElementById("assess_num").value;
	var criterion_num=document.getElementById("criterion_num").value;
	if(!isPlusInteger(assess_num)){
		alert("评审条数输入错误!");
		return false;
	}
	if(!isPlusInteger(criterion_num)){
		alert("提出规范要求条数输入错误!");
		return false;
	}
	
var bool = true;//提交表单判断参数
//非空校验

	//保存表单
	if(bool){
	var flag=window.confirm('确认操作吗?');//isSubmit
	if(flag==true){
	var url = "${contextPath}/ledger/contract/ledgerContract/save.action";
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
