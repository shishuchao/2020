<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>模板列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript"
					src="${contextPath}/scripts/checkboxsoperation.js">
		</script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<SCRIPT type="text/javascript">
				function addTemplate(){
					window.location = '${contextPath}/ccrTemplate/editTemplate.action';
				}
		
				function modifyTemplate(){
					var cbxs = document.getElementsByName("ids");
					var cbx_count = 0;
					var cbx_no = -1;
					var id = "";
					var sta = "";
					for ( var i = 0; i < cbxs.length; i++) {
						if (cbxs[i].checked) {
							cbx_count++;
							cbx_no = i;
							id = cbxs[i].value;
						}
					}
					if (cbx_count > 1) {
						alert("不能同时修改多个信息！");
						return false;
					}
					if (cbx_no == -1) {
						alert("没有选择要修改的信息!");
						return false;
					}
					
					window.location = '${contextPath}/ccrTemplate/editTemplate.action?id=' + id;
				}
				function delTemplate(){
				
					var cbxs = document.getElementsByName("ids");
					var cbx_count = 0;
					var cbx_no = -1;
					var ids='';
					for ( var i = 0; i < cbxs.length; i++) {
						if (cbxs[i].checked) {
							cbx_count++;
							cbx_no = i;
							ids += '@' + cbxs[i].value;
						}
					}
					if (cbx_no == -1) {
						alert("没有选择要删除的信息!");
						return false;
					}
					if(window.confirm("确定要删除选中的记录吗？若删除，相应的报表将一并删除")){
						window.location = '${contextPath}/ccrTemplate/delTemplate.action?id=' + ids;
					}
				}
		</SCRIPT>
</head>
<body>
<center>
	<table id="tableTitle" width="100%" border=0 cellPadding=0
				cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
					
						报表模板
					
				</td>
			</tr>
	</table>
	<br/>
		<display:table requestURI="templateList.action" name="ccrTemplateList"
					id="row" pagesize="${baseHelper.pageSize}" partialList="true"
					size="${baseHelper.totalRows}" class="its">
			<display:column title="选择" style="text-align:center;width:30px" headerClass="center">
						<input type="checkbox" name="ids" value="${row.id}">
			</display:column>
			<display:column property="templateName" title="模板名称" sortable="true" sortName="false" headerClass="center" style="text-align:center" />
			<display:column property="creator" title="创建人" sortable="true" sortName="false" headerClass="center" style="text-align:center" />
			<display:column property="createDate" title="创建时间" sortable="true" sortName="false" headerClass="center" style="text-align:center" />
			<display:column  title="" sortable="false"
						sortName="false" headerClass="center" style="text-align:center" >
							<a href="cellTemplateMain.action?id=${row.id}" target="_blank">设计</a>
						</display:column>
					
		</display:table>
		</center>
			<br>
				<div align="right">
					<s:submit value="添加" onclick="addTemplate(); "></s:submit>
					&nbsp;&nbsp;
					<s:button value="修改" onclick="modifyTemplate(); "></s:button>
					&nbsp;&nbsp;
					
					<s:button value="删除" onclick="delTemplate(); "></s:button>
					&nbsp;&nbsp;
					
					<s:button value="全选" onclick="checkall('ids')"/>
						&nbsp;&nbsp;
						<s:button value="反选" onclick="checkback('ids')"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
</body>
</html>