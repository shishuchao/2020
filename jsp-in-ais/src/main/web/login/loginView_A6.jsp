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
	<title>A6审计信息化平台</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<link href="${smvc}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
	<link href="${smvc}/index/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/layouts/layout4/css/layout.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/layouts/layout4/css/themes/light.min.css" rel="stylesheet" type="text/css"/>
	<link href="${smvc}/index/css/login.css" rel="stylesheet" type="text/css"/>

<body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid" style="background-color: #1c77ac; background-image: url('${smvc}/resources/images/login/light.png'); background-repeat: no-repeat; background-position: center top; overflow: hidden; min-width: 1000px;">
<div id="mainBody">
	<div id="cloud1" class="cloud"></div>
	<div id="cloud2" class="cloud"></div>
</div>
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top" style="background: none;border: none;">
	<div class="page-header-inner ">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<a><img src="${smvc}/index/assets/global/img/yonyou.png" alt="logo" class="logo-default" style="margin: 40px 30px 0;" width="340" height="40"/> </a>
		</div>
	</div>
</div>
<!-- END HEADER INNER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->
<!-- BEGIN CONTAINER -->
<div class="page-container">
	<div class="page-content">
		<div class="loginbody">
			<div class="portlet" style="margin-top:10%;">
				<div class="portlet-body">
					<form name="mainform" id="mainform" class="form-horizontal" method="post" action="/ais/j_acegi_security_check">
						<div class="form-body">
							<div class="form-group">
								<div class="col-md-12 text-center">
									<%--<img src="${smvc}/resources/images/login/sysname.png" width="870" height="100"/>--%>
										<img src="${smvc}/images/audittitle.png" style="width: 742px; height: 85px;"/>
								</div>
							</div>
							<div class="form-group" style="margin-top:100px;">
								<div class="col-md-12">
									<table  cellpadding="0" cellspacing="0" border="0" class="inputc inputpanel" style="margin-bottom: 20px;" align="center">
										<tr>
											<td width="20px"></td>
											<td height="70">
												<table cellpadding="0" cellspacing="0" border="0" class="inputc" id="usernameTable">
													<tr>
														<td>
															<div class="ipt_m1">
																<div class="ipt_m">
																	<div style="position:relative;padding-left:17px;padding-top:10px;position:relative;">
																		<div id="usernamelab" style="position:absolute;z-index:99999;" class="label" onclick="loginTipWordClick(this);">账号</div>
																		<div style="width:190px;;max-width:100%;height:22px;top:0px;left:0px;position:relative" id="$d_main_userid">
																			<div id="userid" style="position: relative; left: 0px; top: 0px; width: 100%; height: 100%;" title="">
																				<div id="userid_textdiv" class="text_div" style="position: relative; top: 0px; width: 186px; overflow: hidden;">
																					<div class="input_normal_left_bg"></div>
																						<div class="input_normal_center_div_bg" style="width: 180px;">
																							<input type="text" name="j_username" id="j_username" onkeyup="disappear('usernamelab')" onfocus="iptFocus(this,'usernameTable');loginTipWordClick(this);" onblur="iptBlur(this,'usernameTable')" class="input_normal_center_bg text_input" title="" style="width: 176px; height: 100%;">
																						</div>
																					<div class="input_normal_right_bg"></div>
																				</div>
																			</div>
																		</div>

																	</div>
																</div>
															</div>
														</td>
													</tr>
												</table>
											</td>
											<td  height="70">
												<table cellpadding="0" cellspacing="0" border="0" class="inputc" id="passTable">
													<tr>
														<td>
															<div class="ipt_m1">
																<div class="ipt_m">
																	<div style="position:relative;padding-left:17px;padding-top:10px;position:relative;">
																		<div id="passwordlab" style="position:absolute;z-index:99999;" class="label" onclick="loginTipWordClick(this);">密码</div>
																		<div style="width:190px;;max-width:100%;height:22px;top:0px;left:0px;position:relative" id="$d_main_password">
																			<div style="position: relative; left: 0px; top: 0px; width: 100%; height: 100%;" title="">
																				<div class="text_div" style="position: relative; top: 0px; width: 186px; overflow: hidden;">
																					<div class="input_normal_left_bg"></div>
																					<div class="input_normal_center_div_bg" style="width: 180px;">
																						<input type="password" name="password2" id="password2" onkeyup="disappear('passwordlab')" onfocus="iptFocus(this,'passTable');loginTipWordClick($('#passwordlab'));" onblur="iptBlur(this,'passTable')" class="input_normal_center_bg text_input" title="" style="width: 176px; height: 100%;">
																						<input type="hidden" name="j_password" id="j_password">
																					</div>
																					<div class="input_normal_right_bg"></div>
																				</div>
																			</div>
																		</div>

																	</div>
																</div>
															</div>
														</td>
													</tr>
												</table>
											</td>

											<td  width="120px">
												<div style="width:111px;;max-width:100%;height:36px;top:0px;left:0px;position:relative" class="login_button_div">
													<button class="btn_off" style="width: 100%;" onfocus="submitButtonStatus(this,'focus');" onblur="submitButtonStatus(this,'blur');" onclick="return fsubmit(document.mainform);">登 录</button>
												</div>

											</td>
											<td width="20px"></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>
	<div id="auditcopyright" style="color: #c1b7b7; position: absolute; width: 355px;font-size: 18pt; font-weight: bold; bottom: -20px;">北京用友审计软件有限公司 研制</div>
