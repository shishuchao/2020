<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>发起收集</title>
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
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript">
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
		if(frmCheck(myForm,myTable)) {
			$('#submitButton2Start').linkbutton('disable');
			myForm.action =  "<s:url action="start" includeParams="none"/>";
		}
		return true;
	}
	
	function saveForm() {
		 if(frmCheck(myForm,myTable)) {
			 myForm.action = '${contextPath}/riskManagement/management/riskCollect/saveRiskCollectTask.action';
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
       	<div region="center" border='0'>
    	<s:form id="myForm">
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
									onclick="this.style.disabled='disabled';window.location.href='${contextPath}/riskManagement/management/riskCollect/listRiskCollects.action'">返回</a>
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
    		<s:hidden name="crudObject.status"></s:hidden>
    		<s:hidden name="crudObject.serialNumber" id="serialNumber"></s:hidden>
    		<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
    		<table id='myTable' align="center" class="ListTable" style='margin-top: 40px; overflow: auto;'>
    			<tr>
    				<td class="EditHead">编号</td>
    				<td class="editTd">
    					<s:textfield id="sn" name="crudObject.sn" readonly="true" cssClass="noborder"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>年度</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="crudObject.year">
    						<s:iterator value="@ais.framework.util.DateUtil@getIncrementYearList(10,5)" id="entry">
    							<s:if test="${crudObject.year == entry}">
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
    				<td class="EditHead"><font color="red">*</font>风险信息收集任务</td>
    				<td class="editTd">
    					<s:textfield name="crudObject.taskName" maxlength="100" cssClass="noborder"></s:textfield>
    				</td>
    				<td class="EditHead"><font color="red">*</font>适用风险分类体系</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="crudObject.riskType">
    						<s:iterator value="riskTemplates">
    							<s:if test="${crudObject.riskType == templateId }">
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
    				<td class="EditHead"><font color="red">*</font>接收单位</td>
    				<td class="editTd">
    					<s:buttonText2 id="acceptingUnitName" hiddenId="acceptingUnit" cssClass="noborder"
							name="crudObject.acceptingUnitName" 
							hiddenName="crudObject.acceptingUnit"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								 title:'请选择接收单位',
                                 param:{
                                   'p_item':1,
                                   'orgtype':1
                                 },
                                  defaultDeptId:'${user.fdepid}',
                                 onAfterSure:function(data){
                                   $('#acceptingDepName').val('');
                                   $('#acceptingDep').val('');  
                                   }                                 
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="接收单位" maxlength="100"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>接收部门</td>
    				<td class="editTd">
    					<s:buttonText2 id="acceptingDepName" hiddenId="acceptingDep" cssClass="noborder"
							name="crudObject.acceptingDepName" 
							hiddenName="crudObject.acceptingDep"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								 title:'请选择接收部门',
                                 param:{
                                   'p_item':2,
                                   'orgtype':1,
                                   'defaultDeptId':$('#acceptingUnit').val()
                                 },
                                 onAfterSure:function(data){
                                   $('#acceptingPerson').val('');
                                   $('#acceptingPersonName').val('');
                                 },
                                 checkbox:true
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							title="接收部门" maxlength="100"/>
    				</td>
    			</tr>
    			
    			<%-- <tr>
    				<td class="EditHead"><font color="red">*</font>接收人</td>
    				<td class="editTd" colspan="3">
    					<s:buttonText2 id="acceptingPersonName" hiddenId="acceptingPerson" cssClass="noborder"
							name="crudObject.acceptingPersonName" 
							hiddenName="crudObject.acceptingPerson"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                     'p_item':1,
                                     'orgtype':1
                                  },
                                  title:'请选择接收人',
                                  type:'treeAndEmployee'
								})"  
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"	maxlength="500" title="接收人"/>
    				</td>
    			</tr> --%>
    			
    			<tr>
    				<td class="EditHead"><font color="red">*</font>收集开始时间</td>
    				<td class="editTd">
    					<input type="text" id="collectStartTime" name="crudObject.collectStartTime" value="${crudObject.collectStartTime}"
								class="easyui-datebox" editable="false"/>
    				</td>
    				<td class="EditHead"><font color="red">*</font>收集截至时间</td>
    				<td class="editTd">
    					<input type="text" id="collectEndTime" name="crudObject.collectEndTime" value="${crudObject.collectEndTime}"
								class="easyui-datebox" editable="false"/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">发起单位</td>
    				<td class="editTd">
    					<s:property value="crudObject.initiateUnitName"></s:property>
    					<s:hidden name="crudObject.initiateUnit"></s:hidden>
    					<s:hidden name="crudObject.initiateUnitName"></s:hidden>
    				</td>
    				<td class="EditHead">发起部门</td>
    				<td class="editTd">
    					<s:property value="crudObject.initiateDepName"></s:property>
    					<s:hidden name="crudObject.initiateDep"></s:hidden>
    					<s:hidden name="crudObject.initiateDepName"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">发起人</td>
    				<td class="editTd">
    					<s:property value="crudObject.initiatePersonName"></s:property>
    					<s:hidden name="crudObject.initiatePerson"></s:hidden>
    					<s:hidden name="crudObject.initiatePersonName"></s:hidden>
    				</td>
    				<td class="EditHead">发起时间</td>
    				<td class="editTd">
    					<s:property value="crudObject.initiateTime"></s:property>
    					<s:hidden name="crudObject.initiateTime"></s:hidden>
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
    	</s:form>
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
