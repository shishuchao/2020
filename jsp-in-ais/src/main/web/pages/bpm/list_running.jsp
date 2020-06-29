<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<title><s:property value="#title" /></title>
	<!-- 已办事项 -->
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:20px;
			padding:5px 4px;
		}
	</STYLE>
	<script language="javascript">
		function open_flow_win(flowdefindid, nodestate, formid) {
		//	var url = "/ais/bpm/definition/viewWebflow4running.action?bpmDefinition.id=" + flowdefindid + "&crudId=" + formid+"&curr_node_name="+nodestate;
//			window.location.href=url;
			window.open("/ais/bpm/definition/viewWebflow4running.action?curr_node_name="+nodestate+"&bpmDefinition.id=" + flowdefindid + "&crudId=" + formid, '流程图例', 'height=660,width=660,status=no,toolbar=no,menubar=no,location=no,resizable=yes');
		}
		function open_flow(value){
			var url = "/ais"+value;
			//parent.addTab("tabs","表单信息","manuViewTab",url,false);
			//allWindShow('open_flow',url,1300,900);
		//	window.open(url,'表单信息','height=660,width=660,status=no,toolbar=no,menubar=no,location=no,resizable=yes,scrollbars=1');
			aud$openNewTab('表单信息',url,true);
		}
		/*
		 *  打开或关闭查询面板
		 */
		function triggerSearchTable() {
			var isDisplay = document.getElementById('searchTable').style.display;
			if (isDisplay == '') {
				document.getElementById('searchTable').style.display = 'none';
			} else {
				document.getElementById('searchTable').style.display = '';
			}
		}
		
		function doClean(){
			$("[name = 'info.processName']").val("");
		}
	</script>
</head>
<body class="easyui-layout" style="margin: 0;padding: 0;overflow:hidden;">
	<div id="runningSearch" class="searchWindow">
		<div class="search_head">
			<s:form name="myform" action="running.action" namespace="/bpm/taskinstance" id="myform">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td  class="EditHead" style="width: 15%">流程名称</td>
						<td  class="editTd" colspan="3">
							<s:textfield cssClass="noborder" name="info.processName" maxlength="50" cssStyle="width:90%;" />
						</td>
						<td  class="EditHead" style="width: 15%">项目名称</td>
						<td  class="editTd" colspan="3">
							<s:textfield cssClass="noborder" name="info.project_name" maxlength="50" cssStyle="width:90%;" />
						</td>
					</tr>
					<tr>
						<td  class="EditHead" style="width: 15%">表单名称</td>
						<td  class="editTd" colspan="3">
							<s:textfield cssClass="noborder" name="info.formName" maxlength="50" cssStyle="width:90%;" />
						</td>
						<td  class="EditHead" style="width: 15%"></td>
						<td  class="editTd" colspan="3">
						</td>
					</tr>
				</table>
	        </s:form>
        </div>
        <div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#runningSearch').window('close')">取消</a>
			</div>
		</div>
    </div>
   	<div region="center" fit="true">
		<table id="taskInstanceList"></table>
	</div>
	
	<div id="open_flow"></div>
	<div id="open_flow_win"></div>
</body>
<script type="text/javascript">
	function doSearch(){
		$('#taskInstanceList').datagrid({
			queryParams:form2Json('myform')
		});
		$('#runningSearch').window('close');
	}
	function restal(){
		resetForm('myform');
		//doSearch();
	}
	$(function(){
		showWin('runningSearch');
		showWin('open_flow','查看表单');
		showWin('open_flow_win','查看流程图例');
		$('#taskInstanceList').datagrid({
			url : '<%=request.getContextPath()%>/bpm/taskinstance/running.action?querySource=grid&type=${param.type}',
			method:'post',
			showFooter:true,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit:true,
			pageSize: 20,
			idField:'id',
			fitColumns: false,	
			border:false,
			singleSelect:false,
			remoteSort: false,
			toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('runningSearch','800','200');
					}
				}],
			frozenColumns:[[
		       			{field:'processName',title:'流程名称',width:'150px',halign:'center',align:'left',sortable:true},
		       			{field:'project_name',title:'项目名称',width:'250px',sortable:true,halign:'center',align:'left'}
		    		]],
			columns:[[  
				{
					field:'formName',
					title:'表单名称',
					halign:'center',
					width:250,
					align:'left', 
					sortable:true
				},
				{
					field:'nodeState',
					title:'当前审批节点',
					width:150,
					halign:'center',
					align:'left', 
					sortable:true,
					formatter:function (value,row,rowIndex){
							var nodeState =row.formState==3 ? '结束' : row.nodeState ;
							return nodeState;
					}
				},
				{
					field:'formState',
					title:'流程状态',
					width:100,
					halign:'center',
					align:'left', 
					sortable:true,
					formatter:function (value,row,rowIndex){
						var formState_bool=row.formState;
						if(formState_bool==1){
							return '正在执行';
						}else if(formState_bool==2){
							return '已被挂起';
						}else{
							return '执行完毕';
						}
					}
				},
				{
					field:'toActorId_name',
					title:'下一步处理人',
					width:110,
					halign:'center',
					align:'left', 
					sortable:true,
					formatter:function(value,row,rowIndex){
						var name=row.formState==3 ? '-' : row.toActorId_name;
						return name;
					}
				},
				{field:'operate',
					 title:'操作',
					 width:250, 
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 formatter:function(value,row,index){
					 	var param1 = [row.viewLink];
					 	var param2 = [row.processId,row.nodeState,row.formId];
					 	var btn2 = "查看表单,open_flow,"+param1.join(',')+"-btnrule-查看流程图例,open_flow_win,"+param2.join(',');
						 return ganerateBtn(btn2); 
						 
//						 var a = '<a href=\"javascript:void(0)\" onclick=\"open_flow(\''+row.viewLink+'\');">查看表单</a>|'+
//						 '<a href=\"javascript:void(0)\" onclick=\"javascript:open_flow_win(\''+row.processId+'\',\''+row.nodeState+'\',\''+row.formId+'\');\">查看流程图例</a>';
					 }
				}
			]]   
		}); 
	});
	
</script>
</html>
