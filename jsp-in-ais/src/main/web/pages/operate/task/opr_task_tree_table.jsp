<%@ page pageEncoding="GBK"%>
<%@page import="net.sf.json.JSONObject"%> 
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="ais.operate.task.service.ITaskService"%>
<%
 	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
	ITaskService service = (ITaskService) ctx
					.getBean("operate-taskService");
    String  project_id = request.getParameter("project_id");//��Ŀid
    String  taskPid = request.getParameter("taskPid");//���ڵ�
    if(taskPid.equalsIgnoreCase("undefined"))
    	taskPid="-1";
    String  task = request.getParameter("task");
    String userCode = request.getParameter("userCode");//�û�id
    String select = request.getParameter("select");//û��
    
	JSONObject json = service.getTaskTreeJSONTable(project_id,taskPid,userCode,select);
	if("-1".equals(task)){
		out.print(json.get("root"));
	}else{
		out.print(json.get("children"));
	}
	
	
 
%>