<%@page import="ais.project.ProjectSysParamUtil"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<%@page import="ais.sysparam.util.SysParamUtil"%><html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	</head>
	<body>
		<%
		Object obj=request.getAttribute("url");
		if(obj!=null){
			String url=(String)obj;
			response.sendRedirect(url);		
		}else{
			//response.sendRedirect(request.getContextPath() + "/portal/simple/simple-firstPageAction!sysPortal.action");
			String username = (String)request.getAttribute("username");
			String firstPage = (String)request.getAttribute("firstPage");
			if("superadmin".equalsIgnoreCase(username) || "admin".equalsIgnoreCase(username)){
				response.sendRedirect(request.getContextPath() + "/portal/simple/simple-firstPageAction!menu.action?parentMenuId=10");
			}else {
			    if("audportal".equalsIgnoreCase(firstPage) && !username.startsWith("TEMP")) {
					response.sendRedirect(request.getContextPath() + "/portal/simple/simple-firstPageAction!audportal.action?audportal=audportal");
				} else {
					response.sendRedirect(request.getContextPath() + "/portal/simple/simple-firstPageAction!sysPortal.action");
				}
			}
		}
		%>
	</body>
</html>

