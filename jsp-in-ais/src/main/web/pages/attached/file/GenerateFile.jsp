<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>生成取数文件模块</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/gray/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/icon.css" type="text/css"></link>
	</head>
	<script type="text/javascript">
$(function(){
   $('#win').window({ //关闭上传div时需要显示金格控件
    onClose:function(){
       $("#webForm").show();
    }
});
})
//开启上传div
function showUploadDiv(){
	window.returnValue=true;
   $("#webForm").hide();
   $('#win').window('open');
}

//模板或者文档标示符
var isTemp = "";
//当前模板id
var nowTemplateId = "";
//作用：显示操作状态
function StatusMsg(mString){
  $("#StatusBar").text(mString);
}
//编辑模板
function openTemplate(templateid,templatename){
  $('#east').panel("open"); //打开公式panel
  $('#delTemplate').show();
  
  nowTemplateId = templateid;
  isTemp = "template"; //用于保存文档或模板是的标示符
  
  try{
  //以下属性必须设置，实始化iWebOffice
  WebOffice.WebUrl="<%=basePath%>servlet/OfficeServlet?isTask=yes";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  WebOffice.RecordID="";                 //RecordID:本文档记录编号
  WebOffice.Template = templateid;   //Template:模板编号
  WebOffice.FileName = templatename;   //FileName:文档名称
  WebOffice.FileType=".xls";   //FileType:文档类型  .doc  .xls  .wps
  WebOffice.EditType="1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
  WebOffice.UserName="";   //UserName:操作用户名

  WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
  StatusMsg(WebOffice.Status);
  }catch(e){
    alert(WebOffice.Status);
  }
}

//编辑文档
function openFile(fileid,filename){
  $('#east').panel("close"); //关闭公式模板
  $('#delTemplate').hide(); //文档不需要删除所以隐藏
  isTemp = "file"; //用于保存文档或模板是的标示符
  try{
  //以下属性必须设置，实始化iWebOffice
  WebOffice.WebUrl="<%=basePath%>servlet/OfficeServlet";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  WebOffice.RecordID=fileid;                 //RecordID:本文档记录编号
  WebOffice.Template = "";   //Template:模板编号
  WebOffice.FileName = filename;   //FileName:文档名称
  WebOffice.FileType=".xls";   //FileType:文档类型  .doc  .xls  .wps
  WebOffice.EditType="1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
  WebOffice.UserName="系统用户";   //UserName:操作用户名

  WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
  StatusMsg(WebOffice.Status);
  }catch(e){
    alert(WebOffice.Status);
  }
}

//保存模板/文档
function save(){
	window.returnValue=true;
  WebOffice.WebClearMessage();            //清空iWebOffice变量
  
  if("template" == isTemp){
     if (!WebOffice.WebSaveTemplate()){    //交互OfficeServer的OPTION="SAVETEMPLATE"
     alert("保存模板错误!");
     StatusMsg(WebOffice.Status);
     return false;
     }else{
        alert("保存模板成功！");
     }
  }else if("file" == isTemp){
     if (!WebOffice.WebSave(true)){    //交互OfficeServer的OPTION="SAVEFILE"
     alert("保存生成文件错误!");
     StatusMsg(WebOffice.Status);
     return false;
     }else{
        alert("保存生成文件成功！");
     }
  
  }
   
}

//替换公式
function replaceFormula(templateid,projectId){
  if(confirm("您确定要生成新文件吗，生成新文件可能删除掉已经生成文件的数据！")){
   $.ajax({
   type: "POST",
   url: "<%=basePath%>attached/file/attachedfile!replaceFormula.action",
   dataType:"json",
   data:{"templateid":templateid,"projectId":projectId},
   success: function(obj){
       alert("生成文件成功！");
       $("#"+obj.templateid).html("<a onClick='openFile(\""+obj.fileid+"\",\""+obj.filename+"\")' href='javascript:void(0)' style='text-decoration:none;'>"+obj.filename+"</a>");
   }
});
  }
}

//插入excel值
function insertFormula(formula){
 var sheetIndex = WebOffice.WebObject.Application.ActiveSheet.Index;
 WebOffice.WebObject.Application.Sheets(sheetIndex).Select();
 var address = WebOffice.WebObject.Application.ActiveCell.Address;
 WebOffice.WebObject.Application.Range(address).Select();
 WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "{"+formula+"}";
}

