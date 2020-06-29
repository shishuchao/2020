<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" />
	<title>AIS审计作业系统</title>
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
	<!-- END THEME LAYOUT STYLES -->
	<!-- END HEAD -->

<body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid" style="background-color: #1c77ac; background-image: url('${smvc}/resources/images/login/light.png'); background-repeat: no-repeat; background-position: center top; overflow: hidden;">
<div id="mainBody">
	<div id="cloud1" class="cloud"></div>
	<div id="cloud2" class="cloud"></div>
</div>
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
	<div class="page-header-inner ">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<a><img src="${smvc}/index/assets/global/img/yonyou.png" alt="logo" class="logo-default" style="margin: 13px 0 0"/> </a>
		</div>
	</div>
	<div class="page-actions" style="font:bold 28px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;color: #096099">
		<%--<label>AIS数字化审计分析平台</label>position: absolute;left: 20%;top:30%;color: white;--%>
			<label title="AIS审计信息化平台" style="position: absolute;left: 20%;top:30%;font:bold 28px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">
				审计信息化平台
			</label>
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
						<span class="username username-hide-on-mobile"> ${user.fdepname}&nbsp;&nbsp;${user.fname} </span>
						<i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu dropdown-menu-default">
						<li>
							<a data-toggle="modal" data-target="#acntMngShow">
								<i class="glyphicon glyphicon-user"></i> 账号管理 </a>
						</li>
						<li>
							<a data-toggle="modal" onclick="logout();">
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
		<div class="row" style="padding-top:5%">
			<div class="col-md-12">
				<div class="portlet light portlet-fit" style="background: none">
					<div class="portlet-body">
						<div class="mt-element-card mt-element-overlay">
							<div class="row">
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12 col-lg-offset-2 col-md-offset-4 col-sm-offset-6 col-xs-offset-12">
									<div class="mt-card-item" style="margin-bottom: 0;border: none">
										<div class="mt-card-avatar mt-overlay-1" style="cursor: pointer;" onclick="openSubsystem('审计管理系统','/portal/simple/simple-firstPageAction!menu.action?parentMenuId=02')">
											<img src="${smvc}/resources/images/newimg/1.png">
										</div>
										<div class="mt-card-content">
											<p class="mt-card-desc font-white" style="font:bold 18px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">审计管理系统</p>
										</div>
									</div>
								</div>
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
									<div class="mt-card-item" style="margin-bottom: 0;border: none">
										<div class="mt-card-avatar mt-overlay-1" style="cursor: pointer;" onclick="openSubsystem('在线作业系统','/portal/simple/simple-firstPageAction!menu.action?parentMenuId=02,021&isOnline=Y')">
											<img src="${smvc}/resources/images/newimg/2.png">
										</div>
										<div class="mt-card-content">
											<p class="mt-card-desc font-white" style="font:bold 18px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">在线作业系统</p>
										</div>
									</div>
								</div>
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
									<div class="mt-card-item" style="margin-bottom: 0;border: none">
										<div class="mt-card-avatar mt-overlay-1" style="cursor: pointer;" onclick="openSubsystem('决策支持系统','/portal/simple/simple-firstPageAction!menu.action?parentMenuId=031')">
											<img src="${smvc}/resources/images/newimg/5.png" />
										</div>
										<div class="mt-card-content">
											<p class="mt-card-desc font-white" style="font:bold 18px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">决策支持系统</p>
										</div>
									</div>
								</div>
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
									<div class="mt-card-item" style="margin-bottom: 0;border: none">
										<div class="mt-card-avatar mt-overlay-1" style="cursor: pointer;" onclick="openSubsystem('风险管理系统','/portal/simple/simple-firstPageAction!menu.action?parentMenuId=102')">
											<img src="${smvc}/resources/images/newimg/4.png">
										</div>
										<div class="mt-card-content">
											<p class="mt-card-desc font-white" style="font:bold 18px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">风险管理系统</p>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12 col-lg-offset-2 col-md-offset-4 col-sm-offset-6 col-xs-offset-12">
									<div class="mt-card-item" style="margin-bottom: 0;border: none">
										<div class="mt-card-avatar mt-overlay-1" style="cursor: pointer;" onclick="openSubsystem('内控评价系统','/portal/simple/simple-firstPageAction!menu.action?parentMenuId=05')">
											<img src="${smvc}/resources/images/newimg/3.png">
										</div>
										<div class="mt-card-content">
											<p class="mt-card-desc font-white" style="font:bold 18px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">内控评价系统</p>
										</div>
									</div>
								</div>
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
									<div class="mt-card-item" style="margin-bottom: 0;border: none">
										<div class="mt-card-avatar mt-overlay-1" style="cursor: pointer;" onclick="openSubsystem('工程审计系统','/portal/simple/simple-firstPageAction!menu.action?parentMenuId=04')">
											<img src="${smvc}/resources/images/newimg/5.png">
										</div>
										<div class="mt-card-content">
											<p class="mt-card-desc font-white" style="font:bold 18px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">工程审计系统</p>
										</div>
									</div>
								</div>
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
									<div class="mt-card-item" style="margin-bottom: 0;border: none">
										<div class="mt-card-avatar mt-overlay-1">
											<img src="${smvc}/resources/images/newimg/6.png">
										</div>
										<div class="mt-card-content">
											<p class="mt-card-desc font-white" style="font:bold 18px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">数据分析系统</p>
										</div>
									</div>
								</div>
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
									<div class="mt-card-item" style="margin-bottom: 0;border: none">
										<div class="mt-card-avatar mt-overlay-1">
											<img src="${smvc}/resources/images/newimg/6.png">
										</div>
										<div class="mt-card-content">
											<p class="mt-card-desc font-white" style="font:bold 18px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">监控预警系统</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<!--
<div class="page-footer">
	<div class="page-footer-inner"> ${copyright}

	</div>
</div>-->
<!-- END FOOTER -->
<script type="text/javascript">
    var contextPath = '${smvc}';
</script>
<!--[if lt IE 9]>
<script src="${smvc}/index/assets/global/plugins/respond.min.js"></script>
<script src="${smvc}/index/assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script src="${smvc}/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>

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
</body>

</html>

