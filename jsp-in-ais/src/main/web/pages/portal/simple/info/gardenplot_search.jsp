<%@page import="ais.framework.util.MyProperty"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>


<script language="javascript">
function searchList(){
//匹配查询

	var url = "<%=request.getContextPath()%>/portal/simple/information/gardenPlotSearch.action";
	myform.action = url;
	myform.submit();
	
}
function resetPage(){
	var _title = document.getElementsByName("studyGardenPlot.title");
	var _key = document.getElementsByName("studyGardenPlot.keyword");
	var _createdate = document.getElementsByName("studyGardenPlot.create_date");
	var _parentId = document.getElementsByName("studyGardenPlot.parent_id");
	if(_title){
		_title[0].value="";
	}
	if(_key){
		_key[0].value="";
	}
	if(_createdate){
		_createdate[0].value="";
	}
	if(_parentId){
		_parentId.selectedIndex=-1;
	}
}
</script>
<title>学习园地</title>

<s:head/>
<%

		String u="";
			 Cookie[] cookies = request.getCookies();
		     if (cookies != null) {
		     for (int i=0; i< cookies.length; i++) { 
		     if (cookies[i].getName().equals("ais_u")){
		     u = cookies[i].getValue();
		     break; 
		     }
		     }
		     }
			String pStr = MyProperty.getProperties("ais.portal");
		
			ais.user.model.UUser user = (ais.user.model.UUser) session
					.getAttribute("user");
			String name = "";
			if (user != null) {
				name = user.getFname();
			}
			ais.organization.model.UOrganization orga = (ais.organization.model.UOrganization) session
					.getAttribute("organization");
			
		%>
</head>

<body>
<center>
<s:form id="myform"   action="/portal/simple/information/gardenPlotSearch.action">
	
<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
<tr  class="titletable1">
<td  class="ListTableTr11" >标题</td><td><s:textfield name="studyGardenPlot.title"/></td>
<td  class="ListTableTr11" >创建时间</td><td><s:textfield name="studyGardenPlot.tempDate" onclick="calendar()" readonly="true"/></td>	
</tr>
<tr  class="titletable1">
<td  class="ListTableTr11" >关键字</td><td><s:textfield name="studyGardenPlot.keyword"/></td>
<td  class="ListTableTr11" >学习园地类别</td><td><s:select name="studyGardenPlot.parent_id" list="basicUtil.gardenplotList" listKey="code" listValue="name" emptyOption="true"></s:select></td>	
</tr>
	
</table>
<s:hidden name="view" value='1'/>
<s:hidden name="studyGardenPlot.ispub" value="Y"></s:hidden>
<s:button value="查询" onclick="javascript:searchList();"/>
<s:button onclick="resetPage()" value='重置'></s:button>
</s:form>
	<display:table name="studyGardenPlotList" id="row" requestURI="${contextPath}/portal/simple/information/gardenPlotSearch.action"
		class="its" pagesize="${baseHelper.pageSize}" partialList="true" size="${baseHelper.totalRows}"
		sort="external" defaultsort="3" defaultorder="descending"
		export="false" style="word-break:break-all; word-wrap: break-word;">
	<display:column style="width:50%" title="标题" sortable="true" sortName="title"  class="center" headerClass="center">
	<a href="<s:url action="gardenPlotView"><s:param name="studyGardenPlot.id" value="'${row.id}'"/></s:url>" target="_blank">${row.title}</a>
	</display:column>
	<display:column title="关键字" sortable="true" sortName="keyword"  class="center" headerClass="center" property="keyword"></display:column>
	<display:column property="create_date" title="创建时间" sortable="true" sortName="create_date" style="white-space:nowrap; width:200;"  class="center" headerClass="center"></display:column>
	</display:table>
	</div>
			<div id="foot">
				<table width="95%" style="border: 0px;" cellspacing="0" cellpadding="0">
					<tr>
						<td width="70%" height="36">
							&nbsp;
						</td>
						<td width="30%" valign="bottom" class="text1">
							<%=request.getAttribute("copyright") %>
						</td>
					</tr>
				</table>
			</div>
</center>
</body>
</html>
