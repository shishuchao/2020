<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>查询书列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<script type="text/javascript">
	showWin('dlgSearch');
	  function freshGrid(){
				searchWindShow('dlgSearch',600,200);
			}
	  /*
		* 查询
		*/
		function doSearch(){
      	$("#newsList").datagrid({
				queryParams:form2Json("myForm")
			});
			$('#dlgSearch').dialog('close');
      }
		function openUrlByMsgId(msgId){
			openUrl('innerMsg_view.action?innerMsg.msgId='+msgId);
		}
		//站内消息回复
		function openUrlByMsgIdReply(msgId,readFlag){
			window.location.href= 'innerMsg_reply.action?innerMsg.msgId='+msgId+'&readFlag='+readFlag;
		}		
		function showResponse(row){
			rows = row.parentElement.getElementsByTagName("tr");
			if (rows.length==1){
				location.reload();//刷新
			}else{
				row.parentElement.removeChild(row);
			}
		}
		function DeleteContacts(){
			var ids = $('#newsList').datagrid('getSelections');
			if (ids.length  != 1 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
		$.messager.confirm('提示信息', '确定要删除常用联系人信息吗?', function(isDel){
			if(isDel){
				 var idv = ids[0].id;
				$.ajax({
					url:"${contextPath}/admin/delContacts.action",
					type:"POST",
					data:{"id":idv},
					success:function(flag){
						if(flag = "suc"){
							$.messager.show({title:'提示信息',msg:'删除成功!'});	
							doSearch();
						}else{
							$.messager.show({title:'提示信息',msg:'删除失败!'});	
						}
					}
					
				});
			}
		  });
		}
		function openByContacts(){
			var ids = $('#newsList').datagrid('getSelections');
			if (ids.length  != 1 ) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
				return false;
			}
			 var idv = ids[0].id;
		   window.location.href='${contextPath}/admin/contactsEdit.action?id='+idv;
		}
		/*
		* 重置
		*/
		function resetContacts(){
			resetForm('myForm');
			doSearch();
		}
		/*
		* 取消
		*/
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
		
		
	</script>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
  <div id="dlgSearch" class="searchWindow" title="查询条件" style='overflow:hidden;padding:0px;' >
		<div class="search_head">
			<s:form id="myForm" action="contactsList" method="post" namespace="/admin" >
				<table class="ListTable" align="center">
					<tr>
					<td align="left" class="EditHead" style="width:15%;">
							姓名
						</td>
						<td align="left" class="editTd" style="width:34%;" >
						<s:textfield name="contacts.userName" title="姓名" id="userName" cssClass="noborder"/>
						</td>
						<td align="left" class="EditHead" style="width:15%;">
							系统账号
						</td>
						<td align="left" class="editTd" style="width:34%;">
							<s:textfield name="contacts.sysAccount" title="系统账号" id="sysAccount" cssClass="noborder"/>
						</td>
					</tr>
				</table>
			</s:form>
			<br/><br/>
			<div  align="right">
				<a class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetContacts()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
		 </div>
		</div>
		
</div> 
<div region="center" >
		<table id="newsList"></table>
	</div> 
			<div id="tb">
			<a href="javascript:;" class="easyui-linkbutton" id="search" onclick="freshGrid()" data-options="iconCls:'icon-search',plain:true">查询</a>
			<a href="javascript:;" class="easyui-linkbutton" id="edit"  onclick="openByContacts()" data-options="iconCls:'icon-edit',plain:true">修改</a>
			<a href="javascript:;" class="easyui-linkbutton"  id="del" onclick="DeleteContacts()" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div>

	<script type="text/javascript">
		 $(function(){
			$('#newsList').datagrid({
				url : "<%=request.getContextPath()%>/admin/contactsList.action?querySource=grid",
	      	method:'post',
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				border:false,
				toolbar: '#tb',
				singleSelect:true,
				remoteSort: false, 
				
			/* 	method:'post',
				showFooter:false,
				rownumbers:true, 
			 	pagination:true, 
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:false,
				border:false,
				singleSelect:false,
				remoteSort: false,
				pageSize:20,
				//selectOnCheck: false,
				toolbar: '#tb', */
				columns:[[  
					{field:'userName',
							title:'姓名',
							width:100,
							align:'center', 
							sortable:true
					},
					{field:'sysAccount',
						title:'系统账号',
						width:200,
						sortable:true, 
						align:'center',
						
					},
					{field:'email',
						 title:'电子信箱',
						 width:200, 
						 align:'center', 
						 sortable:true
						
					}
				]]   
			}); 
		}); 
	</script>
</body>
</html>