<%
String crudId = request.getParameter("crudId");
String taskInstanceId = request.getParameter("taskInstanceId");
response.sendRedirect("/ais/pages/operate/task/matters_flow.jsp?doubt_id="+crudId+"&taskInstanceId="+taskInstanceId);
%>