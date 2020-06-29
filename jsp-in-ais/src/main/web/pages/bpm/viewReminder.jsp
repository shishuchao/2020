<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>系统催办</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript">
		function PopWin(url,name)
		{
			window.open(url,name,"height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		} 
		</SCRIPT>
	</head>
	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/bpm/reminder/list.action')"/>
					</td>
				</tr>
			</table>

			<display:table id="row" name="reminderList" pagesize="10" class="its"
				requestURI="${contextPath}/bpm/reminder/list.action">
				<display:column title="信息" property="description" sortable="true" headerClass="center" class="center"/>
				<display:column title="处理" headerClass="center" class="center">
					<a href="javascript:void(0);"
						onclick="PopWin('${contextPath}${row.editUrl}','${row.id}')">执行</a>
				</display:column>
			</display:table>
		</center>
	</body>
</html>
