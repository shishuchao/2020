<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>    
<html>
<head>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
<script type="text/javascript" src="${contextPath}/pages/assist/baseInfo/dept.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
	var ADDEDYEARS="${addedYears}";
</script>
<title></title>
</head>
<body >
<s:form action="baseInfoAction!saveFunds" namespace="/assist/baseInfo" onsubmit="return chkFunds()">
	<s:hidden name="funds.fk"/>
	<s:hidden name="funds.id"/>
	<s:hidden name="deptInfo.orgId"/>
	<table id='tab1' cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
		<tr>
			<td class="ListTableTr11" style="text-align: center;" colspan="4">资产规模</td>
		</tr>
		<tr>
			<td class="ListTableTr11" style="width: 20%;">资产（上年末数）</td>
			<td class="ListTableTr22" style="width: 30%;"><s:textfield name="funds.assets" value="${funds.assets}"/></td>
			<td class="ListTableTr11" style="width: 20%;">负债（上年末数）</td>
			<td class="ListTableTr22" style="width: 30%;"><s:textfield name="funds.indebted" value="${funds.indebted}"/></td>
		</tr>
		<tr>
			<td class="ListTableTr11" >权益（上年末数）</td>
			<td class="ListTableTr22"><s:textfield name="funds.equities" value="${funds.equities}"/></td>
			<td class="ListTableTr11" >损益（上年数）</td>
			<td class="ListTableTr22"><s:textfield name="funds.pl" value="${funds.pl}"/></td>
		</tr>
		<tr>
			<td class="ListTableTr11" >分公司数量</td>
			<td class="ListTableTr22"><s:textfield name="funds.comNo" value="${funds.comNo}"/></td>
			<td class="ListTableTr11" >子公司数量</td>
			<td class="ListTableTr22"><s:textfield name="funds.subNo" value="${funds.subNo}"/></td>
		</tr>
		<tr>
			<td class="ListTableTr11" style="text-align: center;" colspan="4">审计部门经费</td>
		</tr>
		<tr>
			<td class="ListTableTr11" >计划</td>
			<td class="ListTableTr22"><s:textfield name="funds.planFund" value="${funds.planFund}"/></td>
			<td class="ListTableTr11" >实际</td>
			<td class="ListTableTr22"><s:textfield name="funds.pracFund" value="${funds.pracFund}"/></td>
		</tr>
		<tr>
			<td class="ListTableTr11" >年度<font color="red">*</font></td>
			<td class="ListTableTr22"><s:select name="funds.year" list="{'2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020'}" emptyOption="true"/></td>
			<td class="ListTableTr11"></td>
			<td class="ListTableTr22"></td>
		</tr>
	</table>
	<s:submit value="保存"/><s:button value="返回" onclick="history.back(-1);"/>
</s:form>
</body>
</html>