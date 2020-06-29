<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>

<html>

<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>经济责任人多选</title>
</head>

<frameset cols="250,*" frameborder="no" border="0" framespacing="0">
	<s:url id="url1" action="economyDutyAction" method="selectTree" namespace="/mng/economyduty">
		<s:param name="audobjid" value="#parameters.audobjid[0]"></s:param>
	</s:url>
    <frame src="<s:text name="%{url1}"/>" name="_left" scrolling="Auto" style="width: 23%" noresize>
    <frame src="" name="main" style="width: 77%">
</frameset>

<noframes>
	<body>
		对不起，您的浏览器不支持框架。请采用IE6.0以上版本浏览器进行浏览......
	</body>
</noframes>

</html>