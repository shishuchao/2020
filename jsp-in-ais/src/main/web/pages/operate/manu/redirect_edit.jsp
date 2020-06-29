<%
String crudId = request.getParameter("crudId");
String taskInstanceId = request.getParameter("taskInstanceId");
response.sendRedirect("/ais/pages/operate/manu/manuscript_flow.jsp?manuscript_id="+crudId+"&taskInstanceId="+taskInstanceId);
%>