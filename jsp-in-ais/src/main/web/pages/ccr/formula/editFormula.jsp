<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>编辑模板</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		</style>
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
				if(frmCheck(document.forms[0], 'tab1')){
					var status = document.getElementById('status').value;
					if(status == 'insert'){
						if(formulaValidation()){
							document.forms[0].submit();
							alert('保存成功！');
							parent.treefrm.location = '${contextPath}/ccrFormula/listFormula.action';
							window.location = '${contextPath}/ccrFormula/editFormula.action';
							
						}
					}else{
						document.forms[0].submit();
						alert('保存成功！');
						parent.treefrm.location = '${contextPath}/ccrFormula/listFormula.action';
						window.location = '${contextPath}/ccrFormula/editFormula.action';
					}
					
				}
			}
			function loadForm(){
				var operateResult = document.getElementById("operateResult").value;
				if(operateResult=='false'){
					alert("保存失败！");
				}
			}
			
			function typeChange(obj){
				var formulatype = obj.value ;
				var cordRow = document.getElementById('cordRow');
				if(formulatype == 0){
					cordRow.style.display='none';
				}
				if(formulatype == 1){
					cordRow.style.display='block';
				}
			}
			
			function isChn(obj){ 
				var reg = /^[\u4E00-\u9FA5]+$/; 
				if(obj.value!=""){
					if(!reg.test(obj.value)){ 
						alert("请输入中文"); 
						obj.focus();
					} 
				}
			} 
			
			function isEng(obj){
				if(obj.value!=""){
					var reg = RegExp("^[a-zA-Z]+$");
					if(!reg.test(obj.value)){
						alert("请输入英文"); 
						obj.focus();
					}
				}
			}
			
			function cOrdChange(obj){
				var cod = obj.value ;
				var unitRow = document.getElementById('unitRow');
				if(cod == 1){
					unitRow.style.display='block';
				}else{
					unitRow.style.display='none';
				}
			}
			
			function conditionChange(obj){
				var condition = obj.value;
				var conditionRow = document.getElementById('conditionRow');
				if(condition == 1){
					conditionRow.style.display='block';
				}else{
					conditionRow.style.display='none';
				}
			}
			
			function  formulaTypestatus(){
				var formulaType = ${formula.type};
				var cod = ${formula.cOrd};
				var condition = ${formula.conditions};
				
				var cordRow = document.getElementById('cordRow');
				if(0 == formulaType){
					cordRow.style.display='none';
				}
				
				var unitRow = document.getElementById('unitRow');
				if(cod == 1){
					unitRow.style.display='block';
				}else{
					unitRow.style.display='none';
				}
				
				var conditionRow = document.getElementById('conditionRow');
				if(condition == 1){
					conditionRow.style.display='block';
				}else{
					conditionRow.style.display='none';
				}
			}
			
			
			
			function formulaValidation(){
				var fname = document.getElementById('formulaName').value;
				var fnameCn = document.getElementById('formulaNameCn').value;
				var flag = false;
				
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/ccrFormula', action:'validator', executeResult:'false' }, 
				{ 'formulaName':fname,'formulaNameCn':fnameCn},
				xxx2);
			    function xxx2(data){
			    	if(data['message'] != null && data['message'] != ""){
			    		if(data['message'] == '1'){
			    			alert('英文名称已经存在');
			    		}
			    		if(data['message'] == '2'){
			    			alert('中文名称已经存在');
			    		}
			    		if(data['message'] == '0'){
			    			flag = true;
			    		}
			    	}
			    }
			    return flag;
			}
		</script>
	</head>
	<body onload="formulaTypestatus(); ">
		<s:form action="saveFormula" namespace="/ccrFormula" name="editForm">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
							公式编辑
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 align="right">
						中文名称：
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="15%" align="left" colspan="1">
						<s:if test="${empty(formula.id)}">
							<s:textfield id="formulaNameCn" name="formula.formulaNameCn" onblur="isChn(this)" size="20"  title="公式名称" maxlength="50" cssStyle="width:100%"/>
						</s:if>
						<s:else>
							<s:textfield id="formulaNameCn" name="formula.formulaNameCn" size="20"  readonly="true" title="公式名称" maxlength="50" cssStyle="width:100%"/>
						</s:else>
					</TD>
					<TD class=ListTableTr1 width="15%" align="right">
						英文名称：
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 align="left" width="25%" colspan="1">
						<s:if test="${empty(formula.id)}">
							<s:textfield id="formulaName" name="formula.formulaName" size="20" onblur="isEng(this)"  title="公式" maxlength="50" cssStyle="width:100%"/>
						</s:if>
						<s:else>
							<s:textfield id="formulaName" name="formula.formulaName" size="20"   title="公式" readonly="true" maxlength="50" cssStyle="width:100%"/>
						</s:else>
					</TD>
					<TD class=ListTableTr1 width="120" align="right">
						返回值类型
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 align="left" colspan="1">
						<s:radio  list="rettypeMap" name="formula.rettype" listKey="key" listValue="value" value="formula.rettype"></s:radio>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						报表类型
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:select name="formula.templateType" list="templateMap" listKey="key" listValue="value" value="formula.templateType"></s:select>
					</TD>
					<s:hidden name="formula.type" value="0"></s:hidden>
					<%--<TD class=ListTableTr1 style="width: 120px">
						公式类型
					</td>
					<TD class="ListTableTr2" align="left" colspan="2">
						<s:radio  list="formulaTypeMap" name="formula.type" listKey="key" listValue="value" value="formula.type" onclick="typeChange(this); "></s:radio>
					</td>
				--%></TR>
				<TR  id="cordRow">
				<TD class=ListTableTr1 style="width: 120px">
						所需汇总公式
					</TD>
					<TD class="ListTableTr2" align="left" colspan="2">
						<s:hidden id="compFormulaId" name="formula.compFormulaId"/>
						<s:textfield id="compFormula" name="formula.compFormula" size="20"  title="汇总对象" maxlength="50" cssStyle="width:100%" readonly="true"/>	
					</TD>
					<TD class=ListTableTr1 style="width: 120px">
						明细/本单位及所有子单位
					</TD>
					<TD class="ListTableTr2" align="left" colspan="2">
						<s:radio  list="compilTypeMap" name="formula.cOrd" listKey="key" listValue="value" value="formula.cOrd" onclick="cOrdChange(this); "></s:radio>	
					</TD>
				</TR>
				<tr id="unitRow">
					<TD class=ListTableTr1 style="width: 120px">
						单位名称
					</TD>
					<TD class=ListTableTr2 width="75%" align="left" colspan="5" >
							<s:buttonText name="formula.unitName" id="unitName"
							hiddenId="unitId" hiddenName="formula.unitId"
							cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=unitName&paraid=unitId&p_item=1&orgtype=0',300,250,'所属单位')"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							doubleDisabled="false" />
					</TD>
				</tr>
				<s:hidden name="formula.conditions" value="0"></s:hidden>
				<%--<tr>
					<TD class=ListTableTr1 style="width: 120px">
						有无特定条件
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:radio  list="conditionMap" name="formula.conditions" listKey="key" listValue="value" value="formula.conditions" onclick="conditionChange(this); "></s:radio>	
					</td>
				</tr>
				
				--%><tr id="conditionRow">
					<TD class=ListTableTr1 style="width: 80px">
						条件参照公式
					</TD>
					<TD class="ListTableTr2" align="left" colspan="1" style="width: 180px">
						<s:hidden id="conFormulaId" name="formula.conFormulaId"/>	
						<s:textfield id="conFormula" name="formula.conFormula" size="20"  title="参照公式" maxlength="50" cssStyle="width:100%" readonly="true"/>
					</td>
					<TD class=ListTableTr1 style="width: 60px">
						操作符
					</TD>
					<TD class="ListTableTr2" align="left" colspan="1" style="width: 180px">
						<s:select name="formula.operator" list="#@java.util.LinkedHashMap@{'=':'=', '>':'>', '<':'<', '<>':'<>'}" listKey="key" listValue="value" value="formula.templateType" cssStyle="width:100%"></s:select>
					</td>
					<TD class=ListTableTr1 style="width: 60px">
						参照值
					</TD>
					<TD class="ListTableTr2" align="left" colspan="1" style="width: 180px">
						<s:textfield id="comp" name="formula.comp" size="20"  title="参照值" maxlength="50" cssStyle="width:100%"/>
					</td>
				</tr>
				
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						公式说明
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:textarea rows="4" cols="30" name="formula.mark" cssStyle="height:50px; width:100%"></s:textarea>
					</TD>
				</TR>
				
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						公式参数
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:textarea rows="4" cols="30" name="formula.paras" cssStyle="height:50px; width:100%"></s:textarea>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						公式用法
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:textarea rows="4" cols="30" name="formula.usage" cssStyle="height:50px; width:100%"></s:textarea>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						公式示例
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:textarea rows="4" cols="30" name="formula.exam" cssStyle="height:50px; width:100%"></s:textarea>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						SQL
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:textarea rows="4" cols="30" name="formula.hql" cssStyle="height:50px; width:100%"></s:textarea>
					</TD>
				</TR>
				
			</TABLE>
			<br>
			<div align="center">
				<s:button value="保存" onclick="saveForm()"></s:button>
				<s:button value="返回" onclick="history.go(-1)"></s:button>
			</div>
			<s:hidden name="formulaId"/>
			<s:hidden name="formula.id"/>
			<s:hidden name="status" id="status"/>
		</s:form>
	</body>
</html>
