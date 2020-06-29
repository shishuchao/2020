<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计问题多维统计分析</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<style>
		.multiSelectOptions {
			height:150px
		}
	</style>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="proSituation" class="searchWindow">
	<div class="search_head" id="">
		<s:form id="searchForm" action="multiDemensionResults" namespace="/project" method="post">
			<table id="searchTable" cellpadding=0 border=0 class="ListTable" align="center">
				<tr>
					<td align="left" class="EditHead">审计单位</td>
					<td align="left" class="editTd">
						<s:buttonText2 id="audit_dept_name"  cssClass="noborder"
									   name="wpd.audit_dept_name"
									   hiddenId="audit_dept" hiddenName="wpd.audit_dept"
									   doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										   param:{
												'p_item':3
										},
										  title:'请选择审计单位',
										   checkbox:true
										})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
					<td align="left" class="EditHead">项目年度</td>
					<td align="left" class="editTd">
						<select id="w_plan_year1" multiple="multiple" editable="false">
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
								<s:if test="${key == year}">
									<option value="${key}" selected="selected">${value}</option>
								</s:if>
								<s:else>
									<option value="${key}">${value}</option>
								</s:else>
							</s:iterator>
						</select>
						<input type="hidden" id="w_plan_year" name="wpd.w_plan_year"/>
					</td>
				</tr>
				<tr>
					<td align="left" class="EditHead">项目名称</td>
					<td align="left" class="editTd">
						<input type="text" name="wpd.w_plan_name" id="w_plan_name" class="noborder">
					</td>
					<td align="left" class="EditHead">快捷选择</td>
					<td align="left" class="editTd">
						<select id="select_all1" multiple="multiple" editable="false">
							<s:iterator value="#@java.util.LinkedHashMap@{'audit_dept_name':'审计单位','pro_year':'项目年度','project_name':'项目名称'}">
								<option value="${key}">${value}</option>
							</s:iterator>
						</select>
						<input type="hidden" id="select_all" name="select_all"/>
					</td>
				</tr>
			</table>
		</s:form>
	</div>
	<div class="serch_foot">
		<div class="search_btn">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetDoubtList()">重置</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#proSituation').window('close')">取消</a>
		</div>
	</div>
</div>
<div region="center">
	<table id="dataList"></table>
	<div id="buttonDiv" align="right" style="width: 97%">
		<s:if test="${baseHelper.totalRows>0}">
			<input id="exportButton" type="button" value="导出" onclick="showPopWin('${contextPath}/pages/project/start/countColumnSelector.jsp',500,400)"/>
		</s:if>
	</div>
</div>
<div id="proName" title="项目作业信息" style="overflow:hidden;padding:0px">
	<iframe id="showProName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
