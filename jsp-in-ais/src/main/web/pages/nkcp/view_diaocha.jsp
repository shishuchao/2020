<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>内控调查</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<table id="diaoChaTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
			<tr>
				<td class="ListTableTr11">
					调查内容：
				</td>
				<td class="ListTableTr22">
					<s:textarea name="diaoCha.content" rows="50"
						cssStyle="width:100%;overflow-y:visible;" title="调查内容"/>
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					是否适用：
				</td>
				<td class="ListTableTr22">
					<s:property value="diaoCha.isSuit" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					调查结果：
				</td>
				<td class="ListTableTr22">
					<s:textarea name="diaoCha.result" rows="50"
						cssStyle="width:100%;overflow-y:visible;" title="调查结果"/>
				</td>
			</tr>
		</table>
		<div align="right" style="width: 97%">
			<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/nkcp/listDiaoCha.action?categoryId=${diaoCha.categoryId}'" />
		</div>
	</body>
</html>
