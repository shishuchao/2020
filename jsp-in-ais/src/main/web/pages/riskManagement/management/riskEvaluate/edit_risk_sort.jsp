<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>设置风险应对策略</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script> 
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript">
 $(function(){
	 $('#head'+"_${riskEvaluateWait.answerFileId}").fileUpload({
	 	fileGuid:'${riskEvaluateWait.answerFileId}' == ''?'1':'${riskEvaluateWait.answerFileId}',
		echoType:2,
		uploadFace:1,
		<s:if test="view != 'Y'">
	 		isDel:true,
	 		isEdit:true,
			triggerId:'content'+'_${riskEvaluateWait.answerFileId}'
		</s:if>
		<s:else>
			isDel:false,
	 		isEdit:false,
			triggerId:false
		</s:else>
	});
	 
	 var parentTabId = '${parentTabId}';
	 var curTabId = aud$getActiveTabId();
	 $('#sDTable').datagrid({
		 toolbar:[
		 <s:if test="view != 'Y'">
		    {
			 text:'保存',
			 iconCls:'icon-save',
			 handler:function() {
				 if(audEvd$validateform('myForm')) {
					 $.post('${contextPath}/riskManagement/management/riskSort/saveRiskSort.action',$('#myForm').serialize(),function (data){
						 if(data.result == '0') {
						 	showMessage1('保存成功！');
						 }
					 });
				 }
			 }
		 },'-',
		 {
			 text:'提交',
			 iconCls:'icon-ok',
			 handler:function() {
				 if(audEvd$validateform('myForm')) {
					 $.post('${contextPath}/riskManagement/management/riskSort/submitRiskSort.action',$('#myForm').serialize(),function (data){
						 if(data.result == '0') {
						 	showMessage1('提交成功！');
						 	 var frameWin = aud$getTabIframByTabId(parentTabId);
							 frameWin.refresh(); 
							 aud$closeTab(curTabId, parentTabId);
						 }
					 });
				 }
			 }
		 }
		 </s:if>
        ]
	 });
});
 
</script>
</head>
<body>
    <div title="设置风险应对策略" fit='true' style="overflow: visible;">
    	<div region="center">   	 	
            	<table id='sDTable'></table>
       	</div>
       	
    	<s:form id="myForm">
    		<s:hidden name="riskEvaluateWait.id" id="id"></s:hidden>
    		<s:hidden name="riskEvaluateWait.evaluateSerialNum" id="evaluateSerialNum"></s:hidden>
    		<s:hidden name="riskEvaluateWait.status"></s:hidden>
    		<s:hidden name="riskEvaluateWait.answerFileId"></s:hidden>
    		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
    				<td class="EditHead"><font color="red">*</font>应对策略</td>
    				<td class="editTd">
    					<select id="answerPlot" class="easyui-combobox editElement required" name="riskEvaluateWait.answerPlot" style="width:150px;" data-options="panelHeight:'auto'" >
					       <option value="">&nbsp;</option>
					       <s:iterator value="basicUtil.risk_RepoliciesList" id="entry">
						         <s:if test="${riskEvaluateWait.answerPlot==code}">
					       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
					       		 </s:if>
					       		 <s:else>
							        <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       		 </s:else>
					       </s:iterator>
					    </select>	
    				</td>
    				<td class="EditHead"><font color="red">*</font>优先顺序</td>
    				<td class="editTd">
    					<select class="easyui-combobox editElement required" name="riskEvaluateWait.prioritySort" style="width:150px;"  editable="false">
					       <option value="">&nbsp;</option>
					       <s:iterator value='#@java.util.LinkedHashMap@{"0":"低","1":"中","2":"高"}' id="entry">
						       <s:if test="${riskEvaluateWait.prioritySort==key}">
						       	 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:if>
						       <s:else>
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						         </s:else>
						       </s:iterator>
					    </select>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead"><font color="red">*</font>要求开始时间</td>
    				<td class="editTd">
    					<input type="text" id="demandStartTime" name="riskEvaluateWait.demandStartTime" value="${riskEvaluateWait.demandStartTime}"
								class="easyui-datebox editElement required" editable="false"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>要求完成时间</td>
    				<td class="editTd">
    					<input type="text" id="demandEndTime editElement required" name="riskEvaluateWait.demandEndTime" value="${riskEvaluateWait.demandEndTime}"
								class="easyui-datebox" editable="false"/>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>风险应对建议
    					<div style="float: center"><font color="red">（2000字以内）</font></div>
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='answerAdvice' name='riskEvaluateWait.answerAdvice' 
						class="noborder editElement required clear len200" style='border-width:0px;height:150px;width:99%;overflow:hidden;' >${riskEvaluateWait.answerAdvice}</textarea>
					</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					附件
					</td>
    				<td class="editTd" colspan="3">
    					<div id="head_${riskEvaluateWait.answerFileId}" style="float: left"></div>
    					<div id="content_${riskEvaluateWait.answerFileId}" style="float: right"></div>
    				</td>
    			</tr>
    		</table>
    	</s:form>
    </div>
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
