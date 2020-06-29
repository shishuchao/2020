<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<title>审计方案库内容查看 </title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
</head>
<body class="easyui-layout" fit="true" border="0" style="padding:0px;margin:0px;overflow:hidden;">
	<div region="west" split="true"  border="0" style="width:300px;padding:0px;margin:0px;overflow:hidden;">
		<iframe name="f_left"  frameborder="0" scrolling="no" marginheight="0" style='height:100%;width:100%'
		src="${contextPath}/operate/template/showTreeListView.action?interCtrl=${interCtrl}&audTemplateId=<%=request.getParameter("audTemplateId")%>"></iframe>
	</div>
	<div region="center" border="0" style="padding:0px;margin:0px;overflow:hidden;">
		<iframe name="childBasefrm"  frameborder="0" scrolling="no" marginheight="0" style='height:100%;width:100%'
		src="${contextPath}/operate/template/showContentView.action?interCtrl=${interCtrl}&selectedTab=main&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>"></iframe>
	</div>
</body>
</html>


<!-- 
<frameset rows="0,*" cols="*" frameborder="1" border="6" framespacing="1" bordercolor="#A1C7F9">
  <frame src="<%=request.getContextPath()%>/pages/operate/template/opr_template_top.jsp" name="topFrame" scrolling="NO">
  <frameset id="sidebar_content" cols="400, *" frameborder="1" border="6" framespacing="5" bordercolor="#A1C7F9">
    <frame name="f_left" src="showTreeListView.action?audTemplateId=<%=request.getParameter("audTemplateId")%>" scrolling="yes" frameborder="1" />
    <frame name="childBasefrm" src="showContentView.action?selectedTab=main&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>" frameborder="1" />
  </frameset>
</frameset>
 -->