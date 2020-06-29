<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List"%>
 <%@ page import="ais.operate.task.model.AudDoubt"%>
<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue(){
	var arr=document.getElementById("configtree").getElementsByTagName("input");
	var first=true;
	var ids=document.all("paraidvalue");
	var names=document.all("paranamevalue");
	for(var t=0;t<arr.length; t++){
		if(arr[t].checked==true){
			if(first==true){
				ids.value=arr[t].value; first=false;
				names.value=arr[t].nextSibling.innerHTML;
			}else{
				ids.value+=","+arr[t].value;
				names.value+=","+arr[t].nextSibling.innerHTML;
			}
		}
	}
}
</script>
  </head>
  
  <body><!-- click="getSelectedValue('41','tom')"-->
<div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00">
<% 
StringBuffer   showProductList   =   new   StringBuffer();   

List list=(List)request.getAttribute("listDoubt");
if(list==null||list.size()>0){
	

for(int a=0;a<list.size();a++){
	AudDoubt audDoubt = (AudDoubt)list.get(a);
if(audDoubt!=null){

}else{
 continue;
}
//System.out.println(audManuscript);
String name = audDoubt.getDoubt_name();   
String id = audDoubt.getDoubt_id();   
String linked = audDoubt.getLinked();  
%>

     <p  title="<%=name%>" sid="<%=id%>" pid="0"  value=""
    <%if("1".equals(linked)){%>
     checked=true
     <%}else{%>
     checked=false
     <%}%>
     ></p>
   <%}%>
     </div>&nbsp;
<%}else{ %>
	
</div>&nbsp;
 
<p><font size="4" color='#1b6252'>&nbsp;&nbsp;没有可供选的择审计疑点。<br>&nbsp;&nbsp;请先确认您是否已经在该审计事项下做了审计疑点!</font></p>
<p>&nbsp;&nbsp;</p>
<%}%>
<input type=hidden id="paraidvalue" value=""><input type=hidden id="paranamevalue" value="">

  </body>
</html>