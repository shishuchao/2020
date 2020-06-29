<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue()
{
	  document.all("paranamevalue").value=configtree.GetSelectedValue();
	  document.all("paraidvalue").value=configtree.GetSelected();
}
</script>
  </head>
  
  <body>
<div class="TreeView" id="configtree" Checkbox="1" SelectSub="false" SelectedColor="#FFFF00">

<s:iterator value="#request.sorts">
   <p title="<s:property value="name"/>" sid="<s:property value="id"/>" pid="<s:property value="fid"/>" click="getSelectedValue('<s:property value="id"/>','<s:property value="name"/>')" />
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">

  </body>
</html>