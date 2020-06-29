<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'底稿模板列表'"></s:text>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script language="javascript">
		$(function(){
			// 初始化生成表格
			$('#manuTemplateList').datagrid({
				url : "${contextPath}/commons/oaprint/manuTemplateList.action?querySource=grid&dwrModuleid=1040&manuIds2=${manuIds2}&manuType=${manuType}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:true,
				fit: true,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'newObj',
						text:'选择',
						iconCls:'icon-add',
						handler:function(){
							checkSelect();
						}
					},		
					{
						id:'emailOpr',
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							close_win();
						}
					}									
				],
				columns:[[  
					<!--{field:'templateid',title:"复选框",width:'50', checkbox:true, align:'center'},-->
	       			{field:'filename',title:'模板名称',width:'250',sortable:true,halign:'center',align:'left'},
	       			{field:'descript',title:'模块描述',width:'80',sortable:true, halign:'center',align:'left'}
				]]   
			}); 
		}); 
		function checkSelect(){
			var selectedRow = $('#manuTemplateList').datagrid('getSelected'); 
	        if(!selectedRow){
	            top.$.messager.show({
	            	title:"提示信息",
	            	msg:"请选择底稿模板！",
	            	timeout:5000,
	            	showType:'slide'
	            });
	            return;
	       }    
	        
	        var tpl = selectedRow.templateid;
			document.getElementsByName("tid")[0].value = tpl;
			var crudid='${manuIds2}';
			document.getElementsByName("crudid")[0].value = crudid;
			tplform.submit();
			$('body').layout('remove', 'center');
		}		
		
		function close_win(){
			parent.close_win();
		}
		</script>
	</head>
	<body class="easyui-layout" fit='true' border='0'>
			<input type="hidden" name="manuIds2" id="manuIds2" value="${manuIds2}"/>
			<s:form id="tplform" action="exportManuByTemplate" namespace="/commons/oaprint" method="post">
				<div region="center" border='0'>
					<table id="manuTemplateList"></table>
				</div>
			    <s:hidden name="dwrModuleid" />
			    <s:hidden name="tid" />
			    <s:hidden name="crudid" />
		        <input type="hidden" name="manuTypeName" id="manuTypeName" value="${manuTypeName}"/>
		        <input type="hidden" name="manuType"     id="manuType"     value="${manuType}"/>
			</s:form>
	</body>
</html>
