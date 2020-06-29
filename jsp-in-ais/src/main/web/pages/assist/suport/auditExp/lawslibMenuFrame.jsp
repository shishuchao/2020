<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="<%=request.getContextPath()%>/styles/main/ais.css"
			rel="stylesheet" type="text/css">
<style type="text/css"> 
	#container{
		width:100%;height: 90%;
	}
	#content{
		width: 20%;text-align: left;float: left;height: 100%;
	}
	#sidebar{
		width: 80%;text-align: left;float: right;height: 100%;
	}
</style>
</head>
	<table style="padding: 0;border-spacing: 0;border-collapse: 0;">
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				 <s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/pages/assist/suport/auditExp/lawslibMenuFrame.jsp')"/> 
			</td>
		</tr>
	</table>
<div id="container">
  <div id="content">
	<iframe name="f_left" width="100%" frameborder="0" height="98%" src="../lawsLib/treeMenu.action?mCodeType=sjjy"></iframe>
  </div>
  <div id="sidebar">
	<iframe name="childBasefrm" width="100%" frameborder="0" height="98%" src="<%=request.getContextPath()%>/pages/assist/suport/lawsLib/tishi.jsp" ></iframe>
  </div>
</div>
</html>