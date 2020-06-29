<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<head>
<title>被审计单位整改反馈</title>
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
<%--	<style type="text/css">
		.datagrid-cell-rownumber {
			height:21px !important;
		}
	</style>--%>
	<script type="text/javascript">
		function cleanForm(){
			$("#searchForm .editTd").find("input,select").val(null);
			//document.forms[0].action="${contextPath}/project/rework/listAllForAuditObject.action";
			//document.forms[0].submit();
		}
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border='0'>
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form namespace="/project/rework"  action="listAllForAuditObject"  id="searchForm">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width: 15%">
						<s:if test="${en eq 'en'}">
							Project Name
						</s:if>
						<s:else>
							项目名称
						</s:else>
					</td>
					<td class="editTd" style="width: 35%">
						<s:textfield cssClass="noborder" name="proName" />
					</td>
					<td class="EditHead" style="width: 15%">
						<s:if test="${en eq 'en'}">
							Project Type
						</s:if>
						<s:else>
							项目类别
						</s:else>
					</td>
					<td class="editTd" style="width: 35%">
					<!-- <s:select cssStyle="width:160px;" name="proTypeCode" list="basicUtil.planProjectTypeList4Search" listKey="code" listValue="name" headerKey="" headerValue=""></s:select> -->	
						<select class="easyui-combobox" name="proTypeCode" editable="false">
					       <option value="">&nbsp;</option>
					       <s:iterator value="basicUtil.planProjectTypeList4Search" >
					         <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       </s:iterator>
					    </select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						<s:if test="${en eq 'en'}">
							Audit Department
						</s:if>
						<s:else>
							审计单位
						</s:else>
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="deptName" />
					</td>
					<td class="EditHead">
						项目年度
					</td>
					<td class="editTd">
						<select id="searchForm_proYear" class="easyui-combobox" name="proYear"  overflow：auto  style="width:150px;" data-options="panelHeight:'150px',editable:false">
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)">
								<s:if test="${proYear==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
							</s:iterator>
						</select>

						<%--<input type="text" id="searchForm_proYear" name="proYear" editable="false" Class="easyui-datebox noborder"/>--%>
					</td>
					<%-- <td class="EditHead">
						项目负责人
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="proMana" />
					</td> --%>
				</tr>
			</table>
			<s:hidden name="status"></s:hidden>
			<s:hidden name="listStatus"/>
			<s:hidden name="auditingObject.id"></s:hidden>
		</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">
					<s:if test="${en eq 'en'}">
						Query
					</s:if>
					<s:else>
						查询
					</s:else>
				</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="cleanForm()">
					<s:if test="${en eq 'en'}">
						Reset
					</s:if>
					<s:else>
						重置
					</s:else>
				</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">
					<s:if test="${en eq 'en'}">
						Cancel
					</s:if>
					<s:else>
						取消
					</s:else>
				</a>
			</div>
	    </div>
	</div>
	<div region="center" border='0'>
		<table id="its"></table>
	</div>
	<script type="text/javascript">
		
		function doSearch(){
			$('#its').datagrid({
				queryParams:form2Json('searchForm')
			});
			$('#dlgSearch').dialog('close');
		}
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
		$(function(){
			if('${empty proYear}'=='true'){
				var d = new Date();
				$('#searchForm_proYear').combo('setValue',d.getFullYear());
				$('#searchForm_proYear').combo('setText',d.getFullYear());
			}
			showWin('dlgSearch');
			var en = '${en}' == 'en';
			var bodyW = $('body').width();
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/project/rework/listAllForAuditObjectUp.action?querySource=grid",
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
						text:en ? 'Query':'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					}			
				],
				columns:[[  
	       			{field:'project_name',title:en ? 'Project Name':'项目名称',width:bodyW * 0.4 + 'px',halign:'center',align:'left',sortable:true},
	       			{field:'pro_year',title:en ? 'Year':'项目年度',width:bodyW * 0.05 + 'px',sortable:true,halign:'center',align:'center'},
					{field:'audit_dept_name',
						 title:en ? 'Audit Department':'审计单位',
						 width:bodyW * 0.2 + 'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'audit_object_name',
						title:en ? 'Auditee':'被审计单位',
						width:bodyW * 0.2 + 'px',
						halign:'center',
						align:'left',
						sortable:true/* ,
						formatter:function(value,rowData,rowIndex){
							if(value!=null){
								return value.substring(0,10);
							}
						} */
					},
					{field:'operate',
						 title:en ? 'Operation':'操作',
						 halign:'center',
						 align:'center', 
						 width:bodyW * 0.05 + 'px',
						 sortable:false,
						 formatter:function(value,row,index){
						 	 var param = [row.formId,row.pro_type,row.pro_type_child];
							 var btn2 = (en ? 'Edit,updateRework,':"添加资料,updateRework,")+param.join(',');
							 return ganerateBtn(btn2);
						 }
					}
				]]   
			});

			// 初始化项目年度控件
			/*$("#searchForm_proYear").datebox({
				formatter: function(date) {
					return date.getFullYear() + '';
				},
				parser: function (str) {
					var t = Date.parse(str);
					if (!isNaN(t)){
						return new Date(t);
					} else {
						return new Date();
					}
				},
				onShowPanel : function() {
					$('.calendar-title span').click()
				},
			});*/
		});
		function updateRework(formId,pro_type,pro_type_child){
			window.location.href="${contextPath}/auditAccessoryList/list.action?en=${en}&view=list&cruProId="+formId+"&pro_type="+pro_type+"&pro_child_type="+pro_type_child;
		}
	</script>	
	
</body>
</html>
 