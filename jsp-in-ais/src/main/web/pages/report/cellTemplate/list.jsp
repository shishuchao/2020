<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<html>
	<head>
		<title>报表模板</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>	
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<s:head theme="simple" />
		<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript">
		function loadForm(){
			var operateResult = document.getElementById("operateResult").value;
			if(operateResult=='true'){
			}else if(operateResult=='false'){
				alert("删除失败！");
			}
		}
		function editVal(){
			var cbxs = document.getElementsByName("cts");
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
				alert("不能同时修改多个报表信息！");
				return false;
			}
			if(cbx_no==-1){
				alert("没有选择要修改的报表!");
				return false;
			}
			document.location="edit.action?id="+id;
		}
		function delVal(){
			var cbxs = document.getElementsByName("cts");
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
				alert("不能同时删除多个报表信息！");
				return false;
			}
			if(cbx_no==-1){
				alert("没有选择要删除的报表信息!");
				return false;
			}
			if( window.confirm('确认删除吗？')){
				document.location="delete.action?id="+id;
			}
		}
		</script>
	</head>
	<body onload="loadForm()">
		<s:hidden name="operateResult" id="operateResult"></s:hidden>
		<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
							<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/ct/list.action')" />
					</td>
				</tr>
			</table>
		<center>
			<display:table requestURI="list.action" name="result" id="row" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}"
				class="its" >
				<display:column title="选择" style="text-align:center;width:30px">
					<s:if test="${row.id!='8abcd0902a3b2c9e012a3bb731170001'}">
						<input type="checkbox" name="cts" value="${row.id}">
					</s:if>
				</display:column>
				<display:column title="报表名称" property="templateName"  headerClass="center" sortable="true" style="text-align:center;height:23px">
				</display:column>
				<display:column property="creator" title="创建人" sortName="false" headerClass="center" style="text-align:center"/>
				<display:column title="创建日期" sortable="false" headerClass="center" style="text-align:center">
					${fn:substring(row.createDate, 0, 19)}
				</display:column>
				<display:column property="modifier" title="最后修改人" sortable="false" headerClass="center" style="text-align:center"/>
				<display:column title="最后修改日期" sortable="false" headerClass="center" style="text-align:center">
					${fn:substring(row.modifyDate, 0, 19)}
				</display:column>
				<display:column title="报表设计" style="text-align:center">
					<a href="sign.action?id=${row.id}" target="_blank">设计</a>
				</display:column>
			</display:table>

			<br>
				<div align="right">
				<input type="button" value="增加" onclick="javascript:document.location='edit.action'">
				&nbsp;&nbsp;
				<s:button onclick="delVal()" value="删除"/>
				&nbsp;&nbsp;
				<s:button onclick="editVal()" value="修改"/>
				&nbsp;&nbsp;
				<input type="button" onclick="checkall('cts',true)" value="全选">
				&nbsp;&nbsp;
				<input type="button" onclick="checkback('cts',false)" value="反选">
				&nbsp;&nbsp;
			</div>
		</center>
	</body>
</html>
