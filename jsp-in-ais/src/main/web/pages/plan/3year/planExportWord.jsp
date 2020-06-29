<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML >
<html>
	<head>
		<title>导出三年计划</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body>
			<s:hidden id="templateId" name="templateId" value="${templateId}"/>
			<s:hidden id="planName" value="${yearPlan.planName}"/>
			<s:hidden id="planId" value="${yearPlan.formId}"/>
			<div id="buttonDiv" align="center">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="webSaveLocal()">导出</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="WebOpenPrint()">打印</a>
			</div>
			<div id="webOfficeDiv">
				<object id="WebOffice" name="WebOffice" width="100%" height="100%"
					 classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499"
					 codebase="${contextPath}/pages/commons/file/iWebOffice2009.cab#version=10.0.0.0">
				</object>
			</div>
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
		$(function () {
            createWord();
            $('#webOfficeDiv').height($('body').height());
        });
		//作用：打印文档
		function WebOpenPrint(){
		  try{
		    document.WebOffice.WebOpenPrint();
		  }
		  catch(e){
		    alert(e.description);
		  }
		}
        //作用：存为本地文件
        function webSaveLocal(){
            try{
                document.WebOffice.WebSaveLocal();
                window.close();
            }catch(e){}
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
			  document.WebOffice.WebShow(true);
		  }
		  else{
			  document.WebOffice.WebShow(false);
		  }
		}

		/**
		*	页面加载后自动分析初稿模板中的公式并后台计算替换模板中公式的值
		*/
		function createWord(){

			var templateId = $('#templateId').val();
			var planName = $('#planName').val();
			try{
                document.WebOffice.WebRepairMode = true;
                document.WebOffice.Compatible=false; //兼容模式解决了docx在打开时变成doc文件

				document.WebOffice.WebUrl="${contextPath}/iweb/file"+templateId;
				document.WebOffice.RecordID=templateId;
				document.WebOffice.FileName=planName+".docx";
				document.WebOffice.FileType=".docx";
				document.WebOffice.EditType="1,1";
				document.WebOffice.ShowMenu="0";
				document.WebOffice.WebOpen(false);

				countFormula();

			}catch(e){
			    alert(e)
			}
		}

		/**
		*	使用指定值替换word中的公式
		*/
		function replaceFormulaByValue(formula,value){

		   var allText = document.WebOffice.WebObject.Application.Selection.Range;
		   allText.Find.Wrap = 1;
		   while(allText.Find.Execute(formula)){
			   var start = allText.Start;
			   var end = allText.End;
			   var formulaRan = document.WebOffice.WebObject.Range(start,end);
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
		function countFormula(){

            var planId = document.getElementById('planId').value;

		   //读取公式并替换到word中
		   var formulaArray = new Array();//文档中包含的所有公式
		   var firstIndex = -1; //第一次查找到的索引
		   var allText = document.WebOffice.WebObject.Application.Selection.Range;
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
			   var formulaRan = document.WebOffice.WebObject.Range(start,end);
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
					{'planId':planId,'formulaListString':formulaString},
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
