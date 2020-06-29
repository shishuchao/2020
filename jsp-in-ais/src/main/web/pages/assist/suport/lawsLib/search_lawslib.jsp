<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="ufaud" uri="http://www.ufaud.com/aistld"%>
<!DOCTYPE HTML> 
<html>
	<head>
		<title>查询</title><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>
	<body>
<script language="javascript" src="<%=request.getContextPath()%>/scripts/calendar.js">
</script>
		<center>
			<h3>
				查询参数
			</h3>
			<s:form action="toSearch" namespace="/pages/assist/suport/lawsLib"
				method="post" theme="simple">
				<ufaud:showQueryItem
					pojoClass="ais.assist.suport.lawsLib.model.AssistSuportLawslib"
					excludeItem="id,categoryFk,muuid,classification,remark,summary,keywords,upman,summan,sundept"
					applicationResources="ApplicationResources_zh_CN"></ufaud:showQueryItem>
				<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
				<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
				<s:hidden name="m_view" value="${m_view}"></s:hidden>

				<table style="width: 97%; border: 0">
					<tr>
						<td>
							<span style="float: right;"> <s:submit value="查询"></s:submit>&nbsp;<s:reset
									value="重置"></s:reset>&nbsp; <input type="button" value="返回"
									onClick="history.go(-1)" /> </span>
						</td>
					</tr>
				</table>
			</s:form>



		</center>
	</body>
</html>
