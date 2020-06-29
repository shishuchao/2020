<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>引用底稿数据页面</title>
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
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="north" data-options="split:false,collapsible:false" style="height:60px;overflow:hidden;">
			<s:form id="searchForm" name="searchForm" action="queryManuSelect" namespace="/operate/manu" method="post">
				<s:token/>
				<s:hidden name="project_id"/>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td align="left" class="EditHead">底稿名称</td>
						<td align="left" class="editTd"><s:textfield cssClass="noborder" cssStyle="width:300px;" name="ms_name" maxlength="100" />
							<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()" style="margin-left:100px;">查询</a>
						</td>
						<td align="left" class="EditHead" style="display: none">底稿编号</td>
						<td align="left" class="editTd" style="display: none"><s:textfield cssClass="noborder" cssStyle="width:300px;" name="ms_code" maxlength="100" /></td>
					</tr>
				</table>
			</s:form>
		</div>
		<s:hidden name="manuId"/>
		<div region="center">
			<table id="manuSelectList"></table>
		</div>
		<script type="text/javascript">
			function doSearch(){
	        	$('#manuSelectList').datagrid({
	    			queryParams:form2Json('searchForm')
	    		});
	        }
	        
	        function mySure(){
		        var selectedRows = $('#manuSelectList').datagrid('getChecked');//返回是个数组
		        if(selectedRows.length==0){
		        	$.messager.alert('提示信息','请选择引用底稿!','info');
		        	return false;
		        }
		        var strIds = "";
		        var strIds=new Array();
		        var strNames=new Array();
				   for(i=0;i <selectedRows.length;i++){
		                var tempformId = selectedRows[i].formId;
				        var tempms_name = selectedRows[i].ms_name;
				        strIds.push(tempformId);
				        strNames.push(tempms_name);
				   }	 
				   $("#mylinkManuName",parent.document).val(strNames.join(","));
				   $("#mylinkManuId",parent.document).val(strIds.join(","));
				   parent.closeWinUI();
	        }
	
			$(function(){
				// 初始化生成表格
				$('#manuSelectList').datagrid({
					url : "<%=request.getContextPath()%>/operate/manu/queryManuSelect.action?querySource=grid&manuId=${manuId}&project_id=${project_id}&t="+new Date().getTime() ,
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:false,
					remoteSort: false,
					toolbar:[{
							id:'mySure',
							text:'确定',
							iconCls:'icon-ok',
							handler:function(){
								mySure();
							}
						}
					],
					columns:[[  
						{field:'formId',title:"复选框",width:'7%', checkbox:true, halign:'center',align:'left'},						
		       			{field:'ms_name',title:'底稿名称',width:'35%',sortable:true,halign:'center',align:'left'},
		       		/* 	{field:'manuTypeName',title:'底稿类型',width:'80',sortable:true,align:'center'},		 */
		       			{field:'task_name',title:'审计事项',width:'30%',sortable:true,halign:'center',align:'left'},	
		       			{field:'ms_author_name',title:'撰写人',width:'12%',sortable:true,halign:'center',align:'left'}
					]]   
				}); 
			});
		</script>
	</body>
</html>