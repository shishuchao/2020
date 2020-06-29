<%@ page pageEncoding="GBK"%>
<%@page import="net.sf.json.JSONObject"%> 
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="ais.operate.task.service.ITaskService"%>
<%
 	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
	ITaskService service = (ITaskService) ctx
					.getBean("pro-ledgerCustomService");
    String  project_id = request.getParameter("project_id");
    String  taskPid = request.getParameter("taskPid");
    String  checkbox = request.getParameter("checkbox");//是否显示checkbox
    String  gm = request.getParameter("gm");
    String  viewTree = request.getParameter("viewTree");
    String view="1";
    String  groupOrMember = "0";//0全部，1是小组，2是组员,用来判断是小组批量还是组员批量
    if("1".equals(gm)){
    	groupOrMember="1";
    }
    else if("2".equals(gm)){
    	groupOrMember="2";
    }else{
    	groupOrMember="0";
    }
    if("0".equals(viewTree)){//用来判断是显示什么图标，0：显示的是对钩图标，1：显示的是msn人头
    	view="0";
    }
    String userCode = request.getParameter("userCode");
    String node = request.getParameter("node");//当前树节点在树里的路径x-x-x
	//JSONObject json = service.getTaskTreeJSONListTree(project_id,taskPid,userCode,checkbox,node,groupOrMember,view);
	if("-1".equals(taskPid)&&false){//不显示根节点
		out.print(json.get("root"));
	}else{
		out.print(json.get("children"));
	}
	
	
 
%>