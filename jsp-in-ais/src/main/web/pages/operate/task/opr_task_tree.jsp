<%@ page pageEncoding="GBK"%>
<%@ page import="net.sf.json.JSONObject"%> 
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="ais.operate.task.service.ITaskService"%>
<%
 	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
	ITaskService service = (ITaskService) ctx
					.getBean("operate-taskService");
    String  project_id = request.getParameter("project_id");
    String  taskPid = request.getParameter("taskPid");
    String  viewTree = request.getParameter("viewTree");
    String  view="1";//是查看
    //请求数据viewTree=0，不是查看页面，不显示msn而是对钩图标
    if("0".equals(viewTree)){
    	view="0";//是编辑
    }
    String userCode = request.getParameter("userCode");
    String select = request.getParameter("select");
    
	JSONObject json = service.getTaskTreeJSONList(project_id,taskPid,userCode,select,view);
	if("-1".equals(taskPid)&&false){
		out.print(json.get("root"));
	}else{
		out.print(json.get("children"));
	}
	
	
 
%>