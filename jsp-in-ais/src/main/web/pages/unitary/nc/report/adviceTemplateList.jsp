<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计通知书模板列表</title>
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
	<div id="templateWindow" title="审计通知书模板" style="overflow:hidden;padding:0px">
		<iframe id="template" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		// 初始化生成表格
		$('#templateList').datagrid({
			url : "<%=request.getContextPath()%>/unitary/nc/autoreport/adviceTemplateList.action?template.projectTypeCode=<%=request.getParameter("projectTypeCode")%>&fromType=<%=request.getParameter("fromType")%>",
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
			toolbar:[{
					text:'新增',
					iconCls:'icon-add',
					handler:function(){
						modifyTemplate('','<%=request.getParameter("projectTypeCode")%>');
					}
			}],
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
						var link = '<a href=\"javascript:void(0);\" onclick=\"modifyTemplate(\''+row.id+'\',\''+row.projectTypeCode+'\')\">编辑模板</a>|<a href=\"javascript:void(0);\" onclick=\"deleteTemplate(\''+row.id+'\')\">删除模板</a>';
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

	function deleteTemplate(templateId){
		top.$.messager.confirm('确认','确定要删除此模板吗?',function(r){
			if(r){
				$.ajax({
					url:'<%=request.getContextPath()%>/unitary/nc/autoreport/deleteTemplate.action',
					type:'get',
					data:{
						'template.id':templateId
					},
					success:function(data){
						if(data == 'ok') {
							showMessage1('删除模板成功!');
							$('#templateList').datagrid('reload');
						}else{
							showMessage1('删除模板失败!');
						}
					}
				});
			}
		});
	}

	function modifyTemplate(templateId,projectTypeCode){
		var url = "<%=request.getContextPath()%>/unitary/nc/autoreport/adviceData.action?templateId="+templateId+"&projectTypeCode="+projectTypeCode;
		$('#template').attr("src",url);
		$('#templateWindow').window('open');
	}

</script>
</body>
</html>