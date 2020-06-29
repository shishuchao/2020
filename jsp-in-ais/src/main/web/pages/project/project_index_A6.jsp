<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" />
	<title>审计作业系统(${projectStartObject.project_name})</title>
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
	<link href="${smvc}/index/assets/global/plugins/jqtip/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/layouts/layout4/css/layout.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/index/assets/layouts/layout4/css/themes/light.min.css" rel="stylesheet" type="text/css" />
	<link href="${smvc}/easyui/querytable.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script>
	<style type="text/css">
		a i{
			color:white!important;
		}
		a.dropdown-toggle{
		}
		a.dropdown-toggle:hover{
			background: none!important;
		}
		.nav .open>a,.nav .open>a:focus,.nav .open>a:hover {
			background: none!important;
		}
		.page-header.navbar .top-menu .navbar-nav>li.dropdown.open .dropdown-toggle {
			background: none!important;
		}
		.page-header.navbar .top-menu .navbar-nav>li.dropdown>.dropdown-toggle {
			margin: 0;
			padding: 21px 12px 24px;
		}
		.nav-tabs>li>a {
			padding: 6px 15px;
		}
		.page-header.navbar .top-menu .navbar-nav>li.dropdown-extended .dropdown-menu .dropdown-menu-list>li>a {
			display: block;
			clear: both;
			font-weight: 300;
			line-height: 20px;
			white-space: normal;
			font-size: 13px;
			padding: 6px 8px 6px;
			text-shadow: none;
		}
		.page-header.navbar .top-menu .navbar-nav>li.dropdown-extended .dropdown-menu {
			min-width: 200px;
			max-width: 200px;
			width: 200px;
		}
		.page-sidebar .page-sidebar-menu>li>a, .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu>li>a {
			padding: 9px 15px;
		}
		.page-sidebar .page-sidebar-menu .sub-menu li>a, .page-sidebar-closed.page-sidebar-fixed .page-sidebar:hover .page-sidebar-menu .sub-menu li>a {
			padding: 8px 14px 8px 30px;
		}
	</style>
<body class="page-header-fixed page-container-bg-solid" style="overflow: hidden;">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top" style="height: 70px; min-height: 70px;">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner " style='background-image:url("${smvc}/index/assets/global/img/headBack.png");background-repeat:no-repeat;height:70px; background-color: #197aba;'>
		<!-- BEGIN LOGO -->
		<div class="page-logo" style="padding: 20px; margin:0px;">
			<a><img src="${smvc}/index/assets/global/img/headLogo.png" alt="logo"/> </a>
			<div style="font-size: 19pt;font-weight: bold;color: #FFF;position: absolute;top: 17px;left: 212px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 40%">
<%--				<c:choose>--%>
<%--					<c:when test="${fn:length(projectStartObject.project_name) > 20}">--%>
<%--						<c:out value="${fn:substring(projectStartObject.project_name, 0, 20)}..." />--%>
<%--					</c:when>--%>
<%--					<c:otherwise>--%>
<%--						<c:out value="${projectStartObject.project_name}" />--%>
<%--					</c:otherwise>--%>
<%--				</c:choose>--%>
				${projectStartObject.project_name}
			</div>
		</div>
