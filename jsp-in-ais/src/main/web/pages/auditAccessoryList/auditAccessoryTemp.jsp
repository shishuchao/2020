<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>被审计单位资料模板</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:5px 4px;
		}
	</STYLE>
	<script type="text/javascript">
	
		 var datagrid;
		 $(function(){
				// 初始化生成表格
				datagrid = $('#aatList').datagrid({
					url : "<%=request.getContextPath()%>/auditAccessoryList/auditAccessoryTemplate.action?querySource=grid",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					pageSize: 20,
					fit: true,
					idField:'id',	
					border:false,
					fitColumns: true,
					singleSelect:false,
					remoteSort: false,
					toolbar:[
						{
							id:'add',
							text:'添加模板',
							iconCls:'icon-add',
							handler:function(){
								window.location='${contextPath}/auditAccessoryList/auditAccessoryTempList.action?checkOption=add&view=edit';
							}
						},'-',
						{
							id:'delete',
							text:'删除',
							iconCls:'icon-delete',
							handler:function(){
								var ids = new Array();
								var rows = $('#aatList').datagrid('getChecked');
								for(i in rows) {
									if(typeof rows[i].id != 'undefined') {
										ids.push(rows[i].id);
									}
								}
								if(ids.length > 0) {
									delAuditTemp(ids.join(","));
								} else {
									showMessage1("请选择条数据！")
								}
							}
						},'-',
						{
							id:'copy',
							text:'复制',
							iconCls:'icon-copy',
							handler:function(){
								var ids = new Array();
								var rows = $('#aatList').datagrid('getChecked');
								for(i in rows) {
									if(typeof rows[i].id != 'undefined') {
										ids.push(rows[i].id);
									}
								}
								if(ids.length == 1) {
									copyTemp(ids[0]);
								} else {
									showMessage1("请选择1条数据！")
								}
							}
						},'-',helpBtn
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					onClickCell:function(rowIndex, field, value) {
						if(field == 'templatename') {
							var rows = $('#aatList').datagrid('getRows');
							var row = rows[rowIndex];
							editTemp(row.id);
						}
					},
					columns:[[  //
						{field:'id',checkbox:true,title:'选择'},
						{field:'templatename',
								title:'模板名称',
								width:150,
								halign: 'center',
								align:'left', 
								sortable:true,
								formatter:function(value,row,index){
									var result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
									return result;
								 	//return '<a href="${contextPath}/auditAccessoryList/auditAccessoryTempList.action?checkOption=edit&view=isView&auditUuid='+row.id+'">'+row.templatename+'</a>';
								}
						},
						{field:'pro_type_name',
							title:'适用项目类别',
							width:150,
							halign: 'center',
							sortable:true, 
							align:'left'
						},
						{field:'createName',
							 title:'创建人',
							 width:100,
							 halign: 'center',
							 align:'left', 
							 sortable:true
						},
						{field:'createTime',
							 title:'创建时间',
							 width:100,
							 halign: 'center',
							 align:'center', 
							 sortable:true
						}/*,
						{field:'operate',
							 title:'操作',
							 halign: 'center',
							 align:'center', 
							 sortable:false,
							 formatter:function(value,row,index){
							 	var param = [row.id];
							 	var btn2 = "修改,editTemp,"+param.join(',')+"-btnrule-删除,delAuditTemp,"+param.join(',')
								           +"-btnrule-复制,copyTemp,"+param.join(',');
								           
								return ganerateBtn(btn2);
							 }
						}*/
					]]   
				}); 
		 });
		 function delAuditTemp(auditUuids){
		 	$.messager.confirm('提示信息','您确定要删除此模板么？',function(flag){
				if(flag){
				$.ajax({
					url:"${contextPath}/auditAccessoryList/delAuditAccessoryTemplate.action",
					type:"Post",
					data:{"auditUuids":auditUuids},
					success:function(data){
						showMessage1("删除成功！");
						$('#aatList').datagrid('reload');
					}
				});
				}
			});
		 }
		 function editTemp(auditUuid){
		 	window.location.href = '<a href="${contextPath}/auditAccessoryList/auditAccessoryTempList.action?checkOption=edit&view=edit&auditUuid='+auditUuid;
		 }
		 function copyTemp(auditUuid){
		 	window.location.href = '<a href="{contextPath}/auditAccessoryList/auditAccessoryTempList.action?checkOption=copy&view=edit&auditUuid='+auditUuid;
		 }
	</script>
</head>
<body class="easyui-layout">
    <div region="center" border='0'>
		<table id="aatList"></table>
	</div>
</body>
</html>
