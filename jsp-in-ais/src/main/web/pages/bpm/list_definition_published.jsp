<!DOCTYPE HTML> 
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'已发布流程定义'"></s:text>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<SCRIPT type="text/javascript">
		function refresh(){
			parent.refreshUnusedflow();
		}
	</SCRIPT>
	</head>
<body class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head" style="height: 50px;">
			<s:form action="list_published" namespace="/bpm/definition" method="post" name="myform" id="myform">
				<input type="hidden" name="condition" value="yes" reload="false"/>
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width:20%">
							流程名称
						</td>
						<td class="editTd" style="width:30%">
							<s:textfield cssClass="noborder" name="bpmDefinition.name2Display"  cssStyle="width:80%"/>
						</td>
						<td class="EditHead" style="width:15%">
							业务对象
						</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="bpmDefinition.table_name" cssStyle="width:80%" maxlength="50"/>
						</td>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
			<div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
		</div>
	</div>

	<div region="center" border="0px">
		<table id="bpmDefinitionList"></table>
	</div>
	<div id="planName" title="已发布流程" style="overflow:hidden;padding:0px">
		<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
	<script type="text/javascript">
		$('#planName').window({
			//top:100,
			//left:300,
			width:900,
			height:400,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false,
			maximized:true,
			closed:true
		});
		function planName(url){
			//var viewUrl = "${contextPath}/plan/year/view.action?selectedTab=yearDetailListDiv&crudId="+id;
			$('#showPlanName').attr("src",url);
			$('#planName').window('open');
		}
	
		function listProcessInstance(definitionId){
			window.open('${contextPath}/bpm/monitor/list.action?definitionId='+definitionId,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		}

		/*
        * 查询
        */
		function doSearch(){
			document.getElementById('myform').action = "${contextPath}/bpm/definition/list_published.action";
			$('#bpmDefinitionList').datagrid({
				queryParams:form2Json('myform')
			});
			$('#dlgSearch').dialog('close');
		}
		/*
        * 取消
        */
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
		/**
		 重置
		 */
		function restal(){
			resetForm('myform');
		}

		$(function(){
			showWin('dlgSearch');
			$('#bpmDefinitionList').datagrid({
				url : "<%=request.getContextPath()%>/bpm/definition/list_published.action?querySource=grid",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize:20,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('dlgSearch');
					}
				},'-',helpBtn
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				columns:[[
					{field:'name2Display',title:'流程名称',width:100,halign:'center',align:'left',sortable:true},
	       			{field:'table_name',title:'业务对象',width:100,sortable:true,halign:'center',align:'left'},  
					{field:'form_name',
							title:'表单类型',
							width:150,
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'operate',
						 title:'操作',
						 align:'center',
						 width:200,
						 sortable:false,
						 formatter:function(value,row,index){
							<s:if test="${view eq 'view'}">
							 	return '<a href=\"javascript:void(0)\" onclick=\"toLook(\''+row.id+'\');\">查看</a>';
							</s:if>	
							<s:else>
								return '<a href=\"javascript:void(0)\" onclick="window.open(\'${contextPath}/bpm/definition/viewWebflow.action?bpmDefinition.id='+row.id+'\',\'流程图例\',\'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no\')">查看</a>'
								  		+'&nbsp;&nbsp;'+
								  		'<a href=\"javascript:void(0)\" onclick="planName(\'${contextPath}/bpm/group/findBpmGruopByDefinitionId.action?definitionId='+row.id+'\')">设置群组</a>'
								  		+'&nbsp;&nbsp;'+
								  		'<a href=\"javascript:void(0)\" onclick="planName(\'${contextPath}/bpm/definition/findDefinitionDepts.action?definitionId='+row.id+'\')">设置适用单位</a>'
								  		+'&nbsp;&nbsp;'+
								  		'<a href=\"javascript:void(0)\" onclick=\"inValid(\''+row.id+'\');\">失效</a>'
								  		+'&nbsp;&nbsp;'+
								  		'<a href=\"javascript:void(0)\" onclick="planName(\'${contextPath}/bpm/monitor/list.action?definitionId='+row.id+'\')">流程实例</a>';
							</s:else>
								 
						 }
					}
				]]   
			}); 
		});
		function inValid(id){
			$.messager.confirm('提示信息','确认失效该流程吗？',function(flag){
				if(flag){
					//window.location.href="${contextPath}/bpm/definition/invalid.action?id="+id;
				//	refresh();
					$.ajax({
					    type:'post',
						url:'${contextPath}/bpm/definition/invalid.action',
						data:{'id':id},
						datatype:'json',
						success:function(data){
							if(data.er != null && data.er != "" ){
								$.messager.alert('错误信息',data.er,'error');
								return false;
							}else{
								window.location.reload();
								refresh();
							}
						}
					});
				}
			});
		}
		function toLook(id){
			window.open('${contextPath}/bpm/definition/viewWebflow.action?bpmDefinition.id='+id+'&view=view','流程图例','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		}
	</script>
</body>
</html>
