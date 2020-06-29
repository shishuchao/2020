<%@ page language="java" pageEncoding="UTF-8"%>
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
		<title>模板管理</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script language="javascript">
//作用：显示操作状态
function StatusMsg(mString){
  //StatusBar.innerText=mString;
}

//作用：载入iWebOffice
function Load(){
  try{
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
  }catch(e){}
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

//作用：保存文档
function SaveDocument(){
	var moduleobj = document.getElementsByName("modulename");
	if(moduleobj){
		if(moduleobj.length){
			if(moduleobj[0].selectedIndex==0){
				//alert("请选择该模板对应的模块！");
				$.messager.show({
			   		style:{ 
		                right:'', 
		                top:document.body.scrollTop+document.documentElement.scrollTop, 
		                bottom:'' 
		            },
					title:'提示信息',
					msg:'请选择该模板对应的模块！',
					timeout:2000,
					showType:'slide'
				});
				return false;
			}
		}
	}
	webform.WebOffice.WebClearMessage();
	if (!webform.WebOffice.WebSaveBookMarks()){    //交互OfficeServer的OPTION="SAVEBOOKMARKS"
		StatusMsg(webform.WebOffice.Status);
		return false;
	}
  
	var _filename = document.getElementsByName("FileName_")[0];
	var _descript = document.getElementsByName("Descript_")[0];
	document.getElementsByName("mFileName")[0].value = _filename.value;
	webform.WebOffice.FileName= _filename.value;
	webform.WebOffice.ExtParam= moduleobj[0].options[moduleobj[0].selectedIndex].text+";"+_descript.value;
	document.getElementsByName("mDescript")[0].value = _descript.value;
	document.getElementsByName("mModulename")[0].value = moduleobj[0].options[moduleobj[0].selectedIndex].text;
	webform.WebOffice.WebUrl="<%=mServerUrl%>@"+moduleobj[0].options[moduleobj[0].selectedIndex].value;
	//webform.WebOffice.WebSetMsgByName("MyDefine1","自定义变量值1");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSaveTemplate()时，一起提交到OfficeServer中
	if (!webform.WebOffice.WebSaveTemplate()){    //交互OfficeServer的OPTION="SAVETEMPLATE"
		StatusMsg(webform.WebOffice.Status);
		webform.WebOffice.WebUrl="<%=mServerUrl%>";
		return false;
	}else{
		$.messager.show({
			style:{ 
				right:'', 
				top:document.body.scrollTop+document.documentElement.scrollTop, 
				bottom:'' 
			},
			title:'提示信息',
			msg:'模板保存成功!',
			timeout:2000,
			showType:'slide'
		 });
		 //showMessage1('模板保存成功!');
	     StatusMsg(webform.WebOffice.Status);
	     webform.WebOffice.WebUrl="<%=mServerUrl%>";
	     return true;
	}
	var webForm = document.getElementById('webForm');
	webForm.submit();
  
}

//作用：标签管理
function WebOpenBookMarks(){
	var moduleobj = document.getElementsByName("modulename");
	if(moduleobj){
		if(moduleobj.length){
			if(moduleobj[0].selectedIndex==0){
				$.messager.show({
			   		style:{ 
			               right:'', 
			               top:document.body.scrollTop+document.documentElement.scrollTop, 
			               bottom:'' 
			           },
					title:'提示信息',
					msg:'请选择该模板对应的模块！',
					timeout:2000,
					showType:'slide'
				});
				//showMessage1("请选择该模板对应的模块！");
				return false;
			}
		}
	}
  try{
  <%
  	int pos = mServerUrl.indexOf("file");
  	String tempurl = mServerUrl.substring(0,pos+4);
  %>
  	webform.WebOffice.WebUrl="<%=tempurl%>"+moduleobj[0].options[moduleobj[0].selectedIndex].value;
    webform.WebOffice.WebOpenBookmarks();    //交互OfficeServer的OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
    webform.WebOffice.WebUrl="<%=mServerUrl%>";
  }catch(e){}
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
    /*$.messager.show({
   		style:{ 
               right:'', 
               top:document.body.scrollTop+document.documentElement.scrollTop, 
               bottom:'' 
           },
		title:'提示信息',
		msg:'本地文件保存成功！',
		timeout:2000,
		showType:'slide'
	});*/
    //showMessage1('本地文件保存成功！');
  }catch(e){}
}

//作用：打开本地文件
function WebOpenLocal(){
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}
function toSave(){
	
}

function triggerSearchTable(){
			var isDisplay = document.getElementById('templateInfo').style.display;
			if(isDisplay==''){
				document.getElementById('templateInfo').style.display='none';
			}else{
				document.getElementById('templateInfo').style.display='';
			}
		}		
</script>
	</head>
	<body  onload="Load()" onunload="UnLoad()" style="overflow:hidden;">
		<!--引导和退出iWebOffice-->
		<table cellpadding=0 cellspacing=1 border=0 
			class="ListTable" width="100%" align="center">
			<tr>
				<td colspan="5"  style="text-align: center;" class="edithead">
						新增打印模板&nbsp;&nbsp;
						<a href="javascript:void(0);" onclick="triggerSearchTable();">模块信息设置</a>
				</td>
			</tr>
		</table>
		<form name="webform" method="post" id="webform"
			action="${contextPath}/commons/oaprint/saveTemplate.action"
			onsubmit="return SaveDocument();">
			<!--保存iWebOffice后提交表单信息-->
			<input type="hidden" name="RecordID"
				value="<s:property value="mRecordID"/>">

			<table cellpadding=0 cellspacing=1 border=0
				class="ListTable" width="100%" align="center" id="templateInfo">
				<tr>
					<td align="left" class="EditHead" style="width: 15%;">
						模板名
					</td>
					<td align="left" class="editTd" style="width: 35%;">
						<input class="noborder" type="text" name="FileName_" style="width: 160px"
							value="<s:property value="mFileName"/>">
					</td>
					<td align="left" class="EditHead" style="width: 15%;">
						对应模块
					</td>
					<td align="left" class="editTd" style="width: 35%;">
						<s:select list="bpmtableMap" name="modulename"
							theme="ufaud_simple" templateDir="/strutsTemplate"
							emptyOption="true" />
					</td>
				</tr>

				<tr>
					<td align="left" class="EditHead">
						说明
					</td>
					<td align="left" class="editTd" colspan=3>
						<input class="noborder" type="text" style="width: 160px;" name="Descript_"
							value="<s:property value="mDescript"/>">
					</td>
				</tr>
				<tr>
					<td align=right class="EditHead" colspan="6">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="WebOpenBookMarks()">定义标签</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-file'" onclick="WebOpenLocal()">打开本地文件</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="WebSaveLocal()">保存本地文件</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="SaveDocument()">保存</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="history.back()">返回</a>&nbsp;
					</td>
				</tr>
			</table>

			<table border=0 cellspacing='1' cellpadding='0' width='100%'
				height='100%' align="center">
				<!--  <tr>
    <td height="10">
	<div id=StatusBar>状态栏</div>
    </td>
  </tr>-->
				<tr>
					<td>
						<!--调用iWebOffice，注意版本号，可用于升级-->
						<%@ include file="/pages/commons/file/iwebOfficeControl.jsp"%>
					</td>
				</tr>
			</table>

			<s:hidden name="mRecordID" />
			<s:hidden name="mFileName" />
			<s:hidden name="mDescript" />
			<s:hidden name="mModulename" />

		</form>

	</body>
</html>