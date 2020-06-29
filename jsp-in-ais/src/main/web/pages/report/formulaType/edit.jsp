<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>编辑公式分类</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<s:head theme="simple" />
		<script type="text/javascript">
			function saveForm(){
				if(frmCheck(document.forms[0], 'tab1')&&validateRepeat()){
					document.forms[0].submit();
				}
			}
			function validateRepeat(){
				var flag = false;
				var typeCode = document.getElementById("save_formulaType_typeCode").value;
				if(typeCode==0||typeCode==1||typeCode==2||typeCode==3){
					alert("已存在相同的公式分类编码！");
					return false;
				}
				var typeName = document.getElementById("save_formulaType_typeName").value;
				var parentCode = document.getElementById("save_formulaType_parentCode").value;
				var id = document.getElementById("save_formulaType_id").value;
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/report/formulatype', action:'validateRepeat', executeResult:'false' }, 
				{ 'typeCode':typeCode,'typeName':typeName,'parentCode':parentCode, 'id':id },callbackFun);
			    function callbackFun(data){
			     	var hasRepeat = data['message'];
			     	if( hasRepeat!= null && hasRepeat != '0'){
				     	if(hasRepeat=='2'){
			     			alert("已存在相同的公式分类编码！");
				     	}else if(hasRepeat=='1'){
			     			alert("已存在相同的公式分类名称！");
					    }else if(hasRepeat=='3'){
						    alert("已存在相同的公式分类名称和编码！");
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
				}else if(operateResult=='true'){
					parent.leftTree.location.reload();
				}
			}
		</script>
	</head>
	<body onload="loadForm()">
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<s:form action="save" namespace="/report/formulatype" name="editForm">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						<s:if test="${empty(formulaType.id)}">
							新增公式分类
						</s:if>
						<s:else>
							修改公式分类
						</s:else>
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 width="10%" >
						公式分类编号
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr22 width="35%" align="left">
							<s:textfield name="formulaType.typeCode" size="37"  title="编号" maxlength="32"/>
					</TD>
					<TD class=ListTableTr1 width="10%" >
						公式分类名称
						<FONT color=red>*</FONT>
					</TD>
					<TD class="ListTableTr22" width="35%" align="left">
						<s:textfield name="formulaType.typeName" size="37" title="科目名称" maxlength="20" />
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
						<s:if test="${formulaType.parentCode=='1'}">
							系统公式
						</s:if>
						<s:elseif test="${formulaType.parentCode=='2'}">
							区域公式
						</s:elseif>
						<s:elseif test="${formulaType.parentCode=='3'}">
							单元格公式
						</s:elseif>
						<s:else>
							<s:property value="formulaType.parentName"/>
						</s:else>
					</TD>
				</TR>
			</TABLE>
			<br>
			<div align="center">
				<s:button value="保存" onclick="saveForm()"></s:button>
			</div>
			<s:hidden name="formulaType.id"/>
			<s:hidden name="formulaType.parentCode"></s:hidden>
			<s:if test="${formulaType.parentCode=='1'}">
				<s:hidden name="formulaType.parentName" value="系统公式"></s:hidden>
			</s:if>
			<s:elseif test="${formulaType.parentCode=='2'}">
				<s:hidden name="formulaType.parentName" value="区域公式"></s:hidden>
			</s:elseif>
			<s:elseif test="${formulaType.parentCode=='3'}">
				<s:hidden name="formulaType.parentName" value="单元格公式"></s:hidden>
			</s:elseif>
			<s:else>
				<s:hidden name="formulaType.parentName"></s:hidden>
			</s:else>
			<s:hidden name="formulaType.attributeCode"></s:hidden>
			<s:if test="${formulaType.attributeCode==1}">
				<s:hidden name="formulaType.attributeName" value="系统公式"></s:hidden>
			</s:if>
			<s:elseif test="${formulaType.attributeCode==2}">
				<s:hidden name="formulaType.attributeName" value="区域公式"></s:hidden>
			</s:elseif>
			<s:elseif test="${formulaType.attributeCode==3}">
				<s:hidden name="formulaType.attributeName" value="单元格公式"></s:hidden>
			</s:elseif>
			<s:else>
				<s:hidden name="formulaType.attributeName"></s:hidden>
			</s:else>
		</s:form>
	</body>
</html>
