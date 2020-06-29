<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:head theme="ajax" />
		<title>审计方案库选择2</title>
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script>
		
		  //编辑
          function editRecord(){
        	 var rows = $('#operateList').datagrid('getChecked');
        	 if(rows == null || rows.length == 0){
        		 //$.messager.alert('警告',"请选择要创建的记录","error");
        		 top.$.messager.show({title:'提示信息', msg:"请选择要创建的记录!"});
                 return false;
             }
                 var row = rows[0];
                 var audTemplateId=row['audTemplateId'];
                 window.location.href='${contextPath}/operate/template/generate.action?project_id=${project_id}&taskInstanceId=${taskInstanceId}&ppFormId=${ppFormId}&audTemplateId='+audTemplateId; 
		   } 
		   
		    function viewRecord(){
		    	var rows = $('#operateList').datagrid('getChecked');
	        	 if(rows == null || rows.length == 0){
	        		 //alert("请选择要查看的记录!");
	        		 //$.messager.alert('警告',"请选择要查看的记录","error");
	        		 top.$.messager.show({title:'提示信息', msg:"请选择要查看的记录!"});
	                 return false;
	             }
	                 var row = rows[0];
	                 var audTemplateId=row['audTemplateId'];
	                 var temp ='${contextPath}/operate/template/mainView.action?audTemplateId='+audTemplateId;
	         		 window.parent.addTab('tabs','查看实施方案','tempframe3',temp,true);
		   } 
		   

		
		jQuery(document).ready(function(){
			jQuery.ajax({
				url:'${contextPath}/project/prepare/isMyProject.action',
				type:'POST',
				data:{"crudId":'${project_id}'},
				dataType:'json',
				async:'false',
				success:function(data){
					if(data == null) {
						jQuery("#isguest").hide();
					}else{
					}
				},
				error:function(){
				}
			});
		});
</script>

	<body class="easyui-layout">
		<s:form id="myform"   action="view.action"   namespace="/operate/template">
			<s:hidden name="type" />
			<div region="center" >
				<table id="operateList"></table>
			</div>
		 </s:form>
 	<script>
		$(function(){
			$('#operateList').datagrid({
				url : "<%=request.getContextPath()%>/operate/template/relistAll.action?querySource=grid&project_id=${project_id}&taskInstanceId=${taskInstanceId}&ppFormId=${crudId}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:false,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'createTask',
						text:'创建方案',
						iconCls:'icon-add',
						handler:function(){
						editRecord();
						}
					},
					{
						id:'viewRecord',
						text:'查看方案',
						iconCls:'icon-view',
						handler:function(){
							viewRecord();
						}
					},
					{
						id:'toW',
						text:'返回',
						iconCls:'icon-undo',
						handler:function(){
							window.history.back();
						}
					}
				],
				frozenColumns:[[
							{field:'audTemplateId',width:'50px',  hidden:true, align:'center'},
							{field:'templateName',
									title:'方案名称',
									width:"20%",
									halign:'center',
									align:'left', 
									sortable:true
							}
					]],
				columns:[[ 
							{field:'proVer',
								title:'方案版本',
								width:"10%",
								halign:'center',
								sortable:true, 
								align:'center'
							},
							{field:'typeName',
								 title:'类别名称',
								 width:"20%", 
								 halign:'center',
								 align:'left', 
								 sortable:true
							},
							{field:'typeName2',
								 title:'子类别名称',
								 width:"15%", 
								 halign:'center',
								 align:'left', 
								 sortable:true
							},
							{field:'atCompany',
								 title:'所属单位',
								 width:"15%", 
								 halign:'center',
								 align:'center', 
								 sortable:false
							},
							{field:'proAuthorName',
								 title:'编制人',
								 width:80, 
								 halign:'center',
								 align:'center', 
								 sortable:false
							},
							{field:'proDate',
								 title:'编制日期',
								 width:100, 
								 halign:'center',
								 align:'center', 
								 sortable:false,
								 formatter:function(value,row,index){ 
									 if(null!=value){
										  var unixTimestamp = value.substring(0,10);
					                         return unixTimestamp ;
									 }else{
										 return '';
									 }
			                       } 
							}
				]]   
			}); 
		});
		
　 	</script>
	</body>
</html>

