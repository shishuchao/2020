<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>设置群组</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript">
		function openAddWindow(definitionId)
		{
			window.location.href='<s:url action="toAddGroup" namespace="/bpm/group" includeParams="none"></s:url>?definitionId='+definitionId;
		}
		function deleteGroup(ids,definitionId){
		  $.messager.confirm('提示信息', '确认删除吗?', function(is){
        	if(is){
        		$.ajax({
    				type:'post',
    				url:"${contextPath}/bpm/group/deleteGroup.action",
    				data:{"id":ids,"definitionId":definitionId},
    				success:function(data){
    					if(data.suc == 1){
    						 top.$.messager.show({title:'提示信息',msg:'删除成功!'});
    						 window.location.reload();
    					}else if(data.suc  == 2){
    						 top.$.messager.show({title:'提示信息',msg:'存在流程!'});
    					}else{
    						top.$.messager.show({title:'提示信息',msg:'删除失败!'});
    					}
    					
    				}
    				
    			});	
        	}
		  }); 
		}
	</script>
	</head>
	<body class="easyui-layout">
		<s:property value="#session.errorGroup" />
		<c:remove var="errorGroup" scope="session" />
		<div region="center" >
			<table id="bpmGroupList"></table>
		</div>
	</body>
	<script type="text/javascript">
		$(function(){
			$('#bpmGroupList').datagrid({
				url : "<%=request.getContextPath()%>/bpm/group/findBpmGruopByDefinitionId.action?querySource=grid&definitionId=${definitionId}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'newYear',
						text:'添加群组',
						iconCls:'icon-add',
						handler:function(){
							openAddWindow('${definitionId}');
						}
				}],
				frozenColumns:[[
				       			{field:'name',title:'群组名称',width:'230px',align:'center'},
				       			{field:'description',title:'描述信息',width:'230px',sortable:true,align:'center'}
				    		]],
				columns:[[  
					{field:'operate',
						 title:'操作',
						 width:230, 
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
							 return '<a href="${contextPath}/bpm/definition/authflow.action?bpmDefinition.id=${definitionId}&bpmGroup.id='+row.id+'" target="_blank" >授权</a>'
							 		+'&nbsp;&nbsp;'+
							 		'<a href="${contextPath}/bpm/group/toAddGroup.action?id='+row.id+'&definitionId=${definitionId}" target="_self" >修改</a>'
									 +'&nbsp;&nbsp;'+
							 		'<a href="javascript:void(0);" onclick="deleteGroup(\''+row.id+'\',\'${definitionId}\');">删除</a>';
						 }
					}
				]]   
			}); 
		});
	</script>	
</html>
