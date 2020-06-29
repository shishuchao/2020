
<%
java.util.List list = (java.util.List)request.getAttribute("list");
String pro_id = (String)request.getAttribute("pro_id");
 
if(list!=null&&list.size()>0){
response.sendRedirect("/ais/operate/template/view.action");

}else{
response.sendRedirect("/ais/pages/operate/template/template2_programme.jsp?pro_id="+pro_id+"&");

}
%>