</div>
<script type="text/javascript">
    var contextPath = '${smvc}';
    var error = '${param.login_error}';
    var canLogin = '<%=SecurityContextUtil.canLogin()%>';
</script>
<!--[if lt IE 9]>
<script src="${smvc}/index/assets/global/plugins/respond.min.js"></script>
<script src="${smvc}/index/assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script src="${smvc}/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/1.4/jquery.min.js"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/scripts/app.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/layouts/layout4/scripts/layout.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script>
<script type="text/javascript">
/**
 * Created by xujun on 2017/8/8.
 */
var w_main = b_cloud = b_cloud1 = b_cloud2 = mainwidth = null;
var offset1 = 450;
var offset2 = 0;


$(function() {
    w_main = $("#mainBody");
    $body = $("body");
    b_cloud1 = $("#cloud1");
    b_cloud2 = $("#cloud2");
    mainwidth = w_main.outerWidth();
    /// 飘动
    setInterval(function flutter() {
        if (offset1 >= mainwidth) {
            offset1 = -580;
        }

        if (offset2 >= mainwidth) {
            offset2 = -580;
        }
        offset1 += 1.1;
        offset2 += 1;
        b_cloud1.css("background-position", offset1 + "px 100px")
        b_cloud2.css("background-position", offset2 + "px 460px")
    }, 70);
  
});

