
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<s:text id="title" name="'编号规则定义表匹配查询'"></s:text>





<html>
<script language="javascript">
function searchList(){
//匹配查询

	var url = "${contextPath}/code/rule/codeRule/search.action";
	myform.action = url;
	myform.submit();
	
}


function searchrecal(){
	var url = "${contextPath}/code/rule/codeRule/search.action";
    window.location = url;
}
</script>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
<head>
<title><s:property value="#title"/></title>
<s:head/>
</head>

<body>
<center>

<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead">&nbsp;<s:property value="#title"/></td></tr>
</table>

<s:form id="myform"   action="view.action"   namespace="/code/rule/codeRule">



<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
	


             	  


             	  


             	  


             	  


             	  


             	  
</table>


<s:hidden name="codeRule.id"/>  
<div align="right">
<s:button value="查询" onclick="javascript:searchList();"/>&nbsp;&nbsp;
<s:button value="重置" onclick="javascript:searchrecal();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
</s:form>
<display:table name="list" id="row" requestURI="${contextPath}/code/rule/codeRule/search.action" class="its" 
	pagesize="15" partialList="true" size="resultSize">
	<display:column property="id" title="主键" sortable="true"></display:column>
		
	<display:column property="rule_table_name" title="业务表名" sortable="true"></display:column>	
		
	<display:column property="rule_field_desc" title="业务字段描述" sortable="true"></display:column>	
		
	<display:column property="rule_field_name" title="字段名" sortable="true"></display:column>	
		
	<display:column property="rule_field_type" title="字段类型" sortable="true"></display:column>	
		
	<display:column property="rule_field_length" title="字段宽度" sortable="true"></display:column>	
		
	<display:column property="rule_formula" title="公式" sortable="true"></display:column>	
	

	<display:column title="操作">
		<a href="<s:url action="view"><s:param name="id" value="${row.id}"/></s:url>" target="_blank">查看</a>
	</display:column>
	<display:setProperty name="paging.banner.placement" value="bottom" />
</display:table>
</center>
</body>
</html>
