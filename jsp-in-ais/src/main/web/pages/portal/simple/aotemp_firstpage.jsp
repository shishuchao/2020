<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>AIS审计作业系统</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<link href="${contextPath}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
	<link href="${contextPath}/index/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/layouts/layout2/css/themes/light.css" rel="stylesheet" type="text/css" id="style_color" />
	<link href="${contextPath}/easyui/querytable.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/easyui/1.4/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/easyui/1.4/themes/icon.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/css/aotemp.css?v=7" rel="stylesheet" type="text/css"/>
</head>
<body style="background: white;">
	<div class="container-fluid" style="margin-top: 10px;">
		<div class="row">
			<div class="col-md-6">
				<div class="portlet light tasks-widget" id="msg">
					<div class="portlet-title barBg title-border">
						<div class="rowTitleWrap" style="cursor: pointer;">
							<span class="rowTitle">消息提醒</span>
							<span class="titleTip" id="msgTitleTip">0</span>
							<span class="rowTitleLogo"></span>
						</div>
						<div class="tools">
							<a href="javascript:;" id="msg_more" title="更多">更多
								<i class="fa fa-angle-double-right"></i>
							</a>
						</div>
					</div>
					<div class="portlet-body body-border body-height2">
						<div class="task-content">
							<ul class="task-list" id="msgReminder">
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="portlet light tasks-widget" id="uploadData">
					<div class="portlet-title barBg title-border">
						<div class="rowTitleWrap">
							<span class="rowTitle">项目资料上传</span>
							<span class="rowTitleLogo"></span>
						</div>
						<div class="tools">
							<a href="javascript:;" id="uploadData_more" title="更多">更多
								<i class="fa fa-angle-double-right"></i>
							</a>
						</div>
					</div>
					<div class="portlet-body body-border body-height2">
						<div class="task-content">
							<ul class="task-list" id="uploadDataTable">
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="portlet light tasks-widget" id="special">
					<div class="portlet-title barBg title-border">
						<div class="rowTitleWrap">
							<span class="rowTitle">专项填报处理</span>
							<span class="rowTitleLogo"></span>
						</div>
						<div class="tools">
							<a href="javascript:;" id="special_more" title="更多">更多
								<i class="fa fa-angle-double-right"></i>
							</a>
						</div>
					</div>
					<div class="portlet-body body-border body-height2">
						<div class="task-content">
							<ul class="task-list" id="specialList">
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="portlet light tasks-widget" id="feedback">
					<div class="portlet-title barBg title-border">
						<div class="rowTitleWrap">
							<span class="rowTitle">问题整改反馈</span>
							<span class="rowTitleLogo"></span>
						</div>
						<div class="tools">
							<a href="javascript:;" id="feedback_more" title="更多">更多
								<i class="fa fa-angle-double-right"></i>
							</a>
						</div>
					</div>
					<div class="portlet-body body-border body-height2">
						<div class="task-content">
							<ul class="task-list" id="feedbackTable">
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="portlet light tasks-widget">
					<div class="portlet-title barBg title-border">
						<div class="rowTitleWrap">
							<span class="rowTitle">单位数据收集</span>
							<span class="rowTitleLogo"></span>
						</div>
					</div>
					<div class="portlet-body body-border body-height" style="text-align:center;white-space:nowrap;">
						<div class="logoWrap" onclick="parent.addTab('tabs','被审计单位信息','objectinfo','${contextPath}/mng/audobj/object/edit.action?en=${en}&source=auditobject&tab=1&auditingObject.id=${account.audit_object}',true)">
							<span class="icon-aoinfo logo"></span>
							<div class="text">单位信息维护</div>
						</div>
						<div class="logoWrap" onclick="aud$openNewTab('采集数据上传','${contextPath}/mng/audobj/data/listAuditObjectData.action',false);">
							<span class="icon-dataupload logo"></span>
							<div class="text">采集数据上传</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="portlet light tasks-widget">
					<div class="portlet-title barBg title-border">
						<div class="rowTitleWrap">
							<span class="rowTitle">常用工具</span>
							<span class="rowTitleLogo"></span>
						</div>
					</div>
					<div class="portlet-body body-border body-height" style="text-align:center;white-space:nowrap;">
						<div class="logoWrap" id="meetingUrl" onclick="AotempFirstPage.createMeeting();">
							<span class="icon-concat2 logo"></span>
							<div class="text">远程沟通工具</div>
						</div>
						<div class="logoWrap" onclick="window.open('${contextPath}/datacollect/审友A7-数据搬运工.zip')">
							<span class="icon-datacollect logo"></span>
							<div class="text">数据采集工具</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<iframe style="display: none;" id="loginFrame"></iframe>
	</div>

	<script type="text/javascript">
		var contextPath = '${contextPath}';
		var floginname = '${user.floginname}';
	</script>
	<!--[if lt IE 9]>
	<script src="${contextPath}/index/assets/global/plugins/respond.min.js"></script>
	<script src="${contextPath}/index/assets/global/plugins/excanvas.min.js"></script>
	<![endif]-->
	<!-- BEGIN CORE PLUGINS -->
	<script src="${contextPath}/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/moment.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script src="${contextPath}/index/aotemp_firstpage.js?v=7" type="text/javascript"></script>
</body>
</html>