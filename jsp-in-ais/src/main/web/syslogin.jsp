<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.apache.commons.lang.StringUtils"%><html>
<head>
<title>cellrpt login jsp</title>
</head>
<body>
<center>
<%
String syssend=request.getParameter("syssend");
String u=request.getParameter("u");
String n=request.getParameter("n");
String p=request.getParameter("p");
if(StringUtils.isEmpty(syssend)){
	syssend="ais";
}
if(StringUtils.isEmpty(u)){
	u="";
}
if(StringUtils.isEmpty(n)){
	n="";
}
if(StringUtils.isEmpty(p)){
	p="";
}
	response.sendRedirect("system/uSystemAction!sysSend.action?syssend="+syssend+"&u="+u+"&n="+n+"&p="+p);%>
</center>
</body>
</html>