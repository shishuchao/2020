<%@ page pageEncoding="GBK"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="ais.operate.template.service.ITemplateService"%>
<%
	WebApplicationContext ctx = WebApplicationContextUtils
			.getWebApplicationContext(application);
	ITemplateService service = (ITemplateService) ctx
			.getBean("operate-templateService");
	String audTemplateId = request.getParameter("audTemplateId");
	String taskPid = request.getParameter("taskPid");
	JSONObject json = service.getTemplateTreeJSONList(audTemplateId,
			taskPid);
	//out.print(json.get("children"));
	//根节点
	/*if ("-1".equals(taskPid)) {
		out.print(json.get("root"));
	} else {//子节点
		out.print(json.get("children"));
	}*/
	if("-1".equals(taskPid)&&false){
		out.print(json.get("root"));
	}else{
		out.print(json.get("children"));
	}
%>