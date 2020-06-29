<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>年度计划</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript">
		
			var datagrid;
			$(function(){
				var year_id = $('#year_id',window.parent.document).val();
				datagrid = $('#yearDetailList').datagrid({
					url : "<%=request.getContextPath()%>/plan/year/view.action?querySource=grid",
					queryParams:{year_id:year_id},
					method:'post',
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:true,
					idField:'formId',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					columns:[[  
						{field:'audit_object_name',
							title:'被审计单位名称',
							width:100,
							align:'center', 
							sortable:true
						},
						{field:'lastAudYear',
							title:'上次审计年度',
							width:80, 
							align:'center',
							sortable:true
						},
						{field:'pro_type_name',
							 title:'项目类别',
							 width:100, 
							 align:'center', 
							 sortable:true
						},
						{field:'w_plan_year',
							 title:'本次审计年度',
							 width:100, 
							 align:'center', 
							 sortable:true
						},
						{field:'w_plan_month',
							 title:'计划月度',
							 width:100, 
							 align:'center', 
							 sortable:true
						},
						{field:'w_plan_name',
							 title:'预选项目名称',
							 width:100, 
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(rowData.detail_plan_name != null && rowData.detail_plan_name != ''){
										<%-- return '<a href="<%=request.getContextPath()%>/plan/detail/view.action?crudId='+rowData.detail_form_id+'">'+rowData.detail_plan_name+'</a>'; --%>
										return '<a href=\"javascript:void(0)\" onclick=\"viewUrl(\''+rowData.detail_form_id+'\');\">'+rowData.detail_plan_name+'</a>';
								    }else{
								    	<%-- return '<a href="<%=request.getContextPath()%>/plan/year/viewYearDetail.action?yearDetailId='+rowData.formId+'" target="_blank" >'+rowData.w_plan_name+'</a>'; --%>
								    	return '<a href=\"javascript:void(0)\" onclick=\"viewYearDetailUrl(\''+rowData.formId+'\');\">'+rowData.w_plan_name+'</a>';
								    }
							 }
						}
					]]   
				});
			});
			function doSearch(mon){
				var year_id = $('#year_id',window.parent.document).val();
				var w_plan_name  = $('#w_plan_name',window.parent.document).val();
				var w_plan_code  = $('#w_plan_code',window.parent.document).val();
				var w_plan_month  = mon;
				var pro_teamleader_name  = $('#pro_teamleader_name',window.parent.document).val();
				var audit_dept_name  = $('#audit_dept_name',window.parent.document).val();
				datagrid.datagrid('options').queryParams = {
					year_id:year_id,
					w_plan_name:w_plan_name,
					w_plan_code:w_plan_code,
					w_plan_month:w_plan_month,
					pro_teamleader_name:pro_teamleader_name,
					audit_dept_name:audit_dept_name
						};
				datagrid.datagrid('reload');
	        }
			//重置查询条件
			function restal(){
				doSearch('');
			}
			
			
		</script>
	</head>
	<body class="easyui-layout">
		
		<div style="height:100%">
		    <table id="yearDetailList"></table>
		</div>
		<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
			<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>
		<script type="text/javascript">
		function viewUrl(id){
			var viewUrl = "<%=request.getContextPath()%>/plan/detail/view.action?crudId="+id;
			$('#showPlanName').attr("src",viewUrl);
			$('#planName').window('open');
		}
		 $('#planName').window({
				width:500, 
				height:200,  
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true    
		    });
		 function viewYearDetailUrl(id){
			var viewUrl = "<%=request.getContextPath()%>/plan/year/viewYearDetail.action?yearDetailId="+id;
			$('#showPlanName').attr("src",viewUrl);
			$('#planName').window('open');
		}
		</script>
	</body>
</html>