<%--		<div class="page-actions" style="margin: 12px 0 15px 10px;">--%>
<%--			<img src="${smvc}/index/assets/global/img/headWord.png" style="position: absolute;left: 40%;"/>--%>
<%--		</div>--%>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN PAGE ACTIONS -->
		<!-- DOC: Remove "hide" class to enable the page header actions -->
		<%--<div class="page-actions" style="margin: 12px 0 15px 10px;">--%>
			<%--<label title="${projectStartObject.project_name}" style="position: absolute;left: 20%;top:30%;color: white;font:bold 28px 'Microsoft YaHei', 微软雅黑, 'MicrosoftJhengHei', 华文细黑, 'SimSun', 宋体;">--%>
				<%--<c:choose>--%>
				<%--<c:when test="${fn:length(projectStartObject.project_name) > 20}">--%>
					<%--<c:out value="${fn:substring(projectStartObject.project_name, 0, 20)}......" />--%>
				<%--</c:when>--%>
				<%--<c:otherwise>--%>
					<%--<c:out value="${projectStartObject.project_name}" />--%>
				<%--</c:otherwise>--%>
				<%--</c:choose>--%>
			<%--</label>--%>
		<%--</div>--%>
		<!-- END PAGE ACTIONS -->
		<!-- BEGIN PAGE TOP -->
		<div class="page-top">
			<!-- BEGIN HEADER SEARCH BOX -->
			<!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
			<!-- END HEADER SEARCH BOX -->
			<!-- BEGIN TOP NAVIGATION MENU -->
			<div class="top-menu">
				<ul class="nav navbar-nav pull-right">
					<li class="dropdown dropdown-extended dropdown-notification">
						<a href="javascript:;" onclick="javascript:window.location.href='${smvc}/portal/simple/simple-firstPageAction!menu.action?parentMenuId=10'" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<i class="icon-home"></i>
						</a>
					</li>
					<li class="dropdown dropdown-extended">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" id="auditTools">
							<i class="fa fa-gears"></i>
						</a>
						<ul class="dropdown-menu" role="menu" style="width: 180px;font-size:16px;">
							<li role="presentation">
								<a role="menuitem" tabindex="-1" href="#proInfo" data-toggle="modal"> 项目信息
								</a>
							</li>
							<li role="presentation">
								<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('分组信息','${contextPath}/project/listGroups.action?view=${view}&crudId=${projectStartObject.formId}','1007')"> 分组信息
								</a>
							</li>
							<li role="presentation">
								<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('成员信息','${contextPath}/project/getlistMembers.action?view=${view }&crudId=${projectStartObject.formId }','1008')"> 成员信息
								</a>
							</li>
							<s:if test="${projectStartObject.planProcess ne 'simplified'}">
								<li role="presentation">
									<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('实施方案','${contextPath}/operate/template/view.action?view=${view }&project_id=${projectStartObject.formId }','1003')"> 实施方案
									</a>
								</li>
								<li role="presentation">
									<%-- <a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('审计分工','${contextPath}/operate/task/project/showContentTypeWorkView.action?owner=true&project_id=${projectStartObject.formId }&view=${view }','fengong')"> 审计分工
									</a> --%>
									<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('分工调整','${contextPath}/project/proMemberWorkList.action?owner=true&project_id=${projectStartObject.formId }&crudId=${projectStartObject.formId}&vview=${view }','fengong')"> 审计分工
									</a>
								</li>
								<%--<li role="presentation">
									<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('被审计单位资料','${contextPath}/auditAccessoryList/list.action?cruProId=${projectStartObject.formId }&pro_type=${projectStartObject.pro_type }&pro_type_child=${projectStartObject.pro_type_child}&view=${view }','1005')"> 被审计单位资料
									</a>
								</li>--%>
							</s:if>
							<li role="presentation">
								<%-- <a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('审计文书','${contextPath}/pages/workprogram/edit_project_workprogram_audit.jsp?projectId=${projectStartObject.formId}','13')"> 审计文书 --%>
								<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('审计文书','${contextPath}/workprogram/editWorkProgramProjectDetail.action?projectid=${projectStartObject.formId}','13')">审计文书
								</a>
							</li>
							<li role="presentation">
								<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('审计依据','${contextPath}/pages/operate/manu/law_redirect.jsp?projectId=${projectStartObject.formId}','fagui')"> 审计依据
								</a>
							</li>
							<li role="presentation">
								<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('审计案例库','${contextPath}/pages/assist/suport/lawsLib/index.action?mCodeType=sjal&m_view=view','anli')"> 审计案例库
								</a>
							</li>
							<li role="presentation">
								<a role="menuitem" tabindex="-1" href="javascript:;" onclick="ProjectIndex.goMenu('审计问题库','${contextPath}/pages/ledger/problem_tree/problemindex.jsp?view=yes','wenti')"> 审计问题库
								</a>
							</li>
							<s:if test="@ais.project.ProjectSysParamUtil@isZXSJEnabled()">
								<li role="presentation">
									<a role="menuitem" tabindex="-1" href="javascript:;" onclick="zxsj()"> 大数据审计
									</a>
								</li>
							</s:if>
						</ul>
					</li>
					<li class="dropdown dropdown-user">
						<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<span class="username username-hide-on-mobile" style="color: white;"> ${user.fdepname}&nbsp;&nbsp;${user.fname}</span>
							<i class="fa fa-angle-down"></i>
						</a>
						<ul class="dropdown-menu dropdown-menu-default">
							<li>
								<a href="${smvc}/Manuel.html#_Toc9930560" target="_blank">
									<i class="glyphicon glyphicon-help"></i> 系统帮助 </a>
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
		<div class="page-sidebar navbar-collapse collapse" style="margin-left:-10px;">
			<div style="background-color: #1A70A9;">
				<div style="padding-top: 14px;text-align: right;font-size: 20px;color: #ffffff;">
					<i class="icon-logout menu-toggler sidebar-toggler" style="margin-right: 20px;cursor: pointer" title="收起菜单"></i>
				</div>
				<!-- BEGIN SIDEBAR MENU -->
				<!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
				<!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
				<!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
				<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
				<!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
				<!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
				<ul class="page-sidebar-menu  page-header-fixed page-sidebar-menu-hover-submenu " style="background-color: #1A70A9;" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200" id="menuList">
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
				<div class="col-md-12" style='margin-left:-12px!important;padding-left:1px!important;padding-right:0px!important;color:#838fa1;'>
					<div class="tabbable tabbable-custom tabbable-noborder" id="tabs" role="tablist">
						<ul class="nav nav-tabs" style="padding:0px;margin-left:-5px;margin-top:0px;">
						</ul>
						<div class="tab-content" style="padding:0px;margin-left:-3px;">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END CONTENT BODY -->
	</div>
	<!-- END CONTENT -->
