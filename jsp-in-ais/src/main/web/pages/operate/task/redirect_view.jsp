<%
String crudId = request.getParameter("crudId");
String taskInstanceId = request.getParameter("taskInstanceId");
response.sendRedirect("/ais/pages/operate/task/view_flow_mng.jsp?doubt_id="+crudId);
%>