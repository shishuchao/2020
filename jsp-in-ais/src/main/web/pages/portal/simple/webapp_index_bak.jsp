<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" />
	<title>AIS审计管理系统</title>
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
	<link href="${smvc}/index/assets/layouts/layout2/css/layout.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/layouts/layout2/css/themes/light.css" rel="stylesheet" type="text/css" id="style_color" />
	<!-- END THEME LAYOUT STYLES -->
<!-- END HEAD -->

<body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner ">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<a><img src="${smvc}/index/assets/global/img/yonyou.png" alt="logo" class="logo-default" style="margin: 13px 0 0"/> </a>
			<div class="menu-toggler sidebar-toggler">
				<!-- DOC: Remove the above "hide" to enable the sidebar toggler button on header -->
			</div>
		</div>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN PAGE ACTIONS -->
		<!-- DOC: Remove "hide" class to enable the page header actions -->
		<!-- END PAGE ACTIONS -->
		<!-- BEGIN PAGE TOP -->
		<div class="page-top">
			<!-- BEGIN HEADER SEARCH BOX -->
			<!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
			<!-- END HEADER SEARCH BOX -->
			<!-- BEGIN TOP NAVIGATION MENU -->
			<div class="top-menu" style="background: url('${smvc}/resources/images/newimg/headPicLeft.jpg') no-repeat;">
				<ul class="nav navbar-nav pull-right">
					<!-- BEGIN BOOKMARKS DROPDOWN -->
					<li class="dropdown dropdown-extended dropdown-notification" id="header_bookmarks_bar">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="fa fa-heart-o" ></i>
						</a>
						<ul class="dropdown-menu">
							<li>
								<ul id="bookMarksList" class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
								</ul>
							</li>
						</ul>
					</li>
					<!-- END BOOKMARKS DROPDOWN -->
					<!-- BEGIN NOTIFICATION DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="icon-bell"></i>
							<span class="badge badge-danger" id="remind"> 0 </span>
						</a>
						<ul class="dropdown-menu">
							<li>
								<ul id="remindList" class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
								</ul>
							</li>
						</ul>
					</li>
					<!-- END NOTIFICATION DROPDOWN -->
					<!-- BEGIN INBOX DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="icon-envelope-open"></i>
							<span class="badge badge-primary" id="innerMsgCount"> 0 </span>
						</a>
						<ul class="dropdown-menu">
							<li class="external">
								<h3>您有
									<span class="bold" id="innerMsgCnt"></span> 条未读消息</h3>
								<a data-toggle="modal" data-target="#allMsg">查看所有</a>
							</li>
							<li>
								<ul id="innerMsgList" class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
								</ul>
							</li>
						</ul>
					</li>
					<!-- END INBOX DROPDOWN -->
					<!-- BEGIN USER LOGIN DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-user">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<span class="username username-hide-on-mobile"> ${user.fname} </span>
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
<div class="page-container">
	<!-- BEGIN SIDEBAR -->
	<div class="page-sidebar-wrapper">
		<!-- END SIDEBAR -->
		<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
		<!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
		<div class="page-sidebar navbar-collapse collapse">
			<!-- BEGIN SIDEBAR MENU -->
			<!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
			<!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
			<!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
			<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
			<!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
			<!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
			<ul class="page-sidebar-menu  page-header-fixed page-sidebar-menu-hover-submenu " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
				<li class="nav-item start active open" style="border-top:5px solid #8b9c9c">
					<a href="javascript:;" class="nav-link nav-toggle" onclick="Layout.setSidebarMenuActiveLink('click',this);">
						<i class="icon-home"></i>
						<span class="title">首页</span>
						<span class="selected"></span>
					</a>
				</li>
				<c:forEach items="${menuList}" var="menu">
					<li class="nav-item">
					<a href="javascript:;" class="nav-link nav-toggle" onmouseover="childMenu('${menu.ffunid}')">
						<i class="${menu.iconCls}"></i>
						<span class="title">${menu.ffundisplay}</span>
						<span class="arrow"></span>
					</a>
					<c:if test="${menu.isHaveChild eq 'Y'}">
						<ul class="sub-menu" id="submenu-${menu.ffunid}">
						</ul>
					</c:if>
					</li>
				</li>
				</c:forEach>
			</ul>
			<!-- END SIDEBAR MENU -->
		</div>
		<!-- END SIDEBAR -->
	</div>
	<!-- END SIDEBAR -->
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<!-- BEGIN CONTENT BODY -->
		<div class="page-content">
			<div class="row">
				<div class="col-md-12">
					<div class="tabbable tabbable-custom tabbable-noborder" id="tabs" role="tablist">
						<ul class="nav nav-tabs">
						</ul>
						<div class="tab-content">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END CONTENT BODY -->
	</div>
	<!-- END CONTENT -->
