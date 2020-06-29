<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>基本信息</title>
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
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
		$(function(){
			$('#head'+"_${riskTaskTemplate.file_id}").fileUpload({
				fileGuid:'${riskTaskTemplate.file_id}' == ''?'1':'${riskTaskTemplate.file_id}',
				echoType:2,
				isDel:false,
				isEdit:false,
				uploadFace:1,
				triggerId:false
			});
			
			$('#head'+"_${riskEvaluateWait.answerFileId}").fileUpload({
				fileGuid:'${riskEvaluateWait.answerFileId}' == ''?'1':'${riskEvaluateWait.answerFileId}',
				echoType:2,
				isDel:false,
				isEdit:false,
				isAdd:false,
				uploadFace:1,
				triggerId:false
			});
		});
		
		function closeWindow(){
			var frameWin = aud$getTabIframByTabId(parentTabId);
			var dvapWin  = frameWin.$('#gridRisk').get(0).contentWindow;
			 dvapWin.refresh(); 
			 aud$closeTab(curTabId, parentTabId);
		}
	</script>
</head>
<body>
	<div class="easyui-panel" title="风险基本信息" >
   		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
   			<tr>
   				<td class="EditHead">编号</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.taskCode"/>
   				</td>
   				<td class="EditHead">风险事项</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.taskName"/>
   				</td>
   			</tr>
   			<tr>
   				<td class="EditHead">
   					风险描述
   				</td>
   				<td class="editTd" colspan="3">
					<s:property value='riskTaskTemplate.riskDescription'/>
				</td>
   			</tr>
   			<tr>
   				<td class="EditHead">
   					影响描述
   				</td>
   				<td class="editTd" colspan="3">
					<s:property value='riskTaskTemplate.influenceDescription'/>
				</td>
   			</tr>
   			<tr>
   				<td class="EditHead">风险归类</td>
   				<td class="editTd">
   					<s:property	value="riskTaskTemplate.taskPname"/>
   				</td>
   				<td class="EditHead">风险类型</td>
   				<td class="editTd">
   					<select class="easyui-combobox" name="riskTaskTemplate.riskTypeCode" disabled="disabled">
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
   					<s:property value="riskTaskTemplate.affiliatedDeptName"/>
   				</td>
   				<td class="EditHead">主责部门</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.majorDutyDeptName"/>
   				</td>
   			</tr>
   			<tr>
   				<td class="EditHead">次主责部门</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.minorDutyDeptName"/>
   				</td>
   				
   				<td class="EditHead">涉及业务</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.involvedBusiness"/>
   				</td>
   			</tr>
   			<tr>
				<td class="EditHead">
					风险成因
				</td>
				<td class="editTd" colspan="3">
					<s:property value='riskTaskTemplate.riskCause'/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					风险源
				</td>
				<td class="editTd" colspan="3">
					<s:property value='riskTaskTemplate.riskSource'/>
				</td>
			</tr>
   			 <tr>
   				<td class="EditHead">估计财务损失</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.estimatedFinancialLoss"/>万元
   				</td>
   				<td class="EditHead">实际财务损失</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.actualFinancialLoss"/>万元
   				</td>
   			</tr>
   			<tr>
   				<td class="EditHead">当前管控情况</td>
   				<td class="editTd">
   					<select class="easyui-combobox" name="riskTaskTemplate.currentControlSituation" disabled="disabled">
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
   				<td class="EditHead">上报时间</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.createTime"></s:property>
   				</td>
   			</tr>
   			<tr>
   				<td class="EditHead">上报部门</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.createrDeptName"></s:property>
   				</td>
   				<td class="EditHead">上报人</td>
   				<td class="editTd">
   					<s:property value="riskTaskTemplate.createrName"></s:property>
   				</td>
   			</tr>
   			<tr>
    			<td class="EditHead">
    				附件
				</td>
    			<td class="editTd" colspan="3">
    				<div id="head_${riskTaskTemplate.file_id}" style="float: left"></div>
    				<div id="content_${riskTaskTemplate.file_id}" style="float: right"></div>
    			</td>
   			</tr>
    	</table>
    </div>
   	<br/>
	<!-- 风险评估结果确认 -->
	<div class="easyui-panel" style="height:400px;width:100%;padding:0px;" title="风险评估结果确认" >
		<!-- <table id="gridRiskList" class="ListTable"  ></table> -->
		<iframe width=100% height=350 frameborder=0 scrolling="no" id="gridRisk"
		 	src="${contextPath}/riskManagement/management/riskEvaluate/listRiskWaitSureDetail.action?rrs_id=${rrs_id}&isView=${isView}&parentTabId=${parentTabId}&riskEvaluateWaitId=${riskEvaluateWaitId}">
		</iframe>
	</div>
</body>
</html>
