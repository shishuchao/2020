<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>AIS审计信息化平台</title>
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
</style>
</head>
<body style="background: white;overflow-x:hidden;">
<div class="container-fluid">
	<div class="row">
		<div class="col-md-8 rowPadding">		
			<div class="portlet light tasks-widget " style="min-height:180px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" 
						style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">新闻中心</button>					
				</div>
				<div class="portlet-body">
					<div class="col-md-6">
						<div id="newsbody" style="padding-top:2px; margin-left:-15px;"></div>
					</div>	
					<div class="col-md-6">
						<ul id="newsInfoList"></ul>
					</div>	
				</div>
			</div>		
		</div>
		<div class="col-md-4 rowPadding">
			<div class="portlet light tasks-widget " style="min-height:180px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" 
					style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">法律法规</button>
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
						<ul class="task-list" id="flfgList"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 rowPadding">
			<div class="portlet light tasks-widget " style="min-height:140px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" 
					style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">计划信息</button>
					<div class="tools">
						<a href="javascript:;" id="planInfo_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="planInfo_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="task-content">
						<ul class="task-list" id="planInfoList"></ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6 rowPadding">
			<div class="portlet light tasks-widget " style="min-height:140px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" 
					style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">人员信息</button>
					<div class="tools">
						<a href="javascript:;" id="userInfo_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="userInfo_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="task-content">
						<ul class="task-list" id="userInfoList"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-6 rowPadding">
			<div class="portlet light tasks-widget " style="min-height:140px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" 
					style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">项目信息</button>
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
		<div class="col-md-6 rowPadding">
			<div class="portlet light tasks-widget " style="min-height:140px;">
				<div class="portlet-title">
					<button class="btn btn-circle-top btn-primary" 
					style="border-radius: 7px 7px 0 0!important;margin-top:0px!important;width:80px;">成果信息</button>
					<div class="tools">
						<a href="javascript:;" id="resultInfo_reload" title="刷新">
							<i class="fa fa-refresh"></i>
						</a>
						<a href="javascript:;" id="resultInfo_more" title="更多">
							<i class="fa fa-angle-double-right" style="font-size: 1.5em;"></i>
						</a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="task-content">
						<ul class="task-list" id="resultInfoList"></ul>
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
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<%-- <jsp:include flush="true" page="/heartbeat.jsp" /> --%>
</body>
</html>