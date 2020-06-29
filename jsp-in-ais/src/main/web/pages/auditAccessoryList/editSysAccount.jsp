<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>创建临时账号</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>   
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		  
		<script type="text/javascript">
			$(function(){
				var returnValue='${audit_objects_name}'.split(",");
				var returnValue2='${audit_objects}'.split(",");
				var productStra = $("#auditObjectList");
				//var option = "<option value=""></option>";
				for(var i=0;i<returnValue2.length;i++){
					var option="";
					 option = $("<option>").text(returnValue[i]).val(returnValue2[i]);
					 productStra.append(option);
					
				}										
			});
			function saveForm(){
				if(!frmCheck(document.forms[0], 'tab1')){
					return;
				}
				if(!emailValidate("email")){
					return;
				}
				if('${sysAccount.userCode}'==null || '${sysAccount.userCode}'==''){
					if(!validateRepeat())
						return;
				}
				if($("#auditObjectList").find("option:selected").val()==null||$("#auditObjectList").find("option:selected").val()==''){
					window.parent.$.messager.show({
						title:'消息',
						msg:'被审计单位不能为空！'
					});
					return;
				}else{
					$("#audit_object").val($("#auditObjectList").find("option:selected").val());
					$("#audit_object_name").val($("#auditObjectList").find("option:selected").text());
				}
				$.ajax({
					type : "POST",
					url : "${contextPath}/auditAccessoryList/saveSysAccount.action",
					dataType:"text",
					data : $("#tempForm").serialize(),
					success : function(msg) {
						if('suc'==msg){
							window.parent.$.messager.show({
								title:'消息',
								msg:'保存成功！'
							});
							parent.closeWinUI();
						}
					}
				});	                				
				
			}
			function validateRepeat(){
				var flag = false;
				var userCode = document.getElementById("saveSysAccount_sysAccount_userCode").value;
				var name = document.getElementById("saveSysAccount_sysAccount_name").value;
				var loginname = document.getElementById("saveSysAccount_sysAccount_loginname").value;
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/auditAccessoryList', action:'validateSysAccount', executeResult:'false' }, 
				{ 'userCode':userCode,'name':name,'loginname':loginname },callbackFun);
			    function callbackFun(data){
			     	var hasRepeat = data['message'];
			     	if( hasRepeat!= null && hasRepeat != ''){
				     	alert(hasRepeat);
			     		flag = false;
			     	}else{
			     		flag = true;
			     	}
				}
			    DWREngine.setAsync(true);
				return flag;
			}
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<s:form id="tempForm" action="saveSysAccount" namespace="/auditAccessoryList"
			name="editForm">
			<div region="center">
			<TABLE id="tab1" class="ListTable">
				<TR>
					<TD class="EditHead" width="10%">
						<s:if test="${empty(sysAccount.userCode)}">
							<FONT color=red>*</FONT>&nbsp;
						</s:if>
						编码
					</TD>
					<TD class="editTd">
						<s:if test="${empty(sysAccount.userCode)}">
							<s:textfield name="sysAccount.userCode"
								id="saveSysAccount_sysAccount_userCode" size="37" title="编号"
								maxlength="32" />
						</s:if>
						<s:else>
							<s:property value="sysAccount.userCode" />
							<s:hidden name="sysAccount.userCode" />
						</s:else>
					</TD>
					<TD class="EditHead">
					<s:if test="${empty(sysAccount.loginname)}">
							<FONT color=red>*</FONT>&nbsp;
						</s:if>
						登录账号
					</TD>
					<TD class="editTd">
						<s:if test="${empty(sysAccount.loginname)}">
							<s:textfield name="sysAccount.loginname"
								id="saveSysAccount_sysAccount_loginname" size="37" title="登录账号"
								maxlength="255" />
						</s:if>
						<s:else>
							<s:property value="sysAccount.loginname" />
							<s:hidden name="sysAccount.loginname" />
						</s:else>
					</TD>
				</TR>
				<TR>
					<TD class="EditHead">
						<FONT color=red>*</FONT>&nbsp;姓名
						
					</TD>
					<TD class="editTd" width="35%" align="left">
						<s:textfield name="sysAccount.name"
							id="saveSysAccount_sysAccount_name"  title="姓名" cssClass="noborder"
							maxlength="20" />
					</TD>
					<TD class="EditHead">
						<FONT color=red>*</FONT>&nbsp;密码
						
					</TD>
					<TD class="editTd" width="35%" align="left">
						<s:password name="sysAccount.password"  title="密码" cssClass="noborder"
						 showPassword="true" maxlength="255"></s:password>
					</TD>
				</TR>
				<TR>
					<TD class="EditHead">
						E-mail
					</TD>
					<TD class="editTd">
						<s:textfield name="sysAccount.email" id="email" cssClass="noborder"
							title="电子邮件" maxlength="255" />
					</TD>
					<TD class="EditHead" width="10%">
						<FONT color=red>*</FONT>&nbsp;被审计单位
						
					</TD>
					<TD class="editTd">
						<select id="auditObjectList" name="auditObjectList" style="width:160px;"></select>							
					</TD>
				</TR>
			</TABLE>
			</div>
			<div region="south" border="false" style="text-align:right;padding-right:20px;">
				<div style="display: inline;" align="right">
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>
					&nbsp;&nbsp;
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="parent.closeWinUI();">关闭</a>
				</div>
			</div>
			<s:hidden name="sysAccount.projectId" value="${projectId}" />
			<s:hidden name="sysAccount.id" />
			<s:hidden name="sysAccount.userId" />
			<s:hidden name="sysAccount.createId" />
			<s:hidden name="sysAccount.createName" />
			<s:hidden name="sysAccount.auditDeptId" />
			<input type="hidden" name="sysAccount.audit_object" id="audit_object"/>
			<input type="hidden" name="sysAccount.audit_object_name" id="audit_object_name"/>
			<s:hidden name="sysAccount.sendMsgTime" />
			<s:hidden name="projectId" />
		</s:form>
	</body>
</html>
