<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="false" %>
<%@ page import="ais.framework.acegi.SecurityContextUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<title>用户登录</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script> 
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<link href="css/style.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
		}
		-->
		</style>
		<script type="text/javascript">
			function fsubmit(obj){
                Login();
				if(<%=SecurityContextUtil.canLogin()%>){
					alert("当前登陆用户数已经达到最大限制，请稍后重试！窗口将自动关闭！");
					window.close();
				}
				chg64();
				obj.submit();
			}
			function freset(obj){
				obj.reset();
			}
			function init() {
				document.getElementById("j_username").select();
			}
			
			function guestLogin(){
				document.all.username.value='guest';
				document.all.password.value=encode64('admin');
				document.forms[0].submit();
			    return true;
			}
			
			function Login(){
				var username=document.all.username.value;
				var psw=document.all.password.value;
				var succ=true;
				if (username == ""){
					alert("请输入用户名！");
					document.all.username.focus();
					succ=false;
					return false;
				}else{
					if (psw == ""){
					   alert("请输入密码！");
					   document.all.password.focus();
					   succ=false;
					   return false;
					}else{
					   document.forms[0].submit();
					   return true;
					}
				}
			}
		
			function chg64(){
				document.getElementsByName("j_password")[0].value=encode64(document.getElementsByName("password2")[0].value);
				return true;
			}
			
		</script>
	</head>
	<body id="Mainbg">
				<form name="mainform" id="mainform" method="post" action="/ais/j_acegi_security_check">
					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:5%;">
					  <tr>
					    <td style="text-align:center;"><img src="/ais/resources/images/newimg/loginMain.jpg" width="100%"/></td>
					  </tr>
					 </table>
					<table border="0" width="100%" height="50" cellpadding="0" cellspacing="0">
							<tr>
								<td align="right" style="width: 60%">
								<label for="username">用户名：</label>
								<input class="required" id="j_username" name="j_username" size="20" tabindex="1" />
								&nbsp;&nbsp;<label for="password">密码：</label>
									<input class="required" type="password" id="password2" name="password2" size="20" tabindex="2"/>
									<input type="hidden" id="j_password" name="j_password" size="10" tabindex="2" />
									&nbsp;&nbsp;&nbsp;
								</td>
								<td align="left">
									<button type="button" onclick="javascript:fsubmit(document.mainform);" style="cursor:hand;border:0px;width:90px;height:24px; padding:0px;" tabindex="3" accesskey="1"><img src="/ais/resources/images/newimg/_btn01.jpg"/></button>
									&nbsp;&nbsp;
									<button type="reset" style="cursor:hand;border:0px;width:90px;height:24px; padding:0px;" tabindex="4" accesskey="c" ><img src="/ais/resources/images/newimg/_btn02.jpg"/></button>
								</td>
							</tr>
						</table>
						<img src="/ais/resources/images/newimg/logo.jpg" style="width:100%;border:0; height:10; cellpadding:0; cellspacing:0;"/>
				</form>
		<script type="text/javascript">
		$(document).ready(function(){
			if('${param.login_error}'=='1'){
				alert("用户名或密码错误！或此用户已注销或冻结!");
			}
			$("#j_username").focus();
			document.onkeydown = function(e){ 
			    var ev = document.all ? window.event : e;
			    if(ev.keyCode==13) {
			    	fsubmit(document.mainform);
			     }
			}
		});
		</script>
    </body>
</html>
