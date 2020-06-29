<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<s:head theme="ajax" />
<title>系统通知</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function PopWin(url,name)
{
	window.open(url,name,,"height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
} 
</script>

</head>
<body>
<br>
<s:tabbedPanel id='test' theme='ajax'>
	<s:if test="${hasRemindMessage=='true'}">
		<s:div id='rem' label='催办信息' theme='ajax' labelposition='top'
			loadingText="正在加载内容......">
			<iframe frameborder="0" height="250" width="100%" scrolling="auto" src="${contextPath}/bpm/reminder/list4portal.action"></iframe>
		</s:div>
	</s:if>
	<s:if test="${hasPersonalProgramme=='true'}">
		<s:div id='pernPgm' label='个人计划' theme='ajax' labelposition='top'
			loadingText="正在加载内容......">
			<iframe frameborder="0" height="250" width="100%" scrolling="auto" src="${contextPath}/plan/personalprogramme/list4portal.action"></iframe>
		</s:div>
	</s:if>
</s:tabbedPanel>
<br>
<br>
<br>
<div align="center"><s:button value="关 闭"
	onclick="javascript:window.close();" /></div>
</body>
</html>

