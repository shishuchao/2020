<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>问题类别1</title>
		<style type="text/css">
.borderTd1 {
	border-right-width: 0 !important;
	border-bottom-width: 0 !important;
}

.borderTd2 {
	border-bottom-width: 0 !important;
}
</style>
	   	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
   			<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
			<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
	</head>
	<body>
		<div class="easyui-panel" title="问题点" fit=true
			style="overflow: visibility; padding: 3px 3px 3px 3px;"
			align="center" width="100%">
			<s:form id="ledgerForm" name="form2" action="save_problempoint.action"
				namespace="/ledger/problemledger">
			<table cellpadding=1 cellspacing=1 border=0 
				class="ListTable" id="tab1" name="tab1" width="100%">
				<tr>
					<td class="EditHead" style="width: 15%">
						问题点编号
					</td>
					<td class="editTd" style="text-align: left;">
						${ledgerTemplateNew.code}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						问题点
					</td>
					<td class="editTd" style="text-align: left;">
						${ledgerTemplateNew.name}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						问题类别
					</td>
					<td class="editTd" style="text-align: left;">
						${ledgerTemplateNew.fname }
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						所属项目类别
					</td>
					<td class="editTd" style="text-align: left;">
						${ledgerTemplateNew.belong_pro_type_name }
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="border-right-width:0;">
						政策法规依据
					</td>
					<td class="editTd" style="text-align: left;">
					    <s:textarea name="ledgerTemplateNew.bewrite" cssClass="noborder" value="${ledgerTemplateNew.bewrite}"
								cssStyle="width:100%;" rows="5"></s:textarea>
					</td>
				</tr>
			</table>
			</s:form>
		</div>
	<script type="text/javascript">
	 $(document).ready(function(){	
	$("#ledgerForm").find("textarea").each(function(){
		autoTextarea(this);
	});
		});
	</script>
	</body>
</html>