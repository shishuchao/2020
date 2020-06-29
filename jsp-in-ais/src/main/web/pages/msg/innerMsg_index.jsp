<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>
 <head>
	<title> 消息列表 </title>
	<meta http-equiv="X-UA-Compatible" content="IE=5">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/styles/main/ais.css"
				rel="stylesheet" type="text/css">
	<style type="text/css">
		#container{
		width:100%;height: 97%;
		}
		#content{
		width: 15%;text-align: left;float: left;height: 100%;
		}
		#sidebar{
		width: 85%;text-align: left;float: right;height: 100%;
		}
	</style>			
</head>
<body> 
	<table style="padding: 0;border-spacing: 0;border-collapse: 0;width:97%;margin: 0;">
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				消息中心
			</td>
		</tr>
	</table>
	<div style="height: 91%;padding: 0;margin: 0; border: 0;width:100%;">
		<div id="content">
			<iframe name="left" scrolling="Auto" noresize src="<%=request.getContextPath()%>/msg/innerMsg_tree.action" width="100%" height="100%" frameborder="0" ></iframe>
		</div>
		<div id="sidebar">
			<iframe name="childBasefrm" title="未读消息" src="<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=2" width="100%" height="100%" frameborder="0"><!-- main --></iframe>
		</div>
	</div>
</body>
</HTML>
