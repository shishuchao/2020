<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<s:text id="title" name="'会议通知匹配查询'"></s:text>
<html>
<head>
<title><s:property value="#title"/></title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script language="javascript">
function searchList(){
//匹配查询

	var url = "${contextPath}//plan/meeting/meeting/search.action";
	myform.action = url;
	myform.submit();
	
}

function searchrecal(){
	var url = "${contextPath}//plan/meeting/meeting/search.action";
    window.location = url;
}
</script>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<s:head/>
</head>

<body>
<center>

<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead">&nbsp;<s:property value="#title"/></td></tr>
</table>

<s:form id="myform"   action="view.action"   namespace="//plan/meeting/meeting">



<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
	


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  


             	  
</table>


<s:hidden name="crudObject.id"/>  
<div align="right">
<s:button value="查询" onclick="javascript:searchList();"/>&nbsp;&nbsp;
<s:button value="重置" onclick="javascript:searchrecal();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
</s:form>
<display:table name="list" id="row" requestURI="${contextPath}//plan/meeting/meeting/search.action" class="its" 
	pagesize="15" partialList="true" size="resultSize">
	<display:column property="id" title="主键" sortable="true"></display:column>
	
	<display:column property="draftsmanId" title="起草人Id" sortable="true"></display:column>
	
	<display:column property="draftsmanName" title="起草人" sortable="true"></display:column>
	
	<display:column property="pubDate" title="发布日期" sortable="true"></display:column>
	
	<display:column property="callDate" title="召开日期" sortable="true"></display:column>
	
	<display:column property="endDate" title="结束日期" sortable="true"></display:column>
	
	<display:column property="startTime" title="开始时间" sortable="true"></display:column>
	
	<display:column property="endTime" title="结束时间" sortable="true"></display:column>
	
	<display:column property="sumUnit" title="召集单位" sortable="true"></display:column>
	
	<display:column property="compereId" title="主持人Id" sortable="true"></display:column>
	
	<display:column property="compereName" title="主持人" sortable="true"></display:column>
	
	<display:column property="locate" title="地点" sortable="true"></display:column>
	
	<display:column property="joiner" title="参加人员" sortable="true"></display:column>
	
	<display:column property="meetingName" title="会议名称" sortable="true"></display:column>
	
	<display:column property="meetingTitle" title="会议议题" sortable="true"></display:column>
	
	<display:column property="taskStats" title="任务状态" sortable="true"></display:column>
	
	<display:column property="handerSuggest" title="处理人意见" sortable="true"></display:column>
		
	<display:column title="操作">
		<a href="<s:url action="view"><s:param name="id" value="${row.id}"/></s:url>">查看</a>
	</display:column>			
</display:table>
</center>
</body>
</html>
