<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>项目小组列表</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center" >
			<table id="list_groupList"></table>
		</div>
		<s:hidden name="crudId" />
		<script type="text/javascript">
			$(function(){
				// 初始化生成表格
				$('#list_groupList').datagrid({
					url : "<%=request.getContextPath()%>/project/listGroupsView.action?querySource=grid&projectFormId=${crudId}",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					pageSize: 20,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					columns:[[  
						{field:'groupTypeName',
							title:'分组类型',width:180,
							halign:'center',align:'left',
							sortable:true
						},
						{field:'groupName',
							 title:'分组名称',width:300,
							 halign:'center',align:'left',
							 sortable:true
						},
						{field:'auditObjectName',
							 title:'被审计单位',width:500,
							 halign:'center',align:'left', 
							 sortable:true
						},
						{field:'description',
							 title:'分组说明',width:300,
							 halign:'center',align:'left', 
							 sortable:true
						}
					]]   
				});
			});
		</script>
	</body>
</html>