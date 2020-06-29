<%
String crudId = request.getParameter("crudId");
String taskInstanceId = request.getParameter("taskInstanceId");
response.sendRedirect("/ais/pages/operate/manu/manuscript_view.jsp?manuscript_id="+crudId+"&taskInstanceId="+taskInstanceId);
%>