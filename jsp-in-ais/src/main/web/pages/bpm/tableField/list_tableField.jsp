<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>字段显示</title>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		
		<SCRIPT type="text/javascript">
			function openAddBpmTableField()
			{
				window.location.href='<s:url action="edit" namespace="/bpm/tableField" includeParams="none"></s:url>?bpmTableField.table_code=<s:property value="%{bpmTable.code}"/>&&bpmTable.name='+encodeURI(encodeURI('<s:property value="%{bpmTable.name}" />'));
			}
			function editBpmTableField(table_code,code)
			{
				window.location.href='${contextPath}/bpm/tableField/edit.action?bpmTableField.code='+code+'&&bpmTableField.table_code='+table_code+'&&bpmTable.name='+encodeURI(encodeURI('<s:property value="%{bpmTable.name}" />'));
			}
			function deleteAddBpmTableField(code,table_code)
			{
				window.location.href='${contextPath}/bpm/tableField/delete.action?bpmTableField.code='+code+'&&bpmTableField.table_code='+table_code+'&&bpmTable.name='+encodeURI(encodeURI('<s:property value="%{bpmTable.name}" />'));
			}
			function deleteAddBpmTableFieldById(table_code,code,id){
				$.messager.confirm('提示信息','您确定要删除吗?',function(flag){
					if(flag){
						window.location.href='${contextPath}/bpm/tableField/deleteFieldById.action?bpmTableField.id='+id+'&&bpmTableField.table_code='+table_code+'&&bpmTable.name='+encodeURI(encodeURI('<s:property value="%{bpmTable.name}" />'));
					}
				});
			}
			
			function init(){
				if('${session.errorTableField}' != ''){
					showMessage1('${session.errorTableField}');
					return false;
				} 
			}
		</SCRIPT>
	</head>
	<body onload='init();' class="easyui-layout">
		<div class="easyui-panel" fit=true style="overflow: visibility ;"
			title="所属表单：${bpmTable.name}
			<br>
			<%--<div style='font-color:red'><s:property value="#session.errorTableField" /></div> --%>
			<c:remove var="errorTableField" scope="session" />" >
				<table id="bpmTableFieldList"></table>
		</div>
		<script type="text/javascript">
		$(function(){
			$('#bpmTableFieldList').datagrid({
				url : "<%=request.getContextPath()%>/bpm/tableField/list.action?querySource=grid&bpmTable.code=${bpmTable.code}&bpmTable.name="+encodeURI("${bpmTable.name}"),
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:true,
				fit: true,
				pageSize:20,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'newYear',
						text:'添加字段',
						iconCls:'icon-add',
						handler:function(){
								openAddBpmTableField();
						}
					},{
						id:'newYear',
						text:'返回列表页面',
						iconCls:'icon-undo',
						handler:function(){
								window.location.href="<%=request.getContextPath()%>/bpm/table/list.action";
						}
					}
				],
				columns:[[  
					{field:'code',title:'字段编码',width:150,halign:'center',align:'center',sortable:true,formatter:function(value,row,IndexRow){
								if(row.used=='1'){
									return '<font color="color">'+row.code+'</font>';
								}else{
									return row.code;
								}
					}},
					{field:'name',title:'字段名称',width:100,halign:'center',sortable:true,align:'left'},		
					{field:'dbfield',
							title:'数据库对应字段名称',
							width:150,
							halign:'center', 
							align:'center', 
							sortable:true
					},
					{field:'type',
							title:'字段类型',
							width:100,
							halign:'center',
							align:'center', 
							sortable:true
					},
					{field:'description',
							title:'字段描述',
							width:100,
							halign:'center', 
							align:'left', 
							sortable:true
					},
					{field:'operate',
						 title:'操作',
						 width:150, 
						 halign:'center', 
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
						 	var param = [row.table_code,row.code,row.id];
						 	var btn2 = "修改,editBpmTableField,"+param.join(',')+"-btnrule-删除,deleteAddBpmTableFieldById,"+param.join(',');
							return ganerateBtn(btn2);
						 			
						 }
					}
				]]   
			}); 
		});
		</script>
	</body>
</html>
