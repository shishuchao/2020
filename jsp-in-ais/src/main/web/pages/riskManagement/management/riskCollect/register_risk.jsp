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
<script type="text/javascript">
 $(function(){
     autoTextarea($('#riskTask_riskDescription')[0]);
     autoTextarea($('#riskTask_influenceDescription')[0]);
     autoTextarea($('#adjustIllustrate')[0]);
     var value1 = document.getElementById('estimatedFinancialLoss').value;
     var value2 = document.getElementById('actualFinancialLoss').value;
     var num1 = new Number(value1);
     var num2 = new Number(value2);
     $('#estimatedFinancialLoss').val(num1);
     $('#actualFinancialLoss').val(num2);
});
 
 function getTaskPid(obj) {
	 showSysTree(obj,
				{ reeTabTitle1:'风险树',
				  cascadeCheck:false,
				  dnd:true,
				  noMsg:true,
				  queryBox:false,
               	  param:{
                  	   'rootParentId':'-1',
                  	   'whereHql':'template_type != \'2\' and template_Id = \'${riskTask.templateId}\'',
                       'beanName':'RiskTaskTemplateTree',
                       'treeId'  :'taskId',
					   'treeText':'taskName',
					   'treeParentId':'taskPid',
					   'treeOrder':'taskCode',
					   'treeAtrributes':'template_type'
                  }                                
	});
 }
 /*
 * 保存方法
  */
 function save(){
     var val1= document.getElementById('estimatedFinancialLoss').value;
     var val2= document.getElementById('actualFinancialLoss').value;
     if( !isNaN(val1)){
         if( !isNaN(val2)){
             if(audEvd$validateform('myForm')) {
                 $.ajax({
                     url: '${contextPath}/riskManagement/management/riskRegister/saveRigisterRisk.action',
                     type: 'POST',
                     data: $('#myForm').serialize(),
                     async: false,
                     success: function(data){
                         if(data.result == '1') {
                             $('#taskCode').val(data.taskCode);
                             $('#taskOrder').val(data.taskOrder);
                             $('#taskPcode').val(data.taskPcode);
                         }else if(data.result == '2') {
                             $('#taskCode').val(data.taskCode);
                             $('#taskOrder').val(data.taskOrder);
                             $('#taskPcode').val(data.taskPcode);
                             $('#id').val(data.taskId);
                         }
                         showMessage1('保存成功！');
                     }
                 });
             }
         }else{
             showMessage1("实际财务损失数据格式不是数字！");
         }
     }else{
         showMessage1("估计财务损失数据格式不是数字！");
     }
 }
 function closeWin (){
     var parentTabId = '${parentTabId}';
     var curTabId = aud$getActiveTabId();
     var frameWin = aud$getTabIframByTabId(parentTabId);
     var dvapWin;
     if('${riskTask.operateType}' == '0')
         dvapWin = frameWin.$('#myFrame1').get(0).contentWindow;
     else if('${riskTask.operateType}' == '1'){
         dvapWin = frameWin.$('#myFrame2').get(0).contentWindow;
     }
     dvapWin.g1.refresh();
     aud$closeTab(curTabId, parentTabId);
 }
