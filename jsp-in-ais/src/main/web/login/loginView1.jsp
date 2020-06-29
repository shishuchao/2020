<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="false" %>
<%@ page import="ais.framework.acegi.SecurityContextUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html>
<head>
<title>用户登录</title>
<meta http-equiv="X-UA-Compatible" content="IE=8/9/10/11/Edge">
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/easyui/jquery.slideBox.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/easyui/scrollMulitiPic/css/lrtk.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script> 				
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.slideBox.min.js"></script>

<style>
*{
	font-size:12px;
	font-family:'微软雅黑';
}
div a:link {
	color: currentColor; 
	text-decoration:none;	
} 
div a:hover {
	color: blue; 	
}
::-webkit-input-placeholder { /* WebKit browsers */
    color:    #999;
}
:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
    color:    #999;
}
::-moz-placeholder { /* Mozilla Firefox 19+ */
    color:    #999;
}
:-ms-input-placeholder { /* Internet Explorer 10+ */
    color:    #999;
}
.loginWinWrap{
    width:360px;
    border:0px solid #cccccc; 
}
.loginWinInputWrap{
    width:320px;
    padding:20px ;
    text-align:center;
}
.loginWinBg{
    background-image:url(/ais/cloud/homeimg/loginAll.png);
    padding:2px 5px 2px 5px;
}
.loginWin_inputWrap{
    background-position:-349px -86px;
    width:320px;
    height:50px;
    border:0px solid #cccccc;
    padding:5px;
}
.loginWin_input{
    float:left;
    height:34px;
    line-height:34px;
    margin-top:0px;
    width:255px;
    padding:2px 5px 2px 5px;
    border-width:0px;
    font-size:15px;
}
.loginWin_userlogo{
    background-position:-865px -86px;
    width:30px;
    height:30px;
    float:left;
    margin:10px 0px 0px 5px;
}
.loginWin_passlogo{
    background-position:-905px -86px;
    width:30px;
    height:30px;
    float:left;
    margin:10px 0px 0px 5px;
}
.loginWin_loginSubmit{
    background-position:-14px -86px;
    width:320px;
    height:48px;
    border:0px solid #cccccc;
    padding:5px;
    cursor:pointer;
}
.loginWin_forgetPass{
    background-position:-720px -86px;
    width:70px;
    height:48px;
    border:0px solid #cccccc;
    padding:5px;
    float:left;
    cursor:pointer;
}
.loginWin_resetinput{
    background-position:-817px -86px;
    width:30px;
    height:48px;
    border:0px solid #cccccc;
    padding:5px;
    float:right;
    cursor:pointer;
}
.loginWin_bottom{
    background-color:#cccccc;
    background-repeat:repeat-x;
    width:350px;
    height:30px;
    border-width:0px;
    padding:5px;
}



.slideNew{
    background-image: url(/ais/cloud/homeimg/titleHot.png);
    background-repeat: no-repeat;
    width:400px;
    height:115px;
    border:1px solid #cccccc;
    overflow:hidden;
}

button,a:focus{  
	-moz-outline:none; 
	outline:none; 
	hidefocus:true;
} 

.topHot{
	font-family:'粗黑';
	color:'#bd1515';
}
.home_top{

}
.home_top_img{
	width:100%;
	height:150px;
	border-width:0px;
	paddign:0px;
	margin:0px;
}
.home_bottom{
	padding:2px;
	height:55px;
	text-align:center;
}
.bottom_txt{
	color:gray;
	text-align:center;
	line-height:19px;
	font-size:12px;
	padding:1px 10px 1px 1px;
}
.nowrap{
	display:inline;
}
.noscroll{
	overflow:hidden;
}
.txtleft{
	text-align:left;
}
.txtright{
	text-align:right;
}
.txtcenter{
	text-align:left;
}
.lightcolor{
	color:#cccccc;
}
.menulogo{
	float:left;
	width:60px;
}

.menulogo image{
	width:45px;
	height:45px;
	border-width:0px;
}
.menu_txt{
	position:relative;
	top:-15px;
	line-height:24px;
}
.menu_txt_over{
	position:relative;
	top:-14px;
	line-height:24px;
	font-size:12px;
}
</style>
<script type="text/javascript">
function setHeight(){
	$('body').layout('collapse','north');
	return;
	var c = $('body');
	var p = c.layout('panel','north');
	var oldHeight = p.panel('panel').outerHeight();
	p.panel('resize', {height:'auto'});
	var newHeight = p.panel('panel').outerHeight();
	//alert(c.height() + newHeight - oldHeight)
	c.layout('resize',{
		height: (c.height() + newHeight - oldHeight)
	});
}

