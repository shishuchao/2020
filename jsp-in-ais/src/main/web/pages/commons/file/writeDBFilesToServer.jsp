<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:set var="smvc" value="<%=request.getContextPath()%>"/>
<html>
<head>
	<script type="text/javascript" src="${smvc}/easyui/boot.js"></script>
	<script type="text/javascript" src="${smvc}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="${smvc}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${smvc}/resources/js/common.js"></script>

</head>
<body style="overflow:hidden;" class="easyui-layout">
	<div region="center">
		<table id="fileTable"></table>
	</div>
</body>

<script type='text/javascript'>
	$(function(){
		var gridTableId = "fileTable";
		var editBtn ={
			text:'迁移',
			iconCls:'icon-edit',
			handler:function(){
				top.$.messager.confirm('确认','确定要迁移数据库附件到文件服务器吗？确保文件服务器可用！',function(r){
					if(r){
						aud$loadOpen();
						$.ajax({
							url:'${smvc}/commonPlug/writeDBFilesToServer.action',
							type:'post',
							dataType:'json',
							success:function(data){
								if(data.type == 'info'){
									var rows = $('#'+gridTableId).datagrid('getRows');
									if(rows && rows.length){
										for(var i in rows){
											var row = rows[i];
											if(data.successFiles.indexOf(row['fileId']) != -1){
												row['status'] = '成功';
											}
										}
										$('#'+gridTableId).datagrid("reload");
									}
								}else {
									showMessage1(data.msg);
								}
								aud$loadClose();
							}
						});
					}
				});
			}

		};

		var cusToolbar = [editBtn];
		$('#'+gridTableId).datagrid({
			url : "<%=request.getContextPath()%>/commonPlug/writeDBFilesToServer.action?querySource=grid&t="+new Date().getTime() ,
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:false,
			striped:true,
			autoRowHeight:false,
			fit: true,
			pageSize: 20,
			fitColumns:true,
			idField:'fileId',
			border:false,
			singleSelect:true,
			remoteSort: false,
			toolbar:cusToolbar,
			columns:[[
				{field:'fileName',
					title:'附件名称',
					width:150,
					halign:'center',
					align:'left',
					sortable:true
				},
				{field:'uploader_name',
					title:'上传人',
					sortable:true,
					width:100,
					halign:'center',
					align:'center'
				},
				{field:'fileTime',
					title:'上传时间',
					width:100,
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'savedToServer',
					title:'迁移状态',
					halign:'center',
					width:80,
					align:'center',
					sortable:true,
					formatter:function(value,row,index){
						return value == '1' ? '已迁移':'未迁移';
					}
				}

			]]
		});

	})
</script>
</html>