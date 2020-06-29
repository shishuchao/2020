<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>项目计划</title>
			<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	</head>

<body style="margin: 0;padding: 0;overflow:auto;" >
			<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td colspan="4"  class="EditHead">
						&nbsp;<span style="float:left">项目计划信息</span>

					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width: 20%">
						计划状态
					</td>
					<td class="editTd" style="width: 30%">
						<s:property value="workplanDetail.status_name" />
					</td>
					<td class="EditHead" style="width: 20%">
						计划编号
					</td>
					<td class="editTd" style="width: 30%">
						<s:property value="workplanDetail.w_plan_code" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						计划年度
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.w_plan_year" />
					</td>
					<td class="EditHead">
						计划月度
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.w_plan_month" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						项目名称
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.w_plan_name" />
					</td>
					<td class="EditHead">
						计划类别
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.w_plan_type_name"/>
					</td>
				</tr>
				<tr>
					<%-- 
					<td class="EditHead">
						计划等级
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.plan_grade_name"/>
					</td>
					--%>
					<td class="EditHead">
						项目类别
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.pro_type_name"/>
							&nbsp;&nbsp;
						<s:property value="workplanDetail.pro_type_child_name"/>
					</td>
				</tr>
				<s:if test="${!workplanDetail.nbzwpg}">
				<tr>
					<td class="EditHead">
						审计单位
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.audit_dept_name"/>
					</td>
					<td class="EditHead">
						被审计单位
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.audit_object_name"/>
					</td>
				</tr>
				</s:if>
				<s:else>
					<td class="EditHead">
						测试组织者
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.audit_dept_name"/>
					</td>
				</s:else>
				<tr>

				   <td class="EditHead">上次审计年度</td>
				   <td class="editTd" >

				       <s:property value="workplanDetail.lastAudYear"/>
				   </td>
				   <td class="EditHead">上次审计类型</td>
				   <td  class="editTd">

				      <s:property value="workplanDetail.lastProTypeName"/>
				   </td>
				</tr>
				<!-- <tr>
				   <td class="EditHead">风险值：</td>
				   <td colspan="3" >
				      <s:property value="workplanDetail.riskValue"/>
				   </td>
				</tr> -->
				<!-- 工程项目审计 -->
				<s:if test="workplanDetail.gcxmsj">

				<tr >
					<td class="EditHead" id="gcxmTd1">

				<tr id="gcxmTr1">
					<td class="EditHead" id="gcxmTd1">

						合同金额
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.contractAmount"/>万元
					</td>
					<td class="EditHead" id="gcxmTd2">
						项目管理模式
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.managerType"/>
					</td>
				</tr>

				<tr  >
					<td class="EditHead" id="gcxmTd3">

				<tr id="gcxmTr2" >
					<td class="EditHead" id="gcxmTd3">

						开工日期
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.startProDate"/>
					</td>
					<td class="EditHead" id="gcxmTd4">
						竣工日期
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.finishProDate"/>
					</td>
				</tr>

				<tr  >
					<td class="EditHead" id="gcxmTd5">

				<tr id="gcxmTr3" >
					<td class="EditHead" id="gcxmTd5">

						项目状态
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.proStatus"/>
					</td>
				</tr>
				</s:if>
				<s:if test="workplanDetail.jjzrr">
					<tr>
						<td class="EditHead">
							经济责任人
						</td>
						<td class="editTd" colspan="3">
							<s:property value="workplanDetail.jjzrrname"/>
						</td>
						<!-- <td class="EditHead">
							是否为总公司党组管理干部
						</td>
						<td class="editTd" >
							<s:if test="${workplanDetail.isDangLeader=='true'}">
								是
							</s:if>
							<s:else>
								否
							</s:else>
						</td> -->
					</tr>
				</s:if>
				<s:if test="workplanDetail.rework">
					<tr>
						<td class="EditHead">
							后续审计项目
						</td>
						<td class="editTd" colspan="3">
							<s:property value="workplanDetail.reworkProjectNames"/>
						</td>
					</tr>
				</s:if>
				<s:if test="${!workplanDetail.nbzwpg}">
				<tr>
				<td class="EditHead" id="aditDeptTd">
						项目领导
					</td>
					<td class="editTd" colspan="3">
					<s:property value="workplanDetail.pro_teamcharge_name"/>
                    </td>
				</tr>
				<tr>
					<td class="EditHead">
						项目组长
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_teamleader_name"/>
					</td>
					<td class="EditHead">
						项目主审
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_auditleader_name"/>
					</td>
				</tr>
				</s:if>
				<s:else>
					<tr>
					<td class="EditHead">
						内控专岗负责人
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.pro_teamleader_name"/>
					</td>
				</tr>
				</s:else>
			
				<tr>
					<td class="EditHead">
						项目开始日期
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_starttime"/>
					</td>
					<td class="EditHead">
						项目结束日期
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_endtime"/>
					</td>
				</tr>
			<s:if test="${!workplanDetail.nbzwpg}">
				<tr>
					<td class="EditHead" nowrap>
						审计期间开始
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.audit_start_time"/>
					</td>
					<td class="EditHead" nowrap>
						审计期间结束
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.audit_end_time"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap>
						<%-- 正文内容： --%>
							立项依据
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.content"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计方式
					</td>
					<td class="editTd" colspan="3">
						<!--<s:select id="handle_modus" name="workplanDetail.handle_modus" 
						list="basicUtil.completed_FormList" listKey="code" listValue="name"
						disabled="true"
						display="${varMap['handle_modusRead']}" theme="ufaud_simple"
						templateDir="/strutsTemplate" emptyOption="true"/>-->
						<s:property escape="false" value="basicUtil.getCOMPLETEDFORMNameByCode('${workplanDetail.handle_modus}')"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计目的
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.audit_purpose"/>
					</td>
				</tr>
				<%-- <tr>
					<td class="EditHead">
						审计范围：
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.audit_scope"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计依据：
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.audit_basis"/>
					</td>
				</tr>
				--%>
				<tr>
					<td class="EditHead">
						审计安排
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.audArrange"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计重点
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.audEmphasis"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						备注
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.plan_remark"/>
					</td>
				</tr>
				<tr>
					<%-- <td class="EditHead">
						附件
					</td>
					<td class="editTd" colspan="3">
						<div id="accelerys" align="center">
							<s:property escape="false" value="accessoryList" />
						</div>
					</td> --%>
			<%-- 		
					<td class="EditHead" >附件
						<s:hidden id="w_file" name="workplanDetail.w_file" />
					</td>
					<td class="editTd" colspan="3" >
						<div data-options="fileGuid:'${workplanDetail.w_file}'"  class="easyui-fileUpload" ></div>
					</td>
					 --%>
					
				</tr>
			</s:if>
			</table>
			
	</body>
</html>
