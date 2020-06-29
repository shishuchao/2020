<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>运行的流程</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${contextPath}/scripts/base64_Encode_Decode.js'></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<body class="easyui-layout">
			<div  region="north" style="height:50px;">
				<table cellpadding=0 cellspacing=0 border=0 class="ListTable" width="100%" align="center">
					<tr >
						<td colspan="5" class="edithead">
							<font style="float: left;">流程监控-流程实例</font>
						</td>
					</tr>
				</table>
				<input type=hidden id="curr_node_name" value=""/>
			</div>	
			<div region="center">
				<table id="instanceList"></table>
			</div>	
		<script type="text/javascript">
			function open_flow_win(flowdefindid,nodestate,formid){
				document.getElementById("curr_node_name").value=nodestate;
				var url = "${contextPath}/bpm/monitor/editWebflow4running.action?currentNodeName="+encode64(encodeURI(nodestate))+"&definitionId="+flowdefindid+"&formId="+formid;
				window.open(url,'人工干预','height=510,width=843,status=no,toolbar=no,menubar=no,location=no,resizable=yes');
			}

			//表单信息
			function openFormInfo(url,title){
				aud$openNewTab(title, url, true);
			}
			$(function(){
				$('#instanceList').datagrid({
					url : "<%=request.getContextPath()%>/bpm/monitor/list.action?querySource=grid&definitionId=${definitionId}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:true,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					frozenColumns:[[
					       			{field:'processName',title:'流程名称',sortable:true,width:'150px',align:'center'},
					       			{field:'formName',title:'表单名称',width:'250px',sortable:true,align:'center'}
					    		]],
					columns:[[  
						{field:'nodeName',
								title:'当前节点名称',
								width:100,
								align:'center', 
								sortable:true,
								formatter:function(value,row,rowIndex){
									var nodeName=row.formState==3 ? '-' : row.nodeState; 
									return nodeName ;
						}},
						{field:'toActorIdName',
							title:'当前处理人',
							width:80,
							sortable:true, 
							align:'center',
							formatter:function(value,row,IndexRow){
								var toActorId_name=row.formState==3 ? '-' : row.toActorId_name;
								return toActorId_name;
							}
						},
						{field:'operate',
							 title:'操作',
							 width:100, 
							 align:'center', 
							 sortable:false,
							 formatter:function(value,row,index){
								 return '<a href=\"javascript:void(0)\" onclick="javascript:openFormInfo(\'${contextPath}'+row.viewLink+'\',\'表单信息\')">表单信息</a>'
								 		+'&nbsp;&nbsp;'+
								 		'<a href=\"javascript:void(0)\" onclick="javascript:open_flow_win(\''+row.processId+'\',\''+row.nodeState+'\',\''+row.formId+'\');">人工干预</a>';
							 }
						}
					]]   
				}); 
			});
		</script>
	</body>
</html>
