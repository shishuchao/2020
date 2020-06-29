<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>错误</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>

	</head>
	<body>
		<center>

			<table width="100%">
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						填写反馈意见
					</td>
				</tr>
			</table>
			<br>
			<s:form action="saveIdea" namespace="/mng/project/report">
				<!-- 引入项目的信息 -->

				<FIELDSET style="width:400">
					<LEGEND>
						<font color="blue">系统提示：</font>
					</LEGEND>
					<br>
					<div align="center">
						<font color="red">&nbsp;对不起！您无权进行该操作。</font>
					</div>
					<br>
				</FIELDSET>
			</s:form>

		</center>
	</body>
</html>
