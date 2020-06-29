<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>编辑内控调查</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<s:form id="diaoChaForm" action="saveDiaoCha" namespace="/nkcp" >
			<s:hidden name="diaoCha.categoryId" />
			<s:hidden name="diaoCha.id" />
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
						<s:select name="diaoCha.isSuit" list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" emptyOption="true"></s:select>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						调查结果：
					</td>
					<td class="ListTableTr22">
						<s:select name="diaoCha.result" list="#@java.util.LinkedHashMap@{'是':'是','弱':'弱','否':'否'}" emptyOption="true"></s:select>
					</td>
				</tr>
			</table>
			<div align="right" style="width: 97%">
				<s:submit value="保存" onclick="this.style.disabled='disabled';" />
				<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/nkcp/listDiaoCha.action?categoryId=${diaoCha.categoryId}'" />
			</div>
		</s:form>
	</body>
</html>
