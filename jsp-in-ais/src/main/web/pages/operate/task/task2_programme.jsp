<%
String project_id = (String)request.getParameter("project_id");
 
response.sendRedirect("/ais/operate/template/view.action?project_id="+project_id+"");


%>
