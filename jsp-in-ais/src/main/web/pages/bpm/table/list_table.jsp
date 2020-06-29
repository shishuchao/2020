<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>表单显示</title>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>
	<SCRIPT type="text/javascript">
	
	function openAddBpmTable(){
		window.location.href='<s:url action="edit" namespace="/bpm/table" includeParams="none"></s:url>';
	}
	function OpenNewJsp(code,tName){	
		window.location.href = '${contextPath}/bpm/tableField/list.action?bpmTable.code='+code+'&&bpmTable.name='+encodeURI(encodeURI(tName));
	}
	function editFrom(code,name){
		window.location.href="${contextPath}/bpm/table/edit.action?bpmTable.code="+code;
	}
	function del(code,name){
		$.messager.confirm('确认','确认删除吗?', function(flag){
			if (flag) {
				$.ajax({
					url:"${contextPath}/bpm/table/delete.action?",
					type:"POST",
					data:{"bpmTable.code":code},
					success:function(data){
						if(data == '1') {
							showMessage1('删除成功！');
							$('#bpmTableList').datagrid('reload');
						}else{
							showMessage1('该业务对象已经被流程选用，不可以删除！');
						}
					},
					error:function(data){
						showMessage1('系统错误，请刷新数据后重新尝试！');
					}
				});
			}
		});
	}
	</SCRIPT>
</head>
<body class="easyui-layout">
	<div id="bpmTableList"></div>
	<div id="configTable" title="设计字段"></div>
	<s:property value="#session.errorTable" />
	<c:remove var="errorTable" scope="session" />
	<script type="text/javascript">
	$(function(){
		showWin('configTable','xxxxxx');
		$('#bpmTableList').datagrid({
			url : "<%=request.getContextPath()%>/bpm/table/list.action?querySource=grid",
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
					text:'添加表单',
					iconCls:'icon-add',
					handler:function(){
						openAddBpmTable();
					}
				},'-',helpBtn
			],
			onLoadSuccess:function(){
				initHelpBtn();
			},
			columns:[[  
				{field:'code',title:'编码',width:150,halign:'center',align:'left',sortable:true},
				{field:'name',title:'表单名称',width:100,halign:'center',sortable:true,align:'left'},		
				{field:'description',
						title:'计表单描述',
						width:100,
						halign:'center',
						align:'left',
						sortable:true
				},
				{field:'operate',
					 title:'操作',
					 align:'center',
					 sortable:false,
					 formatter:function(value,row,index){
					 	var param = [row.code,row.name];
					 	var btn2 = "修改,editFrom,"+param.join(',')+"-btnrule-设计字段,OpenNewJsp,"+param.join(',')
								   +"-btnrule-删除表单,del,"+param.join(',');
						return ganerateBtn(btn2);
					 }
				}
			]]   
		}); 
	});
	</script>
</body>
</html>
