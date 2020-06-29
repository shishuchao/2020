<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
	<s:if test="${message == 'reload'}">
		var node = window.parent.parent.$('#treeMatter').tree('getSelected');
		var parentNode = window.parent.parent.$('#treeMatter').tree('getParent',node.target);
		window.parent.parent.$('#treeMatter').tree('reload',parentNode.target);
	</s:if>
</script>
</head>
<body>
<h2>请点击左边的树进行操作！</h2>
</body>
</html>