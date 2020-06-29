<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目管理-项目整改</title>
		<s:head theme="ajax" />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
	</head>
	<body style="" class="easyui-layout">
		  <div region="center" id='auditWorkProgramPrepare' title=''> 
		 	<iframe id="prepareWorkProgram"
				src="${contextPath}/workprogram/viewWorkProgramProjectDetail.action?projectid=<s:property value="crudObject.project_id" />&wpd_stagecode=rework&isEdit=false&view=${param.view}"
				frameborder="0" width="100%" height="100%"></iframe> 
		<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
		 </div>  
	</body>
</html>