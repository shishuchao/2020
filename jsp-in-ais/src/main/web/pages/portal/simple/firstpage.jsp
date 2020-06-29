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
.task-list li:hover{
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
	background: url('${contextPath}/index/assets/global/img/a7/groupBg1_logo.png') no-repeat center;
}
.groupBg2{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg5.png') repeat center;
}
.groupBg2_logo{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg2_logo.png') no-repeat center;
}
.groupBg3{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg4.png') repeat center;
}
.groupBg3_logo{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg3_logo.png') no-repeat center;
}
.groupBg4{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg2.png') repeat center;
}
.groupBg4_logo{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg4_logo.png') no-repeat center;
}
.groupBg5{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg3.png') repeat center;
}
.groupBg5_logo{
	background: url('${contextPath}/index/assets/global/img/a7/groupBg5_logo.png') no-repeat center;
}
.groupPadding{
	overflow: hidden;
	margin:20px 0px 20px 0px;
	padding:0px;
	height:100px;
	width:19.6%;
	display:inline-block;
	text-align:center;
	position:relative;
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
.col-md-8,.col-md-4,.col-md-7,.col-md-5{
	padding-left:0px !important;
	padding-right:0px !important;
}
.rowTitleWrap{
	display:inline;
	position:relative;
	float:left;
	width:150px;
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
	height:190px;
	margin-top:2px;
}
.body-height2{
	height:240px;
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
	width:19%;

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
			<div class="portlet-body title-border" id="homeStBar" style="white-space:nowrap;">
				<div class="groupBg1 groupPadding ">
					<div class="groupBg1_logo groupLogo"></div>
					<span class="groupText">计划完成率</span>
					<span class="groupData" id="jhwcl">0%</span>
				</div>
				<div class="groupBg2 groupPadding splitbar">
					<div class="groupBg2_logo groupLogo"></div>
					<span class="groupText">发现问题数</span>
					<span class="groupData" id="fxwts">0</span>
				</div>
				<div class="groupBg3 groupPadding splitbar">
					<div class="groupBg3_logo groupLogo"></div>
					<span class="groupText">整改完成率</span>
					<span class="groupData" id="zgwcl">0%</span>
				</div>
				<div class="groupBg4 groupPadding splitbar">
					<div class="groupBg4_logo groupLogo"></div>
					<span class="groupText">查出违纪违规金额(万元)</span>
					<span class="groupData" id="wjwgje">0</span>
				</div>
				<div class="groupBg5 groupPadding splitbar">
					<div class="groupBg5_logo groupLogo"></div>
					<span class="groupText">已纠正违纪违规资金(万元)</span>
					<span class="groupData" id="yccwjwgzj">0</span>
				</div>	
			</div>								
		</div>
	</div>
	
	<div class="row" style="margin-top:5px!important;">
		<div class="col-md-7" >
			<div class="portlet light tasks-widget" >
				<div class="portlet-title barBg title-border">
					<div class="rowTitleWrap " id="toTaskBtn">					
						<span class="rowTitle">审计待办事项</span>
						<span class="titleTip" id="taskTitleTip">0</span>
						<span class="rowTitleLogo"></span>						
					</div>
					<span style="width:20px;text-align:center;float:left;margin-top:2px;">|</span>
					<div class="rowTitleWrap" id="msgReminderBtn">					
						<span class="rowTitle rowTitle-disabled">消息提醒</span>
						<span class="titleTip" id="msgTitleTip">0</span>
					</div>
					<div class="tools">
						<!--  
						<a href="javascript:;" id="todo_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						-->
						<a href="javascript:;" id="todo_more" title="更多">更多
							<i class="fa fa-angle-double-right" ></i>
						</a>
					</div>
				</div>
				<div class="portlet-body body-border body-height">
					<div>
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
		<div class="col-md-5">
			<div class="portlet light tasks-widget" >
				<div class="portlet-title barBg title-border">
					<div class="rowTitleWrap">					
						<span class="rowTitle">常用查询</span>
						<span class="rowTitleLogo"></span>						
					</div>
				</div>
				<div class="portlet-body body-border body-height" style="text-align:center;white-space:nowrap;">							
					<div class="logoWrap" onclick="hotlink(1)">						
						<span class="icon-sjdx logo"></span>
						<div class="text">审计对象</div>
					</div>
					<div class="logoWrap" onclick="hotlink(2)">
						<span class="icon-sjry logo"></span>
						<div class="text">审计人员</div>
					</div>
					<div class="logoWrap" onclick="hotlink(3)">
						<span class="icon-sjcg logo"></span>
						<div class="text">审计成果</div>
					</div>
					<div class="logoWrap" onclick="hotlink(4)">
						<span class="icon-sjxm logo"></span>
						<div class="text">审计项目</div>
					</div>
					<div class="logoWrap" onclick="hotlink(5)">
						<span class="icon-fgcx logo"></span>
						<div class="text">法规查询</div>
					</div>
				</div>
			</div>
		</div>				
	</div>

	<div class="row">
		<div class="col-md-7">
			<div class="portlet light tasks-widget " >
				<div class="portlet-title barBg title-border">
					<div class="rowTitleWrap">					
						<span class="rowTitle">实施项目阶段统计</span>
						<span class="rowTitleLogo"></span>						
					</div>
					<div class="tools">
						<!-- 
						<a href="javascript:;" id="projectInfo_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>-->
						<a href="javascript:;" id="projectInfo_more" title="更多">更多
							<i class="fa fa-angle-double-right"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body body-border body-height2">
					<div class="task-content">
						<ul class="task-list" id="projectInfoList"></ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-5">
			<div class="portlet light tasks-widget " >
				<div class="portlet-title barBg title-border">
					<div class="rowTitleWrap">					
						<span class="rowTitle">学习园地</span>
						<span class="rowTitleLogo"></span>						
					</div>
					<div class="tools">
						<!-- 
						<a href="javascript:;" id="garden_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>-->
						<a href="javascript:;" id="garden_more" title="更多">更多
							<i class="fa fa-angle-double-right"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body body-border body-height2">
					<div class="task-content">
						<ul class="task-list" id="studyGarden"></ul>
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
    function hotlink(linkIndex){
    	var title = "";
    	var url = "";
    	var tabId = "";
    	if(linkIndex == '1'){
    		title = "审计对象";
    		url = "${contextPath}/mng/audobj/object/index.action?status=view";
    		tabId = ranNum(10);
    	}else if(linkIndex == '2'){
    		title = "审计人员";
    		url = "${contextPath}/mng/employee/employeeInfoList.action";
    		tabId = ranNum(10);
    	}else if(linkIndex == '3'){
    		title = "审计成果";
    		url = "${contextPath}/archives/pigeonhole/searchArchivesList.action";
    		tabId = ranNum(10);
    	}else if(linkIndex == '4'){
    		title = "审计项目";
    		//url = "${contextPath}/project/listAll.action";
			//改为审计成果-审计项目查询 by zxl 20-03-10
			url = "${contextPath}/operate/manuExt/listAuditProject.action";
    		tabId = ranNum(10);
    	}else if(linkIndex == '5'){
    		title = "法规查询";
    		url = "${contextPath}/pages/assist/suport/lawsLib/search.action?fristType=2&mCodeType=flfg&nodeid=-1&m_view=view";
    		tabId = ranNum(10);
    	}
    	//alert(title +"\n"+ url+"\n"+tabId)
    	//parent.goMenu(title,url,tabId);
    	openInpectModelWindow(title, url);
    }
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
<script src="${contextPath}/index/firstpage.js" type="text/javascript"></script>
<%--<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>--%>
<link href="${contextPath}/easyui/querytable.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/easyui/1.4/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/easyui/1.4/themes/icon.css" rel="stylesheet" type="text/css" />
<%--<script src="${contextPath}/easyui/1.4/jquery-1.7.1.min.js" type="text/javascript"></script>--%>
<script src="${contextPath}/easyui/1.4/jquery.easyui.min.js" type="text/javascript" ></script>
<script src="${contextPath}/easyui/1.4/locale/easyui-lang-zh_CN.js" type="text/javascript" ></script>
<script src="/ais/index/preventBackspace.js" type="text/javascript" ></script>

<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>

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
		FirstPageTables.todoTaskTable();
		$(this).find('.rowTitle').css('color','#333');
		$('#msgTitleTip').parent().find('.rowTitle').css('color','gray');
		$('#todoTask').show();
		$('#msgReminder').hide();
		$('body').data('activeTabBar','todoTask');
	});
	$('#msgTitleTip').parent().bind('click', function(){
		FirstPageTables.msgReminderTable();
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