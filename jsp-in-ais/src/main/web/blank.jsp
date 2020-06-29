<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>blank</title>
<script type="text/javascript">
<%
	String s=(String)request.getAttribute("tip");
	if(s!=null&&s.length()>0){
	out.write("alert('"+s+"')");
	}
%>
</script>
</head>
<body>	
</body>
</html>