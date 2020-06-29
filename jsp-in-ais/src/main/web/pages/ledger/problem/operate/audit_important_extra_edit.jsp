<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>选择审计重点内容</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/DWRAction.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
</head>
<body>
		<div id="divExtra">
			<div class="search_head">	
			<s:form id="extraForm" name="extraForm" action="selectExtra" namespace="/proledger/problem" method="post">
				<s:hidden name="project_id" value="${ project_id }"/>
				<s:hidden name="id" value="${ id }"/>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead" style="width:22%">审计重点内容</td>
						<td class="editTd" style="width:28%">
							<select id="importantContentName" class="easyui-combobox" panelHeight="auto" name="" style="width:100%;"  editable="false">
							   <s:iterator value="auditImportantMap" id="entry">
								 <option value="<s:property value='key'/>"><s:property value='value'/></option>
							   </s:iterator>
							</select> 
						</td>
						<td class="EditHead" style="width:22%">审计重点分类</td>
						<td class="editTd" style="width:28%">
						<select id="importantContentExtraId" class="easyui-combobox" name="importantContentExtraId" panelHeight="auto" style="width:100%;"  editable="false">
						   <s:iterator value="auditimportantExtraMap" id="entry">
							 <option value="<s:property value='key'/>"><s:property value='value'/></option>
						   </s:iterator>
						</select> 
						</td>
					</tr>
				</table>
			</s:form>
			</div>
			<div class="serch_foot" style="text-align:center;">
				<div class="search_btn" >
				<br />
					<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="doSubmit()">确定</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
		</div>
	<script type="text/javascript">
		function doSubmit(){
			$('#extraForm').action = "<%=request.getContextPath()%>/proledger/problem/selectExtra.action?project_id=<%=request.getAttribute("project_id")%>&id=${id}";
			$('#extraForm').submit();
			parent.$('#audit_important_content_extra').window('close');
			parent.window.location.reload();
		}
		
		function doCancel(){
			parent.$('#audit_important_content_extra').window('close');
		}
	</script>
</body>
</html>