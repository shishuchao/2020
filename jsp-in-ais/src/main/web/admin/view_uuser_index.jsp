<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>

 <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> index </TITLE>
</HEAD>
<frameset cols="180,*" frameborder="no" border="0" framespacing="0" >
<s:url id="url"  action="/orgnizationAction" method="welcome" />
   <!--  <frame src="<s:text name="%{url}"></s:text>" name="left" scrolling="Auto" noresize>   -->
   <frame name="left" scrolling="Auto" noresize src="/ais/admin/uuserTree.action?view=view">
    <frame   name="maintest" src="../blank.jsp">
 </frameset>
<noframes>
<body>
对不起，您的浏览器不支持框架。请采用IE6.0以上版本浏览器进行浏览......
</body></noframes>
</HTML>
