<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<center >
	<div id="includeTable">
		
		<table id="projectStartTable"  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
			<tr >
				<td colspan="4" align="left" class="edithead">
					&nbsp;项目信息
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					项目名称：
				</td>
				<td class="editTd">
					<s:property value="crudObject.project_name"/>
				</td>
				<td class="EditHead">
					项目编号：
				</td>
				<td class="editTd">
					<s:property value="crudObject.project_code"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					项目年度：
				</td>
				<td class="editTd">
					<s:property value="crudObject.pro_year"/>
				</td>
				<td class="EditHead">
					项目类别：
				</td>
				<td class="editTd">
					<s:property value="crudObject.pro_type_name"/>
					&nbsp;&nbsp;
					<s:property value="crudObject.pro_type_child_name"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					计划类别：
				</td>
				<td class="editTd">
					<s:property value="crudObject.plan_type_name"/>
				</td>
				<td class="EditHead">
					计划等级：
				</td>
				<td class="editTd">
					<s:property value="crudObject.plan_grade_name"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					审计单位：
				</td>
				<td class="editTd" colspan="3">
					<s:property value="crudObject.audit_dept_name"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					被审计单位：
				</td>
				<td class="editTd" colspan="3">
					<s:property value="crudObject.audit_object_name"/>
				</td>
			</tr>
			<s:if test="crudObject.jjzrr">
				<tr>
					<td class="EditHead">
						经济责任人：
					</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.jjzrrname"/>
					</td>
				</tr>
			</s:if>
			<s:if test="crudObject.rework">
				<tr>
					<td class="EditHead">
						后续审计项目：
					</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.reworkProjectNames"/>
					</td>
				</tr>
			</s:if>
			<tr>
				<td class="EditHead">
					开始日期：
				</td>
				<td class="editTd">
					<s:property value="crudObject.pro_starttime"/>
				</td>
				<td class="EditHead">
					结束日期：
				</td>
				<td class="editTd">
					<s:property value="crudObject.pro_endtime"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap>
					审计期间开始：
				</td>
				<td class="editTd">
					<s:property value="crudObject.audit_start_time"/>
				</td>
				<td class="EditHead" nowrap>
					审计期间结束：
				</td>
				<td class="editTd">
					<s:property value="crudObject.audit_end_time"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					审计目的：
				</td>
				<td class="editTd" colspan="3">
					<s:textarea name="crudObject.audit_purpose" disabled="true"
						cssStyle="width:100%;height:20;overflow-y:visible" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					审计范围：
				</td>
				<td class="editTd" colspan="3">
					<s:textarea name="crudObject.audit_scope" disabled="true"
						cssStyle="width:100%;height:20;overflow-y:visible" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					审计依据：
				</td>
				<td class="editTd" colspan="3">
					<s:textarea name="crudObject.audit_basis" disabled="true"
						cssStyle="width:100%;height:20;overflow-y:visible" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					备注：
				</td>
				<td class="editTd" colspan="3">
					<s:textarea cssClass="noborder" name="crudObject.plan_remark" disabled="true"
						cssStyle="width:100%;height:20;overflow-y:visible" />
				</td>
			</tr>
		</table>
		<div id="planAnnexList">
			<s:property value="planAnnexList" escape="false" />
		</div>
	</div>
</center>