//删除模板
function delTemplate(){
	window.returnValue=true;
  var audTaskId = '<s:property value="#session.audTaskId"/>';
  if(confirm("您确定要删除当前模板么，如果删除则生成文档会一起删除！")){
    if("" == nowTemplateId){
       alert("没有选中模板！");
       return;
    }
    
     $.ajax({
        type: "POST",
        url: "<%=basePath%>attached/file/attachedfile!delImplementTaskTemplate.action",
        data:{"templateid":nowTemplateId,"audTaskId":audTaskId},
        success: function(obj){
             alert("删除模板成功！");
             $("#"+nowTemplateId).parent().remove();
             WebOffice.WebClose()
   }
});
    
    }
}

//返回上级
function back(){
   var project = '<s:property value="#session.projectId"/>';
   window.location = "<%=basePath%>operate/taskExt/index.action?project_id="+project;
}

//上传文档
function doUpload(){
   var uploadFile = $("#uploadFile").val();
    if("" == uploadFile){
      alert("上传文件不能为空！");
      return;
    }
   var fileType = uploadFile.substring(uploadFile.lastIndexOf(".")+1); //判断上传文件后缀是否是excel格式
   if("xls" != fileType){
      alert("请上传后缀为\".xls\"格式的excel模板！");
      return;
   }
   
   $("#attachedForm").submit();
}

  </script>
	<body class="easyui-layout" >
			<div region="west" split="true" title="附表操作" style="width: 250px;">
				<table style="width: 98%;  word-break: break-all;">
					<tr style="font-size: x-small; font-weight: bold">
						<td style="width: 45%" align="center">
							模板名称
						</td>
						<td style="width: 10%" align="center">
							操作
						</td>
						<td style="width: 45%" align="center">
							生成文件
						</td>
					</tr>

					<s:iterator value="#session.attachedMap" id="map">
						<tr style="font-size: x-small;">
							<td style="width: 38%" align="center">
								<a href="javascript:openTemplate('<s:property value="#map.key.templateid"/>','<s:property value="#map.key.templatename"/>')"><s:property value="#map.key.templatename" /> </a>
							</td>
							<td style="width: 12%" align="center">
								<a href="javascript:replaceFormula('<s:property value="#map.key.templateid"/>','<s:property value="#session.projectId"/>')" style="text-decoration: none;" title="点击生成文档"><img width="20" height="22" border="0" src="<%=basePath%>pages/attached/css/right.jpg"></img></a>
							</td>
							<td style="width: 37%" align="center" id="<s:property value="#map.key.templateid"/>">
								<a href="javascript:openFile('<s:property value="#map.value.documnetid"/>','<s:property value="#map.value.filename"/>')"><s:property value="#map.value.filename" /> </a>
							</td>
						</tr>
					</s:iterator>
				</table>
			</div>
			<div region="east" id="east" title="公式列表" split="true" style="width: 100px;">
				<table style="width: 98%; margin-left: -10px; word-break: break-all;">
					<tr style="font-size: x-small; font-weight: bold">
						<td align="center">
							公式名称
						</td>
					</tr>
					<s:iterator value="#session.formulaList" id="formula">
						<tr style="font-size: x-small;">
							<td align="center">
								<a href="javascript:insertFormula('<s:property value="#formula.formulacode"/>')"><s:property value="#formula.formulaname" /> </a>
							</td>
						</tr>
					</s:iterator>
				</table>
			</div>
			<div region="center" title="生成文件查看<span style='width:100px'></span><a href='javascript:save();'>保存文档</a>&nbsp;&nbsp;<a href='javascript:delTemplate();' style='display:none' id='delTemplate'>删除模板</a>&nbsp;&nbsp;<a href='javascript:showUploadDiv();'>上传模板</a>" style="padding: 5px; background: #eee;" id="webForm">
				
					<script src="<%=basePath%>pages/commons/file/iWebOffice2003.js"></script>
				
				<div id="StatusBar" style="bottom: 0px"></div>
			</div>
			<!-- 上传div开始 -->
	<div id="win" class="easyui-window" title="上传模板" style="width: 550px; height: 62px" data-options="iconCls:'icon-save',modal:true,closed:true">
		<form action="<%=basePath%>attached/uploadfile/attacheduploadfile!implementUpload.action" method="post" enctype="multipart/form-data" id="attachedForm">
			&nbsp;&nbsp;&nbsp;
			<input type="file" name="file" size="50" id="uploadFile">
			&nbsp;&nbsp;&nbsp;
			<button type="button" onclick="doUpload();">
				提交
			</button>
			<input type="hidden" name="audTaskId" value="<s:property value="#session.audTaskId"/>">
			<input type="hidden" name="projectId" value="<s:property value="#session.projectId"/>">
		</form>
	</div>
	</body>
	
	<!-- 上传div结束-->

</html>
