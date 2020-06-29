<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目注销</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript">
			function getItem(url,title,width,height){
				$('#item_ifr').attr('src',url);
				$('#subwindow').window({
					title: title,
					width: width,
					height:height,
					modal: true,
					shadow: true,
					closed: false,
					collapsible:false,
					maximizable:false,
					minimizable:false
				});
			}
			function saveF(){
				var ayy = $('#item_ifr')[0].contentWindow.saveF();
				var ay = ayy[0].split(',');
				if(ay.length == 1){
					document.all('pso.pro_type').value=ayy[0];
				}else if(ay.length == 2){
					document.all('pso.pro_type_child').value=ay[0];
					document.all('pso.pro_type').value=ay[1];
				}
	    		document.all('pso.pro_type_name').value=ayy[1];
	    		closeWin();
			}
			function cleanF(){
				document.all('pso.pro_type').value='';
				document.all('pso.pro_type_name').value='';
	    		document.all('pso.pro_type_child').value='';
	    		closeWin();
			}
			function closeWin(){
				$('#subwindow').window('close');
			}
		</script>
<%--		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>--%>
	</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form id="searchForm" action="list" namespace="/project/cancel" method="post">
			<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:15%">项目编号</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="pso.project_code" cssStyle="width:80%" maxlength="50"/>
					</td>
					<td class="EditHead" style="width:15%">项目名称</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="pso.project_name" cssStyle="width:80%" maxlength="50"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">计划类别</td>
					<td class="editTd">
					    <select id="plan_type" class="easyui-combobox" name="pso.plan_type" style="width:80%" panelHeight="auto">
					       <option value="">请选择</option>
					       <s:iterator value="basicUtil.planTypeList" id="entry">
					         <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       </s:iterator>
					    </select>
					</td>
					<td class="EditHead">项目类别</td>
					<td class="editTd">
					        <s:buttonText name="pso.pro_type_name" cssClass="noborder"
								hiddenName="pso.pro_type" cssStyle="width:80%" 
								doubleOnclick="getItem('/pages/basic/code_name_tree_select.jsp','项目类别',500,400)"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" />
							<input type="hidden" name="pso.pro_type_child" value="">
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap="nowrap">某阶段状态</td>
					<td class="editTd">
					    <select id="searchStage" class="easyui-combobox" name="pso.searchStage" style="width:39%" >
					       <option value="">请选择</option>
					       <s:iterator value="@ais.project.ProjectUtil@getProjectAllStageFieldName()" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					    <select id="stageStatus" class="easyui-combobox" name="pso.stageStatus" style="width:39%" >
					       <option value="">请选择</option>
					       <s:iterator value="#@java.util.LinkedHashMap@{'null':'未执行','0':'进行中','1':'已完成'}" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					</td>
					<td class="EditHead">项目年度</td>
					<td class="editTd">
					    <select id="pro_year" class="easyui-combobox" name="pso.pro_year" style="width:80%" >
					       <option value="">请选择</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
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
	<div region="center" >
		<table id="resultList"></table>
	</div>
	<div id="subwindow" class="easyui-window" title="" iconCls="icon-search" style="width:500px;height:500px;padding:5px;" closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
			</div>
			<div region="south" border="false" style="text-align:right;padding:5px 0;">
			    <div style="display: inline;" align="right">
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
					<a class="easyui-linkbutton" iconCls="icon-tip" href="javascript:void(0)" onclick="cleanF()">清空</a>
					<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
			    </div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			showWin('dlgSearch');
			$('#resultList').datagrid({
				url : "<%=request.getContextPath()%>/project/cancel/list.action?querySource=grid",
				method:'post',
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				idField:'formId',
				fitColumns: false,	
				border:false,
				singleSelect:false,
				remoteSort: true,
				toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('dlgSearch');
					}
					},'-',
					{
						id:'newYear',
						text:'删除项目',
						iconCls:'icon-delete',
						handler:function(){
							deleteAllProjectInfo();
						}
					},'-',helpBtn
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				frozenColumns:[[
	       			{field:'formId',width:'50px', checkbox:true,halign:'center',align:'center'},
	       			{field:'status_name',title:'项目状态',width:'80',align:'left',
	       				sortable:true,
						formatter:function(value,row,rowIndex){
							if(row.is_closed=='closed'){
								return '已关闭';
							}else{
								return '正在执行';
							}
	       				}
		       		},
		       		{field:'project_name',
						title:'项目名称',
						width:260,
						halign:'center',
						sortable:true, 
						align:'left'
					}
	       			
	    		]],
	    		columns:[[
	    			{field:'project_code',
		       			title:'项目编号',
		       			width:'200',
		       			halign:'center',
		       			sortable:true,
		       			align:'left'
		       		},
		    		{field:'pro_type_name',
						title:'项目类别',
						width:80,
						halign:'center',
						sortable:true, 
						align:'center'
					},
		    		{field:'audit_dept_name',
						title:'所属单位',
						width:200,
						halign:'center',
						sortable:true, 
						align:'left'
					},
		    		{field:'prepare_closed',
						title:'项目准备',
						width:80,
						halign:'center',
						sortable:true, 
						align:'left',
						sortable:true,
						formatter:function(value,row,rowIndex){
							if(row.prepare_closed=='1'){
								return '已完成';
							}else if(row.prepare_closed=='0'){
								return '正在进行';
							}else{
								return '未执行';
							}
	       				}
					},
		    		{field:'actualize_closed',
						title:'项目实施',
						width:80,
						halign:'center',
						sortable:true, 
						align:'left',
						sortable:true,
						formatter:function(value,row,rowIndex){
							if(row.actualize_closed=='1'){
								return '已完成';
							}else if(row.actualize_closed=='0'){
								return '正在进行';
							}else{
								return '未执行';
							}
	       				}
					},
		    		{field:'report_closed',
						title:'项目终结',
						width:80,
						halign:'center',
						sortable:true, 
						align:'left',
						sortable:true,
						formatter:function(value,row,rowIndex){
							if(row.report_closed=='1'){
								return '已完成';
							}else if(row.report_closed=='0'){
								return '正在进行';
							}else{
								return '未执行';
							}
	       				}
					},
		    		{field:'rework_closed',
						title:'项目整改',
						width:80,
						sortable:true,
						halign:'center', 
						align:'left',
						sortable:true,
						formatter:function(value,row,rowIndex){
							if(row.rework_closed=='1'){
								return '已完成';
							}else if(row.rework_closed=='0'){
								return '正在进行';
							}else{
								return '未执行';
							}
	       				}
					},
		    		{field:'archives_closed',
						title:'项目档案',
						width:80,
						sortable:true,
						halign:'center', 
						align:'left',
						sortable:true,
						formatter:function(value,row,rowIndex){
							if(row.account_closed=='1'){
								return '已完成';
							}else if(row.account_closed=='0'){
								return '正在进行';
							}else{
								return '未执行';
							}
	       				}
					}
				]]
			}); 
		});
	</script>
	<script type="text/javascript">
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#resultList').datagrid({
					queryParams:form2Json('searchForm')
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
				resetForm('searchForm');
				document.getElementsByName("pso.pro_type_name")[0].value = '';
				//doSearch();
			}
			/*删除选中的单条计划*/
			function deleteAllProjectInfo(id){
				var ids=$('#resultList').datagrid('getSelections');
				if (ids.length == 0) {
					showMessage1("请选择要删除的数据！");
					return false;
				}
				var idString = '';
				for(var i=0;i<ids.length;i++){
					idString = idString + ',' + ids[i].formId;
				}
				if(idString != '' ){
					$.messager.confirm("确认",'确定要删除选中的项目吗?一旦删除将永远不可恢复，程序开发者不承担任何法律责任!',function(flag){
						if(flag){
							window.location.href="/ais/project/cancel/delete.action?crudId="+idString;
						}
					})
				}	
			}	
		</script>
	</body>
</html>