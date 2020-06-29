<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>自动审计报告公式</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>   
		<script type="text/javascript">
			function load(){
				var selectedValue = '${selectedValue}';
				var opts = document.getElementById("formulaList");
				if('' != selectedValue){
					for(var i=0;i<opts.options.length;i++){
						if(selectedValue==opts.options[i].value){
		                    opts.options[i].selected = 'selected';
		                    break;
	             		}
             		}
					var editArea = document.getElementById('formulaFrame');
					editArea.src='/ais/unitary/nc/autoreport/editFormula.action?formula.id='+selectedValue;
				}
			}
			/**
			*	编辑公式
			*/
			function editFormula(){
				var selectedValue = document.getElementById('formulaList').value;
				var editArea = document.getElementById('formulaFrame');
				editArea.src='/ais/unitary/nc/autoreport/editFormula.action?formula.id='+selectedValue;
			}
			
			/**
			*	新建公式
			*/
			function newFormula(){
				var editArea = document.getElementById('formulaFrame');
				editArea.src='/ais/unitary/nc/autoreport/editFormula.action';
			}
			
			/**
			*	保存公式
			*/
			function saveFormula(){
				var selectedValue = document.getElementById('formulaList').value;
				var editArea = document.getElementById('formulaFrame');
				//var val=document.getElementsByName('formula.name');//formula.name
				var val = $('#formulaFrame').contents().find('#formulaForm').find('#formulaName').val();//formula.name
				if(val.value ==""){
					showMessage1('请输入公式名称');
					return false;
				}
				$.ajax({
					type:"post",
					data:$('#formulaFrame').contents().find('#formulaForm').serialize(),
					url:"/ais/unitary/nc/autoreport/saveFormula.action",
					async:false,
					success:function(data){
				    	showMessage1('保存成功！');
				    	window.location.href='/ais/unitary/nc/autoreport/reportFormula.action?id='+selectedValue;
				    	//window.location.href='/ais/unitary/nc/autoreport/editFormula.action?formula.id='+selectedValue;
					}
				});
				//window.frames['formulaFrame'].document.forms["formulaForm"].submit();
			}
			
			/**
			*	删除公式
			*/
			function deleteFormula(){
				var editArea = document.getElementById('formulaFrame');
				window.frames['formulaFrame'].document.forms["formulaForm"].action='/ais/unitary/nc/autoreport/deleteFormula.action';
				window.frames['formulaFrame'].document.forms["formulaForm"].submit();
			}
			
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow-y:auto;" class="easyui-layout" fit='false' border='0' onload="load()">
		<div region='center' border='0'>	
			<table cellpadding=0 cellspacing=1 border=0 class="ListTable" align="center" >
				<tr>
					<td class="EditHead" style='width:200px;'>
						<div align="center">
						<font size="4">公式列表</font>
						</div>
						<s:select id="formulaList" name="formula.id" cssStyle="width:200px;height:550px;"
								list="formulaList" listKey="id" listValue="name"
								disabled="false" theme="ufaud_simple"
								templateDir="/strutsTemplate" multiple="true" ondblclick="editFormula()"/>
					</td>
					<td class="editTd">
						<div id="buttonDiv" style="text-align:left;padding-right:5px;">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="newFormula()">新建</a>&nbsp;&nbsp;
							<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormula()">保存</a>&nbsp;&nbsp;
							<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteFormula()">删除</a>&nbsp;&nbsp;
						</div>
						<iframe id="formulaFrame" src="" frameborder="0" width="100%" height="550px" scrolling="no"></iframe>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
