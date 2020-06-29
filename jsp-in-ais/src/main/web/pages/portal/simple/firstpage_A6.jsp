<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>A6风控审计信息化平台</title>
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
	padding-top:0px!important;
	padding-bottom:0px!important;
	padding-left:1px!important;
	padding-right:1px!important;
	margin:0px!important;
}
.portlet{
	padding-top:0px!important;
	padding-right:5px!important;
	padding-bottom:5px!important;
	padding-left:5px!important;
}
.portlet-title{
	min-height:22px!important;
}
.portlet.light > .portlet-title > .tools{
	padding-top:0px!important;
	padding-bottom:0px!important;
	padding-right:0px!important;
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
</style>
</head>
<body style="background: white;">
<div class="container-fluid" style="margin-top: 10px;">
	<div class="row">
		<div class="col-md-8 rowPadding">		
			<div class="portlet light tasks-widget" style="min-height:180px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" 
					style="position:relative;left:44.8%;border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">图片新闻</button>
				</div>
				<div class="portlet-body">
					<div class="col-md-5">
						<div id="newsbody"></div>
					</div>	
					<div class="col-md-7">
						<ul id="newsInfoList"></ul>
					</div>	
				</div>
			</div>		
		</div>
		<div class="col-md-4 rowPadding">
			<div class="portlet light tasks-widget " style="height:180px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:100px;margin-left: 30px;">审计待办事项</button>
					<div class="tools">
						<a href="javascript:;" id="todo_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="todo_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body" style="padding-left: 20px;">
					<div class="task-content">
						<ul class="task-list" id="todoTask"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12 rowPadding" style="padding:1.0em 0.1em 0.4em 0.1em;">
			<div class=" light" style="display: none;">
				<div class="portlet-body" style="padding:0px;text-align:center;vertical-align:middle;">
					<img src='${contextPath}/index/assets/global/img/middleWords.jpg' style='padding:0px;margin:0px;width:100%;height:100%;'></img>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 rowPadding">
			<div class="portlet light " style="height:180px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width: 140px;">审计计划执行情况</button>
					<div class="tools">
						<a href="javascript:;" id="plan_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
					</div>
				</div>
				<s:if test="${magOrganization.fid} == '1000'">
					<span style="float:right">
						<a href="javascript:;" onclick="onGroupClick()">全集团</a>
						<a href="javascript:;" onclick="onPartClick()">各事业部</a>
					</span>
				</s:if>
				<div class="portlet-body" style="padding-top: 30px!important;">
					<div id="planEcharts" style="height:180px;width:100%;"></div>
				</div>
			</div>
		</div>
		<div class="col-md-6 rowPadding">
			<div class="portlet light tasks-widget " style="height:180px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:140px;">实施项目阶段统计</button>
					<div class="tools">
						<a href="javascript:;" id="projectInfo_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="projectInfo_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="task-content">
						<ul class="task-list" id="projectInfoList"></ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-3 rowPadding">
			<div class="portlet light " style="height:180px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">常用查询</button>
				</div>
				<div class="portlet-body" style="padding-top: 10px!important;">
					
						<table class="table table-light" style="text-align: center;margin-top:35px;">
							<tr>
								<td style="cursor:pointer;line-height:0.2em;padding:0px;border:0px!important;" onclick="hotlink(1)">
									<span style="height:40px;width:50px;display:inline-block;">
										<i class="fa fa-globe" style="font-size:2.5em;color:#5CA4C7;position: relative;top:15%;"></i>
									</span>
									<p>审计对象</p>
								</td>
								<td style="cursor:pointer;line-height:0.2em;padding:0px;border:0px!important;" onclick="hotlink(2)">
									<span style="height:40px;width:50px;display:inline-block;">
										<i class="fa fa-group" style="font-size:2.5em;color:#5CA4C7;position: relative;top:15%;"></i>
									</span>
									<p>审计人员</p>
								</td>
							</tr>
							<tr>
								<td style="cursor:pointer;line-height:0.2em;" onclick="hotlink(3)">
									<span style="height:40px;width:50px;display:inline-block;">
										<i class="fa fa-map" style="font-size:2.5em;color:#5CA4C7;position: relative;top:15%;"></i>
									</span>
									<p>审计成果</p>
								</td>
								<td style="cursor:pointer;line-height:0.2em;" onclick="hotlink(4)">
									<span style="height:40px;width:50px;display:inline-block;">
										<i class="fa fa-tasks" style="font-size:2.5em;color:#5CA4C7;position: relative;top:10%;"></i>
									</span>
									<p>审计项目</p>
								</td>
							</tr>
						</table>
					
				</div>
			</div>
		</div>
	</div>
	<div style="height: 40px;">&nbsp;</div>
	<div class="row">
		<div class="col-md-3 rowPadding">
			<div class="portlet light tasks-widget " style="height:140px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">通知公告</button>
					<div class="tools">
						<a href="javascript:;" id="notification_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="notification_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="task-content">
						<ul class="task-list" id="infoTable"></ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-3 rowPadding">
			<div class="portlet light tasks-widget " style="height:140px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">学习园地</button>
					<div class="tools">
						<a href="javascript:;" id="garden_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="garden_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="task-content">
						<ul class="task-list" id="studyGarden"></ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-3 rowPadding">
			<div class="portlet light tasks-widget " style="height:140px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:100px;">审计工作标准</button>
					<div class="tools">
						<a href="javascript:;" id="workStandard_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="workStandard_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="task-content">
						<ul class="task-list" id="workStandardList"></ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-3 rowPadding">
			<div class="portlet light tasks-widget " style="height:140px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">法律法规</button>
					<div class="tools">
						<a href="javascript:;" id="flfg_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="flfg_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="task-content">
						<ul class="task-list" id="flfgList">

						</ul>
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
    		url = "${contextPath}/project/listAll.action";
    		tabId = ranNum(10);
    	}
    	//alert(title +"\n"+ url+"\n"+tabId)
    	parent.goMenu(title,url,tabId);
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
</body>
</html>