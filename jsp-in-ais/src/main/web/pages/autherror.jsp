<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>系统提示</title>
		<style>
		input{border:1px double #7F9DB9;}
		textarea{border:1px double #7F9DB9;}
		</style>
		
		
</head>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />

<body>

<br><br><br><br>
<div align="center">
<FIELDSET style="width:550"><LEGEND><font color="blue">系统提示：</font></LEGEND>
<br>
<div align="center">
<div class="cfblk" style="width:300pt" >

<COLGROUP>
<COL width="65">
<COL width="*">
<li>您没有授权</li>
<!-- 
<li><a href="javascript:;" onclick="javascript:top.window.location.href='/ais';">返回 </a></li>
 -->
</div>
</div>
<br>
</FIELDSET>
</div>
<br>


</body>
</html>

