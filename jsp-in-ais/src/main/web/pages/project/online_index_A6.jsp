<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" />
	<title>${parentMenu.ffundisplay}</title>
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

<body class="page-container-bg-solid page-header-fixed">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
	<div class="page-header-inner ">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<a><img src="${smvc}/index/assets/global/img/yonyou.png" alt="logo" class="logo-default" style="margin: 13px 0 0"/> </a>
		</div>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN PAGE ACTIONS -->
		<!-- DOC: Remove "hide" class to enable the page header actions -->
		<div class="page-actions" style="font:bold 28px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;color: #096099">
			<label>${parentMenu.ffundisplay}</label>
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
					<li class="dropdown dropdown-extended dropdown-notification" id="homelogo" style="display:none;">
						<a href="javascript:;" onclick="parentFocus();" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="icon-home" title="返回导航"></i>
						</a>
					</li>
					<!-- BEGIN BOOKMARKS DROPDOWN -->
					<s:if test="${user.flevel !='aotemp' }">
						<li class="dropdown dropdown-extended dropdown-notification" id="header_bookmarks_bar">
							<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
								<i class="icon-star" title="常用菜单"></i>
							</a>
							<ul class="dropdown-menu">
								<li>
									<ul id="bookMarksList" class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
									</ul>
								</li>
							</ul>
						</li>
					</s:if>
					<!-- END BOOKMARKS DROPDOWN -->
					<!-- BEGIN NOTIFICATION DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="icon-bell" title="待办事项"></i>
							<span class="badge badge-danger" id="remind"> 0 </span>
						</a>
						<ul class="dropdown-menu">
							<li>
								<ul id="remindList" class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#ffffff">
								</ul>
							</li>
						</ul>
					</li>
					<!-- END NOTIFICATION DROPDOWN -->
					<!-- BEGIN INBOX DROPDOWN -->
					<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
					<li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="icon-envelope-open" title="站内消息"></i>
							<span class="badge badge-primary" id="innerMsgCount"> 0 </span>
						</a>
						<ul class="dropdown-menu">
							<li class="external">
								<h3>您有
									<span class="bold" id="innerMsgCnt"></span> 条未读站内消息</h3>
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
							<span class="username username-hide-on-mobile" style="color: #096099;"> ${user.fdepname}&nbsp;&nbsp;${user.fname} </span>
							<i class="fa fa-angle-down"></i>
						</a>
						<ul class="dropdown-menu dropdown-menu-default">
							<li>
								<a data-toggle="modal" data-target="#acntMngShow">
									<i class="glyphicon glyphicon-user"></i> 账号管理 </a>
							</li>
							<li>
								<a data-toggle="modal" onclick="exitSystem();">
									<i class="glyphicon glyphicon-log-out"></i> 退出系统 </a>
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
			<div style="background-color: #1970a9;">
				<div style="padding-top: 20px;text-align: right;font-size: 20px;color: #ffffff;">
					<i class="icon-logout menu-toggler sidebar-toggler" style="margin-right: 20px;cursor: pointer" title="收起菜单"></i>
				</div>
				<!-- BEGIN SIDEBAR MENU -->
				<!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
				<!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
				<!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
				<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
				<!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
				<!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
				<ul class="page-sidebar-menu page-sidebar-menu-hover-submenu" style="background-color: #1970a9;" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
					<!--<li class="nav-item start active open">
						<a href="javascript:;" class="nav-link nav-toggle" onclick="Layout.setSidebarMenuActiveLink('click',this);">
							<i class="icon-home"></i>
							<span class="title">首页</span>
							<span class="selected"></span>
						</a>
					</li>
					-->
					<c:forEach items="${menuList}" var="menu">
						<li class="nav-item">
							<c:choose>
								<c:when test="${menu.isHaveChild eq 'Y'}">
									<a href="javascript:;" class="nav-link nav-toggle" onmouseover="childMenu('${menu.ffunid}')">
										<c:choose>
											<c:when test="${menu.iconCls eq 'icon-user'}">
												<i class="${menu.iconCls}" style="background: none;"></i>
											</c:when>
											<c:otherwise>
												<i class="${menu.iconCls}"></i>
											</c:otherwise>
										</c:choose>
										<span class="title">${menu.ffundisplay}</span>
										<span class="arrow"></span>
									</a>
									<ul class="sub-menu" id="submenu-${menu.ffunid}">
									</ul>
								</c:when>
								<c:otherwise>
									<a href="javascript:;" class="nav-link nav-toggle">
										<c:choose>
											<c:when test="${menu.iconCls eq 'icon-user'}">
												<i class="${menu.iconCls}" style="background: none;"></i>
											</c:when>
											<c:otherwise>
												<i class="${menu.iconCls}"></i>
											</c:otherwise>
										</c:choose>
										<span class="title" onclick="goMenu('${menu.ffundisplay}','${menu.flink}','${menu.ffunid}','',this)">${menu.ffundisplay}</span>
										<span class="arrow"></span>
									</a>
								</c:otherwise>
							</c:choose>
						</li>
					</li>
					</c:forEach>
				</ul>
			</div>
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
<!--
<div class="page-footer">
	<div class="page-footer-inner"> ${copyright}

	</div>
