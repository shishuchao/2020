<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>ais login jsp</title>
</head>
<body>
<center>

<%response.sendRedirect(request.getContextPath()+"/system/uSystemAction!login.action");%>
</center>
</body>
</html>