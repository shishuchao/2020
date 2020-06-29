<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:head theme="ajax" />
		<title>审计方案库选择1</title>
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script>
		
		  //编辑
          function editRecord(){
        	 var rows = $('#operateList').datagrid('getChecked');
        	 if(rows == null || rows.length == 0){
        		 top.$.messager.show({title:'提示信息', msg:"请选择要创建的记录!"});
        		 //$.messager.alert('警告',"请选择要查看的记录","error");
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
                 var temp ='${contextPath}/operate/template/mainView.action?interCtrl=${interCtrl}&audTemplateId='+audTemplateId;
         		 var title = "${interCtrl}" == "true" ? "评价" : "实施";
                 top.addTab('tabs', title + '方案查看 ','tempframe',temp,true);
		   } 
		   

		
		jQuery(document).ready(function(){
			jQuery.ajax({
				url:'${contextPath}/project/prepare/isMyProjectEdit.action',
				type:'POST',
				data:{"crudId":'${project_id}'},
				dataType:'json',
				async:'false',
				success:function(data){
					if("${interCtrl}" == "true"){
						return;
					}
					//只有整体组负责人、组长、主审、副组长可以创建、修改方案
					data.group == 'zhengti' && data.role == '1' ? jQuery("#createTask").show() : jQuery("#createTask").hide();
					
					/*
					if(data == null) {
						jQuery("#createTask").hide();
						jQuery("#viewRecord").hide();
					}else{
					}*/
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
			<s:hidden id="oprauthority"/>
		 </s:form>
 	<script>
		$(function(){
			var oprauthority =$('#oprauthority').val()
			if(1==oprauthority){
				jQuery("#createTask").hide();
				jQuery("#viewRecord").hide();
			}
			
			$('#operateList').datagrid({
				url : "<%=request.getContextPath()%>/operate/template/listAll.action?querySource=grid&project_id=${project_id}",
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
					}
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				frozenColumns:[[
					{field:'audTemplateId',width:'50px',  hidden:true, align:'center'},
					{field:'templateName',
							title:'方案模板名称',
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

