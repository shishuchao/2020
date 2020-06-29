<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title></title>
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
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>
</head>
	<body>
		<div id="proSituation" class="searchWindow">
			<div class="search_head">
			<s:form id="searchForm" action="createTabs" namespace="/proledger/custom" method="post">
				<table id="searchTable" cellpadding=0 border=0 class="ListTable" align="center">
					<tr>
						<td align="left" class="EditHead" style="width:15%">项目编号：</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="p_code" cssClass="noborder" maxlength="50" cssStyle="width:80%"/>
						</td>
						<td align="left" class="EditHead" style="width:15%">项目名称：</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="p_name" cssClass="noborder" maxlength="50" cssStyle="width:80%"/>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">被审计单位：</td>
						<td align="left" class="editTd">
							<s:buttonText2 cssStyle="width:80%;" hiddenId="audited_code_name" cssClass="noborder"
								id="audited_code" name="audited_code"
								hiddenName="audited_code_name"
								doubleOnclick="showSysTree(this,{url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
																  param:{'departmentId':'${organization.fid}'},
																  cache:false,
																  checkbox:true,
																  title:'请选择被审计单位'
																})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								title="被审计单位" maxlength="1500" />
						</td>
						<td align="left" class="EditHead">项目年度：</td> 
						<td align="left" class="editTd">
							<select id="" class="easyui-combobox" name="p_year" editable="false" style="width:80%" panelHeight="auto">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select> 
						</td>		
					</tr>
					<tr>
						<td align="left" class="EditHead">项目类别：</td>
						<td align="left" class="editTd">
							<select id="select2" class="easyui-combobox" name="pro_type" style="width:80%" panelHeight="auto">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
						         <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       </s:iterator>
							</select>
							
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
	<table id="dataList"></table>
	<div id="commonPage"></div>
	<script type="text/javascript">
	$(function(){
		showWin('proSituation');
		showWin('commonPage','公用弹窗页面');
		// 初始化生成表格
		$('#dataList').datagrid({
			url : "<%=request.getContextPath()%>/proledger/custom/list.action?querySource=grid",
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			pageSize: 20,
			fitColumns:true,
			idField:'id',	
			border:false,
			singleSelect:true,
			remoteSort: false,
			toolbar:[{
						id:'searchObj',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('proSituation',900);
						}
					},
					{
						id:'toWord',
						text:'导出',
						iconCls:'icon-export',
						handler:function(){
							toWord();
						}
					}],
			columns:[[
				{field:'', title:'项目信息',rowspan:1,colspan:6, align:'center', show:'true'}, 
				{field:'', title:'项目投入人天数',rowspan:1,colspan:3, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'},  
				{field:'', title:'审计建议/处理意见',rowspan:1,colspan:4, align:'center', show:'true'},
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}, 
				{field:'', title:'',rowspan:1,colspan:1, align:'center', show:'true'}],
			   [{field:'pro_code', title:'项目编号', align:'center', show:'true'},
			    {field:'pro_name', title:'项目名称', align:'left', show:'true',
					formatter:function(value,rowData,rowIndex){
						return '<a href=\"javascript:void(0)\" onclick=\"proName(\''+rowData.formId+'\');\">'+value+'</a>';
					}
			    },
			    {field:'pro_year', title:'项目年度', align:'center', show:'true'},
			    {field:'pro_type', title:'项目类别', align:'center', show:'true'},
			    {field:'audit_dept_name', title:'审计单位', align:'center', show:'true'},
			    {field:'audit_object_name', title:'被审计单位', align:'center', show:'true'},
			    {field:'xmrs', title:'项目人数', align:'center', show:'true'},
			    {field:'xmts', title:'项目天数', align:'center', show:'true'},
			    {field:'rtshj', title:'人天数合计', align:'center', show:'true'},
			    {field:'sjwt', title:'审计问题（条数）', align:'center', show:'true'},
			    {field:'sjwtje', title:'审计问题金额（万元）', align:'center', show:'true'},
			    {field:'ccsslf', title:'查出损失浪费（万元）', align:'center', show:'true'},
			    {field:'zjxy', title:'增加收益（万元）', align:'center', show:'true'},
			    {field:'dayaxs', title:'发现大案要案线索（条数）', align:'center', show:'true'},
			    {field:'tczgjy', title:'提出整改建议', align:'center', show:'true'},
			    {field:'jybcn', title:'建议被采纳', align:'center', show:'true'},
			    {field:'clyj', title:'提出处理建议', align:'center', show:'true'},
			    {field:'yjbcn', title:'意见被采纳', align:'center', show:'true'},
			    {field:'xzcf', title:'行政处分（条数）', align:'center', show:'true'},
			    {field:'jjcf', title:'经济处分（人）', align:'center', show:'true'},
			    {field:'ysjjjccl', title:'移送纪检监察处理（人）', align:'center', show:'true'},
			    {field:'yssfjgaj', title:'移送司法机关案件（件）', align:'center', show:'true'},
			    {field:'yssfjgcl', title:'移送司法机关（人）', align:'center', show:'true'}]
			]
		}); 
	});
	//重置查询条件
	function resetDoubtList(){
		resetForm('searchForm');
		//doSearch();
	}
	function proName(id){
		window.open(
				'${contextPath}/project/prepare/projectIndex.action?crudId='
						+ id + '&stage=1&source=view&projectview=view&isView=2&view=view', '',
						'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	//查询
	function doSearch(){
	    $('#dataList').datagrid({
	    	queryParams:form2Json('searchForm')
	    });
	    $('#proSituation').window('close');
	}
	function toWord(){
		var url = '${contextPath}/pages/ledger/columnSelector.jsp';
		showWinIf('commonPage',url,'选择窗口',530,400);
	}	
	function exportExcel(columns){
		document.getElementById("searchForm").action="load.action?"+columns;
		document.getElementById("searchForm").target="_blank";
		document.getElementById("searchForm").submit();
		document.getElementById("searchForm").action="list.action";
		document.getElementById("searchForm").target="_self";
	}
	</script>
	</body>
</html>