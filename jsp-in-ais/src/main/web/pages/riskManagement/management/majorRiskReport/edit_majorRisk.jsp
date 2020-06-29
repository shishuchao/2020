<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>新增风险事项</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript">
 function getTaskPid(obj) {
	 showSysTree(obj,
				{ reeTabTitle1:'风险树',
				  cascadeCheck:false,
				  dnd:true,
				  noMsg:true,
				  queryBox:false,
               	  param:{
                  	   'rootParentId':'-1',
                  	   'whereHql':'template_type != \'2\'',
                       'beanName':'RiskTaskTemplateTree',
                       'treeId'  :'taskId',
					   'treeText':'taskName',
					   'treeParentId':'taskPid',
					   'treeOrder':'taskCode',
					   'treeAtrributes':'template_type'
                  }                                
	});
 }
 
	function sucFun(){
		if($("#sucFlag").val()=='1'){
			$("#sucFlag").val('');
			$.messager.show({title:'提示信息',msg:'保存成功!'});
		}        		
	}
	
	function toSubmit(act){
		<s:if test="isUseBpm=='true'">
	 	if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
		 	var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
		 	if(actor_name==''){
		 		$.messager.show({title:'提示信息',msg:'下一步处理人不能为空！'});
				return false;
			}
		}
	  	</s:if>
		jQuery("#myForm").attr("action","submit.action");
		jQuery("#myForm").submit();			  	
	 } 	
	
	function beforStartProcess() {
		if(audEvd$validateform('myForm')) {
			$('#submitButton2Start').linkbutton('disable');
			myForm.action =  "<s:url action="start" includeParams="none"/>";
		}
		return true;
	}
	
	function saveForm() {
		 if(audEvd$validateform('myForm')) {
			 myForm.action='${contextPath}/riskManagement/management/majorRiskReport/saveMajorRisk.action';
			 myForm.submit();
		 }
	}
	
	function doStart(){
		document.getElementById('myForm').action = "start.action";
		document.getElementById('myForm').submit();
	}

</script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
	<body onload="end();sucFun();">
</s:if>
<s:else>
	<body onload="sucFun();">
