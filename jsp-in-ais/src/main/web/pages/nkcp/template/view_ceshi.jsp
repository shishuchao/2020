<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>内控测试</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<s:form id="ceShiForm" action="saveCeShi" namespace="/nkcp/template" >
			<s:hidden name="ceShi.categoryId" />
			<s:hidden name="ceShi.id" />
			<table id="ceShiTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
				<tr>
					<td class="ListTableTr11">
						测试目标：
					</td>
					<td class="ListTableTr22">
						<s:textarea name="ceShi.muBiao" rows="50"
							cssStyle="width:100%;overflow-y:visible;" title="测试目标"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						弱点分析：
					</td>
					<td class="ListTableTr22">
						<s:textarea name="ceShi.ruoDian" rows="50"
							cssStyle="width:100%;overflow-y:visible;" title="弱点分析"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						测试方法：
					</td>
					<td class="ListTableTr22">
						<s:textarea name="ceShi.fangFa" rows="50"
							cssStyle="width:100%;overflow-y:visible;" title="测试方法"/>
					</td>
				</tr>
			</table>
			<div align="right" style="width: 97%">
				<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/nkcp/template/listCeShi.action?categoryId=${ceShi.categoryId}'" />
			</div>
		</s:form>
	</body>
</html>