</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div class="page-footer">
	<div class="page-footer-inner"> ${copyright}
		<a id="goYj" style="display: none;" target="_blank"></a>
	</div>
</div>
<!-- END FOOTER -->
<!--查看所有modal dialogs-->
<div class="modal fade modal-scroll" id="allMsg" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="width:1200px"> 
		<div class="modal-content" style="height:650px">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title">站内消息</h4>
			</div>
			<div class="modal-body" >
				<ul id="new_tabs" class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active"><a href="#mynews" role="tab" data-toggle="tab">提示信息</a></li>
				    <li role="presentation"><a href="#weidu"  role="tab" data-toggle="tab">未读消息</a></li>
				    <li role="presentation"><a href="#yidu"  role="tab" data-toggle="tab">已读消息</a></li>
				    <li role="presentation"><a href="#yifa"  role="tab" data-toggle="tab">已发消息</a></li>
				    <li role="presentation"><a href="#eamil"  role="tab" data-toggle="tab">已发邮件</a></li>
			   </ul>
			   <div class="tab-content">
				 <div role="tabpanel" class="tab-pane fade in active" id='mynews' title='提示信息' style="padding:0px;height:450px;overflow:hidden;">
		                 <iframe id="news_ifr" name="news_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=-1"  scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
		        </div>
		        <div role="tabpanel" class="tab-pane" id='weidu' title='未读消息' style="padding:0px;height:450px;overflow:hidden;">
		                 <iframe id="weidu_ifr" name="weidu_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=2" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
				</div> 
				<div role="tabpanel" class="tab-pane" id='yidu' title='已读消息' style="padding:0px;height:450px;overflow:hidden;">
					     <iframe id="yidu_ifr" name="yidu_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=1" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
				</div>
				<div role="tabpanel" class="tab-pane" id='yifa' title="已发消息" style="padding:0px;height:450px;overflow:hidden;">
					     <iframe id="yifa_ifr" name="yifa_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_edit.action?readFlag=3" scrolling='yes' frameborder="0" width="100%" height="100%" ></iframe>
				</div>
				<div role="tabpanel" class="tab-pane" id='eamil' title='已发邮件' style="padding:0px;height:450px;overflow:hidden;">
					     <iframe id="email_ifr" name="email_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=4" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
				</div>
				<div class="modal-footer" style="padding-top:5px;text-align:center">
        			<button type="button" class="btn btn-default" onclick="sendF()">新建消息</button>
				    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
     		    </div>
			 </div>
		 </div>			
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
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
	<!--modal dialogs-->
<div class="modal fade modal-scroll" id="msgDialog" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title">消息详情</h4>
			</div>
			<div class="modal-body"style="height: 460px;">
				<iframe  width="100%" height="450px" id="msgFrame" frameborder="0" marginheight="0"  marginwidth="0"  style="overflow: hidden;"></iframe>
			</div>
			<div class="modal-footer" style="padding-top: 8px;height: 50px;text-align:center">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<script type="text/javascript">
    var contextPath = '${smvc}';
    var hasReminder = '${hasRemindMessage}';
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
<script src="${smvc}/index/assets/layouts/layout2/scripts/layout.js" type="text/javascript"></script>
<script src="${smvc}/index/assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
<link href="${smvc}/easyui/1.4/themes/metro/easyui.css" rel="stylesheet" type="text/css"/>
<link href="${smvc}/easyui/1.4/themes/icon.css" rel="stylesheet" type="text/css"/>
<script src="${smvc}/easyui/1.4/jquery.easyui.min.js" type="text/javascript"></script>
<script src="${smvc}/easyui/1.4/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>

<script src="${smvc}/index/index.js" type="text/javascript"></script>
<!-- END THEME LAYOUT SCRIPTS -->
</body>

</html>

