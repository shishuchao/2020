<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="_self">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目小组成员</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<s:head theme="ajax" />
	</head>
  <body>
  	<s:form id="memberForm" action="saveMember" namespace="/project/members"> 
  		<s:hidden name="projectFormId"/>
  		<s:hidden name="proMemberId"/>
  		<s:hidden name="addMemberOption"/>
  		<s:hidden id="zhengTiGroupId" name="group.groupId"/>
  		<s:hidden name="proMember.isOutSystem" value="Y"/>
		<table id="projectMemberTable" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					所属小组：
				</td>
				<td class="ListTableTr22">
					<s:select id="groupId" name="proMember.group.groupId"
						list="groupUserCanModifyUsers"
						listKey="groupId" listValue="groupName"
						disabled="false" theme="ufaud_simple"
						templateDir="/strutsTemplate" />
				</td>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					用户名称：
				</td>
				<td class="ListTableTr22">
					<s:textfield id="userName" name="proMember.userName" maxlength="10" title="用户名称"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					系统账号：
				</td>
				<td class="ListTableTr22">
					<s:textfield id="userId" name="proMember.userId" maxlength="15" />
				</td>
				<td class="ListTableTr11" nowrap>
					<font color=red>*</font>
					密码：
				</td>
				<td class="ListTableTr22">
					<s:password name="outSystemMemberPassword" maxlength="25" />
				</td>
			</tr>
		</table>
		
		<div align="right" style="width: 96%;">
			<input id="saveButton" type="button" value="确定" onclick="this.style.disabled='disabled';toSave()"/>
			&nbsp;&nbsp;
			<input type="button" value="取消" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/project/members/listMembers.action?projectFormId=${projectFormId}'"/>
		</div>
	</s:form>
	
	<script type="text/javascript">
	
		function toSave(){
			document.getElementById('saveButton').disabled=true;
			var memberForm = document.getElementById('memberForm');
			if(!frmCheck(document.forms[0],'projectMemberTable')){
				document.getElementById('saveButton').disabled=false;
				return false;
			}else if(isOutSystemMemberCanSave()){
				memberForm.submit();
			}else{
				document.getElementById('saveButton').disabled=false;
			}
		}
		
		/**
		* 是否可以保存外部用户
		*/
		function isOutSystemMemberCanSave(){
			
			var userId = document.getElementById('userId').value;
			var userName = document.getElementById('userName').value;
			
			var result = 'YES';
			var messages = '';
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/members', action:'isOutSystemMemberCanSave', executeResult:'false' }, 
				{'proMember.userId':userId,'proMember.userName':userName},
				xxx);
			function xxx(data){
				result = data['isOutSystemMemberCanSave'];
				messages = data['messages'];
			} 
			if(result=='YES'){
				return true;
			}else{
				alert(messages);
				return false;
			}
		}
		
	</script>
	
  </body>
</html>
