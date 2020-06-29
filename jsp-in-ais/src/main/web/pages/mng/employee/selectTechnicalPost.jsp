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
		function getSelectedValue(title,sid)
		{	
		  	document.all("paranamevalue").value=title;
		  	document.all("paraidvalue").value=sid;
		}
	</script>
    <title>职称</title>
  </head>
  
  <body>
	<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
		<s:iterator value="#request.technicalPostList">
			<p title="<s:property value="name"/>" sid="<s:property value="code"/>" pid="0"
			 click="getSelectedValue('<s:property value="name"/>','<s:property value="code"/>')"></p>
		</s:iterator>
	</div>
	<input type="hidden" id="paranamevalue" value="">
	<input type="hidden" id="paraidvalue" value="">
  </body>
</html>