</script>
</head>
<body>
    <!-- <div class="easyui-panel" title="新增风险事项" fit='true' style="overflow: visible;" region="center"> -->
    	<%--<div region="center">
            	<table id='sDTable'></table>
       	</div>--%>
        <div style='float: left; text-align: left;padding-bottom: 5px'>
            <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="save();">保存</a>&nbsp;
            <a href="javascript:void(0);" id="closeBtn" class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="closeWin();">关闭</a>
        </div>
       	
    	<s:form id="myForm">
    		<s:hidden name="riskTask.formId" id="id"></s:hidden>
    		<s:hidden name="riskTask.operateType"></s:hidden>
    		<s:hidden name="riskTask.file_id"></s:hidden>
    		<s:hidden name="riskTask.collectTaskId"></s:hidden>
    		<s:hidden name="riskTask.collectTaskName"></s:hidden>
    		<s:hidden name="riskTask.collectTaskYear"></s:hidden>
    		<s:hidden name="riskTask.templateId"></s:hidden>
    		<s:hidden name="riskTask.taskOrder" id="taskOrder"></s:hidden>
    		<s:hidden name="riskTask.taskPcode" id="taskPcode"></s:hidden>
    		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
    				<td class="EditHead">编号</td>
    				<td class="editTd">
    					<s:textfield id="taskCode" name="riskTask.taskCode" readonly="true" cssClass="noborder"/>
    				</td>
    				<td class="EditHead"><font color="color">*</font>风险事项</td>
    				<td class="editTd">
    					<s:textfield id="taskName" name="riskTask.taskName" maxlength="100" cssClass="noborder editElement required"/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>风险描述
    					<div style="float: center"><font color="red">（2000字以内）</font></div>
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='riskTask_riskDescription' name='riskTask.riskDescription'
				 			class="noborder editElement required clear len2000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTask.riskDescription}</textarea>
					</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>影响描述
    					<div style="float: center"><font color="red">（2000字以内）</font></div>
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='riskTask_influenceDescription' name='riskTask.influenceDescription' 
						class="noborder editElement required clear len2000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTask.influenceDescription}</textarea>
					</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead"><font color="red">*</font>风险归类</td>
    				<td class="editTd">
    					<s:buttonText2 id="taskPname" hiddenId="taskPid" cssClass="noborder editElement required"
							name="riskTask.taskPname" 
							hiddenName="riskTask.taskPid"
							doubleOnclick="getTaskPid(this)"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="风险树" maxlength="100"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>风险类型</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskTask.riskTypeCode">
    						<s:iterator value="basicUtil.riskTypeList" id="entry">
    							<s:if test="${riskCollectTask.riskTypeCode == key}">
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
							name="riskTask.affiliatedDeptName" 
							hiddenName="riskTask.affiliatedDeptId"
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
							name="riskTask.majorDutyDeptName" 
							hiddenName="riskTask.majorDutyDeptId"
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
							name="riskTask.minorDutyDeptName" 
							hiddenName="riskTask.minorDutyDeptId"
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
    					<s:textfield name="riskTask.involvedBusiness" maxlength="100"  cssClass="noborder"></s:textfield>
    				</td>
    			</tr>
    			
    			<tr>
					<td class="EditHead">
						风险成因
					</td>
					<td class="editTd" colspan="3">
						<textarea type='text' id='riskTask_riskCause' name='riskTask.riskCause'
				 			class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTask.riskCause}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						风险源
					</td>
					<td class="editTd" colspan="3">
						<textarea type='text' id='riskTask_riskSource' name='riskTask.riskSource'
				 			class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTask.riskSource}</textarea>
					</td>
				</tr>
    			
    			 <tr>
    				<td class="EditHead">估计财务损失</td>
    				<td class="editTd">
    					<s:textfield id="estimatedFinancialLoss" name="riskTask.estimatedFinancialLoss" maxlength="100"  cssClass="noborder money"></s:textfield>万元
    				</td>
    				<td class="EditHead">实际财务损失</td>
    				<td class="editTd">
    					<s:textfield id="actualFinancialLoss" name="riskTask.actualFinancialLoss" maxlength="100"  cssClass="noborder money"></s:textfield>万元
    				</td>
    			</tr>
    			
    			<s:if test="${riskTask.operateType == '0'}">
    			<tr>
    				<td class="EditHead">当前管控情况</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskTask.currentControlSituation">
    						<s:iterator value="basicUtil.riskChargeList">
    							<s:if test="${riskTask.currentControlSituation == key}">
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
    					<s:property value="riskTask.createTime"></s:property>
    					<s:hidden name="riskTask.createTime"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">上报部门</td>
    				<td class="editTd">
    					<s:property value="riskTask.createrDeptName"></s:property>
    					<s:hidden name="riskTask.createrDeptId"></s:hidden>
    					<s:hidden name="riskTask.createrDeptName"></s:hidden>
    				</td>
    				<td class="EditHead">上报人</td>
    				<td class="editTd">
    					<s:property value="riskTask.createrName"></s:property>
    					<s:hidden name="riskTask.createrName"></s:hidden>
    					<s:hidden name="riskTask.createrId"></s:hidden>
    				</td>
    			</tr>
    			</s:if>
    			<s:else>
    				<tr>
    				<td class="EditHead">当前管控情况</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskTask.currentControlSituation">
    						<s:iterator value="basicUtil.riskChargeList">
    							<s:if test="${riskTask.currentControlSituation == key}">
    								<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
    							</s:if>
    							<s:else>
    								<option value="<s:property value="code"/>"><s:property value="name"/></option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    				<td class="EditHead">调整时间</td>
    				<td class="editTd">
    					<s:property value="riskTask.createTime"></s:property>
    					<s:hidden name="riskTask.createTime"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>调整说明
    				</td>
    				<td class="editTd" colspan="3">
    					<textarea id="adjustIllustrate" name="riskTask.adjustIllustrate" cssClass="noborder editElement required"
    						cssStyle="width:80%;height:50px;overflow-y:visible;line-height:150%;">${riskTask.adjustIllustrate}</textarea>
    					<!-- <input type="hidden" id="riskTask.adjustIllustrate.length" value="1000"/> -->
    				</td>
    			</tr>
    			</tr>
    			<tr>
    				<td class="EditHead">调整人所在部门</td>
    				<td class="editTd">
    					<s:property value="riskTask.createrDeptName"></s:property>
    					<s:hidden name="riskTask.createrDeptId"></s:hidden>
    					<s:hidden name="riskTask.createrDeptName"></s:hidden>
    				</td>
    				<td class="EditHead">调整人</td>
    				<td class="editTd">
    					<s:property value="riskTask.createrName"></s:property>
    					<s:hidden name="riskTask.createrName"></s:hidden>
    					<s:hidden name="riskTask.createrId"></s:hidden>
    				</td>
    			</tr>
    			</s:else>
    		</table>
    	</s:form>
    	<div border="0" region="south">
    		<div id="evidence_file" class="easyui-fileUpload"  data-options="fileGuid:'${riskTask.file_id}' ,callbackGridHeight:400"></div>
    	</div>
     <!--  </div> -->
    
    
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
