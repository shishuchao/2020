<%@ page contentType="text/html; charset=utf-8" %>
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
function chkall(){
	configtree.CheckAllNodes();
}
function allNochk(){
	configtree.UnCheckAllNodes();
} 
</script>
  </head>
  
  <body style="margin-top: 3px;">
  <div id="m_div" style="text-align:right;">
	<table border=0 cellspacing=1 cellpadding=1>
	<tr>
	<td>
		<div id="oneSelect" class="imgbtn" style="width:50px;" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="全选" onclick="chkall();"></div>					
		</td>
		<td>	
		<div id="oneSelect2" class="imgbtn" style="width:50px;" Imgsrc="<%=request.getContextPath()%>/resources/images/sall.gif" Background="#D2E9FF" Text="全不选" onclick="allNochk();"></div>
		</td>
		<td><div style="width:10px;"></div></td>
	</tr>
	</table>
</div>
<div class="TreeView" id="configtree" Checkbox="1" SelectSub="false" SelectedColor="#FFFF00">
<s:iterator value="#request.orgtree">
   <p  title="<s:property value="fname"/>" sid="<s:property value="fid"/>"  pid="<s:property value="fpid"/>"></p>
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
  </body>
</html>