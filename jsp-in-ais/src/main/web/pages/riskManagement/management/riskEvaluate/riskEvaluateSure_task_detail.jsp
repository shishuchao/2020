<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%-- <jsp:directive.page import="ais.framework.util.UUID"/> --%>

<html>
<title>风险评估结果确认审核-风险评估任务详情</title>
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
	</script>
</head>
<body>
	<div class="easyui-layout" title="" fit='true' style="overflow: auto; width: 100%;height: 100%;">
	<div region="center" border='0'>
    <!-- 评估任务基本信息 -->
   <div class="easyui-panel" title="评估任务基本信息" class="position:relative" class="easyui-panel">
    		<table id='mytable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
    				<td class="EditHead">编号</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.serial_num"/>
    				</td>
    				<td class="EditHead">评估任务</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.taskName"/>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">评估单位</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.evaluateCompanyName"/>
    				</td>
    				<td class="EditHead">评估状态</td>
    				<td class="editTd">
    					<s:if test="${riskEvaluateTask.status == 0 }">
    						待评估
    					</s:if>
    					<s:elseif test="${riskEvaluateTask.status == 1 }">
    						评估中
    					</s:elseif>
    					<s:else>
    						已评估
    					</s:else>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">风险分类体系</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.riskTypeName"/>
    				</td>
    				<td class="EditHead">风险评估体系</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.riskEvaluateName"/>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">评估开始时间</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.evaluateStartTime"/>
    				</td>
    				<td class="EditHead">评估截止时间</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.evaluateEndTime"/>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">评估部门</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.evaluateDepartmentName"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>评估年度</td>
    				<td class="editTd">
    					<s:property value="riskEvaluateTask.evaluateYear"/>
    				</td>
    			</tr>
    		</table>
    </div>
	<br/>
	<!-- 风险列表 -->
	<div class="easyui-panel" style="height:380px;width:100%;padding:0px;" title="风险列表">
		<!-- <table id="gridRiskList" class="ListTable"  ></table> -->
		<iframe width=100% height=380 frameborder=0 scrolling="no" id="gridRisk"
		 	src="${contextPath}/riskManagement/management/riskEvaluate/listRiskWaitSure.action?view=${view}&riskevaluate_id=${riskevaluate_id}&riskEvaluate=${riskEvaluateTask.riskEvaluate}">
		</iframe>
	</div>
	</div>
	</div>
</body>
</html>
