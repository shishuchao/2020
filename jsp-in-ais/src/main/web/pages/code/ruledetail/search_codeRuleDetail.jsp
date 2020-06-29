
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<s:text id="title" name="'编号规则评细定义匹配查询'"></s:text>





<html>
<script language="javascript">
function searchList(){
//匹配查询

	var url = "${contextPath}/code/ruledetail/codeRuleDetail/search.action";
	myform.action = url;
	myform.submit();
	
}


function searchrecal(){
	var url = "${contextPath}/code/ruledetail/codeRuleDetail/search.action";
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


<s:form id="myform"   action="view.action"   namespace="/code/ruledetail/codeRuleDetail">



<s:hidden name="codeRuleDetail.id"/>  
<div align="right">
<s:button value="查询" onclick="javascript:searchList();"/>&nbsp;&nbsp;
<s:button value="重置" onclick="javascript:searchrecal();"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
</s:form>
<display:table name="list" id="row" requestURI="${contextPath}/code/ruledetail/codeRuleDetail/search.action" class="its" 
	pagesize="15" partialList="true" size="resultSize">
	<display:column property="id" title="主键" sortable="true"></display:column>
		
	<display:column property="d_field_name" title="编码字段名" sortable="true"></display:column>	
		
	<display:column property="d_field_value" title="值" sortable="true"></display:column>	
		
	<display:column property="d_field_type" title="编码类型" sortable="true"></display:column>	
		
	<display:column property="d_table_name" title="表名" sortable="true"></display:column>	
		
	<display:column property="d_function" title="函数" sortable="true"></display:column>	
		
	<display:column property="d_comparesign" title="比较符" sortable="true"></display:column>	
		
	<display:column property="d_compare_value" title="比较值" sortable="true"></display:column>	
		
	<display:column property="d_digit" title="位数" sortable="true"></display:column>	
	

	<display:column title="操作">
		<a href="<s:url action="view"><s:param name="id" value="${row.id}"/></s:url>" target="_blank">查看</a>
	</display:column>			
</display:table>
</center>
</body>
</html>
