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
	 /*var parentTabId = '${parentTabId}';
	 var curTabId = aud$getActiveTabId();

	 $('#sDTable').datagrid({
		 toolbar:[{
			 text:'关闭',
			 iconCls:'icon-cancel',
			 handler:function() {
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
		 }]
	 });*/
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
 
</script>
</head>
<body>
    <!-- <div class="easyui-panel" title="新增风险事项" fit='true' style="overflow: visible;" region="center"> -->
    	<!-- <div region="center">   	 	
            	<table id='sDTable'></table>
       	</div> -->
       	
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
    					<s:property value="riskTask.taskCode" />
    				</td>
    				<td class="EditHead">风险事项</td>
    				<td class="editTd">
    					<s:property value="riskTask.taskName" />
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">
    					风险描述
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='riskTask_riskDescription' name='riskTask.riskDescription' readonly="readonly"
				 			class="noborder editElement required clear len2000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTask.riskDescription}</textarea>
					</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">
    					影响描述
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='riskTask_influenceDescription' name='riskTask.influenceDescription' 
						class="noborder editElement required clear len2000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTask.influenceDescription}</textarea>
					</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">风险归类</td>
    				<td class="editTd">
    					<s:property value="riskTask.taskPname" />
    				</td>
    				<td class="EditHead">风险类型</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskTask.riskTypeCode" disabled="disabled">
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
    				<td class="EditHead">所属单位</td>
    				<td class="editTd">
    					<s:property value="riskTask.affiliatedDeptName" />
    				</td>
    				<td class="EditHead">主责部门</td>
    				<td class="editTd">
    					<s:property value="riskTask.majorDutyDeptName" />
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">次主责部门</td>
    				<td class="editTd">
    					<s:property value="riskTask.minorDutyDeptName" />
    				</td>
    				
    				<td class="EditHead">涉及业务</td>
    				<td class="editTd">
    					<s:property value="riskTask.involvedBusiness" />
    				</td>
    			</tr>
    			
    			<tr>
					<td class="EditHead">
						风险成因
					</td>
					<td class="editTd" colspan="3">
						<textarea type='text' id='riskTask_riskCause' name='riskTask.riskCause' readonly="readonly"
				 			class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTask.riskCause}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						风险源
					</td>
					<td class="editTd" colspan="3">
						<textarea type='text' id='riskTask_riskSource' name='riskTask.riskSource' readonly="readonly"
				 			class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${riskTask.riskSource}</textarea>
					</td>
				</tr>
    			
    			 <tr>
    				<td class="EditHead">估计财务损失</td>
    				<td class="editTd">
    					<s:property value="riskTask.estimatedFinancialLoss" />万元
    				</td>
    				<td class="EditHead">实际财务损失</td>
    				<td class="editTd">
    					<s:property value="riskTask.actualFinancialLoss" />万元
    				</td>
    			</tr>
    			
    			<s:if test="${riskTask.operateType == '0'}">
    			<tr>
    				<td class="EditHead">当前管控情况</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskTask.currentControlSituation" disabled="disabled">
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
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">上报部门</td>
    				<td class="editTd">
    					<s:property value="riskTask.createrDeptName"></s:property>
    				</td>
    				<td class="EditHead">上报人</td>
    				<td class="editTd">
    					<s:property value="riskTask.createrName"></s:property>
    				</td>
    			</tr>
    			</s:if>
    			<s:else>
    				<tr>
    				<td class="EditHead">当前管控情况</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskTask.currentControlSituation" disabled="disabled">
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
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					调整说明
    				</td>
    				<td class="editTd" colspan="3">
    					<s:property value="riskTask.adjustIllustrate" />
    				</td>
    			</tr>
    			</tr>
    			<tr>
    				<td class="EditHead">调整人所在部门</td>
    				<td class="editTd">
    					<s:property value="riskTask.createrDeptName"></s:property>
     				</td>
    				<td class="EditHead">调整人</td>
    				<td class="editTd">
    					<s:property value="riskTask.createrName"></s:property>
    				</td>
    			</tr>
    			</s:else>
    		</table>
    	</s:form>
    	<div border="0" region="south">
    		<div id="evidence_file" class="easyui-fileUpload"  data-options="fileGuid:'${riskTask.file_id}' , isAdd:false,
								               isEdit:false,
								               isDel:false,callbackGridHeight:400"></div>
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
