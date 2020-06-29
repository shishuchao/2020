<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>

<HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> employeeindex </TITLE>
</HEAD>
<%
   request.setAttribute("org",request.getParameter("org"));
   String s1="p_issel",s=request.getParameter(s1); if(s==null) s="";
   String s3="p_item",s4=request.getParameter(s3); if(s4==null) s4="";
%>
<frameset cols="250,*" frameborder="no" border="0" framespacing="0" >
<s:url id="url"  action="uSystemAction"   method="orgList4employee" namespace="/system"></s:url>
<s:url id="url2" action="getEmployeeList" namespace="/mng/employee"></s:url>
<s:set name="org">
	<s:if test="${org=='local'}">
    	<frame src="<s:text name="%{url}"/>" name="left" scrolling="Auto" noresize>
	</s:if>   
    <s:else>
    	<frame src="orgtreeAll.jsp<%="?"+s1+"="+s%><%="&"+s3+"="+s4 %>" name="left" scrolling="Auto" noresize>
    </s:else>
</s:set>
    <frame src="<s:text name="%{url2}"/>"  name="main"> <!-- main -->
</frameset>
<noframes><body>
对不起，您的浏览器不支持框架。请采用IE6.0以上版本浏览器进行浏览......
</body></noframes>
</HTML>