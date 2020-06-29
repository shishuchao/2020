<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>年度计划--明细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
  </head>
  
  <body>
		<table cellpadding=0 cellspacing=1 border=0 class="ListTable" align="center">
			<tr >
				<td colspan="4"  class="edithead">
					<font style="float: left;">明细计划信息</font>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					计划状态
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.status_name" />
				</td>
				<td class="EditHead" nowrap>
					年度计划编号
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.w_plan_code" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					计划年度
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.w_plan_year" />
				</td>
				<td class="EditHead">
					计划月度
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.w_plan_month" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					计划名称
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.w_plan_name" />
				</td>
				<td class="EditHead">
					负责人
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.pro_teamleader_name"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					计划类别
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.w_plan_type_name"/>
				</td>
				<td class="EditHead">
					项目类别
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.pro_type_name" />
					&nbsp;&nbsp;
					<s:property value="workPlanDetail.pro_type_child_name" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					审计单位
				</td>
				<td class="editTd" colspan="3">
					<s:property value="workPlanDetail.audit_dept_name"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					被审单位
				</td>
				<td class="editTd" colspan="3">
					<s:property value="workPlanDetail.audit_object_name" />
				</td>
			</tr>
			<s:if test="workPlanDetail.jjzrr">
				<tr>
					<td class="EditHead">
						经济责任人
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workPlanDetail.jjzrrname"/>
					</td>
				</tr>
			</s:if>
			<s:if test="workPlanDetail.rework">
				<tr>
					<td class="EditHead">
						后续审计项目
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workPlanDetail.reworkProjectNames"/>
					</td>
				</tr>
			</s:if>
			<tr>
				<td class="EditHead">
					开始日期
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.pro_starttime"/>
				</td>
				<td class="EditHead">
					结束日期
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.pro_endtime"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap>
					审计期间开始
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.audit_start_time"/>
				</td>
				<td class="EditHead" nowrap>
					审计期间结束
				</td>
				<td class="editTd">
					<s:property value="workPlanDetail.audit_end_time"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					正文内容
				</td>
				<td class="editTd" colspan="3">
					<s:textarea name="workPlanDetail.content" readonly="true"
						cssStyle="width:100%;height:20;overflow-y:visible;border:0"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					完成形式
				</td>
				<td class="editTd" colspan="3">
					<s:textarea name="workPlanDetail.handle_modus" readonly="true"
						cssStyle="width:100%;height:20;overflow-y:visible;border:0"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					审计目的
				</td>
				<td class="editTd" colspan="3">
					<s:property value="workPlanDetail.audit_purpose"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					审计范围
				</td>
				<td class="editTd" colspan="3">
					<s:property value="workPlanDetail.audit_scope"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					审计依据
				</td>
				<td class="editTd" colspan="3">
					<s:property value="workPlanDetail.audit_basis"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					备注
				</td>
				<td class="editTd" colspan="3">
					<s:property value="workPlanDetail.plan_remark"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					附    件
				</td>
				<td class="editTd" colspan="3">
					<div id="accelerys" align="center">
						<s:property escape="false" value="accessoryList" />
					</div>
				</td>
			</tr>
		</table>
  </body>
</html>
