<%@ page pageEncoding="GBK"%>
<%@page import="net.sf.json.JSONObject"%> 
<%@ page import="net.sf.json.*"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="ais.operate.task.service.ITaskService"%>
<%@ page import="java.util.List"%>
<%@page import="ais.user.model.UUser"%>
<%
 	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
	ITaskService service = (ITaskService) ctx
					.getBean("operate-taskService");
    String  project_id = request.getParameter("project_id");
    String  taskPid = request.getParameter("taskPid");
    //request.setAttribute("uuuser",request.getSession().getAttribute("user"));
    UUser user = (UUser) session.getAttribute("user");
    request.getSession().getServletContext().setAttribute("uuuser",request.getSession().getAttribute("user"));
	JSONObject json = service.getTaskTreeJSONList(project_id,taskPid,user.getFloginname());
	
	//System.out.println( "taskPid# "+request.getParameter("taskPid"));
	//out.print("[{user:'Jack Slocum',iconCls:'task',task:'Abstract rendering in TreeNodeUI',uiProvider:'col',duration:'15 min'}]");
	if("-1".equals(taskPid)){
	//System.out.println("root# "+json.get("root"));
	out.print(json.get("root"));
	}else{
	out.print(json.get("children"));
	}
	
	
 
%>