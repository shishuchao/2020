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
    String  view="1";//�ǲ鿴
    //��������viewTree=0�����ǲ鿴ҳ�棬����ʾmsn���ǶԹ�ͼ��
    if("0".equals(viewTree)){
    	view="0";//�Ǳ༭
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