<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>被审计单位资料授权页面</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
    <form id="myform" name="myform" method="post">
        <input type="hidden" name="accessoryId" value="${accessoryId}">
        <input type="hidden" name="crudId" value="${crudId}">
		<div region="center" >
			<table id="resultList"></table>
		</div>
	</form>
<script language="javascript">
			$(function(){
				$('#resultList').datagrid({
					url : "${contextPath}/project/memberList.action?querySource=grid",
					queryParams : form2Json('myform'),
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					pageSize: 10,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:true,
					idField:'user_code',	
					border:false,
					singleSelect:false,
					remoteSort: false,
					toolbar:[
						{
							id:'search',
							text:'授权',
							iconCls:'icon-upload',
							handler:function(){
								auth(true);
							}
						},
						{
							id:'export',
							text:'取消授权',
							iconCls:'icon-cancel',
							handler:function(){
								auth(false);
							}
						},
						{
							id:'export',
							text:'返回',
							iconCls:'icon-undo',
							handler:function(){
								window.parent.closedlg(true);
							}
						}
					],
					columns:[[
						{field:'employeeInfo_ids',width:'50',checkbox:'true',align:'center',
							formatter:function(value,row,index){
								return '<input type="checkbox" name="employeeInfo_ids" value="'+row.user_code+'">';
							}
						},
						{field:'group',title:'组别',width:'100',halign:'center',align:'left',sortable:true},
						{field:'user_name',title:'姓名',width:'100',halign:'center',align:'left',sortable:true,
							formatter:function(value,row,index){
								if(row.description!='Y') {
									return '<a style="color:blue" onclick="showUser(\''+row.user_code+'\');" href="javascript:void(0);">'+value+'</a>&nbsp;';
								}
								return value;
							}
						},
						{field:'work',title:'是否授权',width:'60',align:'center',sortable:true,
							formatter:function(value,row,index){
								if(row.work=='1') return "<img src='/ais/cloud/images/edit.gif' title='已授权'>	";
								return "<img src='/ais/cloud/images/delete.gif' title='未授权'>";
							}
						}, 
						{field:'duty',title:'项目角色',width:'100',align:'center',sortable:true}
					]]
					,onLoadSuccess:function(data){
						var rows = $('#resultList').datagrid('getRows');
						if(!rows)return;
						if(rows.length==0)return;
						for(var i=0;i<rows.length;i++) {
				            var td=$('input[name="employeeInfo_ids"]')[i];
							$(td).val(rows[i].user_code);
				        }
						$('#resultList').datagrid('unselectAll');
					}
					/*,loadFilter:function(data){
						if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
							data = {
								total: data.length,
								rows: data
							}
						}
						var dg = $(this);
						var opts = dg.datagrid('options');
						var pager = dg.datagrid('getPager');
						pager.pagination({
							onSelectPage:function(pageNum, pageSize){
								opts.pageNumber = pageNum;
								opts.pageSize = pageSize;
								pager.pagination('refresh',{
									pageNumber:pageNum,
									pageSize:pageSize
								});
								dg.datagrid('loadData',data);
							}
						});
						if (!data.originalRows){
							data.originalRows = (data.rows);
						}
						var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
						var end = start + parseInt(opts.pageSize);
						data.rows = (data.originalRows.slice(start, end));
						return data;
					}*/
				});
			});
			/*
			* 成员信息
			*/
			function showUser(userid) {
				/*var url = '${contextPath}/mng/employee/employeeInfoView.action?queryType=all&ul='+userid;
				var arg = {width:800,height:450,closed:true,modal:true,maximizable:true,resizable:true,draggable:true,title: '人员信息'};
				_showDlg(arg,url,window.parent);*/
				var o=window.parent.$('#dlgperson');
				o[0].children[0].src='${contextPath}/mng/employee/employeeInfoView.action?queryType=all&ul='+userid;
				o.dialog('open');
			}
			/*
			*授权/取消授权
			*/
			function auth(flag) {
				var rows = $('#resultList').datagrid('getChecked');
				if (rows.length<=0) {
					window.parent.$.messager.show({
						title:'提示信息',
						msg:'请选择要进行'+(flag?'资料授权':'取消授权')+'的项目成员！'
					});
					return;
				}
				if (flag) {
					myform.action='${contextPath}/project/accessoryAuthorize.action';
					myform.submit();
				}else{
					$.messager.confirm('确认', '确定取消授权吗？', function(r){
						if (r) {
							myform.action='${contextPath}/project/cancelAccessoryAuth.action';
							myform.submit();
						}
					});
				}
				/*var ids=new Array();
				for(var i=0; i<rows.length; i++){
					ids.push(rows[i].user_code);
				}*/
				/*if (flag) {
					$("#myform").attr("action",'${contextPath}/project/accessoryAuthorize.action');
					$("#myform").form('submit',{
		        		onSubmit:function(){
		            		return true; //当表单验证不通过的时候 必须要return false 
		            	},
						success:function(data){
							$('#resultList').datagrid('reload');
							window.parent.$.messager.show({
								title:'提示信息',
								msg:'资料授权成功！'
							});
						},
						error:function(){
							$('#resultList').datagrid('reload');
						}
				    });
				}else{
					$("#myform").attr("action",'${contextPath}/project/cancelAccessoryAuth.action');
					$.messager.confirm('确认', '确定取消授权吗？', function(r){
						if (r) {
							$("#myform").form('submit',{
				        		onSubmit:function(){
				            		return true; //当表单验证不通过的时候 必须要return false 
				            	},
								success:function(data){
									$('#resultList').datagrid('reload');
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'取消授权成功！'
									});
								},
								error:function(){
									$('#resultList').datagrid('reload');
								}
						    });
						}
					});
				}*/
				/*var json={};
				json.accessoryId="${accessoryId}";
				json.crudId="${crudId}";
				json.employeeInfo_ids=ids;
				jQuery.ajax({
					url:'${contextPath}/project/'+(flag?'accessoryAuthorize':'cancelAccessoryAuth')+'.action',
					data : json,
					type:'POST',
					dataType:'json',
					async:'false',
					success:function(data){
						$('#resultList').datagrid('reload');
						window.parent.$.messager.show({
							title:'提示信息',
							msg:(flag?'资料授权':'取消授权')+'成功！'
						});
					},
					error:function(){
						$('#resultList').datagrid('reload');
					}
				});*/
			}
</script>
 	</body>
</html>
