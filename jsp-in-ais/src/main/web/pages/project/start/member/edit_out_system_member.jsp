<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目小组成员</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!-- <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" /> -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	  	<s:form id="memberForm" action="saveMember" namespace="/project">
			<div region="center">
		  		<s:token/> 
		  		<s:hidden name="crudId"/>
		  		<s:hidden name="proMemberId" id="proMemberId"/>
		  		<s:hidden name="addMemberOption"/>
		  		<s:hidden id="zhengTiGroupId" name="group.groupId"/>
		  		<s:hidden name="proMember.isOutSystem" value="Y"/>
				<table id="projectMemberTable" cellpadding="0" cellspacing="1" border="0" class="ListTable" align="center">
					<tr style="display:none">
						<td class="EditHead">
							<font color=red>*</font>
							所属小组
						</td>
						<td class="editTd">
							<select editable="false" class="easyui-combobox"
								name="proMember.group.groupId" id="groupId" panelHeight="auto"
								onchange="setProRole3()">
							       <!-- <option value="">&nbsp;</option> -->
							       <s:iterator value="crudObject.proMemberGroups" >
					       			<option  value="<s:property value="groupId"/>"><s:property value="groupName"/></option>
							       </s:iterator>
						    </select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<font color=red>*</font>
							用户名称
						</td>
						<td class="editTd">
							<s:textfield id="userName" name="proMember.userName" maxlength="10" title="用户名称" cssClass="noborder"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<font color=red>*</font>
							系统账号
						</td>
						<td class="editTd">
							<s:textfield id="userId" name="proMember.userId" maxlength="15" cssClass="noborder"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<font color=red>*</font>
							密码
						</td>
						<td class="editTd">
							<s:password name="outSystemMemberPassword" maxlength="25" cssClass="noborder"/>
						</td>
					</tr>
				</table>
			</div>
			<div region="south" border="false" style="text-align:right;padding-right:20px;">
				<div style="display: inline;" align="right">
					<a id="saveButton" class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="toSave()">保存</a>
					&nbsp;&nbsp;
					<a id="exitButton" class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="window.parent.closedlg(true);">取消</a>
				</div>
			</div>
		</s:form>
	
	<script type="text/javascript">
		function toSave(){
			$('#saveButton').linkbutton('disable');
			var memberForm = document.getElementById('memberForm');
			if(!frmCheck(document.forms[0],'projectMemberTable',window.parent)){
				$('#saveButton').linkbutton('enable');
				return false;
			}else if(isOutSystemMemberCanSave()){
				//memberForm.submit();
				//window.parent.closedlg();
				$('#memberForm').form('submit',{
	        		onSubmit:function(){
	            		return true; //当表单验证不通过的时候 必须要return false 
	            	},
			        success:function(result){
			        	window.parent.closedlg();
						window.parent.$.messager.show({
							title:'提示信息',
							msg:'保存成功！'
						});
			        }
			    });
			}else{
				$('#saveButton').linkbutton('enable');
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
			$.ajax({
				url:'${contextPath}/project/members/isOutSystemMemberCanSave.action',
				async:false,
				type:'post',
				data:{'proMember.userId':userId,'proMember.userName':userName,'proMember.proMemberId':'${proMemberId}'},
				success:function(data) {
					result = data['isOutSystemMemberCanSave'];
					messages = data['messages'];
				}
			});


			if(result=='YES'){
				return true;
			}else{
				window.parent.$.messager.show({
					title:'提示信息',
					msg:messages
				});
				return false;
			}
		}
	</script>
	
  </body>
</html>
