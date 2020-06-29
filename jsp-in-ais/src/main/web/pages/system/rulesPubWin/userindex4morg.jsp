<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>

 <HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> index </TITLE>
<% String s1="p_issel",s=request.getParameter(s1); if(s==null) s="";
String p1=request.getParameter("feedback_unit");
String p2=request.getParameter("feedback_unit_name");
String orgId="orgId";
String orgName="orgName";
System.out.println(p1);
%>

</HEAD>
<frameset cols="250,*" frameborder="no" border="0" framespacing="0" >
<s:url id="url2"  action="uSystemAction"  method="getUserOwnList" namespace="/system">

</s:url>
    <frame src="/ais/system/uSystemAction!findUorg.action<%="?"+s1+"="+s+"&orgId="+p1+"&orgName="+p2%>" name="left" scrolling="Auto" noresize>
    <frame src=""  name="main">
</frameset>
<noframes><body>
对不起，您的浏览器不支持框架。请采用IE6.0以上版本浏览器进行浏览......
</body></noframes>
</HTML>