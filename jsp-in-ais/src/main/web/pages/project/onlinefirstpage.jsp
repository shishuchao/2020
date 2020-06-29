<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>A7审计信息化平台</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<link href="${contextPath}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
	<link href="${contextPath}/index/assets/layouts/layout2/css/themes/light.css" rel="stylesheet" type="text/css" id="style_color" />

<style type="text/css">
.rowPadding{
	padding-left:0px!important;
	padding-right:0px!important;
	margin-top:0px!important;
	color:#838fa1;
}
.portlet-body{
	padding-top:0px!important;
	margin-top:-8px!important;
}
.task-list > li{
	padding-bottom:0px!important;
}
.task-list li:hover, .task-content tr:hover{
	background:#aae3fa!important;
}
.portlet{
	padding-top:0px!important;
	padding-right:5px!important;
	padding-bottom:5px!important;
	padding-left:5px!important;
}
.portlet-title{
	min-height:30px!important;
}
.portlet.light > .portlet-title > .tools{
	padding-top:0px!important;
	padding-bottom:0px!important;
	padding-right:10px!important;
	margin-top:4px!important;
}
.btn{
	padding-top:0px!important;
	padding-bottom:0px!important;
	padding-right:0px!important;
	padding-left:0px!important;
	margin-top:0px!important;
}
.carousel-caption{
	filter:Alpha(opacity=50);
	opacity:0.5;
	margin:0px!important;
	padding-top:2px!important;
	padding-bottom:20px!important;
	padding-right:10px!important;
	padding-left:10px!important;
}
hr, p {
	margin: 35px 0;
}

.barBg{
	background: url('${contextPath}/index/assets/global/img/a7/barBg.png') repeat center;
}
.groupBg1{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg6.png') repeat center;
}
.groupBg1_logo{
	background: url('${contextPath}/index/assets/global/img/a7/online_logo1.png') no-repeat center;
}
.groupBg2{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg2.png') repeat center;
}
.groupBg2_logo{
	background: url('${contextPath}/index/assets/global/img/a7/online_logo2.png') no-repeat center;
}
.groupBg3{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg4.png') repeat center;
}
.groupBg3_logo{
	background: url('${contextPath}/index/assets/global/img/a7/online_logo3.png') no-repeat center;
}
.groupBg4{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg5.png') repeat center;
}
.groupBg4_logo{
	background: url('${contextPath}/index/assets/global/img/a7/online_logo4.png') no-repeat center;
}
.groupBg5{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg1.png') repeat center;
}
.groupBg5_logo{
	background: url('${contextPath}/index/assets/global/img/a7/online_logo5.png') no-repeat center;
}
.groupBg6{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg3.png') repeat center;
}
.groupBg6_logo{
	background: url('${contextPath}/index/assets/global/img/a7/online_logo6.png') no-repeat center;
}

