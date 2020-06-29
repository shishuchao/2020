<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
String _ServerName = request.getServerName();
int _ServerPort = request.getServerPort();
String _CtxPath = request.getContextPath();
String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
String fileId = (String)request.getAttribute("mRecordID");
String mServerUrl = url_prefix+ "/iweb/file"+fileId;
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>打印</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
<script language="javascript">
//作用：显示操作状态
function StatusMsg(mString){
  StatusBar.innerText=mString;
}

//作用：载入iWebOffice
function Load(){
  try{
  <%
		List bmList = (List)request.getAttribute("templateBookMarkList");
  		List bmValList = (List)request.getAttribute("templateBookMarkValList");
  		if(bmList!=null){
  			if(bmList.size()==0){
  				%>
  					alert("该模板没有定义标签，请重新维护改模板！");
  					self.close();
  				<%
  				
  			}
  		}
  		%>
  //以下属性必须设置，实始化iWebOffice
  webform.WebOffice.WebUrl="<%=mServerUrl%>";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  webform.WebOffice.RecordID="<s:property value="mRecordID"/>";   //RecordID:本文档记录编号
  webform.WebOffice.Template="<s:property value="mRecordID"/>";   //Template:模板编号
  webform.WebOffice.FileName="<s:property value="mFileName"/>";   //FileName:文档名称
  webform.WebOffice.FileType="<s:property value="mFileType"/>";   //FileType:文档类型  .doc  .xls  .wps
  webform.WebOffice.EditType="<s:property value="mEditType"/>";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
  webform.WebOffice.UserName="<s:property value="mUserName"/>";   //UserName:操作用户名
  webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
  StatusMsg(webform.WebOffice.Status);
  //设置标签值
	<%
  		
  		if(bmList!=null&&bmValList!=null){
	  		for(int i=0;i<bmList.size();i++){
	  			String bmName = (String)bmList.get(i);
	  			String bmVal = (String)bmValList.get(i);
	  			%>
	  			SetBookmarks("<%=bmName%>","<%=bmVal%>");
	  			<%	
	  		}
  		}
	%>
  }catch(e){}
}
//设置bookmark值
function SetBookmarks(vbmName,vbmValue){
  if(webform.WebOffice.FileType!=".doc"){return false;}
  if (!webform.WebOffice.WebSetBookmarks(vbmName,vbmValue)){
    StatusMsg(webform.WebOffice.Status);
  }else{
    StatusMsg(webform.WebOffice.Status);
  }
}

//作用：退出iWebOffice
function UnLoad(){
  try{
  if (!webform.WebOffice.WebClose()){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg("关闭文档...");
  }
  }catch(e){}
}


//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebOffice.WebLoadTemplate()){  //交互OfficeServer的OPTION="LOADTEMPLATE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}
//作用：打印文档
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }
  catch(e){
    alert(e.description);
  }
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：打开本地文件
function WebOpenLocal(){
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}
</script>
</head>
<body bgcolor="#ffffff" onload="Load()" onunload="UnLoad()"> <!--引导和退出iWebOffice-->
<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
	class="ListTable" width="100%" align="center">
	<tr class="listtablehead">
		<td colspan="5" align="left" class="edithead">
			<div style="display: inline;width:80%;">
				打印
			</div>
		</td>
	</tr>
</table>
<form name="webform" method="post" action="${contextPath}/commons/oaprint/saveTemplate.action" onsubmit="return SaveDocument();"> <!--保存iWebOffice后提交表单信息-->
<input type="hidden" name="RecordID" value="<s:property value="mRecordID"/>">

<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center" id="templateInfo">

  <td align=right  class="listtabletr11" colspan="6">
                 <input type=button value="保存本地文件"  onclick="WebSaveLocal()">
                 <input type=button value="打印文件" onclick="WebOpenPrint()"> 
				 <input type=button value="关闭" onclick="self.close()"> 
  </td>
</tr>
</table>
<table border=0 cellspacing='1' cellpadding='0' width='100%' height='100%' align="center">
   <tr>
    <td height="10">
	<div id=StatusBar>状态栏</div>
    </td>
  </tr>
  <tr>
    <td>
      <!--调用iWebOffice，注意版本号，可用于升级-->
	<%@ include file="/pages/commons/file/iwebOfficeControl.jsp" %>
  </td>
</tr>
</table>

<s:hidden name="mRecordID"/>
<s:hidden name="mFileName"/>
<s:hidden name="mDescript"/>
<s:hidden name="mModulename"/>
</form>

</body>
</html>
