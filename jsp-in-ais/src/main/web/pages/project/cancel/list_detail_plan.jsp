<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>明细计划列表</title>
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
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form id="searchForm" action="listDetailPlan" namespace="/project/cancel">
			<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:15%">
						计划状态
					</td>
					<td class="editTd" style="width:35%">
					    <select class="easyui-combobox" data-options="panelHeight:'auto'" name="detailPlan.status" style="width:80%;" >
					       <option value="">请选择</option>
					       <s:iterator value="@ais.plan.constants.PlanState@planStateCodeNameMap" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					</td>
					<td class="EditHead" style="width:15%">
						计划编号
					</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="detailPlan.w_plan_code" cssStyle="width:80%"  maxlength="50" />
					</td>
				</tr>
				<%-- <tr>
					<td class="EditHead">
						计划月度
					</td>
					<td class="editTd">
					    <select class="easyui-combobox" name="detailPlan.w_plan_month" style="width:80%;" >
					       <option value="">请选择</option>
					       <option value="1">1</option>
					       <option value="2">2</option>
					       <option value="3">3</option>
					       <option value="4">4</option>
					       <option value="5">5</option>
					       <option value="6">6</option>
					       <option value="7">7</option>
					       <option value="8">8</option>
					       <option value="9">9</option>
					       <option value="10">10</option>
					       <option value="11">11</option>
					       <option value="12">12</option>
					    </select>
					</td>
					<td class="EditHead">
						执行月度
					</td>
					<td class="editTd">
					     <select class="easyui-combobox" name="detailPlan.w_plan_excute_month" style="width:80%" >
					       <option value="">请选择</option>
					       <option value="1">1</option>
					       <option value="2">2</option>
					       <option value="3">3</option>
					       <option value="4">4</option>
					       <option value="5">5</option>
					       <option value="6">6</option>
					       <option value="7">7</option>
					       <option value="8">8</option>
					       <option value="9">9</option>
					       <option value="10">10</option>
					       <option value="11">11</option>
					       <option value="12">12</option>
					    </select>
					</td>
				</tr> --%>
				<tr>
					<td class="EditHead">
						计划名称
					</td>
					<td class="editTd" >
						<s:textfield cssClass="noborder" name="detailPlan.w_plan_name" cssStyle="width:80%"  maxlength="50" />
					</td>
					<%-- <td class="EditHead">
						计划类别
					</td>
					<td class="editTd">
						<select id="plantype" data-options="panelHeight:'auto'" class="easyui-combobox" name="detailPlan.w_plan_type_name" style="width:80%" editable="false">
					       <option value="">请选择</option>
					       <s:iterator value="basicUtil.planTypeList" >
					         <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       </s:iterator>
					    </select>
					</td> --%>
					<td class="EditHead" style="width:15%">
						计划年度
					</td>
					<td class="editTd" style="width:85%" colspan="3">
					    <select id="w_plan_year" class="easyui-combobox" name="detailPlan.w_plan_year" style="width:32%;" >
					       <option value="">请选择</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计单位
					</td>
					<td class="editTd">
						<s:buttonText2 id="detailPlan.audit_dept_name" cssClass="noborder"
							name="detailPlan.audit_dept_name" cssStyle="width:80%"
							hiddenName="detailPlan.audit_dept"
							hiddenId="detailPlan.audit_dept"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'审计单位',
                                  param:{
                                    'p_item':1,
                                    'orgtype':1
                                  }
								})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" maxlength="50" />
					</td>
					<td class="EditHead">
						项目组长
					</td>
					<td class="editTd">
						<s:buttonText2 id="detailPlan.pro_teamleader_name" cssClass="noborder"
							name="detailPlan.pro_teamleader_name" cssStyle="width:80%"
							hiddenId="detailPlan.pro_teamleader"
							hiddenName="detailPlan.pro_teamleader"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  title:'请选择负责人',
                                  type:'treeAndEmployee'
								})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" maxlength="50" />
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
		<table id="detailPlanList"></table>
	</div>
	<script type="text/javascript">
		$(function(){
			showWin('dlgSearch');
			$('#detailPlanList').datagrid({
				url : "<%=request.getContextPath()%>/project/cancel/listDetailPlan.action?querySource=grid",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:true,
				fit:true,
				pageSize: 20,
				idField:'formId',
				fitColumns: true,
				border:false,
				singleSelect:false,
				remoteSort: false,
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
						text:'删除明细计划',
						iconCls:'icon-delete',
						handler:function(){
							deleteDetailPlan();
						}
					},'-',helpBtn
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
	    		columns:[[
	    				{field:'check',width:'50px', checkbox:true,halign:'center',align:'center'},
	       				{field:'status_name',title:'计划状态',width:100,halign:'center',align:'center'},
	       				{field:'w_plan_name',title:'项目计划名称',width:200,halign:'center',align:'left',sortable:true},
	  					{field:'w_plan_year',
	  						 title:'计划年度',
	  						 width:80,
	  						 halign:'center', 
	  						 align:'center', 
	  						 sortable:true
	  					},
	  					{field:'w_plan_code',
			       			title:'计划编号',
			       			width:150,
			       			sortable:true,
			       			halign:'center',
			       			align:'left'
		       			},
	  					{field:'audit_dept_name',
	  						 title:'审计单位',
	  						 width:200,
	  						 halign:'center',
	  						 align:'left', 
	  						 sortable:true
	  					},
	  					{field:'pro_teamleader_name',
	  						 title:'项目组长',
	  						 width:200,
	  						 halign:'center', 
	  						 align:'left', 
	  						 sortable:true
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
	        	$('#detailPlanList').datagrid({
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
				//doSearch();
			}
			/*删除选中的单条计划*/
			function deleteDetailPlan(id){
				var ids=$('#detailPlanList').datagrid('getSelections');
				if(ids.length == 0) {
					showMessage1('请选择要删除的数据！');
					return false;
				}
				var idString = '';
				for(var i=0;i<ids.length;i++){
					idString = idString + ',' + ids[i].formId;
				}
				if(idString != '' ){
					$.messager.confirm("确认",'确定要删除选中的明细计划吗?一旦删除将永远不可恢复，程序开发者不承担任何法律责任!',function(flag){
						if(flag){
							window.location.href="/ais/project/cancel/deleteDetailPlan.action?crudId="+idString;
						}
					})
				}
			}
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('planTable').style.display;
				if(isDisplay==''){
					document.getElementById('planTable').style.display='none';
				}else{
					document.getElementById('planTable').style.display='';
				}
			}
		</script>
	</body>
</html>