<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<%
    String referer = request.getHeader("referer");
    referer = referer==null? "login.jsp" : request.getHeader("referer");
    int indexp = referer.indexOf("login.jsp?");
    if(indexp!=-1){
    	referer=referer.substring(0,indexp+9);
    }
	String params = request.getParameter("params")==null?"":request.getParameter("params");

%>
<body scroll=no onload = "find()">
	<script language="JavaScript">
		function find() {
			document.me.width.value = window.screen.width;
			document.me.height.value = window.screen.height;
			document.me.submit();
		}
	</script>
	<c:set var="iecache" value="Y"/>
	<c:if test="${(not empty param.ieCache) && (param.ieCache == 'N')}">
		<c:set var="iecache" value="N"/>
	</c:if>
	<c:set var="autotest" value="N"/>
	<c:if test="${(not empty param.autoTest) && (param.autoTest == 'Y')}">
		<c:set var="autotest" value="Y"/>
	</c:if>
	<form name="me" method="post" action="<%=referer%>">
		<input type="hidden" name="width">
		<input type="hidden" name="height">
		<input type="hidden" name="iecache" value="${iecache}">
		<input type="hidden" name="autotest" value="${autotest}">
		<input type="hidden" name="indexhidder" value="1">
		<input type="hidden" name="p" value="<%=params%>">
	</form>
</body>
</html>