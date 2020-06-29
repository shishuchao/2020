<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
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
					检查单位
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="adminDept.checkDept"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					检查开始日期
				</td>
				<td class="ListTableTr22">
					<s:property value="adminDept.beginDate"/>
				</td>
				<td class="ListTableTr11">
					检查结束日期
				</td>
				<td class="ListTableTr22">
					<s:property value="adminDept.endDate"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					是否被处罚
				</td>
				<td class="ListTableTr22">
					<s:property value="adminDept.isPenalize"/>
				</td>						
				<td class="ListTableTr11" nowrap="nowrap">
					处罚金额
				</td>
				<td class="ListTableTr22">
					<fmt:formatNumber value="${adminDept.penalizeMoney}" pattern="###,###.##" type="currency" minFractionDigits="2"/>万元
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					检查内容
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="adminDept.checkContent"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					附件
				</td>
				<td class="ListTableTr22" colspan="3">
					<div id="accessoriesList" align="center">
						<s:property escape="false" value="adminDeptAccessoriesByDelete" />	
					</div>
				</td>						
			</tr>
	</table>
		<input type="button" name="back" value="返回" onclick="javascript:window.location='${contextPath}/mng/audobj/object/searchAdminDept.action?pid=${pid}&status=${status}'">
		<br>
</center>
</body>
</html>
