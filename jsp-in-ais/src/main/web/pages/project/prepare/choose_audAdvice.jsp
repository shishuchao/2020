<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计报告模板列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
</head>
<body>
<div style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true">
	<div region="center" border='0'>
		<table id="templateList"></table>
	</div>
	<div id="templateWindow" title="审计模板" style="overflow:hidden;padding:0px">
		<iframe id="template" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		// 初始化生成表格
		$('#templateList').datagrid({
			url : "<%=request.getContextPath()%>/project/prepare/audAdvice/templateList.action?crudId=${crudId}&project_id=${project_id}&taskInstanceId=${taskInstanceId}&choose=true",
			method:'post',
			showFooter:false,
			rownumbers:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			fitColumns:true,
			idField:'id',
			border:false,
			singleSelect:true,
			remoteSort: false,
			columns:[[
				{field:'name',
					title:'模板名称',
					width:200,
					halign:'center',
					align:'left',
					sortable:true
				},
				{field:'operate',
					title:'操作',
					halign:'center',
					align:'center',
					width:100,
					sortable:false,
					formatter:function(value,row,index){
						var link = '<a href=\"javascript:void(0);\" onclick=\"chooseTemplate(\''+row.id+'\',\''+row.projectTypeCode+'\')\">编辑模板</a>';
						return link;
					}
				}
			]]
		});

		$('#templateWindow').window({
			width:950,
			height:450,
			modal:true,
			fit:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true,
			onClose:function(){
				$('#templateList').datagrid('reload');
			}
		});
	});

	function chooseTemplate(templateId,projectTypeCode){
			window.location.href="<%=request.getContextPath()%>/project/prepare/audAdvice/edit!createAudAdvice.action?crudId=${crudId}&project_id=${project_id}&taskInstanceId=${taskInstanceId}&choose=true&templateId="+templateId+"&projectTypeCode="+projectTypeCode;
	}


</script>
</body>
</html>