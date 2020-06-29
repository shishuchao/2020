<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>批量提交底稿</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
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

  </head>
  
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body onload="end();">
</s:if>
<s:else>
	<body >
</s:else>
	<s:form id="myform" action="submit" namespace="/plan/detail"
			onsubmit="">
	<div style="display: none;">
	<s:hidden name="crudObject.fid" />
			<s:hidden name="crudObject.w_writer_person" />
			<s:hidden name="crudObject.w_writer_person_name" />
			<s:hidden name="crudObject.w_write_date" />
			<s:hidden id="yearPlanId" name="crudObject.year_id" />
			<s:hidden name="crudObject.year_detail_id" />
			<s:hidden id="monthPlanId" name="crudObject.month_id" />
			<s:hidden name="crudObject.month_detail_id" />
			<s:hidden name="crudObject.detail_form_id" />
			<s:hidden name="crudObject.detail_plan_name" />
			<s:hidden name="crudObject.source_plan_form_id" />
			<s:hidden name="crudObject.code" />
			<s:hidden id="detail_id" name="crudObject.detail_id" />
			<s:hidden name="crudObject.isFJ" />
			<s:hidden name="crudObject.operateflag" />
			<s:hidden name="crudObject.isAddByMonth" />
			<s:hidden name="crudObject.isAddByYear" />
			<s:hidden name="monthDetailId" />
			<s:hidden name="monthFormId" />
			<s:hidden name="yearDetailId" />
			<s:hidden name="yearFormId" />
			<s:hidden name="option" />
			<s:hidden name="defer" />
			<s:hidden name="adjust" />
			<s:hidden name="cancel" />
			<s:hidden name="carryforward" />
            <s:hidden name="workprogramid"/>
            <s:hidden name="crudObject.batch"/>
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;项目计划信息
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						计划状态
					</td>
					<td class="ListTableTr22">
							<s:property value="crudObject.status_name" />
							<s:hidden name="crudObject.status" />
							<s:hidden name="crudObject.status_name" />
					</td>
					<td class="ListTableTr11">
						计划编号
					</td>
					<td class="ListTableTr22">
						<s:textfield id="w_plan_code" name="crudObject.w_plan_code"
								readonly="!(varMap['w_plan_codeWrite']==null?true:varMap['w_plan_codeWrite'])"
								display="${varMap['w_plan_codeRead']}" cssStyle="width:50%" title="计划编号" maxlength="25"/>
						<font color=red>保存时刻自动生成,请谨慎修改</font>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color=red>*</font>
						计划年度
					</td>
					<td class="ListTableTr22">
						<s:property value="crudObject.w_plan_year" />
						<s:hidden name="crudObject.w_plan_year" />
					</td>
					<td class="ListTableTr11">
						<font color=red>*</font>
						计划月度
					</td>
					<td class="ListTableTr22">
						<s:if test="${yearFormId!=''}">
							<s:select
								list="{'1','2','3','4','5','6','7','8','9','10','11','12'}"
								name="crudObject.w_plan_month" disabled="false"
								theme="ufaud_simple" templateDir="/strutsTemplate" />
						</s:if>
						<s:else>
							<s:property value="crudObject.w_plan_month" />
							<s:hidden name="crudObject.w_plan_month" />
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color=red>*</font>
						计划名称
					</td>
					<td class="ListTableTr22">
						<s:textfield name="crudObject.w_plan_name"
							readonly="!(varMap['w_plan_nameWrite']==null?true:varMap['w_plan_nameWrite'])"
							display="${varMap['w_plan_nameRead']}" cssStyle="width:90%" title="计划名称" maxlength="255"/>
					</td>
					<td class="ListTableTr11">
						<font color=red>*</font>
						计划类别
					</td>
					<td class="ListTableTr22">
						<s:if test="${monthFormId!=null||yearFormId!=''}">
						<s:select id="plan_type" name="crudObject.w_plan_type"
							list="basicUtil.planTypeList" listKey="code" listValue="name"
							disabled="!(varMap['w_plan_typeWrite']==null?true:varMap['w_plan_typeWrite'])"
							display="${varMap['w_plan_typeRead']}" theme="ufaud_simple"
							templateDir="/strutsTemplate" />
						</s:if>
						<s:else>
							<s:property value="crudObject.w_plan_type_name"/>
							<s:hidden name="crudObject.w_plan_type" />
							<s:hidden name="crudObject.w_plan_type_name" />
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<s:if test="varMap['plan_gradeRequired']">
							<font color=red>*</font>
						</s:if>
						计划等级
					</td>
					<td class="ListTableTr22">
						<s:select id="plan_grade" name="crudObject.plan_grade"
							list="basicUtil.planLevelList" listKey="code" listValue="name"
							disabled="!(varMap['plan_gradeWrite']==null?true:varMap['plan_gradeWrite'])"
							display="${varMap['plan_gradeRead']}" theme="ufaud_simple"
							templateDir="/strutsTemplate" emptyOption="true"/>
					</td>
					<td class="ListTableTr11">
						<s:if test="varMap['pro_typeRequired']">
							<font color=red>*</font>
						</s:if>
						项目类别
					</td>
					<td class="ListTableTr22">
						<s:doubleselect id="pro_type" doubleId="pro_type_child"
							doubleList="projectTypeMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="crudObject.pro_type" list="projectTypeMap.keySet()"
							doubleName="crudObject.pro_type_child" theme="ufaud_simple"
							templateDir="/strutsTemplate"
							disabled="!(varMap['pro_typeWrite']==null?true:varMap['pro_typeWrite'])"
							doubleDisabled="!(varMap['pro_type_childWrite']==null?true:varMap['pro_type_childWrite'])"
							display="${varMap['pro_typeRead']}" onchange="projectTypeChangeHandler();setWorkProgramId()"
							emptyOption="true" doubleEmptyOption="true"/>
                        &nbsp; <a href="javascript:;" onclick="showWorkProgram()">查看对应工作方案</a>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color=red>*</font>
						审计单位
					</td>
					<td class="ListTableTr22">
						<s:if test="${monthFormId!=null||yearFormId!=''}">
							<s:if test="'${option}'=='addyuxuan'">
								<s:buttonText2 id="audit_dept_name" hiddenId="audit_dept"
								name="crudObject.audit_dept_name" cssStyle="width:90%"
								hiddenName="crudObject.audit_dept"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=crudObject.audit_dept_name&paraid=crudObject.audit_dept',600,350,'组织机构选择')"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true"
								display="${varMap['audit_deptRead']}"
								doubleDisabled="!(varMap['audit_deptWrite']==null?true:varMap['audit_deptWrite'])" title="审计单位" maxlength="100"/>
							</s:if>
							<s:else>
								<s:buttonText2 id="audit_dept_name" hiddenId="audit_dept"
								name="crudObject.audit_dept_name" cssStyle="width:90%"
								hiddenName="crudObject.audit_dept"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=crudObject.audit_dept_name&paraid=crudObject.audit_dept&funname=auditDeptChange()',600,350,'组织机构选择')"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true"
								display="${varMap['audit_deptRead']}"
								doubleDisabled="!(varMap['audit_deptWrite']==null?true:varMap['audit_deptWrite'])" title="审计单位" maxlength="100"/>
							</s:else>
						</s:if>
						<s:else>
							<s:property value="crudObject.audit_dept_name"/>
							<s:hidden name="crudObject.audit_dept_name" />
							<s:hidden id="audit_dept" name="crudObject.audit_dept" />
						</s:else>
					</td>
					<td class="ListTableTr11"  nowrap="nowrap">
						<font color=red>*</font>
						被审单位
					</td>
					<td class="ListTableTr22">
						<s:buttonText2 id="audit_object_name" hiddenId="audit_object"
							name="crudObject.audit_object_name" cssStyle="width:90%"
							hiddenName="crudObject.audit_object"
							doubleOnclick="selectAuditObject()"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							display="${varMap['audit_objectRead']}"
							doubleDisabled="!(varMap['audit_objectWrite']==null?true:varMap['audit_objectWrite'])" title="审计单位" maxlength="1500"/>
					</td>
				</tr>
				<tr id="jjzrrTr"  style="display: none;">
					<td class="ListTableTr11" id="jjzrrTd">
						&nbsp;
					</td>
					<td class="ListTableTr22" colspan="3">
					    <s:buttonText2 id="jjzrr" name="crudObject.jjzrrname" hiddenId="jjzrrName"
							cssStyle="width:95%" hiddenName="crudObject.jjzrrid"
							doubleOnclick="selectJJZRR()"
							doubleSrc="${contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"/>
					</td>
				</tr>
				<tr id="reworkTr"  style="display: none;">
					<s:if test="@ais.plan.util.PlanSysParamUtil@isReworkByProblem()">
						<td class="ListTableTr11">
							后续问题点
						</td>
						<td class="ListTableTr22">
							<s:buttonText2 id="reworkProProblemName" hiddenId="reworkProProblemCode"
								name="crudObject.reworkProjectProblemName" cssStyle="width:90%"
								hiddenName="crudObject.reworkProjectProblemCode"
								doubleOnclick="selectReworkProjectProblem()"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" />
						</td>
					</s:if>
					<td class="ListTableTr11" id="reworkTd">
						&nbsp;
					</td>
					<s:if test="@ais.plan.util.PlanSysParamUtil@isReworkByProblem()">
						<td class="ListTableTr22" colspan="1">
					</s:if>
					<s:else>
						<td class="ListTableTr22" colspan="3">
					</s:else>
						<s:buttonText2 id="reworkProName" hiddenId="reworkProId"
							name="crudObject.reworkProjectNames" cssStyle="width:90%"
							hiddenName="crudObject.reworkProjectIds"
							doubleOnclick="selectReworkProject()"
							doubleSrc="${contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true" />
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color=red>*</font>
						项目组长
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:buttonText2 id="pro_teamleader_name" hiddenId="pro_teamleader"
							name="crudObject.pro_teamleader_name" cssStyle="width:95%"
							hiddenName="crudObject.pro_teamleader"
							doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/selectemployee.jsp?url=${pageContext.request.contextPath}/pages/system/employeeindex.jsp&paraname=crudObject.pro_teamleader_name&paraid=crudObject.pro_teamleader&p_issel=1',600,500)"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							display="${varMap['pro_teamleaderRead']}"
							doubleDisabled="!(varMap['pro_teamleaderWrite']==null?true:varMap['pro_teamleaderWrite'])" maxlength="500" title="项目组长"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color=red>*</font>
						项目开始日期
					</td>
					<td class="ListTableTr22">
						<s:textfield id="pro_starttime" name="crudObject.pro_starttime"
							readonly="true" cssStyle="width:90%" maxlength="15"
							title="单击选择日期"
							disabled="!(varMap['pro_starttimeWrite']==null?true:varMap['pro_starttimeWrite'])"
							display="${varMap['pro_starttimeRead']}" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
					<td class="ListTableTr11">
						<font color=red>*</font>
						项目结束日期
					</td>
					<td class="ListTableTr22">
						<s:textfield id="pro_endtime" name="crudObject.pro_endtime"
							readonly="true" cssStyle="width:90%" maxlength="15"
							title="单击选择日期"
							disabled="!(varMap['pro_endtimeWrite']==null?true:varMap['pro_endtimeWrite'])"
							display="${varMap['pro_endtimeRead']}" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
				</tr>
				
				<tr>
					<td class="ListTableTr11" nowrap>
						<s:if test="varMap['audit_start_timeRequired']">
							<font color=red>*</font>
						</s:if>
						审计期间开始
					</td>
					<td class="ListTableTr22">
						<s:textfield id="audit_start_time" name="crudObject.audit_start_time"
								readonly="true" cssStyle="width:90%" maxlength="15"
								title="单击选择日期"
								disabled="!(varMap['audit_start_timeWrite']==null?true:varMap['audit_start_timeWrite'])"
								display="${varMap['audit_start_timeRead']}" onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
					<td class="ListTableTr11" nowrap>
						<s:if test="varMap['audit_end_timeRequired']">
							<font color=red>*</font>
						</s:if>
						审计期间结束
					</td>
					<td class="ListTableTr22">
						<s:textfield id="audit_end_time" name="crudObject.audit_end_time"
								readonly="true" cssStyle="width:90%" maxlength="15"
								title="单击选择日期"
								disabled="!(varMap['audit_end_timeWrite']==null?true:varMap['audit_end_timeWrite'])"
								display="${varMap['audit_end_timeRead']}" onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
				</tr>
				<s:hidden name="crudObject.isSupervise"></s:hidden>
				<s:if test="varMap['contentRead']">
				<tr>
					<td class="ListTableTr11" nowrap>
						<s:if test="varMap['contentRequired']">
							<font color=red>*</font>
						</s:if>
						正文内容<br/><div style="text-align:left"><font color=DarkGray>(请限3000字)</font></div>
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea name="crudObject.content" rows="20" 
							readonly="!(varMap['contentWrite']==null?true:varMap['contentWrite'])"
							display="${varMap['contentRead']}" 
							cssStyle="width:100%;height:100px;overflow-y:visible" title="正文内容"/>
						<input type="hidden" id="crudObject.content.maxlength" value="3000"/>
					</td>
				</tr>
				</s:if>
				<tr>
					<td class="ListTableTr11">
						<s:if test="varMap['handle_modusRequired']">
							<font color=red>*</font>
						</s:if>
						完成形式
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="handle_modus" name="crudObject.handle_modus"
							readonly="!(varMap['handle_modusWrite']==null?true:varMap['handle_modusWrite'])"
							display="${varMap['handle_modusRead']}" 
							cssStyle="width:100%;height:20px;overflow-y:visible" title="完成形式"/>
						<input type="hidden" id="crudObject.handle_modus.maxlength" value="500"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<s:if test="varMap['audit_purposeRequired']">
							<font color=red>*</font>
						</s:if>
						审计目的
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="audit_purpose" name="crudObject.audit_purpose"
							readonly="!(varMap['audit_purposeWrite']==null?true:varMap['audit_purposeWrite'])"
							display="${varMap['audit_purposeRead']}"
							cssStyle="width:100%;height:20;overflow-y:visible" title="审计目的"/>
						<input type="hidden" id="crudObject.audit_purpose.maxlength" value="1000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<s:if test="varMap['audit_scopeRequired']">
							<font color=red>*</font>
						</s:if>
						审计范围
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="audit_scope" name="crudObject.audit_scope"
							readonly="!(varMap['audit_scopeWrite']==null?true:varMap['audit_scopeWrite'])"
							display="${varMap['audit_scopeRead']}"
							cssStyle="width:100%;height:20;overflow-y:visible" title="审计范围"/>
						<input type="hidden" id="crudObject.audit_scope.maxlength" value="1000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<s:if test="varMap['audit_basisRequired']">
							<font color=red>*</font>
						</s:if>
						审计依据
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="audit_basis" name="crudObject.audit_basis"
							readonly="!(varMap['audit_basisWrite']==null?true:varMap['audit_basisWrite'])"
							display="${varMap['audit_basisRead']}"
							cssStyle="width:100%;height:20;overflow-y:visible" title="审计依据"/>
						<input type="hidden" id="crudObject.audit_basis.maxlength" value="1000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<s:if test="varMap['plan_remarkRequired']">
							<font color=red>*</font>
						</s:if>
						备注
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="plan_remark" name="crudObject.plan_remark"
							cssStyle="width:100%;height:20;overflow-y:visible"
							readonly="!(varMap['plan_remarkWrite']==null?true:varMap['plan_remarkWrite'])"
							display="${varMap['plan_remarkRead']}" title="备注"/>
						<input type="hidden" id="crudObject.plan_remark.maxlength" value="1000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<s:button
							disabled="!(varMap['uploadw_fileWrite']==null?true:varMap['uploadw_fileWrite'])"
							display="${varMap['uploadw_fileRead']}" onclick="Upload('crudObject.w_file',accelerys)"
							value="上传附件"></s:button>
						<s:hidden name="crudObject.w_file" />
					</td>
					<td class="ListTableTr22" colspan="3">
						<div id="accelerys" align="center">
							<s:property escape="false" value="accessoryList" />
						</div>
					</td>
				</tr>
			</table>
	</div>
	 <table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					&nbsp;项目计划批量提交
				</td>
		</tr>

		<tr align="center" class="titletable1">
			 
			<td width=25%>
				<center>
					项目计划名称
				</center>
			</td>
			
			<td width=25%>
				<center>
					项目计划编码
				</center>
			</td>
			<td>
				<center width=25%>
					负责人
				</center>
			</td>
			<td width=25%>
				<center>
					审计单位
				</center>
				
			</td>
			 
		</tr>
		<s:iterator value="planList">
			<tr>
				<td class="listtabletr2">
				<center>
					<s:property value="w_plan_name" />
				</center>
				</td>
				<td class="listtabletr2" style='word-break:break-all;word-wrap:break-word;width:300px'>
					 
					<center>
						<s:property value="w_plan_code" />
					</center>
				</td>
				<td class="listtabletr2">
					<center>
						<s:property value="pro_teamleader_name" />
				</td>
				<td class="ListTableTr2" >
				<center>
					<s:property value="audit_dept_name" />
					</center>
				</td>
				 
			</tr>
		</s:iterator>
	  </table>
	<s:hidden name="crudObject.formId" />
	<div align="center">
		<s:button value="返回" onclick="backList()" />
		&nbsp;&nbsp;
	</div>
	</s:form>
  </body>
  <script type="text/javascript">
  //返回上级list页面
   function backList()
   {
   		window.parent.location.href="${contextPath}/plan/detail/listAll.action?userRole=${userRole}&yearFormId=${yearFormId}&type=edit";
   		window.parent.hidePopWin(false);
   }
  </script>
</html>
