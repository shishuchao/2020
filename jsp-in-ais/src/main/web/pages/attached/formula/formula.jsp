<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新自动审计报告公式</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
</head>
<body>
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable" width="100%" align="center">
		<tr class="listtablehead">
			<td colspan="4" class="edithead"
				style="text-align: left; width: 100%;"><s:property
					escape="false"
					value="@ais.framework.util.NavigationUtil@getNavigation('/ais/attached/formula/reportAttachedFormula.action')" />
			</td>
		</tr>
	</table>
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable" align="center" style="width: 80%;">
		<tr class="listtablehead">
			<td class="listtabletr11">
				<div align="center">
					<font size="4">公式列表</font>
				</div> 
				<s:select id="attachedFormulaList" name="attachedFormula.formulaid" cssStyle="width:200px;height:500px;" 
						list="attachedFormulaList" listKey="formulaid" listValue="formulaname" 
						theme="ufaud_simple" 
						templateDir="/strutsTemplate" multiple="true" ondblclick="editFormula()" />
			</td>
			<td class="listtabletr22">
				<div id="buttonDiv" align="center">
					<input type="button" style="width:100px;" value="新建" onclick="newFormula()">
						<input type="button" style="width:100px;" value="保存" onclick="saveFormula()">
						<input type="button" style="width:100px;" value="删除" onclick="deleteFormula()">
					<!-- <button style="width: 100px;" onclick="newFormula()">新建</button>
					<button style="width: 100px;" onclick="saveFormula()">保存</button>
					<button style="width: 100px;" onclick="deleteFormula()">删除</button> -->
				</div> <iframe id="attachedFormulaFrame" src="" frameborder="0" width="100%"
					height="500" scrolling="no"></iframe>
			</td>
		</tr>
	</table>
	<script type="text/javascript">
			
			/**
			*	编辑公式
			*/
			function editFormula(){
				var selectedValue = document.getElementById('attachedFormulaList').value;
				var editArea = document.getElementById('attachedFormulaFrame');
				editArea.src='/ais/attached/formula/editAttachedFormula.action?attachedFormula.formulaid='+selectedValue;
			}
			
			/**
			*	新建公式
			*/
			function newFormula(){
				var editArea = document.getElementById('attachedFormulaFrame');
				editArea.src='/ais/attached/formula/editAttachedFormula.action';
			}
			
			/**
			*	保存公式
			*/
			function saveFormula(){
				var editArea = document.getElementById('attachedFormulaFrame');
				//校验公式名称
				var formulaname = document.frames('attachedFormulaFrame').document.all.formulaname.value;
				var formulacode = document.frames('attachedFormulaFrame').document.all.formulacode.value;
				if(formulaname==null || formulaname==''){
					alert("公式名称不能为空！");
					return;
				}
				if(formulacode==null || formulacode==''){
					alert("公式编码不能为空！");
					return;
				}
				document.frames('attachedFormulaFrame').document.all.attachedFormulaForm.submit();
			}
			
			/**
			*	删除公式
			*/
			function deleteFormula(){
				
				af=document.getElementById("attachedFormulaList");
				var selectID = "";
				var selectName = "";
				for(var i=0;i<af.length;i++){
					if(af.options[i].selected){
						selectID += af.options[i].value+",";
						selectName +="["+af.options[i].text+"]";
					}		
				}
				if(window.confirm("确认删除" + selectName + "?")){
					window.location.href="${contextPath}/attached/formula/delAttachedFormula.action?formulaIdStr=" +selectID;
				}else {
					return false;
				}
			
			}
			
		</script>
</body>
</html>