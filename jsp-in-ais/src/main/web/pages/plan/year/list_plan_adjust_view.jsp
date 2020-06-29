<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>年度计划调整痕跡查看</title>
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
	<body class="easyui-layout">
		<div region="center" >
			<table id="listPlanTable"></table>
			<s:hidden name="crudObject.formId" value="${plan_id}" id="pid"/>
		</div>
	</body>
	
	<script type="text/javascript">
		 function back(){
		   window.location.href = "${contextPath}/plan/year/listAllAdjust!listAllAdjustMain.action";
		 }
		 
		 $(function(){
		 		var bodyW = $('body').width();
		        var pid = $('#pid').val();
				// 初始化生成表格
				$('#listPlanTable').datagrid({
					url : "<%=request.getContextPath()%>/plan/year/listAllAdjust!viewAdjust.action?querySource=grid&plan_id="+pid,
                  //  title:'调整痕迹查看',
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					//width:'100%',
					//height:'70%',
					fit: true,
    				fitColumns:true,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					/*toolbar:[{
							id:'back',
							text:'返回',
							iconCls:'icon-undo',
							handler:function(){
								back();
							}
						}
					],*/
					columns:[[  
						{field:'workPlanDetailCode',
								title:'项目编号',
								width:bodyW*0.15+'px',
								halign:'center',
								align:'left', 
								sortable:true
						},
						{field:'workPlanDetailName',
							title:'项目名称',
							width:bodyW*0.25+'px',
							halign:'center',
							align:'left', 
							sortable:true
						},
						{field:'operateUser',
							 title:'操作人',
							 width:bodyW*0.15+'px',
							 align:'center', 
							 sortable:true
						},
						{field:'operate',
							 title:'操作痕迹',
							 width:bodyW*0.15+'px',
							 align:'center', 
							 sortable:true
						},
						{field:'operateTime',
							 title:'操作时间',
							 width:bodyW*0.15+'px',
							 align:'center', 
							 sortable:true
						}
					]]   
				});

			 //单元格tooltip提示
			 $('#listPlanTable').datagrid('doCellTip', {
				 onlyShowInterrupt:true,
				 position : 'bottom',
				 maxWidth : '200px',
				 tipStyler : {
					 'backgroundColor' : '#EFF5FF',
					 borderColor : '#95B8E7',
					 boxShadow : '1px 1px 3px #292929'
				 }
			 });
			});
	</script>
</html>