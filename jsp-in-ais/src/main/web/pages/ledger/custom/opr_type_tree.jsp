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
    String  checkbox = request.getParameter("checkbox");//�Ƿ���ʾcheckbox
    String  gm = request.getParameter("gm");
    String  viewTree = request.getParameter("viewTree");
    String view="1";
    String  groupOrMember = "0";//0ȫ����1��С�飬2����Ա,�����ж���С������������Ա����
    if("1".equals(gm)){
    	groupOrMember="1";
    }
    else if("2".equals(gm)){
    	groupOrMember="2";
    }else{
    	groupOrMember="0";
    }
    if("0".equals(viewTree)){//�����ж�����ʾʲôͼ�꣬0����ʾ���ǶԹ�ͼ�꣬1����ʾ����msn��ͷ
    	view="0";
    }
    String userCode = request.getParameter("userCode");
    String node = request.getParameter("node");//��ǰ���ڵ��������·��x-x-x
	//JSONObject json = service.getTaskTreeJSONListTree(project_id,taskPid,userCode,checkbox,node,groupOrMember,view);
	if("-1".equals(taskPid)&&false){//����ʾ���ڵ�
		out.print(json.get("root"));
	}else{
		out.print(json.get("children"));
	}
	
	
 
%>