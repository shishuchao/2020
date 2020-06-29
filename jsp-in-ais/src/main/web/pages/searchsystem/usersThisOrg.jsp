<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>

 <HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> index </TITLE>
<% String s1="p_issel",s=request.getParameter(s1); if(s==null) s="";
String p1=request.getParameter("feedback_unit");
System.out.println(p1);
%>

</HEAD>
<frameset frameborder="no" border="0" framespacing="0" >
    <frame src="/ais/systemnew/getUserOwnList.action<%="?"+s1+"="+s+"&p_deptid="+p1%>"  name="main" noresize="noresize">
</frameset>
<noframes><body>
对不起，您的浏览器不支持框架。请采用IE6.0以上版本浏览器进行浏览......
</body></noframes>
</HTML>