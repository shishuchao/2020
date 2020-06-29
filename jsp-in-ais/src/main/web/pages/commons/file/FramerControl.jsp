<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
    String _ServerName = request.getServerName();
    int _ServerPort = request.getServerPort();
    String _CtxPath = request.getContextPath();
%>

<%
String fileId = request.getParameter("fileId");
String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
String url = url_prefix+ "/commons/file/downloadFile.action?fileId="+fileId;
url = url_prefix+ "/download/file"+fileId;
System.out.println(" url:" + url_prefix+"/commons/file/downloadFile.action?fileId="+fileId);
%>
<html>
<head>
<title>就地编辑</title>

<style>
body { font-family:宋体; font-size:9pt; color:black; cursor:default; margin:0; }
td { font-family:宋体; font-size:9pt; color:black; cursor:default; }
.icon { font-family:Wingdings; font-size:12pt; cursor:default; display:none; }
.fakehlink {cursor: hand; text-decoration: underline; color: #0066CC; font-weight:normal;}
</style>
<script type="text/javascript" src="object.js"></script>
<script language="VBScript">
Function oFramer_OnCommand(cmd, arg)

    
    Select Case UCase(cmd)
    Case "SAVE"
      u = "<%=_CtxPath%>/commons/file/saveEditedFile.action?fileId=<%=fileId%>"
	        result = oFramer.SaveToServer(u)
	        MsgBox result, 0, "保存文档"
    Case Else

    End Select            
End Function
</script>

<script language="JavaScript">
function onBodyLoaded() {
    document.body.scroll = "no";
    insertObject("<%=url_prefix%>");
    if (typeof(document.all("oFramer")) == "undefined" || typeof(document.all("oFramer").Open) == "undefined") {
        alert("Excel 操作失败");
        return;
    }
    oFramer.Open("<%=url%>");
	oFramer.focus();
}
function onBodyUnload() {
    if (typeof(document.all("oFramer")) == "undefined" || typeof(document.all("oFramer").Open) == "undefined") {
        return;
    }
    oFramer.close();
}
function onBodyFocus() {
	try{
    	window.setTimeout("oFramer.Activate()", 0);
    }catch(e){
    
    }
}
</script>
<style>
input { behavior:url(/res/input.htc);font-family:宋体; font-size:9pt; padding-top:2px; border:1pt solid #99cccc; text-indent:1px; }
</style>
</head>
<body onload="onBodyLoaded()" onunload="onBodyUnload()" onfocus="onBodyFocus()">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr height="100%">
<td valign="top" width="100%">
<div id="oFramerDiv">
<!--
<object classid="clsid:00000103-92E6-4AB6-A701-C40315913A5D"
    id="oFramer"
    width="100%"
    height="100%"
    codebase="<%=url_prefix%>\scripts\CofiAskExt.CAB#version=1,0,0,1"
    >
    <param name="IsPromptSave" value="false">
    <param name="BorderStyle" value="0">
    <param name="Caption" value="This is the Caption">
</object>
-->
</div>
</td>
</tr>
</table>
</body>
</html>