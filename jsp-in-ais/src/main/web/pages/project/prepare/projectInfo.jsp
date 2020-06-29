<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>项目信息</title>
     	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
	</head>
	
	<body class="easyui-layout">
		<div region="center">
			<table class="ListTable" style="width:100%">
				<tr>
					<td class="EditHead" style="width:15%">项目名称</td>
					<td class="editTd" style="width:35%"><s:property
							value="projectStartObject.project_name" /></td>
					<td class="EditHead" style="width:15%">项目编号</td>
					<td class="editTd" style="width:35%"><input type="hidden"
											  name="projectStartObject.project_code"
											  value="${projectStartObject.project_code }"> <s:property
							value="projectStartObject.project_code" /></td>
				</tr>
				<tr>
					<td class="EditHead">项目年度</td>
					<td class="editTd"><s:property
							value="projectStartObject.pro_year" /></td>
					<td class="EditHead">项目月度</td>
					<td class="editTd"><s:property
							value="workPlanDetail.w_plan_month" /></td>
				</tr>
				<tr>
					<td class="EditHead">审计单位</td>
					<td class="editTd"><s:property
							value="projectStartObject.audit_dept_name" /></td>
					<td class="EditHead">项目类别</td>
					<td class="editTd"><s:property
							value="projectStartObject.pro_type_name" /> &nbsp;&nbsp; <s:property
							value="projectStartObject.pro_type_child_name" /></td>
				</tr>
				<tr>
					<td class="EditHead">被审计单位</td>
					<td class="editTd" colspan="3"><s:property
							value="projectStartObject.audit_object_name" /></td>
				</tr>
				<s:if test="projectStartObject.jjzrr">
					<tr>
						<td class="EditHead">
							经济责任人
						</td>
						<td class="editTd" colspan="3">
							<s:property value="projectStartObject.jjzrrname"/>
						</td>
					</tr>
				</s:if>
				<tr>
					<td class="EditHead">
						审计方式
					</td>
					<td class="editTd">
						<s:property escape="false" value="basicUtil.getCOMPLETEDFORMNameByCode('${workPlanDetail.handle_modus}')"/>
					</td>
					<s:if test="${workPlanDetail.agencyName != null && workPlanDetail.agencyName != ''}">
					<td class="EditHead" id="td_agency01">
						中介机构
					</td>
					<td class="editTd" id="td_agency02">
						<s:property escape="false" value="workPlanDetail.agencyName"/>
					</td>
					</s:if>
				</tr>
				<tr>
					<td class="EditHead">计划类别</td>
					<td class="editTd"><s:property
							value="projectStartObject.plan_type_name" /></td>
					<td class="EditHead">计划等级</td>
					<td class="editTd" colspan="3"><s:property
							value="projectStartObject.plan_grade_name" /></td>
				</tr>

				<!-- 工程项目审计 -->
				<s:if test="projectStartObject.gcxmsj">
					<tr id="gcxmTr1">
						<td class="EditHead" id="gcxmTd1">合同金额</td>
						<td class="editTd"><s:property
								value="projectStartObject.contractAmount" />万元</td>
						<td class="EditHead" id="gcxmTd2">项目管理模式</td>
						<td class="editTd"><s:property
								value="projectStartObject.managerType" /></td>
					</tr>
					<tr id="gcxmTr2">
						<td class="EditHead" id="gcxmTd3">开工日期</td>
						<td class="editTd"><s:property
								value="projectStartObject.startProDate" /></td>
						<td class="EditHead" id="gcxmTd4">竣工日期</td>
						<td class="editTd"><s:property
								value="projectStartObject.finishProDate" /></td>
					</tr>
					<tr id="gcxmTr3">
						<td class="EditHead" id="gcxmTd5">项目状态</td>
						<td class="editTd" colspan="3"><s:property
								value="projectStartObject.proStatus" /></td>
					</tr>
				</s:if>
				<s:if test="projectStartObject.rework">
					<tr>
						<td class="EditHead">后续审计项目</td>
						<td class="editTd" colspan="3"><s:property
								value="projectStartObject.reworkProjectNames" /></td>
					</tr>
				</s:if>
				<tr>
					<td class="EditHead">开始日期</td>
					<td class="editTd"><s:property
							value="projectStartObject.pro_starttime" /></td>
					<td class="EditHead">结束日期</td>
					<td class="editTd"><s:property
							value="projectStartObject.pro_endtime" /></td>
				</tr>
				<s:if test="${!projectStartObject.nbzwpg}">
					<tr>
						<td class="EditHead" nowrap><s:if
								test="varMap['audit_start_timeRequired']">
							<font color=red>*</font>
						</s:if> 审计期间开始</td>
						<td class="editTd"><s:property
								value="projectStartObject.audit_start_time" /> <input
								type="hidden" name="projectStartObject.audit_start_time"
								value="${projectStartObject.audit_start_time }"></td>
						<td class="EditHead" nowrap><s:if
								test="varMap['audit_end_timeRequired']">
							<font color=red>*</font>
						</s:if> 审计期间结束</td>
						<td class="editTd"><s:property
								value="projectStartObject.audit_end_time" /> <input type="hidden"
																					name="projectStartObject.audit_end_time"
																					value="${projectStartObject.audit_end_time }"></td>
					</tr>
					<tr>
						<td class="EditHead" style="width:15%">
							作业模式
						</td>
						<td class="editTd" style="width:35%">
							在线
						</td>
						<td class="EditHead" style="width:15%">
							审计流程
						</td>
						<td class="editTd" style="width:35%">
							<s:if test="${projectStartObject.planProcess == 'standard'}">
								标准流程
							</s:if>
							<s:elseif test="${projectStartObject.planProcess == 'simplified'}">
								简易流程
							</s:elseif>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							立项依据
						</td>
						<td class="editTd" colspan="3">
							<s:property value="workPlanDetail.content" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							审计目的
						</td>
						<td class="editTd" colspan="3">
							<s:property value="projectStartObject.audit_purpose" />
						</td>
					</tr>
					<tr >
						<td class="EditHead">
							审计安排
						</td>
						<td class="editTd" colspan="3">
							<s:property value="projectStartObject.audArrange" />
						</td>
					</tr>
					<tr >
						<td class="EditHead">
							审计重点
						</td>
						<td class="editTd" colspan="3">
							<s:property value="projectStartObject.audEmphasis"/>
						</td>
					</tr>

					<tr>
						<td class="EditHead">
							备注
						</td>
						<td class="editTd" colspan="3">
							<s:property value="projectStartObject.plan_remark"/>
						</td>
					</tr>
				</s:if>
			</table>
		</div>
	</body>
</html>
