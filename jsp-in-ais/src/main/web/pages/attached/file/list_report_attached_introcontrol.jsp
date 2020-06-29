<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>内控测试报告阶段附表列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/gray/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/icon.css" type="text/css"></link>
		<link href="<%=basePath%>styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
//开启上传div
function showUploadDiv(){
   $("#webForm").hide();
   $('#win').window('open');
}

//生成文档
function doGenerate(documentid,templateid,projectid,reportid){
  $.ajax({
   type: "POST",
   url: "<%=basePath%>attached/file/attachedfile!introAttachedReplaceFormula.action",
   data: {"documentid":documentid,"templateid":templateid,"crudId":projectid},
   success: function(msg){
     if(1 == msg){
       alert("生成文档成功！");
       window.location = "<%=basePath%>attached/file/attachedfile!reportAttachedList.action?crudId="+projectid+"&reportId="+reportid;
     }else{
       alert("生成文档失败！");
       return false;
     }
   }
});
}

//上传文档
function doUpload(){
   var uploadFile = $("#uploadFile").val();
   var type = uploadFile.substring(uploadFile.lastIndexOf(".")+1);
    if("" == uploadFile){
      alert("上传文件不能为空！");
      return;
    }
    if(type != "xls"){
       alert("上传模板必须为后缀是\".xls\"格式的excel文档！");
       return;
    }
   
   $("#attachedForm").submit();
}

//修改模板
function templateModify(templateid){
   window.open("<%=basePath%>attached/file/attachedfile!introTemplateModify.action?templateid="+templateid,"","toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
}

//文档修改
function documentModify(documentid){
   window.open("<%=basePath%>attached/file/attachedfile!showReportAttached.action?documentid="+documentid,"","toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
}

//删除附表
function doDeldoc(documnetid,projectid,reportid,templateid){
if(confirm("删除文档时会同时删除模板，确定删除文档么？")){
 $.ajax({
   type: "POST",
   url: "<%=basePath%>attached/file/attachedfile!delReportAttached.action",
   data: {"documentid":documnetid,"templateid":templateid},
   success: function(msg){
     if(1 == msg){
       alert("删除文档成功！");
       window.location = "<%=basePath%>attached/file/attachedfile!reportAttachedList.action?crudId="+projectid+"&reportId="+reportid;
     }else{
       alert("删除文档失败！");
       return false;
     }
   }
});
 }
}
</script>
	</head>
	<body>
		<div>
			<a href="javascript:showUploadDiv()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">上传附表模板</a>
		</div>
		<table>
			<thead>
				<tr class="ListTableTrCenter" style="background-color: #EEF7FF; font-weight: bold;">
					<td style="text-align: center; width: 20%">
						文件名称
					</td>
					<!--  <td style="text-align: center; width: 10%">
						文件类型
					</td> -->
					<td style="text-align: center; width: 20%">
						创建时间
					</td>
					<td style="text-align: center; width: 15%">
						创建人
					</td>
					<td style="text-align: center; width: 20%">
						模板名称
					</td>
					<td style="text-align: center; width: 15%">
						操作
					</td>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#request.attachedDocumentfileList" id="attachedDocument">
					<tr class="ListTableTrCenter" style="background-color: white;">
						<td style="text-align: center;vertical-align: middle" class="ListTableTd">
						  <a onclick="documentModify('<s:property value="#attachedDocument.documnetid" />')" href="javascript:void(0)"><s:property value="#attachedDocument.filename" /></a>
						</td>
						<!-- <td style="text-align: center;vertical-align: middle" class="ListTableTd">
							<s:property value="#attachedDocument.filetype" />
						</td>  -->
						<td style="text-align: center;" class="ListTableTd">
						    <s:property value="#attachedDocument.filedate" />
						</td>
						<td style="text-align: center;" class="ListTableTd">
						    <s:property value="#attachedDocument.userinfo" />
						</td>
						<td style="text-align: center;" class="ListTableTd">
						    <a onclick="templateModify('<s:property value="#attachedDocument.templateid" />')" href="javascript:void(0)" title="点击修改模板"><s:property value="#attachedDocument.templatename" /></a>
						</td>
						<td style="text-align: center;" class="ListTableTd">
						    <a href="javascript:void(0)" onclick="doGenerate('<s:property value="#attachedDocument.documnetid" />','<s:property value="#attachedDocument.templateid" />','<s:property value="#request.projectId" />','<s:property value="#request.reportId" />')">生成</a>
						    <a href="javascript:void(0)" onclick="doDeldoc('<s:property value="#attachedDocument.documnetid" />','<s:property value="#request.projectId" />','<s:property value="#request.reportId" />','<s:property value="#attachedDocument.templateid" />')">删除</a>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
	</body>
	<!-- 上传div开始 -->
	<div id="win" class="easyui-window" title="上传模板" style="width: 500px; height: 62px" data-options="iconCls:'icon-save',modal:true,closed:true">
		<form action="<%=basePath%>attached/uploadfile/attacheduploadfile!introReportUpload.action" method="post" enctype="multipart/form-data" id="attachedForm">
			&nbsp;&nbsp;&nbsp;
			<input type="file" name="file" size="50" id="uploadFile">
			&nbsp;&nbsp;&nbsp;
			<button type="button" onclick="doUpload();">
				提交
			</button>
			<input type="hidden" name="crudId" value="<s:property value="#request.projectId" />">
			<input type="hidden" name="reportId" value="<s:property value="#request.reportId" />">
		</form>
	</div>
	<!-- 上传div结束-->
</html>