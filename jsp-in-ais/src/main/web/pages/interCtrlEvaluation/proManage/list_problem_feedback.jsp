 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
	<head>
		<title>整改进度反馈列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center">
		<table id='trackList'></table>
	</div>
	<script type="text/javascript">
	Date.prototype.format = function(format) {
		var o = {
			"M+" : this.getMonth() + 1, // 月
			"d+" : this.getDate(), // 天
			"h+" : this.getHours(), // 时
			"m+" : this.getMinutes(), // 分
			"s+" : this.getSeconds(), // 秒
			"q+" : Math.floor((this.getMonth() + 3) / 3), // 刻
			"S" : this.getMilliseconds() //毫秒
		// millisecond
		}
		if (/(y+)/.test(format))
			format = format.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(format))
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
						: ("00" + o[k]).substr(("" + o[k]).length));
		return format;
	}
			$(function(){
				$('#trackList').datagrid({
					url : "/ais/intctet/proManage/feedbackListForAuditObject.action?querySource=grid&inter_ctrl_problem_id=${inter_ctrl_problem_id}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns: true,
					idField:'formId',	
					border:false,
					singleSelect:false,
					pageSize:20,
					remoteSort: false,
					toolbar:[{
							id:'add',
							text:'新增',
							iconCls:'icon-add',
							handler:function(){
								window.location.href="${contextPath}/intctet/proManage/editAudTrackingLedgerRework.action?project_id=${project_id}&inter_ctrl_problem_id=${inter_ctrl_problem_id}";						
							}
						},
						{
							id:'back',
							text:'返回',
							iconCls:'icon-undo',
							handler:function(){
								window.location.href="/ais/intctet/proManage/auditDeptTabFile.action?project_id=${project_id}&wpd_stagecode=rework";
							}
						}
					],
					frozenColumns:[[{field:'formId',width:'50px', hidden:true, align:'center'},
									{field:'mend_date',title:'反馈日期',width:'130px',align:'center', sortable:true},
									{field:'mend_result',title:'整改进度',width:'200px',align:'center', sortable:true},
									{field:'responsibility',title:'是否追责',width:'100px',sortable:true, align:'center'},
									{field:'responsibility_Mode',title:'追责方式',width:'100px',sortable:true, align:'center'},
									{field:'mend_state',title:'整改状态', width:100,align:'center',sortable:true}]],
					columns:[[
						{field:'examine_startdate',title:'实际整改开始日期', width:'130px',align:'center',sortable:true,
							formatter:function(value,rowData,rowIndex) {
		                         var dt = new Date(value);
		                         return dt.format("yyyy-MM-dd");
							}	
						},
						{field:'examine_enddate',title:'实际整改结束日期', width:'130px',align:'center',sortable:true,
							formatter:function(value,rowData,rowIndex) {
		                         var dt = new Date(value);
		                         return dt.format("yyyy-MM-dd");
							}	
						},
						{field:'no_rectification_reason',title:'到期未整改原因',width:'200px',align:'center',sortable:true},
						{field:'feedback_date',title:'跟踪检查时间',width:'130px',sortable:true,align:'center'},
						{field:'examine_result',title:'跟踪检查结果', width:'200px',align:'center',sortable:true},
						{field:'f_mend_opinion_name',title:'整改状态评价', width:'100px',align:'center',sortable:true},
						{field:'tracker_name',title:'跟踪检查人', width:'100px',align:'center',sortable:true},
						{field:'operate',title:'修改',align:'center',
							formatter:function(value,rowData,rowIndex){
								if(rowData.stateCode == '1')
									return '<a href=\"javascript:void(0)\" onclick=\"viewTrackInfo(\''+rowData.inter_ctrl_problem_id+'\',\''+rowData.formId+'\');\">查看</a>';
								else
									return '<a href=\"javascript:void(0)\" onclick=\"trackInfo(\''+rowData.inter_ctrl_problem_id+'\',\''+rowData.formId+'\');\">修改</a>';	
							}	
						}
					]]   
				}); 
			});
			function trackInfo(inter_ctrl_problem_id,formId){
				var row = $('#trackList').datagrid("getSelections");
				var project_id = '${project_id}';
				var permission = '${permission}';
				var interaction = '${interaction}';
				var idEdit = '${isEdit}';
				trackUrl = "${contextPath}/intctet/proManage/editAudTrackingLedgerRework.action?inter_ctrl_problem_id="+inter_ctrl_problem_id+"&project_id=${project_id}&isEdit=isEdit&formId="+formId;
				window.location.href= trackUrl; 
			}
			
			function viewTrackInfo(inter_ctrl_problem_id,formId) {
				var row = $('#trackList').datagrid("getSelections");
				var project_id = '${project_id}';
				var permission = '${permission}';
				var interaction = '${interaction}';
				var idEdit = '${isEdit}';
				trackUrl = "${contextPath}/intctet/proManage/editAudTrackingLedgerRework.action?isView=yes&inter_ctrl_problem_id="+inter_ctrl_problem_id+"&project_id=${project_id}&isEdit=isEdit&formId="+formId;
				window.location.href= trackUrl; 
			}
			
		</script>
	</body>
</html>
 