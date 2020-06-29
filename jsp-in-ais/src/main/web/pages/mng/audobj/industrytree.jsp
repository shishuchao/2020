<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
  <head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue(id,name)
{
  document.all("paranamevalue").value=name;
  document.all("paraidvalue").value=id;
}
</script>
  </head>

<body style="margin-top: 3px;">

<s:if test="${empty (industry_Tree)}">
	<div align="center">
	<h4 style="color: red">没有对应的行业性质</h4>
	</div>
</s:if>
<s:else>
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00" SelectSub="false">
	<p title="所有行业性质" sid="x1" pid="0"></p>
	<s:iterator value="#request.industry_Tree">
		<s:if test="${parentCode=='0'}">
	   	<p title="<s:property value="name"/>" sid="<s:property value="code"/>" pid="x1" click="getSelectedValue('<s:property value="code"/>','<s:property value="name"/>')"></p>
	   </s:if>
	   <s:else>
	   	<p title="<s:property value="name"/>" sid="<s:property value="code"/>" pid="<s:property value="parentCode"/>" click="getSelectedValue('<s:property value="code"/>','<s:property value="name"/>')"></p>
	   </s:else>
	</s:iterator>
</div>
</s:else>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
  </body>
</html>