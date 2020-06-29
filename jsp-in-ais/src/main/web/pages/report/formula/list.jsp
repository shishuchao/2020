<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>公式列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>	
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
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
		function editVal(){
			var cbxs = document.getElementsByName("formulas");
			var cbx_count = 0;
			var cbx_no = -1;
			var id = "";
			for(var i=0;i<cbxs.length;i++){
				if(cbxs[i].checked){
					cbx_count++;
					cbx_no = i;
					id = cbxs[i].value;
				}
			}
			if(cbx_count>1){
				alert("不能同时修改多个公式信息！");
				return false;
			}
			if(cbx_no==-1){
				alert("没有选择要修改的公式!");
				return false;
			}
			document.forms[0].action="edit.action?id="+id;
			document.forms[0].submit();
		}
		function delVal(){
			var cbxs = document.getElementsByName("formulas");
			var cbx_count = 0;
			var cbx_no = -1;
			var id = "";
			for(var i=0;i<cbxs.length;i++){
				if(cbxs[i].checked){
					cbx_count++;
					cbx_no = i;
					id = cbxs[i].value;
				}
			}
			if(cbx_count>1){
				alert("不能同时删除多个公式信息！");
				return false;
			}
			if(cbx_no==-1){
				alert("没有选择要删除的公式信息!");
				return false;
			}
			if( window.confirm('确认删除吗？')){
				document.forms[0].action="delete.action?id="+id;
				document.forms[0].submit();
			}
		}
		</script>
	</head>
	<body onload="loadForm()">
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<s:form namespace="/report/formula" action="list.action">
		<table id="searchTable" style="display: 'none'" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
			<tr class="listtablehead">
				<td align="left" class="listtabletr1">
					公式名称
				</td>
				<TD class="listtabletr1">
					<s:textfield name="formula.funName" size="30" maxlength="30"/>
				</TD>
				<TD align="center" class="listtabletr1">
					公式中文名称
				</TD>
				<TD class="listtabletr1">
					<s:textfield name="formula.cnName" size="30" maxlength="30"/>
				</TD>
			</tr>
			<tr class="listtablehead" align="right">
				<td colspan="6" align="right" class="listtabletr1">
					<div align="right">
						<s:submit value="查询"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<s:button value="重置" onclick="javascript:document.location='${contextPath}/report/formula/list.action?typeCode=${typeCode}&attributeCode=${attributeCode}'"></s:button>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</td>
			</tr>
		</table>
		<s:hidden name="typeCode"></s:hidden>
		<s:hidden name="attributeCode"></s:hidden>
		</s:form>
		<center>
			<display:table requestURI="${contextPath}/report/formula/list.action" name="result" id="row" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external" defaultorder="descending"
				class="its" >
				<c:if test="${attributeCode!=1}">
				<display:column title="选择" style="width:30px">
					<input type="checkbox" name="formulas" value="${row.id}">
				</display:column>
				</c:if>
				<display:column title="公式名称" headerClass="center" sortable="true" sortName="funName" style="height:23px">
					${row.funName}
				</display:column>
				<display:column property="cnName" title="中文名称" sortName="cnName" sortable="true" headerClass="center"/>
				<display:column property="rettype" title="返回类型" sortable="false" headerClass="center"/>
				<display:column property="typeName" title="公式分类" sortable="false" headerClass="center"/>
			</display:table>

			<br>
				<div align="right">
				<c:if test="${attributeCode!=1}">
				<input type="button" value="增加" onclick="javascript:document.location='${contextPath}/report/formula/edit.action?typeCode=${typeCode}&attributeCode=${attributeCode}'">
				&nbsp;&nbsp;
				<s:button onclick="delVal()" value="删除"/>
				&nbsp;&nbsp;
				<s:button onclick="editVal()" value="修改"/>
				&nbsp;&nbsp;
				<input type="button" onclick="checkall('formulas',true)" value="全选">
				&nbsp;&nbsp;
				<input type="button" onclick="checkback('formulas',false)" value="反选">
				&nbsp;&nbsp;
				</c:if>
			</div>
		</center>
	</body>
</html>
