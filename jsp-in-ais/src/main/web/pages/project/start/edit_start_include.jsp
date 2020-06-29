<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript">
	/**
	* 选择被审计单位
	*/
	function selectAuditObject(){
		if(${projectStartObject.jjzrr}){
			alert('经济责任人审计一旦进入项目阶段 后不允许更改被审计单位!');
			return false;
		}
		var auditDeptId = '${projectStartObject.audit_dept}';//计划单位
		showPopWin('${contextPath}/pages/system/search/searchdatamuti.jsp?url=${contextPath}/mng/audobj/object/auditedDeptList.action&paraname=projectStartObject.audit_object_name&paraid=projectStartObject.audit_object&showRootNode=_show&where='+auditDeptId,600,350,'被审单位');
	}
</script>
<center>
	<div id="includeTable">

		<table id="projectStartTable" cellpadding=0 cellspacing=1 border=0
			bgcolor="#409cce" class="ListTable">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					&nbsp;项目信息
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					<s:if test="varMap['project_nameRequired']">
						<font color=red>*</font>
					</s:if>
					项目名称：
				</td>
				<td class="listtableTr22">
					<%--
					<s:textfield name="projectStartObject.project_name" 
							readonly="!(varMap['project_nameWrite']==null?true:varMap['project_nameWrite'])"
							display="${varMap['project_nameRead']}"  title="项目名称" maxlength="255"/> --%>
					<s:property value="projectStartObject.project_name"/>
				</td>
				<td class="ListTableTr11">
					项目编号：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.project_code"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					项目年度：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_year"/>
				</td>
				<td class="ListTableTr11">
					项目类别：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_type_name"/>
					&nbsp;&nbsp;
					<s:property value="projectStartObject.pro_type_child_name"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					计划类别：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="projectStartObject.plan_type_name"/>
				</td>
				<%-- 
				<td class="ListTableTr11">
					计划等级：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.plan_grade_name"/>
				</td>
				--%>
			</tr>
			<s:if test="${!projectStartObject.nbzwpg}">
				<tr>
					<td class="ListTableTr11">
						审计单位：
					</td>
					<td class="ListTableTr22">
						<s:property value="projectStartObject.audit_dept_name"/>
					</td>
					<td class="ListTableTr11">
						被审计单位：
					</td>
					<td class="ListTableTr22">
						<s:property value="projectStartObject.audit_object_name"/>
						<s:hidden name="projectStartObject.audit_object"></s:hidden>
					</td>
				</tr>
			</s:if>
			<s:else>
					<td class="ListTableTr11">
						测试组织者：
					</td>
					<td class="ListTableTr22">
						<s:property value="projectStartObject.audit_dept_name"/>
					</td>
					<td class="ListTableTr11">
						测内控专岗负责人：
					</td>
					<td class="ListTableTr22">
						<s:property value="projectStartObject.pro_teamleader_name"/>
					</td>
			</s:else>
				<!-- 工程项目审计 -->
			<s:if test="projectStartObject.gcxmsj">
				<tr id="gcxmTr1">
					<td class="ListTableTr11" id="gcxmTd1">
						合同金额
					</td>
					<td class="ListTableTr22" >
						<s:property value="projectStartObject.contractAmount"/>万元
					</td>
					<td class="ListTableTr11" id="gcxmTd2">
						项目管理模式
					</td>
					<td class="ListTableTr22" >
						<s:property value="projectStartObject.managerType"/>
					</td>
				</tr>
				<tr id="gcxmTr2" >
					<td class="ListTableTr11" id="gcxmTd3">
						开工日期
					</td>
					<td class="ListTableTr22" >
						<s:property value="projectStartObject.startProDate"/>
					</td>
					<td class="ListTableTr11" id="gcxmTd4">
						竣工日期
					</td>
					<td class="ListTableTr22" >
						<s:property value="projectStartObject.finishProDate"/>
					</td>
				</tr>
				<tr id="gcxmTr3" >
					<td class="ListTableTr11" id="gcxmTd5">
						项目状态
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:property value="projectStartObject.proStatus"/>
					</td>
				</tr>
			</s:if>
			
			<s:if test="projectStartObject.jjzrr">
				<tr>
					<td class="ListTableTr11">
						经济责任人：
					</td>
					<td class="ListTableTr22" >
						<s:property value="projectStartObject.jjzrrname"/>
					</td>
					<td class="ListTableTr11">
							是否为总公司党组管理干部
					</td>
					<td class="ListTableTr22" >
						<s:if test="${projectStartObject.isDangLeader=='true'}">
							是
						</s:if>
						<s:else>
							否
						</s:else>
					</td>
				</tr>
			</s:if>
			<s:if test="projectStartObject.rework">
				<tr>
					<td class="ListTableTr11">
						后续审计项目：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:property value="projectStartObject.reworkProjectNames"/>
					</td>
				</tr>
			</s:if>
			<tr>
				<td class="ListTableTr11">
					开始日期：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_starttime"/>
				</td>
				<td class="ListTableTr11">
					结束日期：
				</td>
				<td class="ListTableTr22">
					<s:property value="projectStartObject.pro_endtime"/>
				</td>
			</tr>
		 
			<tr>
				<td class="ListTableTr11" nowrap>
					<s:if test="varMap['audit_start_timeRequired']">
						<font color=red>*</font>
					</s:if>
					审计期间开始：
				</td>
				<td class="ListTableTr22">
					<%--
					<s:textfield id="audit_start_time" name="projectStartObject.audit_start_time"
							readonly="true" cssStyle="width:45%" maxlength="20"
							title="单击选择日期"
							disabled="!(varMap['audit_start_timeWrite']==null?true:varMap['audit_start_timeWrite'])"
							display="${varMap['audit_start_timeRead']}" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield> --%>
					<s:property value="projectStartObject.audit_start_time"/>
				</td>
				<td class="ListTableTr11" nowrap>
					<s:if test="varMap['audit_end_timeRequired']">
						<font color=red>*</font>
					</s:if>
					审计期间结束：
				</td>
				<td class="ListTableTr22">
					<%--
					<s:textfield id="audit_end_time" name="projectStartObject.audit_end_time"
							readonly="true" cssStyle="width:40%" maxlength="20"
							title="单击选择日期"
							disabled="!(varMap['audit_end_timeWrite']==null?true:varMap['audit_end_timeWrite'])"
							display="${varMap['audit_end_timeRead']}" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield> --%>
					<s:property value="projectStartObject.audit_end_time"/>
				</td>
			</tr>
			<%-- 
			<tr>
				<td class="ListTableTr11">
					<s:if test="varMap['audit_purposeRequired']">
						<font color=red>*</font>
					</s:if>
					审计目的：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:textarea id="audit_purpose"
						name="projectStartObject.audit_purpose"
						readonly="!(varMap['audit_purposeWrite']==null?true:varMap['audit_purposeWrite'])"
						display="${varMap['audit_purposeRead']}"
						cssStyle="width:100%;height:20;overflow-y:visible" title="审计目的"/>
					<input type="hidden" id="projectStartObject.audit_purpose.maxlength" value="1500"/>
				</td>
			</tr>
		    --%>
		    <s:if test="${!projectStartObject.nbzwpg}">
			<tr>
				<td class="ListTableTr11">
					<s:if test="varMap['audit_scopeRequired']">
						<font color="red">*</font>
					</s:if>
					审计范围：
				</td>
				<td class="ListTableTr22" colspan="3">
					<%--
					<s:textarea id="audit_scope" name="projectStartObject.audit_scope"
						readonly="!(varMap['audit_scopeWrite']==null?true:varMap['audit_scopeWrite'])"
						display="${varMap['audit_scopeRead']}"
						cssStyle="width:100%;height:20;overflow-y:visible" title="审计范围"/>
					<input type="hidden" id="projectStartObject.audit_scope.maxlength" value="1500"/>
					 --%>
					 <s:property value="projectStartObject.audit_scope"/>
				</td>
			</tr>
			<%-- 
			<tr>
				<td class="ListTableTr11">
					<s:if test="varMap['audit_basisRequired']">
						<font color=red>*</font>
					</s:if>
					审计依据：
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:textarea id="audit_basis" name="projectStartObject.audit_basis"
						readonly="!(varMap['audit_basisWrite']==null?true:varMap['audit_basisWrite'])"
						display="${varMap['audit_basisRead']}"
						cssStyle="width:100%;height:20;overflow-y:visible" title="审计依据"/>
					<input type="hidden" id="projectStartObject.audit_basis.maxlength" value="1500"/>
				</td>
			</tr>
			--%>
			<tr>
				<td class="ListTableTr11">
					<s:if test="varMap['plan_remarkRequired']">
						<font color="red">*</font>
					</s:if>
					备注：
				</td>
				<td class="ListTableTr22" colspan="3">
					<%--
					<s:textarea id="plan_remark" name="projectStartObject.plan_remark"
						cssStyle="width:100%;height:20;overflow-y:visible"
						readonly="!(varMap['plan_remarkWrite']==null?true:varMap['plan_remarkWrite'])"
						display="${varMap['plan_remarkRead']}" title="备注"/>
					<input type="hidden" id="projectStartObject.plan_remark.maxlength" value="1500"/>
					 --%>
					  <s:property value="projectStartObject.plan_remark"/>
				</td>
			</tr>
		</s:if>
		</table>
		<div id="planAnnexList">
			<s:property value="planAnnexList" escape="false" />
		</div>
	</div>
</center>
