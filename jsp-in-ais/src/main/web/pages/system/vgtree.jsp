<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
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
 <div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00">
<s:iterator value="#request.vgtree"  id="row">
<p  title="<s:property value="name"/>" sid="<s:property value="id"/>" pid="0"></p>
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
  </body>
</html>