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

<s:iterator value="msg.list">
<li><s:property value="info" escape="false"/></li>
</s:iterator> 
<br>

<%

  //显示自动跳转，【现在尚无法自动跳转】
  //String autoLocationStr=msg.getAutoLocationString();
  //String autoLocationUrl=msg.getAutoLocationUrl();
  //if (autoLocationStr!=null && !autoLocationStr.trim().equals("") && autoLocationUrl!=null && !autoLocationUrl.trim().equals("")){
  //out.println("<tr><td><li>系统5秒后自动跳转至 <a href='"+autoLocationUrl+"'>"+autoLocationStr+"</a></td></tr>");
  //}
%>

</div>
</div>
<br>
</FIELDSET>
</div>


<br>


</body>
</html>

