<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>编辑表单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		
	</head>

	<body class="easyui-layout">
		<center>
			<div style="width:50%;">
				<s:actionerror />
				<br>
				<table id="planTable" cellpadding=0 cellspacing=0 border=0
					class="ListTable">
					<s:form action="saveOrUpdate" namespace="/bpm/table" method="post" id="myForm">
						<s:token/>
						<tr>
							<td class="EditHead" style="width:20%">
								<font color=red>*</font>&nbsp;表单编码
							</td>
							<td class="editTd" style="width:80%">
								<s:textfield cssClass="noborder" name="bpmTable.code" cssStyle="width:180px;"></s:textfield>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								<font color=red>*</font>&nbsp;表单名称
							</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="bpmTable.name" cssStyle="width:180px;"></s:textfield>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								表单描述
							</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="bpmTable.description" cssStyle="width:180px;"></s:textfield>
							</td>
						</tr>
						<s:hidden name="bpmTable.id"></s:hidden>
						<tr>
							<td class="EditHead" colspan="2">
								<div style="float:right;padding-right:8px;">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="toSave()" >保存</a>
									<!--<s:submit value="保存" onclick="return validateTableName();"></s:submit>&nbsp;&nbsp;-->
									<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="javascript:window.location.href='<s:url action="list" includeParams="none"></s:url>'">返回</a>
								</div>
							</td>
						</tr>
					</s:form>
				</table>
			</div>
		</center>
	</body>
	<script type="text/javascript">
		function validateTableName()
		{
			var tableCode=document.getElementsByName("bpmTable.code")[0];
			var tablename=document.getElementsByName("bpmTable.name")[0];
			if(!new RegExp("^[a-zA-z]{1}[a-zA-z0-9_]*$").test(tableCode.value))
			{
				window.alert("表单编号必须以字母开头，且只能包含字母、数字、下划线！");
				tableCode.focus();
				return false;
			}
			else if(tablename.value=="")
			{
				window.alert("表单名称不能为空！");
				tablename.focus();
				return false;
			}
			return true;
		}
		function toSave(){
			if(validateTableName()){
				myForm.submit();
				showMessage1('保存成功');
			}
		}
	</script>
</html>
