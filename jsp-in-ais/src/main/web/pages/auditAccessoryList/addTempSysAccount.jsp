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
		<link href="${contextPath}/styles/main/ais.css" " rel="stylesheet"
			type="text/css">
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<s:head theme="simple" />
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
					showMessage2("被审计单位不能为空!");
					return;
				}else{
					$("#audit_object").val($("#auditObjectList").find("option:selected").val());
					$("#audit_object_name").val($("#auditObjectList").find("option:selected").text());
				}	
				var formData=$("#myform").serialize();
				$.ajax({
					type : "POST",
					url : "${contextPath}/auditAccessoryList/addTempSysAccountFun.action",
					data : formData,
					success : function(msg) {
						window.dialogArguments.reloadwin();
						window.close();
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
				     	showMessage1(hasRepeat);
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
	<body >
		<s:form id="myform" action="" namespace="/auditAccessoryList"
			name="editForm">
			<table id="tableTitle" width="100%" border=0 cellPadding=0
				cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						创建临时帐号
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1
				bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class="listtabletr11" width="10%">
						<s:if test="${empty(sysAccount.userCode)}">
							<FONT color=red>*</FONT>&nbsp;
						</s:if>
						编码
					</TD>
					<TD class=ListTableTr22 width="35%" align="left">
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
					<TD class="listtabletr11" width="10%">
					<s:if test="${empty(sysAccount.loginname)}">
							<FONT color=red>*</FONT>&nbsp;
						</s:if>
						登录账号
					</TD>
					<TD class="ListTableTr22" width="35%" align="left">
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
					<TD class="listtabletr11" width="10%">
						<FONT color=red>*</FONT>&nbsp;姓名
						
					</TD>
					<TD class="ListTableTr22" width="35%" align="left">
						<s:textfield name="sysAccount.name"
							id="saveSysAccount_sysAccount_name"  title="姓名"
							maxlength="20" />
					</TD>
					<TD class="listtabletr11" width="10%">
						<FONT color=red>*</FONT>&nbsp;密码
						
					</TD>
					<TD class="ListTableTr22" width="35%" align="left">
						<s:password name="sysAccount.password"  title="密码"
							maxlength="255"></s:password>
					</TD>
				</TR>
				<TR>
					<TD class="listtabletr11" width="10%">
						E-mail
					</TD>
					<TD class="ListTableTr22" width="35%" align="left">
						<s:textfield name="sysAccount.email" id="email" 
							title="电子邮件" maxlength="255" />
					</TD>
					<TD class="listtabletr11" width="10%">
						<FONT color=red>*</FONT>&nbsp;被审计单位
						
					</TD>
					<TD class="ListTableTr22" width="35%" align="left">
						<select id="auditObjectList" name="auditObjectList" style="width:160px;"></select>							
					</TD>
				</TR>
			</TABLE>
			<br>
			<div style="text-align:right;padding-right:7px;">
				<s:button value="保存" onclick="saveForm()"></s:button>&nbsp;&nbsp;
			</div>
			<s:hidden name="sysAccount.projectId" value="${projectId}" />
			<s:hidden name="sysAccount.id" />
			<s:hidden name="sysAccount.userId" />
			<s:hidden name="sysAccount.createId" />
			<s:hidden name="sysAccount.createName" />
			<s:hidden name="sysAccount.auditDeptId" />
			<s:hidden name="sysAccount.auditDeptName" />
			<input type="hidden" name="sysAccount.audit_object" id="audit_object"/>
			<input type="hidden" name="sysAccount.audit_object_name" id="audit_object_name"/>		
			<s:hidden name="sysAccount.sendMsgTime" />
			<s:hidden name="projectId" />
		</s:form>
	</body>
</html>
