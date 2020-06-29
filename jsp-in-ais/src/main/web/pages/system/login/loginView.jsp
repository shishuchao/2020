<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="ais.user.model.UUser"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="ais.framework.util.Base64,java.io.OutputStream,ais.framework.util.MyProperty"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<%@page import="ais.sysparam.util.SysParamUtil"%><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<%
	String username = (String)session.getAttribute("loginname");
	if(username != null){
		session.invalidate();
	}

 %>
	<head>
		<title><%=SysParamUtil.getSysParam("ais.login.title")%></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<meta name="keywords" content="Central Authentication Service,JA-SIG,CAS" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/system/login/home.css" type="text/css" media="all" />
		<script src="<%=request.getContextPath()%>/pages/system/login/common.js" type="text/javascript"></script>
	</head>
	<body onload="init();">
	
		<div id="content" style="height:559px;text-align: center;vertical-align: middle;">
	<form method="post" action="/ais/loginServlet">

		<div>
				<img src="<%out.print(request.getContextPath()+"/skin/picview/pic1.jpg");%>" border="0"/>
				<div>
					<div >
					<table  border="0" width="800" height="82" background="<%out.print(request.getContextPath()+"/skin/picview/pic2.jpg");%>" cellpadding="0" cellspacing="0" ><!-- images/login_bottom.jpg -->
					<tr>
						<td align="center" valign="center">
							<label for="username" style="color:black;">系统账户：</label>
							<input class="required" id="username" name="username" size="10" tabindex="1" accesskey="" />
							&nbsp;
							<label for="password" style="color:black;">密码：</label>
							<input class="required"  type="password" id="password" name="password" size="10" tabindex="2" accesskey=""/>
							&nbsp;&nbsp;&nbsp;
						<button type="submit" style="cursor:hand;border:0px;height:26px;width:104px;" tabindex="3" accesskey="1"><img src="/ais/pages/system/login/_btn1.gif"/></button>
						&nbsp;&nbsp;
						<button type="reset" style="cursor:hand;border:0px;height:26px;width:104px;" tabindex="4" accesskey="c" ><img src="/ais/pages/system/login/_btn2.gif"/></button>
						
						</td>
						 
						</tr>
						<tr>
						<td>
						</td>
						</tr>
						</table>
					</div>
					
			
			
				</div>
	</div>
	</form>

</div>
	
    </body>
</html>
