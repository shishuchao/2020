<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>项目质量控制列表(总表)</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>

</head>
<body>
	<table cellpadding=0 cellspacing=0 border=0 bgcolor="#409cce" class="ListTable" width="100%" align="center">
		<tr class="listtablehead">
			<td colspan="4" class="edithead" style="text-align: left; width: 100%;">
				<span style="display: inline; width: 80%;float: left;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/qualitySupervision/AuditQualitySupervisionAction!getAuditQualitySupervisionList.action')" />
				</span>
				<span style="float: right;"><a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a></span>
			</td>
		</tr>
	</table>
	<s:form name="myform" action="AuditQualitySupervisionAction!getAuditQualitySupervisionList" namespace="/qualitySupervision">
		<table id="searchTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center" style="display: none; table-layout: fixed;">
			<tr class="listtablehead" height="23">
				<td align="left" class="listtabletr11">项目编号</td>
				<td align="left" class="listtabletr22"><s:textfield name="projectStartObject.project_code" maxlength="50" /></td>
				<td align="left" class="listtabletr11">项目名称</td>
				<td align="left" class="listtabletr22"><s:textfield name="projectStartObject.project_name" maxlength="50" /></td>
			</tr>
			<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						所属单位
					</td>
					<td align="left" class="listtabletr22">
						<s:buttonText2 name="projectStartObject.audit_dept_name"
							hiddenName="projectStartObject.audit_dept"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'审计单位',
                                  param:{
                                    'p_item':1,
                                    'orgtype':1
                                  }
								})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
					<td align="left" class="listtabletr11">
						被审计单位
					</td>
					<td align="left" class="listtabletr22">
						<s:buttonText2 name="projectStartObject.audit_object_name"
							hiddenName="projectStartObject.audit_object"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                              cache:false,
							  checkbox:true,
                              height:500,
							  title:'被审计单位树'
							})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
			<tr class="listtablehead" height="23">
				<td align="right" class="listtabletr1" colspan="4">
					<DIV align="right">
						<s:button value="查询" onclick="myform.submit();" />
						&nbsp; <input type="button" value="重置" onclick="doClean()" />
					</DIV>
				</td>
			</tr>
		</table>
		<div align="center">
			<display:table id="row" name="projectStartObjectList" class="its" cellpadding="1" style="width:100%;" pagesize="15" requestURI="${contextPath}/ais/qualitySupervision/AuditQualitySupervisionAction!getAuditQualitySupervisionList.action">
				<display:column title="项目状态" style="WHITE-SPACE: nowrap" sortable="true">
					<s:if test="${row.is_closed == 'running'}">进行中</s:if>
					<s:else>已关闭</s:else>
				</display:column>
				<display:column property="project_code" title="项目编号" style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column title="项目名称" style="WHITE-SPACE: nowrap" sortable="true">
					<a href="javascript:void(0)" onclick="seeAllProcess('${row.formId}')">${row.project_name}</a>
				</display:column>
				<display:column property="plan_type_name" title="项目类别" style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="audit_dept_name" title="审计单位" style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="audit_object_name" title="被审计单位" style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="pro_teamleader_name" title="项目组长" style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="pro_auditleader_name" title="项目主审" style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column title="审计通知书" style="WHITE-SPACE: nowrap" sortable="true">
					<s:if test="${row.audAdviceFormInfo.formState == '1'}">
						<s:if test="${row.audAdviceFormInfo.toActorId == user.floginname}">
							<a href="${contextPath}${row.audAdviceFormInfo.taskEditUrl}">审核中</a>
						</s:if>
						<s:else>
							<a href="${contextPath}${row.audAdviceFormInfo.taskEditUrl}&view=view&taskview=view">审核中</a>
						</s:else>
					</s:if>
					<s:elseif test="${row.audAdviceFormInfo.formState == '3'}">
						<a href="javascript:void(0)" onclick="seeHasDone('${row.audAdviceFormInfo.formId}','${row.project_name}')">已通过</a>
					</s:elseif>
					<s:else>-</s:else>
				</display:column>
				<display:column title="实施方案" style="WHITE-SPACE: nowrap" sortable="true">
					<s:if test="${row.implementationPlanFormInfo.formState == '1'}">
						<s:if test="${row.implementationPlanFormInfo.toActorId == user.floginname}">
							<a href="${contextPath}${row.implementationPlanFormInfo.taskEditUrl}">审核中</a>
						</s:if>
						<s:else>
							<a href="${contextPath}${row.implementationPlanFormInfo.taskEditUrl}&view=view&taskview=view">审核中</a>
						</s:else>
					</s:if>
					<s:elseif test="${row.implementationPlanFormInfo.formState == '3'}">
						<a href="javascript:void(0)" onclick="seeHasDone('${row.implementationPlanFormInfo.formId}','${row.project_name}')">已通过</a>
					</s:elseif>
					<s:else>-</s:else>
				</display:column>
				<display:column title="审计底稿</br>(审核中/已通过)" headerClass="center" style="WHITE-SPACE: nowrap" sortable="true">
					<a  onclick="goAllManuscriptProcess('${row.formId}','${row.project_name}')" href="javascript:void(0)">${row.audPapersProportion }</a>
				</display:column>
				<display:column title="审计报告" style="WHITE-SPACE: nowrap" sortable="true">
					<s:if test="${row.auditReportFormInfo.formState == '1'}">
						<s:if test="${row.auditReportFormInfo.toActorId == user.floginname}">
							<a href="${contextPath}${row.auditReportFormInfo.taskEditUrl}">审核中</a>
						</s:if>
						<s:else>
							<a href="${contextPath}${row.auditReportFormInfo.taskEditUrl}&view=view&taskview=view">审核中</a>
						</s:else>
					</s:if>
					<s:elseif test="${row.auditReportFormInfo.formState == '3'}">
						<a href="javascript:void(0)" onclick="seeHasDone('${row.auditReportFormInfo.formId}','${row.project_name}')">已通过</a>
					</s:elseif>
					<s:else>-</s:else>
				</display:column>
				<display:column title="项目归档" style="WHITE-SPACE: nowrap" sortable="true">
					<s:if test="${row.projectArchiveFormInfo.formState == '1'}">
						<s:if test="${row.projectArchiveFormInfo.toActorId == user.floginname}">
							<a href="${contextPath}${row.projectArchiveFormInfo.taskEditUrl}">审核中</a>
						</s:if>
						<s:else>
							<a href="${contextPath}${row.projectArchiveFormInfo.taskEditUrl}&view=view&taskview=view">审核中</a>
						</s:else>
					</s:if>
					<s:elseif test="${row.projectArchiveFormInfo.formState == '3'}">
						<a href="javascript:void(0)" onclick="seeHasDone('${row.projectArchiveFormInfo.formId}','${row.project_name}')">已通过</a>
					</s:elseif>
					<s:else>-</s:else>
				</display:column>
				<display:column title="整改跟踪" style="WHITE-SPACE: nowrap;" sortable="true">
					<s:if test="${row.rectificationTrackingFormInfo.formState == '1'}">
						<s:if test="${row.rectificationTrackingFormInfo.toActorId == user.floginname}">
							<a href="${contextPath}${row.rectificationTrackingFormInfo.taskEditUrl}">审核中</a>
						</s:if>
						<s:else>
							<a href="${contextPath}${row.rectificationTrackingFormInfo.taskEditUrl}&view=view&taskview=view">审核中</a>
						</s:else>
					</s:if>
					<s:elseif test="${row.rectificationTrackingFormInfo.formState == '3'}">
						<a href="javascript:void(0)" onclick="seeHasDone('${row.rectificationTrackingFormInfo.formId}','${row.project_name}')">已通过</a>
					</s:elseif>
					<s:else>-</s:else>
				</display:column>
			</display:table>
		</div>
		<div id="hasDoneProcessDiv"></div>
		</s:form>
