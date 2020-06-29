<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>指定项目中所有的审批流程</title>
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

		<link rel="stylesheet"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css"
			type="text/css"></link>
		<link rel="stylesheet"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css"
			type="text/css"></link>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/js/createOrgTree.js"></script>

	</head>
	<script type="text/javascript">
	function open_flow_win(flowdefindid, nodestate, formid) {
		document.getElementById("curr_node_name").value = nodestate;
		window.open("/ais/bpm/definition/viewWebflow4running.action?bpmDefinition.id=" + flowdefindid + "&crudId=" + formid, '流程图例', 'height=660,width=660,status=no,toolbar=no,menubar=no,location=no,resizable=yes');
	}

	/*
	 *  打开或关闭查询面板
	 */
	function triggerSearchTable() {
		var isDisplay = document.getElementById('planTable').style.display;
		if (isDisplay == '') {
			document.getElementById('planTable').style.display = 'none';
		} else {
			document.getElementById('planTable').style.display = '';
		}
	}
	
	function doClear(){
	   $("[name= 'formInfoCondition.formState']").val("0");
	   $("[name= 'formInfoCondition.formType']").val("");
	   $("[name= 'formInfoCondition.formName']").val("");
	   $("[name= 'formInfoCondition.processName']").val("");
	   $("[name= 'formInfoCondition.nodeState']").val("");
	   $("[name= 'formInfoCondition.draftsman']").val("");
	   $("[name= 'formInfoCondition.fromActorId']").val("");
	   $("[name= 'formInfoCondition.toActorId']").val("");
	}
