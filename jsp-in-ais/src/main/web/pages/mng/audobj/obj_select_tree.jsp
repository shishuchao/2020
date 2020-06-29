<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head>
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue(id,name)
{
  document.all("paranamevalue").value=name;
  document.all("paraidvalue").value=id;
}
</script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
</head>
  
<body>
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
	
<s:iterator id="tree" value="#request.objtree">
	<s:if test="${returnCurrent=='1'}">
		<p title="<s:property value="name"/>" sid="<s:property value="currentCode"/>" pid="<s:property value="superiorCode"/>" click="getSelectedValue('<s:property value="currentCode"/>','<s:property value="name"/>')"></p>
	</s:if>
	<s:else>
		<p title="<s:property value="name"/>" sid="<s:property value="currentCode"/>" pid="<s:property value="superiorCode"/>" click="getSelectedValue('<s:property value="id"/>','<s:property value="name"/>')"></p>
	</s:else>
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">

  </body>
</html>