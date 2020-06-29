<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>执行结果</title>
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
</head>
<body>
       	<div data-options="region:'center',split:true">
    		<s:hidden name="riskCollectTask.formId" id="id"/>
    		<table id='myTable' align="center" class="ListTable" style='margin-top: 40px; overflow: auto;'>
    			<tr>
    				<td class="EditHead">编号</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.sn"/>
    				</td>
    				<td class="EditHead">年度</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskCollectTask.year" disabled="disabled">
    						<s:iterator value="@ais.framework.util.DateUtil@getIncrementYearList(10,5)" id="entry">
    							<s:if test="${riskCollectTask.year == entry}">
    								<option selected="selected" value="${entry}">${entry}</option>
    							</s:if>
    							<s:else>
    								<option value="${entry}">${entry}</option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">风险信息收集任务</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.taskName"/>
    				</td>
    				<td class="EditHead">适用风险分类体系</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="riskCollectTask.riskType" disabled="disabled">
    						<s:iterator value="riskTemplates">
    							<s:if test="${riskCollectTask.riskType == templateId }">
    								<option selected="selected" value="<s:property value="templateId"/>"><s:property value="templateName"/></option>
    							</s:if>
    							<s:else>
    								<option value="<s:property value="templateId"/>"><s:property value="templateName"/></option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">接收单位</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.acceptingUnitName" />
    				</td>
    				<td class="EditHead">接收部门</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.acceptingDepName" />
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">收集开始时间</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.collectStartTime"/>
    				</td>
    				<td class="EditHead">收集截至时间</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.collectEndTime"/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">发起单位</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.initiateUnitName"></s:property>
    				</td>
    				<td class="EditHead">发起部门</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.initiateDepName"></s:property>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">发起人</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.initiatePersonName"></s:property>
    				</td>
    				<td class="EditHead">发起时间</td>
    				<td class="editTd">
    					<s:property value="riskCollectTask.initiateTime"></s:property>
    				</td>
    			</tr>
    		</table>
    	</div>
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
