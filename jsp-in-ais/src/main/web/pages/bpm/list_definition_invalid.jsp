<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:text id="title" name="'已失效流程定义'"></s:text>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script> 
		<script type="text/javascript">
			$(function(){
				$('#bpmDefinitionList').datagrid({
					url : "<%=request.getContextPath()%>/bpm/definition/list_invalid.action?querySource=grid",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize:20,
					fitColumns:true,
					idField:'id',
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[{
							text:'刷新',
							iconCls:'icon-reload',
							handler:function(){
								$('#bpmDefinitionList').datagrid('reload');
							}
						}
					],
					columns:[[  
		       			{field:'name2Display',title:'流程名称',sortable:true,width:100,halign:'center',align:'left'},
		       			{field:'table_name',title:'业务对象',width:100,sortable:true,halign:'center',align:'left'},
						{field:'form_name',
								title:'表单类型',
								width:100,
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
							 formatter:function(value,row,rowIndex){
								<s:if test="${view eq 'view'}">
									return '<a href=\"javascript:void(0)\" onclick="window.open(\'${contextPath}/bpm/definition/viewWebflow.action?opertion=invaild&bpmDefinition.id='+row.id+'\',\'流程图例\',\'height=550px, width=660px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no\')">查看流程图例</a>
								</s:if>
								<s:else>
									return '<a href=\"javascript:void(0)\" onclick=\"active(\''+row.id+'\');\">激活</a>'
											+'&nbsp;&nbsp;'+
											'<a href=\"javascript:void(0)\" onclick="window.open(\'${contextPath}/bpm/definition/viewWebflow.action?opertion=invaild&bpmDefinition.id='+row.id+'\',\'流程图例\',\'height=550px, width=660px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no\')">查看流程图例</a>';
								</s:else>
							 }
						}
					]]   
				}); 
			});
			
			function active(id){
				$.messager.confirm('提示信息','确认激活该流程，将它置为未发布状态？',function(flag){
					if(flag){
						$.ajax({
						    type:'post',
							url:'${contextPath}/bpm/definition/validprocess.action',
							data:{'id':id},
							datatype:'json',
							success:function(data){
								if(data.er != null && data.er != "" ){
									$.messager.alert('错误信息',data.er,'error');
									return false;
								}else{
									window.location.reload();
									refresh();
								}
								
							}
						});
					//	window.location.href="${contextPath}/bpm/definition/validprocess.action?id="+id;
					//	refresh();
					}
				});
			}
			
			function refresh(){
				//流程发布时，可以同步刷新已发布流程的页签---LIHAIFENG 2007-11-28
				//window.parent.frames['unpublishedflow'].location.reload();
				parent.refreshUnpublishedflow();

			}
		</script>
	</head>
	<body  class="easyui-layout">
		<div region="center" border="0px">	
			<table id="bpmDefinitionList"></table>
		</div>	
	</body>
</html>
