<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>项目详细信息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
	</head>

	<body>
		<div id='projectInfoTabPanel' class="easyui-tabs" fit="true" style="overflow:visible;">
			<div id='projectInfo' title='项目信息'>
				<iframe id="projectInfoFrame"
					src="${contextPath}/project/start/view4Panel.action?project_id=<s:property value="crudId"/>"
					frameborder="0" width="100%" height="500"></iframe>
			</div>
			<div id='prepareInfo' title='准备阶段'>
				<s:if test="${projectStartObject.prepare_closed=='1'}">
				<iframe id="prepareInfoFrame"
					src="${contextPath}/project/prepare/view4Panel.action?project_id=<s:property value="crudId"/>"
					frameborder="0" width="100%" height="500"></iframe>
				</s:if>
				<s:else>
				<iframe id="prepareInfoFrame"
					src="${contextPath}/project/prepare/edit4Panel.action?project_id=<s:property value="crudId"/>"
					frameborder="0" width="100%" height="500"></iframe>
				</s:else>	
			</div>
			<div id='actualizeInfo' title='实施阶段'>
				<s:if test="${projectStartObject.actualize_closed=='1'}">
				<iframe id="actualizeInfoFrame"
					src="${contextPath}/project/actualize/view4Panel.action?viewPermission=<s:property value="viewPermission"/>&project_id=<s:property value="crudId"/>"
					frameborder="0" width="100%" height="500"></iframe>
				</s:if>	
				<s:else>
				<iframe id="actualizeInfoFrame"
					src="${contextPath}/project/actualize/edit4Panel.action?viewPermission=<s:property value="viewPermission"/>&project_id=<s:property value="crudId"/>"
					frameborder="0" width="100%" height="500"></iframe>
				</s:else>
			</div>
			<div id='reprotInfo' title='终结阶段'>
				<s:if test="${projectStartObject.report_closed=='1'}">
				<iframe id="reportInfoFrame"
					src="${contextPath}/project/report/view4Panel.action?project_id=<s:property value="crudId"/>&viewPermission=${viewPermission}"
					frameborder="0" width="100%" height="500"></iframe>
				</s:if>
				<s:else>
				<iframe id="reportInfoFrame"
					src="${contextPath}/project/report/edit4Panel.action?project_id=<s:property value="crudId"/>&viewPermission=${viewPermission}"
					frameborder="0" width="100%" height="500"></iframe>
				</s:else>
			</div>
			<s:if test="@ais.project.ProjectSysParamUtil@isXMTZEnabled()">
				<div id='tzInfo' title='项目台账'>
					<iframe id="tzFrame"
						src="${contextPath}/proledger/custom/createLedgerTabs.action?project_id=${crudId}&isView=true&permission=${viewPermission}"
						frameborder="0" width="100%" height="500"></iframe>
				</div>
			</s:if>
			<s:if test="@ais.project.ProjectSysParamUtil@isReworkStageEnabled()">
				<div id='reworkInfo' title='整改跟踪阶段'>
					<s:if test="${projectStartObject.rework_closed=='1'}">
					<iframe id="reworkInfoFrame" 
						src="${contextPath}/project/rework/view4Panel.action?project_id=<s:property value="crudId"/>"
						frameborder="0" width="100%" height="500"></iframe>
					</s:if>
					<s:else>
					<iframe id="reworkInfoFrame" 
						src="${contextPath}/project/rework/edit4Panel.action?project_id=<s:property value="crudId"/>"
						frameborder="0" width="100%" height="500"></iframe>
					</s:else>	
				</div>
			</s:if>
		</div>
	</body>
</html>
