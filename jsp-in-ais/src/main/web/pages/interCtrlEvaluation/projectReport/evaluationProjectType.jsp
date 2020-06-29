<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计报告维护</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true'>
		<div region="center" border='0'>
			<div class='easyui-tabs' fit='true' border='0'>
		<%-- 		<div  title='审计报告'>
					<iframe src="${contextPath}/pages/unitary/nc/report/projectTypeList.jsp" frameborder="0" width="100%" height="98%"  ></iframe>
				</div>
				<div  title='审计通知书' >
					<iframe src="${contextPath}/unitary/nc/autoreport/adviceData.action" frameborder="0" width="100%" height="98%" ></iframe>
					<iframe src="${contextPath}/pages/unitary/nc/report/projectTypeList2.jsp" frameborder="0" width="100%" height="98%" ></iframe>
				</div>
				<div  title='文书模板' >
					<iframe src="${contextPath}/pages/unitary/nc/report/writerTemplateList.jsp" frameborder="0" width="100%" height="98%" ></iframe>
				</div> --%>
				<div  title='内控评价报告' >
					<iframe src="${contextPath}/pages/interCtrlEvaluation/projectReport/evaProjectTypeList.jsp" frameborder="0" width="100%" height="98%" ></iframe>
				</div>
			</div>
		</div>
	</body>
</html>
