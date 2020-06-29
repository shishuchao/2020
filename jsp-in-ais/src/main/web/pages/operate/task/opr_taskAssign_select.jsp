<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.List"%>
 <%@ page import="ais.operate.task.model.AudMember"%>
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
  
  <body><!-- click="getSelectedValue('4','tom')"-->
<div class="TreeView" id="configtree" Checkbox="1" SelectedColor="#FFFF00">
<% 
StringBuffer   showProductList   =   new   StringBuffer();   



List list=(List)request.getAttribute("list");
boolean flag=true;
if(list!=null&&list.size()>0){
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
String linked = audMember.getLinked();  
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
 
<p>&nbsp;&nbsp;没有可供选择的小组成员，如果已经选择小组，请先确认该小组是否分配人员!</p>
<p>&nbsp;&nbsp;</p>
<%}%>
<input type=hidden id="paraidvalue" value=""><input type=hidden id="paranamevalue" value="">

  </body>
</html>