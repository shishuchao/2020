<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
<title>重复提交</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 

</head>
<body>
<div class="easyui-panel" title="数据非法，所提交的数据不能含有" border="0">
	<div style="padding:10px 20px 20px 50px; text-align:left; line-height:30px;">
		<li>“'(英文单引号，可采用中文单引号)”</li>
		<li>“"(英文双引号，可采用中文双引号)”</li>
		<li>“<(左尖括号)”</li>
		<li>“>(右尖括号)”</li>
		<li>“$(美元符号)”</li>
	</div>

</div>
<!-- End Save for Web Slices -->
</body>
</html>

