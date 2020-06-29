<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>定稿问题列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>//resources/js/common.js"></script>  
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center">
			<table id="problemList"></table>
		</div>
		<script type="text/javascript">
		   /*查看
			*/
			function viewPro(id){
				//window.location.href="${contextPath}/proledger/problem/viewDecideLedgerProblemByUI.action?view=${param.view}&id="+id;
				window.location.href="${contextPath}/proledger/problem/viewDecideLedgerProblem.action?view=${param.view}&id="+id;
			}
			$(function(){
				// 初始化生成表格
				$('#problemList').datagrid({
					url : "${contextPath}/proledger/problem/decideLedgerProblemListNew1.action?project_id=${project_id}&querySource=grid",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					pageNumber:1,
					pageSize:20,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					border:false,
					singleSelect:true,
					remoteSort: false,
					onLoadSuccess:function(){
						doCellTipShow('problemList');
					},
					frozenColumns:[[
						{field:'serial_num',title:'问题编号',width:'10%',align:'center',sortable:true,
							formatter:function(value,row,index){
								return '<a href=\"javascript:void(0)\" onclick=\"viewPro(\''+row.id+'\');\">'+value+'</a>';
							}
						},
						{field:'audit_con',
							title:'问题标题',
							halign:'center',
							width:'15%',
							align:'center',
							sortable:true
						}
					]],
					columns:[[
						{field:'problem_all_name',
							title:'问题类别',
							width:'17%',
							align:'center',
							sortable:true
						},
						{field:'problem_name',
							title:'问题点',
							halign:'center',
							width:'15%',
							align:'left',
							sortable:true
						},
						{field:'problem_money',
							title:'发生金额(万元)',
							halign:'center',
							width:'10%',
							align:'right',
							sortable:true
						},
						{field:'problemCount',
							title:'发生数量(个)',
							halign:'center',
							width:'10%',
							align:'right',
							sortable:true
						},
						{field:'problem_grade_name',
							title:'审计发现类型',
							width:'15%',
							align:'center',
							sortable:true
						}
					]]   
				}); 
			});
		</script>
	</body>
</html>