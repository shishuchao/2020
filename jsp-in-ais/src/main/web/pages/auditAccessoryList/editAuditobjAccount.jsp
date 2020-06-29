<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>创建被审计单位反馈账号</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>   
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>

		<script type="text/javascript">
			$(function(){
				if('${rV}'=='suc'){
					window.parent.$.messager.show({
						title:'消息',
						msg:'保存成功！'
					});
					parent.closeWinUI();
				}
			});
			function saveForm(){
				if (!emptyValidate('pwd', '密码')) {
					return;
				}
				if (!emptyValidate('email', 'E-mail')) {
					return;
				}

				if(!frmCheck(document.forms[0], 'tab1')){
					return;
				}
				if(!emailValidate("email")){
					return;
				}
				if(!validateRepeat()){
					return;
				}
/*				if('${sysAccount.userCode}'==null || '${sysAccount.userCode}'==''){
					if(!validateRepeat())
						return;
				}*/
				var tempForm = document.getElementById('tempForm');
				tempForm.submit();
			}
			function validateRepeat(){
				var flag = false;
				var userCode = document.getElementById("saveSysAccount_sysAccount_userCode").value;
				var name = document.getElementById("saveSysAccount_sysAccount_name").value;
				var loginname = document.getElementById("saveSysAccount_sysAccount_loginname").value;
				var sysAccount_userId = $('#sysAccount_userId').val();
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/auditAccessoryList', action:'validateSysAccount', executeResult:'false' },
						{ 'userCode':userCode,'name':name,'loginname':loginname,'userId':sysAccount_userId},callbackFun);
				function callbackFun(data){
					var hasRepeat = data['message'];
					if( hasRepeat!= null && hasRepeat != ''){
						//alert(hasRepeat);
						$.messager.confirm('提示信息', hasRepeat+' 是否重新生成？', function(r){
							if(r){
								updateUserCode();
							}
						});
						flag = false;
					}else{
						flag = true;
					}
				}
				DWREngine.setAsync(true);
				return flag;
			}

			function updateUserCode() {
				$.ajax({
					type: "GET",
					url: '<%=request.getContextPath()%>/auditAccessoryList/getNewUserCode.action',
					cache: false,
					dataType: "text",
					success: function(data){
						var newCode = data;
						if(newCode != null && newCode != ''){
							$("#saveSysAccount_sysAccount_userCode").val(newCode);
							$("#saveSysAccount_sysAccount_loginname").val(newCode);
						}
					}
				});
			}

			function emptyValidate(target, title) {
				var pwd = $('#' + target).val();
				if (pwd == null || pwd == '') {
					showMessage1(title + '不能为空！');
					return false;
				}
				return true;
			}
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<s:form id="tempForm" action="saveAuditobjAccount" namespace="/auditAccessoryList" name="editForm">
			<div region="center">
				<div style="text-align:right;padding-top:5px;">
					<s:if test="${view != 'view' }">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm()" id="save_id">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</s:if>
				</div>
				<TABLE id="tab1" class="ListTable">
					<TR>
						<TD class="EditHead" width="15%">
							编码(自动生成）
						</TD>
						<TD class="editTd">
							<s:textfield name="sysAccount.userCode" id="saveSysAccount_sysAccount_userCode" cssClass="noborder" title="编号" maxlength="32" readonly="true"/>
						</TD>
						<TD class="EditHead">
							用户名称
						</TD>
						<TD class="editTd" width="35%" align="left">
							<s:textfield name="sysAccount.name" id="saveSysAccount_sysAccount_name" title="用户名称" cssClass="noborder" maxlength="20"/>
						</TD>
					</TR>
					<TR>
						<TD class="EditHead">
							系统账号(自动生成)
						</TD>
						<TD class="editTd">
							<s:textfield name="sysAccount.loginname" id="saveSysAccount_sysAccount_loginname" cssClass="noborder" title="系统账号" maxlength="255" readonly="true"/>
						</TD>
						<TD class="EditHead">
							<s:if test="${view != 'view'}">
								<FONT color=red>*</FONT>&nbsp;
							</s:if>
							密码
						</TD>
						<TD class="editTd" width="35%" align="left">
							<s:password id="pwd" name="sysAccount.password"  title="密码" cssClass="noborder" showPassword="true" maxlength="255"/>
						</TD>
					</TR>
					<TR>
						<TD class="EditHead">
							电话
						</TD>
						<TD class="editTd">
							<s:if test="${view == 'view'}">
								<s:property value="sysAccount.phone" />
							</s:if>
							<s:else>
								<s:textfield name="sysAccount.phone" id="phone" cssClass="noborder"
								title="电话"/>
							</s:else>
						</TD>
						<TD class="EditHead" width="10%">
							手机
						</TD>
						<TD class="editTd">
							<s:if test="${view == 'view'}">
								<s:property value="sysAccount.mobile" />
							</s:if>
							<s:else>
								<s:textfield name="sysAccount.mobile" id="mobile" cssClass="noborder"
								title="手机" maxlength="11" />
							</s:else>
						</TD>
					</TR>
					<TR>
						<TD class="EditHead">
							<s:if test="${view != 'view'}">
								<FONT color=red>*</FONT>&nbsp;
							</s:if>
							E-mail
						</TD>
						<TD class="editTd" colspan="3">
							<s:if test="${view == 'view'}">
								<s:property value="sysAccount.email" />
							</s:if>
							<s:else>
								<s:textfield name="sysAccount.email" id="email" cssClass="noborder" title="电子邮件" maxlength="255" />
							</s:else>
						</TD>
					</TR>
				</TABLE>
			</div>
            <s:hidden name="sysAccount.projectId" value="${projectId}"/>
            <s:hidden name="sysAccount.id"/>
            <s:hidden name="sysAccount.userId" id="sysAccount_userId"/>
            <s:hidden name="sysAccount.createId"/>
            <s:hidden name="sysAccount.createName"/>
            <s:hidden name="sysAccount.auditDeptId"/>
            <s:hidden name="sysAccount.auditDeptName"/>
            <s:hidden name="sysAccount.audit_object"/>
            <s:hidden name="sysAccount.audit_object_name"/>
            <s:hidden name="sysAccount.sendMsgTime"/>
            <s:hidden name="projectId"/>
		</s:form>
	</body>
</html>
