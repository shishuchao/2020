<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>参与审计项目历史</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
	<%-- <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	 --%>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div>
			<s:form action="toJoinAuditProjectHistoryList" name="searchForm" id="searchForm" namespace="/mng/examproject/members/audProjectMembersInfo" method="post">
				<s:hidden id="export" name="export"></s:hidden>
				<s:hidden id="querySource" name="querySource" value="gid"></s:hidden>
				<s:hidden id="employeeInfo.id" name="employeeInfo.id" value="${employeeInfo.id}"></s:hidden>
				<s:hidden id="helper.freeStartDate" name="helper.freeStartDate" value="${helper.freeStartDate}"></s:hidden>
				<s:hidden id="helper.freeEndDate" name="helper.freeEndDate" value="${helper.freeEndDate}"></s:hidden>
				<s:hidden id="helper.fullStartDate" name="helper.fullStartDate" value="${helper.fullStartDate}"></s:hidden>
				<s:hidden id="helper.fullEndDate" name="helper.fullEndDate" value="${helper.fullEndDate}"></s:hidden>
			</s:form>
		</div>
		<div region="center" >
			<table id="itts"></table>
		</div>
		<div id="sjsx" title="审计事项" style='overflow: auto; padding: 0px;'>
			<table class="ListTable" align="center" id="tId">
			</table>
		</div>	
		<input type="hidden" value="${employeeInfo.sysAccounts}" id="sysAccounts" />
		<input type="hidden" value="${employeeInfo.personnelCode}" id="personnelCode" />
		<input type="hidden" value="${employeeInfo.id}" id="eid" name="eid"/>
	
		<script type="text/javascript">
		
		function doSearch(){
			document.getElementById('export').value="true";
        	//$('#itts').datagrid({
    		//	queryParams:form2Json('searchForm')
    		//});
    		document.getElementById("searchForm").submit();
        }
		
		var eid=document.getElementById("eid");
		var sysAccounts=document.getElementById("sysAccounts");
		$(function(){
			var enableKpi = <%=request.getAttribute("enableKpi")%>;
			// 初始化生成表格
			$('#itts').datagrid({
				url : '<%=request.getContextPath()%>/mng/examproject/members/audProjectMembersInfo/toJoinAuditProjectHistoryList.action?querySource=gid&employeeInfo.id='+eid.value+'&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}',
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'emexecl',
						text:'导出',
						iconCls:'icon-export',
						handler:function(){
							doSearch();
						}
					}
				],
				frozenColumns:[[
				       			{field:'sysAccounts',title:'系统',width:'50px',halign:'center',hidden:true},
				       			{field:'pro_type_name',title:'项目类别',width:100,halign:'center',align:'left',sortable:true,
									formatter:function(value,rowData,rowIndex){
										return rowData.pro_type_name;
									}
								},
				       			{field:'project_name',title:'项目名称',width:180,halign:'center',sortable:true,align:'left'}
				    		]],
				columns:[[
					{
						field: 'real_start_time',
						title: '启动时间',
						width: 180,
						halign: 'center',
						align: 'center',
						sortable: true,
						formatter: function (value, row, index) {
							if (value != null) {
								return value.substring(0, 10);
							}
						}
					},
					{
						field: 'real_closed_time',
						title: '关闭时间',
						width: 180,
						halign: 'center',
						align: 'center',
						sortable: true,
						formatter: function (value, row, index) {
							if (value != null) {
								return value.substring(0, 10);
							}
						}
					},
					{
						field: 'roleName',
						title: '项目角色',
						width: 180,
						halign: 'center',
						align: 'left',
						sortable: true
					},
					{
						field: 'audit_dept_name',
						title: '所属单位',
						width: 180,
						halign: 'center',
						align: 'left',
						sortable: true
					},
					{
						field: 'audit_object_name',
						title: '被审计单位',
						width: 180,
						halign: 'center',
						align: 'left',
						sortable: true
					},
					<s:if test="${enableKpi == true}">
					{
						field: 'proScore',
						title: '分值',
						width: 180,
						halign: 'center',
						align: 'center',
						sortable: true
					},
					</s:if>
					{
						field: 'employeeInfo',
						title: '分工事项',
						width: 180,
						halign: 'center',
						align: 'center',
						sortable: true,
						formatter: function (value, rowData, rowIndex) {
							//'+rowData.formId+',
							if (rowData.formId != null) {
								return '<a href="javascript:void(0);" onclick="viewDesc(\'' + rowData.formId + '\',\'' + rowData.sysAccounts + '\')">详情</a>';
							}
						}
					}
				]]   
			}); 
		});
		function viewDesc(project_id_value,sysAccounts){
			 $("#tId").empty();
			$.post("/ais/operate/taskExt/getTaskList.action",
					{project_id:project_id_value,userId:sysAccounts},
				function(returnValue2) {
					var jsonstr = eval( "(" + returnValue2 + ")" )
					var buffer = "<tr><td class='EditHead' nowrap='nowrap' style='text-align:center;'>审计事项</td><td class='EditHead' nowrap='nowrap' style='text-align:center'>审计小组</td></tr>";
					if(null!=jsonstr && jsonstr.length>0){
						for(var i=0;i<jsonstr.length;i++){
							buffer = buffer +"<tr><td class='EditHead' nowrap='nowrap' style='text-align:center'>"+jsonstr[i].taskName+"</td><td class='EditHead' nowrap='nowrap' style='text-align:center'>"+jsonstr[i].taskGroupAssignName+"</td></tr>";
						}
					}
					$("#tId").append(buffer);
					$('#sjsx').window('open');
				});	
	} 	
	$(function(){  	
	    var cwidth = window.parent.document.body.clientWidth;
	    var cheight = window.parent.document.body.clientHeight;
	    $('#sjsx').window({
			width:900, 
			height:100,  
			top:cheight >300 ? (cheight -300 ) * 0.5 :30,
	        left:cwidth >600 ? (cwidth -600 ) * 0.5 :30,
	        inline:true,
	        maximized:true,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			closed:true    
	    });   		
	}); 
	</script>	
</body>
</html>
