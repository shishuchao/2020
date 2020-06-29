<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String _ServerName = request.getServerName();
int _ServerPort = request.getServerPort();
String _CtxPath = request.getContextPath();
String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
//传过来的记录主键，多个，以逗号分隔
	String enforceIds = (String) request.getAttribute("crudId");
	String[] enforceIdArr = {};
	if (!"".equals(enforceIds) && enforceIds != null) {
		enforceIdArr = enforceIds.split(",");
	}
%>
<html>
	<head>
		<!-- <meta http-equiv="X-UA-Compatible" content="IE=5"> -->
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>实施方案导出模板</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/commons/file/WebOffice.js"></script>
		<script type="text/javascript">
			var WebOffice = new WebOffice2015(); //创建WebOffice对象
		</script>	
	</head>
	<body onload="createEnforceTemplate()">
		<s:form id="webform" name="webform" action="exportEnforeTemplate" namespace="/project/prepare">
			<s:hidden id="enforceId" name="templateId" />
			<s:hidden id="projectName" name="project_name"/>
			<s:hidden id="projectId" name="project_id"/>
			<div id="buttonDiv" align="center">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="webSaveLocal()">导出</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeEdit()">关闭</a>
			</div>
			<div id="webOfficeDiv">
				<script type="text/javascript" src="<%=request.getContextPath()%>/pages/commons/file/iWebOffice2015.js"></script>
			</div>
		
		</s:form>
	<script type="text/javascript">
		
		Array.prototype.contains = function(myValue){
			for(var i=0; i<this.length; i++){
			   var element = this[i];
			   if(element == myValue){
				   return true;
			   }
			}
			return false;  
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
	
		/**
		*	页面加载后自动分析初稿模板中的公式并后台计算替换模板中公式的值
		*/
		function createEnforceTemplate(){
			WebOffice.setObj(document.getElementById('WebOffice'));//给2015对象赋值
			WebOffice.ShowTitleBar(false);
			WebOffice.ShowStatusBar(true);
			$('#webOfficeDiv').height($(document).height()-50);

			var enforceId = document.getElementById('enforceId').value;
			var projectName = document.getElementById('projectName').value;
			var projectId = document.getElementById('projectId').value;
			try{
				WebOffice.WebUrl="<%=url_prefix%>/iweb/file"+enforceId;
				WebOffice.RecordID=enforceId;
				WebOffice.FileName="ENFORCE_"+projectId+".doc";
				WebOffice.FileType=".doc";
				WebOffice.UserName="${user.fname}";
				WebOffice.setEditType("1");   //EditType:编辑类型  方式一、方式二  <参考技术文档>
				WebOffice.HookEnabled();
				WebOffice.WebOpen(true);
				WebOffice.ShowCustomToolbar(false);
			    WebOffice.ShowMenuBar(false);
				//测试复制模版
				  <%
				  //如果选择了多个底稿，则对模版进行复制操作
				  	if(enforceIdArr.length>1){%>
				  		var allDoc=WebOffice.WebObject.ActiveDocument.Application.Selection;
				  		allDoc.WholeStory();
				  		allDoc.Copy();
				  		var wdStory=6;
				  		var wdMove=0;
				  		var wdPageBreak=7;
				  		var wdFormatOriginalFormatting=16;
				  		countFormula('<%=enforceIdArr[0]%>');
				  	<%
				  		for(int i=1;i<enforceIdArr.length;i++){
				  			String enforceId=enforceIdArr[i];
				    %>
							  try{
								  allDoc.EndOf(wdStory,wdMove);
								  allDoc.InsertBreak(wdPageBreak);
								  allDoc.PasteAndFormat(wdFormatOriginalFormatting);
								//换算公式
									countFormula('<%=enforceId%>');
							  }catch(e){
								  alert(e);
							  }
							  <%
				  		}
				 	 }else{ %>
				 		countFormula('<%=enforceIdArr[0]%>');
				 	<%	 }
				  %>
				 WebOffice.WebSave(true);
				 //alert(webform.WebOffice.Status);
				 $("#sucFlag").val(WebOffice.Status);
				//刷新父页面,否则编辑和查看连接不可用
				//var superWin = window.dialogArguments;
				//superWin.location.href="/ais/project/report/edit.action?projectType=${projectType}&crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}";
				
			}catch(e){}
		}
		
		/**
		*	使用指定值替换word中的公式
		*/
		function replaceFormulaByValue(formula,value){
			
		   var allText = WebOffice.WebObject.ActiveDocument.Application.Selection.Range;
		   allText.Find.Wrap = 1;
		   while(allText.Find.Execute(formula)){
			   var start = allText.Start;
			   var end = allText.End;
			   var formulaRan = WebOffice.WebObject.ActiveDocument.Range(start,end);
			   if(typeof value=='string' && value.length > 5 && value.substr(0,5)=='table'){//表格直接替换
				   value = value.substr(5,value.length);
				   formulaRan.Text = value;
				   var onetable = formulaRan.ConvertToTable('|');
				   onetable.Borders.InsideLineStyle = 1;
				   onetable.Borders.OutsideLineStyle = 1;

			   }else{
				   formulaRan.Text = value;
			   }
		   }
		}
		//作用：存为本地文件
		function webSaveLocal(){
		  try{
		    WebOffice.WebSaveLocal();
		    closeEdit();
		  }catch(e){}
		}
		/**
		*	保存审计报告初稿
		*/
		function expEvidence(){
			//var evidenceId = document.getElementById('evidenceId').value;
			//var url = "${contextPath}" + "/commons/file/downloadFile.action?fileId=" + evidenceId;
			//window.open(url, "","height=500px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
			//window.location.href="${contextPath}/commons/file/downloadFile.action?fileId="+evidenceId;
			//window.open('${contextPath}/commons/file/downloadFile.action?fileId='+evidenceId,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')
			WebSaveLocal();
			closeEdit();
		}
	
		/**
		*	计算模板中所有公式的值并替换到模板中
		*/
		function countFormula(manuId){
			
			var enforceId = document.getElementById('enforceId').value;
			var projectName = document.getElementById('projectName').value;
			var projectId = document.getElementById('projectId').value;
			
		   //读取公式并替换到word中
		   var formulaArray = new Array();//文档中包含的所有公式
		   var firstIndex = -1; //第一次查找到的索引
		   var allText = WebOffice.WebObject.ActiveDocument.Application.Selection.Range;
		   allText.Find.Wrap = 1;
		   while(allText.Find.Execute('{')){
			   
			   var start = allText.Start;
			   if(firstIndex==start){
				   break;//再次查找到了第一次查找到的公式
			   }
			   if(firstIndex==-1){
				   firstIndex = start;
			   }
			   allText.Find.Execute('}')
			   var end = allText.End;
			   var formulaRan = WebOffice.WebObject.ActiveDocument.Range(start,end);
			   var formula = formulaRan.Text;
			   if(!formulaArray.contains(formula)){
				   formulaArray.push(formula);
			   }
		   }
			   
			//保存替换后的文档
			if(formulaArray.length > 0){//文档中包含公式
			   //把保存公式的Array转为|分隔的字符串传递给后台
			   var formulaString = '';
			   for(var i=0;i<formulaArray.length;i++){
				   formulaString = formulaString+'|'+formulaArray[i];
			   }
				   
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/unitary/nc/autoreport', action:'countFormulaValue', executeResult:'false' }, 
					{'projectStartFormId':projectId,'formulaListString':formulaString,'manuId':manuId},
					xxx);
				function xxx(data){
					var formulaValue = data['formulaValue'];
					if(typeof formulaValue != 'undefined'){
						var formulaMap = eval('('+formulaValue+')');
						 for(var i=0;i<formulaArray.length;i++){
						 	var formula = formulaArray[i];
						 	var value = formulaMap[formula];
						 	if(typeof value != 'undefined'){
						 		replaceFormulaByValue(formula,value);
						 	}
						 }
					}
				}
			}
			
		}
		
	</script>
	<input type="hidden2" name="sucFlag" id="sucFlag" />
	</body>
</html>