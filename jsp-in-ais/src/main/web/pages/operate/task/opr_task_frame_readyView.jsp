<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<title>查看实施方案</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
</head>
<body class="easyui-layout" fit="true" border="0" style="padding:0px;margin:0px;overflow:hidden;">
	<div region="west" split="true"  border="0" style="width:350px;padding:0px;margin:0px;overflow:hidden;">
		<iframe name="f_left"  frameborder="0" scrolling="no" marginheight="0" style='height:100%;width:100%'
		src="${contextPath}/operate/task/showTreeListView.action?fromAdjust=${fromAdjust}&project_id=<%=request.getParameter("project_id")%>"></iframe>
	</div>
	<div region="center" border="0" style="padding:0px;margin:0px;overflow:hidden;">
		<iframe name="childBasefrm"  frameborder="0" scrolling="no" marginheight="0" style='height:100%;width:100%'
		src="${contextPath}/operate/task/showContentView.action?interCtrl=${interCtrl}&project_id=<%=request.getParameter("project_id")%>"></iframe>
	</div>
</body>
</html>

<!--  
<frameset rows="0,*" cols="*" frameborder="1" border="1" framespacing="1">
<s:hidden name="fromAdjust"></s:hidden>
  <frame src="showContentTop.action?fromAdjust={fromAdjust}&project_id=<%=request.getParameter("project_id")%>" name="topFrame" scrolling="NO" >
  <frameset id="sidebar_content" cols="400, *" frameborder="1" border="6" framespacing="5" bordercolor="#A1C7F9" style="overflow: auto;">
    <frame name="f_left" src="showTreeListView.action?fromAdjust=<%=request.getParameter("fromAdjust")%>&project_id=<%=request.getParameter("project_id")%>" scrolling="yes" frameborder="1" />
    <frame name="childBasefrm" src="showContentView.action?project_id=<%=request.getParameter("project_id")%>" frameborder="1" />
</frameset>
</frameset>
	
-->