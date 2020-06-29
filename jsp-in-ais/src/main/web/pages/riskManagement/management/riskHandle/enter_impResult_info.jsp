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
			triggerId:'content'+'_${impResultInfo.file_id}'
	 });

	 $('#sDTable').datagrid({
		 toolbar:[{
			 text:'保存',
			 iconCls:'icon-save',
			 handler:function() {
				 if(audEvd$validateform('myForm')) {
					 $.ajax({
						url: '${contextPath}/riskManagement/management/riskHandle/saveImpResultInfo.action',
						type: 'POST',
						data: $('#myForm').serialize(),
						async: false,
						success: function(data){
							 if(data == '1') {
								 showMessage1('保存成功！');
								var frameWin = aud$getTabIframByTabId(parentTabId);
								 aud$closeTab(curTabId, parentTabId);
							 }
						}
					 });
				 }
			 }
		 },'-',{
			 text:'历次执行结果',
			 iconCls:'icon-view',
			 handler:function() {
				 var url = '${contextPath}/riskManagement/management/riskHandle/listImpResultInfos.action?hmId=${impResultInfo.hmId}';
				 aud$openNewTab('历次执行结果', url, true);
			 }
		 }]
	 });
});
 
</script>
</head>
<body>
    <!-- <div class="easyui-panel" title="新增风险事项" fit='true' style="overflow: visible;" region="center"> -->
    	<div region="center">   	 	
            	<table id='sDTable'></table>
       	</div>
       	
    	<s:form id="myForm">
    		<s:hidden name="impResultInfo.id"></s:hidden>
    		<s:hidden name="impResultInfo.hmId"></s:hidden>
    		<s:hidden name="impResultInfo.file_id"></s:hidden>
    		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
    				<td class="EditHead"><font color="red">*</font>执行结果</td>
    				<td class="editTd">
    					<s:textfield id="impResult" name="impResultInfo.impResult" cssClass="noborder editElement required"/>
    				</td>
    				<td class="EditHead"><font color="color">*</font>执行状态</td>
    				<td class="editTd">
    					<select name="impResultInfo.impStatus" class="noborder editElement required">
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
    					<font color="red">*</font>具体描述
    					<div style="float: center"><font color="red">（1000字以内）</font></div>
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='impResultInfo_detailedDes' name='impResultInfo.detailedDes'
				 			class="noborder editElement required clear len1000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${impResultInfo.detailedDes}</textarea>
					</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead"><font color="red">*</font>执行部门</td>
    				<td class="editTd">
    					<s:buttonText2 id="impDeptName" hiddenId="impDept" cssClass="noborder editElement required"
							name="impResultInfo.impDeptName" 
							hiddenName="impResultInfo.impDept"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								 title:'请选择接收单位',
                                 param:{
                                   'p_item':1,
                                   'orgtype':1
                                 },
                                  defaultDeptId:'${user.fdepid}',
                                 onAfterSure:function(){
                                   $('#impPersonName').val('');
                                   $('#impPerson').val('');
                                 }                                 
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="接收单位" maxlength="100"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>执行人</td>
    				<td class="editTd" colspan="3">
    					<s:buttonText2 id="impPersonName" hiddenId="impPerson" cssClass="noborder editElement required"
							name="impResultInfo.impPersonName" 
							hiddenName="impResultInfo.impPerson"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  title:'请选择接收人',
                                  type:'treeAndUser'
								})"  
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"	maxlength="500" title="执行人"/>
    				</td>
    			</tr>
 				<tr>
					<td class="EditHead">
						备注
					</td>
					<td class="editTd" colspan="3">
						<textarea type='text' id='impResultInfo_remark' name='impResultInfo.remark'
				 			class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${impResultInfo.remark}</textarea>
					</td>
				</tr>
    			
    			<tr>
    				<td class="EditHead">录入人</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.enterManName"></s:property>
    					<s:hidden name="impResultInfo.enterManName"></s:hidden>
    					<s:hidden name="impResultInfo.enterMan"></s:hidden>
    				</td>
    				<td class="EditHead">录入时间</td>
    				<td class="editTd">
    					<s:property value="impResultInfo.enterTime"></s:property>
    					<s:hidden name="impResultInfo.enterTime"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">录入部门</td>
    				<td class="editTd" colspan="3">
    					<s:property value="impResultInfo.enterDeptName"></s:property>
    					<s:hidden name="impResultInfo.enterDept"></s:hidden>
    					<s:hidden name="impResultInfo.enterDeptName"></s:hidden>
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