.groupPadding{
	overflow: hidden;
	margin:20px 0px 20px 0px;
	padding:0px;
	height:100px;
	width:16.3%;
	display:inline-block;
	text-align:center;
	position:relative;
	cursor:pointer;
	color:white;
	opacity:0.85;
    -moz-opacity:0.85;
    filter:alpha(opacity=85);
}
.groupLogo{
	overflow: hidden;
	height:38px;
	width:38px;
	position:absolute;
	top:10px;
	left:20px;
	opacity:0.9;
    -moz-opacity:0.9;
    filter:alpha(opacity=90);

}
.groupPadding:hover, .groupLogo:hover{
	opacity:1;
    -moz-opacity:1;
    filter:alpha(opacity=100);
}
.groupText{
	position:absolute;
	bottom:10px;
	left:20px;
	font-size:15px;
}
.groupData{
	position:absolute;
	top:15px;
	right:15px;
	font-size:30px;
}
.col-md-6, .col-md-12{
	padding-left:0px!important;
	padding-right:0px!important;
	margin-top:5px!important;
}
.rowTitleWrap{
	display:inline;
	position:relative;
	float:left;
	width:120px;
}
.rowTitle-active{
	opacity:1;
    -moz-opacity:1;
    filter:alpha(opacity=100);
	font-weight:bold;
	color:gray;
}
.rowTitle{
	font-size:15px;
	padding-left:10px;
	height:27px;
	line-height:27px;
}
.rowTitleLogo{
	background: url('${contextPath}/index/assets/global/img/a7/rowTitleLogo.png') no-repeat center;
	float:left;
	margin-left:10px;
	margin-top:11px;
	width:6px;
	height:7px;
}
.titleTip{
	color:white;
	background-color:red;
	border-radius:30px!important;
	position:absolute;
	bottom:7px;
	font-size:12px;
	width:20px;
	text-align:center;
	opacity:0.5;
    -moz-opacity:0.5;
    filter:alpha(opacity=70);
}
.rowTitle-disabled{
	color:gray;
}
.title-border{
	border:1px solid #e6e6e6;
	margin-bottom:0px!important;
}
.body-border{
	border:1px solid #e6e6e6;
	margin-bottom:0px!important;
	border-top-width:0px!important;
}
.body-height{
	height:430px;
	margin-top:2px;
}
.portlet{
	margin-bottom:0px!important;
}
.portlet .task-content{
	padding:10px;
}
.logoWrap{
	overflow: hidden;
	text-align:center;
	position:relative;
	top:22%;
	padding-left:10px;
	padding-right:10px;
	display:inline-block;
	cursor:pointer;

}
.logoWrap > .logo:hover{
	opacity:1;
    -moz-opacity:1;
    filter:alpha(opacity=100);
}
.logoWrap > .logo{
	width:76px;
	height:76px;
	opacity:0.8;
    -moz-opacity:0.8;
    filter:alpha(opacity=80);
}
.icon-sjdx{
	background: url('${contextPath}/index/assets/global/img/a7/sjdx.png') no-repeat center;
}
.icon-sjry{
	background: url('${contextPath}/index/assets/global/img/a7/sjry.png') no-repeat center;
}
.icon-sjcg{
	background: url('${contextPath}/index/assets/global/img/a7/sjcg.png') no-repeat center;
}
.icon-sjxm{
	background: url('${contextPath}/index/assets/global/img/a7/sjxm.png') no-repeat center;
}
.icon-fgcx{
	background: url('${contextPath}/index/assets/global/img/a7/fgcx.png') no-repeat center;
}
.logoWrap > .text{
	height:25px;
	line-height:25px;
	padding:2px;
	font-size:16px;
	text-align:center;
	color:#646464;
}
</style>
</head>
<body style="background: white;">
<div class="container-fluid">
	<div class="row" >
		<div class="col-md-12" style="text-align:center;margin-top:10px!important;padding-left:5px!important;padding-right:5px!important;">
			<div class="portlet-body  title-border" id="homeStBar">
				<div class="groupBg1 groupPadding" onclick="goOnline('全部项目')">
					<div class="groupBg1_logo groupLogo"></div>
					<span class="groupText">全部项目</span>
					<span class="groupData" id="hs_allProject">0</span>
				</div>
				<div class="groupBg2 groupPadding splitbar" onclick="goOnline('正在进行中')">
					<div class="groupBg2_logo groupLogo"></div>
					<span class="groupText">正在进行中</span>
					<span class="groupData" id="hs_inprogress">0</span>
				</div>
				<div class="groupBg3 groupPadding splitbar" onclick="goOnline('准备阶段')">
					<div class="groupBg3_logo groupLogo"></div>
					<span class="groupText">准备阶段</span>
					<span class="groupData" id="hs_prepare">0</span>
				</div>
				<div class="groupBg4 groupPadding splitbar" onclick="goOnline('实施|终结阶段')">
					<div class="groupBg4_logo groupLogo"></div>
					<span class="groupText">实施&nbsp;|&nbsp;终结阶段</span>
					<span class="groupData" id="hs_actualize">0</span>
				</div>
				<div class="groupBg5 groupPadding splitbar" onclick="goOnline('归档阶段')">
					<div class="groupBg5_logo groupLogo"></div>
					<span class="groupText">归档阶段</span>
					<span class="groupData" id="hs_account">0</span>
				</div>	
				<div class="groupBg6 groupPadding splitbar" onclick="goOnline('整改阶段')">
					<div class="groupBg6_logo groupLogo"></div>
					<span class="groupText">整改阶段</span>
					<span class="groupData" id="hs_rework">0</span>
				</div>	
			</div>											
		</div>
	</div>
	
	<div class="row" >
		<div class="col-md-6">
			<div class="portlet light tasks-widget" >
				<div class="portlet-title barBg title-border">
					<div class="rowTitleWrap " id="toTaskBtn">					
						<span class="rowTitle">待办事项</span>
						<span class="titleTip" id="taskTitleTip">0</span>
						<span class="rowTitleLogo"></span>						
					</div>
					<span style="width:20px;text-align:center;float:left;margin-top:2px;">|</span>
					<div class="rowTitleWrap" id="msgReminderBtn">					
						<span class="rowTitle rowTitle-disabled">消息提醒</span>
						<span class="titleTip" id="msgTitleTip">0</span>
					</div>
					<div class="tools">
						<a href="javascript:;" id="task_more" title="更多">更多
							<i class="fa fa-angle-double-right" ></i>
						</a>
					</div>
				</div>
				<div class="portlet-body body-border body-height">
					<div class="task-content">
						<div id ='todoTask'>						
							<table id="todoTaskTable" style="table-layout:fixed" class="table  table-light">
								<thead>
								<tr style="background:#e3eefd;font-weight:bold;color:#838fa1!important;">
									<th style="width:70%;">任务名称</th>
									<th style="width:100px;">提交人</th>
									<th style="width:150px;text-align:center;">提交时间</th>
								</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<ul class="task-list" id="msgReminder" style="display:none;"></ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="portlet light tasks-widget" >
				<div class="portlet-title barBg title-border">
					<div class="rowTitleWrap">					
						<span class="rowTitle">我的项目</span>
						<span class="rowTitleLogo"></span>						
					</div>
					<div class="tools">
						<a href="javascript:;" id="myProjects_more" title="更多">更多
							<i class="fa fa-angle-double-right" ></i>
						</a>
					</div>
				</div>
				<div class="portlet-body body-border body-height">
					<div class="task-content">
						<table id="myProjectsTable" style="table-layout:fixed" class="table table-light">
							<thead>
							<tr style="background:#e3eefd;font-weight:bold;color:#838fa1!important;">
								<th style="width: 50%;">项目名称</th>
								<th style="width: 30%;">项目角色</th>
								<th style="width: 20%;">当前阶段</th>
							</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>				
	</div>
