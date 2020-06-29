<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title></title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
<s:head theme="ajax"/>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
</head>
<body>
<script>
<s:if test="refresh==1">
 	window.parent.frames[0].location.reload();
</s:if>
</script>
<center>
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
			<tr>
				<td class="ListTableTr11">
					账户状态
				</td>
				<td class="ListTableTr22">
					<s:property value="bankAccount.accoState"/>
				</td>
				<td class="ListTableTr11">
					开户银行
				</td>
				<td class="ListTableTr22">
					<s:property value="bankAccount.openBank"/>
				</td>						
			</tr>
			<tr>
				<td class="ListTableTr11">
					账号
				</td>
				<td class="ListTableTr22">
					<s:property value="bankAccount.account"/>
				</td>
				<td class="ListTableTr11">
					开户名称
				</td>
				<td class="ListTableTr22">
					<s:property value="bankAccount.openName"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					账户性质
				</td>
				<td class="ListTableTr22">
					<s:property value="bankAccount.accoType"/>
				</td>						
				<td class="ListTableTr11">
					开户日期
				</td>
				<td class="ListTableTr22">
					<s:property value="bankAccount.openDate"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					销户日期
				</td>
				<td class="ListTableTr22">
					<s:property value="bankAccount.outDate"/>
				</td>						
				<td class="ListTableTr11">
					是否审批
				</td>
				<td class="ListTableTr22">
					<s:property value="bankAccount.isExamine"/>
				</td>
			</tr>
	</table>
		<input type="button" name="back" value="返回" onclick="javascript:window.location='${contextPath}/mng/audobj/object/searchBankAccount.action?pid=${pid}&status=${status}'">
		<br>
</center>
</body>
</html>
