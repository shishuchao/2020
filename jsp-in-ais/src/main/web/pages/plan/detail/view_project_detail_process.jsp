<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
	    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>离线项目查看</title>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<body style="overflow: hidden;">
<%--		<input id='yearPlanPanel' type='hidden' value='${param.selectedTab}' />--%>

		<div id="qtabs" class="easyui-tabs" fit="true">
			<div id='basicInfoDiv' title='基本信息' style="overflow: hidden;">
				<iframe width="100%" height="100%" frameborder="0" id="basicInfo" src=""></iframe>
			</div>
			<div id='processInfoDiv' title='进度填报信息' style="overflow: hidden;">
				<iframe width="100%" height="100%" frameborder="0" id="processInfo" src=""></iframe>
			</div>
		</div>
		<script type="text/javascript">
			var finishCode = "<s:property value="@ais.project.ProjectContant@PROCESS_FINISH" />";
			$(function () {
				if ($('#basicInfo')){
					var url = "${contextPath}/plan/detail/view.action?crudId=${param.projectId}";
					$('#basicInfo').attr('src', url);
				}

				if ($('#processInfo')){
					var url = "${contextPath}/project/process/edit.action?plan_form_id=${param.startId}&processCode=${param.processCode}&finishCode=" + finishCode + "&view=view";
					$('#processInfo').attr('src', url);
				}
			})
		</script>

	</body>
</html>