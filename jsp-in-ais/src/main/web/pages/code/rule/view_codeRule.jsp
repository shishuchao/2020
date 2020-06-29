
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


	<s:text id="title" name="'编号规则定义表查看'"></s:text>





<html>
<script language="javascript">
function backList(){
//返回上级list页面
	var url = "${contextPath}/code/rule/codeRule/list.action";
	myform.action = url;
	myform.submit();

}
</script>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
<head>
<title><s:property value="#title"/></title>
<s:head/>
</head>

<body>
<center>
<s:form id="myform"  action="view" namespace="/code/rule/codeRule" >

<table>
	<tr class="listtablehead"><td colspan="5" align="left" class="edithead">&nbsp;<s:property value="#title"/></td></tr>
</table>


	
<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
	
<tr  class="titletable1">
<td>业务表名</td><td><s:property value="codeRule.rule_table_name"/></td>
</tr>
		 
	
<tr  class="titletable1">
<td>业务字段描述</td><td><s:property value="codeRule.rule_field_desc"/></td>
</tr>
		 
	
<tr  class="titletable1">
<td>字段名</td><td><s:property value="codeRule.rule_field_name"/></td>
</tr>
		 
	
<tr  class="titletable1">
<td>字段类型</td><td><s:property value="codeRule.rule_field_type"/></td>
</tr>
		 
	
<tr  class="titletable1">
<td>字段宽度</td><td><s:property value="codeRule.rule_field_length"/></td>
</tr>
		 
	
<tr  class="titletable1">
<td>公式</td><td><s:property value="codeRule.rule_formula"/></td>
</tr>
		 
		
</table>

<s:hidden name="codeRule.id"/>  
<s:button  value="关闭" onclick="javascript:window.close();"/> 
</s:form>

</center>
</body>
</html>
