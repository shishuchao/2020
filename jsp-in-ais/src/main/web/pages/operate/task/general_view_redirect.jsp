<%
String project_id = (String)request.getAttribute("project_id");
String type = (String)request.getAttribute("type");
String file_id = (String)request.getAttribute("file_id");
String mod_id = (String)request.getAttribute("mod_id");
String bns_id = (String)request.getAttribute("bns_id");
String url = (String)request.getAttribute("url");
String content = (String)request.getAttribute("content");
 
response.sendRedirect("/ais/pages/operate/task/fap_view.jsp?project_id="+project_id+"&type="+type+"&mod_id="+mod_id+"&bns_id="+bns_id);
 
%>
