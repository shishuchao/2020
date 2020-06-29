<!DOCTYPE HTML >
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="ais.file.model.FileBean"%>
<%@page import="ais.file.service.FileService"%>

<%
    String _ServerName = request.getServerName();
    int _ServerPort = request.getServerPort();
    String _CtxPath = request.getContextPath();
%>

<%
String fileId = request.getParameter("fileId");
String fileType = request.getParameter("FileType");
String readonly = request.getParameter("r");
String noDownload = request.getParameter("u");
String savable = "";
String download = "";
if("t".equals(readonly)){
	savable = "disabled";
}
if(noDownload==null || "".equals(noDownload) || "0".equals(noDownload)){
	download  = "disabled";
}
String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
String url = url_prefix+ "/iweb/file"+fileId+"?path=1";

WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
FileService fileService = (FileService) ctx.getBean("fileService");
FileBean filebean = fileService.getByFileId(fileId);
String guid = filebean.getGuid();
String iweb_type = null;
if(filebean!=null&&filebean.getFileType()!=null){
	String file_bean_type = filebean.getFileType().trim();
	if("application/vnd.ms-excel".equalsIgnoreCase(file_bean_type)){
		iweb_type = ".xls";
	}
	if("application/msword".equalsIgnoreCase(file_bean_type)){
		iweb_type = ".doc";
	}
	if("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet".equalsIgnoreCase(file_bean_type)){
		iweb_type = ".xlsx";
	}
	if("application/vnd.openxmlformats-officedocument.wordprocessingml.document".equalsIgnoreCase(file_bean_type)){
		iweb_type = ".docx";
	}
	if("application/vnd.openxmlformats-officedocument.presentationml.presentation".equalsIgnoreCase(file_bean_type)){
		iweb_type = ".pptx";
	}
	if("application/vnd.ms-powerpoint".equalsIgnoreCase(file_bean_type)){
		iweb_type = ".ppt";
	}
}
%>

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
       		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
<!--  <meta http-equiv="X-UA-Compatible" content="IE=9" /> -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/pages/commons/file/WebOffice.js?v=1'></script>
		
		
<% 
if("t".equals(readonly)){
%>
<title>查看附件</title>
<%}else{ %>
<title>就地编辑</title>
<%} %>
<style>
body { font-family:宋体; font-size:9pt; color:black; cursor:default; margin:0; }
td { font-family:宋体; font-size:9pt; color:black; cursor:default; }
</style>
</head>
<body onload="onBodyLoaded();" onunload="onBodyUnload()" >



<form name="webform" method="post" action="<%=_CtxPath%>/commons/file/saveEditedFile.action">
<input type="hidden" name="fileId" value="<%=fileId%>">
<input type="hidden" name="excelXml" value="">
</form>
<!--  
<div id="jgHead" style='width:100%;height:30px;line-height:30px;position:absolute;top:2px;z-index:999999999999999999;'>
	<div style='float:left;'>
		<div id=StatusBar>状态栏</div>
	</div>
	<div style='float:right;padding-top:2px;'>
			<s:if test="${param.edit ne 'no' and param.r ne 't'}">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveDocument()">保存文档</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="WebSaveLocal()">保存到本地</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-view'" onclick="ShowRevision(true)">显示编辑痕迹</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="ShowRevision(false)">隐藏编辑痕迹</a>
			</s:if>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-email'" onclick="javascript:WebOffice.style.display='none';showPopWin('<%=request.getContextPath()%>/msg/sendMail.action?innerMsg.attachmentsId=<%=guid%>',500,350,'发送邮件')">发送邮件</a>
			<a class="easyui-linkbutton" id="addFgBtn" data-options="iconCls:'icon-add'" onclick="return copyFgzd()">添加</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="return closeEdit()">关 闭</a>
	</div>
</div>	
-->
<div style="height: 20px;">状态：<span id="state"></span></div>
<div id='jgContainer'>
	<script src="iWebOffice2015.js"></script>
</div>
<!-- <div id="tempMailDiv" title="邮件发送" style='overflow:hidden;padding:0px;'> 	  		
				<iframe id="mailFrame" name="mailFrame" title="邮件发送" src="" width="100%" height="99%" frameborder="0"></iframe>				
 </div> -->
</body>
</html>

<script type="text/javascript">
	var WebOffice = new WebOffice2015(); //创建WebOffice对象
