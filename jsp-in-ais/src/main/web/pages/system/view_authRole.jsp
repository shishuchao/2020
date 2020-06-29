<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<!-- edit_authRole.jsp -->
		<title>角色</title>
		<link href="<%=request.getContextPath()%>/styles/main/main.css" rel="stylesheet"
			type="text/css">
	</head>
	<body>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		<s:form action="saveAuthRole" namespace="/system" method="post"
			theme="simple">
			<s:hidden name="authRole.froleid" value="${authRole.froleid}" ></s:hidden>
			<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
				<tr>
					<td class="listtabletr1">角色名称：
					</td>
					<td class="listtabletr2">
						<s:text  name="${authRole.fname}"></s:text>
					</td>
					</tr>
					<tr>
					<td class="listtabletr1">备注：</td>
					<td class="listtabletr2">
						<s:text name="${authRole.fnote}"></s:text>
					</td>
				</tr>
			</table>
			</center>
			<a href="javascript:history.go(-1)">返回</a>
		</s:form>
	</body>
</html>