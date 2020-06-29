<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目计划列表</title>
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
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="true"  style="width:700px;height:300px;overflow:hidden">
			<div class="panel layout-panel layout-panel-center" style="width: 686px; left: 6px; top: 30px;">
			<div region="center" title="" class="panel-body panel-body-noheader layout-body" style="width: 684px; height: 234px;">
			 <s:form id="selectForm" name="selectForm" action="listAll" namespace="/plan/detail">
				<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">
							计划名称
						</td>
						<td class="editTd" >
							<s:textfield cssClass="noborder" name="crudObject.w_plan_name" cssStyle="width:80%"  maxlength="50" />
						</td>
						<td class="EditHead" style="width:15%">
							计划编号
						</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="crudObject.w_plan_code" cssStyle="width:80%" maxlength="50"   />
						</td>
					</tr>
					<tr class="listtablehead" height="23">
						<td class="EditHead">
							计划月度
						</td>
						<td class="editTd">
						    <select class="easyui-combobox" name="crudObject.w_plan_month" style="width:80%"  editable="false">
						       <option value="">&nbsp;</option>
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
						    <select class="easyui-combobox" name="crudObject.w_plan_excute_month" style="width:80%"  editable="false">
						       <option value="">&nbsp;</option>
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
					</tr>
					<tr height="23">
						<td class="EditHead" style="width:15%">
							计划状态
						</td>
						<td class="editTd" style="width:35%">
						    <select class="easyui-combobox" name="crudObject.status" style="width:80%" editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.plan.constants.PlanState@planStateCodeNameMap" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select>
						</td>
						<td class="EditHead">
							计划类别
						</td>
						<td class="editTd">
						    <select class="easyui-combobox" name="crudObject.w_plan_type_name" style="width:80%" editable="false">
						       <option value="">&nbsp;</option>
						       <option value="年度计划">年度计划</option>
						       <option value="临时计划">临时计划</option>
						    </select>
						</td>
					</tr>
					<tr class="listtablehead" height="23">
						<td class="EditHead">
							计划年度
						</td>
						<td class="editTd" >
						    <select id="w_plan_year" class="easyui-combobox" style="width:80%" name="crudObject.w_plan_year"  editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select> 
						</td>
						<td class="EditHead">
							审计单位
						</td>
						<td class="editTd">
							<s:buttonText2 id="crudObject.audit_dept_name" cssClass="noborder"
								name="crudObject.audit_dept_name" readonly="true" cssStyle="width:80%"
								hiddenName="crudObject.audit_dept"
								hiddenId="crudObject.audit_dept"
								doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									  title:'请选择审计单位',
	                                  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  }
									})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" maxlength="50" />
						</td>
					</tr>
					<tr class="listtablehead" >
						<td class="EditHead" style="width:15%">
							负责人
						</td>
						<td class="editTd" style="width:85%" colspan="3">
							<s:buttonText2 id="crudObject.pro_teamleader_name" cssClass="noborder"
								name="crudObject.pro_teamleader_name" readonly="true" cssStyle="width:32%"
								hiddenId="crudObject.pro_teamleader"
								hiddenName="crudObject.pro_teamleader"
								doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
	                                  param:{
	                                     'p_item':1,
	                                     'orgtype':1
	                                  },
	                                  title:'请选择负责人',
	                                  type:'treeAndEmployee'
									})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" maxlength="50" />
						</td>
					</tr>
				</table>
			</s:form>
			</div>
			</div>
			<div class="panel layout-panel layout-panel-south" style="width: 686px; left: 6px; top: 266px;">
			<div region="south" border="false" style="text-align: right; padding-right: 20px; width: 666px; height: 26px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
				<div style="display: inline;" align="right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
			</div>
	    </div>
	    <div region="center" >
			<table id="resultList"></table>
		</div>
		<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
			<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>

		<script type="text/javascript">
	        function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#resultList').datagrid({
	    			queryParams:form2Json('selectForm')
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
				resetForm('selectForm');
				doSearch();
			}
			/*
				计划处理
			*/
			function process(param){
				var ids = document.getElementsByName("detail_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						window.location.href="/ais/plan/detail/edit.action?module=${module}&"+param+"=true&crudId="+ids[i].value;
						break;
					}
				}
			}
			
			/*
				删除选中的单条计划
			*/
			function deleteDetailPlan(detail_plan_id,detail_status){
				if(detail_status=='计划草稿'){
					$.messager.confirm("提示信息",'确定要删除本条计划吗?',function(flg){
						if(flg){
							window.location.href="/ais/plan/detail/delete.action?yearFormId=${yearFormId}&crudId="+detail_plan_id;
							showMessage2("删除成功！");
						}
					});
				}else{
					showMessage1("明细计划已经审批或执行，不能删除！");
				}
			}

			/*
				新增项目计划
			*/
			function addDetailPlan(){
				window.location.href="/ais/plan/detail/edit.action?option=add";
			}
		
			/*
				启动选中的单条计划
			*/
			function updateDetailPlan(detail_plan_id,detail_status){
				if(detail_status=='计划草稿'){
					window.location.href="/ais/plan/detail/edit.action?yearFormId=${yearFormId}&crudId="+detail_plan_id;
					showMessage2("启动成功！");
				}else{
					showMessage1("明细计划已经审批或执行，不能启动！");
				}
			}
			
			function planName(id){
				var viewUrl = "${contextPath}/plan/detail/view.action?crudId="+id;
				$('#showPlanName').attr("src",viewUrl);
				$('#planName').window('open');
			}
			 $('#planName').window({
					width:950, 
					height:450,  
					modal:true,
					collapsible:false,
					maximizable:true,
					minimizable:false,
					closed:true    
			    });
			
			$(function(){
		    	if('${empty crudObject.w_plan_year}'=='true'){
					var d = new Date();
					$('#w_plan_year').combo('setValue',d.getFullYear());
					$('#w_plan_year').combo('setText',d.getFullYear());
				}
			    // 初始化生成表格
				$('#resultList').datagrid({
					url : "<%=request.getContextPath()%>/plan/detail/listAll.action?querySource=grid",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize: 20,
    				fitColumns:false,
					idField:'formId',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								freshGrid();
							}
						},{
							id:'add',
							text:'新增 ',
							iconCls:'icon-add',
							handler:function(){
								addDetailPlan();
							}
						}
					],
					frozenColumns:[[
					       			{field:'status_name',title:'计划状态',sortable:true,halign:'center',align:'left'},
					       			{field:'w_plan_code',title:'计划编号',width:'210px',sortable:true,halign:'center',align:'left'}
					    		]],
					columns:[[  
						{field:'w_plan_name',
								title:'项目计划名称',
								width:200,
								halign:'center',
								align:'left', 
								sortable:true,
								formatter:function(value,rowData,rowIndex){
									/* return '<a href="${contextPath}/plan/detail/view.action?crudId='+rowData.formId+'" target="_blank" >'+value+'</a>'; */
									return '<a href=\"javascript:void(0)\" onclick=\"planName(\''+rowData.formId+'\');\">'+value+'</a>';
						}},
						{field:'w_plan_year',
							title:'计划年度',
							sortable:true,
							align:'center'
						},
						{field:'w_plan_month',
							title:'计划月度',
							sortable:true,
							align:'center'
						},
						{field:'w_plan_excute_month',
							title:'执行月度',
							sortable:true, 
							align:'center'
						},
						{field:'w_plan_type_name',
							title:'计划类别',
							sortable:true,
							align:'center'
						},
						{field:'audit_dept_name',
							 title:'审计单位',
							 width:200, 
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'operate',
							 title:'操作',
							 halign:'center',
							 align:'center', 
							 sortable:false,
							 formatter:function(value,row,index){
								 return '<a href=\"javascript:void(0)\" onclick=\"deleteDetailPlan(\''+row.formId+'\',\''+row.status_name+'\');\">删除</a>|<a href=\"javascript:void(0)\" onclick=\"updateDetailPlan(\''+row.formId+'\',\''+row.status_name+'\');\">启动</a>';
							 }
						}
					]]   
				});

				//单元格tooltip提示
				$('#resultList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
			});
		</script>
	</body>
</html>