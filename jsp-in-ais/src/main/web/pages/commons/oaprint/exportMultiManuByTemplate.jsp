<%@page import="java.sql.Date"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String _ServerName = request.getServerName();
	int _ServerPort = request.getServerPort();
	String _CtxPath = request.getContextPath();
	String url_prefix = "http://" + _ServerName + ":" + _ServerPort+ _CtxPath;
	String fileId = (String) request.getAttribute("mRecordID");
	String mServerUrl = url_prefix + "/iweb/file" + fileId;
	//传过来的底稿主键，多个，以逗号分隔
	String manuIds = (String) request.getAttribute("crudid");	
	String[] manuIdArr = {};
	if (!"".equals(manuIds) && manuIds != null) {
		manuIdArr = manuIds.split(",");
	}
	List bmList = (List)request.getAttribute("templateBookMarkList");
    List bmValList = (List)request.getAttribute("templateBookMarkValList");
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>综合工作底稿导出</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css" />
		
<script language="javascript">

//作用：显示操作状态
function StatusMsg(mString){
  StatusBar.innerText=mString;
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
	
	  //设置标签值
	  SetBookmarks();  
	  //替换换行标签
	  //replaceParagraphs('[huanhang]'); 
	  //光标回到文档开头
	  //allDoc.HomeKey(wdStory,wdMove);
	  countFormula();
	  //在控件中直接显示文档，需要保存到本地的，自行点击保存到本地按钮
	  if(window.confirm("导出底稿成功，是否显示导出的底稿文件？\n显示请点【确定】，并自行保存到本地。\n直接存到本地请点【取消】。")) {
	  	  document.body.style.display = "";
	  }else{
		  webform.WebOffice.WebSaveLocal();
		  StatusMsg(webform.WebOffice.Status);
		  parent.close_win();
	  }	
	  
  }catch(e){
	  alert('multi Manu Load:\n'+e.message);
  }  
}

function countFormula(){
	try{
	  //读取公式并替换到word中
	   var formulaArray = new Array();//文档中包含的所有公式
	   var firstIndex = -1; //第一次查找到的索引
	   var allText = webform.WebOffice.WebObject.Application.Selection.Range;
	   allText.Find.Wrap = 1;
	   while(allText.Find.Execute('{#jq!#')){
		   var start = allText.Start;
		   if(firstIndex==start){
			   break;//再次查找到了第一次查找到的公式
		   }
		   if(firstIndex==-1){
			   firstIndex = start;
		   }
		   allText.Find.Execute('#jq!#}')
		   var end = allText.End;
		   var formulaRan = webform.WebOffice.WebObject.Range(start,end);
		    var formula = formulaRan.Text;
		    formula = formula.substr(6,formula.length);
		    formula = formula.substr(0,formula.length-6);
			formulaRan.Text = formula;
		    formulaRan.Font.Bold=1;
	   }  
	}catch(e){
		alert('countFormula:\n'+e.message);
	}	   
}
//设置bookmark值
function SetBookmarks(){
	try{		
		<%
			if(bmList!=null&&bmValList!=null&&bmList.size()>0&&bmValList.size()>0){
				//标签长度
				int bmLen = bmList.size();
				//标签对应值长度
				int bmValLen = bmValList.size();
				if(bmValLen%bmLen!=0){ //值个数不是公式的整数倍
		  			%>
			  			alert("底稿中有公式未取到值，可能无法正确导出!");
			  			self.close();
		  			<%
				}
				//共有几张底稿
				int sizeofdoc = bmValLen/bmLen;
				for(int j=0;j<sizeofdoc;j++){
		  			for(int i=0;i<bmList.size();i++){
		  				String bmName = (String)bmList.get(i);
		  				String bmVal="";
		  				Object _obj = bmValList.get(i+bmLen*j);
		  				if(_obj instanceof String){
		  					bmVal = (String)_obj;
		  				}else if(_obj instanceof Date){
		  					bmVal = ((Date)_obj).toString();
		  				}
			  			%>
			  			setBookMarkVals("<%=bmName%>","<%=bmVal%>");
			  			replaceParagraphs('[huanhang]');
			  			setTextBold('[处理建议:]');
			  			<%	
		  			}
		  		}
			}
		%>
	}catch(e){
		alert("SetBookmarks:\n"+e.message);
	}
}
/**
 *作用：根据标签名设定标签值
 */
