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
<script type="text/javascript">
 $(function(){
	 $('#head'+"_${impResultInfo.file_id}").fileUpload({
			fileGuid:'${impResultInfo.file_id}' == ''?'1':'${impResultInfo.file_id}',
			echoType:2,
			isDel:false,
			isEdit:false,
			uploadFace:1,
			triggerId:false
	 });
	 
	 $('#head'+"_${impResultInfo.file_id02}").fileUpload({
			fileGuid:'${impResultInfo.file_id02}' == ''?'1':'${impResultInfo.file_id02}',
			echoType:2,
			isDel:false,
			isEdit:false,
			uploadFace:1,
			triggerId:'content'+'_${impResultInfo.file_id02}'
	 });
	 
	 var parentTabId = '${parentTabId}';
	 var curTabId = aud$getActiveTabId();

	 $('#sDTable').datagrid({
		 toolbar:[{
			 text:'保存',
			 iconCls:'icon-save',
			 handler:function() {
				 if(audEvd$validateform('myForm')) {
					 $.ajax({
						url: '${contextPath}/riskManagement/management/riskHandle/saveEvaluateImpInfo.action',
						type: 'POST',
						data: $('#myForm').serialize(),
						async: false,
						success: function(data){
							 if(data == '1') {
								 showMessage1('保存成功！');
								 aud$closeTab(curTabId, parentTabId);
							 }
						}
					 });
				 }
			 }
		 },'-',{
			 text:'查看历次评价',
			 iconCls:'icon-view',
			 handler:function() {
				 var url = '${contextPath}/riskManagement/management/riskHandle/listEvaluateImpInfos.action?hmId=${impResultInfo.hmId}';
				 aud$openNewTab('历次评价结果', url, true);
			 }
		 }/* ,'-',{
			 text:'关闭',
			 iconCls:'icon-cancel',
			 handler:function() {
				 var frameWin = aud$getTabIframByTabId(parentTabId);
				 var dvapWin = frameWin.$('#myFrame4').get(0).contentWindow;
				 dvapWin.g1.refresh(); 
				 aud$closeTab(curTabId, parentTabId);
			 }
		 } */]
	 });
});
 
 function viewHistory(){
	 var url = '${contextPath}/riskManagement/management/riskHandle/listImpResultInfos.action?hmId=${impResultInfo.hmId}';
	 aud$openNewTab('历次执行结果', url, true);
 }
 
</script>
</head>
<body>
    	<div region="center">   	 	
            	<table id='sDTable'></table>
       	</div>
       	
    	<s:form id="myForm">
    		<s:hidden name="impResultInfo.id"></s:hidden>
    		<s:hidden name="impResultInfo.hmId"></s:hidden>
    		<s:hidden name="impResultInfo.file_id"></s:hidden>
    		<s:hidden name="impResultInfo.file_id02"></s:hidden>
    		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
    				<td colspan="4" style="background-color: #E0ECFF">
    					<font color="#0E2D5F">应对措施执行情况查看</font>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">执行结果</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.impResult"/>
    				</td>
    				<td class="EditHead">执行状态</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.impStatusName"/>&nbsp;&nbsp;&nbsp;&nbsp;<span onclick="viewHistory()">查看历次执行结果</span>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					具体描述
    				</td>
    				<td class="editTd" colspan="3">
						<s:property value='impResultInfo.detailedDes'/>
					</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">执行部门</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.impDeptName"/>
    				</td>
    				<td class="EditHead">执行人</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.impPersonName"/>
    				</td>
    			</tr>
 				<tr>
					<td class="EditHead">
						备注
					</td>
					<td class="editTd" colspan="3">
						<s:property value='impResultInfo.remark'/>
					</td>
				</tr>
    			
    			<tr>
    				<td class="EditHead">录入人</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.enterManName"></s:property>
    				</td>
    				<td class="EditHead">录入时间</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.enterTime"></s:property>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">录入部门</td>
    				<td class="editTd" colspan="3">
    					<s:property value="impResultInfo.enterDeptName"></s:property>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">附件</td>
    				<td class="editTd" colspan="3">
    					<div id="head_${impResultInfo.file_id}" style="float: left"></div>
    					<div id="content_${impResultInfo.file_id}" style="float: right"></div>
    				</td>
    			</tr>
    			<tr>
    				<td colspan="4" style="background-color: #E0ECFF">
    					<font color="#0E2D5F">应对措施执行情况评价</font>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead"><font color="color">*</font>执行状态评价</td>
    				<td class="editTd" colspan="3">
    					<select name="impResultInfo.impStatusEvaluate" class="noborder editElement required">
    						<s:iterator value="basicUtil.impStatusList">
    							<s:if test="${impResultInfo.impStatusEvaluate == code}">
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
    					<font color="red">*</font>评价描述
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='impResultInfo_evaluateDes' name='impResultInfo.evaluateDes'
				 			class="noborder editElement required clear len1000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${impResultInfo.evaluateDes}</textarea>
					</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">评价人</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.evaluateManName"></s:property>
    					<s:hidden name="impResultInfo.evaluateMan"></s:hidden>
    					<s:hidden name="impResultInfo.evaluateManName"></s:hidden>
    				</td>
    				<td class="EditHead">评价时间</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.evaluateTime"></s:property>
    					<s:hidden name="impResultInfo.evaluateTime"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">评价部门</td>
    				<td class="editTd" colspan="3">
    					<s:property value="impResultInfo.evaluateDeptName"></s:property>
    					<s:hidden name="impResultInfo.evaluateDept"></s:hidden>
    					<s:hidden name="impResultInfo.evaluateDeptName"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">附件</td>
    				<td class="editTd" colspan="3">
    					<div id="head_${impResultInfo.file_id02}" style="float: left"></div>
    					<div id="content_${impResultInfo.file_id02}" style="float: right"></div>
    				</td>
    			</tr>
    		</table>
    	</s:form>
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
