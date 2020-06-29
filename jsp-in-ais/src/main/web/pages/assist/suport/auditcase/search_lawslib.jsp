<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <%@taglib prefix="ufaud" uri="http://www.ufaud.com/aistld"%>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>查询审计案例</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>
<body>
<script language="javascript" src="<%=request.getContextPath()%>/scripts/calendar.js">
</script>
<center>
<h3>查询参数</h3>
<s:form action="toSearch" namespace="/pages/assist/suport/lawsLib" method="post" theme="simple">
<ufaud:showQueryItem pojoClass="ais.assist.suport.lawsLib.model.AssistSuportLawslib" excludeItem="id,categoryFk,muuid,classification,remark,summary,keywords,upman,summan,sundept" applicationResources="ApplicationResources_zh_CN"></ufaud:showQueryItem>
<!--  下面输得3句是用来从其它页面传来数据需要的东东
<s:hidden name="industryName_compareKey" value="like"></s:hidden>
<s:hidden name="industryName_value" value="%中文%"></s:hidden>
<input type="radio" style="display:none"　name="industryName_logicKey" value="and" checked="checked" />
 -->
 <s:hidden name="nodeid" value="${nodeid}"></s:hidden>
 <s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
  <s:hidden name="m_view" value="${m_view}"></s:hidden>

<table style="width:97%;border:0" >
	<tr>
		<td>
			<span style="float:right;">
				<s:submit value="查询"></s:submit>&nbsp;<s:reset value="重置"></s:reset>&nbsp;
				<input type="button" value="返回" onClick="history.go(-1)"/>
			</span>
		</td>
	</tr>
</table>
</s:form>


  
</center>
</body>
</html>
