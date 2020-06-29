<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<TITLE> 当前在线人信息 </TITLE>

	<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<style type="text/css">
body{width:80%;text-align: center;}
</style>
<script language="Javascript">

</script>
</HEAD>
<BODY topmargin=0 leftmargin=0 > 

<display:table name="list" id="row" class="its" pagesize="10" requestURI="uSystemAction!onLineUsers.action" excludedParams="*">
	
	<display:column  title ="账号" property ="floginname" sortable="true" headerClass="center" class="center"></display:column>
	<display:column  title ="姓名" property ="fname" sortable="true" headerClass="center" class="center"></display:column>
</display:table>
<br>
<div style="text-align: center;">
<input type="button" value="关闭" onclick="window.close()">
</div>
</BODY>
</HTML>