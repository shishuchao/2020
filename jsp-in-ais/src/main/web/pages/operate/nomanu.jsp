<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>信息提示</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/ueditor/ueditor.all.js"></script>
	</head>
	<body>
		<table width="100%" height="100%">
			<tr>
				<td align="center">
					<font size="4" color='#1b6252'>无权查看此底稿或者已经被删除</font>
				</td>
			</tr>
		</table>
	</body>
</html>
