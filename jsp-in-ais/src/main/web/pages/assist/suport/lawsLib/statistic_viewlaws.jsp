<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" import="java.util.*" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title></title>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>    
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script language="javascript">
		
			function CheckSubmit(){
				document.forms[0].action = "${contextPath}/pages/assist/suport/lawsLib/statisticViewLawsInfo.action";
				document.forms[0].target = "showreport";
				document.forms[0].submit();
			}

		     $(document).ready(function(){
		    	 CheckSubmit();
		     });
		</script>
	</head>
	<body>
		<table id="tab1" >
			<s:form name="form">
			</s:form>
		</table>
		<div>
			<iframe allowtransparency="true" style="z-Index: 1" name="showreport" src="<%=request.getContextPath()%>/blank.jsp" frameborder="0" scrolling="yes" width="100%" height="400"></iframe>
		</div>
	</body>
</html>