//回车事件监听
$(document).keydown(function(e){
	if(e.keyCode==13){
		var loginWin= $("#loginFlag").val();
		if(loginWin == "1"){
			userLogin('userLoginForm','j_username','j_password');
		}else{
			userLogin('userLoginForm2','j_username','j_password');
		}
	}
	
});
// ajax用户登录
function userLogin(formId,usernameId,passwordId,isShowMsg){
	if(<%=SecurityContextUtil.canLogin()%>){
		$.messager.alert("提示信息","当前登陆用户数已经达到最大限制，请稍后重试！","error");
	}else{
		$('#'+formId).form('submit',{
			url:"<%=request.getContextPath()%>/j_acegi_security_check",
			onSubmit: function(param){
				var objs=[{'name':usernameId,'title':'用户名不能为空!'},
				          {'name':passwordId+"2",'title':'密码不能为空!'}];
				for(var i=0; i<objs.length; i++){
					var obj = objs[i];
					//alert($('#'+formId+' input[name="'+obj.name+'"]').val())
					if(!$('#'+formId+' input[name="'+obj.name+'"]').val()){
						alert(obj.title);
						$('#'+formId+' input[name="'+obj.name+'"]').focus();
						//$.messager.alert('提示信息',obj.title,'error',function(){
							//$('#'+formId+' input[name="'+obj.name+'"]').focus();
						//});
						return false;
					}
				}
				// 密码加密
				$('#'+formId+' input[name='+passwordId+']').val(encode64($('#'+formId+' input[name='+passwordId+'2]').val()));
				//alert($('#userLoginForm').serialize())
				return true;
			},
			success:function(data){
				var data = jQuery.parseJSON(data);
				if(data.msg && data.type == 'error'){
					
					alert(data.msg);
					$('#'+formId+' input[name='+usernameId+']').focus();
					
					//$.messager.alert('提示信息', data.msg, data.type ? data.type : 'info', function(){
					//	$('#'+formId+' input[name='+usernameId+']').focus();
					//});					
				}
				if(data.type == 'info'){
					if(data.username){
						$('#loginDiv').hide();
						$('#afterLoginDiv').show();
						$('#userLoginWin').window('close');
						$('#isUserLogin').val('1');
						//审计考核局欢迎您!
						$('#barMsg').html("<strong>"+data.username+"</strong>,&nbsp;&nbsp;欢迎您登陆系统!");
						$('#showUserName').html(data.username);
						$('#showUserDept').html(data.userdept);
						
						var url = $('#userLoginWin').data('openUrl');
						if(url){
							var udswin = window.open(url,'','width=800px,height=700px,toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			                udswin.moveTo(0,0);
			                udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
							$('#userLoginWin').removeData('openUrl');
						}
					}
				}
			},
			error:function(){
				$.messager.alert('提示信息','请求失败！请检查网络是否通畅或与管理员联系！','error');
			}
		});	 
	}
}


// 友情链接
function commonBlocks(blockId, links, hot){
	if(blockId == 'bulletinsDiv'){
		var content = links[0]==null?"无内容":links[0].content;
		content = content.length>100 ? content.substr(0,100)+'...' : content;
		$('#'+blockId).append("<div style='line-height:20px;'><a target='_blank' href='gateWayViewNews.jsp?id="+(links[0]==null?'':links[0].id)+"'>&nbsp;&nbsp;&nbsp;&nbsp;"+content+"</a></div>");
		return;
	}
	
	
	if(links && links.length > 0){
		var target = $('#'+blockId);
		$.each(links,function(i,link){
			if(i>7)return false;
			var div = document.createElement('div');
			var t = link.title;
			var title = t;
			if(t.length > 14){
				title = t.substr(0,13)+'...';
			}
			var linkey = blockId == 'linksDiv' ? link.infkey : 'gateWayViewNews.jsp?id='+link.id;
			var logopic = hot && i==0 ? '/ais/cloud/homeimg/hot.png' : '/ais/images/portal/pic/green.png';
			$(div).addClass('txtleft').attr({'style':'padding:5px 0px 4px 0px;float:left;clear:left;'})
			.append("<a href='"+linkey+"' title='"+t+"' target='_blank'><image style='border-width:0;' src='"+logopic+"'></image><span style='padding:2px 2px 5px 3px;'>"+title+"</span></a>");
			$(target).append(div);
		});
	}
}
//公司新闻及审计动态

function appendNewsAndTrends(news,trends){
    var html = "";
    for(var i = 0;i<news.length;i++) {
        html = html+'<li><a href=\"gateWayViewNews.jsp?id='+news[i].id+'\" target=\"_blank\" title=\"'+news[i].title+'\"><img src=\"'+news[i].image[0]+'\" style=\"width:1000px;height:200px;\"></a></li>';
    }
    $('#news').append(html);
    html = "";
    for(var i = 0;i<trends.length;i++) {
        html = html+'<li class=\"featureBox\"><div class=\"box\"><a name=\"da1\" href=\"gateWayViewNews.jsp?id=\"'+trends[i].id+' target=\"_blank\"><img src=\"'+trends[i].image[0]+'\" width=\"270\" height=\"150\"></a></div> </li>';
    }
    $('#trends').append(html);

}

// 页面初始化
$(function(){

	// 加载页面各个模块
	$.ajax({
		url:"<%=request.getContextPath()%>/portal/firstgateway/getLoginUser.action", 
		type:'post',
		dataType:'json',
		success:function(data){
			if(data.gateWayUsername){
				$('#showUserName').html(data.gateWayUsername);
				$('#showUserDept').html(data.gateWayUserdept);
				$('#isUserLogin').val('1');
				//审计考核局欢迎您!
				$('#barMsg').html("<strong>"+data.gateWayUsername+"</strong>,&nbsp;&nbsp;欢迎您登陆系统!");
				$('#afterLoginDiv').show();
				$('#loginDiv').hide();
			}else{
				$('#afterLoginDiv').hide();
				$('#loginDiv').show();
			}
		},
		error:function(){
			$.messager.alert('提示信息','请求失败！请检查网络是否通畅或与管理员联系！','error');
		}
	});

	// 加载页面各个模块
	$.ajax({
		url:"<%=request.getContextPath()%>/portal/firstgateway/showFirstgateway.action", 
		type:'post',
		dataType:'json',
        async:false,
		success:function(data){
			commonBlocks("informationsDiv",data.informations,true);
			commonBlocks("linksDiv",data.links, false);
			commonBlocks('studyDiv',data.study, false);
			commonBlocks('bulletinsDiv',data.bulletins, false);
			commonBlocks('sjfxDiv',data.sjfcs, false);
            appendNewsAndTrends(data.news,data.trends);
			//alert(parseInt(Math.random())+' '+data.informations.length)
			//alert(parseInt(10*Math.random()))
			var hotnewIndex = parseInt(data.news.length*Math.random());
			hotnewIndex = hotnewIndex >= data.news.length ? (data.news.length-1) : hotnewIndex;
			$.each(data.news,function(i,info){
				if(i== hotnewIndex){
					var content = info.content.replace(/<(?:(?:\/?[A-Za-z]\w*\b(?:[=\s](['"]?)[\s\S]*?\1)*)|(?:!--[\s\S]*?--))\/?>/g,'');
					var content2 = content.length>100?content.substr(0,100):content;
					var content3 = content.length>400?content.substr(0,400):content;	
					$('#hotNewDiv').append("<div title='"+info.title+"' style='text-align:center;padding:10px 5px 5px 20px;color:#bd1515 ;font-family:粗黑;'><a target='_blank' href='gateWayViewNews.jsp?id="+info.id+"'><span style='font-weight:bold;font-size:30px;'>"+(info.title.length>20 ? info.title.substr(0,20) : info.title)+"</span></a></div>")
					.append("<div title=\'"+content3+"\' style=\'padding:0px 5px 5px -15px;\'><label><ul><li><a target=\'_blank\' href=\'gateWayViewNews.jsp?id="+info.id+"\'>"+content2+"</a></li></ul></label></div>");
					return false;
				}
			});

			$('a[name=da1]').each(function(i,obj){
				var info = data.trends[i];
				$(obj).attr('href','gateWayViewNews.jsp?id='+info.id);
			});
		},
		error:function(){
			$.messager.alert('提示信息','请求失败！请检查网络是否通畅或与管理员联系！','error');
		}
	});
	
	
	
	
	if(<%=SecurityContextUtil.canLogin()%>){
		$.messager.alert("提示信息","当前登陆用户数已经达到最大限制，请稍后重试！","error");
	}		
	$('#barMsg').html("审计考核局欢迎您!");
	$('#isUserLogin').val('0');
	String.prototype.lpad = function(num,fillchar){
	   try{
			var str = this;
			// 字符串的实际长度
			var len = str.length;
			// num要大于字符串的长度
			if(num && parseInt(num) > len){
				fillchar    = fillchar ? fillchar : ' ';
				// 最终长度和初始字符串的差值，即填充字符的个数
				var differ  = parseInt(num) - len;
				var fillArr = new Array();
				// 填充differ个fillchar
				for(var i=0; i<differ; i++){
					fillArr.push(fillchar);
				}
				fillArr.push(str);
				return fillArr.join("");
			}else{
				return str;
			}
		}catch(e){
			alert(e.message)
		}
	}
	
	function getCurrentDate(){
		  var s = "今天日期是:&nbsp;&nbsp;";
		  var date = new Date();
		  var arr = [];
		  arr.push(s);
		  arr.push(new String(date.getYear()).lpad(4,'0'));
		  arr.push("年");
		  arr.push(new String(date.getMonth()+1).lpad(2,'0'));
		  arr.push("月");
		  arr.push(new String(date.getDate()).lpad(2,'0'));
		  arr.push("日");
		  return arr.join("");
	}
	
	if('${param.login_error}'=='1'){
		$.messager.alert('提示信息',"用户名或密码错误！",'error',function(){
			$("#j_username").focus();
		});
	}	
	/**
	$(window).bind('keydown',function(e){
	    var ev = document.all ? window.event : e;
	    if(ev.keyCode==13) {
	    	var ele = ev.srcElement || ev.target;
	    	if(ele){
	    		while(ele.nodeName != 'FORM'){
	    			ele = $(ele).parent()[0]
	    		}
	    		//alert(ele.id)
	    		var formId = $(ele).attr('id');
	    		if(formId){
	    			userLogin(formId,'j_username','j_password');	
	    		}	    		
	    	}    	
	     }
	});
	*/
	
	// 检查用户是否登陆
	function checkLoginUser(){
		return $('#isUserLogin').val()=='1' ? true : false;
	}
	
	
	// 注册登录按钮事件
	$('#userLoginBtn').bind('click' ,function(){ userLogin('userLoginForm','j_username','j_password'); });
	$('#userLoginBtn2').bind('click',function(){ userLogin('userLoginForm2','j_username','j_password'); });
	
	var webroot = '<%=request.getContextPath()%>';
	var imgsrcPrefix = webroot+'/cloud/homeimg/';
	// 头部按钮组
	var menuArr = [
		{name:'管理作业',img:'u50.png',url:webroot+'/syslogin.jsp',callbackFn:checkLoginUser},
		{name:'预警分析',img:'u82.png',url:webroot+'/portal/simple/simple-firstPageAction!menu.action',callbackFn:checkLoginUser},
		{name:'决策支持',img:'u52.png',url:webroot+'/portal/simple/simple-firstPageAction!menu.action',callbackFn:checkLoginUser},
		{name:'过程监控',img:'u54.png',url:webroot+'/portal/simple/simple-firstPageAction!menu.action',callbackFn:checkLoginUser},
		{name:'绩效考核',img:'u56.png',url:webroot+'/portal/simple/simple-firstPageAction!menu.action',callbackFn:checkLoginUser},
		{name:'办公管理',img:'u58.png',url:webroot+'/portal/simple/simple-firstPageAction!menu.action',callbackFn:checkLoginUser},
		{name:'即时通讯',img:'u60.png',url:webroot+'/portal/simple/simple-firstPageAction!menu.action',callbackFn:checkLoginUser},
		{name:'系统管理',img:'u62.png',url:webroot+'/portal/simple/simple-firstPageAction!menu.action',callbackFn:checkLoginUser}
	];	
	//生成按钮
	var w = $('body').width();
	var h = $('body').height();
	$.each(menuArr,function(i, json){
		var menuWrap = document.createElement('div');
		var img = document.createElement('img');
		var imgWrap = document.createElement('div');
		var txtWrap = document.createElement('div');
		$(menuWrap).addClass('menulogo');
		$(imgWrap).append(img);
		$(img).attr("src",imgsrcPrefix+json.img);
		$(menuWrap).append(imgWrap).append(txtWrap);
		$(txtWrap).addClass('menu_txt').html(json.name);
		$('#menubar').append(menuWrap);			
		// 注册鼠标和单击事件
		var src = json.img.split('.')[0];
		$(img).bind('mouseover',function(){
			$(img).attr('src',imgsrcPrefix+src+'_selected.png').css('cursor','pointer');
			$(txtWrap).removeClass('menu_txt').addClass('menu_txt_over');
		});
		$(img).bind('mouseout',function(){
			$(img).attr('src',imgsrcPrefix+src+'.png');
			$(txtWrap).removeClass('menu_txt_over').addClass('menu_txt')
		});
		$(img).bind('click',function(){
			if(checkLoginUser()){
				var udswin = window.open(json.url,'','width=800px,height=700px,toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
                udswin.moveTo(0,0);
                udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
            }else{
				//$.messager.alert('提示信息','只有登陆用户才可以操作！','error');
				$('#userLoginWin').window('open');
				$('#userLoginWin').data('openUrl',json.url);
			}			
		});
	});
	$('#curDate').html(getCurrentDate());
	
	$(window).bind('resize',function(){
		resizeWindow();
	});
	
	$('#userLoginClearBtn').bind('click',function(){
		$('#userLoginForm').form('clear');		
	});
	
	$('#userLoginClearBtn2').bind('click',function(){
		$('#userLoginForm2').form('clear');		
	});
	

	$('#userLoginBtn, #userLoginClearBtn').bind('mouseover',function(){
	    $(this).css('color','white').parent('div').css('background-image','url(/ais/cloud/homeimg/loginBtnOver.png)');
	}).bind('mouseout',function(){
	    $(this).css('color','black').parent('div').css('background-image','');
	});
	
	// 用户切换
	$('#userSwitch').bind('click',function(e){
		$.messager.confirm('用户切换','是否注销当前用户？',function(flag){
            if(flag) {
//                $('#isUserLogin').val('0');
//                $('#barMsg').html("审计考核局欢迎您!");
//                $('#userLoginForm').form('clear');
//                $('#userLoginForm2').form('clear');
//                $('#afterLoginDiv').hide();
//                $('#loginDiv').show();
//                $('#userLoginWin').window('open');
                window.location='<%=request.getContextPath()%>/system/uSystemAction!loginOut.action';
            }
		});
	});
	
	
	// 根据屏幕分辨率，设置区域宽度
	function resizeWindow(){
		window.setTimeout(function(){
			var wWin   = $('body').width();
			var wLeft  = $('#contentLeft').width();
			wLeft = wLeft <200 ? 230 : wLeft;
			var wRight = $('#contentRight').width();
			wRight = wRight <200 ? 230 : wRight;
			var wScroll = 30;
			var centerW = wWin-wLeft-wRight-wScroll;
			centerW = centerW < 260 ? 260 : centerW;
			$('#contentCenter').css('width',centerW);
			var slidW = $('#slideDiv').width();
			var slidW2 = slidW;
			$('.slideBox').css('width',slidW2);
			$('.slideBox li').each(function(i){
				//$(this).css('width',slidW2);
			});
			///alert($('.items img').length)
			$('.items img').each(function(i){
				$(this).css('width',slidW2);
			});
			//$('.slideBox > .tips').css('width',slidW2);
			$('.slideNew').css('width',slidW);
		},100);		
	}	
	

    if($('#news').html()!=null&&$('#news').html()!='') {
        // 图片新闻
        $('#slides').slideBox({
            duration: 0.7,//滚动持续时间，单位：秒
            easing: 'swing',//swing,linear//滚动特效
            delay: 5,//滚动延迟时间，单位：秒
            hideClickBar: false,//不自动隐藏点选按键
            clickBarRadius: 10
        });
    }
	// 登陆小窗口
   	$('#userLoginWin').window({
        closed  :true,
        closable:true,
        modal:true,
        draggable:true,
        resizable:true,
        shadow:true,
        width :370,
        height:310,
        inline:true,
        collapsible:false,
        minimizable:false,
        maximizable:false
	});
	
	//  重置窗口大小
    resizeWindow()
	
	$('.tips a').attr('target','_blank');
});
function loginFlag1(){
	$("#loginFlag").val("");
}
function loginFlag2(){
	$("#loginFlag").val("1");
}
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/scrollMulitiPic/js/lrscroll.js"></script>
</head>
<body class="easyui-layout" >
	<!-- 用户登陆弹出框 -->
    <div id='userLoginWin' style='overflow:hidden;' title="用户登陆" >
    	<div  style='border-bottom:1px solid #cccccc;overflow:hidden;height:310px;text-align:center; '>  
      		<form  name="userLoginForm2" id="userLoginForm2" method="POST"  >
			    <div class='loginWinWrap'>
			        <div class='loginWinInputWrap'>
			            <div class="loginWinBg loginWin_inputWrap">
			                <div class="loginWinBg loginWin_userlogo"></div>
			                <input type='text' name="j_username" class="loginWin_input"  onclick="loginFlag1();" placeholder="用户名"/>
			            </div>   
			            <div class="loginWinBg loginWin_inputWrap">
			                <div class="loginWinBg loginWin_passlogo"></div>
			                <input type='password'  name="j_password2" class="loginWin_input" placeholder="密码"/>
			                <input type="hidden"    name="j_password"  />
							<input type='hidden'    name='acegiAjax'  value='true'/>
			            </div>
			            <a id="userLoginBtn2"   style="cursor:pointer;">
			            	<div class="loginWinBg loginWin_loginSubmit"></div>
			            </a>
			            <div style='padding:10px;'>
			                <div class="loginWinBg loginWin_forgetPass"></div>
			                <a id="userLoginClearBtn2" style="cursor:pointer;">
			                	<div class="loginWinBg loginWin_resetinput"></div>
			                </a>
			            </div>
			        </div>
			        <div class="loginWinBg loginWin_bottom"></div>
			    </div>
	    	</form>    	
    	</div>
    </div> 

	<!-- 顶部 top -->
	<div data-options="region:'north',split:false,border:false" class="home_top noscroll">
		<div onclick='setHeight()'>
			<image class='home_top_img txtcenter' src="/ais/cloud/homeimg/u177.jpg"></image>
			<image style="display:none;background-repeat:no-repeat;position:absolute;right:0px;bottom:-2px;border:0px;" src="/ais/cloud/homeimg/u0.png"></image>
		</div>
	</div>

	<!-- 主体 body -->
	<div data-options="region:'center',split:false, border:false">
		<div class="easyui-layout" data-options="fit:true"> 
			<input type="hidden" id="loginFlag" value="" /> 
			<!-- 头部按钮区 -->
			<div data-options="region:'north',split:false, border:false" class="noscroll" style='height:70px;'>
				<div style='line-height:33px;overflow:hidden;padding:4px 10px 5px 5px;'>
					<div class='txtlfet  nowrap' style='float:left;padding:7px 10px 4px 5px;'>
						<div id='curDate' style='line-height:25px;'></div>
						<div id='barMsg'  style='line-height:23px;'></div>
					</div>
					<div id='menubar' class='txtright nowrap' style='float:right;'></div>
				</div>
			</div>
			<!-- 内容区 body -->
			<div data-options="region:'center', split:false"  class='txtcenter'  class='noscroll'>
				<div style='padding:0px;margin:0px;' class='txtcenter noscroll'>
					<!-- 左侧功能区  -->
					<div id='contentLeft' style='width:230px;padding:2px;clear:left;float:left;'>
						<div class="txtcenter noscroll" style='padding:12px 5px 5px 5px;border:1px solid #cccccc;text-align:center;margin-bottom:2px;'>													
							<div id='afterLoginDiv' style='display:none;vertical-align:middle;height:161px;'>
								<div style='padding:6px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>用户已登陆</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u44.png"></image></div>
								</div>
								<div style='padding:20px 5px 5px 5px;float:left;width:70px;height:90px;border:0px solid #cccccc;'>
									<image style='width:60px;height:70px;' src='/ais/cloud/homeimg/loginHead.png'></image>
								</div>
								<div style='vertical-align:middle;float:right;width:130px;text-align:left;line-height:90px;color:gray;'>
									<div style='line-height:30px;text-align:right;'>
										<a href="javascript:void(0);" id='userSwitch'><image style="cursor:pointer;width:17px;height:14px;border:0px;" src='/ais/cloud/homeimg/userswitch.png'></image></a>
									</div>
									<div style='line-height:25px;text-align:left;'>
										<strong><label id='showUserName'></label></strong>
									</div>
									<div style='line-height:25px;text-align:left;'>
										<label id='showUserDept' style='color:#b4b6b9t;'></label>
									</div>
								</div>
								<div style='float:left;clear:both;width:220px;height:5px;background-color:gray; padding:10px 0px 0px 0px;text-align:left;'></div>
								<div style='margin-top:-15px;float:left;clear:both;width:75px;height:15px;background-size:cover;BACKGROUND-IMAGE: url(/ais/cloud/homeimg/ztFill.png);BACKGROUND-REPEAT: no-repeat;text-align:left;'></div>
							</div>
							<div id='loginDiv' style='height:161px;'>
								<div style='padding:6px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>用户登陆</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u44.png"></image></div>
								</div>
								<form name="userLoginForm" id="userLoginForm"  method="post"  style='padding:20px 0px 10px 0px;'>
									<div style='padding:3px 3px 10px 3px;'>
										<label style='width:60px;text-align:right;padding-right:7px;'>用户名</label>
										<input class="easyui-textbox" name="j_username" onclick="loginFlag2();"  data-options="iconCls:'icon-man'" style='height:20px;width:150px;' tabindex="1"  placeholder="用户名"/>
									 </div>
									<div style='padding:3px 3px 10px 3px;'>
										<label style='width:60px;text-align:right;padding-right:7px;'>密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
										<input type="password"  name="j_password2"  class="easyui-textbox"  data-options="iconCls:'icon-lock'" style='height:20px;width:150px;' tabindex="2" placeholder="密码"/>
										<input type="hidden"    name="j_password"  />
										<input type='hidden'    id='acegiAjax'  name='acegiAjax'  value='true'/>
										<input type='hidden'    id='isUserLogin' value='0'/>
										<input type='hidden'    value='${userloginname}'/>
									</div>
									<div style='padding:3px 3px 10px 3px;'>
										<div style='padding-left:7px;float:left; line-height:35px;' class='nowrap'>
											<a href='javascript:void(0);'>忘记密码?</a>
										</div>
										<div style='width:100px;float:right;padding:10px;margin-right:5px;'>
											<div style='float:left;width:40px;height:15px;'>
												<a id="userLoginClearBtn" style="cursor:pointer;margin-top:-12px;">重置</a>
											</div>
											<div style='float:right;width:40px;height:15px;'>
												<a id="userLoginBtn"   style="cursor:pointer;margin-top:-12px;">登陆</a>
											</div>
										</div>			
									</div>
								</form>
							</div>
						</div>
						<div class="txtcenter" style="border:1px solid #cccccc;margin-bottom:2px;">
							<div  style='padding:15px;height:200px;'>
								<div style='padding:5px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>部门公告</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u40.png"></image></div>
								</div>
								<div id='informationsDiv' style='padding:10px 10px 10px 0px;height:150px;'></div>
								<div style="float:right;">
									<a style="font:10pt;cursor:pointer;" target='_blank' href="gateWayMoreNews.jsp?type=1">
										<img src="/ais/images/portal/pic/blue.png" style="border-width:0;">&nbsp;更多
									</a>
								</div>
							</div>
						</div>
						<div class="txtcenter" style="border:1px solid #cccccc;">
							<div  style='padding:15px;height:200px;'>
								<div style='padding:5px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>学习园地</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u44.png"></image></div>
								</div>
								<div id='studyDiv' style='padding:10px 10px 10px 0px;height:150px;'></div>	
								<div style="float:right;">
									<a style="font:10pt;cursor:pointer;" target='_blank' href="gateWayMoreNews.jsp?type=13">
										<img src="/ais/images/portal/pic/blue.png" style="border-width:0;">&nbsp;更多
									</a>
								</div>						
							</div>
						</div>
					</div>
					<!-- 中间功能区 -->
					<div id='contentCenter' style='width:42%;padding:2px 0px 2px 0px;clear:none; float:left;text-align:center;'>
						<div class="txtcenter" style="width:100%;border:0px solid #cccccc;margin-bottom:2px;">
							<div  style='padding:15px;height:350px;'>
								<div style='padding:5px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>公司新闻</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u48.png"></image></div>
								</div>		
								<div id='slideDiv' style='padding:10px 2px 10px 2px;text-align:center;'>
									<div id="slides" class="slideBox" style='border:1px dashed #cccccc;'>
									  <ul class="items" id="news">
									    <%--<li><a href="new1.jsp" target="_blank" title="抗震救灾 铁路全力畅通“生命线” "><img src="/ais/cloud/homeimg/u101.jpg" style='width:1000px;height:200px;'></a></li>--%>
									    <%--<li><a href="new1.jsp" target="_blank" title="前七个月全路客货运输稳步推进 "><img src="/ais/cloud/homeimg/u103.jpg" style='width:100px;height:200px;'></a></li>--%>
									    <%--<li><a href="new1.jsp" target="_blank" title="争分夺秒 救灾专列在行动 "><img src="/ais/cloud/homeimg/u105.jpg" style='width:1000px;height:200px;'></a></li>--%>
									    <%--<li><a href="new1.jsp" target="_blank" title="D5176次列车驶出兰渝铁路广安南站"><img src="/ais/cloud/homeimg/u107.jpg" style='width:1000px;height:200px;'></a></li>--%>
									  </ul>
									</div>
							    </div>
							    <div  class='slideNew' id='hotNewDiv'></div>
							</div>
						</div>
						<div class="txtcenter" style="width:100%;border:0px solid #cccccc;margin-bottom:2px;">
							<div  style='padding:15px;height:250px;'>
								<div style='padding:5px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>审计动态</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u44.png"></image></div>
								</div>
								<div style='margin-top:10px;border:0px dashed #cccccc;text-align:center;'>
									<DIV class='featureContainer'>
									    <DIV class='feature'>
									        <DIV class='block'>
									            <DIV id=botton-scroll>
									                <UL class=featureUL id="trends">
										                  <%--<LI class=featureBox>--%>
										                      <%--<DIV class=box>--%>
										                        <%--<A name="da1" href="new1.jsp" target="_blank"><IMG src="/ais/cloud/homeimg/6.jpg" width='270' height=150></A>--%>
										                      <%--</DIV>--%>
										                  <%--</LI>--%>
										                  <%--<LI class=featureBox>--%>
										                    <%--<DIV class=box>--%>
										                        <%--<A name="da1" href="new1.jsp" target="_blank"><IMG src="/ais/cloud/homeimg/7.jpg" width='270' height=150></A>--%>
										                    <%--</DIV>--%>
										                  <%--</LI>--%>
										                  <%--<LI class=featureBox>--%>
										                    <%--<DIV class=box>--%>
										                    	<%--<A name="da1" href="new1.jsp" target="_blank"><IMG src="/ais/cloud/homeimg/8.jpg" width='270' height=150></A>--%>
										                    <%--</DIV>--%>
										                  <%--</LI>--%>
										                  <%--<LI class=featureBox>--%>
										                    <%--<DIV class=box>--%>
										                    	<%--<A name="da1" href="new1.jsp" target="_blank"><IMG src="/ais/cloud/homeimg/u105.jpg" width='270' height=150></A>--%>
										                    <%--</DIV>--%>
										                  <%--</LI>--%>
									                </UL>
									            </DIV>
									        </DIV>
									        <div class='scrollBtn'>
									       		<A class=prev href="javascript:void();">Previous</A>
									       		<A class=next href="javascript:void();">Next</A>
									       </div>
									    </DIV>
									
									</DIV>
								</div>
							</div>
						</div>
					</div>
					<!-- 右侧功能区 -->
					<div id='contentRight' style='width:230px;padding:2px;clear:right;float:right;' class='noscroll'>
						<div class="txtcenter" style="border:1px solid #cccccc;margin-bottom:2px;">
							<div  style='padding:15px;height:148px;'>
								<div style='padding:5px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>公司简介</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u10.png"></image></div>
								</div>	
								<div id='bulletinsDiv' style='overflow:hidden;height:118px;padding:10px 0px 10px 0px'></div>
							</div>
						</div>
						<div class="txtcenter" style="border:1px solid #cccccc;margin-bottom:2px;">
							<div  style='padding:15px;height:200px;'>
								<div style='padding:5px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>审计风采</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u48.png"></image></div>
								</div>		
								<div id="sjfxDiv" style="padding:10px 10px 10px 0px;height:150px;"></div>
								<div style="float:right;">
									<a style="font:10pt;cursor:pointer;" target='_blank' href="gateWayMoreNews.jsp?type=14">
										<img src="/ais/images/portal/pic/blue.png" style="border-width:0;">&nbsp;更多
									</a>
								</div>
							</div>
						</div>
						<div class="txtcenter" style="border:1px solid #cccccc;margin-bottom:2px;">
							<div  style='padding:15px;height:200px;'>
								<div style='padding:5px;height:12px;border-bottom:1px solid #cccccc;'>
									<div style='float:left;'>友情链接</div>
									<div style='float:right;'><image src="/ais/cloud/homeimg/u48.png"></image></div>
								</div>		
								<div id="linksDiv" style="padding:10px 10px 10px 0px;height:150px;"></div>
								<div style="float:right;">
									<a style="font:10pt;cursor:pointer;" target='_blank' href="gateWayMoreNews.jsp?type=10">
										<img src="/ais/images/portal/pic/blue.png" style="border-width:0;">&nbsp;更多
									</a>
								</div>
							</div>
						</div>
					</div>
					<!-- 底部 -->
					<div style='width:100%;padding:10px;clear:both;float:left;text-align:center;border-top:1px solid #cccccc;' class="home_bottom noscroll nowrap">
						<div class="bottom_txt">版权所有 中国铁路总公司 京 ICP备 10009636号(建议分辨率不低于1024*768)</div>
						<div class="bottom_txt ">地址：北京市复兴路10号0431-82098114</div>
						<div class="bottom_txt nowrap">技术支持：北京用友审计软件有限公司</div>
					</div>					
				</div>
			</div>
		</div>
	</div>	
</body>
</html>