function openwindow(url,name,iWidth,iHeight){
	var url;                                 //转向网页的地址;
	var name;                           //网页名称，可为空;
	var iWidth;                          //弹出窗口的宽度;
	var iHeight;                        //弹出窗口的高度;
	var iTop = (window.screen.availHeight-iHeight)/2;       //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-iWidth)/2;           //获得窗口的水平位置;
	window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
}
function fsubmit(obj){
    var username = $('#j_username').val();
    var psw = $('#password2').val();

    if (username == ""){
        alert("请输入用户名！");
        $('#j_username').focus();
        return false;
    }else {
        if (psw == "") {
            alert("请输入密码！");
            $('#password2').focus();
            return false;
        }
    }
    // fixed by sunny 2019-04-13
	// 这里取消中化项目的ldap登录验证
    chgRsa();
    obj.submit();
    // fixed end
	<%--var aisLoginUsers = '<%=MyProperty.getProperties("aisLoginUsers")%>';--%>
    <%--if(aisLoginUsers != ''&&aisLoginUsers != 'null'){--%>
		<%--if(aisLoginUsers.indexOf(username+',') > -1 || username.indexOf('TEMP-') == 0){--%>
            <%--chg64();--%>
            <%--obj.submit();--%>
		<%--}else{--%>
            <%--return ldapAuth(username,psw);--%>
		<%--}--%>
	<%--}else{--%>
        <%--return ldapAuth(username,psw);--%>
	<%--}--%>
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

function chgRsa(){
    try {
        document.getElementsByName("j_password")[0].value = RSAEncode(document.getElementsByName("password2")[0].value);
        return true;
    } catch (e) { // for less IE9
        document.getElementsByName("j_password")[0].value = document.getElementsByName("password2")[0].value;
    }
    return false;
}

$(document).ready(function(){
    if(error =='1'){
        alert("用户名或密码错误！或此用户已注销或冻结!");
    }
    document.all.j_username.focus();
    document.onkeydown = function(e){
        var ev = document.all ? window.event : e;
        if(ev.keyCode==13) {
            fsubmit(document.mainform);
        }
    }
});


function iptFocus(obj,tableid){

    $(obj).removeClass('input_normal_center_bg');
    $(obj).addClass('input_highlight_center_bg');

    var parent = $(obj).parent();
    parent.removeClass();
    parent.addClass('input_highlight_center_div_bg');
    var left = parent.prev();
    var right = parent.next();

    left.removeClass();
    left.addClass('input_highlight_left_bg');
    right.removeClass();
    right.addClass('input_highlight_right_bg');
    $('#'+tableid).addClass("inputf");
}

function disappear(tableid) {
	$('#' + tableid).html('');
}

function iptBlur(obj,tableid){
    $(obj).removeClass('input_highlight_center_bg');
    $(obj).addClass('input_normal_center_bg');

    var parent = $(obj).parent();
    parent.removeClass();
    parent.addClass('input_normal_center_div_bg');
    var left = parent.prev();
    var right = parent.next();

    left.removeClass();
    left.addClass('input_normal_left_bg');
    right.removeClass();
    right.addClass('input_normal_right_bg');
    $('#'+tableid).removeClass("inputf");
}

/**
 * 自定义加载提示条
 */
function showLoginLoadingBar() {
    var btns = document.getElementById('submitBtn').getElementsByTagName("button");
    if(btns && btns.length > 0){
        btns[0].className = 'btn_loading';
    }
}

//点击输入框提示文字的处理，聚焦到输入框
function loginTipWordClick(obj){
    var oo = obj;
    if(typeof obj == 'input'){
        if($(obj).attr('id') == 'j_username'){
            oo = $('#usernamelab');
		}else if($(obj).attr('id') == 'password2'){
            oo = $('#passwordlab');
		}
	}
    var parentDiv = oo.parentNode;
    var inputs = parentDiv.getElementsByTagName("INPUT");
    if(inputs && inputs.length>0){
        inputs[0].focus();
        $(oo).html('');
    }
    //e = EventUtil.getEvent();
    //stopAll(e);
    //clearEventSimply(e);
    if(oo.id=="randimglab" && oo.style.left=="6px"){
        oo.style.fontSize="12px";
    }
}

function submitButtonStatus(obj,type){
    if(type === 'focus'){
        $(obj).removeClass('btn_off');
        $(obj).addClass('btn_on');
    }else if(type === 'blur'){
        $(obj).removeClass('btn_on');
        $(obj).addClass('btn_off');
    }

}

function ldapAuth(username,psw) {
    $.ajax({
		url:'${smvc}/ldap/auth',
		type:'post',
		data:{
		    'ldapuser':username,
			'ldappass':psw
        },
		async:false,
		success:function(ret){
		    if(ret == '1'){
		        window.location.href = '${smvc}/j_acegi_security_check?from=app&j_username='+username;
            }else if(ret == '2'){
		        alert('LDAP认证失败！');
            }
        }
	});
    return false;
}
var resize = function() {
    var windowWidth = $(window).width();
    var left = (windowWidth - 355) / 2;
    $("#auditcopyright").css("left", left + "px");
};

$(window).resize(resize);
resize();
</script>
</body>

</html>

