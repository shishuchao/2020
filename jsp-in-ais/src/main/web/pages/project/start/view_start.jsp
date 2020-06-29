<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目基本信息</title>
		<s:head theme="ajax" />
		<style type="text/css">
			body { text-align:center; }
			#wrap { 
				width:98%;
				text-align:left;
				margin:10px auto;
				overflow:hidden;
			} 
		</style>
	</head>
	<body>
		<div id="wrap" >
			<jsp:include page="/pages/project/start/edit_start_include_readonly.jsp" />
		</div>
	</body>
</html>
