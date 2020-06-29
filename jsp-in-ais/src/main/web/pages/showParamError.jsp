<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<title>非法参数提示</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=basePath%>pages/introcontrol/util/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>pages/introcontrol/util/themes/icon.css">
<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>

</head>
<body>
<div class="easyui-panel" title="请求的URL中有有非法的参数" border="0">
	<div style="padding:10px 20px 20px 50px; font-size:14px; border:1px solid #cccccc; border-top-width:0px; text-align:left; line-height:20px;">
		<li>一般含有这些的字符的参数为非法参数：<pre>< > * ( ) $ \ ' " &lt;script &lt;SCRIPT</pre></li>
		<textarea style="font-size:15px;border:0px;color:red; width:100%;overflow:hidden;" readonly>${errorMsg}</textarea>
	</div>
	<div style="text-align:right;padding:10px;">
		<button class="easyui-linkbutton"  iconCls="icon-ok" onclick="history.go(-1);">返回</button>
	</div>

</div>
<!-- End Save for Web Slices -->
</body>
</html>

