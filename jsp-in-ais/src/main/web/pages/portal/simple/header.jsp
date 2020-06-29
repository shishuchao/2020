<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="ais.framework.util.MyProperty"%>
<style type="text/css">
#header_default{
	width:100%;border:0;padding:0;height: 53px;
	background-image: url("${contextPath}/images/portal/headPicMiddle.jpg");
	background-repeat: repeat-x;
	margin:0;
	display: inline;
	display:block;
}
#header_left{
	width:500px;float:left;margin:0;border:0;height: 53px;
	background-image: url("${contextPath}/images/portal/headPicLeft.jpg");
	background-repeat: no-repeat;
	margin:0;
	display: inline;
}
#header_right{
	width:200px;float:right;border:0;height: 53px;
	background-image: url("${contextPath}/images/portal/headPicRight.jpg");
	background-repeat: no-repeat;
	margin:0;
	display: inline;
}
</style>
<div id="header_default" style="display:block">
  <div id="header_left"></div>      
  <div id="header_right"></div>        
</div>
