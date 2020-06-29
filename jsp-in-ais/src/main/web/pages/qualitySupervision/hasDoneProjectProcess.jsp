<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>指定项目中所有的审批流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>

</head>
<div align="center">
	<display:table id="row" name="hasDoneProcesstList" class="its" cellpadding="1" pagesize="15" requestURI="${contextPath}/ais/qualitySupervision/AuditQualitySupervisionAction!projectProcesstList.action">
		<display:column property="taskName" title="环节名称" style="WHITE-SPACE: nowrap" sortable="true" />
		<display:column property="userName" title="处理人" style="WHITE-SPACE: nowrap" sortable="true" />
		<display:column property="deptName" title="处理人所在部门" style="WHITE-SPACE: nowrap" sortable="true" />
		<display:column property="comments" title="处理意见" style="WHITE-SPACE: nowrap" sortable="true" />
		<display:column property="createDate" title="处理时间" format="{0,date,yyyy-MM-dd hh:mm:ss}"  style="WHITE-SPACE: nowrap" sortable="true" />
	</display:table>
</div>
</body>
</html>