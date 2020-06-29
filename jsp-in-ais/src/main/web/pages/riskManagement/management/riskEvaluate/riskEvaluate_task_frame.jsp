<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>风险评估任务下发-选择风险事项-frame页面</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	
	<script type="text/javascript">
		$(function(){
			$('#tt').tabs({
				onSelect:function(title,index){
					if(title == '新增风险') {
						if($('#iframe02').attr('src') == ''){
							$('#iframe02').attr('src','${contextPath}/riskManagement/management/riskEvaluate/listRegisterNew.action?riskevaluate_id=${riskevaluate_id}&parentTabId=${parentTabId}');
						}
					}
					/* else if(title == '评估结果') {
						if($('#iframe03').attr('src') == ''){
							$('#iframe03').attr('src','${contextPath}/riskManagement/management/riskEvaluate/listRiskGrades.action?rrs_id=${rrs_id}&riskWaitId=${riskWaitId}');
						}
					} */
				} 
			});
		});
	</script>

</head>
<body>
    <div id="tt" class="easyui-tabs" fit="true" border="0" style="overflow: hidden">
    	<div title="风险库" style="overflow:hidden;padding:10px;">
    		<iframe id="iframe01" src="${contextPath}/riskManagement/management/riskEvaluate/main.action?templateId=${templateId}&riskevaluate_id=${riskevaluate_id}&activeTabId=${parentTabId}" 
    		width="100%" height="100%" frameBorder="0"></iframe>
    	</div>
    	<div title="新增风险" style="overflow:hidden;padding:10px;">
    		<iframe id="iframe02" width="100%" height="100%" frameBorder="0" src=""></iframe>
    	</div>
    	<!-- <div title="评估结果" style="overflow:hidden;padding:10px;">
    		<iframe id="iframe03" width="100%" height="100%" frameBorder="0" src=""></iframe>
    	</div> -->
    </div>
</body>
</html>
