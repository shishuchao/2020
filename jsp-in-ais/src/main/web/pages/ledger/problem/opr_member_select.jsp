<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List"%>
<%@ page import="ais.project.start.model.ProMember"%>
<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
		function getSelectedValue(title,sid)
		{	
		  	document.all("paranamevalue").value=title;
		  	document.all("paraidvalue").value=sid;
		}
</script>
  </head>
  
  <body>
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
<% 
	StringBuffer showProductList = new StringBuffer();   
	List list = (List)request.getAttribute("pmList");
	if(list==null||list.size()>0){
		for(int a=0;a<list.size();a++){
			ProMember pm = (ProMember)list.get(a);
			if(pm!=null){

			}else{
				continue;
			}
			String name1 = pm.getUserName();
			String name2 = pm.getUserName()+"("+pm.getRoleName()+")";
			String id = pm.getUserId();   
			String linked = "0";  
%>
     <p title="<%=name2%>" sid="<%=id%>" pid="0"  value="" click="getSelectedValue('<%=name1%>','<%=id%>')"></p>
   	<%}%>
     </div>&nbsp;
<% }else{ %>	
</div>&nbsp;
<p><font size="4" color='#1b6252'>&nbsp;&nbsp;没有可供选的项目成员。<br>&nbsp;&nbsp;</font></p>
<p>&nbsp;&nbsp;</p>
<%}%>
<input type="hidden" id="paraidvalue" value="">
<input type="hidden" id="paranamevalue" value="">

  </body>
</html>