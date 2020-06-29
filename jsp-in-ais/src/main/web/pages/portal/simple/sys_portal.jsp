<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" />
	<title>A7审计信息化集成平台</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<!-- BEGIN GLOBAL MANDATORY STYLES -->
	<link href="${smvc}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.css" rel="stylesheet" type="text/css" />
	<!-- END GLOBAL MANDATORY STYLES -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<!-- END PAGE LEVEL PLUGINS -->
	<!-- BEGIN THEME GLOBAL STYLES -->
	<link href="${smvc}/index/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
	<link href="${smvc}/index/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
	<!-- END THEME GLOBAL STYLES -->
	<!-- BEGIN THEME LAYOUT STYLES -->
	<link href="${smvc}/index/assets/layouts/layout4/css/layout.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/layouts/layout4/css/themes/light.min.css" rel="stylesheet" type="text/css" id="style_color" />
	<link href="${smvc}/index/css/login.css" rel="stylesheet" type="text/css"/>
	<link rel="shortcut icon" type="icon" href="${smvc}/images/displaytag/favicon.ico">

	<script src="${smvc}/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
	<!-- END THEME LAYOUT STYLES -->
	<!-- END HEAD -->

	<%--为避免出现此界面闪现过渡，放到head里--%>
	<script type="text/javascript">
        var audportal = '${audportal}';
        var menus = $.parseJSON('${menus}');
        if (menus.menus.length == 1) { // 如果仅仅只有一个可选项，不要再点击了，直接进入系统
            var menu = menus.menus[0];
            if(audportal != null){
                location.href = "${smvc}" + menu.flink + menu.menuId + "&audportal=" + audportal;
            }else{
                location.href = "${smvc}" + menu.flink + menu.menuId;
            }
        }
	</script>
	
<style type="text/css">	
.home-menu-item{
	height:25px!important;
	line-height:25px!important;
}
.menu-line{
    border-left-width:0px!important;
}
</style>	
	
</head>
<body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid" style="background-color: #1c77ac; background-image: url('${smvc}/resources/images/login/light.png'); background-repeat: no-repeat; background-position: center top; overflow: hidden;">
<div id="mainBody">
	<div id="cloud1" class="cloud"></div>
	<div id="cloud2" class="cloud"></div>
</div>
<!-- BEGIN HEADER -->
<div class="page-header navbar" style="height: 70px; min-height: 70px;background-color:transparent;border-bottom:0px;">
	<div class="page-header-inner ">
		<!-- BEGIN LOGO -->
		<div class="page-logo" style="font-weight:bold;font-size:2em;margin-left:49px;margin-top:32px;position:absolute;">
			<img src="${smvc}/index/assets/global/img/a7/navi_version.png" style="width:150px;"/>
		</div>
	</div>
	
	<div style="position:fixed;top:10px;right:20px;white-space: nowrap;font-size:14px;">
	<s:if test="${sysOldVersion == 'true' && oldVersionUrl != null && oldVersionUrl != ''}">
		<a href="javascript:void(0);" class="l-btn l-btn-small l-btn-plain m-btn m-btn-small"  id="sysOldVersion" onclick="throwOldVersion()" title="系统旧版本" style="cursor:pointer;text-decoration: none;color:white;">
			<strong>系统旧版本</strong>
		</a>
	</s:if>
		<a href="javascript:void(0);"  id="userInfoMenu" title="${user.fdepname}-${user.fname}" 
			 style="cursor:pointer;text-decoration: none;color:white;">
			<strong>${user.fdepname}&nbsp;&nbsp;${user.fname}</strong>
		</a>
	</div>
	
		<div class="page-actions" style="font:bold 28px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;color: #096099">
			<%--<label>AIS审计信息化平台</label>color: white;--%>
			<%--<label title="AIS审计信息化平台" style="position: absolute;left: 20%;top:30%;font:bold 28px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">--%>
				<%--AIS审计信息化平台--%>
			<%--</label>--%>
		</div>
		<!-- END PAGE ACTIONS -->
		<!-- BEGIN PAGE TOP -->
		<div class="page-top">
			<!-- BEGIN HEADER SEARCH BOX -->
			<!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
			<!-- END HEADER SEARCH BOX -->
			<!-- BEGIN TOP NAVIGATION MENU -->
			<div class="top-menu" style="display:none;">
				<ul class="nav navbar-nav pull-right">
					<!-- BEGIN USER LOGIN DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-user">
						<a href="javascript:;" id='loginUserInfo' class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<span class="username username-hide-on-mobile" style="color:white;"> ${user.fdepname}&nbsp;&nbsp;${user.fname} </span>
							<i class="fa fa-angle-down"></i>
						</a>
						<ul class="dropdown-menu dropdown-menu-default">
							<li>
								<a data-toggle="modal" data-target="#acntMngShow">
									<i class="glyphicon glyphicon-user"></i> 账号的管理 </a>
							</li>
							<li>
								<a data-toggle="modal" data-target="#versionShow">
									<i class="glyphicon glyphicon-user"></i> 版本的信息 </a>
							</li>
							<li>
								<a href="javascript:void(0);" data-toggle="modal" onclick="logout();">
									<i class="glyphicon glyphicon-log-out"></i> 注销 </a>
							</li>
						</ul>
					</li>
					<!-- END USER LOGIN DROPDOWN -->
				</ul>
			</div>
			<!-- END TOP NAVIGATION MENU -->
		</div>
		<!-- END PAGE TOP -->
	</div>
	<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->
