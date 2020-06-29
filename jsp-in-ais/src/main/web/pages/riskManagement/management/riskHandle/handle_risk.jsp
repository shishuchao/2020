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

     $(function(){
    	 $('#tt').tabs({
    			onSelect:function(title,id){
    				if(title == '应对方案') {
    					if($('#myFrame1').attr('src') == '') {
    						var url = '${contextPath}/riskManagement/management/riskHandle/editHandlePro.action?formId=${crudObject.formId}';
    						<s:if test="varMap['handleProjectWrite']==null and varMap['impResultWrite']==null or varMap['handleProjectWrite']==null?true:varMap['handleProjectWrite']">
    						</s:if>
    						<s:else>
    							url += '&isView=y';
    						</s:else>
        					$('#myFrame1').attr('src',url);
        					$('#iframeId').val('应对方案');
    					}
    				}else if(title == '执行结果'){
    					if($('#myFrame2').attr('src') == '') {
    						var url = '${contextPath}/riskManagement/management/riskHandle/editImpResult.action?formId=${crudObject.formId}';
    						<s:if test="varMap['impResultWrite']==null?true:varMap['impResultWrite']">
    						</s:if>
    						<s:else>
    							url += '&isView=y';
    						</s:else>
    						$('#myFrame2').attr('src',url);
        					$('#iframeId').val('执行结果');
    					}
    				}else if(title == '执行评价'){
    					if($('#myFrame3').attr('src') == '') {
    						var url = '${contextPath}/riskManagement/management/riskHandle/editEvaluateImp.action?formId=${crudObject.formId}';
    						<s:if test="varMap['impEvaluateWrite']==null?true:varMap['impEvaluateWrite']">
    						</s:if>
    						<s:else>
    							url += '&isView=y';
    						</s:else>
    						$('#myFrame3').attr('src',url);
        					$('#iframeId').val('执行评价');
    					}
    				}
    			}
    		});
     });
	
 	function sucFun(){
 		<s:if test="varMap['impEvaluateWrite']==null?true:varMap['impEvaluateWrite']">
 			$("#tt").tabs({
 				selected:3
 			});
 		</s:if>
 		<s:if test="varMap['impResultWrite']==null?true:varMap['impResultWrite']">
 			$("#tt").tabs({
				selected:2
			});
 		</s:if>
 		<s:if test="varMap['handleProjectWrite']==null and varMap['impResultWrite']==null or varMap['handleProjectWrite']==null?true:varMap['handleProjectWrite']">
 			$("#tt").tabs({
				selected:1
			});
 		</s:if> 
		if($("#sucFlag").val()=='1'){
			$("#sucFlag").val('');
			$.messager.show({title:'提示信息',msg:'保存成功!'});
		}        		
	}
	
	function toSubmit(act){
		var res;
	  	<s:if test="varMap['handleProjectWrite']==null and varMap['impResultWrite']==null or varMap['handleProjectWrite']==null?true:varMap['handleProjectWrite']">
	  		res = $("#myFrame1")[0].contentWindow.check();
	  		if(!res)
	  			return false;
	 	</s:if>
	  	
	  	<s:if test="varMap['impResultWrite']==null?true:varMap['impResultWrite']">
	 		res = $("#myFrame2")[0].contentWindow.check();
	 		if(!res)
	  			return false;
	 	</s:if>
	  	
	 	<s:if test="varMap['impEvaluateWrite']==null?true:varMap['impEvaluateWrite']">
	 		res = $("#myFrame3")[0].contentWindow.check();
	 		if(!res)
	  			return false;
	 	</s:if>
		
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
		var res = $("#myFrame1")[0].contentWindow.check();
		if(res) {
			$('#submitButton2Start').linkbutton('disable');
			myForm.action =  "<s:url action="start" includeParams="none"/>";
		}
		return res;
	}
	
	function saveForm() {
		 var iframeId = $('#iframeId').val();
		 if(iframeId == '执行结果') {
			 <s:if test="varMap['impResultWrite']==null?true:varMap['impResultWrite']">
			 	$("#myFrame2")[0].contentWindow.saveForm();
			 </s:if>
		 }else if(iframeId == '执行评价'){
			 <s:if test="varMap['impEvaluateWrite']==null?true:varMap['impEvaluateWrite']">
			 	$("#myFrame3")[0].contentWindow.saveForm();
			 </s:if>
		 }else {
			 <s:if test="varMap['handleProjectWrite']==null and varMap['impResultWrite']==null or varMap['handleProjectWrite']==null?true:varMap['handleProjectWrite']">
			 	$("#myFrame1")[0].contentWindow.saveForm();
			 </s:if>
		 }
	}
	
	function saveBaseForm() {
		myForm.action="${contextPath}/riskManagement/management/riskHandle/saveRisk.action";
		myForm.submit();
	}
	
	function doStart(){
		document.getElementById('myForm').action = "start.action";
		document.getElementById('myForm').submit();
	}
    
	function asignByiframe1(proName,
			proTarget,
			proDescribe,
			orgLeader,
			flow,
			source,
			tool,
			planStartTime,
			planEndTime,
			creater,
			createrName,
			createTime,
			remark1) {
		$('#proName').val(proName);
		$('#proTarget').val(proTarget);
		$('#proDescribe').val(proDescribe);
		$('#orgLeader').val(orgLeader);
		$('#flow').val(flow);
		$('#source').val(source);
		$('#tool').val(tool);
		$('#planStartTime').val(planStartTime);
		$('#planEndTime').val(planEndTime);
		$('#creater').val(creater);
		$('#createrName').val(createrName);
		$('#createTime').val(createTime);
		$('#remark1').val(remark1);
	}
	
	function asignByiframe2(riskConStatus,
			actualStartTime,
			actualEndTime,
			implementation,
			remark2) {
		$('#riskConStatus').val(riskConStatus);
		$('#actualStartTime').val(actualStartTime);
		$('#actualEndTime').val(actualEndTime);
		$('#implementation').val(implementation);
		$('#remark2').val(remark2);
	}
	
	function asignByiframe3(rcsEvaluate,
			impEvaluate,
			remark3,
			impEvaluater,
			impEvaluaterName,
			impEvaluateTime,
			file_id) {
		$('#rcsEvaluate').val(rcsEvaluate);
		$('#impEvaluate').val(impEvaluate);
		$('#remark3').val(remark3);
		$('#impEvaluater').val(impEvaluater);
		$('#impEvaluaterName').val(impEvaluaterName);
		$('#impEvaluateTime').val(impEvaluateTime);
		$('#file_id').val(file_id);
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
			 	<s:hidden name="crudObject.formId"/>
			 	<s:hidden name="crudObject.status"/>
    			<s:hidden name="crudObject.retId"></s:hidden>
    			<s:hidden name="selectedIframe" id="iframeId"/>
    			<s:hidden name="crudObject.proName" id="proName"></s:hidden>
    			<s:hidden name="crudObject.proTarget" id="proTarget"></s:hidden>
    			<s:hidden name="crudObject.proDescribe" id="proDescribe"></s:hidden>
    			<s:hidden name="crudObject.orgLeader" id="orgLeader"></s:hidden>
    			<s:hidden name="crudObject.flow" id="flow"></s:hidden>
    			<s:hidden name="crudObject.source" id="source"></s:hidden>
    			<s:hidden name="crudObject.tool" id="tool"></s:hidden>
    			<s:hidden name="crudObject.planStartTime" id="planStartTime"></s:hidden>
    			<s:hidden name="crudObject.planEndTime" id="planEndTime"></s:hidden>
    			<s:hidden name="crudObject.creater" id="creater"></s:hidden>
    			<s:hidden name="crudObject.createrName" id="createrName"></s:hidden>
    			<s:hidden name="crudObject.createTime" id="createTime"></s:hidden>
    			<s:hidden name="crudObject.remark1" id="remark1"></s:hidden>
    			<s:hidden name="crudObject.riskConStatus" id="riskConStatus"></s:hidden>
    			<s:hidden name="crudObject.actualStartTime" id="actualStartTime"></s:hidden>
    			<s:hidden name="crudObject.actualEndTime" id="actualEndTime"></s:hidden>
    			<s:hidden name="crudObject.implementation" id="implementation"></s:hidden>
    			<s:hidden name="crudObject.remark2" id="remark2"></s:hidden>
    			<s:hidden name="crudObject.rcsEvaluate" id="rcsEvaluate"></s:hidden>
    			<s:hidden name="crudObject.impEvaluate" id="impEvaluate"></s:hidden>
    			<s:hidden name="crudObject.remark3" id="remark3"></s:hidden>
    			<s:hidden name="crudObject.impEvaluater" id="impEvaluater"></s:hidden>
    			<s:hidden name="crudObject.impEvaluaterName" id="impEvaluaterName"></s:hidden>
    			<s:hidden name="crudObject.impEvaluateTime" id="impEvaluateTime"></s:hidden>
    			<s:hidden name="crudObject.file_id" id="file_id"></s:hidden> 
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
								<a href="javascript:void(0);" id="root" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm();">保存</a>&nbsp; 	
							</s:if>
							<s:else>
								<a href="javascript:void(0);" id="root" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="saveBaseForm();">应对</a>&nbsp; 
							</s:else>
							<s:if test="${ param.todoback ne '1' }">
							  <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" 
									onclick="this.style.disabled='disabled';window.location.href='${contextPath}/riskManagement/management/riskHandle/listHandleProjects.action'">返回</a>
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
			<div class="position:relative" id="div2" >
			<div id="tt" class="easyui-tabs" fit="true" border="0" style='margin-top: 40px; overflow: auto;height: 420px' scrolling="no">
    			<div title="基本信息">
					<iframe id="myFrame0"
						src="${contextPath}/riskManagement/management/riskHandle/listBasicInfo.action?id=${id}"
						frameBorder="0" width="100%" height="100%" scrolling="no"></iframe>
				</div>
				<s:if test="crudObject.formId!=null">
					<s:if test="varMap['handleProjectWrite']==null and varMap['impResultWrite']==null and varMap['leaderApproveWrite']==null">
    					<div title="应对方案">
    						<iframe id="myFrame1" src="" 
    							frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    					</div>
    				</s:if>
    				<s:else>
    					<s:if test="varMap['handleProjectWrite']==null?true:varMap['handleProjectWrite']">
    						<div title="应对方案">
    							<iframe id="myFrame1" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    					</s:if>
    					<s:if test="varMap['impResultWrite']==null?true:varMap['impResultWrite']">
    						<div title="应对方案">
    							<iframe id="myFrame1" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    						<div title="执行结果">
    							<iframe id="myFrame2" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    					</s:if>
    					<s:if test="varMap['impEvaluateWrite']==null?true:varMap['impEvaluateWrite']">
    						<div title="应对方案">
    							<iframe id="myFrame1" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    						<div title="执行结果">
    							<iframe id="myFrame2" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    						<div title="执行评价">
    							<iframe id="myFrame3" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    					</s:if>
    					<s:if test="varMap['leaderApproveWrite']==null?true:varMap['leaderApproveWrite']">
    						<div title="应对方案">
    							<iframe id="myFrame1" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    						<div title="执行结果">
    							<iframe id="myFrame2" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    						<div title="执行评价">
    							<iframe id="myFrame3" src="" 
    								frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    						</div>
    					</s:if>
    				</s:else>
    			</s:if>
    		</div>
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
