<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目小组列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	</head>
<!--	<body onload="refreshPermissionTab();">-->
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center" >
			<table id="list_groupList"></table>
		</div>
		<div id="groupButtonDiv" class="easyui-dialog" title="编辑小组" closed="true" modal="true" style="width:800px;height:500px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
	    <div>
			<s:form action="listGroups" namespace="/project">
				<s:hidden name="crudId" />
			</s:form>
		</div>
		<script type="text/javascript">
			$(function(){
				//var crudIds = document.getElementsByName('crudId')[0].value;
				// 初始化生成表格
				$('#list_groupList').datagrid({
					//url : "ais/project/listGroups.action?querySource=grid&crudId="+crudIds,
					url : "ais/project/listGroups.action?querySource=grid&crudId=${crudId}&type=${type}",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					pageSize: 20,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[
					/* 	{
							text:'刷新',
							iconCls:'icon-reload',
							handler:function(){
								$('#list_groupList').datagrid('reload');
							}
						}, */
						<s:if test="${type != 'view'}">
						{
							id:'addGroupButton',
							text:'新增',
							iconCls:'icon-add',
							handler:function(){
								openAddGroupPage();
							}
						},'-',
						</s:if>
						helpBtn
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					columns:[[  
						{field:'groupTypeName',
							title:'分组类型',
							width:'10%',
							halign:'center',
							align:'center',
							sortable:true
						},
						{field:'groupName',
							 title:'分组名称',
							 width:'10%',
							 halign:'center',
							 align:'center',
							 sortable:true
						},
						{field:'auditObjectName',
							 title:'被审计单位',
							 width:'10%',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'task',
							 title:'按审计事项分配',
							 width:'10%',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,row,index){
								 var a = '<a href="javascript:void(0);"  onclick="taskBtn(\''+row.groupId+'\')">分配审计事项</a>';
								 return a;
							 }
						},
						{field:'description',
							 title:'分组说明',
							 width:'10%',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'pro_teamleader_name',
							 title:'分组组长',
							 width:'10%',
							 halign:'center',
							 align:'center', 
							 sortable:true
						}
						<s:if test="${type ne 'view'}">
						,{field:'groupId',title:'操作',halign:'center',align:'center',width:'10%',
							formatter:function(value,row,index){
								var s='';
								if (row.groupType=='fenbu'){
									s += '&nbsp;<a href="javascript:void(0);" style="color:blue" onclick="openModifyGroupPage(\''+row.groupId+'\')">修改</a>';
									s += '&nbsp;<a href="javascript:void(0);" style="color:blue" onclick="deleteGroup(\''+row.groupId+'\')">删除</a>';
								}else if ( row.groupType=='zhengti'){
									//s += '&nbsp;<a href="javascript:void(0);" style="color:blue" onclick="openModifyGroupPage(\''+row.groupId+'\')">修改</a>';							
								}
								return s;
							}
						}
						</s:if>
					]]   
				});
				
				//初始化添加/修改小组窗口
				$('#groupButtonDiv').window({
					width:596,   
					height:220,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				
				
				//单元格tooltip提示
				$('#list_groupList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				
				});
				
			});
			
			//关闭添加/修改小组窗口
			function close_win(){
	   			$('#groupButtonDiv').window('close');  
	   		}
		
		/**
		*	刷新组间授权的tab
		*/
		function refreshPermissionTab(){
			try{
				window.parent.frames['auditResultPermissionFrame'].location.reload();
			}catch(e){};
		}
		
		/**
			打开添加组页面
		*/
		function openAddGroupPage(){
			jQuery.ajax({
				url:'${contextPath}/project/prepare/isMyProject.action',
				type:'POST',
				data:{"crudId":'${crudId}'},
				dataType:'json',
				async:'false',
				success:function(data){
					if(1 == 1) {
						//window.location.href = '${contextPath}/project/editGroup.action?crudId=${crudId}';
						var myurl = '${contextPath}/project/editGroup.action?crudId=${crudId}';
						//$("#groupButtonFrame").attr("src",myurl);
						//$('#groupButtonDiv').window('open');
						var o=$('#groupButtonDiv');
						o.dialog({width:800,height:450,maximizable:false,resizable:false,draggable:false});
						o[0].children[0].src=myurl;
						o.dialog('open');
					}else{
						$.messager.show({
							title:'消息',
							msg:'您不是项目组成员，不能进行操作！'
						});
					}
				},
				error:function(){
				}
			});
			
		}
		/**
			打开修改指定组页面
		*/
		function openModifyGroupPage(groupId){
//			var ids = document.getElementsByName("groupCheckBox");
			/*var rows =$('#list_groupList').datagrid('getSelections');
			if(rows.length == 0 ){
				$.messager.show({
					title:'消息',
					msg:'请选择要修改的项目小组！'
				});
				return;
			}
			for(var i=0;i<rows.length;i++){*/
					jQuery.ajax({
						url:'${contextPath}/project/prepare/isMyProject.action',
						type:'POST',
						data:{"crudId":'${crudId}'},
						dataType:'json',
						async:'false',
						success:function(data){
							if(1 == 1) {
								//window.location.href = '${contextPath}/project/editGroup.action?crudId=${crudId}&&groupId='+rows[i].groupId;
								var myurl = '${contextPath}/project/editGroup.action?crudId=${crudId}&&groupId='+groupId; /*rows[i].groupId;*/
								//$("#groupButtonFrame").attr("src",myurl);
								//$('#groupButtonDiv').window('open');
								var o=$('#groupButtonDiv');
								o.dialog({width:800,height:500,maximizable:false,resizable:false,draggable:false});
								o[0].children[0].src=myurl;
								o.dialog('open');
							}else{
								$.messager.show({
									title:'消息',
									msg:'您不是项目组成员，不能进行操作！'
								});
							}
						},
						error:function(){
						}
					});
					/*
					break;
			}*/
			
		}
		
		/**
			删除选中的组
		*/
		function deleteGroup(groupId){
			/*var ids =$('#list_groupList').datagrid('getSelections');//('getChecked');
			if(ids.length == 0 ){
				$.messager.show({
					title:'消息',
					msg:'请选择要删除的项目小组！'
				});
				return;
			}
			for(var i=0;i<ids.length;i++){*/
					if(!isProGroupCanDelete(groupId)){//(ids[i].groupId)){
						return false;
					}
					$.messager.confirm('确认','确定要删除选定的项目小组吗？',function(r){    
						if (r){    
							jQuery.ajax({
								url:'${contextPath}/project/prepare/isMyProject.action',
								type:'POST',
								data:{"crudId":'${crudId}'},
								dataType:'json',
								async:'false',
								success:function(data){
									if(1 == 1) {
										//window.location.href="${contextPath}/project/deleteGroup.action?crudId=${crudId}&&groupId="+ids[i].groupId;
										jQuery.ajax({
											url:"${contextPath}/project/deleteGroup.action?crudId=${crudId}&&groupId="+groupId,/*ids[i].groupId,*/
											type:'POST',
											async:'false',
											success:function(data){
												$('#list_groupList').datagrid('reload');
												$.messager.show({
													title:'消息',
													msg:'删除成功！'
												});
											}
										});										
									}else{
										$.messager.show({
											title:'消息',
											msg:'您不是项目组成员，不能进行操作！'
										});
									}
								},
								error:function(){
								}
							});
						}    
					});/*
					break;
			}*/
		}
		
		/**
		* 是否可以删除指定编号的组
		*/
		function isProGroupCanDelete(groupId){
			var result = 'YES';
			var messages = '';
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);
			DWRActionUtil.execute(
				{ namespace:'/project/members', action:'isProGroupCanDelete', executeResult:'false' }, 
				{'groupId':groupId},
				xxx);
			function xxx(data){
				result = data['isProGroupCanDelete'];
				messages = data['messages'];
			} 
			if(result=='YES'){
				return true;
			}else{
				$.messager.show({
					title:'消息',
					msg:messages
				});
				return false;
			}
		}
		
	
		/*
			改变底部按钮状态
		*/
		function changeGroupButtonState(checkbox,groupType){
			if(checkbox.checked){
				var ids = document.getElementsByName("groupCheckBox");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked && checkbox.value != ids[i].value){
						ids[i].checked=false;
					}
				}
			}
			var deleteButton = document.getElementById('deleteGroupButton');
			var modifyGroupButton = document.getElementById('modifyGroupButton');
	
			deleteButton.disabled=true;
			modifyGroupButton.disabled = true;
			
			if((!checkbox.checked) || (groupType=='fenbu' && checkbox.checked)){
				deleteButton.disabled=false;
				modifyGroupButton.disabled=false;
			}
		}
			
		function taskBtn(group_id){
			if ( "${audProgramme}" == "1"){
				var temp = '${contextPath}/operate/task/project/mainReadyGroud.action?view=${view}&project_id=${projectFormId}&group_id='+group_id;
				 // window.parent.addTab('tabs','审计分组分工','groupframe',temp,true);
				aud$openNewTab('审计分组分工',temp,true);
			}else{
				$.messager.show({title:'提示消息',msg:'请先创建实施方案！'})	;	
			}
		}
		</script>
	</body>
</html>