</div>-->
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
				    <li role="presentation"><a href="#mynews" role="tab" data-toggle="tab">提示信息</a></li>
				    <li role="presentation"><a href="#weidu"  role="tab" data-toggle="tab">未读消息</a></li>
				    <li role="presentation"><a href="#yidu"  role="tab" data-toggle="tab">已读消息</a></li>
				    <li role="presentation"><a href="#yifa"  role="tab" data-toggle="tab">已发消息</a></li>
				    <li role="presentation"><a href="#eamil"  role="tab" data-toggle="tab">已发邮件</a></li>
			   </ul>
			   <div class="tab-content">
				 <div role="tabpanel" class="tab-pane" id='mynews' title='提示信息' style="padding:0px;height:450px;overflow:hidden;">
		                 <iframe id="news_ifr" name="news_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=-1"  scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
		        </div>
		        <div role="tabpanel" class="tab-pane" id='weidu' title='未读消息' style="padding:0px;height:450px;overflow:hidden;">
		                 <iframe id="weidu_ifr" name="weidu_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=2" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
				</div> 
				<div role="tabpanel" class="tab-pane" id='yidu' title='已读消息' style="padding:0px;height:450px;overflow:hidden;">
					     <iframe id="yidu_ifr" name="yidu_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=1" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
				</div>
				<div role="tabpanel" class="tab-pane" id='yifa' title="已发消息" style="padding:0px;height:450px;overflow:hidden;">
					     <iframe id="yifa_ifr" name="yifa_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=3" scrolling='yes' frameborder="0" width="100%" height="100%" ></iframe>
				</div>
				<div role="tabpanel" class="tab-pane" id='eamil' title='已发邮件' style="padding:0px;height:450px;overflow:hidden;">
					     <iframe id="email_ifr" name="email_ifr" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=4" scrolling='no' frameborder="0" width="100%" height="100%" ></iframe>
				</div>
				<div class="modal-footer" style="padding-top:5px;text-align:center">
        			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#innermsgShow">新建消息</button>
				    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
     		    </div>
			 </div>
		 </div>			
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!--账户管理modal dialogs-->
	<div class="modal fade modal-scroll" id="acntMngShow" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog" style="width: 380px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true"></button>
					<h4 class="modal-title">账户管理</h4>
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
<!--发送站内消息modal dialogs-->
<div class="modal fade modal-scroll" id="innermsgShow" tabindex="-1"
	 role="dialog" aria-hidden="true">
	<div class="modal-dialog" style="width: 1200px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true"></button>
				<h4 class="modal-title">新建消息</h4>
			</div>
			<div class="modal-body" style="min-height: 300px;">
				<iframe  width="100%" height="600" id="innermsg_ifr"
						 src="${contextPath}/msg/innerMsg_edit.action?readFlag=3" frameborder="0" marginheight="0"
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
    function parentFocus(){
        //window.open(window.opener.location,'用友数字化风控审计平台')
        window.opener.focus();
    }
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

<script src="${smvc}/index/online_index.js" type="text/javascript"></script>
<script src="${smvc}/pages/tlInteractive/tlInteractiveCommon.js" type="text/javascript" ></script>
<script src="${smvc}/index/common.js" type="text/javascript"></script>
<!-- END THEME LAYOUT SCRIPTS -->
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
<script type="text/javascript">
    $(function(){
        if(navigator.userAgent.indexOf('Chrom') != -1){
            $('#homelogo').remove();
        }else{
            $('#homelogo').show();
        }
    });
</script>
</body>

</html>

