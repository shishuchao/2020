<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page import="ais.framework.context.AisContext,ais.system.webservices.SysServiceWrap,ais.system.webservices.ISysService,ais.user.model.UUser,ais.sysparam.util.SysParamUtil"%>
<html>
<head>
<title>ais login jsp</title>
</head>
<body>
<center>
<%
String syssend="ais";
String u="";
String n="";
String p="";
String encrypt="1";
if(request.getParameter("syssend")!=null && !request.getParameter("syssend").equals(""))
syssend=request.getParameter("syssend");

if(request.getParameter("u")!=null && !request.getParameter("u").equals(""))
	u=request.getParameter("u");
if(request.getParameter("n")!=null && !request.getParameter("n").equals(""))
	n=request.getParameter("n");
if(request.getParameter("p")!=null && !request.getParameter("p").equals(""))
	p=request.getParameter("p");
String gateway=SysParamUtil.getSysParam("ais.gateway.server");
String remoteAddr=request.getRemoteAddr().trim();
//if(!gateway.trim().equals(remoteAddr))
		//throw new Exception("非法请求:请求地址与网关地址不匹配.");
//获得认证信息
if(request.getHeader("dnname")!=null){
String DN = new String(request.getHeader("dnname").getBytes("ISO8859-1"),"GB2312");
String fname="游客";//用户名称
String fcard="111111111111111111";//身份证号
String[] DN0=DN.split(",");
for(int i=0;i<DN0.length;i++){
	String[] DNTMP=DN0[i].split("=");
	if(DNTMP[0].trim().equals("cn"))
			fname=	DNTMP[1].trim();
	if(DNTMP[0].trim().equals("t"))
			fcard=	DNTMP[1].trim();
}
SysServiceWrap sysServiceWrap=(SysServiceWrap)AisContext.getObjectByIoc("sysServiceWrap");
// 根据身份证号获得用户
ISysService sysService = sysServiceWrap.getSysService();
UUser user = sysService
		.getUserView("from UUser as a where a.fname='"+fname+"'"+" and a.fcard='"+fcard+"'");
if(user!=null){
	n=user.getFloginname();
	p=user.getFpassword();
}
}
if(request.getParameter("url")!=null){//跳到指定页面
	String queryStr=request.getQueryString();
	String exStr="";
	if(queryStr!=null){
		String[] ss=queryStr.split("&");
		for(int i=0;i<ss.length;i++){
			if(ss[i].indexOf("url=")!=0){
				exStr+="&"+ss[i];
			} 
		}
	}
	Cookie cookie=new Cookie("url",request.getParameter("url")+exStr);
	cookie.setMaxAge(-1);//
	cookie.setPath("/");
	response.addCookie(cookie);
}
 %>
<%response.sendRedirect(request.getContextPath()+"/system/uSystemAction!sysSend.action?syssend="+syssend+"&u="+u+"&n="+n+"&p="+p);%>
</center>
</body>
</html>