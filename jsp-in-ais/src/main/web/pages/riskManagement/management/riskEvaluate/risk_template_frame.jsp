<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>选择风险事项主页</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript">
	    
	    //重新加载子页面树方法，必须有选中节点
	    function reloadChildTreeNode(editType,node){
	    	treeIframe.window.reloadSelectedNode(editType,node);
	    }
		
	</script>
</head>
<body class="easyui-layout" fit="true" style="overflow:hidden;" border='0'>
	<div region="west" border="0" split="true" title="" style="overflow:hidden;width:30%;">
		<iframe name="treeIframe" src="${contextPath}/riskManagement/management/riskEvaluate/showTreeList.action?templateId=<%=request.getParameter("templateId")%>&riskevaluate_id=${riskevaluate_id}&parentTabId=${parentTabId}" frameborder="0"
		        style="height:100%;width:100%;overflow:hidden;"></iframe>
	</div>
	<div region="center" border="0"  style="overflow:hidden;">
		<iframe name="childBasefrm" src="${contextPath}/riskManagement/management/riskEvaluate/showContent.action?selectedTab=main&taskPid=<%=request.getParameter("taskPid")%>&templateId=<%=request.getParameter("templateId")%>&riskevaluate_id=${riskevaluate_id}&parentTabId=${parentTabId}" 
		        frameborder="0" style="height:100%;width:100%;overflow:hidden;"></iframe>
	</div>
</body>
</html>