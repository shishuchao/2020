<%@page import="java.util.Arrays"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<%
	String _ServerName = request.getServerName();
	int _ServerPort = request.getServerPort();
	String _CtxPath = request.getContextPath();
	String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
//传过来的底稿主键，多个，以逗号分隔
	String type = (String) request.getAttribute("type");
	String manuIds = (String) request.getAttribute("form_id");
	String[] manuIdArr = {};
	if (!"".equals(manuIds) && manuIds != null) {
		manuIdArr = manuIds.split(",");
	}
%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>创建底稿记录</title>
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
<body onload="createManu()">
<!-- liululu -->
<s:form id="webform" name="webform" action="expManu" namespace="/operate/manuExt">
	<s:hidden id="evidenceId" name="templateId" />
	<s:hidden id="projectName" name="project_name"/>
	<s:hidden id="projectId" name="project_id"/>
	<div id="buttonDiv" align="center">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="webSaveLocal()">导出</a>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="WebOpenPrint()">打印</a>
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
		var flag =  confirm('确认关闭吗?');
		if(flag){
			try{
				window.opener.location.reload();
			}catch(e){}
			window.close();
		}
		
		//aud$closeTab();
	}
	//作用：打印文档
	function WebOpenPrint(){
		try{
			WebOffice.WebOpenPrint();
		}
		catch(e){
			alert(e.description);
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
	function createManu(){
		WebOffice.setObj(document.getElementById('WebOffice'));//给2015对象赋值
		WebOffice.ShowTitleBar(false);
		WebOffice.ShowStatusBar(true);
		$('#webOfficeDiv').height($(document).height()-50);

		var evidenceId = document.getElementById('evidenceId').value;
		var projectName = document.getElementById('projectName').value;
		var projectId = document.getElementById('projectId').value;
		try{
			WebOffice.WebUrl="<%=url_prefix%>/iweb/file"+evidenceId;
			WebOffice.RecordID=evidenceId;
			WebOffice.FileName=projectName+"底稿记录.doc";
			WebOffice.FileType=".doc";
			WebOffice.UserName="${user.fname}";
			WebOffice.EditType='1';
			WebOffice.setEditType("1");   //EditType:编辑类型  方式一、方式二  <参考技术文档>
			WebOffice.ShowMenuBar(false);
			WebOffice.HookEnabled();
			WebOffice.WebOpen(true);
			WebOffice.ShowCustomToolbar(false);
		    WebOffice.ShowMenuBar(false);
			//如果是综合
			if('<%=type%>'=='COMPREHENSIVE'){
				countFormula('<%=manuIds%>','<%=type%>');
			}else{
				<%
                //如果选择了多个底稿，则对模版进行复制操作
                    if(manuIdArr.length>1){%>
				var allDoc=WebOffice.WebObject.ActiveDocument.Application.Selection;
				allDoc.WholeStory();
				allDoc.Copy();
				var wdStory=6;
				var wdMove=0;
				var wdPageBreak=7;
				var wdFormatOriginalFormatting=16;
				countFormula('<%=manuIdArr[0]%>','<%=type%>');
				<%
                    for(int i=1;i<manuIdArr.length;i++){
                        String manuId=manuIdArr[i];
              %>
				try{
					allDoc.EndOf(wdStory,wdMove);
					allDoc.InsertBreak(wdPageBreak);
					allDoc.PasteAndFormat(wdFormatOriginalFormatting);
					//换算公式
					countFormula('<%=manuId%>','<%=type%>');
				}catch(e){
					alert(e);
				}
				<%
                        }
                    }else{ %>
				countFormula('<%=manuIdArr[0]%>','<%=type%>');
				<%	 }
             %>
			}

			countFormulaTH();
		}catch(e){}
	}

	function countFormulaTH(){
		try{
			//读取公式并替换到word中
			var formulaArray = new Array();//文档中包含的所有公式
			var firstIndex = -1; //第一次查找到的索引
			var allText = WebOffice.WebObject.ActiveDocument.Application.Selection.Range;
			allText.Find.Wrap = 1;
			while(allText.Find.Execute('#jq!#')){
				var start = allText.Start;
				if(firstIndex==start){
					break;//再次查找到了第一次查找到的公式
				}
				if(firstIndex==-1){
					firstIndex = start;
				}
				allText.Find.Execute('#jq!#')
				var end = allText.End;
				var formulaRan = WebOffice.WebObject.ActiveDocument.Range(start,end);
				var formula = formulaRan.Text;
				formula = formula.substr(5,formula.length);
				formula = formula.substr(0,formula.length-5);
				formulaRan.Text = formula;
				formulaRan.Font.Bold=1;
			}
		}catch(e){
			alert('countFormula:\n'+e.message);
		}
	}
		
		/**
		*	使用指定值替换word中的公式
		*/
		function replaceFormulaByValue(formula,value){
			var allText = WebOffice.WebObject.ActiveDocument.Application.Selection.Range;
		   allText.Find.Wrap = 1;
		   while(allText.Find.Execute(formula)){
			   
			   value = value.replace(/<img.*?(?:>|\/>)/gi, function (){
	    	        //调用方法时内部会产生 this 和 arguments
	    	      var s = arguments[0].match(/title=[\'\"]?([^\'\"]*)[\'\"]?/i);
	    	      
	    	      if(formula == '{审计过程记录}') {
	    	    	   WebInsertImage('Image1',s[1],true,5);
				   } else if(formula == '{审计结论}') {
					   WebInsertImage('Image2',s[1],true,5);
				   }
	    	      return '';
	    	       
	    	    });
			   
			   var start = allText.Start;
			   var end = allText.End;
			   var formulaRan =  WebOffice.WebObject.ActiveDocument.Range(start,end);
			   if(value.indexOf('<table>') != -1) {
				   value = value.replace(/<table.*<\/table>/g, function(){
					   var sjjl = arguments[0];
					   var sjjlR = '';
					   $.ajax({
				   			url:'${contextPath}/unitary/nc/autoreport/jxhtmlValue.action',
				   			async:false,
				   			data:{'sjjl':sjjl},
				   			type:'POST',
				   			success:function(data) {
								if(typeof data != 'undefined'){
									var formulaRan =  WebOffice.WebObject.ActiveDocument.Range(start,end);
									formulaRan.Text = data;
									var onetable = formulaRan.ConvertToTable('|');
									onetable.Borders.InsideLineStyle = 1;
									onetable.Borders.OutsideLineStyle = 1;
								} 
				   			}
				   		});
					   return '';
				   });
				   
				   if(start > 2) {
					   var formulaRanB = WebOffice.WebObject.ActiveDocument.Range(start-2,start-1);
				   	   if(value != '') {
				   	       formulaRanB.Text = ('\r\n' + value).replace(/<p>/g,'').replace(/<\/p>/g,'').replace(/&nbsp;/g,'').replace(/<\/span>/g,'\r\n').replace(/<span.*;">/g,'').replace(/<br\/>/g,'');
				   	   }
				   }
			   } else {
				   formulaRan.Text = value.replace(/<p>/g,'').replace(/<\/p>/g,'').replace(/&nbsp;/g,'').replace(/<\/span>/g,'\r\n').replace(/<span.*;">/g,'').replace(/<br\/>/g,'');
			   }
		   }
		}
	//作用：存为本地文件
	function webSaveLocal(){
		try{
			WebOffice.WebSaveLocal();
			window.close();
		}catch(e){}
	}

	/**
	 *	保存审计报告初稿
	 */
	function expManu(){
		var evidenceId = document.getElementById('evidenceId').value;
		var url = "${contextPath}" + "/commons/file/downloadFile.action?fileId=" + evidenceId;
		window.open(url, "","height=500px, width=600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		closeEdit();
	}

	/**
	 *	计算模板中所有公式的值并替换到模板中
	 */
	function countFormula(manuId,type){
		var evidenceId = document.getElementById('evidenceId').value;
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
					{'projectStartFormId':projectId,'formulaListString':formulaString,'manuId':manuId,'type':type},
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
		
		function WebInsertImage(mark, image){
			  try{
			    WebOffice.WebInsertImage(mark,image,true,4);   //交互OfficeServer的OPTION="INSERTIMAGE"  参数1表示标签名称  参数2表示图片文件名  参数3为true透明  false表示不透明  参数4为4表示浮于文字上方  5表示衬于文字下方
			  }catch(e){
				alert(e.description);
			  }
			}
	</script>

	</body>
</html>
