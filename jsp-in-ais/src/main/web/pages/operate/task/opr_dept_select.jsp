<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List"%>
 <%@ page import="ais.operate.task.model.AudMember"%>
<html>
  <head>
  		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
  		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="javascript">
function getSelectedValue(id,name){
	  document.all("paranamevalue").value=name;
	  document.all("paraidvalue").value=id;
}
</script>
  </head>
  <body>
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
<% 
StringBuffer   showProductList   =   new   StringBuffer();   

List list=(List)request.getAttribute("list");
boolean flag=true;
for(int a=0;a<list.size();a++){
AudMember audMember = (AudMember)list.get(a);
if(audMember!=null&&audMember.getUser_name()!=null&&!"".equals(audMember.getUser_name().trim())){
flag=false;
}else{
 continue;
}
//System.out.println(audMember);
String name = audMember.getUser_name();   
String id = audMember.getUser_code();   
%>

     <p  title="<%=name%>" sid="<%=id%>" pid="0"  click="getSelectedValue('<%=id%>','<%=name%>')"></p>
   <%}%>

</div>
<input type=hidden id="paraidvalue" value="">
<input type=hidden id="paranamevalue" value="">
  </body>
</html>