<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>设置流程适用单位</title>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell{
				height:10%;
				padding:1px;
			}
		</STYLE>
		<script type="text/javascript">
		function openAddWindow()
		{
			window.location.href='<s:url action="toAddDefinitionDept" namespace="/bpm/definition" includeParams="none"></s:url>?definitionId=${definitionId}';
		}
		function openSearchWindow() {
            window.location.href='<s:url action="toSearchDefinitionDept" namespace="/bpm/definition" includeParams="none"></s:url>?definitionId=${definitionId}';
        }
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center" border='0'>
			<table id="depts"></table>
		</div>
	</body>
	<script type="text/javascript">
	$(function(){
		$('#depts').datagrid({
			url : "<%=request.getContextPath()%>/bpm/definition/findDefinitionDepts.action?querySource=grid&audit_object_name=${audit_object_name}&definitionId=${definitionId}",
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
                id:'search',
                text:'查询',
                iconCls:'icon-search',
                handler:function(){
                    openSearchWindow();
                }
            },{
					id:'newYear',
					text:'添加流程适用单位',
					iconCls:'icon-add',
					handler:function(){
						openAddWindow();
					}
				}
			],
			columns:[[  
	            {field:'deptNames',
		            title:'单位名称',
		            width:100,
		            sortable:true,
		            align:'center'
	            },						
				{field:'operate',
					 title:'操作',
					 width:100, 
					 align:'center', 
					 sortable:false,
					 formatter:function(value,row,index){
					 	 var param = [row.id];
						 var btn2 = "删除,deleteInfo,"+param.join(',');
						 return ganerateBtn(btn2);
					 }
				}
			]]   
		}); 
	});
	function deleteInfo(id){
		$.messager.confirm('提示信息','确认删除吗？',function(isDel){
			if(isDel){
				window.location.href="${contextPath}/bpm/definition/deleteDEfinitionDept.action?definitionDeptId="+id+"&definitionId=${definitionId}";
				showMessage1('删除成功！');
			}else{
				return false;
			}
		});
	}
	</script>
</html>