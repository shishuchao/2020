<%@ page contentType="text/html; charset=utf-8"%>
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

	<script src="${smvc}/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
	<!-- END THEME LAYOUT STYLES -->
	<!-- END HEAD -->

	<%--为避免出现此界面闪现过渡，放到head里--%>
	<script type="text/javascript">
        var menus = $.parseJSON('${menus}');
        if (menus.menus.length == 1) { // 如果仅仅只有一个可选项，不要再点击了，直接进入系统
            var menu = menus.menus[0];
            location.href = "${smvc}" + menu.flink + menu.menuId;
        }
	</script>
</head>
<body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid" style="background-color: #1c77ac; background-image: url('${smvc}/resources/images/login/light.png'); background-repeat: no-repeat; background-position: center top; overflow: hidden;">
<div id="mainBody">
	<div id="cloud1" class="cloud"></div>
	<div id="cloud2" class="cloud"></div>
</div>
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top" style="height: 70px; min-height: 70px;">
	<div class="page-header-inner ">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<%--<a><img src="${smvc}/index/assets/global/img/yonyou.png" alt="logo" class="logo-default" style="margin: 13px 0 0"/> </a>--%>
				<img src="${smvc}/images/auditcloud.png" alt="logo" class="logo-default" style="margin: 23px 0 0" width="295" height="30"/>
			</div>
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
			<div class="top-menu">
				<ul class="nav navbar-nav pull-right">
					<!-- BEGIN USER LOGIN DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-user">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<span class="username username-hide-on-mobile" style="color: #096099;"> ${user.fdepname}&nbsp;&nbsp;${user.fname} </span>
							<i class="fa fa-angle-down"></i>
						</a>
						<ul class="dropdown-menu dropdown-menu-default">
							<li>
								<a data-toggle="modal" data-target="#acntMngShow">
									<i class="glyphicon glyphicon-user"></i> 账号管理 </a>
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
<div class="page-container" style="margin-top: 70px;">
	<div class="page-content">
		<div class="loginbody">
			<div class="auditlogo" style="margin: 0 auto;width: 745px;margin-top: 70px;"><img src="${smvc}/images/audittitle.png" style="width: 742px; height: 85px;"/></div>
			<div class="loginbox1">
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

					function adjustLayout(rows, btnCoutns) {
					    //moduleBtn
						// 获取高度
						var wh = screen.availHeight;
						var ww = screen.availWidth;
						//loginbox0 position: absolute; left: 635px; margin-top: 149.5px;
                        $(".loginbox1").css("width", "800px");
                        $(".loginbox1").css("margin-top", "0px");
                        $(".loginbox1").css("margin-left", ((ww - 800)/2) + "px");
						$(".auditlogo").css("margin-top", ((wh - (rows * 220 + 170)) / 2 - 50) + "px");
						for (var i = 0; i < rows; i++) {
						    var btnCount = btnCoutns[i];
                            var marginwidth = (800 - btnCount * 155) / (btnCount * 2);
                            $(".moduleBtn" + i).css("margin-left", marginwidth);
                            $(".moduleBtn" + i).css("margin-right", marginwidth);
                        }
					}
					var rows = getLayoutRows(menus.menus); // 动态计算行数
                    var btnCounts = [];
					if(menus.menus.length > 0){
                        var menuSize = menus.menus.length;
                        var rowItems = Math.round(menuSize/rows);
                        for (var i = 0; i < rows; i++) {
                            var ul = $('<ul>',{'class':'loginlist'});
                            ul.css("width", "795px");
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
                                ul.append($('<li class="moduleBtn' + i + '">',{'style':'margin-left:3px'}).append($('<span>',{'onclick':'openSubsystem(\''+menu.menuName+'\',\''+menu.flink+menu.menuId+'\')'})
                                    .append($('<img>',{'src':'${smvc}/resources/images/login/'+menu.iconCls+'.png','alt':''+menu.menuName+''}))
                                    .append($('<p>').append(''+menu.menuName+''))));
							}
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
<!--账号管理modal dialogs-->
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
<!-- END CONTAINER -->
<script src="${smvc}/scripts/base64_Encode_Decode.js" type="text/javascript"></script>
<script type="text/javascript">
    var contextPath = '${smvc}';
    var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
    //var queryString = encode64(encodeURI(",,,${user.floginname}"));//用encodeURI需要编码整个URL，然后需要使用这个URL
    //decode64 解码
    var floginname =  "${user.floginname}";
    var queryString = RSAEncode(floginname); //加密
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
<script type="text/javascript">
   <%--  $(function(){
        window.onbeforeunload = function(e) {
            <%session.invalidate();%>
        };
    }); --%>
</script>
</body>

</html>

