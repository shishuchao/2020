<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>人员状态主页</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script language="javascript">

//单击一行，选择checkbox
function selchkbox(){
	init();
	var trObj = event.srcElement.parentNode.parentNode;
	if(trObj.tagName=="tr"||trObj.tagName=="Tr"||trObj.tagName=="TR"){
		trObj.style.color="red";
	}
}

function init(){
	var obj = document.getElementById("row");
	for(var i=0;i<obj.rows.length;i++){
		obj.rows[i].style.color="#000000";
	}
}

 		function doSearch(){
	        	$('#list').datagrid({
	    			queryParams:form2Json('searchForm')
	    		});
	        }

</script>	
	</head>
<body>
		<table id="list"></table>
		<input type="hidden" name="freeStartDate" id="freeStartDate" value="${helper.freeStartDate}"/>
		<input type="hidden" name="fullStartDate"  id="fullStartDate" value="${helper.fullStartDate}"/>
		<input type="hidden" name="fullEndDate"  id="fullEndDate" value="${helper.fullEndDate}"/>
		<input type="hidden" name="freeEndDate" id="freeEndDate" value="${helper.freeEndDate}"/>
		
	<script language="javascript">
	 var freeStartDate=document.getElementById("freeStartDate");
	  var fullStartDate=document.getElementById("fullStartDate");
	   var fullEndDate=document.getElementById("fullEndDate");
	   	   var freeEndDate=document.getElementById("freeEndDate");
		$(function(){
			$('#list').datagrid({
						url : '<%=request.getContextPath()%>/mng/examproject/members/audProjectMembersInfo/toEmployeeManageMain.action?querySource=grid',
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
						frozenColumns:[[
						       			{field:'id',width:'50px', checkbox:true, align:'center',
											 formatter:function(value,row,index){
												 return row.employeeInfo.id;
											 }
										},
						       			{field:'employeeInfo.name',title:'姓名',width:'50px',align:'center',
											 formatter:function(value,row,index){
												 return row.employeeInfo.name;
											 }
										},
						       			{field:'employeeInfo.company',title:'所属单位',width:'250px',sortable:true,align:'center',
						       				 formatter:function(value,row,index){
												 return row.employeeInfo.company;
											 }
										}
						    		]],
						columns:[[  
							{field:'employeeInfo.duty',
									title:'职务级别',
									width:250,
									align:'center', 
									sortable:true,
											 formatter:function(value,row,index){
												 return row.employeeInfo.duty;
											 }
									},
							{field:'row.plan_wait_running',
								title:'排程计划',
								width:80,
								sortable:true, 
								align:'center',
											 formatter:function(value,row,index){
												 return row.plan_wait_running;
											 }
							},
							{field:'row.plan_running',
								 title:'在审项目',
								 width:200, 
								 align:'center', 
								 sortable:true
											 ,
											 formatter:function(value,row,index){
												 return row.plan_running;
											 }
							},
							{field:'row.plan_finished',
								 title:'已审项目',
								 width:200, 
								 align:'center', 
								 sortable:true ,
											 formatter:function(value,row,index){
												 return row.plan_finished;
											 }
							},
							{field:'paging.banner.placement',
								 title:'操作',
								 width:100, 
								 align:'center', 
								 sortable:false,
								 formatter:function(value,row,index){
								 	var dws='<a href="<%=request.getContextPath()%>/mng/examproject/members/audProjectMembersInfo/lookAtDetail.action?employeeInfo.sysAccounts='+row.employeeInfo.sysAccounts+'&employeeInfo.id='+row.employeeInfo.id+'&helper.freeStartDate='+ freeStartDate.value+'&helper.freeEndDate='+freeEndDate.value+'&helper.fullStartDate='+fullStartDate.value+'&helper.fullEndDate='+fullEndDate.value+'" onclick="selchkbox();" target="f_bottom">详情</a>';
									 return dws;
								 }
							}
						]]   
					}); 
					
		});
				
		</script>
	</body>
</html>
