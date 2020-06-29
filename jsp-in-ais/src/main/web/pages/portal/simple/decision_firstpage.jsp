<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="utf-8" />
	<title>${parentMenu.ffundisplay}</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<meta content="" name="description" />
	<link href="${contextPath}/index/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/bootstrap-addtabs/bootstrap.addtabs.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/plugins/jqtip/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
	<link href="${contextPath}/index/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/index/assets/layouts/layout2/css/themes/light.css" rel="stylesheet" type="text/css" id="style_color" />
	<style>
		.longTD{
			overflow:hidden;
			white-space:nowrap;
			text-overflow:ellipsis;
		}
	</style>
</head>
<body style="background: white;">
	<div class="container-fluid" style="margin-top: 10px;">
		<div class="row">
			<div class="col-lg-6 col-md-6 col-xs-6">
				<div class="portlet light bordered" id="problem_type" style="height: 450px;">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-pie-chart"></i>审计问题分布（按问题类别）</div>
						<div class="tools">
							<a href="javascript:;" id="problem_type_reload" title="刷新">
								<i class="glyphicon glyphicon-refresh"></i>
							</a>
						</div>
					</div>
					<div class="portlet-body">
						<div id="problemTypeChart" style="height: 420px;width:90%;"></div>
					</div>

				</div>
			</div>
			<div class="col-lg-6 col-md-6 col-xs-6">
				<div class="portlet light bordered" id="problem_protype" style="height: 450px;">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-pie-chart"></i>审计问题分布（按项目类别）</div>
						<div class="tools">
							<a href="javascript:;" id="problem_protype_reload" title="刷新">
								<i class="glyphicon glyphicon-refresh"></i>
							</a>
						</div>
					</div>
					<div class="portlet-body">
						<div id="problemChart" style="height: 420px;width:90%;"></div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script type="text/javascript">
		var contextPath = '${contextPath}';
	</script>
	<!--[if lt IE 9]>
	<script src="${contextPath}/index/assets/global/plugins/respond.min.js"></script>
	<script src="${contextPath}/index/assets/global/plugins/excanvas.min.js"></script>
	<![endif]-->
	<!-- BEGIN CORE PLUGINS -->
	<script src="${contextPath}/index/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/moment.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/fullcalendar/lang/zh-cn.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/jqtip/jquery.qtip.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/plugins/echarts/echarts.min.js" type="text/javascript"></script>
	<script src="${contextPath}/index/assets/global/scripts/app.min.js" type="text/javascript"></script>

	<script src="${contextPath}/index/decision_firstpage.js" type="text/javascript"></script>
	
	<%-- <jsp:include flush="true" page="/heartbeat.jsp" /> --%>
</body>
</html>