</body>
<script type="text/javascript">
	function seeAllProcess(projectid) {
		window.location = "${contextPath}/ais/qualitySupervision/AuditQualitySupervisionAction!getAllProjectProcessByProjectId.action?projectStartFormId=" + projectid;
	}

	function seeHasDone(formId, projectName) {
		$('#hasDoneProcessDiv').dialog({
			title : projectName,
			width : 800,
			height : 300,
			closed : false,
			cache : false,
			href : '${contextPath}/ais/qualitySupervision/AuditQualitySupervisionAction!getHasDoneProcessByFormId.action?formId=' + formId,
			modal : true
		});
	}
	
	function doClean(){
		$("[name='projectStartObject.project_code']").val("");
		$("[name='projectStartObject.project_name']").val("");
		$("[name='projectStartObject.audit_dept_name']").val("");
		$("[name='projectStartObject.audit_dept']").val("");
		$("[name='projectStartObject.audit_object_name']").val("");
		$("[name='projectStartObject.audit_object']").val("");
	}
	
	function goAllManuscriptProcess(projectid,projectName){
		window.location.href = "${contextPath}/ais/qualitySupervision/AuditQualitySupervisionAction!allManuscriptProcess.action?projectId="+projectid+"&projectName="+encodeURI(encodeURI(projectName));
	}

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
</html>