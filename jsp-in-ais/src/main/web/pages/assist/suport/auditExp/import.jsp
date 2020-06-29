<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>导入审计经验库</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function _import(){
		document.getElementById("importButton").disabled = true;
		document.getElementById("layer").style.display = "";
	}
</script>
</head>

<body>
	<s:form action="assistSuportLawslibAction!importExp" namespace="/pages/assist/suport/lawsLib" method="post" enctype="multipart/form-data" onsubmit="_import()">
		<table>
			<tr>
				<td width="10%" style="text-align: center;">文件位置:</td>
				<td>
					<s:textfield name="tabDir" size="100"></s:textfield>&nbsp;&nbsp;<s:submit id="importButton" value="导入"></s:submit>
				</td>
			</tr>
			<tr>
				<td colspan="2"><font color="red" size="2">包括: EXP_SORT.xls, EXP_EXPERIENCE.xls, EXP_REFERENCE.xls, EXP_STEP.xls, EXP_STEPSQL.xls, EXP_LAW.xls, EXP_EXPLAW.xls, EXP_CASE.xls, EXP_EXPCASE.xls</font></td>
			</tr>
		</table>
	</s:form>
	<div id="layer" style="display: none;" align="center">
		<img src="${contextPath}/images/uploading.gif">
		<br>
		正在导入，请稍候......
	</div>
</body>
</html>