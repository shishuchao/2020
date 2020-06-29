<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目成员列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!-- <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" /> -->
		<!-- <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" /> -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
 	    <script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script> 
	</head>
	<body style="overflow: auto;">
		<div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="false" style="width:600px;height:300px;overflow:hidden">
			<div class="panel layout-panel layout-panel-center" style="width: 586px; left: 6px; top: 30px;">
			<div region="center" title="" class="panel-body panel-body-noheader layout-body" style="width: 584px; height: 234px;">
			<s:form id="myForm" name="myForm" action="searchEmployee" namespace="/mng/employee">
		  		<s:hidden name="crudId"/>
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead">
							人员特长
						</td>
						<td class="editTd">
							<input id="strongPointCode1" data-options="panelHeight:'auto'" style="width: 150px;">
						  	</input>
						  	<input type="hidden" name="employeeInfo.strongPointCode" id="strongPointCode" reload="true"/>
						</td>
						<td class="EditHead">
							执业资格
						</td>
						<td class="editTd">
							<select editable="false" class="easyui-combobox"
								name="employeeInfo.competenceCode" panelHeight="auto">
							       <option value="">&nbsp;</option>
							       <s:iterator value="basicUtil.competenceList4Search">
					       			<option  value="<s:property value="code"/>"><s:property value="name"/></option>
							       </s:iterator>
						    </select>
							<!--<s:select name="employeeInfo.competenceCode" headerKey="" headerValue="" cssClass="easyui-combobox" list="basicUtil.competenceList4Search" listKey="code" listValue="name"/>-->
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							单位名称
						</td>
						<td class="editTd">
							 <s:buttonText2 id="company" name="employeeInfo.company" cssClass="noborder"
									hiddenId="companyCode" hiddenName="employeeInfo.companyCode"
									doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									  param:{
									   'p_item':1,
									   'orgtype':1
									  },
									  title:'审计单位'
									})"
									doubleSrc="${contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0"
									readonly="true" />
						</td>
						<td class="EditHead">
							人员姓名
						</td>
						<td class="editTd">
							<s:textfield name="employeeInfo.name" cssClass="noborder"/>
						</td>
					</tr>
				<%-- <tr class="listtablehead">
					<td align="left" class="listtabletr11" colspan="1">所在城市</td>
					<td align="left" class="listtabletr22" colspan="1">
						<s:select name="employeeInfo.cityCode"
						list="basicUtil.cityList" listKey="code" listValue="name"
						headerKey="" headerValue="" required="true"/>
					</td>
					<td align="left" class="listtabletr11" >
					人才特长
					</td>
					<td align="left" class="listtabletr22" colspan="1">
						<select id="strongPointCode1" name="employeeInfo.strongPointCode1" style=" height:20px;width:140px;" multiple="multiple">
							<c:forEach items="${basicUtil.specialityList}" var="s">
								<option value='${s.code }'>${s.name }</option>
							</c:forEach>
					  	</select>
					  	<input type="hidden" name="employeeInfo.strongPointCode" id="strongPointCode" />
					</td>
				</tr> --%>
				</table>
			</s:form>
			</div>
			</div>
			<div class="panel layout-panel layout-panel-south" style="width: 586px; left: 6px; top: 266px;">
			<div region="south" border="false" style="text-align: right; padding-right: 20px; width: 566px; height: 26px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
				<div style="display: inline;" align="right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="doReset()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
			</div>
		</div>
		<div region="center" class="easyui-layout" style="height: 100%">
			<div style="padding:0px;margin:0px;">
				<table style="padding:0px;margin:0px;" id="projectMemberTable" cellpadding="0" cellspacing="0" border="1" class="ListTable" align="center">
					<tr>
						<td class="EditHead" style='width:70px;' nowrap>
							<font color=red>*</font>
							分组名称
						</td>
						<td class="editTd" >
					      	<select class="easyui-combobox" editable="false"
								name="groupId" id="groupId" data-options="panelHeight:'auto',onSelect:function(rec){setProRole3(rec)}">
							       <s:iterator value="competenceList" >
					       		   		<option value="<s:property value="code"/>"><s:property value="name"/></option>
							       </s:iterator>
						    </select>
		  					<s:hidden id="zhengTiGroupId" name="integoryId"/>
						</td>
	
						<td class="EditHead">
							<font color=red>*</font>
							项目角色
						</td>
						<td class="editTd">
							 <select class="easyui-combobox" editable="false" name="role" id="role" data-options="editable:false,panelHeight:'auto'"></select>
						</td>
					</tr>
				</table>
			</div>
			<div style="padding:0px;margin:0px;min-height: 100px;height: 90%">
				<table id="resultList"></table>
			</div>
		</div>
		<!-- 
		<div region="center" >
			 <form name="emp" id="emp" action="">
			    <input name="crudId" type="hidden" value="${crudId}" />
				<table id="resultList"></table>
			</form>
		</div>
		-->
		<!-- 
		<div region="south" border="false" style="text-align:right;padding-right:20px;">
			<div style="display: inline;" align="right">
				<a id="searchButton" class="easyui-linkbutton" iconCls="icon-search" href="javascript:void(0)" onclick="freshGrid()">查询</a>
				&nbsp;
				<a id="saveButton" class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="toSave()">确定</a>
				&nbsp;
				<a id="exitButton" class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="window.parent.closedlg(true);">取消</a>
			</div>
		</div>
		-->
		<div id="dlg" class="easyui-dialog" title="对话框" closed="true" modal="true" style="width:800px;height:500px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
		<script type="text/javascript"> 
			$(function(){
				$('#resultList').datagrid({
					url : "${pageContext.request.contextPath}/mng/employee/searchEmployee.action?querySource=grid",
					queryParams : form2Json('myForm'),
					method:'post',
					checkOnSelect: false,
					selectOnCheck: false,
					showFooter:false,
					rownumbers:true,
					pagination:true,
					pageSize: 10,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[
						{
							id:'searchButton',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								freshGrid();
							}
						},
						{
							id:'saveButton',
							text:' 选定',
							iconCls:'icon-ok',
							handler:function(){
								toSave();
							}
						},
						{
							id:'exitButton',
							text:'取消',
							iconCls:'icon-cancel',
							handler:function(){
								window.parent.closedlg(true);
							}
						}
					],
					frozenColumns:[[
						{field:'employeeInfo_ids',title:'选择',checkbox:true, align:'center',width:'3%',
							handler:function(value,row,index){
								//value="${row.id}"
							}
						},
						{field:'name',title:'姓名',halign:'center',align:'left',sortable:true,width:'15%',
							formatter:function(value,row,index){
								if(row.isOutSystem!='Y') {
									return '<a style="color:blue" onclick="showUser(\''+row.sysAccounts+'\');" href="javascript:void(0);">'+value+'</a>&nbsp;';
								}
								return value;
							}
						}
					]],
					columns:[[
						{field:'company',title:'单位名称',width:120,halign:'center',align:'left',width:'20%',sortable:true},
						{field:'projectNames',title:'被抽调项目',width:120,halign:'center',align:'left',width:'62%',sortable:true}
					]]
					/*,loadFilter:function(data){
						if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
							data = {
								total: data.length,
								rows: data
							}
						}
						var dg = $(this);
						var opts = dg.datagrid('options');
						var pager = dg.datagrid('getPager');
						pager.pagination({
							onSelectPage:function(pageNum, pageSize){
								opts.pageNumber = pageNum;
								opts.pageSize = pageSize;
								pager.pagination('refresh',{
									pageNumber:pageNum,
									pageSize:pageSize
								});
								dg.datagrid('loadData',data);
							}
						});
						if (!data.originalRows){
							data.originalRows = (data.rows);
						}
						var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
						var end = start + parseInt(opts.pageSize);
						data.rows = (data.originalRows.slice(start, end));
						return data;
					}*/
				});
				setChoice();

 				var zhengTiGroupId = $('#zhengTiGroupId').val();
 				var groupId = $('#groupId').val();
 				if(zhengTiGroupId == groupId || groupId=='') {
 					$('#role').combobox({
 	 	        		url:'${contextPath}/pages/project/start/member/zhengti.json',
 	 	        	    valueField:'id',
 	 	        	    textField:'text',
 	 	             });
 				} else {
 					$('#role').combobox({
 	 	        		url:'${contextPath}/pages/project/start/member/fenzu.json',
 	 	        	    valueField:'id',
 	 	        	    textField:'text',
 	 	             });
 				}
 				
			});
			function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			function doSearch(){
				var value = $('#strongPointCode1').combobox('getValues');
				$('#strongPointCode').val(value);
	        	$('#resultList').datagrid({
	    			queryParams:form2Json('myForm')
	    		});
				$('#dlgSearch').dialog('close');
	        }
	        function doReset(){//onclick="window.location.href='${pageContext.request.contextPath}/project/getlistMembers.action?crudId=${crudId}'"
				var id=$("#myForm_crudId").val();
				$('#strongPointCode1').combobox('setText','');
				$('#strongPointCode1').combobox('setValue','');
				resetForm('myForm');
				$("#myForm_crudId").val(id);
				doSearch();
			}
			function doCancel(){
				$('#dlgSearch').dialog('close');
			}
			/*
			* 成员信息
			*/
			function showUser(userid) {
				var o=$('#dlg');
				o.dialog({width:800,height:450,maximizable:true,resizable:true,draggable:true,title: '人员信息'});
				o[0].children[0].src='${contextPath}/mng/employee/employeeInfoView.action?queryType=all&ul='+userid;
				o.dialog('open');
			}
			 //设置选项值
		 	function setChoice(){
				// 设置多选框的默认选中项。
				var json = $.parseJSON('${sepJson}');
				$('#strongPointCode1').combobox({
					data:json.sepList,
					valueField:'code',
					textField:'name',
					panelHeight:'auto',
					multiple:true,
					editable:false
				});

			}
			function toSave(){
				var rows = $('#resultList').datagrid('getChecked');
				if (rows.length<=0) {
					window.parent.$.messager.show({
						title:'消息',
						msg:'请选择要保存的审计人员！'
					});
					return;
				}

				var groupId = $('#groupId').combobox('getValue');
				var role = $('#role').combobox('getValue');
				if(null==role || role==''){
					window.parent.$.messager.show({
						title:'提示信息',
						msg:'请选择项目角色！'
					});
					return false;
				}
				
				//var ids=[];
				//for(var i=0;i<rows.length;i++)
				//	ids.push(rows[i].id);
				var ids=rows[0].id;
				var userId = rows[0].sysAccounts;
				for(var i=1;i<rows.length;i++){
					ids += ','+rows[i].id;
					userId += ','+rows[i].sysAccounts;
				}

				$.ajax({
				    url: '<%=request.getContextPath()%>/project/checkPromember.action',
		            data: {"groupId":groupId,"userIds":userId,"proMemberId":"","role":role,"project_id":"${crudId}"},
					type:'post',
					async: false,
					success:function(data){
						if (data == "1"){ 
							var params = {'crudId':'${crudId}','employeeInfo_ids':ids,'role':role,'groupId':groupId};
							$.messager.confirm('确认', '确认保存吗？', function(r){
								if (r){
									jQuery.ajax({
										url:'${contextPath}/project/saveMembers.action',
										type:'POST',
										data:params,
										dataType:'json',
										async:'false',
										success:function(data){
								        	window.parent.closedlg();
										},
										error:function(){
								        	window.parent.closedlg();
										}
									});
								}
							});
						 }else if ( data == "2"){
								window.parent.$.messager.show({
									title:'提示信息',
									msg:data+"项目必须有一个主审人员！"
								});
						 }else{
							window.parent.$.messager.show({
								title:'提示信息',
								msg:data+"同一组只能有一个角色！"
							});
						}
					}
				});
			}
        	function setProRole3(rec){
    			var zhengTiGroupId = $('#zhengTiGroupId').val();
   				var groupId = $('#groupId').combobox('getValue');
   				if(groupId != zhengTiGroupId){
					$('#role').combobox('reload','${contextPath}/pages/project/start/member/fenzu.json');
					$('#role').combobox('setValue', 'zuzhang');
             	}else{
             		$('#role').combobox('reload','${contextPath}/pages/project/start/member/zhengti.json');
             		$('#role').combobox('setValue', 'fuzeren');
             	}
        	}
		</script>
	</body>
</html>