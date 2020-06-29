<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="ais.framework.commonPlug.util.CommonPlugUtil"/>
<s:if test="${riskTaskTemplate.taskId==null}">
	<s:text id="title" name="'增加风险程序'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'编辑风险程序'"></s:text>
</s:else>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" /></title>
	<s:head />
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script language="javascript">
		$(function (){
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
		
		function closeWindow(){
			parent.$('#addLeaf_div').window('close');
		}

		//保存表单
		function saveFormLeafAgain(){
			if(audEvd$validateform('myform')){
				var tab='<%=request.getParameter("tab")%>';
				$.ajax({
					type:"post",
					data:$('#myform').serialize(),
					url:"${contextPath}/riskManagement/knowledgeBase/riskTemplate/saveLeafAgain.action?tab="+tab+"&addleaf=true",
					async:false,
					success:function(){
						showMessage1('保存成功！');
						parent.parent.parent.reloadChildTreeNode();
						parent.generateLeaf2();
					}
				});
			}
		}
	</script>
</head>
<body>
	<center class="easyui-layout" style="overflow:auto;">
		<div style="text-align:right;margin-top:10px;margin-bottom:10px;padding-right:18px;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormLeafAgain()">保存并增加</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeWindow();">关闭</a>
		</div>
						
		<div id="aa">
			<s:form id="myform" name="myform" onsubmit="return true;" action="/ais/riskManagement/knowledgeBase/riskTemplate" method="post">
				<table class="ListTable">
					<tr>
						<td class="EditHead" style="width: 20%">
							上级类别名称
						</td>
						<td class="editTd">
							<s:textfield name="riskTaskTemplate.taskPname" title="上级类别名称" id="taskPname" cssClass="noborder editElement required"/>
						</td>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;风险类型
						</td>
						<td class="editTd">
							<select class="easyui-combobox" name="riskTaskTemplate.riskTypeCode">
								<s:iterator value="basicUtil.riskTypeList" id="entry">
									<s:if test="${riskTaskTemplate.riskTypeCode == key}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;编号
						</td>
						<td class="editTd">
							<s:property value="riskTaskTemplate.taskCode"/>
							<s:hidden name="riskTaskTemplate.taskCode"/>
						</td>
						<td class="EditHead">
							<font color="red">*</font>风险事项
						</td>
						<td class="editTd">
							<s:textfield name="riskTaskTemplate.taskName" title="风险事项" id="taskName" cssClass="noborder editElement required" maxlength="100"/>
						</td>
					</tr>
					<tr style='display:none;'>
						<td class="EditHead" >
							<font color="red">*</font>&nbsp;事项序号
						</td>
						<td class="editTd" colspan="3">
							<s:textfield name="riskTaskTemplate.taskOrder" cssClass="noborder" maxlength="3"
								cssStyle='width:150px;'/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;风险描述
						</td>
						<td class="editTd" colspan="3">
							<textarea type='text' id='riskTaskTemplate_riskDescription' name='riskTaskTemplate.riskDescription' 
				 				class="noborder editElement required clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTaskTemplate.riskDescription}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;影响描述
						</td>
						<td class="editTd" colspan="3">
							<textarea type='text' id='riskTaskTemplate_influenceDescription' name='riskTaskTemplate.influenceDescription' 
				 				class="noborder editElement required clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTaskTemplate.influenceDescription}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;所属单位
						</td>
						<td class="editTd">
							<s:buttonText2 id="affiliatedDeptName" hiddenId="affiliatedDeptId" cssClass="noborder editElement required"
								name="riskTaskTemplate.affiliatedDeptName" 
								hiddenName="riskTaskTemplate.affiliatedDeptId"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									title:'请选择所属单位',
									param:{
										'p_item':1,
										'orgtype':1
									},
									defaultDeptId:'${user.fdepid}',
									onAfterSure:function(data){
										$('#majorDutyDeptName').val('');
										$('#majorDutyDeptId').val('');  
									}                               
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:pointer;border:0"
								readonly="true"
								title="所属单位" maxlength="100"/>
						</td>
						<td class="EditHead">
							<font color="red">*</font>&nbsp;主责部门
						</td>
						<td class="editTd">
							<s:buttonText2 id="majorDutyDeptName" hiddenId="majorDutyDeptId" cssClass="noborder editElement required"
								name="riskTaskTemplate.majorDutyDeptName" 
								hiddenName="riskTaskTemplate.majorDutyDeptId"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									title:'请选择主责部门',
									param:{
										'p_item':1,
										'orgtype':1
									},
									defaultDeptId:'${user.fdepid}'
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:pointer;border:0"
								readonly="true"
								title="主责部门" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							次要责任部门
						</td>
						<td class="editTd">
							<s:buttonText2 id="minorDutyDeptName" hiddenId="minorDutyDeptId" cssClass="noborder"
								name="riskTaskTemplate.minorDutyDeptName" 
								hiddenName="riskTaskTemplate.minorDutyDeptId"
								doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									title:'请选择次要责任部门',
									param:{
										'p_item':1,
										'orgtype':1
									},
									defaultDeptId:'${user.fdepid}',
									checkbox:true
								})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:pointer;border:0"
								readonly="true"
								title="次要责任部门" maxlength="100"/>
						</td>
						<td class="EditHead">
							涉及业务
						</td>
						<td class="editTd">
							<s:textfield name="riskTaskTemplate.involvedBusiness" cssClass="noborder" maxlength="64"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							风险成因
						</td>
						<td class="editTd" colspan="3">
							<textarea type='text' id='riskTaskTemplate_riskCause' name='riskTaskTemplate.riskCause' 
				 				class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTaskTemplate.riskCause}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							风险源
						</td>
						<td class="editTd" colspan="3">
							<textarea type='text' id='riskTaskTemplate_riskSource' name='riskTaskTemplate.riskSource' 
				 				class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTaskTemplate.riskSource}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							估计财务损失
						</td>
						<td class="editTd">
							<s:textfield name="riskTaskTemplate.estimatedFinancialLoss" id="estimatedFinancialLoss" cssClass="noborder editElement money" maxlength="10"/>万元
						</td>
						<td class="EditHead">
							实际财务损失
						</td>
						<td class="editTd">
							<s:textfield name="riskTaskTemplate.actualFinancialLoss" cssClass="noborder editElement money" maxlength="10"/>万元
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							当前管控情况
						</td>
						<td class="editTd">
							<select class="easyui-combobox" name="riskTaskTemplate.currentControlSituation">
								<s:iterator value="basicUtil.riskChargeList">
									<s:if test="${riskTaskTemplate.currentControlSituation == key}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
						<td class="EditHead">
							录入时间
						</td>
						<td class="editTd">
							<s:property value="riskTaskTemplate.createTime"/>
							<s:hidden name="riskTaskTemplate.createTime"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							录入部门
						</td>
						<td class="editTd">
							<s:property value="riskTaskTemplate.createrDeptName"/>
							<s:hidden name="riskTaskTemplate.createrDeptId"/>
							<s:hidden name="riskTaskTemplate.createrDeptName"/>
						</td>
						<td class="EditHead">
							录入人
						</td>
						<td class="editTd">
							<s:property value="riskTaskTemplate.createrName"/>
							<s:hidden name="riskTaskTemplate.createrId"/>
							<s:hidden name="riskTaskTemplate.createrName"/>
						</td>
					</tr>
				</table>
				<s:hidden name="riskTaskTemplate.taskId" />
				<s:hidden name="riskTaskTemplate.templateId" />
				<s:hidden name="riskTaskTemplate.taskPid" />
				<s:hidden name="riskTaskTemplate.taskPcode" />
				<s:hidden name="riskTaskTemplate.template_type" value="2" />
				<s:hidden name="templateId" />
				<s:hidden name="taskId" />
				<s:hidden name="type" />
				<s:hidden name="pro_id" />
				<s:hidden name="path" />
				<s:hidden name="node" />
				<s:hidden name="riskTaskTemplate.file_id" />
				<s:hidden name="riskTaskTemplate.riskDivision" />
				<s:hidden name="riskTaskTemplate.riskClass" />
			</s:form>
			<div border="0" region="south">
    			<div id="risk_file" class="easyui-fileUpload"  data-options="fileGuid:'${riskTaskTemplate.file_id}' ,callbackGridHeight:200"></div>
    		</div>
		</div>
	</center>
</body>
</html>
