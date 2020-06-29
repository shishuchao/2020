<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
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
    
    <title>资格</title>
  </head>
  
  <body>
	<div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00">
		<s:iterator value="#request.competenceList">
			<p title="<s:property value="name"/>" sid="<s:property value="code"/>" pid="0"></p>
		</s:iterator>
	</div>
	<input type="hidden" id="paranamevalue">
	<input type="hidden" id="paraidvalue">
  </body>
</html>
