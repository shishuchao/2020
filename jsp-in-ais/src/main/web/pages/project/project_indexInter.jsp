<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8" />
<title>内控评价在线作业系统(${ep.epName})</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<meta content="" name="description" />
<link href="${smvc}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="${smvc}/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${smvc}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
<link href="${smvc}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.css" rel="stylesheet" type="text/css" />
<link href="${smvc}/index/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
<link href="${smvc}/index/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
<link href="${smvc}/index/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
<link href="${smvc}/index/assets/layouts/layout4/css/layout.min.css" rel="stylesheet" type="text/css" />
<link href="${smvc}/index/assets/layouts/layout4/css/themes/light.min.css" rel="stylesheet" type="text/css" />
<link href="${smvc}/easyui/querytable.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script>

<body class="page-header-fixed page-container-bg-solid">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner ">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<a><img src="${smvc}/index/assets/global/img/yonyou.png" alt="logo" class="logo-default" style="margin: 13px 0 0"/> </a>
		</div>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN PAGE ACTIONS -->
		<!-- DOC: Remove "hide" class to enable the page header actions -->
		<div class="page-actions" style="font:bold 28px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;color: #096099">
			<label id="projectNameLink" title="单击查看【评价项目计划】" style="cursor:pointer;">${ep.epName} </label>
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
					<li class="dropdown dropdown-user">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<span class="username username-hide-on-mobile" style="color: #096099;margin-top:3px;">
							${user.fdepname}&nbsp;&nbsp;${user.fname}&nbsp;&nbsp;${curUserRole}</span>
							<i class="fa fa-angle-down"></i>
						</a>
						<ul class="dropdown-menu dropdown-menu-default">
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
				<ul class="page-sidebar-menu  page-header-fixed page-sidebar-menu-hover-submenu " style="background-color: #1970a9;" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200" id="menuList">
					<li class="nav-link nav-toggle" id="li_prepare">
						<a href="javascript:;" class="nav-link nav-toggle">
							<i class="icon-screen-tablet"></i>
							<span class="title">准备阶段</span>
							<span class="arrow"></span>
							<iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe></a>
						<ul class="sub-menu" id="submenu-4610" fetched="true">
							<li class="nav-item">
								<a href="javascript:;" class="nav-link">
									<span class="title" onclick="goMenu('评价方案','/ais/intctet/prepare/assessScheme/showFrame.action?view=${prepareView}&projectFormId=${crudId}','46201005','462010',this)">评价方案</span>
									<span id="heart-46201005" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks('评价方案','/ais/intctet/prepare/assessScheme/showFrame.action?view=${prepareView}','46201005',this)"></span>
								</a>
							</li>

						</ul>
						</a>
					</li>
					<li class="nav-link nav-toggle" id="li_actualize">
						<a href="javascript:;" class="nav-link nav-toggle">
							<i class="icon-screen-desktop"></i>
							<span class="title">实施阶段</span>
							<span class="arrow"></span>
							<iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe></a>
						<ul class="sub-menu" id="submenu-462020" fetched="true">
							<li class="nav-item">
								<a href="javascript:;" class="nav-link">
									<span class="title" onclick="goMenu('评价工具','/ais/intctet/evaluationActualize/showEvaluationTool.action?view=${actualizeView}&projectId=${crudId}','46202005','462020',this)">评价工具</span>
									<span id="heart-46202005" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks('评价工具','/ais/intctet/evaluationActualize/showEvaluationTool.action?view=${actualizeView}&projectId=${crudId}','46202005',this)"></span>
								</a>
							</li>
							<li class="nav-item">
								<a href="javascript:;" class="nav-link">
									<span class="title" onclick="goMenu('底稿复核','/ais/intctet/evaluationActualize/showManuReviewList.action?view=${actualizeView}&projectId=${crudId}','46202020','462020',this)">底稿复核</span>
									<span id="heart-46202020" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks('底稿复核','/ais/intctet/evaluationActualize/showManuReviewList.action?view=${actualizeView}&projectId=${crudId}','46202020',this)"></span>
								</a>
							</li>
							<li class="nav-item">
								<a href="javascript:;" class="nav-link">
									<span class="title" onclick="goMenu('缺陷一览','/ais/intctet/evaluationActualize/showProjectDefectList.action?view=${actualizeView}&projectId=${crudId}','46202010','462020',this)">缺陷一览</span>
									<span id="heart-46202010" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks('缺陷一览','/ais/intctet/evaluationActualize/showProjectDefectList.action?view=${actualizeView}&projectId=${crudId}','46202010',this)"></span>
								</a>
							</li>
							<li class="nav-item">
								<a href="javascript:;" class="nav-link">
									<span class="title" onclick="goMenu('分组小结','/ais/intctet/evaluationActualize/showTeamSummaryList.action?view=${actualizeView}&projectId=${crudId}','46202015','462020',this)">分组小结</span>
									<span id="heart-46202015" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks('分组小结','/ais/intctet/evaluationActualize/showTeamSummaryList.action?view=${actualizeView}&projectId=${crudId}','46202015',this)"></span>
								</a>
							</li>

						</ul>
						</a>
					</li>
					<li class="nav-link nav-toggle" id="li_report">
						<a href="javascript:;" class="nav-link nav-toggle">
							<i class="icon-folder"></i>
							<span class="title">报告阶段</span>
							<span class="arrow"></span>
							<iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe></a>
						<ul class="sub-menu" id="submenu-462030" fetched="true">
							<li class="nav-item">
								<a href="javascript:;" class="nav-link">
									<span class="title" onclick="goMenu('评价报告','/ais/intctet/evaProjectReport/edit.action?view=${reportView}&projectId=${crudId}','46203005','462030',this)">评价报告</span>
									<span id="heart-46203005" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks('评价报告','/ais/intctet/evaProjectReport/edit.action?view=${reportView}&projectId=${crudId}','46203005',this)"></span>
								</a>
							</li>
							<li class="nav-item">
								<a href="javascript:;" class="nav-link">
									<span class="title" onclick="goMenu('缺陷最终认定表','/ais/intctet/reportProblem/initReportProblemPage.action?view=${reportView}&projectId=${crudId}','46203010','462030',this)">缺陷最终认定表</span>
									<span id="heart-46203010" style="float: right;color: #d1b455;" class="glyphicon glyphicon-star-empty" onclick="menu_marks('缺陷最终认定表','/ais/intctet/reportProblem/initReportProblemPage.action?view=${reportView}&projectId=${crudId}','46203010',this)"></span>
								</a>
							</li>
						</ul>
						</a>
					</li>
					<li class="nav-link nav-toggle" >
						<a href="javascript:;" class="nav-link nav-toggle">
							<i class="icon-docs"></i>
							<span class="title" onclick="goMenu('评价文书','/ais/workprogram/editWorkProgramProjectDetailIntctet.action?view=${archivesView}&epId=${crudId}&isEdit=true','462035','4620',this)">评价文书</span>
							<span class="arrow"></span>
						</a>
					</li>
					<li class="nav-link nav-toggle" id="li_archives">
						<a href="javascript:;" class="nav-link nav-toggle">
							<i class="icon-drawer"></i>
							<span class="title" onclick="goMenu('项目归档','/ais/intctet/proArchive/listTobeStarted.action?view=${archivesView}&epId=${crudId}','4633','46',this)">项目归档</span>
							<span class="arrow"></span>
						</a>
					</li>
                    <li class="nav-link nav-toggle" id="li_rework">
                        <a href="javascript:;" class="nav-link nav-toggle">
                            <i class="icon-eye"></i>
                            <span class="title" onclick="goMenu('缺陷整改','/ais/intctet/rework/edit.action?view=${reworkView}&epId=${crudId}','462090','4620',this)">缺陷整改</span>
                            <span class="arrow"></span>
                        </a>
                    </li>
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
<script type="text/javascript">
    var contextPath = '${smvc}';
    var crudId = '${crudId}';
    var stage = '${stage}';
    var prepareView = '${prepareView}';
    var actualizeView = '${actualizeView}';
    var reportView = '${reportView}';
    var archivesView = '${archivesView}';
    var reworkView = '${reworkView}';
    var isEnd = '${isEnd}';
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
<link href="${smvc}/easyui/1.4/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css"/>
<link href="${smvc}/easyui/1.4/themes/icon.css" rel="stylesheet" type="text/css"/>
<script src="${smvc}/easyui/1.4/jquery.easyui.min.js" type="text/javascript"></script>
<script src="${smvc}/easyui/1.4/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script src="${smvc}/index/projectindexInter.js" type="text/javascript"></script>
<script src="${smvc}/index/common.js" type="text/javascript"></script>
<script type="text/javascript" src="${smvc}/pages/tlInteractive/tlInteractiveCommon_A6.js"></script>
<script type="text/javascript">
$(function(){
	$('#projectNameLink').bind('click', function(){
		var editUrl = '${contextPath}/intctet/evaProject/evaPlan/editEvaPlan.action';
        aud$openNewTab("评价项目计划查看", editUrl+"?view=true&formId=${crudId}", true);
	});
	if(isEnd == false || isEnd == null || isEnd == undefiend){		
		//根据不同阶段，删除其它多余的菜单
	    if(stage=="prepare"){
			$("#li_actualize, #li_report, #li_archives, #li_rework").remove();
		}else if(stage=="actualize" || stage=="report"){//内控实施、评价报告
			$("#li_archives, #li_rework").remove();
	    }else if(stage=="archives"){//项目归档
	    	$("#li_rework").remove();
	    }else if(stage=='rework') {//缺陷整改
	
	    }
	}
}); 
</script>
<script src="${smvc}/resources/js/jQuery.md5.js" type="text/javascript"></script>
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>

</html>

