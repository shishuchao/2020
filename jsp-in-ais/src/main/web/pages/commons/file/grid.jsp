<%
String _CtxPath = request.getContextPath();
String fileId = request.getParameter("fileId");

String url = _CtxPath + "/commons/file/downloadFile.action?fileId="+fileId;


%>
<html>
	<head>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css"
			rel="stylesheet" type="text/css">
	</head>
	<title></title>
	<body onload="onBodyLoaded()">
		<script language="JavaScript">
function onBodyLoaded(){
        xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
        xslDoc = new ActiveXObject('Microsoft.XMLDOM'); 
        xmlDoc.async = false;
        xslDoc.async = false;     
        xmlDoc.load("<%=url%>"); 
        xslDoc.load("grid.xsl");
        gridPanel.innerHTML = xmlDoc.documentElement.transformNode(xslDoc);
        //alert(gridPanel.innerHTML);
}
</script>
		<div id="gridPanel"></div>
	</body>
</html>