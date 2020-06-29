<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<center>
	<div id="includeTable" style="display: none">
		<table class="ListTable">
			<tr >
				<td colspan="4" align="left" class="edithead">
					项目信息
				</td>
			</tr>
			<tr >
				<td class="EditHead" nowrap="nowrap" style="width:15%;">
					项目名称
				</td>
				<td class="editTd" style="width:35%;">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.project_name" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projectName" />
					</s:if>
				</td>

				<td class="EditHead" nowrap="nowrap" style="width:15%;">
					项目编号
				</td>
				<td class="editTd" style="width:35%;">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.project_code" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projectcode" />
					</s:if>
				</td>
			</tr>


			<tr >

				<td class="EditHead" nowrap="nowrap">
					计划类别
				</td>
				<td class="editTd">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.plan_type_name" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.auditplantypeName" />
					</s:if>
				</td>
				<td class="EditHead" nowrap="nowrap">
					项目类别
				</td>
				<td class="editTd">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.pro_type_name" />
						<s:if
							test="projectStartObject.pro_type_child_name!=null&&projectStartObject.pro_type_child_name!=''">
								-
								<s:property value="projectStartObject.pro_type_child_name" />
						</s:if>
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projecttypeName" />
					</s:if>
				</td>
			</tr>



			<tr >
				<td class="EditHead" nowrap="nowrap">
					计划等级
				</td>
				<td class="editTd" align="right">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.plan_grade_name" />
					</s:if>
				</td>
				<td class="EditHead" nowrap="nowrap">
					所属单位
				</td>
				<td class="editTd">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.audit_dept_name" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.auditedUnit" />
					</s:if>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap="nowrap">
					被审计单位
				</td>
				<td class="editTd" colspan="3">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.audit_object_name" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.constructUnit" />
					</s:if>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap="nowrap">
					开始日期
				</td>
				<td class="editTd">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.pro_starttime" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projectstarttime" />
					</s:if>
				</td>
				<td class="EditHead" nowrap="nowrap">
					结束日期
				</td>
				<td class="editTd">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.pro_endtime" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projectendtime" />
					</s:if>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap="nowrap">
					项目组长
				</td>
				<td class="editTd" colspan="3">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.pro_teamleader_name" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projectteamleader" />
					</s:if>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap="nowrap">
					项目副组长
				</td>
				<td class="editTd">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.pro_teamleader_ast_name" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projectsubteamleader" />
					</s:if>
				</td>
				<td class="EditHead" nowrap="nowrap">
					项目主审
				</td>
				<td class="editTd">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.pro_auditleader_name" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projectmainaudit" />
					</s:if>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap="nowrap">
					项目参审
				</td>
				<td class="editTd" colspan="3">
					<s:if test="projectStartObject!=null">
						<s:property value="projectStartObject.pro_team_members_name" />
					</s:if>
					<s:if test="auditProjectW!=null">
						<s:property value="auditProjectW.projectmembers" />
					</s:if>
				</td>
			</tr>
			<s:if test="projectStartObject!=null">
				<tr>
					<td class="EditHead" nowrap="nowrap">
						审计范围
					</td>
					<td class="editTd" colspan="3">
						<s:property value="projectStartObject.audit_scope" />
					</td>
				</tr>

				<tr>
					<td class="EditHead" nowrap="nowrap">
						备注
					</td>
					<td class="editTd" colspan="3">
						<s:property value="projectStartObject.plan_remark" />
					</td>
				</tr>
			</s:if>

		</table>

	</div>
	<div style="height: 1px;"></div>
	<div id="includeTable1">
		<table class="ListTable">
			<tr >
				<td colspan="4" align="left" class="edithead">
					<font style="float: left;">档案信息</font>
				</td>
			</tr>
			<tr >

				<td align="left" class="EditHead" nowrap="nowrap"
					style="width:15%;">
					档案名称
				</td>
				<td class="editTd" align="right" colspan="3">
					<s:property value="pigeonholeObject.archives_name" />
				</td>
			</tr>



			<tr >
				<td align="left" class="EditHead" nowrap="nowrap"
					style="width:15%;">
					档案类型
				</td>
				<td class="editTd" align="right" style="width:35%;">
					<s:property value="pigeonholeObject.archives_type_name" />
				</td>

				<td align="left" class="EditHead" nowrap="nowrap"
					style="width:15%;">
					档案状态
				</td>
				<td class="editTd" align="right" nowrap="nowrap"
					style="width:35%;">
					<s:property value="pigeonholeObject.archives_status_name" />
				</td>
			</tr>

			<tr >
				<td align="left" class="EditHead" nowrap="nowrap">
					档案年度
				</td>
				<td class="editTd" align="right">
					<s:property value="pigeonholeObject.archives_year" />
				</td>

				<td align="left" class="EditHead" nowrap="nowrap">
					审计单位
				</td>
				<td class="editTd" align="right">
					<s:property value="pigeonholeObject.archives_unit_name" />
					<s:hidden name="pigeonholeObject.archives_unit" />
				</td>
			</tr>



			<tr >
				<td align="left" class="EditHead" nowrap="nowrap">
					归档发起人
				</td>
				<td class="editTd" align="right">
					<s:property value="pigeonholeObject.archives_start_man_name" />
				</td>


				<td align="left" class="EditHead" nowrap="nowrap">
					归档日期
				</td>
				<td class="editTd" align="right">
					<s:property value="pigeonholeObject.archives_time" />
				</td>
			</tr>
		</table>
	</div>
</center>
<script type="text/javascript">
/*
 * 隐藏/显示项目详细信息
 */
function hidden()
{
	var proInfoDiv = document.getElementById('includeTable');
	if(proInfoDiv.style.display=='none'){
		proInfoDiv.style.display='';
	}else{
		proInfoDiv.style.display='none';
	}
}

</script>