</script>
<script language="JavaScript">
var btnDefNames = ["新建文件","打开文件","保存文件","文字批注","手写批注","文档清稿","重新批注"];
var btnCusNames = ["保存到服务器", "显示编辑痕迹", "隐藏编辑痕迹"];
var btnCusNames2 = ["添加法规"];
$(function(){
	//初始化增加窗口
    $('#tempMailDiv').window({
		width:'90%', 
		height:'90%',  
		modal:true,
		collapsible:true,
		maximizable:true,
		minimizable:true,
		closed:true    
    });
	$('#jgContainer').height($(document).height()-50);
});


function hideToolsBtns(btNames){
	if(btNames && btNames.length){
		$.each(btNames, function(i, btnName){
			WebOffice.VisibleTools(btnName,false);
		});
	}	
}



function saveDocument(){
  if (!WebOffice.WebSave(true)){    //交互OfficeServer的OPTION="SAVEFILE"
     StatusMsg('保存失败！');
     return false;
  }else{
     StatusMsg('保存成功！');
     alert('保存成功！');
     return true;
  }			
}
function onBodyLoaded() {
	
	try{
		//WebOffice.WebRepairMode = true;
		WebOffice.setObj(document.getElementById('WebOffice'));//给2015对象赋值
		WebOffice.ShowTitleBar(false); // 标题栏
//		WebOffice.ShowStatusBar(true);//状态栏
		WebOffice.WebUrl="<%=url%>";//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
		//WebOffice.Compatible=false; //兼容模式解决了docx在打开时变成doc文件
		<%if(iweb_type!=null){%>
		WebOffice.FileType="<%=iweb_type%>";//FileType:文档类型  .doc  .xls  .wps good
		<%}%>
		WebOffice.UserName="${user.fname}";
		WebOffice.FileName="<%=filebean.getFileName()%>";
		//处理编辑、查看、工具栏等
		var isEdit = false;
		//WebOffice.ShowCustomToolbar(false);
		if(window.opener.document.getElementById('sureSelectZcfgTreeNode')){
			//WebOffice.AddToolBarButton("7","添加法规","","添加法规",0);
			$('#addLaw').show();
		}else{
			$('#addLaw').hide();
		}
		//WebOffice.AddToolBarButton("41","-","","",1);
		//WebOffice.AddToolBarButton("10","打印文档","","打印文档",0);
		//WebOffice.AddToolBarButton("101","-","","",1);
		//WebOffice.AddToolBarButton("6","发送邮件","","发送邮件",0);
		WebOffice.UserName='1';
		WebOffice.HookEnabled();
		//WebOffice.WebOpen(true);
		<s:if test="${param.edit ne 'no' and param.r ne 't'}">
		isEdit = true;
		//WebOffice.ShowMenuBar(false);//菜单栏
		WebOffice.ShowToolBars(true); // 工具栏
		WebOffice.ShowCustomToolbar(true);//自定义栏
	    WebOffice.obj.CustomToolBar.AddToolButton(1,"保存到服务器","","保存到服务器",0);
		/* WebOffice.obj.CustomToolBar.AddToolButton("11","-","","",1);
		WebOffice.obj.CustomToolBar.AddToolButton("3","显示编辑痕迹","","显示编辑痕迹",0);
		WebOffice.obj.CustomToolBar.AddToolButton("31","-","","",1);
		WebOffice.obj.CustomToolBar.AddToolButton("4","隐藏编辑痕迹","","隐藏编辑痕迹",0); */
		</s:if>
	    WebOffice.EditType='1';
		WebOffice.setEditType("1");
		if(WebOffice.WebOpen()){ 

		}
		WebOffice.WebShow(false);
		StatusMsg("打开成功！");
	}catch(e){
		//alert(e.description);
	}finally {
    	WebOffice.ShowMenuBar(false);//菜单栏
		WebOffice.ShowStatusBar(false);//状态栏
		<s:if test="${param.edit ne 'no' and param.r ne 't'}">
		</s:if>
		<s:else>
		  WebOffice.ShowToolBars(false);; // 工具栏
		  WebOffice.ShowCustomToolbar(false);//自定义栏
		</s:else>
	}

}

//作用：存为本地文件
function WebSaveLocal(){
	try{
		WebOffice.WebSaveLocal();
	}catch(e){StatusMsg(e.description);}
}


