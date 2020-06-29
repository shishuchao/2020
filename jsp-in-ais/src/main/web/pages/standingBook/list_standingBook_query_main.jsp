<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目台账查询主页面</title>
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
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
        <script type="text/javascript">

		    //导出
		    function execExport(columns){
		    
				document.getElementById("standingBook").action="exportMain.action?"+columns;
				document.getElementById("standingBook").target="_self";
				document.getElementById("standingBook").submit();
				document.getElementById("standingBook").action="exportMain.action";
				document.getElementById("standingBook").target="_self";
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
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="true"  style="width:700px;height:300px;overflow:hidden">
		<div class="panel layout-panel layout-panel-center" style="width: 686px; left: 6px; top: 30px;">
		<div region="center" title="" class="panel-body panel-body-noheader layout-body" style="width: 684px; height: 234px;">
		<s:form action="standingBook" namespace="/standingBook" id="standingBook">
				<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td align="left" class="EditHead" style="width:15%">项目编号</td>
						<td align="left" class="editTd" style="width:35%">
						   <s:textfield name="projectStartObject.project_code" cssStyle="width:80%;" cssClass="noborder"/>
						</td>
						<td align="left" class="EditHead" style="width:15%">项目名称</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="projectStartObject.project_name" cssStyle="width:80%;" cssClass="noborder"/>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">审计单位</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="plan.audit_dept_name" cssClass="noborder"
								name="plan.audit_dept_name" cssStyle="width:80%;"
								hiddenName="plan.audit_dept" hiddenId="plan.audit_dept"
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/systemnew/orgListByAsyn.action',
									  title:'请选择审计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  }
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
						</td>
						<td align="left" class="EditHead">被审计单位</td>
						<td align="left" class="editTd">
						    <s:buttonText2 id="pso.audit_object_name" cssClass="noborder"
								name="pso.audit_object_name" cssStyle="width:80%;"
								hiddenName="pso.audit_object" hiddenId="pso.audit_object"
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
									  title:'请选择被审计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  }
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">项目类型</td>
						<td align="left" class="editTd">
							<s:select id="plan_type" name="projectStartObject.pro_type" cssClass="easyui-combobox" cssStyle="width:80%;"
								list="basicUtil.PlanProjectTypeList" listKey="code" listValue="name" headerKey="" headerValue=""
								theme="ufaud_simple" templateDir="/strutsTemplate" />
						</td>
						
						<td align="left" class="EditHead">
						    审计事项
						</td>
						<td align="left" class="editTd">
						    <s:textfield name="ledgerProblem.taskName" cssStyle="width:80%;" cssClass="noborder"/>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">问题点</td>
						<td align="left" class="editTd">
							<s:buttonText id="problems" hiddenId="ledgerProblem.problem_code" cssClass="noborder"
							cssStyle="width:80%;" name="ledgerProblem.problem_name"
							hiddenName="ledgerProblem.problem_code"
							doubleOnclick="showSysTree(this,{
				    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
				    				onlyLeafCheck:true,
				    				title:'请选择问题点'
								})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td align="left" class="EditHead">审计发现类型</td>
						<td align="left" class="editTd">
						    <s:select id="problem_grade_code" name="ledgerProblem.problem_grade_code" cssClass="easyui-combobox" cssStyle="width:80%;"
								list="basicUtil.ProblemMethodList" listKey="code" listValue="name" headerKey="" headerValue=""
								theme="ufaud_simple" templateDir="/strutsTemplate" />
						</td>
				    </tr>
				    <tr>
						<td align="left" class="EditHead" style="width: 15%">审计实施时间</td>
						<td align="left" class="editTd" colspan="3" style="width: 85%">
						    <input type="text" class="easyui-datebox" style="width: 27%"  name="projectStartObject.pro_starttime" title="单击选择日期"  Style="width:110px;" editable="false" />	
							至
							<input type="text" Class="easyui-datebox"  style="width: 27%" name="projectStartObject.pro_endtime" title="单击选择日期"  Style="width:110px;" editable="false" />
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead" style="width: 15%">审计期间</td>
						<td align="left" class="editTd" colspan="3" style="width: 85%">						
							<input type="text" class="easyui-datebox" style="width: 27%"  name="projectStartObject.audit_start_time" title="单击选择日期"  Style="width:110px;" editable="false" />	
							至
							<input type="text" Class="easyui-datebox" style="width: 27%"  name="projectStartObject.audit_end_time" title="单击选择日期"  Style="width:110px;" editable="false" />
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
			<table id="listStandingBookDiv"></table>
		</div>
		
		<script type="text/javascript">
	        function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#listStandingBookDiv').datagrid({
	    			queryParams:form2Json('standingBook')
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
				resetForm('standingBook');
				//doSearch();
			}
		   
		   //导出
		   function doExport(flag){
		      var chbox = $('#listStandingBookDiv').datagrid('getSelections');
		      
		      if(chbox.length < 1){
		         showMessage1("至少选择一个年度计划！");
		         return false;
		      }
		      if(chbox.length > 1){
		         showMessage1("选择超过一个年度计划！");
		         return false;
		      }
		      var boxValue = new Array;
		      for(var i=0; i < chbox.length; i++){
		         boxValue.push(chbox[i].formId);
		      }
		      if('main' == flag){
		         window.open("${contextPath}/standingBook/standingBook!exportMain.action?formids="+boxValue);
		      }else{
		         window.open("${contextPath}/standingBook/standingBook!exportSub.action?formids="+boxValue);
		      }
		      
		   }
		   
		   function doSearchSub(projectid){
		       window.open("${contextPath}/standingBook/standingBook!StandingBookQuerySub.action?projectStartObject.formId="+projectid);
		   }
		   
		   $(function(){
			$('#listStandingBookDiv').datagrid({
				url : "<%=request.getContextPath()%>/standingBook/standingBook!StandingBookQueryMain.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
			//	pagination:false,
			    pageSize: 20,
				fitColumns:false,
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
				},
				{
					id:'main',
					text:'导出主表',
					iconCls:'icon-export',
					handler:function(){
						doExport("main");
					}},
					{
					id:'sub',
					text:'导出从表',
					iconCls:'icon-export',
					handler:function(){
						doExport("sub");
				    }
				}],
				frozenColumns:[[
				       			{field:'id',width:'50px', checkbox:true, align:'center'},
				       			{field:'project_code',title:'项目编号',width:'200px',align:'left',sortable:true},
				       			{field:'project_name',title:'项目名称',width:'150px',sortable:true,align:'left'}
				    		]],
				columns:[[  
					{field:'audit_dept_name',
							title:'审计单位',
							width:200,
							align:'left', 
							sortable:true,
							formatter:function(value,row,rowIndex){
								return row.audit_dept_name;
					}},
					{field:'audit_object_name',
						title:'被审计单位',
						width:200,
						sortable:true, 
						align:'left',
						formatter:function(value,row,rowIndex){
								return row.audit_object_name;
					}},
					{field:'pro_type_name',
						 title:'项目类型',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pro_type_name;
					}},		
					{field:'audit_start_time',
						 title:'审计期间开始',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndedx){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					},
					{field:'audit_end_time',
						 title:'审计期间结束',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					},
					
					{field:'pro_starttime',
						 title:'审计实施时间开始',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								if(value!=null){
									return value.substring(0,10);
								}	
						 }
					},{field:'pro_endtime',
						 title:'审计实施时间结束',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						 	if(value != null){
							 	return value.substring(0,10);
							 }
						 }
					},
					{field:'pro_teamleader_name',
						 title:'项目组长',
						 align:'left', 
						 sortable:true,
						/*  formatter:function(value,row,rowIndex){
								return row.pro_teamleader_name;
					} */
					},	
					{field:'problemCount',
						 title:'问题个数',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.problemCount;
					}},
					{field:'problemMoney',
						 title:'涉及金额',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.problemMoney;
					}},
					{field:'caozuo',
						 title:'操作',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return '<a href="javascript:void(0)" onclick="doSearchSub('+"'"+row.formId+"'"+')">从表查看</a>';
					}}
					
				]]   
			}); 
		});
		   
		   
		</script>
	</body>
</html>