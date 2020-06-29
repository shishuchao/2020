<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>月度计划--预选项目信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					&nbsp;预选项目信息
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					计划状态：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.status_name" />
				</td>
				<td class="ListTableTr11" nowrap>
					年度计划编号：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_code" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					计划年度：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_year" />
				</td>
				<td class="ListTableTr11">
					计划月度：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_month" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					预选项目名称：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_name" />
				</td>
				<td class="ListTableTr11">
					负责人：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.pro_teamleader_name"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					计划类别：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.w_plan_type_name"/>
				</td>
				<td class="ListTableTr11">
					项目类别：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.pro_type_name" />
					&nbsp;&nbsp;
					<s:property value="workPlanDetail.pro_type_child_name" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					审计实施单位：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_dept_name"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					被审单位：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_object_name" />
				</td>
			</tr>
			<s:if test="workPlanDetail.jjzrr">
				<tr>
					<td class="ListTableTr11">
						经济责任人：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:property value="workPlanDetail.jjzrrname"/>
					</td>
				</tr>
			</s:if>
			<s:if test="workPlanDetail.rework">
				<tr>
					<td class="ListTableTr11">
						后续审计项目：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:property value="workPlanDetail.reworkProjectNames"/>
					</td>
				</tr>
			</s:if>
			<tr>
				<td class="ListTableTr11">
					预计开始日期：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.pro_starttime"/>
				</td>
				<td class="ListTableTr11">
					预计结束日期：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.pro_endtime"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap>
					审计对象数据开始：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.audit_start_time"/>
				</td>
				<td class="ListTableTr11" nowrap>
					审计对象数据结束：
				</td>
				<td class="ListTableTr22">
					<s:property value="workPlanDetail.audit_end_time"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					正文内容：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:textarea name="workPlanDetail.content" readonly="true"
						cssStyle="width:100%;height:20;overflow-y:visible;border:0"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					完成形式：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:textarea name="workPlanDetail.handle_modus" readonly="true"
						cssStyle="width:100%;height:20;overflow-y:visible;border:0"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					审计目的：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_purpose"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					审计范围：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_scope"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					审计依据：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.audit_basis"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					备注：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="workPlanDetail.plan_remark"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					附    件：
				</td>
				<td class="ListTableTr22" colspan="3">
					<div id="accelerys" align="center">
						<s:property escape="false" value="accessoryList" />
					</div>
				</td>
			</tr>
		</table>
  </body>
</html>
