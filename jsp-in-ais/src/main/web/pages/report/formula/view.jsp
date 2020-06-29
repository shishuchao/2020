<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>查看公式分类</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>	
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<s:head theme="simple" />
		<script type="text/javascript">
		function loadForm(){
			var operateResult = document.getElementById("operateResult").value;
			if(operateResult=='true'){
				parent.leftTree.location.reload();
			}else if(operateResult=='false'){
				alert("删除失败！");
			}
		}
		function delFormulaType(typeCode,parentCode,attributeCode){
			if(validateChild(typeCode)){
				window.location='${contextPath}/report/formulatype/delete.action?typeCode='+typeCode+"&parentCode="+parentCode+"&attributeCode="+attributeCode;
			}else if(confirm("存在下级公式分类或下级公式，点击确定全部删除？")){
				window.location='${contextPath}/report/formulatype/delete.action?typeCode='+typeCode+"&parentCode="+parentCode+"&attributeCode="+attributeCode;
			}
		}
		function validateChild(typeCode){
			var flag = false;
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/report/formulatype', action:'validateChild', executeResult:'false' }, 
			{ 'typeCode':typeCode },callbackFun);
		    function callbackFun(data){
		     	var result = data['message'];
		     	if( result!= null && result >0){
		     		flag = false;
		     	}else{
		     		flag = true;
		     	}
			}
			return flag;
		}
		</script>
	</head>
	<body onload="loadForm()">
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					公式分类
				</td>
			</tr>
		</table>
		<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
			<TR>
				<TD class=ListTableTr1 width="10%" >
					公式分类编码
				</TD>
				<TD class=ListTableTr22 width="35%" align="left">
					<s:property value="formulaType.typeCode"/>
				</TD>
				<TD class=ListTableTr1 width="10%" >
					公式分类名称
				</TD>
				<TD class="ListTableTr22" width="35%" align="left">
					<s:property value="formulaType.typeName"/>
				</TD>
			</TR>
			<TR>
				<TD class=ListTableTr1 width="10%" >
					上级编码
				</TD>
				<TD class="ListTableTr22" width="35%" align="left">
					<s:property value="formulaType.parentCode"/>
				</TD>
				<TD class=ListTableTr1 width="10%" >
					上级名称
				</TD>
				<TD class="ListTableTr22" width="35%" align="left">
					<s:property value="formulaType.parentName"/>
				</TD>
			</tr>
		</TABLE>
		<br>
		<div align="center">
			<input type="button" value="增加本级" onclick="window.location='${contextPath}/report/formulatype/edit.action?parentCode=${formulaType.parentCode}&attributeCode=${formulaType.attributeCode }'">
			<input type="button" value="增加下级" onclick="window.location='${contextPath}/report/formulatype/edit.action?parentCode=${formulaType.typeCode}&attributeCode=${formulaType.attributeCode }'">
			<input type="button" value="删除" onclick="delFormulaType('${formulaType.typeCode}','${formulaType.parentCode}','${formulaType.attributeCode}')">
			<input type="button" value="修改" onclick="window.location='${contextPath}/report/formulatype/edit.action?id=${formulaType.id}'">
		</div>
	</body>
</html>
