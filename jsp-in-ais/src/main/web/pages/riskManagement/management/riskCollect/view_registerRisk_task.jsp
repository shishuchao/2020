<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title></title>
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
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript">
 var parentTabId = '${parentTabId}';
 var curTabId = aud$getActiveTabId();

 $(function(){
	 $('#head'+"_${crudObject.file_id}").fileUpload({
			fileGuid:'${crudObject.file_id}' == ''?'1':'${crudObject.file_id}',
			echoType:2,
			isAdd:false,
            isEdit:false,
            isDel:false,
			uploadFace:1,
			triggerId:false
		});
	 
	 // 判断是否保存
	if ('${crudObject.illustration}' != null
				&& '${crudObject.illustration}' != '')
			$('#tt').show();

		$('#tt').tabs({
			onSelect : function(name, id) {
				if(name == '调整风险列表'){
					if($('#myFrame2').attr('src') == '') {
						$('#myFrame2').attr('src','${contextPath}/riskManagement/management/riskRegister/listRegisterAdjust.action?isView=Y&riskType=${riskCollectTask.riskType}&collectTaskName=${riskCollectTask.taskName}&collectTaskYear=${riskCollectTask.year}&collectTaskId=${crudObject.formId}');
					}
				}
			}
		}); 
	});
 
	
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
			 myForm.action="${contextPath}/riskManagement/management/riskRegister/saveRegisterRisk.action";
			 myForm.submit();
		 }
	}
	
	function backList() {
		var frameWin = aud$getTabIframByTabId(parentTabId);
		 frameWin.g1.refresh(); 
		 aud$closeTab(curTabId, parentTabId);
	}
	
	function doStart(){
		document.getElementById('myForm').action = "start.action";
		document.getElementById('myForm').submit();
	}
	
	function viewRisk() {
	    if("${riskCollectTask.riskType}"==""){
            var url = "${contextPath}/riskManagement/knowledgeBase/riskTemplate/main.action?isView=Y&templateId=${param.riskType}";
        }else{
            var url = "${contextPath}/riskManagement/knowledgeBase/riskTemplate/main.action?isView=Y&templateId=${riskCollectTask.riskType}";
        }
		aud$openNewTab('风险库',url,true);
		//showWinIf('auditPlanTree',url,'风险库',$(window).width()-200,$(window).height()-200);
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
							<a href="javascript:void(0);" id="root" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="viewRisk();">查看风险库</a>&nbsp;
							<%-- <s:if test="${ param.todoback ne '1' }">
							  <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
									onclick="this.style.disabled='disabled';window.location.href='${contextPath}/riskManagement/management/riskCollect/listRegisterRisks.action'">返回</a>
							</s:if>
		 					<s:else>
								<s:if test="${taskInstanceId!=null&&taskInstanceId>0} && ${todoback == '1' }">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
			 							onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'">返回</a>
								</s:if>
							</s:else>  --%>
						</span>
						</td>
					</tr>
			
				</table>
			</div>
    	
    		<div class="position:relative" id="div2">
    		<s:hidden name="crudObject.formId"></s:hidden>
    		<s:hidden name="crudObject.rctFormId"></s:hidden>
    		<s:hidden name="crudObject.acceptingDep"></s:hidden>
    		<s:hidden name="crudObject.file_id"></s:hidden>
    		<s:hidden name="crudObject.status"></s:hidden>
    		<s:hidden name="crudObject.acceptingDepName"></s:hidden>
    		<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
    		<table id='myTable' align="center" class="ListTable" style='margin-top: 40px; overflow: auto;'>
    			<tr>
	   				<td class="EditHead"><font color="red">*</font>是否存在新风险</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="crudObject.existedNR" disabled="disabled">
    						<s:iterator value='#@java.util.LinkedHashMap@{"0":"是","1":"否"}' id="entry">
    							<s:if test="${crudObject.existedNR == key}">
    								<option selected="selected" value="<s:property value='key'/>"><s:property value='value'/></option>
    							</s:if>
    							<s:else>
    								<option value="<s:property value='key'/>"><s:property value='value'/></option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    				
    				<td class="EditHead"><font color="red">*</font>是否调整风险库现有风险</td>
    				<td class="editTd">
    					<select class="easyui-combobox" name="crudObject.adjustedOR" disabled="disabled">
    						<s:iterator value='#@java.util.LinkedHashMap@{"0":"是","1":"否"}' id="entry">
    							<s:if test="${crudObject.adjustedOR == key}">
    								<option selected="selected" value="<s:property value='key'/>"><s:property value='value'/></option>
    							</s:if>
    							<s:else>
    								<option value="<s:property value='key'/>"><s:property value='value'/></option>
    							</s:else>
    						</s:iterator>
    					</select>
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="EditHead">
    					附件
					</td>
    				<td class="editTd">
    					<div id="head_${crudObject.file_id}" style="float: left"></div>
    					<div id="content_${crudObject.file_id}" style="float: right"></div>
    				</td>
    				
    				<td class="EditHead"><font color="red">*</font>说明</td>
    				<td class="editTd">
    					<s:property value="crudObject.illustration" />
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
    	
    	<div id="tt" class="easyui-tabs" fit="true" border="0" style="overflow: hidden;display: none">
    	<s:if test="${crudObject.existedNR == '0'}">
    		<div title="新增风险列表">
				<iframe id="myFrame1"
					src="${contextPath}/riskManagement/management/riskRegister/listRegisterNew.action?isView=Y&riskType=${riskCollectTask.riskType}&collectTaskName=${riskCollectTask.taskName}&collectTaskYear=${riskCollectTask.year}&collectTaskId=${crudObject.formId}"
					frameBorder="0" width="100%" height="82%" scrolling="no"></iframe>
			</div>
		</s:if>
		<s:if test="${crudObject.adjustedOR == '0'}">
    		<div title="调整风险列表">
    			<iframe id="myFrame2" src=""
    			frameBorder="0" width="100%" height="82%" style="overflow: hidden;" scrolling="no"></iframe>
    		</div>
    	</s:if>
    	</div>
    </div>
    </div>
    
    <div id="auditPlanTree">
    	<iframe width="100%" height="100%" scrolling="no"></iframe>
    </div>
    
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
