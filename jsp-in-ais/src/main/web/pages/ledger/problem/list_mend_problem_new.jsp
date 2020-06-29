<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
	<head>
		<title>审计决定问题</title>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
	  	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></SCRIPT>
		<script language="javascript">
			function expMendProblemNew(){
				myform.submit();
			}
			
			//初始化加载表格
			$(function(){
				// 初始化生成表格
				$('#gridList').datagrid({
					url : "<%=request.getContextPath()%>/proledger/problem/mendLedgerListNew.action?querySource=grid&project_id=${project_id}",
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
					columns:[[  
						{field:'serial_num',
								title:'问题编号',
								width:200,
								align:'center', 
								sortable:true
						},
						{field:'problem_all_name',
							title:'问题类别',
							width:300,
							sortable:true, 
							align:'center'
						},
						{field:'problem_name',
							 title:'问题点',
							 width:200, 
							 align:'center', 
							 sortable:true
						},
						{field:'problem_money',
							 title:'问题发生金额（万元）',
							 width:200, 
							 align:'center', 
							 sortable:true
						},
						{field:'problemCount',
							 title:'发生数量（个）',
							 width:200, 
							 align:'center', 
							 sortable:false
						},
						{field:'describe',
							 title:'问题摘要',
							 width:200, 
							 align:'center', 
							 sortable:false
						},
						{field:'audit_advice',
							 title:'审计建议',
							 width:200, 
							 align:'center', 
							 sortable:false
						},
						{field:'loginIp',
							 title:'操作',
							 width:200, 
							 align:'center',
							 sortable:false,
							 formatter:function(value,rowData,rowIndex){
							 	var id = rowData.id;
							 	if(${view != 'view' }){
							 		if(${permission=='full'}){
								 		return "<a href=\"${contextPath}/proledger/problem/editMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=true&permission=full\">编辑</a>"
							 		}else{
							 			return "<a href=\"${contextPath}/proledger/problem/editMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=true\">编辑</a>"
							 		}
							 	}else{
							 		return "<a href=\"${contextPath}/proledger/problem/viewMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=false&view=view\">查看</a>"
							 	}
							 }
							 
							 
						}
					]]   
				}); 
			});
			
			//查询
			function doSearch(){
	        	$('#userList').datagrid({
	    			queryParams:form2Json('searchForm')
	    		});
	        }
			
		</script>
	</head>
	<body>
		<center style="height:100%">
			<table id="gridList"></table>
			<!-- 
			<display:table name="list" id="row" requestURI="${contextPath}/proledger/problem/mendLedgerListNew.action" class="its" pagesize="15">
                <display:column title="问题编号" property="serial_num" sortable="true" class="center" headerClass="center" />
                <display:column property="problem_all_name" title="问题类别" sortable="true" class="center" headerClass="center"></display:column>
				<display:column property="problem_name" title="问题点" sortable="true" class="center" headerClass="center"></display:column>
				<display:column title="问题发生金额（万元）" sortable="true" class="center" headerClass="center">
				<fmt:formatNumber value="${row.problem_money}" pattern="###.############"/>
				</display:column>
				<display:column property="problemCount" title="发生数量（个）" sortable="true" class="center" headerClass="center"></display:column>
				<display:column property="describe" title="问题摘要" sortable="true" class="center" headerClass="center"></display:column>
				<display:column property="audit_advice" title="处理决定" sortable="true" class="center" headerClass="center"></display:column>
				<display:column title="操作" class="center" headerClass="center">
					<s:if test="${view != 'view' }">
						<s:if test="${isEdit=='true'}">
							<s:if test="${permission=='full'}">
								<a href="${contextPath}/proledger/problem/editMendLedger.action?id=${row.id}&project_id=${project_id}&isEdit=true&permission=full">编辑</a>
							</s:if>
							<s:else>
								<a href="${contextPath}/proledger/problem/editMendLedger.action?id=${row.id}&project_id=${project_id}&isEdit=true">编辑</a>
							</s:else>
						</s:if>
					</s:if>
					<s:else>
						<a href="${contextPath}/proledger/problem/viewMendLedger.action?id=${row.id}&project_id=${project_id}&isEdit=false&view=view">查看</a>
					</s:else>
					
				</display:column>
			</display:table>
			 -->
		</center>
	<s:form id="myform" action="expMendProblem" namespace="/proledger/problem">
		<div align="right">
		<!-- 导出功能暂时屏蔽掉，最后在放出来研究放在哪里   liyc -->
		<!-- <input type="button" onclick="expMendProblemNew();" value="导出"/> -->
		&nbsp;&nbsp;&nbsp;&nbsp;</div>
		<s:hidden name="project_id" />
		<s:hidden name="isEdit" />
		<s:hidden name="permission" />
	</s:form>
	</body>
</html>
