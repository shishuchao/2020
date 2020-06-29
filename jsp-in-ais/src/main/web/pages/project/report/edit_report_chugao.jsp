<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String _ServerName = request.getServerName();
int _ServerPort = request.getServerPort();
String _CtxPath = request.getContextPath();
String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>创建审计报告初稿</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/commons/file/WebOffice.js"></script>
	</head>
	<body onload="createChugao()">
		<s:form id="webform" name="webform" action="saveChugao" namespace="/project/report">
			<s:hidden id="chugaoId" name="chugao.fileId" />
			<s:hidden id="projectName" name="crudObject.project_name"/>
			<s:hidden id="projectId" name="crudObject.project_id"/>
			<div id="buttonDiv" align="center">
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveChugao();">保存审计报告初稿</a>&nbsp;
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="WebOpenPrint();">打            印</a>&nbsp;
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeEdit();">关            闭</a>&nbsp;
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

		//作用：打印文档
		function WebOpenPrint(){
			try{
				WebOffice.WebOpenPrint();
			}
			catch(e){
				StatusMsg(e.description);
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
				WebOffice.WebShow(true);
			}
			else{
				WebOffice.WebShow(false);
			}
		}

		/**
		 *	页面加载后自动分析初稿模板中的公式并后台计算替换模板中公式的值
		 */
		function createChugao(){
			WebOffice.setObj(document.getElementById('WebOffice2015'));//给2015对象赋值
			WebOffice.ShowTitleBar(false);
			WebOffice.ShowStatusBar(true);
			$('#webOfficeDiv').height($(document).height()-50);

			var chugaoId = document.getElementById('chugaoId').value;
			var projectName = document.getElementById('projectName').value;
			var projectId = document.getElementById('projectId').value;
			try{
				WebOffice.WebUrl="<%=url_prefix%>/iweb/file"+chugaoId;
				WebOffice.RecordID=chugaoId;
				WebOffice.FileName=projectName+"审计报告初稿.doc";
				WebOffice.FileType=".doc";
				WebOffice.UserName="${user.fname}";
				WebOffice.EditType='1';
				WebOffice.setEditType("1");   //EditType:编辑类型  方式一、方式二  <参考技术文档>
				WebOffice.HookEnabled();
				WebOffice.WebOpen(true);
				WebOffice.ShowCustomToolbar(false);
			    WebOffice.ShowMenuBar(false);
				countFormula();

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

		/**
		 *	保存审计报告初稿
		 */
		function saveChugao(){

			//首先保存word文档内容
			if (!WebOffice.WebSave()){
				StatusMsg('Word正文保存到服务器过程中发生未知错误!');
				return false;
			}else {
				StatusMsg("保存成功！");
			}

		}

		/**
		 *	计算模板中所有公式的值并替换到模板中
		 */
		function countFormula(){

			var chugaoId = document.getElementById('chugaoId').value;
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
