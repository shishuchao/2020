<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>月度计划</title>
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
	
	<s:tabbedPanel id="monthPlanPanel" theme='ajax' selectedTab="${param.selectedTab}">
		
		<s:div id='monthBasicInfoDiv' label='计划信息' theme='ajax'>
				<table id="planTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead" style="width: ;">
						<td colspan="4" align="left" class="edithead">
							&nbsp;月度计划信息
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划状态：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.status_name" />
						</td>
						<td class="ListTableTr11" nowrap>
							月度计划编号：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_plan_code" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划年度：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_plan_year"/>
						</td>
						<td align="left" class="listtabletr11">
							计划月度：
						</td>
						<td align="left" class="listtabletr22">
							<s:property value="crudObject.w_plan_month"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划名称：
						</td>
						<td class="ListTableTr22"  colspan="3">
							<s:property value="crudObject.w_plan_name"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划单位：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.audit_dept_name"/>
						</td>
						<td class="ListTableTr11">
							负责人：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_charge_person_name"/>
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11">
							正文内容：
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="crudObject.content" readonly="true"
								 cssStyle="width:100%;height:20;overflow-y:visible;border:0" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							附件：
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
		
		<s:div id='monthDetailListDiv' label='预选项目信息' theme='ajax'>
			<s:form id="monthDetailPlanSearchForm" action="view" namespace="/plan/month" >
				<s:hidden name="crudId" />
				<s:hidden name="taskInstanceId" />
				<input name="selectedTab" type="hidden" value="monthDetailListDiv" />
				<table cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead">
						<td align="left" class="listtabletr11">
							计划状态：
						</td>
						<td align="left" class="listtabletr22">
							 <s:select
								list="@ais.plan.constants.PlanState@planStateCodeNameMap"
								name="searchCondition.status"
								theme="ufaud_simple"
								templateDir="/strutsTemplate" emptyOption="true"/>
						</td>
						<td align="left" class="listtabletr11">
							计划编号：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="searchCondition.w_plan_code" cssStyle="width:100%" />
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="left" class="listtabletr11" nowrap="nowrap">
							预选项目名称：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="searchCondition.w_plan_name" cssStyle="width:100%" />
						</td>
						<td align="left" class="listtabletr11">
							计划月度：
						</td>
						<td align="left" class="listtabletr22">
							<s:select id="w_plan_month" 
								list="{'1','2','3','4','5','6','7','8','9','10','11','12'}"
								name="searchCondition.w_plan_month"
								theme="ufaud_simple"
								templateDir="/strutsTemplate" emptyOption="true"/>
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="left" class="listtabletr11">
							审计实施单位：
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
							负责人：
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
									onclick="window.location.href='${pageContext.request.contextPath}/plan/month/view.action?crudId=${crudId}&&taskInstanceId=${taskInstanceId}&&selectedTab=monthDetailListDiv'">
							</DIV>
						</td>
					</tr>
				</table>
				
				<div style="display: inline;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查询结果过滤器：
					<a href="javascript:;" onclick="filterResultByMonth('1')">一月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('2')">二月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('3')">三月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('4')">四月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('5')">五月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('6')">六月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('7')">七月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('8')">八月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('9')">九月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('10')">十月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('11')">十一月份</a>
					<a href="javascript:;" onclick="filterResultByMonth('12')">十二月份</a>
				</div>
				
				<div align="center">
					<display:table name="monthDetailList" id="row" class="its" cellpadding="1" pagesize="10" 
						pagesize="${baseHelper.pageSize}" partialList="true" 
						size="${baseHelper.totalRows}" sort="external"
						defaultsort="4" defaultorder="descending"
						requestURI="${contextPath}/plan/month/view.action?selectedTab=monthDetailListDiv" >
						<display:column title="选择" headerClass="center" class="center">
							<input type="checkbox" name="detail_plan_id" disabled="true" value="${row.formId}">
							<input type="hidden" id="${row.formId}_status" value="${row.status_name}" />
						</display:column>
						<display:column property="status_name" title="计划状态" headerClass="center" class="center" sortable="true" />
						<display:column title="计划编号" headerClass="center" sortable="true" sortProperty="w_plan_code" property="w_plan_code" />
						<display:column property="w_plan_year" title="年度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true"/>
						<display:column property="w_plan_month" title="计划月度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true" comparator="ais.framework.displaytag.NumberComparator"/>
						<display:column property="w_plan_excute_month" title="执行月度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true"/>
						<display:column property="w_plan_type_name" title="计划类别" headerClass="center" class="center" sortable="true"/>
						<display:column title="预选项目名称" headerClass="center" class="center" sortable="true" sortProperty="w_plan_name"  style="text-align:left;word-break:break-all;">
							<s:if test="${row.detail_plan_name!=null&&row.detail_plan_name!=''}">
								<a href="/ais/plan/detail/view.action?crudId=${row.detail_form_id}" target="_blank">${row.detail_plan_name}</a>
							</s:if>
							<s:else>
								<a href="/ais/plan/month/viewMonthDetail.action?monthDetailId=${row.formId}" target="_blank">${row.w_plan_name}</a>
							</s:else>
						</display:column>
						<display:column property="audit_dept_name" title="审计实施单位" headerClass="center" class="center" sortable="true"/>
						<display:column property="pro_teamleader_name" title="负责人" headerClass="center" class="center" sortable="true"/>
						<display:setProperty name="paging.banner.placement" value="bottom" />
					</display:table>
				</div>
				
				<br/>
			</s:form>
		</s:div>
		
		<s:div id='monthPlanZJDiv' label='工作总结' theme='ajax'>
			<s:form id="monthPlanZJForm" action="saveSummarize" namespace="/plan/month" >
				<s:hidden name="crudId"/>
				<table id="zjTable" cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead" style="width: ;">
						<td colspan="4" align="left" class="edithead">
							&nbsp;月度计划总结
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划年度：
						</td>
						<td class="ListTableTr22">
							${crudObject.w_plan_year }
						</td>
						<td class="ListTableTr11">
							计划月度：
						</td>
						<td class="ListTableTr22">
							${crudObject.w_plan_month }
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划编号：
						</td>
						<td class="ListTableTr22">
							${crudObject.w_plan_code }
						</td>
						<td class="ListTableTr11">
							总结单位：
						</td>
						<td class="ListTableTr22">
							${crudObject.zjdw_name }
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							总结人：
						</td>
						<td class="ListTableTr22">
							${crudObject.zjr_name}
						</td>
						<td class="ListTableTr11">
							总结日期：
						</td>
						<td class="ListTableTr22">
							<s:date format="yyyy-MM-dd" name="crudObject.zjrq"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							总结内容：
						</td>
						<td class="ListTableTr22" colspan=3>
							<s:textarea name="crudObject.zjzw" 
								value="${crudObject.zjzw}" cssStyle="width:600px;border:0" disabled="true"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							附件信息：
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="accelerysOfZJ" align="center">
								<s:property escape="false" value="accessoryListOfZJ" />
							</div>
						</td>
					</tr>
				</table>
				<br/>
			</s:form>
		</s:div>

	</s:tabbedPanel>
	
	<script type="text/javascript">
	
		function filterResultByMonth(month){
			document.getElementById('w_plan_month').value = month;
			document.getElementById('monthDetailPlanSearchForm').submit();
		}
		
	</script>
	</body>
</html>