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
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#D9E8FB">

<s:iterator value="#request.orgtree">
<s:if test="${orgType!='1'}">
<p  style="margin:0px" title="<s:property value="fname"/>" sid="<s:property value="fid"/>" pid="<s:property value="fpid"/>"></p>
</s:if>
<s:else>
<p  style="margin:0px" title="<s:property value="fname"/>" sid="<s:property value="fid"/>" pid="<s:property value="fpid"/>" click="getSelectedValue('<s:property value="fid"/>','<s:property value="fname"/>')"></p>
</s:else> 
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">

  </body>
</html>