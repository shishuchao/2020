<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>blank</title>
<%
String filepath = (String)request.getAttribute("filepath");
%>
<script type="text/javascript">

</script>
</head>
<body>
<img alt="" src='/ais/<%=filepath%>'>
</body>
</html>