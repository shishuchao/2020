<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	//连接url
	String serverUrl = basePath + "servlet/OfficeServlet";
	String recordId = (String)request.getSession().getAttribute("introRecordId"); //模板id
	String filename = (String)request.getSession().getAttribute("introFilename"); //模板名称
	
%>
<html>
	<head>
		<title>模板管理</title>
		<link rel='stylesheet' type='text/css' href='<%=basePath%>pages/attached/css/test.css'>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/gray/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/icon.css" type="text/css"></link>
	    <script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
//作用：显示操作状态
function StatusMsg(mString){
  StatusBar.innerText=mString;
}


//作用：载入iWebOffice
function openTemplate(){
  try{
  //以下属性必须设置，实始化iWebOffice
  webform.WebOffice.WebUrl="<%=serverUrl%>";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  webform.WebOffice.RecordID='<%=recordId%>';                 //RecordID:本文档记录编号
  webform.WebOffice.Template = '';   //Template:模板编号
  webform.WebOffice.FileName = '<%=filename%>';   //FileName:文档名称
  webform.WebOffice.FileType= '.xls';   //FileType:文档类型  .doc  .xls  .wps
  webform.WebOffice.EditType="1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
  webform.WebOffice.UserName="";   //UserName:操作用户名
  

  webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
  StatusMsg(webform.WebOffice.Status);
  }catch(e){
    alert(webform.WebOffice.Status);
  }
}

//作用：退出iWebOffice
function UnLoad(){
  try{
  if (!webform.WebOffice.WebClose()){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg("关闭文档...");
     window.close();
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

//作用：保存模板
function saveDocument(){
  webform.WebOffice.WebClearMessage();            //清空iWebOffice变量
  if (!webform.WebOffice.WebSave(true)){    //交互OfficeServer的OPTION="SAVEFILE"
     alert("保存模板错误!");
     StatusMsg(webform.WebOffice.Status);
     return false;
  }else{
     alert("保存成功！");
     UnLoad();
  } 
}

</script>
	</head>
	<body onload="openTemplate()">
		<div id="layDiv" class="easyui-layout" style="width: 100%; height: 900px;">
			<div region="center" style="height:800px" title="模板名称11:&nbsp;&nbsp;&nbsp;&nbsp;<input id='filename' value='<%=filename%>' size='100' disabled='disabled'>&nbsp;&nbsp;&nbsp;&nbsp;<input value='保存文档' type='button' onclick='saveDocument()'>&nbsp;&nbsp;<input value='关  闭' type='button' onclick='UnLoad()'>">
				<form name="webform" method="post" style="padding: 0; margin: 0">
					<tr>
						<td bgcolor="menu">
							<!--调用iWebOffice，注意版本号，可用于升级-->
							<script src="<%=basePath%>pages/commons/file/iWebOffice2003.js"></script>
						</td>
					</tr>
					<tr>
						<td height='15'>
							<div id=StatusBar>
								状态栏
							</div>
						</td>
					</tr>
				</form>
			</div>
		</div>
	</body>
</html>
