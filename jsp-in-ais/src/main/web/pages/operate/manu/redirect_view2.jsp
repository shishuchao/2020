<%
String crudId = request.getParameter("crudId");
String taskInstanceId = request.getParameter("taskInstanceId");
response.sendRedirect("/ais/pages/operate/manu/manuscript_view2.jsp?manuscript_id2="+crudId+"&taskInstanceId="+taskInstanceId);
%>