//作用：打印文档
function WebOpenPrint(){
	try{
		WebOffice.WebOpenPrint();
	}
	catch(e){
		StatusMsg(e.description);
	}
}

function onBodyUnload() {
	try{
		if (!WebOffice.WebClose()){
			StatusMsg(WebOffice.Status);
		}else{
			StatusMsg("关闭文档...");
		}
	}catch(e){
		StatusMsg(e.description);
	}
}

function closeEdit(){
	window.close();
}
//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
function ShowRevision(mValue){
	if (mValue){
		WebOffice.WebShow(true);
	}
	else{
		WebOffice.WebShow(false);
	}
}
function saveDocument(){
	if (!WebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
		StatusMsg(WebOffice.Status);
		return false;
	}else{
		StatusMsg(WebOffice.Status);
		return true;
	}
}

function OnReady(){
	alert(1)
}

function OnCommand(wID, bstrCaption, bCancel) {
	switch (wID) {
		case 1:
			saveDocument();
			break;
		case 2:
			WebSaveLocal();
			break;
		case 3:
			ShowRevision(true);
			break;
		case 4:
			ShowRevision(false);
			break;
		case 10:
			WebOpenPrint();
			break;
		case 6:
			xiaoming();
			break;
		case 7:
			copyFgzd();
			break;
		default:

	}
}
function hidePopWin(callReturnFunc) {
	gPopupIsShown = false;
	var theBody = document.getElementsByTagName("BODY")[0];
	theBody.style.overflow = "";
	restoreTabIndexes();
	if (gPopupMask == null) {
		return;
	}
	gPopupMask.style.display = "none";
	gPopupContainer.style.display = "none";
	if (callReturnFunc == true && gReturnFunc != null) {
		// Set the return code to run in a timeout.
		// Was having issues using with an Ajax.Request();
		gReturnVal = window.frames["popupFrame"].returnVal;
		window.setTimeout('gReturnFunc(gReturnVal);', 1);
	}
	gPopFrame.src = gDefaultPage;
	// display all select boxes
	if (gHideSelects == true) {
		displaySelectBoxes();
	}
	document.getElementById('WebOffice').style.display='block';
}

// add by qfucee, 2013.11.11
function copyFgzd(){
	//alert(window.parent == window)
	try{
		var pWin = window.opener;
		if(pWin){

			// 获得剪切板的内容
			var clip = window.clipboardData;
			var clipTxt = clip.getData("Text");
			if(clipTxt == null || clipTxt == ''){
				alert('请先选择要引用的法规，并【复制】，再【添加】！');
			}else{
				//targetBtn.fireEvent('onclick');
				//$(targetBtn).trigger("click");
				pWin.addFgAndClose ? (window.close(),pWin.addFgAndClose()) : null;
			}
		}
	}catch(e){
		alert('copyFgzd -- '+e.message);
	}
}
function addFgBtn(){
	if(!window.opener.document.getElementById('sureSelectZcfgTreeNode')){
		WebOffice.VisibleTools("添加法规",false);
		document.getElementById('addFgBtn').style.display = 'none';
		
	}
}
function xiaoming(){

	 var myurl = '<%=request.getContextPath()%>/msg/innerMsg_edit.action?readFlag=8&innerMsg.attachmentsId=<%=guid%>';
	$("#mailFrame").attr("src",myurl);
	$('#tempMailDiv').window('open'); 
}
function closeMailUi(){
	$('#tempMailDiv').window('close');
}
//设置页面中的状态值
function StatusMsg(mValue){
	try{
		document.getElementById('state').innerHTML = mValue;
	}catch(e){
		return false;
	}
}
// end
</script>

<script language="javascript" for="window" event="OnReady()">
   //WebOffice.setObj(document.getElementById('WebOffice2015'));//给2015对象赋值
  // Load();//避免页面加载完，控件还没有加载情况
  alert(1);
</script>

<script language="JavaScript" for=WebOffice event="OnCommand(ID, Caption, bCancel)">
	switch (ID) {
		case 1:
			saveDocument();
			break;
		case 2:
			WebSaveLocal();
			break;
		case 3:
			ShowRevision(true);
			break;
		case 4:
			ShowRevision(false);
			break;
		case 10:
			WebOpenPrint();
			break;
		case 6:
			xiaoming();
			break;
		case 7:
			copyFgzd();
			break;
		default:

	}
</script>