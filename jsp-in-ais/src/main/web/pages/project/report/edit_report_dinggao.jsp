<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
String _ServerName = request.getServerName();
int _ServerPort = request.getServerPort();
String _CtxPath = request.getContextPath();
String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>创建审计报告定稿</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body onload="createdinggao()">
		<s:form id="webform" name="webform" action="savedinggao" namespace="/project/report">
			<s:hidden id="dinggaoId" name="dinggao.fileId" />
			<s:hidden id="projectName" name="project_name"/>
			<s:hidden id="projectId" name="project_id"/>
			<div id="buttonDiv" align="center">
			   <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="savedinggao();">保存审计组报告</a>&nbsp;
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="WebOpenPrint();">打            印</a>&nbsp;
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeEdit();">关            闭</a>&nbsp;
			</div>
			<div id="webOfficeDiv">
				<object id="WebOffice" width="100%" height="95%"
					 classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499"
					 codebase="${contextPath}/pages/commons/file/iWebOffice2009.cab#version=10.0.0.0">
				</object>
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
	
		//作用：打印文档
		function WebOpenPrint(){
		  try{
		    webform.WebOffice.WebOpenPrint();
		  }
		  catch(e){
		    alert(e.description);
		  }
		}
		
		function closeEdit(){
			var flag =  confirm('确认关闭吗?');
			if(flag){
				window.close();
			}else{
				return false;
			}
		}
	
		//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
		function ShowRevision(mValue){
		  if (mValue){
			  webform.WebOffice.WebShow(true);
		  }
		  else{
			  webform.WebOffice.WebShow(false);
		  }
		}
	
		/**
		*	页面加载后自动分析初稿模板中的公式并后台计算替换模板中公式的值
		*/
		function createdinggao(){
			var dinggaoId = document.getElementById('dinggaoId').value;
			var projectName = document.getElementById('projectName').value;
			var projectId = document.getElementById('projectId').value;
			try{
				webform.WebOffice.WebUrl="${contextPath}/iweb/file"+dinggaoId;
				webform.WebOffice.RecordID=dinggaoId;
				webform.WebOffice.FileName=projectName+"审计报告定稿.doc";
				webform.WebOffice.FileType=".doc";
				webform.WebOffice.EditType="1";
				webform.WebOffice.ShowMenu="0";
				webform.WebOffice.WebOpen();
				
				countFormula();
				webform.WebOffice.WebSave(true);
				//刷新父页面,否则编辑和查看连接不可用
				window.opener.location.reload();
				//var superWin = window.dialogArguments;
				//superWin.location.href="/ais/project/report/edit.action?projectType=${projectType}&crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}";
				
			}catch(e){}
		}
		
		/**
		*	使用指定值替换word中的公式
		*/
		function replaceFormulaByValue(formula,value){
			
		   var allText = webform.WebOffice.WebObject.Application.Selection.Range;
		   allText.Find.Wrap = 1;
		   while(allText.Find.Execute(formula)){
			   var start = allText.Start;
			   var end = allText.End;
			   var formulaRan = webform.WebOffice.WebObject.Range(start,end);
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
		
		/**
		*	保存审计报告初稿
		*/
		function savedinggao(){
			
		  //首先保存word文档内容
		  if (!webform.WebOffice.WebSave(true)){
		     alert('Word正文保存到服务器过程中发生未知错误!');
		     return false;
		  }
		  alert("保存成功！")
		  
		}
	
		/**
		*	计算模板中所有公式的值并替换到模板中
		*/
		function countFormula(){
			
			var dinggaoId = document.getElementById('dinggaoId').value;
			var projectName = document.getElementById('projectName').value;
			var projectId = document.getElementById('projectId').value;
			
		   //读取公式并替换到word中
		   var formulaArray = new Array();//文档中包含的所有公式
		   var firstIndex = -1; //第一次查找到的索引
		   var allText = webform.WebOffice.WebObject.Application.Selection.Range;
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
			   var formulaRan = webform.WebOffice.WebObject.Range(start,end);
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
					{'projectStartFormId':projectId,'formulaListString':formulaString},
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

	</body>
</html>
