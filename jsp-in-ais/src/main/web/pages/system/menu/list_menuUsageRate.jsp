<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>功能菜单使用频率</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	 <div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form id="myform" name="myform">
	         <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead" style="width:20%">
						查询开始时间
					</td>
					<td class="editTd" style="width:30%">
						<input class="noborder easyui-datebox" name="startTime" cssStyle="width:80%" maxlength="50" id="startTime">
					</td>
					<td class="EditHead" style="width:20%">
						查询结束时间
					</td>
					<td class="editTd" style="width:30%">
						<input class="noborder easyui-datebox" name="endTime" cssStyle="width:80%" maxlength="50" id="endTime">
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
	    <div region="center" border='0'>
			<table id="projectList"></table>
		</div>
		<script type="text/javascript">
		var datagrid;

			/*
			* 查询
			*/
			function doSearch(){
				var startTime = $('#startTime').datebox('getValue');
				var endTime = $('#endTime').datebox('getValue');
				if(startTime != '' && endTime != '') {
					if(startTime > endTime) {
						showMessage1("开始时间大于结束时间，请重新输入！");
						return false;
					}
				}
	        	datagrid.datagrid('options').queryParams = form2Json('myform');
				datagrid.datagrid('reload');
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
			//导出全部项目
			function exportAllProject(){
                document.getElementById('myform').action = "<%=request.getContextPath()%>/project/exportProject.action?isCommon=${isCommon}&source=process";
                $('#myform').submit();
            }
            //导出勾选项目
			function exportProject(){
				var rows = datagrid.datagrid("getSelections");
				var ids = [];
				if (rows.length > 0) {
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].formId);
					}
					document.getElementById('myform').action = "<%=request.getContextPath()%>/project/exportProject.action?isCommon=${isCommon}&crudIds="+ids;
                    $('#myform').submit();
				}else{
					showMessage1('请先勾选需要导出的项目');
				}

			}
			$(function(){
				var bodyW = $('body').width();
				showWin('dlgSearch');
			    // 初始化生成表格
				datagrid = $('#projectList').datagrid({
				    url:"<%=request.getContextPath()%>/listMenuUsageRate.action?querySource=grid&floginname=${floginname}",
					queryParams:{
				    	startTime:'${startTime}',
						endTime:'${endTime}'
					},
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize: 20,
    				fitColumns:true,
					idField:'formId',
					border:false,
					remoteSort: false,
				<s:if test="${floginname == null or floginname == ''}">
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
						doCellTipShow('projectList');
					},
				</s:if>
					columns:[[
						/*{field:'formId',hidden:true,halign:'center', align:'center',title:'选择'},*/
						{field:'parentMenuName',title:'所属功能模块',halign:'center',align:'left',sortable:true, width:0.2*bodyW+'px'},
						{field:'menuName',title:'功能菜单',width:0.3*bodyW+'px',sortable:true,halign:'center',align:'left'},
						{field:'clickNum',
							title:'点击次数',
							halign:'center',
							width:0.2*bodyW+'px',
							sortable:true, 
							align:'center'
						}
					]]
				});
				
			});
			function planNameSyOff(title, id, startId, processCode) {
				//var url = "${contextPath}/plan/detail/view.action?crudId=" + id;
				var url = "${contextPath}/plan/detail/viewProcess.action?projectId=" + id + "&startId=" + startId + "&processCode=" + processCode;
				aud$openNewTab("离线-" + title, url, true);
			}

	function compute() {//计算函数

	autoMergeCells("projectList", ['parentMenuName'], "0"); //三个参数分别为：表格id，要合并字段的数组，判断字段（不一样则不合并）

	}

	function autoMergeCells(table_id, field_arr, judge) {
		var rows = $("#" + table_id).datagrid("getRows");
		if (NULL(field_arr) || NULL(rows)) {
			return;
		}
		for (var i = 1; i < rows.length; i++) {
			for (var k = 0; k < field_arr.length; k++) {
				var field = field_arr[k]; //要排序的字段
				if (rows[i][field] == rows[i - 1][field]) { //相邻的上下两行
					if (NOTNULL(judge)) {
						if (rows[i][judge] != rows[i - 1][judge]) {
							break;
						}
					}
					var rowspan = 2;
					for (var j = 2; i - j >= 0; j++) { //判断上下多行内容一样
						if (rows[i][field] != rows[i - j][field]) {
							break;
						} else {
							if (NOTNULL(judge)) {
								if (rows[i][judge] != rows[i - j][judge]) {
									break;
								}
							}
							rowspan = j + 1;
						}
					}
					$("#" + table_id).datagrid('mergeCells', { //合并
						index: i - rowspan + 1,
						field: field,
						rowspan: rowspan
					});
				}
			}
		}
	}

	function NOTNULL(obj) {
		if (typeof (obj) == "undefined" || obj === "" || obj == null || obj == "null") {
			return false;
		}
		return true;
	}
	function NULL(obj) {
		if (typeof (obj) == "undefined" || obj === "" || obj == null || obj == "null") {
			return true;
		}
			return false;
	}
 		</script>
	</body>
</html>
