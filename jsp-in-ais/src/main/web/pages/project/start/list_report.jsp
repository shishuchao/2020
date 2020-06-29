<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>项目列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
</head>
<body>
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
		<tr class="listtablehead">
			<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
				<div style="display: inline;width:80%;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/project/projectReport.action')" />
				</div>
				<div style="display: inline;width:20%;text-align: right;">
					<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
				</div>
			</td>
		</tr>
	</table>
	<s:form action="projectReport" namespace="/project" method="post">
		<table id="searchTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center" style="display: none;">
			<tr class="listtablehead">
				<td align="left" class="listtabletr11">项目编号：</td>
				<td align="left" class="listtabletr22"><s:textfield name="pso.project_code" cssStyle="width:98%" /></td>
				<td align="left" class="listtabletr11">项目名称：</td>
				<td align="left" class="listtabletr22"><s:textfield name="pso.project_name" cssStyle="width:98%" /></td>

			</tr>
			<tr class="listtablehead">
				<td align="left" class="listtabletr11">计划类别：</td>
				<td align="left" class="listtabletr22"><s:select name="pso.plan_type" list="basicUtil.planTypeList" listKey="code" listValue="name" emptyOption="true" /></td>
				<td align="left" class="listtabletr11">项目类别：</td>
				<td align="left" class="listtabletr22"><s:doubleselect id="pro_type" doubleId="pro_type_child" doubleList="basicUtil.planProjectTypeMap[top]" doubleListKey="code" doubleListValue="name" listKey="code" listValue="name" name="pso.pro_type" list="basicUtil.planProjectTypeMap.keySet()" doubleName="pso.pro_type_child" theme="ufaud_simple" templateDir="/strutsTemplate" display="${varMap['pro_typeRead']}" emptyOption="true" /></td>
			</tr>
			<tr class="listtablehead">
				<td align="left" class="listtabletr11">所属单位：</td>
				<td align="left" class="listtabletr22"><s:buttonText2 name="pso.audit_dept_name" cssStyle="width:90%" hiddenName="pso.audit_dept" doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'所属单位'
								})" doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false" maxlength="100" /></td>
				<td align="left" class="listtabletr11">被审计单位：</td>
				<td align="left" class="listtabletr22"><s:buttonText2 name="pso.audit_object_name" cssStyle="width:90%" hiddenName="pso.audit_object" doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                              cache:false,
							  checkbox:true,
                              height:500,
							  title:'被审计单位'
							})" doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" title="被审单位" maxlength="1500" /></td>
			</tr>
			<tr class="listtablehead">
				<td align="left" class="listtabletr11">项目年度：</td>
				<td align="left" class="listtabletr22" colspan="3"><s:select name="pso.pro_year" list="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" disabled="false" theme="ufaud_simple" templateDir="/strutsTemplate" /></td>
			</tr>
			<tr class="listtablehead">
				<td align="right" class="listtabletr1" colspan="4">
					<DIV align="right">
						<s:submit value="查询" />
						&nbsp; <input type="button" value="重置" onclick="window.location.href='${contextPath}/project/projectReport.action'" />
					</DIV>
				</td>
			</tr>
		</table>
		<center>
			<div id="listProjectDiv" align="center" style="overflow-x: auto;width: 97%;height: 400px;">
				<display:table id="row" name="resultList" class="its" pagesize="${baseHelper.pageSize}" partialList="false" size="${baseHelper.totalRows}" sort="external" defaultorder="descending" requestURI="${contextPath}/project/projectReport.action">

					<display:column title="状态" headerClass="center_nowrap" style="WHITE-SPACE: nowrap" class="center" sortable="true">
						<c:choose>
							<c:when test="${row.pso.is_closed=='closed'}">已关闭</c:when>
							<c:otherwise>正在执行</c:otherwise>
						</c:choose>
					</display:column>

					<display:column title="项目编号" headerClass="center_nowrap" style="WHITE-SPACE: nowrap" class="center" property="pso.project_code" sortable="true" />

					<display:column title="项目名称" headerClass="center_nowrap" sortable="true" media="html" style="WHITE-SPACE: nowrap">
						<a href="/ais/project/prepare/projectIndex.action?crudId=${row.pso.formId}&view=view" target="_blank">${row.pso.project_name}</a>
					</display:column>

					<display:column title="计划类别" headerClass="center_nowrap" class="center" property="pso.plan_type_name" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="年度" headerClass="center_nowrap" class="center" property="pso.pro_year" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="月度" headerClass="center_nowrap" class="center" property="month" sortable="true" style="WHITE-SPACE: nowrap" comparator="ais.framework.displaytag.NumberComparator" />

					<display:column title="执行月度" headerClass="center_nowrap" class="center" property="excute_month" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="计划等级" headerClass="center_nowrap" class="center" property="pso.plan_grade_name" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="项目类别" headerClass="center_nowrap" class="center" property="pso.pro_type_name" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="项目子类别" headerClass="center_nowrap" class="center" property="pso.pro_type_child_name" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="审计单位" headerClass="center_nowrap" class="center" property="pso.audit_dept_name" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="被审计单位" headerClass="center_nowrap" class="center" property="pso.audit_object_name" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="审计期间(起)" headerClass="center_nowrap" class="center" property="pso.audit_start_time" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="审计期间(止)" headerClass="center_nowrap" class="center" property="pso.audit_end_time" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="执行阶段" headerClass="center_nowrap" class="center" sortable="true">
						<c:choose>
							<c:when test="${row.pso.prepare_closed==null || row.pso.prepare_closed=='0' }">准备阶段</c:when>
							<c:when test="${row.pso.prepare_closed=='1' && row.pso.actualize_closed=='0' }">实施阶段</c:when>
							<c:when test="${row.pso.actualize_closed=='1' && row.pso.report_closed=='0' }">终结阶段</c:when>
							<c:when test="${row.pso.report_closed=='1' && row.pso.account_closed=='0' &&row.pso.is_closed=='running' }">台帐阶段</c:when>
							<c:when test="${row.pso.report_closed=='1' && row.pso.rework_closed=='0' }">整改跟踪阶段</c:when>
							<c:when test="${row.pso.rework_closed=='1' && row.pso.archives_closed=='0' }">归档阶段</c:when>
							<c:when test="${row.pso.archives_closed=='1' && row.pso.is_closed=='running' }">等待关闭</c:when>
							<c:when test="${row.pso.is_closed=='closed' }">已关闭</c:when>
						</c:choose>
					</display:column>

					<display:column title="启动日期" headerClass="center_nowrap" class="center" property="pso.real_start_time" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="关闭日期" headerClass="center_nowrap" class="center" property="pso.real_closed_time" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:column title="投入人数" headerClass="center_nowrap" class="center" property="TRRS" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="项目工作天数" headerClass="center_nowrap" class="center" property="XMGZTS" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="人天数" headerClass="center_nowrap" class="center" property="RTS" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="审计问题(条)" headerClass="center_nowrap" class="center" property="SJWTS" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="审计问题金额(元)" headerClass="center_nowrap" class="center" property="SJWTJE" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="查出损失浪费(元)" headerClass="center_nowrap" class="center" property="CCSSLF" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="增加效益(元)" headerClass="center_nowrap" class="center" property="ZJXY" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="发现大案要案线索(件)" headerClass="center_nowrap" class="center" property="DAYAXS" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="提出整改建议" headerClass="center_nowrap" class="center" property="TCZGJY" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="建议被采纳" headerClass="center_nowrap" class="center" property="JYBCN" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="提出处理意见" headerClass="center_nowrap" class="center" property="TCCLYJ" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="意见被采纳" headerClass="center_nowrap" class="center" property="YJBCN" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="行政处分(人)" headerClass="center_nowrap" class="center" property="XZCF" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="经济处罚(元)" headerClass="center_nowrap" class="center" property="JJCF" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="移送纪检监察处理(人)" headerClass="center_nowrap" class="center" property="YSJJJCCL" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="向司法机关移送案件(件)" headerClass="center_nowrap" class="center" property="XSFJGYSAJ" sortable="true" style="WHITE-SPACE: nowrap" />
					<display:column title="移送司法机关处理(人)" headerClass="center_nowrap" class="center" property="YSSFJGCL" sortable="true" style="WHITE-SPACE: nowrap" />

					<display:setProperty name="paging.banner.placement" value="bottom" />

				</display:table>

			</div>
			<div id="buttonDiv" align="right" style="width: 97%">
				<s:if test="${baseHelper.totalRows>0}">
					<input id="exportButton" type="button" value="导出" onclick="showPopWin('${contextPath}/pages/project/start/columnSelector.jsp',500,350)" />
				</s:if>
			</div>
		</center>
	</s:form>
	<script type="text/javascript">
		function execExport(columns) {
			document.getElementById("projectReport").action = "projectReportExport.action?" + columns;
			document.getElementById("projectReport").target = "_self";
			document.getElementById("projectReport").submit();
			document.getElementById("projectReport").action = "projectReport.action";
			document.getElementById("projectReport").target = "_self";
		}
		/*
		 * DisplayTag添加顶层Header
		 */
		function addTopTableHeader() {

			var listTable = document.getElementById('row');
			var tableHead = listTable.firstChild;

			var newHeaderTr = tableHead.insertRow(0);

			var cellOne = newHeaderTr.insertCell();
			cellOne.innerHTML = '项目信息';
			cellOne.colSpan = 17;
			cellOne.style.textAlign = 'center';
			cellOne.style.fontWeight = 'bold';

			var cellTwo = newHeaderTr.insertCell();
			cellTwo.colSpan = 3;
			cellTwo.innerHTML = '工作量';
			cellTwo.style.textAlign = 'center';
			cellTwo.style.fontWeight = 'bold';

			var cellThree = newHeaderTr.insertCell();
			cellThree.colSpan = 5;
			cellThree.innerHTML = '';

			var cellFour = newHeaderTr.insertCell();
			cellFour.colSpan = 4;
			cellFour.innerHTML = '审计整改建议/处理意见(条)';
			cellFour.style.textAlign = 'center';
			cellFour.style.fontWeight = 'bold';

			var cellFive = newHeaderTr.insertCell();
			cellFive.colSpan = 5;
			cellFive.innerHTML = '';

		}
		addTopTableHeader();

		/*
		 *  打开或关闭查询面板
		 */
		function triggerSearchTable() {
			var isDisplay = document.getElementById('searchTable').style.display;
			if (isDisplay == '') {
				document.getElementById('searchTable').style.display = 'none';
			} else {
				document.getElementById('searchTable').style.display = '';
			}
		}
	</script>
</body>
</html>
