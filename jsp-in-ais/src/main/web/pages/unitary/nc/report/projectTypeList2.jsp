<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>项目类型列表2</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
</head>
<body>
<div style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true">
	<div region="center" border='0'>
		<table id="projectTypeList"></table>
	</div>
	<div id="templateWindow" title="通知书模板列表" style="overflow:hidden;padding:0px">
		<iframe id="templateList" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		// 初始化生成表格
		$('#projectTypeList').datagrid({
			url : "<%=request.getContextPath()%>/unitary/nc/autoreport/projectTypeList.action",
			method:'post',
			cache:false,
			showFooter:false,
			rownumbers:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			fitColumns:true,
			idField:'code',
			border:false,
			singleSelect:true,
			remoteSort: false,
			columns:[[
				{field:'code',
					title:'项目编码',
					width:100,
					halign:'center',
					align:'left',
					sortable:true
				},
				{field:'name',
					title:'项目类型',
					sortable:true,
					width:300,
					halign:'center',
					align:'left'
				},
				{field:'operate',
					title:'操作',
					halign:'center',
					align:'center',
					width:100,
					sortable:false,
					formatter:function(value,row,index){
						var link = '<a href=\"javascript:void(0);\" onclick=\"templateList(\''+row.code+'\',\'advice\')\">模板列表</a>';
						return link;
					}
				}
			]]
		});
		window.setTimeout(function(){			
			$('#templateWindow').window({
				width:950,
				height:450,
				modal:true,
				fit:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});
		},10);
	});

	function templateList(projectTypeCode,fromType){
		var url = "<%=request.getContextPath()%>/pages/unitary/nc/report/adviceTemplateList.jsp?projectTypeCode="+projectTypeCode+"&fromType="+fromType;
		aud$openNewTab('审计通知书-模板列表',url);
		/* $('#templateList').attr("src",url);
		$('#templateWindow').window('open');
		$('#templateWindow').window('resize',{
			width :document.body.clientWidth || document.documentElement.clientWidth,
			height:document.body.clientHeight || document.documentElement.clientHeight			
		}); */
	}

</script>
</body>
</html>