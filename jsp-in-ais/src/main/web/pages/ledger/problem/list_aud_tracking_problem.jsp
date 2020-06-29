<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
	<head>
	   <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>整改跟踪信息列表</title>

		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body>
	<div style="padding: 10px; background: #FAFAFA; border: 1px solid #ccc;">整改跟踪信息</div>
	<div style='height: 100%'>
		<table id='trackList'></table>
	</div>
	<script type="text/javascript">
			$(function(){
				$('#trackList').datagrid({
					url : "<%=request.getContextPath()%>/proledger/problem/auditTrackingList.action?querySource=grid&project_id=<%=request.getAttribute("project_id")%>&permission=<%=request.getAttribute("permission")%>",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					selectOnCheck:false,
					columns:[[
						{field:'id',width:'50', hidden:true, align:'center'},
						{field:'serial_num',title:'问题编号',width:200,align:'center', sortable:true},
						{field:'problem_all_name',title:'问题类别',width:150,sortable:true, align:'center'},
						{field:'problem_name',title:'问题点', width:150,align:'center',sortable:true},
						{field:'problem_money',title:'发生金额(万元)',width:80,align:'center',sortable:true},
						{field:'problemCount',title:'发生数量(个)',width:80,sortable:true,align:'center'},
						{field:'problem_grade_name',title:'审计发现类型', width:100,align:'center',sortable:true},
						{field:'operate',title:'整改跟踪',align:'center',
							formatter:function(value,rowData,rowIndex){
								return '<a href=\"javascript:void(0)\" ondblclick="trackInfo();" >信息跟踪</a>';
					}	
						}
					]]   
				}); 
			});
			function trackInfo(){
				var row = $('#trackList').datagrid("getSelections");
				var project_id = '${project_id}';
				var permission = '${permission}';
				var interaction = '${interaction}';
				var idEdit = '${isEdit}';
				var trackUrl = "${contextPath}/proledger/problem/editAudTrackingLedger.action?id="+row[0].id+"&project_id=${project_id}&isEdit=${isEdit}&permission=${permission}&interaction=${interaction}&view=${view}";
				window.location.href= trackUrl; 
			}
			
		</script>
	</body>
</html>
