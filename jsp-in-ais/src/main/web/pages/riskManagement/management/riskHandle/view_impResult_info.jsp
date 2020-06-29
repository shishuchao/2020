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
	 var parentTabId = '${parentTabId}';
	 var curTabId = aud$getActiveTabId();
	 $('#head'+"_${impResultInfo.file_id}").fileUpload({
			fileGuid:'${impResultInfo.file_id}' == ''?'1':'${impResultInfo.file_id}',
			echoType:2,
			isDel:false,
			isEdit:false,
			uploadFace:1,
			triggerId:false
	 });
});
 
</script>
</head>
<body>
    <!-- <div class="easyui-panel" title="新增风险事项" fit='true' style="overflow: visible;" region="center"> -->
    	<s:form id="myForm">
    		<s:hidden name="impResultInfo.id"></s:hidden>
    		<s:hidden name="impResultInfo.hmId"></s:hidden>
    		<s:hidden name="impResultInfo.file_id"></s:hidden>
    		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
    				<td class="EditHead">执行结果</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.impResult"/>
    				</td>
    				<td class="EditHead"><font color="color">*</font>执行状态</td>
    				<td class="editTd">
    					<select name="impResultInfo.impStatus" disabled="disabled" class="noborder editElement required">
    						<s:iterator value="basicUtil.impStatusList">
    							<s:if test="${impResultInfo.impStatus == code}">
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
    				<td class="editTd" colspan="3">
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
    		</table>
    	</s:form>
     <!--  </div> -->
    
    
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
