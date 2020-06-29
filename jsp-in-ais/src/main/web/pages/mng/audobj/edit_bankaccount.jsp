<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<html>
<head><title></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>					
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
</head>
<body>
<script>
	function saveObj(){
		if(frmCheck(document.forms[0],'tab1')){
			var openDate = document.getElementsByName("bankAccount.openDate")[0].value;
			var outDate = document.getElementsByName("bankAccount.outDate")[0].value;
			if(openDate!=null && openDate!='' && outDate!=null && outDate!='' && !compareDate(openDate,outDate)){
				alert("销户日期 要大于 开户日期！");
				return false;
			}
			document.forms[0].submit();	
		}
	}
</script>
<center>
	<s:form action="saveBankAccount" namespace="/mng/audobj/object">
		<table id='tab1' cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					账户状态
				</td>
				<td class="ListTableTr22">
					<s:select name="bankAccount.accoStateCode" list="basicUtil.accoStateList" emptyOption="true" listKey="code" listValue="name"></s:select>
				</td>
				<td class="ListTableTr11" nowrap="nowrap">
					开户银行
				</td>
				<td class="ListTableTr22">
					<s:textfield cssStyle="width:100%" name="bankAccount.openBank" maxlength="50"></s:textfield>
				</td>						
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					账号
				</td>
				<td class="ListTableTr22">
					<s:textfield name="bankAccount.account"	cssStyle="width:100%" maxlength="32"></s:textfield>
				</td>
				<td class="ListTableTr11" nowrap="nowrap">
					开户姓名
				</td>
				<td class="ListTableTr22">
					<s:textfield name="bankAccount.openName" cssStyle="width:100%" maxlength="8"></s:textfield>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					账户性质
				</td>
				<td class="ListTableTr22">
					<s:select name="bankAccount.accoTypeCode" list="basicUtil.accoTypeList" emptyOption="true" listKey="code" listValue="name" />
				</td>						
				<td class="ListTableTr11" nowrap="nowrap">
					开户日期
				</td>
				<td class="ListTableTr22">
					<s:textfield  readonly="true"
						cssStyle="width:100%" maxlength="10" title="单击选择日期"
					onclick="calendar()" name="bankAccount.openDate"></s:textfield>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11" nowrap="nowrap">
					销户日期
				</td>
				<td class="ListTableTr22">
					<s:textfield name="bankAccount.outDate" readonly="true"
						cssStyle="width:100%" maxlength="10" title="单击选择日期"
					onclick="calendar()"></s:textfield>
				</td>						
				<td class="ListTableTr11">
					是否审批
				</td>
				<td class="ListTableTr22">
					<s:select name="bankAccount.isExamine" list="#@java.util.LinkedHashMap@{'':'','是':'是','否':'否'}"></s:select>
				</td>
			</tr>
		</table>
		<s:button value="保存" onclick="saveObj()"></s:button>
		<input type="button" name="back" value="返回" onclick="javascript:window.location='${contextPath}/mng/audobj/object/searchBankAccount.action?pid=${pid}&status=${status}'">
		<br>
		<s:hidden name="pid"></s:hidden>
		<s:hidden name="status"></s:hidden>
		<s:hidden name="bankAccount.id"></s:hidden>
		<s:hidden name="bankAccount.pid"></s:hidden>
	</s:form>
</center>
</body>
</html>