</s:else>
    <div class="easyui-layout" title="" fit='true' style="overflow: auto; width: 100%;height: 100%;">
    	<div region="center"  border='0'> 
    	<s:form id="myForm" namespace="/riskManagement/management/majorRiskReport">
    		<div style="width: 100%;position:absolute;top:0px;" id="div1" align="center" >
				<table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
					<tr class="EditHead">
						<td >
						<span style='float: left; text-align: left;'>
						<s:property value="#title" /></span>
					   </td> 
						<td>
						<span style='float: right; text-align: right;'>
							<s:if test="crudObject.formId!=null">
								<jsp:include flush="true"
										page="/pages/bpm/list_toBeStart.jsp" /> &nbsp;&nbsp;&nbsp;&nbsp;	
							</s:if>	
							<a href="javascript:void(0);" id="root" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>&nbsp; 
							<s:if test="${ param.todoback ne '1' }">
							  <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
									onclick="this.style.disabled='disabled';window.location.href='${contextPath}/riskManagement/management/majorRiskReport/listMajorRisks.action'">返回</a>
							</s:if>
		 					<s:else>
								<s:if test="${taskInstanceId!=null&&taskInstanceId>0} && ${todoback == '1' }">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
			 							onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'">返回</a>
								</s:if>
							</s:else> 
						</span>
						</td>
					</tr>
			
				</table>
			</div>
			
			<div class="position:relative" id="div2">
    		<s:hidden name="crudObject.formId" id="id"></s:hidden>
    		<s:hidden name="crudObject.operateType"></s:hidden>
    		<s:hidden name="crudObject.file_id"></s:hidden>
    		<s:hidden name="crudObject.status"></s:hidden>
    		<s:hidden name="crudObject.templateId" id="templateId"></s:hidden>
    		<s:hidden name="crudObject.taskOrder" id="taskOrder"></s:hidden>
    		<s:hidden name="crudObject.taskPcode" id="taskPcode"></s:hidden>
    		<table id='myTable' align="center" class="ListTable" style='margin-top: 40px; overflow: auto;'>
    			<tr>
    				<td class="EditHead">编号</td>
    				<td class="editTd">
    					<s:textfield id="taskCode" name="crudObject.taskCode" readonly="true" cssClass="noborder"/>
    				</td>
    				<td class="EditHead"><font color="color">*</font>风险事项</td>
    				<td class="editTd">
    					<s:textfield id="taskName" name="crudObject.taskName" maxlength="100" cssClass="noborder editElement required"/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>风险描述
    					<div style="float: center"><font color="red">（2000字以内）</font></div>
    				</td>
    				<td class="editTd" colspan="3"> 
    					<textarea type='text' id='crudObject_riskDescription' name='crudObject.riskDescription'
				 			class="noborder editElement required clear len2000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${crudObject.riskDescription}</textarea>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>影响描述
    					<div style="float: center"><font color="red">（2000字以内）</font></div>
    				</td>
    				<td class="editTd" colspan="3">
    					<textarea type='text' id='crudObject_influenceDescription' name='crudObject.influenceDescription' 
						class="noborder editElement required clear len2000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${crudObject.influenceDescription}</textarea>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead"><font color="red">*</font>风险归类</td>
    				<td class="editTd">
    					<s:buttonText2 id="taskPname" hiddenId="taskPid" cssClass="noborder editElement required"
							name="crudObject.taskPname" 
							hiddenName="crudObject.taskPid"
							doubleOnclick="getTaskPid(this)"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="风险树" maxlength="100"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>风险类型</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="crudObject.riskTypeCode" class="noborder editElement required">
    						<s:iterator value="basicUtil.riskTypeList" id="entry">
    							<s:if test="${crudObject.riskTypeCode == key}">
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
    				<td class="EditHead"><font color="red">*</font>所属单位</td>
    				<td class="editTd">
    					<s:buttonText2 id="affiliatedDeptName" hiddenId="affiliatedDeptId" cssClass="noborder editElement required"
							name="crudObject.affiliatedDeptName" 
							hiddenName="crudObject.affiliatedDeptId"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								 title:'请选择接收单位',
                                 param:{
                                   'p_item':1,
                                   'orgtype':1
                                 },
                                  defaultDeptId:'${user.fdepid}',
                                 onAfterSure:function(){
                                   $('#majorDutyDeptName').val('');
                                   $('#majorDutyDeptId').val('');
                                   $('#minorDutyDeptName').val('');
                                   $('#minorDutyDeptId').val('');   
                                 }                                 
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="接收单位" maxlength="100"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>主责部门</td>
    				<td class="editTd">
    					<s:buttonText2 id="majorDutyDeptName" hiddenId="majorDutyDeptId" cssClass="noborder editElement required"
							name="crudObject.majorDutyDeptName" 
							hiddenName="crudObject.majorDutyDeptId"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								 title:'请主责部门',
                                 param:{
                                   'p_item':1,
                                   'orgtype':1
                                 },
                                  defaultDeptId:'${user.fdepid}',
                                 onAfterSure:function(){
                                 }
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="主责部门" maxlength="100"/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">次主责部门</td>
    				<td class="editTd">
    					<s:buttonText2 id="minorDutyDeptName" hiddenId="minorDutyDeptId" cssClass="noborder"
							name="crudObject.minorDutyDeptName" 
							hiddenName="crudObject.minorDutyDeptId"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								 title:'请选择次主责部门',
                                 param:{
                                   'p_item':1,
                                   'orgtype':1
                                 },
                                  defaultDeptId:'${user.fdepid}',
                                  checkbox:true,
                                 onAfterSure:function(){
                                 }
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="次主责部门" maxlength="100"/>
    				</td>
    				
    				<td class="EditHead">涉及业务</td>
    				<td class="editTd">
    					<s:textfield name="crudObject.involvedBusiness" maxlength="100"  cssClass="noborder"></s:textfield>
    				</td>
    			</tr>
    			
    			<tr>
					<td class="EditHead">
						风险成因
					</td>
					<td class="editTd" colspan="3">
						<textarea type='text' id='crudObject_riskCause' name='crudObject.riskCause'
				 			class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${crudObject.riskCause}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						风险源
					</td>
					<td class="editTd" colspan="3">
						<textarea type='text' id='crudObject_riskSource' name='crudObject.riskSource'
				 			class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${crudObject.riskSource}</textarea>
					</td>
				</tr>
    			
    			 <tr>
    				<td class="EditHead">估计财务损失</td>
    				<td class="editTd">
    					<s:textfield name="crudObject.estimatedFinancialLoss" maxlength="100"  cssClass="noborder"></s:textfield>万元
    				</td>
    				<td class="EditHead">实际财务损失</td>
    				<td class="editTd">
    					<s:textfield name="crudObject.actualFinancialLoss" maxlength="100"  cssClass="noborder"></s:textfield>万元
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">当前管控情况</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="crudObject.currentControlSituation">
    						<s:iterator value="basicUtil.riskChargeList">
    							<s:if test="${crudObject.currentControlSituation == key}">
    								<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
    							</s:if>
    							<s:else>
    								<option value="<s:property value="code"/>"><s:property value="name"/></option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    				<td class="EditHead">上报时间</td>
    				<td class="editTd">
    					<s:property value="crudObject.createTime"></s:property>
    					<s:hidden name="crudObject.createTime"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">上报部门</td>
    				<td class="editTd">
    					<s:property value="crudObject.createrDeptName"></s:property>
    					<s:hidden name="crudObject.createrDeptId"></s:hidden>
    					<s:hidden name="crudObject.createrDeptName"></s:hidden>
    				</td>
    				<td class="EditHead">上报人</td>
    				<td class="editTd">
    					<s:property value="crudObject.createrName"></s:property>
    					<s:hidden name="crudObject.createrName"></s:hidden>
    					<s:hidden name="crudObject.createrId"></s:hidden>
    				</td>
    			</tr>
    		</table>
    		</div>
    		
    		<s:if test="${taskInstanceId ne -1}">
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
				</div>		
			</s:if>
			
			<div align="center">
				<jsp:include flush="true"
					page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>
    	</div>
    	</s:form>
    	<div border="0" region="south">
    			<div id="evidence_file" class="easyui-fileUpload"  data-options="fileGuid:'${crudObject.file_id}' ,callbackGridHeight:200"></div>
    	</div>
     </div>
    
    
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
