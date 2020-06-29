<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
    String _ServerName = request.getServerName();
    int _ServerPort = request.getServerPort();
    String _CtxPath = request.getContextPath();
    String aisUrl="http://"+_ServerName+":"+_ServerPort+"/"+_CtxPath;
%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>就地编辑</title>
<style>
body { font-family:宋体; font-size:9pt; color:black; cursor:default; margin:0; }
td { font-family:宋体; font-size:9pt; color:black; cursor:default; }
</style>
<script>
//var delay = window.clipboardData.getData("Text");
//alert(delay);
</script>
</head>
<body onload="onBodyLoaded()" onunload="onBodyUnload()">



<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
    <td bgcolor="#7CA4E9" valign="middle" height="15" align="left" nowrap><div id=StatusBar>状态栏</div></td>
	<td bgcolor="#7CA4E9" height="15">
	<input type="button" name="savelocal" onclick="WebSaveLocal()" value="保存到本地"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="button" name="savebutton" onclick="saveDocument()" value=""/>
	
	</td>
	
</tr> 
<tr><td bgcolor="#FFFFFF" valign="top" height="1" colspan="2"></td></tr>
<tr><td bgcolor="#7CA4E9" valign="top" height="1" colspan="2"></td></tr>
<tr><td bgcolor="#FFFFFF" valign="top" height="2" colspan="2"></td></tr>
<tr height="100%" >
<td valign="top" width="100%" colspan="2">
<script src="/ais/pages/commons/file/iWebOffice2003.js"></script>
</td>
</tr>
</table>
<script language="JavaScript">
var dt_pro_id = "${dt_pro_id}";
var dt_guid = "${dt_guid}";
var dt_file_id = "${dt_file_id}";
var dt_type = "${dt_type}";


var url_prefix="http://<%=_ServerName%>:<%=_ServerPort%>/<%=_CtxPath%>";
var url = url_prefix+ "/iweb/file"+dt_file_id;

if("${step_dt}"=="true"){
	window.location="<%=aisUrl%>/operate/doubt/edit.action?pro_id=${dt_pro_id}&type=${dt_type}&url=${url}&mod_id=${mod_id}&bns_id=${bns_id}";
}

var showName = ""; 

if("BW"==dt_type){
	showName = "生成备忘";
}

if("YD"==dt_type){
	showName = "生成疑点";
}
savebutton.value = showName;


function saveDocument(){
  if (!WebOffice.WebSave(true)){    //交互OfficeServer的OPTION="SAVEFILE"
     StatusMsg(WebOffice.Status);
     return false;
  }else{
     StatusMsg(WebOffice.Status);
	 window.location="<%=aisUrl%>/operate/doubt/edit.action?pro_id=${dt_pro_id}&file_id=${dt_guid}&type=${dt_type}&url=${url}&mod_id=${mod_id}&bns_id=${bns_id}";
     return true;
  }			
}
function onBodyLoaded() {
    WebOffice.WebUrl=url;//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件 
    WebOffice.FileType=".xls";//FileType:文档类型  .doc  .xls  .wps
	WebOffice.WebOpen();
 	var cs = WebOffice.WebObject.Application.ActiveSheet;

	window.opener.dt_paste_content.execCommand('Copy',false);
	cs.Paste(); 
	StatusMsg(WebOffice.Status);
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
    WebOffice.WebSaveLocal();
    StatusMsg(WebOffice.Status);
  }catch(e){alert(e.description);}
}

function onBodyUnload() {
  try{
    if (!WebOffice.WebClose()){
      StatusMsg(WebOffice.Status);
    }else{
      StatusMsg("关闭文档...");
    }
  }catch(e){
	alert(e.description);
  }
}
//作用：显示操作状态
function StatusMsg(mString){
  StatusBar.innerText=mString;
}

</script>
</body>
</html>