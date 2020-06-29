<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
<title>年度计划列表(项目启动)</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
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
<script type="text/javascript">
	function selectYearList(){
		if(${userRole=='DUDAO'}){
			yearListForm.action="${contextPath}/plan/year/sendPlanYear.action?userRole=DUDAO";
		}else{
			yearListForm.action="${contextPath}/plan/year/sendPlanYear.action";
		}
		$('#yearList').datagrid({
	    		queryParams:form2Json('yearListForm')
	    });
		$('#proStartUp').dialog('close');
	

		//yearListForm.submit();
	}
	
	function checkYearPlan(userRole,yearFormId){
		var flag =true;
		$.ajax({
			type : "post",
			url : "${contextPath}/plan/detail/checkYearPlan.action",
			cache : false,
			async : false,
			data : {'userRole':userRole,'yearFormId':yearFormId},
			success : function(ret) {
				if (ret != 'true') {
					$.messager.alert("提示信息","没有可以启动的项目！");				
					flag =false;
				} 
			}
		});
		if(flag){
			window.location.href="${contextPath}/plan/detail/listDetailStart.action?type=edit&userRole=${userRole}&yearFormId="+yearFormId;
		}
	}	
	</script>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="proStartUp" class="searchWindow">
		<div class="search_head">
					<s:form name="yearListForm" id="yearListForm" action="sendPlanYear" namespace="/plan/year">
						<s:hidden name="userRole" id="userRole" value="${userRole}"></s:hidden>
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr >
							<td class="EditHead" style="width:15%">计划状态</td>
							<td class="editTd" style="width:35%">
								<select editable="false" class="easyui-combobox" name="crudObject.status" id="plan_status_name" style="width:80%;" editable="false" panelHeight="auto" readonly="true">
								       <option value="">&nbsp;</option>
								       <s:iterator value="@ais.plan.constants.PlanState@planStateCodeNameMap" >
								       	 		<option  value="<s:property value="key"/>"><s:property value="value"/></option>
								       </s:iterator>
							    </select>
									
							</td>
							<td class="EditHead" style="width:15%">计划编号</td>
							<td class="editTd" style="width:35%">
								<s:textfield cssClass="noborder" name="crudObject.w_plan_code" cssStyle="width:80%"
									maxlength="50" />
							</td>
						</tr>
						<tr >
							<td class="EditHead">计划年度</td>
							<td class="editTd">
							<select editable="false" id="w_plan_year" class="easyui-combobox" name="crudObject.w_plan_year" style="width:80%;" editable="false" panelHeight="auto">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
							         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select>
							</td>
							<td class="EditHead">计划名称</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="crudObject.w_plan_name" cssStyle="width:80%"
									maxlength="50" />
							</td>
						</tr>
						<tr >
							<td class="EditHead">
								计划管理员
							</td>
							<td class="editTd">
								<s:buttonText2  cssClass="noborder" id="crudObject.w_charge_person_name"
										name="crudObject.w_charge_person_name" cssStyle="width:80%"
										hiddenId="crudObject.w_charge_person" hiddenName="crudObject.w_charge_person"
										doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
		                                  param:{
		                                     'p_item':1,
		                                     'orgtype':1
		                                  },
		                                  title:'请选择计划管理员',
		                                  type:'treeAndEmployee'
										})"
										doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
										doubleCssStyle="cursor:hand;border:0" maxlength="50"  />
							</td>
						</tr>
					</table>
			</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="selectYearList()">查询</a>
				<s:if test="${userRole=='DUDAO'}">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="window.location.href='${pageContext.request.contextPath}/plan/year/sendPlanYear.action?userRole=DUDAO'">重置</a>
				</s:if>
				<s:else>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="window.location.href='${pageContext.request.contextPath}/plan/year/sendPlanYear.action'">重置</a>
				</s:else>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#proStartUp').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center">
		<table id="yearList"></table>
	</div>
	<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
			<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	</div>
	<script type="text/javascript">

			function enterExportPlan(flag){
				document.getElementById("plan_flag").value=flag;
				document.forms[0].action="exportPlan.action";
				document.forms[0].submit();
			}
			
			/*
				改变底部按钮状态
			*/
			function changeButtonState(checkbox,status,auditDept,fid){
				/**
				if(checkbox.checked){
					var ids = document.getElementsByName("year_plan_id");
					for(var i=0;i<ids.length;i++){
						if(ids[i].checked && checkbox.value != ids[i].value){
							ids[i].checked=false;
						}
					}
				}
				**/
				var ids = document.getElementsByName("year_plan_id");
				var count = 0;
				var formid = "";
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked){
						count++;
						formid=ids[i].value;
					}
				}
				if(count==0){
					var updateButton = document.getElementById('updateButton');
					var deleteButton = document.getElementById('deleteButton');
					//var disassembleButton = document.getElementById('disassembleButton');
					//var finishButton = document.getElementById('finishButton');
					//var summarizeButton = document.getElementById('summarizeButton');
					deleteButton.disabled=true;
					updateButton.disabled=true;
					//disassembleButton.disabled=true;
					//finishButton.disabled=true;
					//summarizeButton.disabled=true;
					/*if(!isEnableMonth){
						var addDetailButton = document.getElementById('addDetailButton');
						addDetailButton.disabled=true;
					}*/
					var exportButton = document.getElementById('exportButton');//wangly
					exportButton.disabled=true;
					var exportButton1 = document.getElementById('exportButton1');//wangly
					exportButton1.disabled=true;
					return;
				}	
				if(count==1){
					status = document.getElementById(formid+"_status").value;
					auditDept = document.getElementById(formid+"_audit_dept").value;
					fid = document.getElementById(formid+"_fid").value;
					var isEnableMonth = <s:property value="@ais.plan.util.PlanSysParamUtil@isMonthPlanEnabled()" />;//是否启用月度计划
					/*if(!isEnableMonth){
						var addDetailButton = document.getElementById('addDetailButton');
					}*/
					var updateButton = document.getElementById('updateButton');
					var deleteButton = document.getElementById('deleteButton');
					//var disassembleButton = document.getElementById('disassembleButton');
					//var finishButton = document.getElementById('finishButton');
					//var summarizeButton = document.getElementById('summarizeButton');
					var exportButton = document.getElementById('exportButton');//wangly
					exportButton.disabled=false;
					var exportButton1 = document.getElementById('exportButton1');//wangly
					exportButton1.disabled=false;
					/*if(!isEnableMonth){
						addDetailButton.disabled=true;
					}*/
					deleteButton.disabled=true;
					updateButton.disabled=true;
					//disassembleButton.disabled=true;
					//finishButton.disabled=true;
					//summarizeButton.disabled=true;
					
					if(auditDept=='${user.fdepid}' || fid=='${user.fdepid}'){
						if(status=='计划草稿' ){
							/*if(!isEnableMonth){
								addDetailButton.disabled=true;
							}*/
							deleteButton.disabled=false;
							updateButton.disabled=false;
							//disassembleButton.disabled=true;
							//summarizeButton.disabled=true;
						}
						if(status=='正在执行' ){
							/*if(!isEnableMonth){
								addDetailButton.disabled=false;
							}*/
							deleteButton.disabled=true;
							updateButton.disabled=true;
							//disassembleButton.disabled=false;
							//finishButton.disabled=false;
							//summarizeButton.disabled=true;
						}
						if(status=='执行完毕' ){
							/*if(!isEnableMonth){
								addDetailButton.disabled=true;
							}*/
							deleteButton.disabled=true;
							updateButton.disabled=true;
							//disassembleButton.disabled=true;
							var audit_dept = document.getElementById(checkbox.value+'_audit_dept').value;
							if('${user.fdepid}'==audit_dept){
								//summarizeButton.disabled=false;
							}
						}
					}
				}//count=1
				if(count>1){
					var updateButton = document.getElementById('updateButton');
					var deleteButton = document.getElementById('deleteButton');
					//var disassembleButton = document.getElementById('disassembleButton');
					//var finishButton = document.getElementById('finishButton');
					//var summarizeButton = document.getElementById('summarizeButton');
					deleteButton.disabled=true;
					updateButton.disabled=true;
					//disassembleButton.disabled=true;
					//finishButton.disabled=true;
					//summarizeButton.disabled=true;
					/*if(!isEnableMonth){
						var addDetailButton = document.getElementById('addDetailButton');
						addDetailButton.disabled=true;
					}*/
					var exportButton = document.getElementById('exportButton');//wangly
					exportButton.disabled=false;
					var exportButton1 = document.getElementById('exportButton1');//wangly
					exportButton1.disabled=false;
				}
			}

			/*
				新增明细计划
			*/
			function addDetailPlan(){
				var ids = document.getElementsByName("year_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						window.location.href="/ais/plan/detail/edit.action?yearFormId="+ids[i].value;
						break;
					}
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
			
			/*
				判断年度计划下是否还有未执行完毕的明细计划
			*/
			function haveUnFinishedDetail(yearPlanId){
				var isHave = 'true';
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/plan/year', action:'haveUnFinishedDetail', executeResult:'false' }, 
					{'currentYearFormId':yearPlanId},
					xxx);
				function xxx(data){
					isHave = data['isHaveUnFinishedDetail'];
				} 
				return isHave;
			}

			/*
				关闭计划前的校验,如果还有未完成的明细计划则不允许完成年度计划
			*/
			function finish(){
				var ids = document.getElementsByName("year_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='正在执行'){
							if(haveUnFinishedDetail(ids[i].value)=='true'){
								alert('当前年度计划中还有未完成的明细计划,不能进行此操作!');
								return false;
							}
							if(confirm('确定本条年度计划完成吗?')){
								window.location.href="/ais/plan/year/finishYearPlan.action?crudId="+ids[i].value;
							}
						}else{
							alert("只有'正在执行'状态下的年度计划才能进行完成操作!");
						}
						break;
					}
				}
			}
			/*
				填写年度计划总结
			*/
			function summarize(){
				var ids = document.getElementsByName("year_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='执行完毕'){
							window.location.href="/ais/plan/year/summarize.action?crudId="+ids[i].value+"&selectedTab=yearPlanZJDiv";
						}else{
							alert("年度计划只有在执行完毕后才能进行年度总结！");
						}
						break;
					}
				}
			}
			
			/*
				立项年度计划
			*/
			function disassemble(){
				var ids = document.getElementsByName("year_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='正在执行'){
							window.location.href="/ais/plan/year/disassemble.action?crudId="+ids[i].value+"&selectedTab=yearDetailListDiv";
						}else{
							alert("年度计划只有在正在执行状态才能进行明细信息的立项！");
						}
						break;
					}
				}

			}
			/*
				删除选中的单条计划
			*/
			function deleteYearPlan(){
				var ids = document.getElementsByName("year_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='计划草稿'){
							if(confirm('确定要删除这条年度计划吗?')){
								window.location.href="/ais/plan/year/delete.action?crudId="+ids[i].value;
							}else{
								return false;
							}
						}else{
							alert("年度计划已经审批或执行，不能删除！");
						}
						break;
					}
				}
			}
			/*
				修改选中的单条计划
			*/
			function updateYearPlan(){
				var ids = document.getElementsByName("year_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='计划草稿'){
							window.location.href="/ais/plan/year/edit.action?crudId="+ids[i].value;
						}else{
							alert("年度计划已经审批或执行，不能修改！");
						}
						break;
					}
				}
			}
		</script>
	
	<script type="text/javascript">
		$(function(){
			showWin('proStartUp');
			loadSelectH();
			$('#plan_status_name').combobox('setValue','8000');
			$('#plan_status_name').combo('setText','正在执行');
			var userRoleid=document.getElementById("userRole");
			//if('${empty crudObject.w_plan_year}'=='true'){
			//	var d = new Date();
			//	$('#w_plan_year').combobox('setValue',d.getFullYear());
			//	$('#w_plan_year').combobox('setText',d.getFullYear());
			//}
			// 初始化生成表格
			$('#yearList').datagrid({
				url : "<%=request.getContextPath()%>/plan/year/sendPlanYear.action?userRole=${userRole}&querySourn=star",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				pageSize:20,
				striped:true,
				fit : true,
				fitColumns:true,
				autoRowHeight:false,
				fit:true,
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
							id:'searchObj',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('proStartUp');
							}
						}
					],
				frozenColumns:[[
				       			{field:'status_name',title:'计划状态',align:'left',sortable:true,halign:'center'},
				       			{field:'w_plan_code',title:'计划编号',width:150,sortable:true,align:'left',halign:'center'}
				    		]],
				columns:[[ 
					{field:'w_plan_year',
						title:'计划年度',
						sortable:true, 
						align:'center',
						halign:'center'
					},
					{field:'w_plan_name',
							title:'年度计划名称',
							width:200,
							align:'left',
							sortable:true,
							halign:'center',
							formatter:function(value,rowData,rowIndex){
								return '<a href=\"javascript:void(0)\" onclick=\"planName(\''+rowData.formId+'\');\">'+value+'</a>';
								/* return '<a href="${contextPath}/plan/year/view.action?selectedTab=yearDetailListDiv&crudId='+rowData.formId+'" target="_blank">'+value+'</a>'; */
					}},
					{field:'audit_dept_name',
						title:'审计单位',
						sortable:true, 
						align:'left',
						halign:'center'
					},
					{field:'w_charge_person_name',
						 title:'计划管理员',
						 align:'center',
						 sortable:true,
						 halign:'center'
					},
					{field:'workPlanDetailCount',
						 title:'可启动项目数',
						 align:'center',
						 sortable:true,
						 halign:'center'
					},
					{field:'operate',
						 title:'操作',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
						 	var param = [userRoleid.value,row.formId];
							var btn2 = "启动,checkYearPlan,"+param.join(',');
							return ganerateBtn(btn2);
						 },
						halign:'center'
					}
				]]   
			});
			//单元格tooltip提示
			$('#yearList').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			});
			$("#play_struts").combobox('setValue','${status_name}')
		});
		function planName(id){
			var viewUrl = "${contextPath}/plan/year/view.action?selectedTab=yearDetailListDiv&crudId="+id;
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
		</script>
</body>
</html>