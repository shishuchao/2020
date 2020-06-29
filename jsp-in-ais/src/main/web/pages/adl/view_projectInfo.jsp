<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<html>
	<title>查看项目信息</title>
	<head>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	</head>
	
<body>
	<div style='text-align:left;'>
		<table id="projectStartTable" class="ListTable" style="width:100%;text-align:left;">
			<tr>
				<td class="EditHead" width="20%">项目名称</td>
				<td class="editTd" width="30%">
                    <s:property value="projectStartObject.project_name" />
                </td>
				<td class="EditHead" width="20%">项目编号</td>
				<td class="editTd" width="30%">
                    <input type="hidden" name="projectStartObject.project_code" value="${projectStartObject.project_code }"> 
                    <s:property value="projectStartObject.project_code" />
               </td>
			</tr>
			<tr>
				<td class="EditHead">项目年度</td>
				<td class="editTd">
                    <s:property value="projectStartObject.pro_year" />
                </td>
				<td class="EditHead">项目类别</td>
				<td class="editTd">
                    <s:property value="projectStartObject.pro_type_name" /> &nbsp;&nbsp; 
                    <s:property value="projectStartObject.pro_type_child_name" />
                </td>
			</tr>
			<tr>
				<td class="EditHead">计划类别</td>
				<td class="editTd" colspan="3">
                    <s:property value="projectStartObject.plan_type_name" />
                </td>
			</tr>
			<s:if test="${!projectStartObject.nbzwpg}">
				<tr>
					<td class="EditHead">审计单位</td>
					<td class="editTd">
                        <s:property value="projectStartObject.audit_dept_name" />
                    </td>
					<td class="EditHead">被审计单位</td>
					<td class="editTd">
                        <s:property value="projectStartObject.audit_object_name" />
                    </td>
				</tr>
			</s:if>
			<s:else>
				<td class="EditHead">测试组织者</td>
				<td class="editTd">
                    <s:property value="projectStartObject.audit_dept_name" />
                </td>
				<td class="EditHead">测内控专岗负责人</td>
				<td class="editTd">
                    <s:property value="projectStartObject.pro_teamleader_name" />
                </td>
			</s:else>
			<!-- 工程项目审计 -->
			<s:if test="projectStartObject.gcxmsj">
				<tr id="gcxmTr1">
					<td class="EditHead" id="gcxmTd1">合同金额</td>
					<td class="editTd">
                        <s:property value="projectStartObject.contractAmount" />万元
                    </td>
					<td class="EditHead" id="gcxmTd2">项目管理模式</td>
					<td class="editTd">
                        <s:property value="projectStartObject.managerType" />
                    </td>
				</tr>
				<tr id="gcxmTr2">
					<td class="EditHead" id="gcxmTd3">开工日期</td>
					<td class="editTd">
                        <s:property value="projectStartObject.startProDate" />
                    </td>
					<td class="EditHead" id="gcxmTd4">竣工日期</td>
					<td class="editTd">
                        <s:property value="projectStartObject.finishProDate" />
                    </td>
				</tr>
				<tr id="gcxmTr3">
					<td class="EditHead" id="gcxmTd5">项目状态</td>
					<td class="editTd" colspan="3">
                        <s:property value="projectStartObject.proStatus" />
                    </td>
				</tr>
			</s:if>

			<s:if test="projectStartObject.jjzrr">
				<tr>
					<td class="EditHead">经济责任人</td>
					<td class="editTd">
                        <s:property value="projectStartObject.jjzrrname" />
                    </td>
					<td class="EditHead">是否为总公司党组管理干部</td>
					<td class="editTd">
                        <s:if test="${projectStartObject.isDangLeader=='true'}">是</s:if>
                        <s:else>否</s:else>
                   </td>
				</tr>
			</s:if>
			<s:if test="projectStartObject.rework">
				<tr>
					<td class="EditHead">后续审计项目</td>
					<td class="editTd" colspan="3">
                        <s:property value="projectStartObject.reworkProjectNames" />
                    </td>
				</tr>
			</s:if>
			<tr>
				<td class="EditHead">开始日期</td>
				<td class="editTd">
                    <s:property value="projectStartObject.pro_starttime" />
                </td>
				<td class="EditHead">结束日期</td>
				<td class="editTd">
                    <s:property value="projectStartObject.pro_endtime" />
                </td>
			</tr>
			<s:if test="${!projectStartObject.nbzwpg}">
				<tr>
					<td class="EditHead" nowrap>
                        <s:if test="varMap['audit_start_timeRequired']">
							<font color=red>*</font>
						</s:if> 审计期间开始
                    </td>
					<td class="editTd">
                        <s:property value="projectStartObject.audit_start_time" /> 
                        <input type="hidden" name="projectStartObject.audit_start_time" value="${projectStartObject.audit_start_time }"></td>
					<td class="EditHead" nowrap>
                        <s:if test="varMap['audit_end_timeRequired']">
							<font color=red>*</font>
						</s:if> 审计期间结束
                    </td>
					<td class="editTd">
                        <s:property value="projectStartObject.audit_end_time" /> 
                        <input type="hidden" name="projectStartObject.audit_end_time" value="${projectStartObject.audit_end_time }">
                    </td>
				</tr>
				<tr>
					<td class="EditHead">
                        <s:if test="varMap['audit_scopeRequired']">
							<font color="red">*</font>
						</s:if> 审计范围
                    </td>
					<td class="editTd" colspan="3">
                        <s:property value="projectStartObject.audit_scope" />
                    </td>
				</tr>
				<tr>
					<td class="EditHead">
                        <s:if test="varMap['plan_remarkRequired']">
							<font color="red">*</font>
						</s:if> 备注
                    </td>
					<td class="editTd" colspan="3">
                        <s:property value="projectStartObject.plan_remark" />
                    </td>
				</tr>
			</s:if>
		</table>
	</div>
</body>
</html>