<!-- BEGIN CONTAINER -->
<div class="page-container" style="margin-top: 0px;">
	<div class="page-content">
		<div>
			<div class="auditlogo" style="text-align:center;">
				<img src="${smvc}/index/assets/global/img/a7/navi_title.png" />
			</div>
			<div class="loginbox1" style="padding-top:44px;">
				<script type="text/javascript">
					<%--var menus = $.parseJSON('${menus}');--%>
					<%--if (menus.menus.length == 1) { // 如果仅仅只有一个可选项，不要再点击了，直接进入系统--%>
					    <%--var menu = menus.menus[0];--%>
					    <%--location.href = "${smvc}" + menu.flink + menu.menuId;--%>
					<%--}--%>
					<%--var rows = parseInt('${rows}');--%>
					function getLayoutRows(funcs) {
					    var fl = (!funcs) ? 0 : funcs.length;
					    if (fl <= 5) return 1;
					    if (fl <= 10) return 2;
					    return Math.floor((fl + 4)/5);
					}

					var ww = screen.availWidth;
					function adjustLayout(rows, btnCoutns) {
						try{
							//alert(rows+","+btnCoutns)
						    //moduleBtn
							// 获取高度
							var wh = screen.availHeight;
							var menuWidth = ww * 0.8;
							if(menuWidth < 800){
								menuWidth = 800;
							}else if(menuWidth > 1260){
								menuWidth = 1260;
							}
							//loginbox0 position: absolute; left: 635px; margin-top: 149.5px;
	                        $(".loginbox1").css("width", menuWidth+"px");
	                        $(".loginbox1").css("margin-top", "0px");

	                        if(rows == 1) {
								$(".auditlogo").css("margin-top", (wh - (rows * 300 + 100) - 50) / 4 + "px");
								$('.loginbox1').css("padding-top", '100px');
							} else {
								$(".auditlogo").css("margin-top", ((wh - (rows * 300 + 100)) / 2 - 50) + "px");
							}

							for (var i = 0; i < rows; i++) {
							    var btnCount = btnCoutns[i];
	                            var marginwidth = 2;//(menuWidth - btnCount * 300) / (btnCount * 2);
	                            $(".moduleBtn" + i).css("margin-left", marginwidth);
	                            //$(".moduleBtn" + i).css("margin-right", marginwidth);
	                            $(".moduleBtn" + i).css("margin-top", marginwidth*2);
	                        }							
						}catch(e){
							//alert(e.message);
						}
					}
					var rows = getLayoutRows(menus.menus); // 动态计算行数
                    var btnCounts = [];
					if(menus.menus.length > 0){
                        var menuSize = menus.menus.length;
                        var rowItems = Math.round(menuSize/rows);
                        for (var i = 0; i < rows; i++) {
                            var ul = $('<ul>',{'class':'loginlist'});
                            ul.css("width", "100%");
							var qsize;
                            if(i==0) {
                            	qsize = 5;
							} else {
                            	qsize = 4;
							}
                            var rowstart = i * rowItems;
                            var rowend = rowstart + rowItems;
                            var btnCount = 0;
                            for (var j = rowstart; j < rowend; j++) {
                                if (j >= menuSize) {
                                    $('.loginbox1').append(ul);
                                    btnCounts.push(btnCount);
                                    break;
                                }
                                btnCount++;
								var menu = menus.menus[j];
								if(menu.iconCls != null) {
									if(menu.iconCls.indexOf('gray') > -1) {
										ul.append($('<li class="moduleBtn' + i + '">',{'style':'margin-left:3px;'}).append($('<span>',{})
												.append($("<img>",{'src':'${smvc}/index/assets/global/img/a7/'+menu.iconCls+'.png','alt':''+menu.menuName+''}))
												.append($("<p>").append(''+menu.menuName+''))));
									} else {
										ul.append($('<li class="moduleBtn' + i + '">',{'style':'margin-left:3px;'}).append($('<span>',{'onclick':'openSubsystem(\''+menu.menuName+'\',\''+menu.flink+menu.menuId+'&fromPortal=1\')'})
										//.append($('<img>',{'src':'${smvc}/resources/images/login/'+menu.iconCls+'.png','alt':''+menu.menuName+''}))
												.append($("<img>",{'src':'${smvc}/index/assets/global/img/a7/'+menu.iconCls+'.png','alt':''+menu.menuName+''}))
												.append($("<p>").append(''+menu.menuName+''))));
									}
								}

							}
							ul.css("margin-left", ((ww - btnCount*250)/2) + "px");
                            $('.loginbox1').append(ul);
                            btnCounts.push(btnCount);
						}
						var resize = function() {
                            adjustLayout(rows, btnCounts);
                        };
                        $(window).resize(resize);
                        resize();
					}else{
					    document.write('<h2 style="color:#ffffff;text-align: center;vertical-align: middle">您没有系统授权，请联系系统运维人员。</h2>');
					}
				</script>
			</div>
		</div>
	</div>
