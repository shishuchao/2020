<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head>
  <meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue()
{		
	var nameStr=configtree.GetSelectedValue();
	var len=nameStr.length;
	if(nameStr.charAt(len-1)==','){	
		nameStr=nameStr.substring(0,len-1);
	}
  	document.all("paranamevalue").value=nameStr;
  	
  	var idStr=configtree.GetSelected();
  	var leng=idStr.length;
	if(idStr.charAt(leng-1)==','){	
		idStr=idStr.substring(0,leng-1);
	}
  	document.all("paraidvalue").value=idStr;
}
</script>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
  </head>
  
  <body>
<div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00">
<s:iterator value="#request.audited_dept_Tree">
   <p  title="<s:property value="name"/>" sid="<s:property value="currentCode"/>" pid="<s:property value="superiorCode"/>"></p>
</s:iterator>
</div>
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
  </body>
</html>