</script>
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable" width="100%" align="center">
		<tr class="listtablehead">
			<td colspan="4" class="edithead"
				style="text-align: left; width: 100%;">
				<div style="display: inline; width: 80%;">
					<s:property value="#request.projectName" />
					&nbsp;的所有审批事项
				</div>
				<div style="display: inline; width: 20%; text-align: right;">
					<a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a>
				</div>
			</td>
		</tr>
	</table>
	<s:form
		action="AuditQualitySupervisionAction!getAllProjectProcessByProjectId.action">
		<table id="planTable" class="ListTable"
			style="display: none; table-layout: fixed;">
			<tr class="listtablehead" height="23">
				<td align="left" class="listtabletr11">
					流程状态
				</td>
				<td align="left" class="listtabletr22">
					<s:select list="#@java.util.LinkedHashMap@{0:'',1:'审核中',3:'已通过'}"
						name="formInfoCondition.formState" listKey="key" listValue="value" />
				</td>
				<td align="left" class="listtabletr11">
					表单类型
				</td>
				<td align="left" class="listtabletr22">
					<s:select
						list="#@java.util.LinkedHashMap@{'':'','1004':'实施方案','1040':'审计底稿','1006':'审计报告','1007':'整改跟踪','1008':'项目归档'}"
						name="formInfoCondition.formType" listKey="key" listValue="value" />
				</td>
				<td align="left" class="listtabletr11">
					表单名称
				</td>
				<td align="left" class="listtabletr22">
					<s:textfield name="formInfoCondition.formName"  maxlength="50"  />
				</td>
			</tr>
			<tr class="listtablehead" height="23">
				<td align="left" class="listtabletr11">
					流程名称
				</td>
				<td align="left" class="listtabletr22">
					<s:textfield name="formInfoCondition.processName" maxlength="50"  /></td>
				<td align="left" class="listtabletr11">
					任务名称
				</td>
				<td align="left" class="listtabletr22">
					<s:textfield name="formInfoCondition.nodeState" maxlength="50" />
				</td>
				<td align="left" class="listtabletr11">
					流程发起人
				</td>
				<td align="left" class="listtabletr22">
					<s:buttonText2 name="formInfoCondition.draftsman" id="draftsman"
						cssStyle="color:gray;"
						doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
	                                  param:{
	                                     'p_item':1,
	                                     'orgtype':1
	                                  },
	                                  singleSelect:true,
	                                  title:'请选择系统账号',
	                                  type:'treeAndUnEmployee'
									})"
						doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
						readonly="true" doubleCssStyle="cursor:hand;border:0;color:Gray;"
						doubleDisabled="false" maxlength="500" title="系统账号" />
				</td>
			</tr>
			<tr class="listtablehead" height="23">
				<td align="left" class="listtabletr11">
					上一步处理人
				</td>
				<td align="left" class="listtabletr22">
					<s:buttonText2 name="formInfoCondition.fromActorId"
						id="fromActorId" cssStyle="color:gray;"
						doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
	                                  param:{
	                                     'p_item':1,
	                                     'orgtype':1
	                                  },
	                                  singleSelect:true,
	                                  title:'请选择系统账号',
	                                  type:'treeAndUnEmployee'
									})"
						doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
						readonly="true" doubleCssStyle="cursor:hand;border:0;color:Gray;"
						doubleDisabled="false" maxlength="500" title="系统账号" />
				</td>
				<td align="left" class="listtabletr11">
					下一步处理人
				</td>
				<td align="left" class="listtabletr22" colspan="3">
					<s:buttonText2 name="formInfoCondition.toActorId" id="toActorId"
						cssStyle="color:gray;"
						doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
	                                  param:{
	                                     'p_item':1,
	                                     'orgtype':1
	                                  },
	                                  singleSelect:true,
	                                  title:'请选择系统账号',
	                                  type:'treeAndUnEmployee'
									})"
						doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
						readonly="true" doubleCssStyle="cursor:hand;border:0;color:Gray;"
						doubleDisabled="false" maxlength="500" title="系统账号" />
				</td>
			</tr>
			<tr class="listtablehead" height="23">
				<td align="right" class="listtabletr1" colspan="6">
					<DIV align="right" style="padding-right:5px;">
						<s:submit value="查询" />
						&nbsp;&nbsp;
						<input type="button" value="重置"
							onclick="doClear()">
					</DIV>
				</td>
			</tr>
		</table>
		<input type=hidden id="curr_node_name" value="" />
		<div align="center">
			<display:table id="row" name="projectProcesstList" class="its"
				cellpadding="1" pagesize="15"
				requestURI="${contextPath}/ais/qualitySupervision/AuditQualitySupervisionAction!projectProcesstList.action">
				<display:column title="流程状态" style="WHITE-SPACE: nowrap"
					sortable="true">
					<s:if test="${row.formState == '3'}">已通过</s:if>
					<s:elseif test="${row.formState == '1'}">审核中</s:elseif>
				</display:column>
				<display:column property="processName" title="流程名称"
					style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column title="表单类型" style="WHITE-SPACE: nowrap"
					sortable="true">
					<s:if test="${row.formType == '1004'}">实施方案</s:if>
					<s:elseif test="${row.formType == '1040'}">审计底稿</s:elseif>
					<s:elseif test="${row.formType == '1006'}">审计报告</s:elseif>
					<s:elseif test="${row.formType == '1007'}">整改跟踪</s:elseif>
					<s:elseif test="${row.formType == '1008'}">项目归档</s:elseif>
				</display:column>
				<display:column property="formName" title="表单名称"
					style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="nodeState" title="任务名称"
					style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="nowNodeCreateTime" title="创建时间"
					style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="draftsman" title="流程发起人"
					style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="fromActorId" title="上一步处理人"
					style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="toActorId" title="下一步处理人"
					style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column property="nowNodeUrgeTime" title="催办时间"
					style="WHITE-SPACE: nowrap" sortable="true" />
				<display:column title="操作" style="WHITE-SPACE: nowrap"
					sortable="true">
					<a href="javascript:void(0);"
						onclick="javascript:window.open('${contextPath}${row.viewLink}','表单信息','height=660,width=660,status=no,toolbar=no,menubar=no,location=no,resizable=yes,scrollbars=1')">查看表单</a>&nbsp;&nbsp;
				<a href="javascript:void(0);"
						onclick="javascript:open_flow_win('${row.processId}','${row.nodeState}','${row.formId}');">查看流程图例</a>&nbsp;&nbsp;
			    <c:if
						test="${row.toActorId == user.floginname && row.formState == '1'}">
						<a href="${contextPath}${row.taskEditUrl}">处理</a>
						<c:choose>
							<c:when
								test="${fn:startsWith(row.resetLink, '?') || fn:startsWith(row.resetLink, '&&')}">
								<a
									href="${pageContext.request.contextPath}/bpm/taskinstance/separateBpm.action?crudId=${row.formId}"
									onclick="return confirm('确认此操作吗？')">回收</a>
							</c:when>
							<c:otherwise>
								<a href="${contextPath}${row.resetLink}"
									onclick="return confirm('确认此操作吗？')">回收</a>
							</c:otherwise>
						</c:choose>
					</c:if>
				</display:column>
			</display:table>
		</div>
	</s:form>
	<div align="right">
		<input style="cursor: pointer;" type="button"
			onclick="window.location = '${contextPath}/ais/qualitySupervision/AuditQualitySupervisionAction!getAuditQualitySupervisionList.action'"
			value="返回" />
		<span style="width: 15px"></span>
	</div>
	</body>
</html>