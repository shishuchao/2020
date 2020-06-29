<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>审计通知书编号</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	</head>
	<body class="easyui-layout">
		<div region="center">
			<table id="reportCode"></table>
		</div>
		<div id="addReportCode" title="新增通知书编号" style="overflow:hidden;padding:0px">
			<iframe id="report_code" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
		</div>
		<script type="text/javascript">
			$(function(){
				$('#reportCode').datagrid({
					url : "<%=request.getContextPath()%>/code/rule/codeRule/list.action?querySource=grid",
					method:'post',
					cache:false,
					showFooter:false,
					rownumbers:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:true,
					idField:'id',
					border:false,
					singleSelect:false,
					remoteSort: false,
					toolbar:[{
						text:'新增',
						iconCls:'icon-add',
						handler:function(){
							changeCode('');
						}
					},'-',{
						text:'设置',
						iconCls:'icon-edit',
						handler:function(){
							var ids = new Array();
							var rows = $('#reportCode').datagrid('getChecked');
							for(i in rows) {
								ids.push(rows[i].id);
							}
							if(ids.length == 1) {
								setCode(ids[0]);
							} else {
								showMessage1("请选择1条数据！");
							}
						}
					},'-',{
						text:'删除',
						iconCls:'icon-delete',
						handler:function(){
							var ids = new Array();
							var rows = $('#reportCode').datagrid('getChecked');
							for(i in rows) {
								ids.push(rows[i].id);
							}
							if(ids.length > 0) {
								deleteCode(ids.join(","));
							} else {
								showMessage1("请选择数据！");
							}
						}
					},'-',helpBtn],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					onClickCell:function(rowIndex, field, value) {
						if(field == 'report_name') {
							var rows = $('#reportCode').datagrid('getRows');
							var row = rows[rowIndex];
							changeCode(row.id);
						}
					},
					columns:[[
						{field:'id',checkbox:true,title:'选择'},
						{field:'report_name',
							title:'审计通知书编号名称',
							width:100,
							halign:'center',
							align:'left',
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								var result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
								return result;
							}
						},
						{field:'pro_name',
							title:'适用项目类型',
							sortable:true,
							width:100,
							halign:'center',
							align:'left'
						},
						{field:'pro_code',
							title:'适用项目类型编号',
							sortable:true,
							width:100,
							halign:'center',
							align:'left'
						},
						{field:'state_name',
							title:'是否启用',
							sortable:true,
							width:60,
							halign:'center',
							align:'left'
						}/*,
						{field:'xxx',
							title:'操作',
							halign:'center',
							align:'center',
							width:100,
							sortable:false,
							formatter:function(value,row,index){
								var link = '<a href=\"javascript:void(0);\" onclick=\"changeCode(\''+row.id+'\')\">修改</a>&nbsp;&nbsp'+
										'<a href=\"javascript:void(0);\" onclick=\"deleteCode(\''+row.id+'\')\">删除</a>&nbsp;&nbsp'+
										'<a href=\"javascript:void(0);\" onclick=\"setCode(\''+row.id+'\')\">设置</a>';
								return link;
							}
						}*/
					]]
				});
				$('#addReportCode').dialog({
					width:900, 
					height:400,  
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
			    });
			});
			//修改
			function changeCode(id){
				var url = "<%=request.getContextPath()%>/code/rule/codeRule/addReportCode.action?id="+id;
				$('#report_code').attr("src",url);
				$('#addReportCode').window('open');
			}
			//删除
			function deleteCode(ids){
				$.messager.confirm('提示信息','确认删除吗？',function(r){
					if(r){
						$.ajax({
							url:"<%=request.getContextPath()%>/code/rule/codeRule/deleteCode.action",
							type:'POST',
							data:{"ids":ids},
							dataType:'text',
							success:function(data){
								if(data == 'success'){
									showMessage1("删除成功!");
									window.location.reload();
								}else{
									showMessage1("删除失败!");
								}
							},
							error:function(data){
								showMessage1('请求失败,请检查网络是否通畅或者与管理员联系！');
							}
						});
					}
				});
			}
			//设置
			function setCode(id){
				window.location.href='${contextPath}/code/ruledetail/codeRuleDetail/list.action?isTZS=true&id='+id+'&rule_id='+id;
			}
			//新增
			function addReportCode(){
				
			}
			function closeWin(){
				$('#addReportCode').window('close');
			}
		</script>
	</body>
	
</html>