<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*"%>
<html>
<head>
	<meta charset="utf-8">
	<title>系统版本</title>
	<style>
		.valuecol {
			padding-left: 20px;
			font-weight: bold;
		}
		.keycol {
			width: 120px;
			font-weight: bold;
		}
	</style>
</head>
<body>
    <div style="height: 12px;">&nbsp;</div>
	<table border="0">
	<tr>
	  <td class="keycol">系统版本</td><td class="valuecol">V7.0</td>
	</tr>
	<tr>
	  <td class="keycol">版本日期</td><td class="valuecol"><%
		Properties p = new Properties();
		try {
			p.load(this.getClass().getResourceAsStream("/touch.properties"));
			String versiondate = p.getProperty("versiondate");
			versiondate = versiondate.substring(0, 10);
			out.println(versiondate);
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	  %></td>
	</tr>
	<tr>
	  <td class="keycol">版权所有</td><td class="valuecol">北京用友审计软件有限公司</td>
	</tr>
	<tr>
	  <td class="keycol">服务热线</td><td class="valuecol">400-690-5610</td>
	</tr>
	<tr>
	  <td class="keycol">官方网站</td><td class="valuecol"><a href="https://www.yonyouaud.com" target="_blank">www.yonyouaud.com</a></td>
	</tr>
	</table>
</body>
</html>