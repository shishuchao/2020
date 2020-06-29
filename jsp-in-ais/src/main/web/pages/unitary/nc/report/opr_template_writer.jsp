<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<%
	String _ServerName = request.getServerName();
	int _ServerPort = request.getServerPort();
	String _CtxPath = request.getContextPath();
	String url_prefix="http://" + _ServerName + ":" + _ServerPort + _CtxPath ;
%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>文书模板</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/commons/file/WebOffice.js"></script>
	<script type="text/javascript">
		var WebOffice = new WebOffice2015(); //创建WebOffice对象
	</script>

</head>
<body onload="editTemplate();">
<s:form id="webform" name="webform" action="saveWriterTemplate" namespace="/unitary/nc/autoreport">
	<table cellpadding=0 cellspacing=1 border=0
		   bgcolor="#409cce" class="ListTable" align="center" style="width: 100%;text-align: center;" id="table1">
		<tr>
			<td colspan="2">
				模板名称:
				<input type="text" class="noborder" value="${moName}" id="moName" name="moName" />
				&nbsp;适用项目类型:
				<input id="pro_type" style="width:200px;"/>
				<input type="hidden" id="code" name="code" value="${code}"/>
				<input type="hidden" id="typeName" name="typeName" value="${typeName}"/>
				&nbsp;&nbsp;对应模块:
				<s:select list="modelTypeList" listKey="code" listValue="name"
						  id="toPackage" name="toPackage" ></s:select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<s:if test="${isView != 'view'}">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveTemplate()">保存</a>
				</s:if>
			</td>
		</tr>
	</table>
	<div id="hiddenDiv1">
	<table cellpadding=0 cellspacing=1 border=0
		   bgcolor="#409cce" class="ListTable" align="center" style="width: 95%;" id="myTable">
		<tr>
			<td colspan="2" height="10px" align="left" class="statue">状态：<span id="state"></span></td>
		</tr>
		<tr>
			<td class="editTd" style="width:95%;height:100%;" id="objectTD">
				<s:hidden id="templateId" />
				<s:hidden id="id" />
				<s:hidden id="fromType" />
				<script type="text/javascript" src="<%=request.getContextPath()%>/pages/commons/file/iWebOffice2015.js"></script>
			</td>
			<s:if test="${isView != 'view'}">
			<td class="editTd" style="width:5%;" nowrap="nowrap">
				<div align="center">
					<font size="4">公式列表</font>
				</div>
				<s:select id="formulaList" name="formula.id" cssStyle="width:150px;height:500px;"
						  list="formulaList" listKey="name" listValue="name"
						  disabled="false" theme="ufaud_simple"
						  templateDir="/strutsTemplate" multiple="true" ondblclick="insertFormula(this.value)"/>
				</s:if>
			</td>
		</tr>
	</table>
	</div>
</s:form>
<script type="text/javascript">
	$(function(){
		var json = eval('(${projectTypeList})');
		$('#pro_type').combobox({
			data:json.projectTypeList,
			valueField:'code',
			panelHeight:'200',
			textField:'name',
			multiple:true,
			editable:false,
			onShowPanel:function(){
				document.getElementById("hiddenDiv1").style.display="none";
			},
			onHidePanel:function(){
				document.getElementById("hiddenDiv1").style.display="";
			}
		});
		$('#toPackage').combobox({
			onShowPanel:function(){
				document.getElementById("hiddenDiv1").style.display="none";
			},
			onHidePanel:function(){
				document.getElementById("hiddenDiv1").style.display="";
			}
		});
		
		if('${code}'!=null&&'${code}'!=''){
			$('#pro_type').combobox('setValues','${code}'.split(','));
			$('#pro_type').combobox('setText','${typeName}');
		}
		$('#toPackage').combobox({
			panelHeight:'auto'
		});

	});


	function editTemplate(){
		try{
			var template = null;
			$.ajax({
				url:'${contextPath}/unitary/nc/autoreport/editWriterTemplate.action',
				type:'post',
				dataType:'json',
				async:false,
				data:{
					'template.id':'${templateId}',
					'fromType':'${fromType}'
				},
				success:function(data){
					template = data;
				}
			});
			document.getElementById('id').value=template.id;
			document.getElementById('templateId').value=template.templateId;
			$('#moName').val(template.name);
			WebOffice.setObj(document.getElementById('WebOffice'));//给2015对象赋值
			WebOffice.ShowTitleBar(false);
			WebOffice.ShowStatusBar(true);
			$('#myTable').height($(document).height()-$('#table1').height());
			$('#webOfficeDiv').height($('#objectTD').height());

			WebOffice.WebUrl="<%=url_prefix%>/iweb/file"+template.templateId;
			WebOffice.RecordID=template.templateId;   //RecordID:项目编码
			WebOffice.FileName=template.templateId+"_项目文书模板.doc";
			WebOffice.FileType=".doc";   //FileType:文档类型  .doc  .xls  .wps
			WebOffice.setEditType("1");   //EditType:编辑类型  方式一、方式二  <参考技术文档>
			WebOffice.EditType='1';
			WebOffice.UserName='${user.floginname}';
			WebOffice.HookEnabled();
			WebOffice.WebOpen(true);
			WebOffice.ShowCustomToolbar(false);
		    WebOffice.ShowMenuBar(false);
			WebOffice.WebShow(false);
		}catch(e){
			//alert(e.message);
		}
	}

	/**
	 *	插入指定公式到光标位置
	 */
	function insertFormula(formulaName){
		WebOffice.WebObject.ActiveDocument.Application.Selection.Range.InsertBefore('{'+formulaName+'}');
	}
	function setprotype(){
		var text = $('#pro_type').combobox('getText');
		var value = $('#pro_type').combobox('getValues');
		$('#code').val(value);
		$('#typeName').val(text);
	}

	/**
	 *	保存模板
	 */
	function saveTemplate(){
		//设置 适用项目类型
		setprotype();
		var toPackage=$('#toPackage').combobox('getValues');
		document.getElementById('toPackage').value=toPackage;
		//首先保存word文档内容
		if (!WebOffice.WebSave()){
			StatusMsg('Word正文保存到服务器过程中发生未知错误!');
			return false;
		}

		//然后保存模板相关信息
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);
		DWRActionUtil.execute(
				{ namespace:'/unitary/nc/autoreport', action:'saveWriterTemplate', executeResult:'false' },
				{   'code':$('#code').val(),
					'typeName':$('#typeName').val(),
					'template.id':document.getElementById('id').value,
					'template.templateId':document.getElementById('templateId').value,
					'moName':$('#moName').val(),
					'toPackage':$('#toPackage').val()},
				xxx);
		function xxx(data){
			StatusMsg(data['ajaxMessage']);
		}

	}
	//设置页面中的状态值
	function StatusMsg(mValue){
		try{
			document.getElementById('state').innerHTML = mValue;
		}catch(e){
			return false;
		}
	}
</script>

</body>
</html>
