<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计人员信息表</title>
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
	</head>
<body  style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
			<div class="search_head">	
		<s:form namespace="/mng/employee" action="employeeInfoList4Dept.action" name="myform" id="myform">
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width: 15%">
						姓名
					</td>
					<td class="editTd" style="width: 35%">
						<s:textfield cssClass="noborder" name="employeeInfo.name" maxlength="50" />
					</td>
					<td class="EditHead" style="width: 15%">
						学历
					</td>
					<td class="editTd" style="width: 35%">
						<select editable="false" name="employeeInfo.diplomaCode" class="easyui-combobox" PanelHeight="auto">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.diplomaList4Search" id="enitty">
									 <option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						职称级别
					</td>
					<td class="editTd">
						<select editable="false" name="employeeInfo.technicalPostCode" class="easyui-combobox" PanelHeight="auto">
									<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.technicalPostList4Search" id="enitty">
									 <option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
						</select>
					</td>
					<td class=EditHead>
						专业
					</td>
					<td class=editTd>
						<select editable="false" name="employeeInfo.specialityCode" class="easyui-combobox" PanelHeight="auto">
									<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.specialtyList4Search" id="enitty">
									 <option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td class="EditHead" id="company1">
						所属单位
					</td>
					<td class="editTd" id="company2">
					        <s:buttonText2 cssClass="noborder" id="company" readonly="true" name="employeeInfo.company" hiddenName="employeeInfo.companyCode" hiddenId="companyCode" doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
										  title:'请选择审计单位'
										})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" maxlength="50" />
						   
					</td>
					<td class=EditHead>
						职务
					</td>
					<td class=editTd>
						<select editable="false" name="employeeInfo.dutyCode" class="easyui-combobox" PanelHeight="auto">
									<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.dutyList4Search" id="enitty">
									  <option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						职业资格
					</td>
					<td class=editTd>
						<select editable="false" name="employeeInfo.competenceCode" class="easyui-combobox" PanelHeight="auto">
									<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.competenceList4Search" id="enitty">
									  <option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
						</select>
					</td>
					<td class=EditHead style="width: 16%">
						从事审计日期
					</td>
					<td class=editTd>
					<input type="text" maxlength="50"  editable="false" class="easyui-datebox noborder" name="employeeInfo.beginWorkDate" title="单击选择日期"/>
					</td>
				</tr>
				<tr>
					<td class=EditHead>
						出生日期
					</td>
					<td class=editTd>
					<input type="text" editable="false" maxlength="50"  class="easyui-datebox noborder" name="employeeInfo.birthday" title="单击选择日期"/>
					</td>
					<td  class=EditHead >
						人员类型
					</td>
					<td class="editTd" align="left" >
						<select editable="false" name="employeeInfo.typeCode" class="easyui-combobox" PanelHeight="auto">
								<option >&nbsp;</option>
								<s:iterator value="basicUtil.typeList" >
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
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
	    </div>
	</div>
	<div region="center" >
		<table id="list"></table>
	</div>
</body>
<script type="text/javascript">
	function doSearch(){
	  	$('#list').datagrid({
			queryParams:form2Json('myform')
		});
	  	$('#dlgSearch').dialog('close');
	}
	function restal(){
		resetForm('myform');
		//doSearch();
	}
	function doCancel(){
		$('#dlgSearch').dialog('close');
	}
	$(function(){
		showWin('dlgSearch');
		// 初始化生成表格
		$('#list').datagrid({
			url : "<%=request.getContextPath()%>/mng/employee/employeeInfoList4Dept.action?querySource=grid",
            queryParams:{'employeeInfo.companyCode':'${employeeInfo.companyCode}'},
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit:true,
			pageSize:20,
			fitColumns: false,
			idField:'row',
			border:false,
			singleSelect:true,
			remoteSort: false,
			toolbar:[
				{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('dlgSearch');
					}
				}
			],
			frozenColumns:[[
       			{field:'row',width:'50px', hidden:true,halign:'center',align:'center'},
       			{field:'name',title:'姓名',width:60,halign:'center',align:'left',sortable:true,
       				formatter:function(value,row,index){
       					return '<a href="${contextPath}/mng/employee/employeeInfoView.action?listStatus=${listStatus}&btnReturn&employeeInfo.id='+row.id+'" >'+row.name+'</a>';
       				}
	       		},
       			{field:'sex',title:'性别',width:40,sortable:true,halign:'center',align:'center'}
    		]],
			columns:[[  
				{field:'birthday',
					title:'出生日期',
					width:100,
					halign:'center',
					align:'center', 
					sortable:true
				},
				{field:'speciality_high',
					title:'最高学历所学专业',
					width:100,
					halign:'center',
					sortable:true, 
					align:'left'
				},
				{field:'diploma',
					 title:'最高学历',
					 width:80,
					 halign:'center', 
					 align:'center', 
					 sortable:true
				},
				{field:'technicalPost',
					 title:'职称级别',
					 width:80,
					 halign:'center',
					 align:'center', 
					 sortable:true
				},
				{
					field: 'qualification_names',
					title: '职业资质',
					width: 150,
					halign: 'center',
					align: 'center'
				},

                {field:'type',
                    title:'人员类型',
                    width:100,
                    halign:'center',
                    align:'left',
                    sortable:true
                },

				{field:'company',
					 title:'所属单位',
					 width:180, 
					 halign:'center',
					 align:'left',  
					 sortable:true
				},
				{field:'duty',
					 title:'职位',
					 width:80, 
					 halign:'center',
					 align:'center', 
					 sortable:true
				},
				{field:'isSysAccounts',
					 title:'是否为外部审计人才',
					 width:180,
					 halign:'center', 
					 align:'center', 
					 sortable:true
				},
				{field:'year_from_joinCorpDate',
					 title:'从事审计日期',
					 width:150, 
					 halign:'center',
					 align:'center', 
					 sortable:true,
					formatter: function (value, rowData) {
						value = rowData.joinCorpDate;
						if (value) {
							var now = new Date();
							var joinCorpDate = new Date(value);
							if (now.getTime() - joinCorpDate.getTime() > 1000 * 60 * 60 * 24) {
								var diff = diffDate(joinCorpDate, now);
								var text = '';
								if (diff.y && diff.y > 0) {
									text += diff.y + '年';
								}
								if (diff.m && diff.m > 0) {
									text += diff.m + '月'
								}
								if (diff.d && diff.d > 0) {
									text += diff.d + '天'
								}
								return text;
							}
						}
						return '';
					}
				}
			]]   
		}); 
	});
	function onloadF(id){
		var url="${contextPath}/mng/employee/employeeInfoView.action?employeeInfo.id="+id+"&listStatus=${listStatus}&btnReturn";
		window.location.href=url;
	}
	function diffDate(sDate1,sDate2){
		var result = {};
		var days1 = (sDate1.getTime() / 3600000 / 24).toFixed();
		var days2 = (sDate2.getTime() / 3600000 / 24).toFixed();
		var diff = days2 - days1;

		if (diff > 0) {
			result.y = (diff / 365).toFixed();
			result.m = (diff % 365 / 30).toFixed();
			result.d = diff % 365 % 30;
		}
		return result;
	}
</script>
</html>
