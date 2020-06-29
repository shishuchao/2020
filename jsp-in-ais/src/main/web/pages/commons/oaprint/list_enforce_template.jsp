<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'实施方案模板列表'"></s:text>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script language="javascript">
		function checkSelect(){
			var selectedRows = $('#manuTemplateList').datagrid('getChecked');//返回是个数组; 
	        if(selectedRows.length==0){
	            $.messager.show({
	            	title:"提示信息",
	            	msg:"请选择底稿模板！",
	            	timeout:5000,
	            });
	            return;
	       }    
	        var tpl = selectedRows[0].templateid;
			document.getElementsByName("tid")[0].value = tpl;
			tplform.submit();

		}		
		
		function close_win(){
			parent.close_win();
		}
		$(function(){
			// 初始化生成表格
			$('#manuTemplateList').datagrid({
				url : "${contextPath}/commons/oaprint/manuTemplateList.action?querySource=grid&moduleid=EnforceTemplate",
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
				singleSelect:false,
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
					{field:'templateid',title:"复选框",width:'50', checkbox:true, align:'center'},
	       			{field:'filename',title:'模板名称',width:'250',sortable:true,align:'center'},
	       			{field:'descript',title:'模块描述',width:'80',sortable:true,align:'center'}
				]]   
			}); 
		}); 
		</script>
	</head>
	<body class="easyui-layout">
		<s:form id="tplform" action="exportEnforeTemplate" namespace="/commons/oaprint" method="post">
			<div region="center" >
					<table id="manuTemplateList"></table>
				</div>
	    <s:hidden name="dwrModuleid" />
	    <s:hidden name="tid" />
		<input type='hidden' name='projectId' id='projectId' value="${projectId}"/>
		</s:form>
	</body>
</html>
