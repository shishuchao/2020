<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>审计经验</title>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
</head>
<body>
<h1>这个页面经查找没有用到，出现使用此页面的时候在进行修改</h1>
<s:form action="">
${message}

	<s:hidden name="m_str" value="${m_str}"></s:hidden>
	<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
	<display:table name="objectList" id="row"  class="its" pagesize="10"   size="listsize" requestURI="/pages/assist/suport/lawsLib/search.action" partialList="true"
			defaultorder="descending">
			<%--<display:column title="主键" sortable="true">${row.id}</display:column>
			<display:column title="主键2" property="id"/>
			
			--%><%--<display:column property="createTime"  format="{0,date,yyyy-MM-dd}">
			</display:column>--%>
			<display:column title="名称<题目/条目>" >${row.title}</display:column>
			<display:column title="编号" >${row.codification}</display:column>	
			<display:column title="颁布单位" >${row.promulgationDept}</display:column>
			<display:column title="时效性" >${row.effective}</display:column>
			<display:column title="备注" >${row.remark}</display:column>
			<display:column title="关键字" >${row.keywords}</display:column>
			<display:column title="类别" >${row.category}</display:column>
			<display:column title="操作类型">
			
				<a href="<s:url action="edit"><s:param name="abc" value="123"/></s:url>&assistSuportLawslib.id=${row.id}&nodeid=${nodeid}">编辑</a>
				<a href="<s:url action="delete"><s:param name="abc" value="123"/></s:url>&assistSuportLawslib.id=${row.id}&nodeid=${nodeid}">删除</a>
			</display:column>
	</display:table>
<hr>
</s:form>
</body>
</html>