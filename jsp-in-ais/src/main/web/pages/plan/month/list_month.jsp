<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>月度计划列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead"
					style="text-align: left; width: 100%;">
					<div style="display: inline; width: 80%;">
						<s:property escape="false"
							value="@ais.framework.util.NavigationUtil@getNavigation('/ais/plan/month/listAll.action')" />
					</div>
					<div style="display: inline; width: 20%; text-align: right;">
						<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
					</div>
				</td>
			</tr>
		</table>
		<s:form action="listAll" namespace="/plan/month">
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center"
				style="display: none; table-layout: fixed;">
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						计划状态：
					</td>
					<td align="left" class="listtabletr22">
						<s:select
							list="@ais.plan.constants.PlanState@planStateCodeNameMap"
							name="crudObject.status" theme="ufaud_simple"
							templateDir="/strutsTemplate" emptyOption="true" />
					</td>
					<td align="left" class="listtabletr11">
						计划编号：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="crudObject.w_plan_code" cssStyle="width:100%"
							maxlength="50" />
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						计划年度：
					</td>
					<td align="left" class="listtabletr22">
						<s:select name="crudObject.w_plan_year"
							list="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)"
							disabled="false" theme="ufaud_simple"
							templateDir="/strutsTemplate" />
					</td>
					<td align="left" class="listtabletr11">
						计划月度：
					</td>
					<td align="left" class="listtabletr22">
						<s:select
							list="{'1','2','3','4','5','6','7','8','9','10','11','12'}"
							name="crudObject.w_plan_month" theme="ufaud_simple"
							templateDir="/strutsTemplate" emptyOption="true" />
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						计划名称：
					</td>
					<td align="left" class="listtabletr22" colspan="3">
						<s:textfield name="crudObject.w_plan_name" cssStyle="width:100%"
							maxlength="50" />
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						计划单位：
					</td>
					<td align="left" class="listtabletr22">
						<s:buttonText2 id="crudObject.audit_dept_name"
							name="crudObject.audit_dept_name" cssStyle="width:90%"
							hiddenName="crudObject.audit_dept"
							hiddenId="crudObject.audit_dept"
							doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=crudObject.audit_dept_name&paraid=crudObject.audit_dept',600,350,'组织机构选择')"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" />
					</td>
					<td align="left" class="listtabletr11">
						负责人：
					</td>
					<td align="left" class="listtabletr22">
						<s:buttonText2 id="crudObject.w_charge_person_name"
							name="crudObject.w_charge_person_name" cssStyle="width:90%"
							hiddenId="crudObject.w_charge_person"
							hiddenName="crudObject.w_charge_person"
							doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/frameselect4s.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=crudObject.w_charge_person_name&paraid=crudObject.w_charge_person',600,350)"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" />
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right">
							<s:submit value="查询" />
							&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/plan/month/listAll.action'">
						</DIV>
					</td>
				</tr>
			</table>

			<div id="listPlanDiv" align="center">
				<display:table id="row" name="resultList"
					pagesize="${baseHelper.pageSize}" partialList="true"
					size="${baseHelper.totalRows}" sort="external" defaultsort="4"
					defaultorder="descending" class="its"
					requestURI="${contextPath}/plan/month/listAll.action">
					<display:column title="选择" headerClass="center">
						<input type="checkbox" name="month_plan_id" value="${row.formId}"
							onclick="changeButtonState(this,'${row.status_name}')" />
						<input type="hidden" id="${row.formId}_status"
							value="${row.status_name}" />
						<input type="hidden" id="${row.formId}_audit_dept"
							value="${row.audit_dept}" />
					</display:column>
					<display:column property="status_name" title="计划状态"
						style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column property="w_plan_code" title="计划编号"
						headerClass="center" style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column property="w_plan_year" title="年度"
						headerClass="center" style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column property="w_plan_month" title="月度"
						headerClass="center" style="WHITE-SPACE: nowrap" sortable="true"
						comparator="ais.framework.displaytag.NumberComparator" />
					<display:column title="月度计划名称" headerClass="center" sortable="true"
						sortProperty="w_plan_name">
						<a
							href="${contextPath}/plan/month/view.action?selectedTab=monthDetailListDiv&crudId=${row.formId}"
							target="_blank">${row.w_plan_name }</a>
					</display:column>
					<display:column property="audit_dept_name" title="审计实施单位"
						headerClass="center" class="center" sortable="true" />
					<display:column property="w_charge_person_name" title="负责人"
						headerClass="center" class="center" sortable="true" />
					<display:column title="查看" headerClass="center" class="center"
						media="html" style="WHITE-SPACE: nowrap">
						<a
							href="${contextPath}/plan/year/listAll.action?crudObject.formId=${row.year_id}">年度计划</a>&nbsp;
						<a
							href="${contextPath}/plan/detail/listAll.action?crudObject.month_id=${row.formId}">项目计划</a>
					</display:column>
					<display:setProperty name="paging.banner.placement" value="bottom" />
				</display:table>
			</div>

			<s:if test="@ais.plan.util.PlanSysParamUtil@isPlanEnabled()">
				<div id="buttonDiv" align="right" style="width: 97%">
				
					<%-- 只有启用项目计划的情况下才能通过这个按钮增加    --%>
					<s:if test="@ais.plan.util.PlanSysParamUtil@isDetailPlanEnabled()">
					<input id="addButton" type="button" value="增加明细计划"
						onclick="addDetailPlan()" disabled="disabled" style="display: ''"/>
					</s:if>
					<s:else>
						<input id="addButton" type="button" value="增加明细计划"
							onclick="addDetailPlan()" disabled="disabled" style="display: none;"/>
					</s:else>
					<input id="deleteButton" type="button" value="删除"
						onclick="deleteMonthPlan()" disabled="disabled" />
					<input id="updateButton" type="button" value="修改"
						onclick="updateMonthPlan()" disabled="disabled" />
						
					<%-- 只有启用项目计划的情况下才能立项到项目计划    --%>
					<s:if test="@ais.plan.util.PlanSysParamUtil@isDetailPlanEnabled()">
						<input id="disassembleButton" type="button" value="立项"
							disabled="disabled" onclick="disassemble()" />
					</s:if>
					<s:else>
						<input id="disassembleButton" type="button" value="立项"
							disabled="disabled" onclick="disassemble()" style="display: none;"/>
					</s:else>
					
					<input id="finishButton" type="button" value="完成"
						disabled="disabled" onclick="finish()" />
					<input id="summarizeButton" type="button" value="总结"
						disabled="disabled" onclick="summarize()" />
				</div>
			</s:if>
		</s:form>

		<script type="text/javascript">
		
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
				判断月度计划下是否还有未执行完毕的明细计划（20090416需求变更,要求项目计划只要进入项目后就可以关闭月度计划）
			*/
			function haveUnFinishedDetail(monthPlanId){
				var isHave = 'true';
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/plan/month', action:'haveUnFinishedDetail', executeResult:'false' }, 
					{'monthFormId':monthPlanId},
					xxx);
				function xxx(data){
					isHave = data['isHaveUnFinishedDetail'];
				} 
				return isHave;
			}
			
			/*
				关闭计划前的校验,如果还有未完成的明细计划则不允许完成月度计划（20090416需求变更,要求项目计划只要进入项目后就可以关闭月度计划）
			*/
			function finish(){
				var ids = document.getElementsByName("month_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='正在执行'){
							if(haveUnFinishedDetail(ids[i].value)=='true'){
								alert('当前月度计划中还有未完成的明细计划,不能进行此操作!');
								return false;
							}
							if(confirm('确定本条月度计划完成吗?')){
								window.location.href="/ais/plan/month/finishMonthPlan.action?crudId="+ids[i].value;
							}
						}else{
							alert("只有'正在执行'状态下的月度计划才能进行完成操作!");
						}
						break;
					}
				}
			}

			/*
				判断当前月度计划是否含有新增的明细计划
			*/
			function haveMonthAddDetail(monthPlanId){
				var isHave = 'false';
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/plan/month', action:'haveMonthAddDetail', executeResult:'false' }, 
					{'monthFormId':monthPlanId},
					xxx);
				function xxx(data){
					isHave = data['isHaveMonthAddDetail'];
				} 
				return isHave;
			}
			
			/*
				新增明细计划
			*/
			function addDetailPlan(){
				var ids = document.getElementsByName("month_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						window.location.href="/ais/plan/detail/edit.action?monthFormId="+ids[i].value;
						break;
					}
				}
			}
			
			/*
				填写月度计划总结
			*/
			function summarize(){
				var ids = document.getElementsByName("month_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='执行完毕'){
							window.location.href="/ais/plan/month/summarize.action?crudId="+ids[i].value+"&selectedTab=monthPlanZJDiv";
						}else{
							alert("月度计划只有在执行完毕后才能进行年度总结！");
						}
						break;
					}
				}
			}
			
			/*
				立项月度计划
			*/
			function disassemble(){
				var ids = document.getElementsByName("month_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='正在执行'){
							window.location.href="/ais/plan/month/disassemble.action?crudId="+ids[i].value+"&selectedTab=monthDetailListDiv";
						}else{
							alert("月度计划只有在正在执行状态才能进行明细信息的立项！");
						}
						break;
					}
				}

			}
			/*
				删除选中的单条计划
			*/
			function deleteMonthPlan(){
				var ids = document.getElementsByName("month_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='计划草稿'){
							if(haveMonthAddDetail(ids[i].value)=='true'){
								alert('当前月度计划中包含新添加的明细计划,请先删除相应明细计划!');
								return false;
							}
							if(confirm('确定要删除本条月度计划吗?')){
								window.location.href="/ais/plan/month/delete.action?crudId="+ids[i].value;
							}
						}else{
							alert("月度计划已经审批或执行，不能删除！");
						}
						break;
					}
				}
			}
			/*
				修改选中的单条计划
			*/
			function updateMonthPlan(){
				var ids = document.getElementsByName("month_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						var status = document.getElementById(ids[i].value+"_status").value;
						if(status&&status=='计划草稿'){
							window.location.href="/ais/plan/month/edit.action?crudId="+ids[i].value;
						}else{
							alert("月度计划已经审批或执行，不能修改！");
						}
						break;
					}
				}
			}
			/*
				改变底部按钮状态
			*/
			function changeButtonState(checkbox,status){
				if(checkbox.checked){
					var ids = document.getElementsByName("month_plan_id");
					for(var i=0;i<ids.length;i++){
						if(ids[i].checked && checkbox.value != ids[i].value){
							ids[i].checked=false;
						}
					}
				}

				var addButton = document.getElementById('addButton');
				var updateButton = document.getElementById('updateButton');
				var deleteButton = document.getElementById('deleteButton');
				var disassembleButton = document.getElementById('disassembleButton');
				var finishButton = document.getElementById('finishButton');
				var summarizeButton = document.getElementById('summarizeButton');

				addButton.disabled=true;
				deleteButton.disabled=true;
				updateButton.disabled=true;
				disassembleButton.disabled=true;
				finishButton.disabled=true;
				summarizeButton.disabled=true;
				
				if(status=='计划草稿' && checkbox.checked){
					addButton.disabled=false;
					deleteButton.disabled=false;
					updateButton.disabled=false;
					disassembleButton.disabled=true;
					summarizeButton.disabled=true;
				}
				if(status=='正在执行' && checkbox.checked){
					deleteButton.disabled=true;
					updateButton.disabled=true;
					disassembleButton.disabled=false;
					finishButton.disabled=false;
					summarizeButton.disabled=true;
				}
				if(status=='执行完毕' && checkbox.checked){
					deleteButton.disabled=true;
					updateButton.disabled=true;
					disassembleButton.disabled=true;
					var audit_dept = document.getElementById(checkbox.value+'_audit_dept').value;
					if('${user.fdepid}'==audit_dept){
						summarizeButton.disabled=false;
					}
				}
			}
		</script>

	</body>
</html>
