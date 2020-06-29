<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<title>报表模板设计－－${cellTemplate.templateName}</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
#container {
	width: 100%;
	height: 100%;
}

#content {
	width: 80%;
	text-align: left;
	float: left;
	height: 100%;
}

#sidebar {
	width: 20%;
	text-align: left;
	float: right;
	height: 100%;
}
#leftTree{
	border-style: double;
}
#childBasefrm{
	border-style: dotted;border-width: 1px
}
</style>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
<div id="container">
<div id="content"><iframe name="leftTree" width="100%"
	frameborder="0" height="100%" style="border-style: double;"
	src="/ais/report/ct/mainSign.action?id=${id }"></iframe>
</div>
<div id="sidebar"><iframe name="childBasefrm" width="100%"
	frameborder="0" height="100%"
	src="<s:url action="formulaTree" namespace="/report/ct"></s:url>"></iframe>
</div>
</div>
</body>
</html>