</div>
<%--<!--账号管理modal dialogs-->
<div class="modal fade modal-scroll" id="acntMngShow" tabindex="-1"
	 role="dialog" aria-hidden="true">
	<div class="modal-dialog" style="width: 380px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true"></button>
				<h4 class="modal-title">账号管理</h4>
			</div>
			<div class="modal-body" style="min-height: 300px;">
				<iframe height="320" width="350" id="acntMng_ifr"
						src="/ais/general/acntMng.action" frameborder="0" marginheight="0"
						marginwidth="0" style="overflow: hidden;"> </iframe>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- END CONTAINER -->--%>
<div id="acntMng_div" title="账号管理" style="overflow:hidden;padding:0px">
	<iframe id="acntMng_ifr" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
</div>
<div id="versionShow_div" title="版本信息" style="overflow:hidden;padding:0px">
	<iframe id="version_ifr" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
</div>
<script src="${smvc}/scripts/base64_Encode_Decode.js" type="text/javascript"></script>
<script type="text/javascript">
    var contextPath = '${smvc}';
    var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
    //var queryString = encode64(encodeURI(",,,${user.floginname}"));//用encodeURI需要编码整个URL，然后需要使用这个URL
    //decode64 解码
    var floginname =  "${user.floginname}";
    var queryString = encode64(encodeURI(",,," + floginname)); //加密
</script>
<!--[if lt IE 9]>
<script src="${smvc}/index/assets/global/plugins/respond.min.js"></script>
<script src="${smvc}/index/assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->

