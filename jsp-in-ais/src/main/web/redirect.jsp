<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<title>
redirect
</title>
</head>
<body bgcolor="#ffffff">
<script language='javascript'>
<s:property value="#request.uRedirect.result" escape="false"/>
</script> 
</body>
</html>
