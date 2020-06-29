<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:scriptlet>
			pageContext.setAttribute("uuid", new Long(Math.round(Math.random() * 9000 + 1000)));
</jsp:scriptlet>
<center>
	<div align="left">
		<a id="docName" style="cursor:hand" onclick="hidden();">隐藏项目信息</a>
	</div>

	<div id="includeTable">
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable">

			<tr class="listtablehead">
				<td class="ListTableTr11">
					项目名称：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.project_name" />
				</td>
			    <td class="ListTableTr11">
					项目编号：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.project_code" />
				</td>
			</tr>



			<tr class="listtablehead">
				<td class="ListTableTr11">
					计划类别：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.plan_type_name" />
				</td>
				<td class="ListTableTr11">
					项目类别：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_type_name" />
					<s:if
						test="projectStartObject.pro_type_child_name!=null&&projectStartObject.pro_type_child_name!=''">
							
							<s:property value="projectStartObject.pro_type_child_name" />
					</s:if>
				</td>
			</tr>



			<tr class="listtablehead">
				<td class="ListTableTr11">
					计划等级：
				</td>
				<td class="ListTableTr22" align="right">
					<s:property value="projectStartObject.plan_grade_name" />
				</td>
				<td class="ListTableTr11">
					所属单位:
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.audit_dept_name" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					被审计单位：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="projectStartObject.audit_object_name" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					开始日期：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_starttime" />
				</td>
				<td class="ListTableTr11">
					结束日期：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_endtime" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					项目组长：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="projectStartObject.pro_teamleader_name" />			
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					项目副组长：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_teamleader_ast_name" />				
				</td>
				<td class="ListTableTr11">
					项目主审：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_auditleader_name" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					项目参审：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="projectStartObject.pro_team_members_name" />					
				</td>
			</tr>
			<s:if test="projectStartObject!=null">
				<tr>
					<td class="ListTableTr11">
						审计范围：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:property value="projectStartObject.audit_scope" />			
					</td>
				</tr>
			</s:if>

			<tr>
				<td class="ListTableTr11">
					备注：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="projectStartObject.plan_remark" />
				</td>
			</tr>

		</table>

	</div>
</center>
<script type="text/javascript">
//隐藏档案详细信息
var flag=0;
function hidden()
{
	if(flag==0)
	{	
		document.getElementById("includeTable").style.display="none";
		flag=1;
		document.getElementById("docName").innerText="显示项目信息";
	}
	else
	{
		document.getElementById("includeTable").style.display="";
		flag=0;
		document.getElementById("docName").innerText="隐藏项目信息";
	}
}
</script>