<script src="${smvc}/index/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${smvc}/index/assets/global/scripts/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<!-- END PAGE LEVEL SCRIPTS -->
<!-- BEGIN THEME LAYOUT SCRIPTS -->
<script src="${smvc}/index/assets/layouts/layout4/scripts/layout.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
<link href="${smvc}/easyui/1.4/themes/metro/easyui.css" rel="stylesheet" type="text/css"/>
<link href="${smvc}/easyui/1.4/themes/icon.css" rel="stylesheet" type="text/css"/>
<script src="${smvc}/easyui/1.4/jquery.easyui.min.js" type="text/javascript"></script>
<script src="${smvc}/easyui/1.4/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script src="${smvc}/index/sysportal.js" type="text/javascript"></script>
<!-- END THEME LAYOUT SCRIPTS -->
<div style="font-weight:bold;font-size:1.5em;color:white;position:absolute;right:30px;bottom:30px;z-index:9999;">
	<img src="${smvc}/index/assets/global/img/a7/navi_bottom.png"/>
</div>

<div id="userInfoItems">
	<div data-options="iconCls:'icon-user'" class='home-menu-item' onclick='acntMngShow()'>账号管理</div>
	<div data-options="iconCls:'icon-about'" class='home-menu-item' onclick='versionShow()'>版本信息</div>
	<div data-options="iconCls:'icon-cancel'" class='home-menu-item' onclick='layout()'>系统注销</div>
<%--	<div data-options="iconCls:'icon-help'" class='home-menu-item' onclick='openHelp()'>系统帮助</div>   --%>
</div>
<script>
$(function(){
	$('#loginUserInfo').bind('mouseover', function(){
		$(this).find('.username').css('color','#096099');
	})
	
	$('#userInfoMenu').menubutton({
		 menu: '#userInfoItems',
		 menuAlign:'right'
	});
	
	if('${loginTitle}'){
		$('title').text('${loginTitle}');
	}
});
function layout(){
	top.$.messager.confirm('确认','您确定要注销登录吗？',function(r){
		if(r){
			/*
			var iframe = document.getElementById("fistPage");
	        if(iframe && iframe.contentWindow){
	            var mywin = iframe.contentWindow;
	            mywin.close_win_close();
	        }*/
	        try{	        	
		       	//opener.close();
		       	aud$closeAllOpener();
	        }catch(e){}
			window.location="<%=request.getContextPath()%>/system/uSystemAction!loginOut.action";
		}
	});
}
function openHelp(){
	aud$openNewWin("<%=request.getContextPath()%>/A7OHLP.html", "系统帮助");
}
function aud$openNewWin(link, sysName){
    var udswin = window.open(
            link, sysName,
            'height='+window.screen.availHeight+'px, width='+window.screen.availWidth+'px, fullscreen=yes, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

        udswin.moveTo(0, 0);
        udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
        if(jQuery.inArray(udswin, windowArray) == -1){
        	windowArray.push(udswin);
        }else{
        	udswin.focus();
        }
}
function acntMngShow(){
	var url = '/ais/general/acntMng.action';
	$('#acntMng_ifr').attr('src',url);
	$('#acntMng_div').window({
		width:350,
		height:320,
		modal:true,
		collapsible:false,
		maximizable:false,
		minimizable:false,
		closed:false
	});
}

function versionShow() {
	var url = '/ais/version.jsp';
	$('#version_ifr').attr('src',url);
	$('#versionShow_div').window({
		width:450,
		height:220,
		modal:true,
		collapsible:false,
		maximizable:false,
		minimizable:false,
		closed:false
	});
}


function throwOldVersion() {
    $.ajax({
        url:'${contextPath}/sysOldVersion.action',
        cache:false,
        dataType:'json',
        success:function(data){
            if(data != null){
                var url = data.sysOldVersionMenu[0].flink;
                aud$openNewWin(url,'系统旧版本');
            }
        }
    })
}

</script>
</body>

</html>

