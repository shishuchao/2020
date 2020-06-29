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
String url = url_prefix+ "/commons/file/getEditedFile.action?fileId="+fileId;

System.out.println(" url:" + url_prefix+"/commons/file/saveEditedFile.action?fileId="+fileId);
%>
<html>
<head>
<title>就地编辑</title>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>

<style>
body { font-family:宋体; font-size:9pt; color:black; cursor:default; margin:0; }
td { font-family:宋体; font-size:9pt; color:black; cursor:default; }
.icon { font-family:Wingdings; font-size:12pt; cursor:default; display:none; }
.fakehlink {cursor: hand; text-decoration: underline; color: #0066CC; font-weight:normal;}

</style>

<style>
input { behavior:url(/res/input.htc);font-family:宋体; font-size:9pt; padding-top:2px; border:1pt solid #99cccc; text-indent:1px; }
</style>
</head>
<body onload="onBodyLoaded()">
<script language="JavaScript">
function saveCell2(){
	alert("a");
	var excelXml = cell.SaveToExcelXML();
	alert("b");
	var fileId = "<%=fileId%>";
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/commons/file', action:'saveEditedFile', executeResult:'false' }, 
					{'fileId':fileId, 'excelXml':excelXml},
					xxx);
	alert("c");				
}
	function xxx(data){
		  alert(data.value);
	}
function onBodyLoaded() {
	//oFramer.focus();
	//alert("a");
	cell.ImportExcelFile("<%=url%>");
	//alert("b");
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
<form name="tmpForm" method="post" action="<%=_CtxPath%>/commons/file/saveEditedFile.action">
<input type="hidden" name="fileId" value="<%=fileId%>">
<input type="hidden" name="excelXml" value="">
</form>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
    <td bgcolor="#7CA4E9" valign="middle" height="20" align="left" nowrap="true">
      <b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp电子表格</b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
      <input type="button" name="saveufcell" value="保存"/>
    </td>
</tr>
<tr><td bgcolor="#FFFFFF" valign="top" height="1"></td></tr>
<tr><td bgcolor="#7CA4E9" valign="top" height="1"></td></tr>
<tr><td bgcolor="#FFFFFF" valign="top" height="2"></td></tr>
<tr height="100%">
<td valign="top" width="100%">
<object classid="clsid:3F166327-8030-4881-8BD2-EA25350E574A" id="cell" CODEBASE="<%=url_prefix%>/scripts/cellweb5.cab#Version=1,0,0,0" width="100%" height="100%">
  <param name="_Version" value="65536">
  <param name="_ExtentX" value="2646">
  <param name="_ExtentY" value="1323">
  <param name="_StockProps" value="0">
</object>
</td>
</tr>
</table>
</body>
</html>