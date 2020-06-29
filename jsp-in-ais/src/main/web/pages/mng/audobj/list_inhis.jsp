<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<head>
<title>内部审计历史</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript">
		function cleanForm(){
            document.getElementsByName("proName")[0].value = "";
           	$("#proTypeCode").combobox('setValue','');
            document.getElementsByName("deptName")[0].value = "";
            document.getElementsByName("proMana")[0].value = "";
		}
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border='0'>
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form namespace="/mng/audobj/object"  action="listinhis"  id="searchForm">
			<%--<s:hidden name="auditingObject.id" id="auditingObject.id"/>
			<s:hidden name="auditingObjectEdit.id" id="auditingObjectEdit.id"/>--%>
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width: 15%">
						项目名称
					</td>
					<td class="editTd" style="width: 35%">
						<s:textfield cssClass="noborder" name="proName" />
					</td>
					<td class="EditHead" style="width: 15%">
						项目类别
					</td>
					<td class="editTd" style="width: 35%">
					<!-- <s:select cssStyle="width:160px;"  name="proTypeCode" list="basicUtil.planProjectTypeList4Search" listKey="code" listValue="name" headerKey="" headerValue=""></s:select> -->
						<select class="easyui-combobox" id="proTypeCode" name="proTypeCode" editable="false">
					       <option value="">&nbsp;</option>
					       <s:iterator value="basicUtil.planProjectTypeList4Search" >
					         <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       </s:iterator>
					    </select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计单位
					</td>
					<td class="editTd">
						<s:buttonText cssStyle="width:80%;"
							name="deptName"
							cssClass="noborder"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
							  title:'请选择审计单位'
							})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							display="true" doubleDisabled="false" />
					</td>
					<td class="EditHead">
						项目组长
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="proMana" />
					</td>
				</tr>
			</table>
			<s:hidden name="status"></s:hidden>
			<s:hidden name="listStatus"/>
			<s:hidden name="auditingObject.id"></s:hidden>
            <s:hidden name="auditingObjectEdit.id"></s:hidden>
		</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="cleanForm()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
	    </div>
	</div>
	<div region="center" border='0'>
		<table id="its"></table>
	</div>
	<script type="text/javascript">

		function doSearch(){
			/*$('#its').datagrid({
				queryParams:form2Json('searchForm')
			});*/
            document.getElementById('searchForm').submit();
			$('#dlgSearch').dialog('close');
		}
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
		$(function(){
			showWin('dlgSearch');
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/mng/audobj/object/listinhis.action?querySource=grid&status=${status}&listStatus=${listStatus}&auditingObject.id=${auditingObject.id}&auditingObjectEdit.id=${auditingObjectEdit.id}&proMana=${proMana}&deptName=${deptName}&proTypeCode=${proTypeCode}&proName=${proName}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				fitColumns: true,
				idField:'id',
				border:false,
				singleSelect:false,
				pageSize:20,
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
				columns:[[
	       			{field:'project_name',title:'项目名称',width:180,halign:'center',align:'left',sortable:true},
	       			{field:'pro_type_name',title:'项目类别',width:150,sortable:true,halign:'center',align:'left'},
					{field:'pro_starttime',
					title:'审计开始日期',
					width:120,
					halign:'center',
					align:'center',
					sortable:true,
					formatter:function(value,rowData,rowIndex){
						if(value!=null){
							return value.substring(0,10);
						}
					}
					},
					{field:'pro_endtime',
						title:'审计结束日期',
						width:120,
						sortable:true,
						halign:'center',
						align:'center',
						formatter:function(value,rowData,rowIndex){
							if(value!=null){
								return value.substring(0,10);
							}
						}
					},
					{field:'audit_dept_name',
						 title:'审计单位',
						 width:180,
						 halign:'center',
						 align:'left',
						 sortable:true
					},
					{field:'pro_teamleader_name',
						 title:'项目组长',
						 width:100,
						 halign:'center',
						 align:'left',
						 sortable:true
					}
				]]
			});
		});
	</script>

</body>
</html>