</div>
<!--项目信息-->
<div class="modal fade modal-scroll bs-modal-lg" id="proInfo" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title">项目信息</h4>
			</div>
			<div class="modal-body"style="height: 460px;overflow:scroll;">
				<div class="table-scrollable">
					<table id="projectStartTable" class="ListTable" style="width:100%">
						<tr>
							<td class="EditHead">项目名称</td>
							<td class="editTd"><s:property
									value="projectStartObject.project_name" /></td>
							<td class="EditHead">项目编号</td>
							<td class="editTd"><input type="hidden"
													  name="projectStartObject.project_code"
													  value="${projectStartObject.project_code }"> <s:property
									value="projectStartObject.project_code" /></td>
						</tr>
						<tr>
							<td class="EditHead">项目年度</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_year" /></td>
							<td class="EditHead">项目类别</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_type_name" /> &nbsp;&nbsp; <s:property
									value="projectStartObject.pro_type_child_name" /></td>
						</tr>
						<tr>
							<td class="EditHead">计划类别</td>
							<td class="editTd" colspan="3"><s:property
									value="projectStartObject.plan_type_name" /></td>
						</tr>
						<s:if test="${!projectStartObject.nbzwpg}">
							<tr>
								<td class="EditHead">审计单位</td>
								<td class="editTd"><s:property
										value="projectStartObject.audit_dept_name" /></td>
								<td class="EditHead">被审计单位</td>
								<td class="editTd"><s:property
										value="projectStartObject.audit_object_name" /></td>
							</tr>
						</s:if>
						<s:else>
							<td class="EditHead">测试组织者</td>
							<td class="editTd"><s:property
									value="projectStartObject.audit_dept_name" /></td>
							<td class="EditHead">测内控专岗负责人</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_teamleader_name" /></td>
						</s:else>
						<!-- 工程项目审计 -->
						<s:if test="projectStartObject.gcxmsj">
							<tr id="gcxmTr1">
								<td class="EditHead" id="gcxmTd1">合同金额</td>
								<td class="editTd"><s:property
										value="projectStartObject.contractAmount" />万元</td>
								<td class="EditHead" id="gcxmTd2">项目管理模式</td>
								<td class="editTd"><s:property
										value="projectStartObject.managerType" /></td>
							</tr>
							<tr id="gcxmTr2">
								<td class="EditHead" id="gcxmTd3">开工日期</td>
								<td class="editTd"><s:property
										value="projectStartObject.startProDate" /></td>
								<td class="EditHead" id="gcxmTd4">竣工日期</td>
								<td class="editTd"><s:property
										value="projectStartObject.finishProDate" /></td>
							</tr>
							<tr id="gcxmTr3">
								<td class="EditHead" id="gcxmTd5">项目状态</td>
								<td class="editTd" colspan="3"><s:property
										value="projectStartObject.proStatus" /></td>
							</tr>
						</s:if>

						<s:if test="projectStartObject.jjzrr">
							<tr>
								<td class="EditHead">经济责任人</td>
								<td class="editTd"><s:property
										value="projectStartObject.jjzrrname" /></td>
								<td class="EditHead">是否为总公司党组管理干部</td>
								<td class="editTd"><s:if
										test="${projectStartObject.isDangLeader=='true'}">
									是
								</s:if> <s:else>
									否
								</s:else></td>
							</tr>
						</s:if>
						<s:if test="projectStartObject.rework">
							<tr>
								<td class="EditHead">后续审计项目</td>
								<td class="editTd" colspan="3"><s:property
										value="projectStartObject.reworkProjectNames" /></td>
							</tr>
						</s:if>
						<tr>
							<td class="EditHead">开始日期</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_starttime" /></td>
							<td class="EditHead">结束日期</td>
							<td class="editTd"><s:property
									value="projectStartObject.pro_endtime" /></td>
						</tr>
						<s:if test="${!projectStartObject.nbzwpg}">
							<tr>
								<td class="EditHead" nowrap><s:if
										test="varMap['audit_start_timeRequired']">
									<font color=red>*</font>
								</s:if> 审计期间开始</td>
								<td class="editTd"><s:property
										value="projectStartObject.audit_start_time" /> <input
										type="hidden" name="projectStartObject.audit_start_time"
										value="${projectStartObject.audit_start_time }"></td>
								<td class="EditHead" nowrap><s:if
										test="varMap['audit_end_timeRequired']">
									<font color=red>*</font>
								</s:if> 审计期间结束</td>
								<td class="editTd"><s:property
										value="projectStartObject.audit_end_time" /> <input type="hidden"
																							name="projectStartObject.audit_end_time"
																							value="${projectStartObject.audit_end_time }"></td>
							</tr>
							<tr>
								<td class="EditHead">
									立项依据
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.content" />
								</td>
							</tr>
							<tr>
								<td class="EditHead">
									审计目的
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.audit_purpose" />
								</td>
							</tr>
							<tr >
								<td class="EditHead">
									审计安排
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.audArrange" />
								</td>
							</tr>
							<tr >
								<td class="EditHead">
									审计重点
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.audEmphasis"/>
								</td>
							</tr>

							<tr>
								<td class="EditHead">
									备注
								</td>
								<td class="editTd" colspan="3">
									<s:property value="projectStartObject.plan_remark"/>
								</td>
							</tr>
						</s:if>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END CONTAINER -->
