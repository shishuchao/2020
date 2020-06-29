
<%@page import="ais.framework.util.MyProperty"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/styles/main/ais.css"
	rel="stylesheet" type="text/css">
<link href="${contextPath}/styles/portal/css.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/styles/portal/info.css" rel="stylesheet"
	type="text/css">
<SCRIPT type="text/javascript"
	src="<%=request.getContextPath()%>/scripts/calendar.js"></SCRIPT>
<script type='text/javascript'
	src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>

<script language="javascript">
function searchList(){
//匹配查询

	var url = "<%=request.getContextPath()%>/portal/simple/information/searchByType.action";
	myform.action = url;
	myform.submit();
	
}
function resetPage(){
	var _title = document.getElementsByName("helper.title");
	var _key = document.getElementsByName("helper.keyWords");
	var _createdate = document.getElementsByName("helper.createDate");
	if(_title){
		_title[0].value="";
	}
	if(_key){
		_key[0].value="";
	}
	if(_createdate){
		_createdate[0].value="";
	}
}
</script>
<title><s:if
	test="helper.infoType==@ais.portal.simple.model.Information@TRENDS">
		审计新闻
	</s:if> <s:elseif
	test="helper.infoType==@ais.portal.simple.model.Information@BULLETIN_BOARD">
		部门公告
	</s:elseif> <s:elseif
	test="helper.infoType==@ais.portal.simple.model.Information@HOTLINK">
		友情链接
	</s:elseif></title>
<%
	int type = ((ais.portal.automake.helper.PortalBaseHelper) request
			.getAttribute("helper")).getInfoType().intValue();
	if (type == ais.portal.simple.model.Information.HOTLINK) {
		request.setAttribute("fkey", "网址");
	} else if (type == ais.portal.simple.model.Information.FEEDBACK) {
		request.setAttribute("fkey", "Email");
	} else {
		request.setAttribute("fkey", "关键字");
	}
%>
</head>

<body>
<center>

<div id="content_1" style="width: 100%;"><br>
<br>
<br>
<s:form id="myform"
	action="/portal/simple/information/searchByType.action">
	<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable">
		<tr class="titletable1">
			<td>标题</td>
			<td><s:textfield name="helper.title" /></td>
			<td>创建时间</td>
			<td><s:textfield name="helper.createDate" onclick="calendar()"
				readonly="true" /></td>
		</tr>
		<tr class="titletable1">
			<td>${fkey}:</td>
			<td><s:textfield name="helper.keyWords" /></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<s:hidden name="helper.infoType" />
	<s:button value="查询" onclick="javascript:searchList();" />
	<s:button onclick="resetPage()" value='重置'></s:button>
</s:form> <display:table name="list" id="row"
	requestURI="${contextPath}/portal/simple/information/searchByType.action"
	class="its" export="false"
	pagesize="${helper.pageSize}" partialList="true" size="${helper.totalRows}" sort="external" 
	defaultsort="3" defaultorder="descending"
	style="word-break:break-all; word-wrap: break-word;">
	<display:column title="标题" sortable="true" class="center" sortName="title"
		headerClass="center">
		<a
			href="<s:url action="viewByType"><s:param name="information.id" value="'${row.id}'"/><s:param name="information.type" value="${row.type}"/></s:url>"
			target="_blank">${row.title}</a>
	</display:column>
	<s:if
	test="helper.infoType==@ais.portal.simple.model.Information@TRENDS">
		<display:column property="infkey" title="关键字" sortable="true" sortName="infkey"
		style="white-space:nowrap; width:200;" class="center"
		headerClass="center"></display:column>
	</s:if> <s:elseif
	test="helper.infoType==@ais.portal.simple.model.Information@BULLETIN_BOARD">
		<display:column property="infkey" title="关键字" sortable="true" sortName="infkey"
		style="white-space:nowrap; width:200;" class="center"
		headerClass="center"></display:column>
	</s:elseif> <s:elseif
	test="helper.infoType==@ais.portal.simple.model.Information@HOTLINK">
		<display:column property="infkey" title="网址" sortable="true" sortName="infkey"
		style="white-space:nowrap; width:200;" class="center"
		headerClass="center"></display:column>
	</s:elseif></title>
	
	<display:column property="createdate" title="创建时间" sortable="true" sortName="createdate"
		style="white-space:nowrap; width:200;" class="center"
		headerClass="center"></display:column>
	<display:column property="customSort" title="优先级" sortable="true" sortName="customSort"
		style="white-space:nowrap; width:200;" class="center"
		headerClass="center"></display:column>
</display:table></div> 
</center>
</body>
</html>
