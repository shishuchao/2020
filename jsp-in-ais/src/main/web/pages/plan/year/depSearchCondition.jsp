<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>年度计划：预选项目：未审计单位检索 记录</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src='${contextPath}/easyui/boot.js'></script>
		<script type="text/javascript" src='${contextPath}/easyui/contextmenu.js'></script>
		<script type="text/javascript">
			var crudId = "${crudId}";
			var yearFormId = "${yearFormId}";
			function doView(recordId){
				$('#viewDlg').dialog({
					title:'多年未审详情',
					content:'<iframe src="${contextPath}/plan/detail/unauditedDepSearch!unauditedDepartmentSearchList.action?fromAdjust=${fromAdjust}&searchRecord='+recordId+'&crudId='+crudId+'&yearFormId='+yearFormId+'&status=view" width="100%" height="100%" marginheight="0"  marginwidth="0"  style="overflow: hidden;" frameborder="0" ></iframe>',
					fit:true,
					resizable:true
				});
			}
			function doDel(recordId){
				$.messager.confirm('删除记录','您确定要删除该记录么？',function(r){    
					if (r){
						parent.location = "${contextPath}/plan/detail/unauditedDepSearch!delSearchRecord.action?fromAdjust=${fromAdjust}&searchRecord="+recordId+"&crudId="+crudId+"&yearFormId="+yearFormId;
					}    
				});
			}
		</script>
	</head>
	<body class="easyui-layout" fit="true">
		<div region="center" style="overflow: hidden">
		    <table id="unaudDepSearchConditionList"></table>
			<div id="viewDlg"></div>
		</div>
	</body>
	<script type="text/javascript">
		$(function(){
			$('#unaudDepSearchConditionList').datagrid({
				url : "${contextPath}/plan/detail/unauditedDepSearch!unaudDepSearchConditionList.action?querySource=grid&fromAdjust=${fromAdjust}&crudId=${crudId}&yearFormId=${yearFormId}",
				method:'post',
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				border:false,
				cache:false,
				singleSelect:true,
				remoteSort: false,
				columns:[[  
					{field:'searchTitle',
						title:'检索条件',
						width:100,
						align:'center', 
						sortable:true
					},
					{field:'searchCreator',
						title:'创建者',
						width:80, 
						align:'center',
						sortable:true
					},
					{field:'searchCreateTime',
						 title:'创建时间',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
						 	return value.substring(0,10);
						 }
					},
					{field:'operate',
						 title:'操作',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
							return '<a href=\"javascript:void(0)\" onclick=\"doView(\''+rowData.id+'\');\">查看</a>|<a href=\"javascript:void(0)\" onclick=\"doDel(\''+rowData.id+'\');\">删除</a>';
						 }
					}
				]]   
			});
		});
	</script>
</html>
