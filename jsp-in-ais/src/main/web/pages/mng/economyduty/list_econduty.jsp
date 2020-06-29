<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML >
<html>
	<head>
		<title>经济责任人基本信息列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center">
		<table id="its"></table>
	</div>
	<div id="showEcondutyDlg" title="经济责任人信息" style="overflow:hidden;padding:0">
		<iframe id="showEcondutyDlgFrame" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
	</div>
	<div>
		<form id="scace" action="<%=request.getContextPath()%>/mng/economyduty/economyDutyAction!delete.action" method="post">
			<input type="hidden" name="superids" id="superids"/>
			<s:hidden name="audobjid"></s:hidden>
			<s:hidden name="status"></s:hidden>
		</form>
	</div>
	<script type="text/javascript">
		
		function submeget(){
			delEdit();
		}
		function showEcondutyDlg(id) {
			<s:if test="${param.status == 'edit'}">
			var url = '${contextPath}/mng/economyduty/economyDutyAction!edit.action?superids=' + id + '&audobjid=${audobjid}&status=${param.status}';
			</s:if>
			<s:else>
			var url = '${contextPath}/mng/economyduty/economyDutyAction!view.action?id=' + id + '&audobjid=${audobjid}&status=${param.status}';
			</s:else>
			$('#showEcondutyDlgFrame').attr('src', url);
			$('#showEcondutyDlg').window('open');
		}

		$(function(){

			$('#showEcondutyDlg').window({
				width: 800,
				height: 450,
				modal: true,
				collapsible: false,
				maximizable: true,
				minimizable: false,
				closed: true
			});

			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/mng/economyduty/economyDutyAction!list.action?querySource=grid&audobjid=${audobjid}&status=",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:false,
				pageSize:20,
				remoteSort: false,
				<s:if test="${param.status == 'edit'}">
				toolbar:[{
						id:'add',
						text:'新增',
						iconCls:'icon-add',
						handler:function(){
							window.location.href='${contextPath}/mng/economyduty/economyDutyAction!add.action?audobjid=${audobjid}&status=${param.status}';						
						}
					},
					{
						id:'delete',
						text:'删除',
						iconCls:'icon-delete',
						handler:function(){
							submeget();
						}
					}
				],
				</s:if>
				columns:[[  
					<s:if test="${param.status == 'edit'}">
	            	{field:'formId',width:'50px', checkbox:true, align:'center'},
	            	</s:if>
	       			{field:'name',title:'姓名',width:80,align:'left',halign:'center',sortable:true,
						formatter:function(value,rowData,rowIndex){
							var onclick = "showEcondutyDlg('" + rowData.id + "')";
							return '<a href="javascript:' + onclick + '">' + rowData.name + '</a>';
						}
	       			},
	       		/* 	{field:'department',title:'工作部门',width:80,sortable:true,halign:'center',align:'left'}, */
					{field:'duty',
						title:'职务',
						width:100,
						halign:'center',
						align:'left', 
						sortable:true
					},
					{field:'incumbencyState',
						title:'在职状态',
						width:80,
						sortable:true, 
						align:'center'
					},
					{field:'beginDate',
						 title:'任职开始日期',
						 width:100, 
						 halign:'center',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,index){
						 	if(value!=null){
						 		return value.substring(0,10);
						 	}
						 }
					},
					{field:'endDate',
						 title:'任职结束日期',
						 width:100, 
						 halign:'center',
						 align:'right', 
						 sortable:true,
 						 formatter:function(value,row,index){
						 	if(value!=null){
						 		return  value.substring(0,10);
						 	}
						 }
					}
				]]   
			}); 
		});
		function wait(){
			document.getElementById("submitButton").disabled = true;
			document.getElementById("layer").style.display = "";
			document.getElementById("errorInfo1").style.display = "none";
			document.getElementById("errorInfo2").style.display = "none";
			importForm.submit();
		}
		function dutyEdit(){
			var rows2=$('#its').datagrid('getSelections');
			var cbx_count = 0;
			var cbx_no = -1;
			var keyvalue="";
			for(var i=0;i<rows2.length;i++){
				if(i==0){
					if(keyvalue==""){
						keyvalue=rows2[i].id;
					}
				}else{
					break;
				}
					cbx_count++;
			}
			if(rows2.length>1){
				showMessage1('不能同时修改多责任人信息！');
				return false;
			}
			if(rows2.length==0){
				showMessage1('请选择要修改的责任人!');
				return false;
			}
			scace.action="<%=request.getContextPath()%>/mng/economyduty/economyDutyAction!edit.action?superids="+keyvalue ;
			scace.submit();
		}

		function delEdit(checkboxName,name){
			var rows2=$('#its').datagrid('getSelections');
			var keyvalue="";
			var count = 0;
			for(var i=0; i<rows2.length; i++){
					if(keyvalue==""){
						keyvalue=rows2[i].id;
					}else{
						keyvalue=keyvalue+","+rows2[i].id;
					}
					count++;
			}
			if(count == 0){
				 showMessage1('请选择记录!');
				 return false;
			}
			$.messager.confirm('提示信息','确定删除吗？',function(isDel){
				if(isDel){
					var ids = document.getElementsByName("superidsaa");
					ids.value=keyvalue;
					scace.action="<%=request.getContextPath()%>/mng/economyduty/economyDutyAction!delete.action?superids="+keyvalue ;
					scace.submit();
					showMessage1('删除成功！');
					return true;
				}else{
					return false;
				}
			});
			return true;
		}
	</script>
	</body>
</html>
