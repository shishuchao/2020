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
%>
<html>
	<head>
		<title>模板管理</title>
		<link rel='stylesheet' type='text/css' href='<%=basePath%>pages/attached/css/test.css'>
	    <script type="text/javascript" src="<%=basePath%>scripts/jquery-1.4.3.min.js"></script>
<style>
.ListTable {
	background-color: #7CA4E9;
	font-size: 12px;
	border: 0px;
	width: 97%;
	margin: 0px;
}

.EditHead {
	background-image: url(../../images/ais/bg1a.jpg);
	background-repeat: repeat;
	height: 26px;
	text-align: left;
	vertical-align: middle;
	font-size: 12px;
	font-family: "simsun";
	font-weight: bold;
	color: #007FFF;
	background-repeat: repeat;
}
</style>
<script type="text/javascript">
//作用：显示操作状态
function StatusMsg(mString){
  StatusBar.innerText=mString;
}

//创建新模板
function addTemplate(){
   openTemplate("","");
   $("#nameTab").show();
}

//作用：载入iWebOffice
var a = ""; //测试模板id
function openTemplate(templateid,templatename){
  a = templateid;
  $("#templatename").val(templatename);
  try{
  //以下属性必须设置，实始化iWebOffice
  webform.WebOffice.WebUrl="<%=serverUrl%>";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  webform.WebOffice.RecordID="";                 //RecordID:本文档记录编号
  webform.WebOffice.Template = templateid;   //Template:模板编号
  webform.WebOffice.FileName = templatename;   //FileName:文档名称
  webform.WebOffice.FileType=".xls";   //FileType:文档类型  .doc  .xls  .wps
  webform.WebOffice.EditType="1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
  webform.WebOffice.UserName="";   //UserName:操作用户名

  webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
  StatusMsg(webform.WebOffice.Status);
  }catch(e){
    alert(webform.WebOffice.Status);
  }
}

//删除模板
function delTemplate(){
if(confirm("确定要删除当前模板么？")){
  var template = webform.WebOffice.Template;
  $.ajax({
   type: "POST",
   url: "<%=basePath%>attached/file/attachedfile!delTemplate.action",
   data: {"templateid":template},
   success: function(msg){
      if(1 == msg){
         window.location.href = "<%=basePath%>attached/file/attachedfile!templateList.action";
      }else{
         alert("删除模板失败！");
      }
   }
});
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

//作用：保存文档
function saveTemplate(){
  webform.WebOffice.WebClearMessage();            //清空iWebOffice变量
  var templatename = $("#templatename").val();
  if("" == templatename){
     alert("模板名称不能为空！");
     return;
  }
  webform.WebOffice.FileName = templatename;
 // webform.WebOffice.WebSetMsgByName("tmpname",templatename);  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSaveTemplate()时，一起提交到OfficeServer中
  if (!webform.WebOffice.WebSaveTemplate()){    //交互OfficeServer的OPTION="SAVETEMPLATE"
     alert("保存模板错误!");
     StatusMsg(webform.WebOffice.Status);
     return false;
  }else{
     window.location.href = "<%=basePath%>attached/file/attachedfile!templateList.action";
  } 
}



//插入excel值
function insertFormula(formula){
 var sheetIndex = webform.WebOffice.WebObject.Application.ActiveSheet.Index;
 webform.WebOffice.WebObject.Application.Sheets(sheetIndex).Select();
 var address = webform.WebOffice.WebObject.Application.ActiveCell.Address;
 webform.WebOffice.WebObject.Application.Range(address).Select();
 webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "{"+formula+"}";
}
</script>
	</head>
	<body bgcolor="#ffffff">
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" height="30" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead" style="text-align: left;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/attached/file/attachedfile!templateList.action')" />
				</td>
			</tr>
		</table>
		<form name="webform" method="post">
			<table border=0 cellspacing='0' cellpadding='0' width=97% height=1000 align=center class=TBStyle>
				<tr>
					<td align="center" class="TDTitleStyle" width="7%" height="20">
						模板名称
					</td>
					<td align="center" class="TDTitleStyle" width="80%">
						<input value="添加模板" type="button" onclick="addTemplate()">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input value="保存模板" type="button" onclick="saveTemplate()">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input value="删除模板" type="button" onclick="delTemplate()">
					</td>
					<td align="center" class="TDTitleStyle" width="7%">
						公式
					</td>
				</tr>

				<tr>
					<td align="center" valign=top class="TDTitleStyle" height=100%>
					   <table>
					     <s:iterator value="#session.templateList" id="temp">
						         <tt align="center" style="cursor: pointer;" onclick="openTemplate('<s:property value="#temp.recordid"/>','<s:property value="#temp.templatename"/>');"><s:property value="#temp.templatename"/></tt><br/>
						</s:iterator>
					   </table>
					</td>

					<td class="TDStyle" height=90%>
						<table id="nameTab" style="display: none" border=0 cellspacing='0' cellpadding='0' width='100%' height='10'>
							<tr>
								<td class="TDTitleStyle">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新模板名称：
									<input id="templatename" type="text" />
								</td>
							</tr>
							<tr>
						</table>
						<table border=0 cellspacing='0' cellpadding='0' width='100%' height='96%'>
							<tr>
								<td bgcolor="menu">
									<!--调用iWebOffice，注意版本号，可用于升级-->
									<script src="<%=basePath%>pages/commons/file/iWebOffice2003.js"></script>
								</td>
							</tr>
							<tr>
								<td bgcolor=menu height='15'>
									<div id=StatusBar>
										状态栏
									</div>
								</td>
							</tr>
						</table>
					</td>

					<td align="center" valign=top class="TDTitleStyle" height=100%>
						 <s:iterator value="#session.formulaList" id="formula">
						         <tt align="center" style="cursor: pointer;" onclick="insertFormula('<s:property value="#formula.formulacode"/>')"><s:property value="#formula.formulaname"/></tt><br/>
						</s:iterator>
					</td>
				</tr>
			</table>
		</form>

	</body>
</html>
