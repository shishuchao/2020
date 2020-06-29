<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="ais.framework.acegi.SecurityContextUtil" %>
<%@ page import="ais.framework.util.MyProperty" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8" />
<title>A7审计信息化平台</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<meta content="" name="description" />
<link rel="shortcut icon" type="icon" href="%>/images/displaytag/favicon.ico">
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
<style type="text/css">
.loginSubmit{
	width:178px;
	height:38px;
	position:absolute;
	top:40px;
}
.loginSubmitover{
	background:url(${smvc}/index/assets/global/img/a7/loginSubmit2.png) no-repeat;
}
.loginSubmitout{
	background:url(${smvc}/index/assets/global/img/a7/loginSubmit.png) no-repeat;
}
body{
	font:bold 14px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;
}
.loginInput{
	padding-left:70px;
	font-size:20px;
	width:300px;
	height:40px;
	border-top-width:0px;
	border-left-width:0px;
	border-right-width:0px;
}
</style>
</head>
<body class="easyui-layout" fit="true" style="background-color:white;overflow:hidden;">
	<div region="north" border="0" style="text-align:left;overflow:hidden;height:100px;">
		<div style="margin-left:49px;margin-top:32px;">	
			<img src="${smvc}/index/assets/global/img/a7/yonyou.png" alt="logo" style="width:150px;height:30px;"/>
		</div>
	</div>
	<div region="center" border="0" style="text-align:center;overflow:hidden;">
		<div class="easyui-layout" fit="true">
			<div region="north" border="0" style="text-align:center;overflow:hidden;height:100px;">
				<div style="padding:5px 0px 10px 5px;margin:5px 0px 0px 0px;">
					<c:choose>
						<c:when test="${param.ao eq '1'}">
							<img src="${smvc}/index/assets/global/img/a7/aotemp.png" style="width:676px;height:59px;"/>
						</c:when>
						<c:otherwise>
							<img src="${smvc}/index/assets/global/img/a7/aisplatform.png" style="width:676px;height:59px;"/>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
			<div id="loginCenterWrap" region="center" border="0" style="text-align:center;overflow:hidden;">
				<div style="background-color:#68b0f4;">	
					<img id="loginCenter" src="${smvc}/index/assets/global/img/a7/loginCenter.png" />
				</div>
			</div>
			<div region="south" border="0" 
				style="text-align:center;overflow:hidden;height:100px;margin-top:40px;">
				<form style='width:100%;text-align:center;margin-left:-50px;' id="busForm" method="post" action="/ais/j_acegi_security_check">
					<span>
						<span style='position:absolute;'>
							<img src="${smvc}/index/assets/global/img/a7/loginUser.png"/>
						</span>
						<span class="textFont">
							<input type='text'  name="j_username" id="j_username" class="loginInput editElement required" 
								title="用户名" placeholder="请输入您的用户名"/>
						</span>
					</span>
					&nbsp;&nbsp;
					<span>
						<span style='position:absolute;'>
							<img src="${smvc}/index/assets/global/img/a7/loginPass.png"/>
						</span>
						<span class="textFont">
							<input type='password' name="j_password" id="j_password" class="loginInput editElement required" 
								title="密码" placeholder="请输入您的密码"/>
						</span>
					</span>
					&nbsp;&nbsp;
					<span id='loginSubmit' class="loginSubmit loginSubmitout">
						<label style="position:relative;top:4px;color:white;font-size:20px;">请登录</label>
					</span>
				</form>
			</div>
		</div>
	</div>
	<div region="south" border="0" style="text-align:right;overflow:hidden;height:60px;">
		<div style="text-align:right;padding-right:26px;">		
			<img src="${smvc}/index/assets/global/img/a7/loginBottom.png"/>
		</div>
	</div>
</body>
<script>
$(function(){
	
	/*try{
		$.ajax({
			url:"<%=request.getContextPath()%>/portal/firstgateway/getSysParam.action", 
			type:'post',
			data:{
				'paramKey':'ais.login.title'
			},
			dataType:'json',
			success:function(data){
				if(data && data.paramVal){
					$('title').text(data.paramVal);
				}
			},
			error:function(){
			}
		});
	}catch(e){
		
	}*/
	
	
	$('#j_username').select().focus();
	$('#loginSubmit').bind('click', function(){		
		aud$loginSubmit();
	});	
    var contextPath = '${smvc}';
    var error = '${param.login_error}';
    if(error == '1'){
       alert("用户名或密码错误！或此用户已注销或冻结!");
       $('#j_username').select().focus();
    }
    document.onkeydown = function(e){
        var ev = document.all ? window.event : e;
        if(ev.keyCode == 13) {
        	aud$loginSubmit();
        }
    }
    
    function aud$setLoginCenter(){ 
    	window.setTimeout(function(){    		
		    var loginCenterWrapW = $('#loginCenterWrap').width();
		    var loginCenterWrapH = $('#loginCenterWrap').height();
		   
		    if(loginCenterWrapW < 1400){   	
			    $('#loginCenter').width(loginCenterWrapW);
			    $('#loginCenter').height(loginCenterWrapH);
		    }
		    $('#j_username,#j_password').bind('mouseover', function(){
		    	$(this).css("color", "#1d78ad");
		    }).bind("mouseout", function(){
		    	$(this).css("color", "#a9a9a9");
		    }).bind("focus", function(){
		    	$(this).css("color", "#4e4e4e");
		    });
		    
		    $('#loginSubmit').bind("mouseover", function(){
		    	$(this).addClass('loginSubmitover').removeClass('loginSubmitout');
		    }).bind('mouseout', function(){
		    	$(this).addClass('loginSubmitout').removeClass('loginSubmitover');
		    });
    	},200)
    }
    
    $(window).bind('resize', aud$setLoginCenter);
    aud$setLoginCenter();
});
function aud$loginSubmit(){
	var busForm = "busForm";
	try{		
		if(aud$validataLogin()){
			$('#j_password').val(RSAEncode($('#j_password').val()));
			$('#'+busForm).submit();
		}
	}catch(e){
		//alert(e.message)
	}
}
function aud$validataLogin(){
	var userNameStr = $('#j_username').val();
	if(!userNameStr){
		alert("用户名为空!");
		return false;
	}
	var passwordStr = $('#j_password').val();
	if(!passwordStr){
		alert("密码为空!")
		return false;
	}
	return true;
}
</script>
</html>