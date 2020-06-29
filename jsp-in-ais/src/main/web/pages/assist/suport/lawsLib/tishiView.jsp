<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title> </title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>  
<script type="text/javascript">
$(function(){	
	var menuPid = '${menuPId}';
	if(menuPid){
		parent.loadParentTree(menuPid); 		
	}
});
${malert}
${jspRefresh}
</script>

</head>
<body style="overflow-y: hidden">
${message}
	<center>
	<br>
	<br>
	<br>
	<br>
	<h3><font color="#1b6252">请您点击左侧树形结构节点进行查看</font></h3>
	<br>
	<br>
	<br>
	<br>
	<br>
	</center>
</body>
</html>