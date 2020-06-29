<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
<s:if test="not empty (message)">
	function loadLeft(){
		parent.tree.location.reload();
	}
	loadLeft();
</s:if>
</script>
</head>
<body>
请点击左边的树进行操作！
</body>
</html>