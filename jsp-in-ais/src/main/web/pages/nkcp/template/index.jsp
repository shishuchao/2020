<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
 		<title>内控调查模板</title>
 		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<style type="text/css">
			#container{
				width:100%;height: 90%;
			}
			#content{
				width: 25%;text-align: left;float: left;height: 100%;
			}
			#sidebar{
				width: 75%;text-align: left;float: right;height: 100%;
			}
		</style>			
	</head>
	<body>
		<center>
			<table style="padding: 0;border-spacing: 0;border-collapse: 0;width:98%;margin: 0;">
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/nkcp/template/index.action')"/>
					</td>
				</tr>
			</table>
			<div style="height: 91%;padding: 0;margin: 0; border: 0;width:98%;">
				<div id="content">
					<iframe name="left" scrolling="auto" noresize 
						src="/ais/nkcp/template/tree.action" 
						width="100%" height="500px" frameborder="0"
						style="margin: 0;padding:0"></iframe>
				</div>
				<div id="sidebar">
					<iframe name="childBasefrm" scrolling="auto" 
						src="/ais/blank.jsp" 
						width="100%" height="500px" frameborder="0"
						style="margin: 0;padding:0"></iframe>
				</div>
			</div>
		</center>
	</body>
</html>
