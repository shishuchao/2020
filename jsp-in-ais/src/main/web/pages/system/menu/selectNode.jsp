<!DOCTYPE HTML>
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
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
<p title="功能树" sid="1" pid="0"></p>
<s:iterator value="menulist">
   <p  title="<s:property value="ffundisplay"/>" sid="${ffunid}" pid="${fparentid}" click="getSelectedValue('${ffunid}','<s:property value="ffundisplay"/>')"></p>
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">

</body>
</html>