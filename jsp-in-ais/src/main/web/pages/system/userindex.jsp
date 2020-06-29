<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>

 <HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> index </TITLE>
</HEAD>
<frameset cols="250,*" frameborder="no" border="0" framespacing="0" >
<s:url id="url"  action="uSystemAction"   method="orgList4user" namespace="/system"></s:url>
<s:url id="url2"  action="uSystemAction"  method="getUserOwnList" namespace="/system">
<%
	request.setAttribute("extend",request.getParameter("extend"));
 %>
</s:url>
    <frame src="<s:text name="%{url}"/>" name="left" scrolling="Auto" noresize>
    <s:if test="${not empty(extend)}">
    <frame src=""  name="main"> <!-- main -->
    </s:if>
    <s:else>
    <frame src="<s:text name="%{url2}"/>"  name="main"> <!-- main -->
    </s:else>
</frameset>
<noframes><body>
对不起，您的浏览器不支持框架。请采用IE6.0以上版本浏览器进行浏览......
</body></noframes>
</HTML>