<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>
<!DOCTYPE HTML>
<html>
	<title>被审计单位历史信息</title>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	<script type="text/javascript">
		$(function(){
			var bodyW = $('body').width();    
			var bodyH = $('body').height();   
			frloadOpen();
			var audTemplateId = '${audTemplateId}';
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#templateTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'projectStartObject',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'formId',
			    whereSql: 'formId in (select project_id from AudTask where templateId=\''+audTemplateId+'\' and taskPid=\'-1\')',
				order:'asc',
				sort:'real_start_time',
				winWidth:800,
				winHeight:250,
				gridJson:{    
					checkOnSelect:false,
					selectOnCheck:false,
					singleSelect:false,
					onLoadSuccess:frloadClose,
					columns:[[
						{field:'project_code', title:'项目编号', width:bodyW*0.16 + 'px', align:'left',halign:'center', show:'false'},      
						{field:'project_name', title:'项目名称', width:bodyW*0.16 + 'px', align:'left',halign:'center', sortable:true},
						{field:'audit_dept_name', title:'审计单位', width:bodyW*0.16 + 'px', align:'left',halign:'center', sortable:true},
						{field:'audit_object_name', title:'被审计单位', width:bodyW*0.16 + 'px', align:'left',halign:'center', sortable:true},
						{field:'pro_year', title:'项目年度', width:bodyW*0.14 + 'px', align:'center',halign:'center', show:'false'},      
						{field:'real_start_time', title:'引用时间', width:bodyW*0.16 + 'px',align:'center',halign:'center', sortable:true,
							formatter:function(value,rowData,rowIndex){
								var date = getDate(value);
								return date;
							}	
						}
					]],
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':false},
				{'index':2, 'display':false},
				{'index':3, 'display':false},
				{'index':4, 'display':false},
				{'index':5, 'display':false},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
			]);
		});
	</script>
	</head>
	<body>
		<div id="container" class='easyui-layout' fit='true'>	
			<div region="center">   	 	
				<table id='templateTable'></table>
			</div>
		</div>
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
