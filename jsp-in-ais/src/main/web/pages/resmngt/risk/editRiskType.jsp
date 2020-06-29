<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>编辑风险分类</title>
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
				//if(frmCheck(document.forms[0], 'tab1')&&validateRepeat()){
					document.forms[0].submit();
				//}
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
	<body>
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<s:form action="saveType" namespace="/resmngt/riskType" name="editForm">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
							编辑风险分类
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 width="10%" >
						分类名称
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr22 width="35%" align="left">
							<s:textfield name="riskType.typeName" size="50"  title="分类名称" maxlength="25"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 width="10%" >
						上级分类
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr22 width="35%" align="left">
							<s:select list="result" listKey="id" listValue="typeName" name="parentId" emptyOption="true"></s:select>
					</TD>
				</TR>
			</TABLE>
			<br>
			<div align="center">
				<s:button value="保存" onclick="saveForm()"></s:button>
			</div>
			<s:hidden name="id"/>
		</s:form>
	</body>
</html>
