<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>年度计划1</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
		<s:head theme="ajax" />
	</head>
	<body>
	
	<s:tabbedPanel id="yearPlanPanel" theme='ajax' selectedTab="${param.selectedTab}">
		
		<s:div id='yearBasicInfoDiv' label='计划信息' theme='ajax'>
				<table id="planTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead" style="width: ;">
						<td colspan="4" align="left" class="edithead">
							&nbsp;年度计划信息
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划状态
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.status_name" />
						</td>
						<td class="ListTableTr11" nowrap>
							年度计划编号
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_plan_code" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划年度
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_plan_year"/>
						</td>
						<td class="ListTableTr11">
							计划名称
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_plan_name"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划单位
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.audit_dept_name"/>
						</td>
						<td class="ListTableTr11">
							负责人
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_charge_person_name"/>
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11">
							正文内容
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="crudObject.content" readonly="true"
								 cssStyle="width:100%;height:20;overflow-y:visible;border:0" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							附件
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="accelerys" align="center">
								<s:property escape="false" value="accessoryList" />
							</div>
						</td>
					</tr>
				</table>
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
				</div>
				<br/>
		</s:div>
		
		<s:div id='yearDetailListDiv' label='预选项目信息' theme='ajax'>
			<s:form id="yearDetailPlanSearchForm" action="disassemble" namespace="/plan/year" >
				<s:hidden name="crudId" />
				<s:hidden name="taskInstanceId" />
				<input name="selectedTab" type="hidden" value="yearDetailListDiv" />
				<table cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead">
						<td align="left" class="listtabletr11">
							计划状态
						</td>
						<td align="left" class="listtabletr22">
							 <s:select
								list="@ais.plan.constants.PlanState@planStateCodeNameMap"
								name="searchCondition.status"
								theme="ufaud_simple"
								templateDir="/strutsTemplate" emptyOption="true"/>
						</td>
						<td align="left" class="listtabletr11">
							计划编号
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="searchCondition.w_plan_code" cssStyle="width:100%" />
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="left" class="listtabletr11">
							计划月度
						</td>
						<td align="left" class="listtabletr22">
							<s:select
								list="{'1','2','3','4','5','6','7','8','9','10','11','12'}"
								name="searchCondition.w_plan_month"
								theme="ufaud_simple"
								templateDir="/strutsTemplate" emptyOption="true"/>
						</td>
						<td align="left" class="listtabletr11" nowrap="nowrap">
							预选项目名称
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="searchCondition.w_plan_name" cssStyle="width:100%" />
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="left" class="listtabletr11">
							审计单位
						</td>
						<td align="left" class="listtabletr22">
							<s:buttonText2 id="searchCondition.audit_dept_name"
								name="searchCondition.audit_dept_name" cssStyle="width:90%"
								hiddenName="searchCondition.audit_dept" hiddenId="searchCondition.audit_dept"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=searchCondition.audit_dept_name&paraid=searchCondition.audit_dept',600,350,'组织机构选择')"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" />
						</td>
						<td align="left" class="listtabletr11">
							负责人
						</td>
						<td align="left" class="listtabletr22">
							<s:buttonText2 id="searchCondition.pro_teamleader_name"
								name="searchCondition.pro_teamleader_name" cssStyle="width:90%"
								hiddenId="searchCondition.pro_teamleader" hiddenName="searchCondition.pro_teamleader"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/frameselect4s.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=searchCondition.pro_teamleader_name&paraid=searchCondition.pro_teamleader',600,350)"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" />
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="right" class="listtabletr1" colspan="4">
							<DIV align="right">
								<s:submit value="查询" />
								&nbsp;
								<input type="button" value="重置"
									onclick="window.location.href='${pageContext.request.contextPath}/plan/year/disassemble.action?crudId=${crudId}&&taskInstanceId=${taskInstanceId}&&selectedTab=yearDetailListDiv'">
							</DIV>
						</td>
					</tr>
				</table>
				<div align="center">
					<display:table name="yearDetailList" id="row" class="its" cellpadding="1" pagesize="20"
						pagesize="${baseHelper.pageSize}" partialList="true" 
						size="${baseHelper.totalRows}" sort="external"
						defaultsort="6" defaultorder="ascending" 
						requestURI="${contextPath}/plan/year/disassemble.action?selectedTab=yearDetailListDiv" >
						<display:column title="选择" headerClass="center" class="center">
							<s:if test="${row.isFJ!='Y'&&row.status_name=='计划草稿'}">
								<s:if test="!@ais.plan.util.PlanSysParamUtil@isMonthPlanEnabled()">
									<input type="radio" name="detail_plan_id" value="${row.formId}">
								</s:if>
								<s:else>
									<input type="checkbox" name="detail_plan_id" value="${row.formId}">
								</s:else>
							</s:if>
							<s:else>
								<s:if test="!@ais.plan.util.PlanSysParamUtil@isMonthPlanEnabled()">
									<input type="radio" name="detail_plan_id" disabled="disabled" value="${row.formId}">
								</s:if>
								<s:else>
									<input type="checkbox" name="detail_plan_id" disabled="disabled" value="${row.formId}">
								</s:else>
							</s:else>
							<input type="hidden" id="${row.formId}_status" value="${row.status_name}" />
						</display:column>
						<display:column property="status_name" title="计划状态" headerClass="center" class="center"  sortable="true" />
						<display:column title="计划编号" headerClass="center" sortable="true" sortProperty="w_plan_code">
							<a href="/ais/plan/year/viewYearDetail.action?yearDetailId=${row.formId}" target="_blank">${row.w_plan_code}</a>
						</display:column>
						<display:column property="w_plan_type_name" title="计划类别" headerClass="center" class="center" sortable="true"/>
						<display:column property="w_plan_year" title="年度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true"/>
						<display:column property="w_plan_month" title="月度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true" comparator="ais.framework.displaytag.NumberComparator"/>
						<display:column property="w_plan_excute_month" title="执行月度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true"/>
						<display:column title="预选项目名称" headerClass="center" class="center" sortable="true" sortProperty="w_plan_name" style="text-align:left;word-break:break-all;">
							<s:if test="${row.detail_plan_name!=null&&row.detail_plan_name!=''}">
								<a href="/ais/plan/detail/view.action?crudId=${row.detail_form_id}" target="_blank">${row.detail_plan_name}</a>
							</s:if>
							<s:else>
								<a href="/ais/plan/year/viewYearDetail.action?yearDetailId=${row.formId}" target="_blank">${row.w_plan_name}</a>
							</s:else>
						</display:column>
						<display:column property="audit_dept_name" title="审计单位" headerClass="center" class="center" sortable="true"/>
						<display:column property="pro_teamleader_name" title="负责人" headerClass="center" class="center" sortable="true"/>
						<display:setProperty name="paging.banner.placement" value="bottom" />
					</display:table>
				</div>
					<div align="right" style="width: 97%">
						<s:if test="${crudObject.status_name=='正在执行'}">
							<input type="button" value="确认立项" onclick="this.style.disabled='disabled';return disassembleYear()"/>
						</s:if>
						&nbsp;&nbsp;
						<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/plan/year/listAll.action'" />
					</div>
				
				<br/>
			</s:form>
		</s:div>

	</s:tabbedPanel>
	<script type="text/javascript">
		/*
			立项年度计划
		*/
		function disassembleYear(){
			var ids = document.getElementsByName("detail_plan_id");
			var detailIds = '';
			for(var i=0;i<ids.length;i++){
				if(ids[i].checked==true){
					detailIds= detailIds==''?ids[i].value:detailIds+','+ids[i].value;
				}
			}
			var isMonthPlanEnabled = <s:property value="@ais.plan.util.PlanSysParamUtil@isMonthPlanEnabled()" />;
			if(!isMonthPlanEnabled){//是否启用月度计划
				if(detailIds==''){
					alert('请选择要立项的明细信息!');
					return false;
				}
				window.location.href="/ais/plan/detail/edit.action?yearDetailId="+detailIds;
			}else{
				if(detailIds==''){
					if(!confirm('确认立项吗?注意:您没有选择任何明细信息，产生的月度计划中将不包含任何明细信息!')){
						return false;
					}
				}
				window.location.href="/ais/plan/month/edit.action?yearFormId=${crudObject.formId}&yearDetailIds="+detailIds;
			}
		}
	</script>
	</body>
</html>
