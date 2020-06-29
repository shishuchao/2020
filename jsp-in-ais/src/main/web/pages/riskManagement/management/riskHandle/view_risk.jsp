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
<script type="text/javascript">
     $(function(){
    	 $('#tt').tabs({
    			onSelect:function(title,id){
    				if(title == '应对方案') {
    					if($('#myFrame2').attr('src') == '') {
    						var url = '${contextPath}/riskManagement/management/riskHandle/editHandlePro.action?isView=Y&formId=${crudObject.formId}';
        					$('#myFrame2').attr('src',url);
    					}
    				}else if(title == '执行结果'){
    					if($('#myFrame3').attr('src') == '') {
    						var url = '${contextPath}/riskManagement/management/riskHandle/editImpResult.action?isView=Y&formId=${crudObject.formId}';
        					$('#myFrame3').attr('src',url);
    					}
    				}else if(title == '执行评价'){
    					if($('#myFrame4').attr('src') == '') {
    						var url = '${contextPath}/riskManagement/management/riskHandle/editEvaluateImp.action?isView=Y&formId=${crudObject.formId}';
        					$('#myFrame4').attr('src',url);
    					}
    				}else if(title == '风险评估'){
    					if($('#myFrame5').attr('src') == '') {
    						var url = '${contextPath}/riskManagement/management/riskEvaluate/listRiskWaitSureDetail.action?isView=Y&riskEvaluateWaitId=${crudObject.retId}';
        					$('#myFrame5').attr('src',url);
    					}
    				}
    			}
    		});
     });
	
</script>
</head>
<body>
    	<div id="tt" class="easyui-tabs" fit="true" border="0" style="overflow: hidden;" scrolling="no">
    		<div title="基本信息">
				<iframe id="myFrame1"
					src="${contextPath}/riskManagement/management/riskHandle/listBasicInfo.action?id=${id}"
					frameBorder="0" width="100%" height="100%" scrolling="no"></iframe>
			</div>
			<div title="风险评估">
    			<iframe id="myFrame5" src="" 
    			frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    		</div>
    		<div title="应对方案">
    			<iframe id="myFrame2" src="" 
    			frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    		</div>
    		<div title="执行结果">
    				<iframe id="myFrame3" src="" 
    					frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
    		</div>
    		<div title="执行评价">
    				<iframe id="myFrame4" src="" 
    					frameBorder="0" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe>
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
