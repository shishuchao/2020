<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>

		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>

		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/pages/pe/validate/checkboxSelected.js"></script>	
		
		<title>考核表单预览</title>

	</head>
	<body>			
		<table id="tableTitle" cellpadding=0 cellspacing=1 border=0	bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;考核表单预览
					</td>
				</tr>
	    </table>			 
		${status}
	</body>
</html>