</div>

<script type="text/javascript">
    var contextPath = '${contextPath}';
    var fdepid = '${user.fdepid}';
    var floginname = '${user.floginname}';
    var isInpctDept = "${isInpctDept}";

    function ranNum(len){
        try {
            len = !len ? 3 : len > 20 ? 20 : len;
            var num = 1;
            var arr = [];
            arr.push("1");
            for(var i=0; i<len-5; i++){
                arr.push("0");
            }
            num = parseInt(arr.join(""));
            var a1 = String(Math.floor(Math.random() * num));
            var d  = String(new Date().getTime());
            var a2 = d.substring(d.length-5);
            return a1+a2;
        } catch (e) {
            isdebug ? alert("Q.util.ran:\n"+e.message) : null;
        }
    }
    
    
</script>
<!--[if lt IE 9]>
<script src="${contextPath}/index/assets/global/plugins/respond.min.js"></script>
<script src="${contextPath}/index/assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script src="${contextPath}/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${contextPath}/index/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${contextPath}/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>

<%--<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>--%>
<link href="${contextPath}/easyui/querytable.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/easyui/1.4/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/easyui/1.4/themes/icon.css" rel="stylesheet" type="text/css" />
<%--<script src="${contextPath}/easyui/1.4/jquery-1.7.1.min.js" type="text/javascript"></script>--%>
<script src="${contextPath}/easyui/1.4/jquery.easyui.min.js" type="text/javascript" ></script>
<script src="${contextPath}/easyui/1.4/locale/easyui-lang-zh_CN.js" type="text/javascript" ></script>
<script src="/ais/index/preventBackspace.js" type="text/javascript" ></script>

<script src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js" type="text/javascript" ></script>
<script src="${contextPath}/index/online_firstpage.js" type="text/javascript"></script>
<jsp:include flush="true" page="/heartbeat.jsp" />

<script type="text/javascript">
$(function(){
	$('body').data('activeTabBar','todoTask');
	$('#taskTitleTip,#msgTitleTip').parent().css('cursor','pointer').bind('mouseover', function(){
		$(this).find('.rowTitle,.titleTip').addClass('rowTitle-active');
	}).bind('mouseout', function(){
		$(this).find('.rowTitle,.titleTip').removeClass('rowTitle-active');
	});
	$('#taskTitleTip').parent().bind('click', function(){
		OnlineFirstPage.todoTaskTable();
		$(this).find('.rowTitle').css('color','#333');
		$('#msgTitleTip').parent().find('.rowTitle').css('color','gray');
		$('#todoTask').show();
		$('#msgReminder').hide();
		$('body').data('activeTabBar','todoTask');
	});
	$('#msgTitleTip').parent().bind('click', function(){
		OnlineFirstPage.msgReminderTable();
		$(this).find('.rowTitle').css('color','#333');
		$('#taskTitleTip').parent().find('.rowTitle').css('color','gray');
		$('#todoTask').hide();
		$('#msgReminder').show();
		$('body').data('activeTabBar','msgReminder');
	});
	
});
</script>
</body>
</html>