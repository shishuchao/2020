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
				height: 120px;
			}
		</style>
		<s:head theme="simple" />
		<script type="text/javascript">
			function saveForm(){
				if(frmCheck(document.forms[0], 'tab1')&&validateRepeat() &&
					firstZM(document.getElementsByName("formula.funName")[0].value)
					&&inoutFirstZM()){
					document.forms[0].submit();
				}
			}
			function inoutFirstZM(){
				var flag =true;
				var inFlag=0;
				var inIndex=0;
				
				var outFlag=0;
				var outIndex=0;
				while(inFlag==0){
					if(document.getElementById("inParaName"+inIndex)!=null){
						if(!firstZM(document.getElementById("inParaName"+inIndex).value)){
							document.getElementById("inParaName"+inIndex).focus();
							flag=false;
							break;
						}
					}else{
						inFlag=1;
					}
					inIndex++;
				}
				while(outFlag==0 && flag){
					if(document.getElementById("outParaName"+outIndex)!=null){
						if(!firstZM(document.getElementById("outParaName"+outIndex).value)){
							document.getElementById("outParaName"+outIndex).focus();
							flag=false;
							break;
						}
					}else{
						outFlag=1;
					}
					outIndex++;
				}
				return flag;
			}
			function firstZM(s){
				if(s==null || s==''){
					alert("参数不能为空！");
					return false;
				}else{
					var patrn=/^[a-zA-Z]{1}/; 
					if (!patrn.test(s)){ 
						alert("必须首字母开头！");
						return false 
					}
				}
				return true; 	
			}
			function validateRepeat(){
				var flag = false;
				var funName = document.getElementById("save_formula_funName").value;
				var id = document.getElementById("save_formula_id").value;
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/report/formula', action:'validateRepeat', executeResult:'false' }, 
				{ 'funName':funName,'id':id },callbackFun);
			    function callbackFun(data){
			     	var hasRepeat = data['message'];
			     	if( hasRepeat!= null && hasRepeat != '0'){
				     	if(hasRepeat=='1'){
			     			alert("已存在相同的公式！");
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
			var inIndex = 0;
			var outIndex = 0;
			function insertParaRow(iTable,index){
				row=iTable.insertRow(iTable.rows.length);
				row.id=index;
				row.className="ListTableTr2";
				td1=row.insertCell();
				td1.setAttribute("nowrap","true");
				td1.innerHTML = "<a href=\"#\" onclick=\"removeParaRow('"+index+"')\" title=\"增加分录\">删除</a>";
				td1=row.insertCell();
				td1.setAttribute("nowrap","true");
				td1.innerHTML = "";
				td1=row.insertCell();
				td1.setAttribute("nowrap","true");
				td1=row.insertCell();
				td1.setAttribute("nowrap","true");
				td1=row.insertCell();
				td1.setAttribute("nowrap","true");
				return row;
			}
			function insertInParaRow(){
				var row1 = insertParaRow(inTable,"inRow"+inIndex);
				row1.children(1).innerHTML='<input type="text" id="inParaName'+inIndex+'" name="inParameters['+inIndex+'].paramName" size="20" maxlength="25" title="参数名称">'
				+'<input type=hidden name="inParameters['+inIndex+'].queryOrder" value="'+inIndex+'">';
				row1.children(2).innerHTML='<input type="text" id="inCnName'+inIndex+'" name="inParameters['+inIndex+'].cnName" size="20" maxlength="50" title="参数中文名">';
				row1.children(3).innerHTML='<select id="inDataType'+inIndex+'"  name="inParameters['+inIndex+'].dataType" title="参数类型">'
				+'<option value="1">String</option><option value="2">Double</option><option value="3">Integer</option>'
				+'<option value="4">Float</option><option value="4">Date</option></select>';
				
				row1.children(4).innerHTML='<input type="text" id="inRemark'+inIndex+'"  name="inParameters['+inIndex+'].remark" size="30" maxlength="250" title="参数说明">';
				inIndex++;
			}
			function insertOutParaRow(){
				var row1 = insertParaRow(outTable,"outRow"+outIndex);
				row1.children(1).innerHTML='<input type="text" id="outParaName'+outIndex+'" name="outParameters['+outIndex+'].paramName" size="20" maxlength="25" title="参数名称">'
				+'<input type=hidden name="outParameters['+outIndex+'].queryOrder" value="'+outIndex+'">';
				row1.children(2).innerHTML='<input type="text" id="outCnName'+outIndex+'" name="outParameters['+outIndex+'].cnName" size="20" maxlength="50" title="参数中文名">';
				row1.children(3).innerHTML='<select id="outDataType'+outIndex+'" name="outParameters['+outIndex+'].dataType" title="参数类型">'
				+'<option value="1">String</option><option value="2">Double</option><option value="3">Integer</option>'
				+'<option value="4">Float</option><option value="4">Date</option></select>';
				
				row1.children(4).innerHTML='<input type="text" id="outRemark'+outIndex+'"  name="outParameters['+outIndex+'].remark" size="30" maxlength="250" title="参数说明">';
				outIndex++;
			}
			function removeParaRow(id){
				var tr=document.getElementById(id);
				if(tr!=null)
					tr.parentNode.removeChild(tr);
			}
		</script>
	</head>
	<body onload="loadForm()">
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<s:form action="save" namespace="/report/formula" name="editForm">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
						<s:if test="${empty(formula.id)}">
							新增公式
						</s:if>
						<s:else>
							修改公式
						</s:else>
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 width="10%" align="right">
						公式名称
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="20%" align="left">
							<s:textfield name="formula.funName" size="20"  title="公式名称" maxlength="30"/>
					</TD>
					<TD class=ListTableTr1 width="12%" align="right">
						公式中文名
						<FONT color=red>*</FONT>
					</TD>
					<TD class="ListTableTr2" width="20%" align="left">
						<s:textfield name="formula.cnName" size="20" title="公式中文名" maxlength="25" />
					</TD>
					<TD class=ListTableTr1 width="10%" align="right">
						返回类型
						<FONT color=red>*</FONT>
					</TD>
					<TD class="ListTableTr2" align="left" width="20%">
						<s:select name="formula.rettype" list="#@java.util.LinkedHashMap@{'':'', 'String':'String', 'Double':'Double','Any':'Any'}" required="true"></s:select>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						输入参数
					</TD>
					<TD class="ListTableTr22" align="center" colspan="5">
					 <table id="inTable" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable width="100%">
					  	<tbody>
						  <tr align="center" class="ListTableTr2">
						    <td align="center" width="30"><a href="javascript:;" onclick="insertInParaRow();" title="增加参数">+</a></td>
						    <td align="center" width="20%">参数</td>
						    <td align="center" width="20%">参数名称</td>
						    <td align="center" width="20%">参数类型</td>
						    <td align="center">说明</td>
						  </tr>
						  <s:iterator value="inParameters" id="row" status="rowIndex">
						  	<tr align="center" class="ListTableTr2" id="inRowM${rowIndex.index}">
						  		<td>
						  			<s:hidden name="inParameters[${rowIndex.index}].queryOrder" value="${rowIndex.index}"></s:hidden>
						  			<a href="javascript:;" onclick="removeParaRow('inRowM${rowIndex.index}')" title="增加分录">删除</a>
						  			<script type="text/javascript">inIndex++;</script>
						  		</td>
						  		<td>
						  			<input type="text" id="inParaName${rowIndex.index}" name="inParameters[${rowIndex.index}].paramName" value="${paramName}" size="20" maxlength="25" title="参数名称">
						  		</td>
						  		<td>
						  			<input type="text" id="inCnName${rowIndex.index}" name="inParameters[${rowIndex.index}].cnName" value="${cnName }" size="20" maxlength="50" title="参数中文名">
						  		</td>
						  		<td>
						  			<s:select list="#@java.util.LinkedHashMap@{'1':'String','2':'Double','3':'Integer','4':'Float','5':'Date'}" 
						  			value="${dataType}" name="inParameters[${rowIndex.index}].dataType" title="参数类型" id="inDataType${rowIndex.index}">
						  			</s:select>
						  		</td>
						  		<td>
						  			<input type="text" id="inRemark${rowIndex.index}"  name="inParameters[${rowIndex.index}].remark" size="30" value="${remark}" maxlength="250" title="参数说明">
						  		</td>
						  	</tr>
						  </s:iterator>
  						</tbody>
 					 </table>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						输出参数
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<table id="outTable" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable width="100%">
						  	<tbody>
							  <tr align="center" class="ListTableTr2">
							    <td align="center" width="30"><a href="javascript:;" onclick="insertOutParaRow();" title="增加参数">+</a></td>
							    <td align="center" width="20%">参数</td>
							    <td align="center" width="20%">参数名称</td>
							    <td align="center" width="20%">参数类型</td>
							    <td align="center">说明</td>
							  </tr>
							  <s:iterator value="outParameters" id="row" status="rowIndex">
							  	<tr align="center" class="ListTableTr2" id="outRowM${rowIndex.index}">
							  		<td>
						  				<s:hidden name="outParameters[${rowIndex.index}].queryOrder" value="${rowIndex.index}"></s:hidden>
							  			<a href="javascript:;" onclick="removeParaRow('outRowM${rowIndex.index}')" title="增加分录">删除</a>
						  				<script type="text/javascript">outIndex++;</script>
							  		</td>
							  		<td>
							  			<input type="text" id="outParaName${rowIndex.index}" name="outParameters[${rowIndex.index}].paramName" value="${paramName}" size="20" maxlength="25" title="参数名称">
							  		</td>
							  		<td>
							  			<input type="text" id="outCnName${rowIndex.index}" name="outParameters[${rowIndex.index}].cnName" value="${cnName }" size="20" maxlength="50" title="参数中文名">
							  		</td>
							  		<td>
							  			<s:select list="#@java.util.LinkedHashMap@{'1':'String','2':'Double','3':'Integer','4':'Float','5':'Date'}" 
							  			value="${dataType}" name="outParameters[${rowIndex.index}].dataType" title="参数类型" id="outDataType${rowIndex.index}">
							  			</s:select>
							  		</td>
							  		<td>
							  			<input type="text" id="outRemark${rowIndex.index}"  name="outParameters[${rowIndex.index}].remark" value="${remark}" size="30" maxlength="250" title="参数说明">
							  		</td>
							  	</tr>
							  </s:iterator>
							 </tbody>
	 					 </table>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						公式内容
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:textarea rows="4" cols="36" name="formula.sql"></s:textarea>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 style="width: 120px">
						公式说明
					</TD>
					<TD class="ListTableTr2" align="left" colspan="5">
						<s:textarea rows="4" cols="30" name="formula.remark" cssStyle="height:50px;"></s:textarea>
					</TD>
				</TR>
			</TABLE>
			<br>
			<div align="center">
				<s:button value="保存" onclick="saveForm()"></s:button>
			</div>
			<s:hidden name="formula.id"/>
			<s:hidden name="formula.typeCode"></s:hidden>
			<s:if test="${formula.typeCode=='1'}">
				<s:hidden name="formula.typeName" value="系统公式"></s:hidden>
			</s:if>
			<s:elseif test="${formula.typeCode=='2'}">
				<s:hidden name="formula.typeName" value="区域公式"></s:hidden>
			</s:elseif>
			<s:elseif test="${formula.typeCode=='3'}">
				<s:hidden name="formula.typeName" value="单元格公式"></s:hidden>
			</s:elseif>
			<s:else>
				<s:hidden name="formula.typeName"></s:hidden>
			</s:else>
			
			<s:hidden name="formula.attributeCode"></s:hidden>
			<s:if test="${formula.attributeCode==1}">
				<s:hidden name="formula.attributeName" value="系统公式"></s:hidden>
			</s:if>
			<s:elseif test="${formula.attributeCode==2}">
				<s:hidden name="formula.attributeName" value="区域公式"></s:hidden>
			</s:elseif>
			<s:elseif test="${formula.attributeCode==3}">
				<s:hidden name="formula.attributeName" value="单元格公式"></s:hidden>
			</s:elseif>
			<s:else>
				<s:hidden name="formula.attributeName"></s:hidden>
			</s:else>
		</s:form>
	</body>
</html>