function setBookMarkVals(bookmark,bookmarkval){
	try{
		var tableDocRange =webform.WebOffice.WebObject.Application.Selection.Range;
		tableDocRange.Find.Wrap = 1;
		while(tableDocRange.Find.Execute(bookmark)){
			var start = tableDocRange.Start;
			var end = tableDocRange.End;
			var formulaRan = webform.WebOffice.WebObject.Range(start,end);
			if(typeof bookmarkval=='string' && bookmarkval.substr(0,5)=='table'){
				// 表格处理
				// 取得表格行列值
				var rc = bookmarkval.substring(bookmarkval.indexOf("{") + 1, bookmarkval.indexOf("}"));
                var rcs = rc.split(",");
                var rows = rcs[0];// 表格行数
                var cols = rcs[1];// 表格列数
                if(rows > 0){
                	var tbvalue = bookmarkval.substr(bookmarkval.indexOf("}") + 1, bookmarkval.length);// 表格内容
			        formulaRan.Text = tbvalue;
			        var onetable = formulaRan.ConvertToTable('|', rows, cols);
			        onetable.Borders.InsideLineStyle = 1;
			        onetable.Borders.OutsideLineStyle = 1;
                }else{
                	formulaRan.Text = "";// 行数为0，输出空
                }
		   }
		<%-- else if (bookmark == "[审计记录]"){
			   // 富文本处理
			   if(bookmarkval == ""){
				   formulaRan.Text = bookmarkval;
			   }else{
				   formulaRan.InsertFile("<%=url_prefix%>/tmpfiles/" + bookmarkval + ".html");
				   //删除临时文件
				   frmdeltmp.location.href = "${contextPath}/commons/oaprint/deleteDescibeFile.action?dwrModuleid=" + bookmarkval + ".html";
				
					
			   }
		   } --%>
		   else if (bookmark == "[审计证据]"){
			   // 富文本处理
			   if(bookmarkval == ""){
				   formulaRan.Text = bookmarkval;
			   }else{
				   formulaRan.InsertFile("<%=url_prefix%>/tmpfiles/" + bookmarkval + ".html");
				   //删除临时文件
				   frmdeltmp.location.href = "${contextPath}/commons/oaprint/deleteDescibeFile.action?dwrModuleid=" + bookmarkval + ".html";
			   }
		   }else if(bookmark == '[审计查证要点]'){
			   formulaRan.Text = bookmarkval;
			   formulaRan.Font.Bold=1;
		   }else{
			   // 非表格处理
			   formulaRan.Text = bookmarkval;
		   }
			//查找一次就停了
			break;
		}
	}catch(e){
		alert('setBookMarkVals:\n'+e.message);
	}
}

/**
 *作用：替换换行标签
 * bookmark 换行标签
 */
function replaceParagraphs(bookmark){
	try{
		var tableDocRange =webform.WebOffice.WebObject.Application.Selection.Range;
		tableDocRange.Find.Wrap = 1;
		while(tableDocRange.Find.Execute(bookmark)){
			var start = tableDocRange.Start;
			var end = tableDocRange.End;
			var formulaRan = webform.WebOffice.WebObject.Range(start,end);
			formulaRan.InsertParagraph();
		}
	}catch(e){
		alert('replaceParagraphs:\n'+e.message);
	}
}

function setTextBold(sourceText){
	try{
		var tableDocRange =webform.WebOffice.WebObject.Application.Selection.Range;
		tableDocRange.Find.Wrap = 1;
		while(tableDocRange.Find.Execute(sourceText)){
			var start = tableDocRange.Start;
			var end = tableDocRange.End;
			var formulaRan = webform.WebOffice.WebObject.Range(start,end);
			formulaRan.Text=sourceText.replace('[','').replace(']','');
			formulaRan.Font.Bold=1;
		}
	}catch(e){
		alert('setTextBold:\n'+e.message);
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
    parent.close_win();
  }
  catch(e){
    alert(e.message);
  }
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
    parent.close_win();
  }catch(e){
	  alert('WebSaveLocal:\n'+e.message);
  }
}
function closeMulti(){
	parent.close_win();
}

//作用：打开本地文件
function WebOpenLocal(){
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){
	  alert('WebOpenLocal:\n'+e.message);
  }
}
</script>
	</head>
	<body bgcolor="#ffffff" onload="Load()" onunload="UnLoad()" style='margin:0px;padding:0px;overflow:hidden;'>
		<!--引导和退出iWebOffice-->
		<form name="webform" method="post">
			<!--保存iWebOffice后提交表单信息-->
			<table cellpadding=0 cellspacing=0 border=0 bordercolor="red" style="width:100%;height:100%">
				<tr>
					<td align=right class="listtabletr11" height="30">
						<div style='float:left;line-height:30px;height:30px;padding:1px 2px 1px 5px;'>综合工作底稿:<label id='StatusBar' style='padding-left:5px;'>状态栏</label></div>
						<div style='float:right;padding:2px 5px 1px 2px;'>
							<a id="btn1" href="javascript:;" onclick="WebSaveLocal()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">保存本地文件</a>
							<a id="btn2" href="javascript:;" onclick="WebOpenPrint()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">打印文件</a>
							<a id="btn3" href="javascript:;" onclick="closeMulti()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭</a>
						</div>
					</td>
				</tr>
				<tr>
					<td height="100%">
						<!--调用iWebOffice，注意版本号，可用于升级-->
						<%@ include file="/pages/commons/file/iwebOfficeControl.jsp"%>
					</td>
				</tr>
			</table>
			<s:hidden name="mRecordID" />
			<s:hidden name="mFileName" />
			<s:hidden name="mDescript" />
			<s:hidden name="mModulename" />
			<input type="hidden" name="RecordID" value="<s:property value="mRecordID"/>">
			<iframe id="frmdeltmp" name="frmdeltmp" style="display: none;" src="about:blank"></iframe>
		</form>

	</body>
</html>
