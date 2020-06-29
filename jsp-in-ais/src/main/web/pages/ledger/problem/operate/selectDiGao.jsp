<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue(id,name)
{
	  document.all("paranamevalue").value=name;
	  document.all("paraidvalue").value=id;
}
</script>
  </head>
  
  <body>
<div class="TreeView" id="configtree" Checkbox="0" SelectSub="false" SelectedColor="#FFFF00">
<s:iterator value="#request.list">
   <p title="<s:property value="ms_name"/>" sid="<s:property value="formId"/>" pid="0" click="getSelectedValue('<s:property value="formId"/>','<s:property value="ms_name"/>')" />
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">

  </body>
</html>