<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>引用疑点数据页面</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center">
			<table id="manuSelectList"></table>
		</div>
			<s:hidden name="project_id" />
			<s:hidden name="taskPid" />
			<s:hidden name="taskId" />
		<script type="text/javascript">
	        function mySure(){
		        var selectedRows = $('#manuSelectList').datagrid('getChecked');//返回是个数组
		        if(selectedRows.length==0){
		        	$.messager.alert('提示信息','请选择引用疑点!','info');
		        	return false;
		        }
		        var doubtIdArray=new Array();
		        var doubtIdArrayName=new Array();
				   for(i=0;i <selectedRows.length;i++){
		                var tempformId = selectedRows[i].doubt_id;
				        var tempms_name = selectedRows[i].doubt_name;
				        doubtIdArray.push(tempformId);
				        doubtIdArrayName.push(tempms_name);
				   }	 
				   $("#doubtIdArrayName",parent.document).val(doubtIdArrayName.join(","));
				   $("#doubtIdArray",parent.document).val(doubtIdArray.join(","));
				   parent.closeWinUI();
	        }
	
			$(function(){
				// 初始化生成表格
				$('#manuSelectList').datagrid({
					url : "<%=request.getContextPath()%>/operate/doubt/queryDoubtSelect.action?querySource=grid&taskPid=${taskPid}&taskId=${taskId}&project_id=${project_id}&t="+new Date().getTime() ,
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'doubt_id',	
					border:false,
					singleSelect:false,
					remoteSort: false,
					toolbar:[{
							id:'mySure',
							text:'确定',
							iconCls:'icon-ok',
							handler:function(){
								mySure();
							}
						}
					],
					columns:[[  
						{field:'doubt_id',title:"复选框",width:'50', checkbox:true, halign:'center',align:'left'},						
		       			{field:'doubt_name',title:'疑点名称',width:'250',sortable:true,halign:'center',align:'left'},
		       			{field:'doubt_code',title:'疑点编码',width:'80',sortable:true,align:'center'},		
		       			{field:'task_name',title:'审计事项',width:'168',sortable:true,halign:'center',align:'left'},	
		       			{field:'doubt_author',title:'撰写人',width:'80',sortable:true,halign:'center',align:'left'}
					]]   
				}); 
			});
		</script>
	</body>
</html>