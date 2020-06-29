<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<%
	//传过来的底稿主键，多个，以逗号分隔
	String manuIds = (String) request.getAttribute("manuIds");
	String[] manuIdArr = {};
	if (!"".equals(manuIds) && manuIds != null) {
		manuIdArr = manuIds.split(",");
	}
%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>创建查询书记录</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body onload="createManu()">
		<s:form id="webform" name="webform" action="archivesAllWriter" namespace="/archives/workprogram/pigeonhole">
			<s:hidden id="evidenceId" name="templateId" />
			<s:hidden id="projectId" name="project_id"/>
			<s:hidden id="type" name="type"/>
			<s:hidden id="archives_form_id" name="archives_form_id"/>
			<div id="buttonDiv" align="center">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="expManu()">导出</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeEdit()">关闭</a>
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
	
		function closeEdit(){
			window.close();
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
		function createManu(){
			var evidenceId = document.getElementById('evidenceId').value;
			var projectId = document.getElementById('projectId').value;
			var type = document.getElementById('type').value;
			var archives_form_id = document.getElementById('archives_form_id').value;
			try{
				webform.WebOffice.WebUrl="${contextPath}/iweb/file"+evidenceId;
				webform.WebOffice.RecordID=evidenceId;
				webform.WebOffice.FileName="BOOK_"+projectId+".doc";
				webform.WebOffice.FileType=".doc";
				webform.WebOffice.EditType="1";
				webform.WebOffice.ShowMenu="0";
				webform.WebOffice.WebOpen();
				//测试复制模板
				  <%
				  //如果选择了多个底稿，则对模板进行复制操作
				  	if(manuIdArr.length>1){%>
				  		var allDoc=webform.WebOffice.WebObject.Application.Selection;
				  		allDoc.WholeStory();
				  		allDoc.Copy();
				  		var wdStory=6;
				  		var wdMove=0;
				  		var wdPageBreak=7;
				  		var wdFormatOriginalFormatting=16;
				  		countFormula('<%=manuIdArr[0]%>');
				  	<%
				  		for(int i=1;i<manuIdArr.length;i++){
				  			String manuId=manuIdArr[i];
				    %>
							  try{
								  allDoc.EndOf(wdStory,wdMove);
								  allDoc.InsertBreak(wdPageBreak);
								  allDoc.PasteAndFormat(wdFormatOriginalFormatting);
								  //换算公式
									countFormula('<%=manuId%>');
							  }catch(e){
								  alert(e);
							  }
							  <%
				  		}
				 	 }else{ %>
				 	countFormula('<%=manuIdArr[0]%>');
				 	<%	 }
				  %>
				
				
				//在控件中直接显示文档，需要保存到本地的，自行点击保存到本地按钮
				  webform.WebOffice.WebSave(true);
				//保存完成以后，跳回弹出的页面  by wk 2016 11 30
				parent.window.location.href="${contextPath}/operate/manuExt/reportTemplateList.action?project_id="+projectId+"&type="+type+"&form_id="+archives_form_id+"&templateId="+evidenceId;
				//刷新父页面,否则编辑和查看连接不可用
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
		*	计算模板中所有公式的值并替换到模板中
		*/
		function countFormula(manuId){
			
			var evidenceId = document.getElementById('evidenceId').value;
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

	</body>
</html>