</div>
<div id="commonPage"></div>
<script type="text/javascript">
	function execExport(){
		document.getElementById("searchForm").action="multiDemensionResults.action?querySource=grid&isExport=y";
		document.getElementById("searchForm").submit();
	}

	//重置查询条件
	function resetDoubtList(){
		$('#audit_dept_name').val('');
		$('#audit_dept').val('');
		$('#w_plan_name').val('');
		$('#w_plan_year').val('');
		$('#select_all').val('');
		$("input[type='checkbox']:checked").prop('checked','');
		$('#w_plan_year1 span').html('');
		$('#select_all1 span').html('');
	}


	//查询
	function doSearch(){
		showOrHide();
		$('#dataList').datagrid({
			queryParams:form2Json('searchForm')
		});
		$('#proSituation').window('close');
	}

	function showOrHide() {
		var select_all = $('#select_all').val();
		var audit_dept_name = $('#audit_dept_name').val();
		if(audit_dept_name != '' || select_all.indexOf("audit_dept_name") > -1){
			$('#dataList').datagrid('showColumn','audit_dept_name');
		}else{
			$('#dataList').datagrid('hideColumn','audit_dept_name');
		}

		var pro_year = $('#w_plan_year').val();
		if(pro_year != '' || select_all.indexOf("pro_year") > -1) {
			$('#dataList').datagrid('showColumn','pro_year');
		} else {
			$('#dataList').datagrid('hideColumn','pro_year');
		}

		var project_name = $('#w_plan_name').val();
		if(project_name != '' || select_all.indexOf("project_name") > -1) {
			$('#dataList').datagrid('showColumn','project_name');
		} else {
			$('#dataList').datagrid('hideColumn','project_name');
		}
	}

	$(function(){
		$('#audit_dept_name').val("${user.fdepname}");
		$('#audit_dept').val("${user.fdepid}");

		var bodyW = $('body').width();
		//查询
		showWin('commonPage','公用弹窗页面');
		showWin('proSituation');
		// 初始化生成表格
		$('#dataList').datagrid({
			url : "<%=request.getContextPath()%>/project/multiDemensionResults.action?querySource=grid",
			queryParams:{
				'wpd.audit_dept':'${user.fdepid}',
				'wpd.w_plan_year':'${year}'
			},
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:false,
			striped:true,
			autoRowHeight:false,
			fit: true,
			pageSize:20,
			fitColumns: false,
			idField:'id',
			border:false,
			singleSelect:true,
			remoteSort: false,
			toolbar:[{
				id:'searchObj',
				text:'查询',
				iconCls:'icon-search',
				handler:function(){
					searchWindShow('proSituation',750,300);
				}
			},'-',
				{
					id:'toWord',
					text:'导出',
					iconCls:'icon-export',
					handler:function(){
						execExport();
					}
				},'-',helpBtn],
			onLoadSuccess:function(){
				initHelpBtn();
			},
			frozenColumns:[[
				{field:'project_name',
					title:'项目名称',
					width:bodyW * 0.2 + 'px',
					halign:'center',
					align:'left',
					sortable:true,
					hidden:true
				},
				{field:'audit_dept_name',
					title:'审计单位',
					width:bodyW * 0.1 + 'px',
					halign:'center',
					align:'left',
					hidden:false
				},

				{field:'pro_year',
					title:'项目年度',
					width:bodyW * 0.1 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					hidden:false,
				}
			]],
			columns:[[
				{field:'problemNum',
					title:'审计发现问题数量',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if(value == null) {
							return '0';
						}else{
							var url = '<a href="javascript:;" onclick="openNew(\'审计发现问题\',\''+rowData.problemNumKey+'\')">'+value+'</a>';
							return url;
						}
					}
				},
				{field:'mendProNum',
					title:'已整改问题数量',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if(value == null) {
							return '0';
						}else{
							var url = '<a href="javascript:;" onclick="openNew(\'已整改问题\',\''+rowData.mendProNumKey+'\')">'+value+'</a>';
							return url;
						}
					}
				},
				{field:'notMendProNum',
					title:'未整改完的问题数',
					width:bodyW * 0.08 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if(value == null) {
							return '0';
						}else{
							var url = '<a href="javascript:;" onclick="openNew(\'未整改完的问题\',\''+rowData.notMendProNumKey+'\')">'+value+'</a>';
							return url;
						}
					}
				},
				/*{field:'mendRate',
                     title:'整改完成率',
                     width:bodyW * 0.08 + 'px',
                     halign:'center',
                     align:'center',
                     sortable:true,
                     hidden:true,
                     formatter:function(value,rowData,rowIndex){
                         if(value == null) {
                             return '0';
                         }else{
                             return value;
                         }
                     }
                },*/
				{field:'suggestNum',
					title:'提出审计建议(条)',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if(value == null) {
							return '0';
						}else{
							var url = '<a href="javascript:;" onclick="openNew(\'提出审计建议\',\''+rowData.suggestNumKey+'\')">'+value+'</a>';
							return url;
						}
					}
				},
				{field:'acceptSugNum',
					title:'采纳审计建议(条)',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if(value == null) {
							return '0';
						}else{
							var url = '<a href="javascript:;" onclick="openNew(\'采纳审计建议\',\''+rowData.acceptSugNumKey+'\')">'+value+'</a>';
							return url;
						}
					}
				},
				{field:'wgwjje',
					title:'查出违纪违规金额（万元）',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if (value != null && value != "") {
							value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
							return value;
						}
						else return "0.00";
					}
				},
				{field:'yjzwjwgje',
					title:'已纠正违纪违规金额（万元）',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if (value != null && value != "") {
							value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
							return value;
						}
						else return "0.00";
					}
				},
				{field:'increase_money',
					title:'促进增收节支（万元）',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if (value != null && value != "") {
							value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
							return value;
						}
						else return "0.00";
					}
				},
				{field:'loss_money',
					title:'查出损失浪费（万元）',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if (value != null && value != "") {
							value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
							return value;
						}
						else return "0.00";
					}
				},
				{field:'qtgrbddl',
					title:'清退个人不当得利（万元)',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if (value != null && value != "") {
							value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
							return value;
						}
						else return "0.00";
					}
				},
				{field:'bjglsk',
					title:'补缴各类税款（万元）',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if (value != null && value != "") {
							value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
							return value;
						}
						else return "0.00";
					}
				},
				{field:'improveRegulation',
					title:'修订规章制度(项)',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'newRegulation',
					title:'新制定规章制度(项)',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'punishPersonEconomic',
					title:'给予经济处罚(人次)',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'punishPersonLaw',
					title:'党纪政纪处理(人次)',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true
				},
				{field:'punishPersonGov',
					title:'移送司法机关(人次)',
					width:bodyW * 0.11 + 'px',
					halign:'center',
					align:'center',
					sortable:true
				}
			]]
		});
		$("#w_plan_year1").multiSelect({
			selectAll: false,
			oneOrMoreSelected: '*',
			selectAllText: '全选',
			noneSelected: '',
			listWidth:'175'
		}, function(){   //回调函数
			$('#w_plan_year').attr('name','wpd.w_plan_year').val($("#w_plan_year1").selectedValuesString());
		});

		$("#select_all1").multiSelect({
			selectAll: false,
			oneOrMoreSelected: '*',
			selectAllText: '全选',
			noneSelected: '',
			listWidth:'175'
		}, function(){   //回调函数
			$('#select_all').attr('name','select_all').val($("#select_all1").selectedValuesString());
		});

		//单元格tooltip提示
		$('#dataList').datagrid('doCellTip', {
			onlyShowInterrupt:true,
			position : 'bottom',
			maxWidth : '200px',
			tipStyler : {
				'backgroundColor' : '#EFF5FF',
				borderColor : '#95B8E7',
				boxShadow : '1px 1px 3px #292929'
			}
		});
	});
	function proName(id,stage){
		window.open(
				'${contextPath}/project/prepare/projectIndex.action?crudId='
				+ id + '&stage=' + stage + '&source=view&projectview=view&isView=2&view=view', '',
				'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	$('#proName').window({
		width:950,
		height:450,
		modal:true,
		fit:true,
		collapsible:false,
		maximizable:true,
		minimizable:false,
		closed:true
	});
	function toWord(){
		var url = '${contextPath}/pages/project/start/countColumnSelector.jsp';
		showWinIf('commonPage',url,'选择窗口',530,400);
	}

	function openNewProject(typeName, key) {
		var url = '${contextPath}/project/displayDetail01.action?key=' + key.replaceAll('#', ',');
		aud$openNewTab(typeName, url ,false);
	}

	function openNew(typeName, key) {
		var keyVal = encodeURI( key.replaceAll('#', '!'));
		var url = '${contextPath}/project/displayProblems.action?key=' + keyVal;
		aud$openNewTab(typeName, url ,false);
	}
</script>
</body>
</html>