<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>导入作业系统的文档</title>
		<s:head />
		<link href="${pageContext.request.contextPath}/styles/main/ais.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/check.js"></script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/calendar.js"></SCRIPT>
	<body>
		<center>
			<s:form action="importFile" namespace="/mng/opr" method="post"
				enctype="multipart/form-data">>
				<jsp:include page="/pages/mng/opr/select_project_include.jsp" />
				<table cellpadding=0 cellspacing=1 border=0 " bgcolor="#409cce"
					class="ListTableFile1">
					<tr>
						<td class="ListTableTr11">
							导入文档
						</td>
						<td class="ListTableTr22">
							<s:file name="zip" cssStyle="width:100%"></s:file>
						</td>
						<td class="ListTableTr22">
							<s:submit value="导入"></s:submit>
						</td>
					</tr>
				</table>
			</s:form>
		</center>
	</body>
</html>
