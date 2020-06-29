<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<html>
<head><title></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>					
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>	
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>				
</head>
<body>
<script>
	function vNum(){
		if(!isMoneyNum(document.getElementById('adminDept.penalizeMoney').value)){
			alert("处罚金额 应为金额！");
			return false;
		}
		return true;
	}
	function saveObj(){
		if(frmCheck(document.forms[0],'tab1')&&vNum()){
			var beginDate=document.getElementsByName("adminDept.beginDate")[0].value;
 			var endDate=document.getElementsByName("adminDept.endDate")[0].value;
 			if(!compareDate(beginDate,endDate)){
 				alert("检查结束日期 要大于 检查开始日期!");
				return false;
 			}
			document.forms[0].submit();	
		}
	}
	function deleteFile(fileId, guid, bool, appType){
			if(window.confirm("确认删除吗?")){
				send("${contextPath}/commons/file/delFile.action?fileId=" + fileId + "&&deletePermission=" + bool + "&&isEdit=false&&guid=" + guid + "&&appType=" + appType, guid);
			}
		}
	
	function Upload(id, filelist){
		var guid = document.getElementById(id).value;
		var num = Math.random();
		var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_audobj_admindept&table_guid=accessory&guid=' + guid + '&deletePermission=true&isEdit=false&param=' + rnm, filelist, 'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	function displayMenoy(){
		var isPenalize = document.getElementsByName("adminDept.isPenalize")[0].value;
		if(isPenalize!=null && isPenalize=='是')
			document.getElementById("moneyId").style.display="";
		else{
			document.getElementsByName("adminDept.penalizeMoney").value="";
			document.getElementById("moneyId").style.display="none";
		}
	}
</script>
<center>
	<s:form action="saveAdminDept" namespace="/mng/audobj/object">
		<table id='tab1' cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					检查单位
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:textfield cssStyle="width:100%" name="adminDept.checkDept" maxlength="50"></s:textfield>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					检查开始日期
				</td>
				<td class="ListTableTr22">
					<s:textfield name="adminDept.beginDate" readonly="true"
						cssStyle="width:100%" maxlength="10" title="单击选择日期"
					onclick="calendar()"></s:textfield>
				</td>
				<td class="ListTableTr11" nowrap="nowrap">
					检查结束日期
				</td>
				<td class="ListTableTr22">
					<s:textfield name="adminDept.endDate" readonly="true"
						cssStyle="width:100%" maxlength="10" title="单击选择日期"
					onclick="calendar()"></s:textfield>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					是否被处罚
				</td>
				<td class="ListTableTr22">
					<s:select name="adminDept.isPenalize" list="#@java.util.LinkedHashMap@{'':'','是':'是','否':'否'}" cssStyle="width:100%;" onchange="displayMenoy()"></s:select>
				</td>						
				<td class="ListTableTr11" nowrap="nowrap">
					处罚金额
				</td>
				<td class="ListTableTr22">
					<s:if test="${adminDept.isPenalize=='是'}">
						<div id="moneyId">
					</s:if>
					<s:else>
						<div id="moneyId" style="display: none">
					</s:else>
						<input name="adminDept.penalizeMoney" value="${adminDept.penalizeMoney}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">
						（万元）
					</div>
				</td>						
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					检查内容
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:textarea cssStyle="width:100%" name="adminDept.checkContent"></s:textarea>
					<input type="hidden" id="adminDept.checkContent.maxlength" value="20">
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					<s:button onclick="Upload('adminDept.accessory', accessoriesList)" value="上传附件"></s:button>
					<s:hidden name="adminDept.accessory"/>
				</td>
				<td class="ListTableTr22" colspan="3">
					<div id="accessoriesList" align="center">
						<s:property escape="false" value="adminDeptAccessoriesByDelete" />	
					</div>
				</td>						
			</tr>
		</table>
		<s:button value="保存" onclick="saveObj()"></s:button>&nbsp;&nbsp;
		<input type="button" name="back" value="返回" onclick="javascript:window.location='${contextPath}/mng/audobj/object/searchAdminDept.action?pid=${pid}&status=${status}'">
		<br>
		<s:hidden name="pid"></s:hidden>
		<s:hidden name="status"></s:hidden>
		<s:hidden name="adminDept.pid"></s:hidden>
		<s:hidden name="adminDept.id"></s:hidden>
	</s:form>
</center>
</body>
</html>