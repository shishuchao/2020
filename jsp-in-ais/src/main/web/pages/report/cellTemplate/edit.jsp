<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>编辑公式</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<style type="text/css">
			textarea {
				width: 90%;
				height: 50px;
			}
		</style>
		<s:head theme="simple" />
		<script type="text/javascript">
			function saveForm(){
				if(frmCheck(document.forms[0], 'tab1')&&validateRepeat()){
					document.forms[0].submit();
				}
			}
			function changeType(vle){
			}
			function changeNr(){
				var nrs = document.getElementById('save_cellTemplate_namedReport');
				var nr = nrs.options[nrs.selectedIndex];
				document.getElementById('save_cellTemplate_templateCode').value=nr.value;
				document.getElementById('save_cellTemplate_templateName').value=nr.text;
			}
			function validateRepeat(){
				var flag = false;
				var templateName = document.getElementById("save_cellTemplate_templateName").value;
				var id = document.getElementById("save_cellTemplate_id").value;
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/report/ct', action:'validateRepeat', executeResult:'false' }, 
				{ 'templateName':templateName,'id':id },callbackFun);
			    function callbackFun(data){
			     	var hasRepeat = data['message'];
			     	if( hasRepeat!= null && hasRepeat != '0'){
				     	if(hasRepeat=='1'){
			     			alert("已存在相同的报表名称！");
				     	}
			     		flag = false;
			     	}else{
			     		flag = true;
			     	}
				}
				return flag;
			}
			function loadForm(){
				var operateResult = document.getElementById("operateResult").value;
				if(operateResult=='false'){
					alert("保存失败！");
				}
			}
		</script>
	</head>
	<body onload="loadForm()">
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<s:form action="save" namespace="/report/ct" name="editForm">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
						<s:if test="${empty(cellTemplate.id)}">
							新增报表
						</s:if>
						<s:else>
							修改报表
						</s:else>
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 align="right">
						报表编号
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="35%" align="left">
							<s:textfield name="cellTemplate.templateCode" size="20"  title="公式名称" maxlength="50"/>
					</TD>
					<TD class=ListTableTr1 width="120" align="right">
						报表名称
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 align="left">
							<s:textfield name="cellTemplate.templateName" size="20"  title="公式名称" maxlength="50"/>
					</TD>
				</TR>
				<TR style="display:'none'">
					<TD class=ListTableTr1 style="width: 120px">
						报表类型
					</TD>
					<TD class="ListTableTr2" align="left" colspan="3">
						<s:select list="#@java.util.LinkedHashMap@{'1':'自定义报表','2':'上报报表'}" name="cellTemplate.templateType" cssStyle="width:150px;" onchange="changeType(this.value)"></s:select>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						报表说明
					</TD>
					<TD class="ListTableTr2" align="left" colspan="3">
						<s:textarea rows="4" cols="30" name="cellTemplate.remark" cssStyle="height:50px;"></s:textarea>
					</TD>
				</TR>
			</TABLE>
			<br>
			<div align="center">
				<s:button value="保存" onclick="saveForm()"></s:button>
				<s:button value="返回" onclick="history.go(-1)"></s:button>
			</div>
			<s:hidden name="cellTemplate.id"/>
			<s:hidden name="cellTemplate.creator"></s:hidden>
			<s:hidden name="cellTemplate.createDate"></s:hidden>
		</s:form>
	</body>
</html>
