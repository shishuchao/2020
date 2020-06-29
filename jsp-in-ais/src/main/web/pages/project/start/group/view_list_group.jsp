<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="_self">
		<title>项目小组</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	</head>
	
  <body>
  	<s:form id="groupForm" action="saveGroup" namespace="/project"> 
  		<s:hidden name="crudId"/>
  		<s:hidden name="groupId"/>
  		<s:hidden name="group.groupType"/>
  		<s:hidden name="group.groupTypeName"/>
		<table id="projectGroupTable" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					分组名称：
				</td>
				<td class="ListTableTr22">
					<s:textfield id="groupName" name="group.groupName"
						maxlength="300" cssStyle="width:96%" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					被审计单位：
				</td>
				<td class="ListTableTr22">
					<s:checkboxlist name="group.auditObject" theme="ufaud_simple" templateDir="/strutsTemplate"
						list="auditObjects" 
						listKey="code" listValue="name" template="checkboxlist_by_string.ftl" value=""/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					分组说明：
				</td>
				<td class="ListTableTr22">
					<s:textfield id="description" name="group.description"
						maxlength="300" cssStyle="width:96%" />
				</td>
			</tr>
		</table>
		
		<div align="right" style="width: 96%;">
			<input type="button" value="确定" onclick="toSave()"/>
		</div>
	</s:form>
	
	<script type="text/javascript">
		function toSave(){
			var groupForm = document.getElementById('groupForm');
			var win = window.dialogArguments;
			var groupName = document.getElementById('groupName').value;
			var auditObject = document.getElementById('group.auditObject').value;
			var description = document.getElementById('description').value;
			if(groupName==''||auditObject==''||description==''){
				alert('请输入必填项目!');
				return false;
			}
			groupForm.submit();
		}
	</script>
	
  </body>
</html>















