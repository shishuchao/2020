<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>审计经验</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">	
<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<SCRIPT type="text/javascript">
	function reset2(){
		setNull("assistSuportLawslib.title");
		setNull("assistSuportLawslib.promulgationDate");
		setNull("assistSuportLawslib.promulgationDept");
		setNull("assistSuportLawslib.summan");
		setNull("assistSuportLawslib.sundept");
		setNull("assistSuportLawslib.content");
		setNull("assistSuportLawslib.categoryFk");
		setNull("assistSuportLawslib.category");
		
		//提交查询
		document.forms[0].submit();
	}
	function setNull(name){
		document.getElementsByName(name)[0].value="";
	}
</SCRIPT>						
</head>
<body>
<s:form action="search.action" method="post">
${message}  
	<%@include file="/pages/assist/suport/auditExp/include_search.jsp"%>
	<display:table name="objectList" id="row"  class="its" requestURI="../lawsLib/search.action?m_view=view" 
		pagesize="${baseHelper.pageSize}" partialList="true" 
		size="${baseHelper.totalRows}" sort="external"
		defaultsort="2" defaultorder="descending" >
			<display:column title="名称" sortable="true" headerClass="center" class="left" sortName="title">
					${row.title}
			</display:column>
			<display:column title="发布单位" property="promulgationDept" sortable="true" headerClass="center" class="left" sortName="promulgationDept"/>
			<display:column title="经验类别" sortable="true" headerClass="center" class="left" sortName="category">${row.category}</display:column>
			<display:column title="创建日期" sortable="true" headerClass="center" class="left" maxLength="10" property="createDate" sortName="createDate">
			</display:column>
			<display:column title="颁布日期" sortable="true" headerClass="center" class="left" maxLength="10" property="promulgationDate" sortName="promulgationDate">
			</display:column>
			<display:column  headerClass="center" class="center" title="操作">
				<a href="../lawsLib/edit.action?m_view=true&assistSuportLawslib.id=${row.id}&nodeid=${nodeid}&m_str=${m_str}">详细内容</a>
			</display:column>
	</display:table>
</s:form>
</body>
</html>