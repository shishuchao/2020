<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue1(id,name)
{
  document.all("paranamevalue").value=name;
  document.all("paraidvalue").value=id;
}
function getSelectedValue()
{
  document.all("paranamevalue").value=configtree.GetSelectedValue();
  document.all("paraidvalue").value=configtree.GetSelected();
}
</script>
  </head>
  
  <body>
<div class="TreeView" id="configtree" Checkbox="${p_check }" topVisible="false" SelectedColor="#FFFF00" SelectSub="false">
 <p  title="基础信息" sid="1" pid="0"></p>
<s:iterator value="#request.basictree">

   <p  title="<s:property value="name"/>" sid="<s:property value="id"/>" pid="<s:property value="pid"/>" click="getSelectedValue1('<s:property value="code"/>','<s:property value="name"/>')"></p>
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">

  </body>
</html>