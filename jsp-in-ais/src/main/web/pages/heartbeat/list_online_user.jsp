<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
	<title>在线用户</title>
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
<%--	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>--%>
	<SCRIPT type="text/javascript">
		//初始化加载表格
		$(function(){
			// 初始化生成表格
			$('#userList').datagrid({
				url : "<%=request.getContextPath()%>/heartbeat/list.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				border:false,
				singleSelect:true,
				pageSize: 20,
				remoteSort: true,
				toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('onlineUserSearch');
					}
				},'-',helpBtn],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				columns:[[  
					{field:'firstBeatTime',
							title:'登录时间',
							width:200,
							halign:'center',
							align:'center', 
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								value=value.replace(/-/g,"/");
								value=value.replace("T"," ");
								var d = new Date(value);
								var year = d.getFullYear();
								var month = d.getMonth()+1;
								var date = d.getDate();
								var h = d.getHours();
								var m = d.getMinutes();
								var s = d.getSeconds();
								return year+'-'+(month.length() == 2 ? month:'0'+month)+'-'+(date.length()==2?date:'0'+date)+' '+h+':'+(m.length()==2?m:'0'+m)+':'+(s.length()==2?s:'0'+s);
					}},
					{field:'orgName',
						title:'组织机构',
						width:300,
						sortable:true, 
						halign:'center',
						align:'left'
					},
					{field:'chiname',
						 title:'用户名称',
						 width:200,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'loginName',
						 title:'登录名',
						 width:200,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'loginIp',
						 title:'IP地址',
						 width:200, 
						 halign:'center',
						 align:'center', 
						 sortable:false
					}
				]]   
			});
			showWin('onlineUserSearch');
		});
		
		//查询
		function doSearch(){
        	$('#userList').datagrid({
    			queryParams:form2Json('searchForm')
    		});
    		$('#onlineUserSearch').window('close')
        }
        //重置查询条件
		function resetOnlineUser(){
			resetForm('searchForm');
			doSearch();
		}
	</SCRIPT>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<!-- 列表FORM -->
	<div id="onlineUserSearch" class="searchWindow">
		<div class="search_head">
			<s:form id="searchForm" name="searchForm" namespace="/heartbeat"  method="post" theme="simple">
				<table cellpadding=0 cellspacing=1 border=0  id="searchTab" class="ListTable" align="center">
					<tr>
						<td class="EditHead" style="width:15%">登录名</td>
						<td class="editTd" style="width:35%">
							<s:textfield name="ou.loginName" cssClass="noborder" cssStyle="width:80%"></s:textfield>
						</td>
						<td class="EditHead" style="width:15%">用户名称</td>
						<td class="editTd" style="width:35%">
							<s:textfield name="ou.chiname" cssClass="noborder" cssStyle="width:80%"></s:textfield>
						</td>
					</tr>
				<!-- 	<tr>
						<td class="EditHead" nowrap>登录起始时间</td>
						<td class="editTd">
							<s:textfield name="visittime1" cssClass="noborder" readonly="true" onclick="calendar()" value="${visittime1}"></s:textfield>
							<input type="text" id="visittime1" name="visittime1" editable="false" Class="easyui-datebox noborder" style="width:80%" />						
						</td>
						<td class="EditHead" nowrap>登录截止时间</td>
						<td class="editTd">
							<s:textfield name="visittime2" cssClass="noborder" readonly="true" onclick="calendar()" value="${visittime2}"></s:textfield>
							 <input type="text" id="visittime2" name="visittime2" editable="false" style="width:80%" Class="easyui-datebox noborder" />
						</td>
					</tr> -->
					<tr>
						<td class="EditHead">IP地址</td>
						<td class="editTd">
							<s:textfield name="ou.loginIp" cssClass="noborder" cssStyle="width:80%"></s:textfield>
						</td>
						<td class="EditHead">组织结构</td>
						<td class="editTd">
							<s:textfield name="ou.orgName" cssClass="noborder" cssStyle="width:80%"></s:textfield>
						</td>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetOnlineUser()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#onlineUserSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center">
		<table id="userList"></table>
	</div>
</body>
</html>
				