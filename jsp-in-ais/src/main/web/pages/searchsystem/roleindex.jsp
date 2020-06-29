<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>

 <HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> index </TITLE>
</HEAD>
<frameset cols="250,*" frameborder="no" border="0" framespacing="0" >
<s:url id="url"  action="orgList4role"  namespace="/systemnew"></s:url>
    <frame src="<s:text name="%{url}"/>" name="left" scrolling="Auto" noresize>
   
    <frame src=""  name="main"> <!-- main -->
</frameset>
<noframes><body>
</body></noframes>
</HTML>