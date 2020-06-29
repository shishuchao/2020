<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="ais.framework.util.MyProperty" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="ais.user.model.UUser" %>

<html>
<head>
    <title>审计系统单点登陆</title>
</head>
<script type="text/javascript">
	var ivUser = '<%=request.getHeader("iv-user")%>';
	ChangeUrl(ivUser);
	function ChangeUrl(ivUser) {
	        var url = "http://";
	        url += "audit.";
	        url += "sinochem.";
	        url += "com"
	        url += "/ais/j_acegi_security_check?"
	        	    +"j_username=" + ivUser + "&from=app"
	        window.top.location.href = url;
	  }

</script>
<body>
</body>
</html>