<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>添加群组</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
	</head>
	<body class="easyui-layout">
		<center>
			<div style="width:50%">
				<table id="planTable" cellpadding=0 cellspacing=0 border=0
					 class="ListTable">
					<s:form action="addGroup" namespace="/bpm/group" id="myFrom">
						<tr>
							<td class="EditHead">
								<font color="red">*</font>群组名称
							</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="model.name"  id="name" cssStyle="width:100%"></s:textfield>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								描述信息
							</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="model.description" cssStyle="width:100%"></s:textfield>
							</td>
						</tr>
						<s:hidden name="definition_id" value="%{#parameters.definitionId}"></s:hidden>
						<s:hidden name="model.id" />
						<s:hidden name="definitionId" value="%{#parameters.definitionId}"></s:hidden>
						<tr>
							<td class="EditHead" colspan="2">
								<center>
								<s:if test="'' == '${model.id}'">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="ToAdd('myForm')" >保存</a>
								</s:if><s:else>
									<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="ToAdd('myForm')" >保存</a>
								</s:else>
								
									<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"  onclick="history.go(-1)">返回</a>
								</center>
							</td>
						</tr>
					</s:form>
				</table>
			</div>
		</center>
	</body>
	<SCRIPT type="text/javascript">
		function validateForm(){
			var groupName=document.getElementById("name");
			if(groupName.value=="" || groupName==null)
			{
				top.$.messager.alert('提示信息','群组名称不能为空！','error');
				groupName.focus();
				return false;
			}else{
				return true;
			}
		}
		function ToAdd(formid){
			var name=document.getElementById("name").value;
			if(name ==''){
				top.$.messager.alert('提示信息','群组名称不能为空！','error');
			}else{
				document.getElementById('myFrom').submit();
			}
		}
	</SCRIPT>
</html>
