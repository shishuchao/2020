<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title></title>
	<link href="/AUDIT/styles/blue/ufaud.css" rel="stylesheet" type="text/css">
	<link href="/AUDIT/styles/displaytag/maven-base.css" rel="stylesheet" type="text/css">
	<link href="/AUDIT/styles/displaytag/maven-theme.css" rel="stylesheet" type="text/css">
	<link href="/AUDIT/styles/displaytag/site.css" rel="stylesheet" type="text/css">
	<link href="/AUDIT/styles/displaytag/screen.css" rel="stylesheet" type="text/css">
	<link href="/AUDIT/styles/displaytag/print.css" rel="stylesheet" type="text/css">
</head>
<body>

<center>
<h3>查询参数</h3>
<s:form action="SearchUOrg.action" namespace="/admin" method="post" theme="simple">
<s:hidden name="m_str"></s:hidden>
<ufaud:showQueryItem pojoClass="ais.ais.model.UOrganization" excludeItem="serialVersionUID,fid,fpid,fcompanyid,fenname,faddress,fweb,fstatus" applicationResources="ApplicationResources_zh_CN"></ufaud:showQueryItem>
<s:submit value="查询"></s:submit>&nbsp&nbsp&nbsp&nbsp<s:reset value="重置"></s:reset>&nbsp&nbsp&nbsp&nbsp
<input type="button" value="返回" onClick="history.go(-1)"/>
</s:form>


  
</center>
</body>
</html>
