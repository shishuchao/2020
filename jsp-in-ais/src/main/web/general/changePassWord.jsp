<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>账号管理</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/base64_Encode_Decode.js"></script>
	<link href="${pageContext.request.contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript">
		$(function(){
			if( "${mess}" != null && "${mess}" != "" ){
				showMessage2("${mess}");
			}
			if( "${message}" != null && "${message}" != "" ){
				showMessage2("${message}");
			}
		});
		function checkForm(){			
			formType = document.getElementsByName('formType');
			for(var i=0;i<formType.length;i++) {
				if(formType[i].checked) {
					n = formType[i].value;
					break;
				}
			}
			if(n=='2'){
				if(!checkMailInfo()){//校验邮箱账号
					return;
				}
			}
			if(n=='1'){
				if (document.savePass.oldPass.value==""){
					showMessage1("请完整输入原来的密码，不能为空!");
					document.savePass.oldPass.focus();
					return false;
				}else if (document.savePass.newPass1.value==""){
					showMessage1("请完整输入新密码!");
					document.savePass.newPass1.focus();
					return false;
				}else if (document.savePass.newPass2.value==""){
					showMessage1("请完整输入验证密码!");
					document.savePass.newPass2.focus();
					return false;
				}else if(document.savePass.newPass1.value!=document.savePass.newPass2.value){
					showMessage1("2次密码不一致！");
					document.savePass.oldPass.focus();
					return false;
				}else if(document.savePass.newPass1.value==document.savePass.oldPass.value){
					showMessage1("新密码不能与旧密码相同！");
					document.savePass.oldPass.focus();
					return false;
				}
				<s:if test="${not empty(isPass) and isPass=='c'}">
					var tmp = $_name("newPass1").value;
					var temp = chk(tmp);
					if(temp!=''){
						showMessage2('密码'+temp);
						return false;
					}
				</s:if>
				<s:if test="${not empty(isOut) and isOut=='Y'}">
					var tmp = $_name("newPass1").value;
					var temp = chk(tmp);
					if(temp!=''){
						showMessage2('密码'+temp);
						return false;
					}
				</s:if>
				$_name("oldPass").value=encode64($_name("oldPass").value);
				$_name("newPass1").value=encode64($_name("newPass1").value);
				$_name("newPass2").value=encode64($_name("newPass2").value);
			}
			savePass.submit();
		}
		
		function chk(s){
			if (s.length<8) return '长度小于8位';
			//else if (s.length>15) return '长度大于15位';
			else if (! s.match(/[0-9]/)) return '没有数字';
			else if (! s.match(/[a-zA-Z]/)) return '没有字母';
			//返回空串表示合格
			else return '';
			}	
		
		function checkMailInfo(){
			var email = document.getElementById("userMail.email").value;
			if(email==null || email==''){
				showMessage1("邮箱账号不能为空！");
				return false;
			}
			if(!emailValidate("userMail.email")){//校验邮箱账号
				return false;
			}
			//邮箱密码不为空
			if(document.getElementsByName("userMail.emailPassword")[0].value==null || document.getElementsByName("userMail.emailPassword")[0].value==''){
				showMessage1("邮箱密码不能为空！");
				return false;
			}
			//smtp服务器
			if(document.getElementsByName("userMail.smtpHost")[0].value==null || document.getElementsByName("userMail.smtpHost")[0].value==''){
				showMessage1("SMTP服务器不能为空！");
				return false;
			}
			return true;
		}

		function chgFormType(vle){
			if(vle=='1'){
				pwdTb.style.display='block';
				emailTb.style.display='none';
				document.savePass.action="savePass.action";
				$('#formType1').checked=true;
				$('#formType2').checked=false;
				document.getElementById("flag").value='0';
			}else{
				pwdTb.style.display='none';
				emailTb.style.display='block';
				document.savePass.action="saveEmail.action";
                $('#formType1').checked=false;
                $('#formType2').checked=true;
				document.getElementById("flag").value='1';
			}
		}
		function sendValidate(){
			showMessage1();
		}
		function $_name(name){return document.getElementsByName(name)[0];}
		function docLoad(){
			chgFormType('1');
		//	chgFormType($('#formType1').val());
		}	
		/**重置**/
		function resetNew(){
			var resetFlag = document.getElementById("flag").value;
			if(resetFlag=='0'){
				document.getElementsByName("oldPass")[0].value="";
				document.getElementsByName("newPass1")[0].value="";
				document.getElementsByName("newPass2")[0].value="";
			}
			if(resetFlag=='1'){
				document.getElementsByName("userMail.email")[0].value="";
				document.getElementsByName("userMail.emailPassword")[0].value="";
				document.getElementsByName("userMail.smtpHost")[0].value="";
			}
		}
	</script>
	</head>
	<body onload="docLoad()" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center">
			<div style="width: 90%; margin-top: 25px; padding: 15px;">
				<%-- <font color="red"> ${mess} </font> --%>
				<s:form action="savePass.action" namespace="/general" method="post"
					name="savePass" theme="simple">
					<input type="radio" name="formType" id="formType1"
						checked="checked" value="1" style=""
						onclick="chgFormType(this.value)" />
					<label for="formType1">
						修改密码
					</label>
					<input type="radio" name="formType" id="formType2" value="2"
						style="" onclick="chgFormType(this.value)" />
					<label for="formType2">
						邮箱
					</label>
					<s:hidden id="flag" name="flag" value="0"></s:hidden>
					<s:hidden id="floginname_" name="floginname_" value="${user.floginname}"></s:hidden>
					<center>
						<table id="pwdTb" cellpadding=0 cellspacing=1 border=0
							bgcolor="#409cce" class="ListTable">
							<tr>
								<td class="EditHead" style="width:40%;">
									旧密码
								</td>
								<td class="editTd" style="width:60%;">
									<s:password name="oldPass" value="" cssStyle="width:160px;" cssClass="noborder"></s:password>
								</td>
							</tr>
							<tr>
								<td class="EditHead">
									新密码
								</td>
								<td class="editTd">
									<s:password name="newPass1" value="" cssStyle="width:160px;" cssClass="noborder"></s:password>
								</td>
							</tr>
							<tr>
								<td class="EditHead" nowrap="nowrap">
									确认新密码
								</td>
								<td class="editTd">
									<s:password name="newPass2" value="" cssStyle="width:160px;" cssClass="noborder"></s:password>
								</td>
							</tr>
						</table>
						<table id="emailTb" cellpadding=0 cellspacing=1 border=0
							bgcolor="#409cce" class="ListTable" style="display: none">
							<tr>
								<td class="EditHead" style="width:40%;">
									邮箱账号
								</td>
								<td class="editTd" style="width:60%;">
									<s:textfield name="userMail.email" id="userMail.email"
										cssStyle="width:160px;" cssClass="noborder"></s:textfield>
								</td>
							</tr>
							<tr>
								<td class="EditHead">
									邮箱密码
								</td>
								<td class="editTd">
									<s:password name="userMail.emailPassword" showPassword="true"
										cssStyle="width:160px;" cssClass="noborder"></s:password>
								</td>
							</tr>
							<tr>
								<td class="EditHead">
									SMTP服务器
								</td>
								<td class="editTd">
									<s:textfield name="userMail.smtpHost" cssStyle="width:160px;" cssClass="noborder"></s:textfield>
								</td>
							</tr>
						</table>
						<div>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="checkForm()">提交</a>&nbsp;&nbsp;
							<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetNew()">重置</a>
						</div>
					</center>
					<h1 align="center">
						<%-- <font color="red"> ${message} </font> --%>
					</h1>
				</s:form>
			</div>
		</div>
	</body>
</html>