<script type="text/javascript">
    var contextPath = '${smvc}';
    var crudId = '${crudId}';
    var source = '${source}';
    var projectview = '${projectview}';
    var menuIds = '${parents}';
    var stateI = ${stateI};
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
<script src="${contextPath}/index/assets/global/plugins/jqtip/jquery.qtip.min.js" type="text/javascript"></script>
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
<script src="${smvc}/index/projectindex.js" type="text/javascript"></script>
<script src="${smvc}/index/common.js" type="text/javascript"></script>
<script src="${smvc}/index/preventBackspace.js" type="text/javascript"></script>
<script type="text/javascript">
    /**
     * 在线审计
     */
    function zxsj(){
        if(${view eq 'view'}){
            alert('当前为预览状态。不可操作！');
            return;
        }
        var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
        var projectCode = document.getElementsByName("projectStartObject.project_code")[0].value;
        var auditStartTime = document.getElementsByName("projectStartObject.audit_start_time")[0].value;
        if(auditStartTime==''){
            alert('审计期间没有定义,无法在线作业!');
            return false;
        }
        var start_1=auditStartTime.split("-")[0];
        var start_2=auditStartTime.split("-")[1];
        var start_3=auditStartTime.split("-")[2];

        if(start_2.length==1){
            start_2 = '0' + start_2;
        }
        if(start_3.length==1){
            start_3 = '0' + start_3;
        }

        var start=start_1+start_2+start_3;

        var auditEndTime = document.getElementsByName("projectStartObject.audit_end_time")[0].value;
        if(auditEndTime==''){
            alert('审计期间没有定义,无法在线作业!');
            return false;
        }
        var end_1=auditEndTime.split("-")[0];
        var end_2=auditEndTime.split("-")[1];
        var end_3=auditEndTime.split("-")[2];

        if(end_2.length==1){
            end_2 = '0' + end_2;
        }
        if(end_3.length==1){
            end_3 = '0' + end_3;
        }

        var end=end_1+end_2+end_3;
		var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
		var queryString = "";
		var url = "";
		if ( "${bigData}"  == true ||  "${bigData}"  == "true" ){
			 queryString = encodeURIComponent(RSAEncode("${user.floginname},${crudId}"));
			 url ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
		}else{
			 queryString = encode64(encodeURI(""+projectCode+","+start+","+end+",${user.floginname}"));
			 url ="http://"+host+"/login.jsp?p="+queryString+"&type=0";
		}


		var udswin=window.open(url,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
        udswin.moveTo(0,0);
        udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
    }
</script>
<script src="${smvc}/resources/js/jQuery.md5.js" type="text/javascript"></script>
</body>

</html>

