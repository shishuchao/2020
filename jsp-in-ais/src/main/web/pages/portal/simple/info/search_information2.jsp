
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<s:text id="title" name="'匹配查询信息管理'"></s:text>





<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script language="javascript">
function searchList(){
//匹配查询

	var url = "<%=request.getContextPath()%>/portal/simple/information/searchByType2.action";
	myform.action = url;
	myform.submit();
	
}
</script>
<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></SCRIPT>
<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<title><s:property value="#title"/></title>
<s:head/>
</head>

<body>
<center>

<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead">&nbsp;<s:property value="#title"/></td></tr>
</table>

<s:form id="myform" name="myform"  action="/portal/simple/information/searchByType2.action">
	
<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
<tr  class="titletable1">
<td>标题</td><td><s:textfield name="information.title"/></td>
	
<td>关键字</td><td><s:textfield name="information.infkey"/></td>
</tr>
<tr  class="titletable1">
<td>创建时间</td><td><s:textfield name="information.createdate" onclick="calendar()" readonly="true"/></td>
<td>分类</td>
<td>
	<s:doubleselect doubleList="categoryMap[top]" doubleListKey="code"
								firstName="选择大类：" secondName="&nbsp;&nbsp;&nbsp;&nbsp;选择小类：" doubleListValue="name" listKey="code" listValue="name"
								name="information.category_code" list="categoryMap.keySet()" 
								doubleName="category2_code" theme="ufaud_simple"
								templateDir="/strutsTemplate"></s:doubleselect>
</td>
</tr>
		
</table>
<s:hidden name="information.isSelect"/>
<s:hidden name="information.id"/>  <s:hidden name="information.type" value="${information.type}"/>  
<s:button value="查询" onclick="javascript:searchList();"/>
<%--<input type="button" name="add" value="增加" onclick="javascript:window.location='<s:url action="editByType2"><s:param name="information.id" value="0"/><s:param name="information.type" value="${information.type}"/></s:url>'">--%>
</s:form>
<display:table name="list" id="row" requestURI="${contextPath}/portal/simple/information/searchByType.action" class="its" pagesize="20" export="false">
	
	<display:column property="title" title="标题" sortable="true"></display:column>
	<display:column property="infkey" title="关键字" sortable="true"></display:column>
	
	<display:column property="createdate" title="创建时间" sortable="true"></display:column>
		
	<display:column title="操作">
<%--		<a href="<s:url action="editByType2"><s:param name="information.id" value="${row.id}"/><s:param name="information.type" value="${row.type}"/></s:url>">修改</a>&nbsp&nbsp--%>
<%--		<a href="<s:url action="deleteByType2"><s:param name="information.id" value="${row.id}"/><s:param name="information.type" value="${row.type}"/></s:url>">删除</a>--%>
		<a href="<s:url action="viewByType2"><s:param name="information.id" value="${row.id}"/><s:param name="information.type" value="${row.type}"/></s:url>">查看</a>
	</display:column>			
</display:table>
<br>
</center>
</body>
</html>
