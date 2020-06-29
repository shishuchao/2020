<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>内控测评</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css" />
		<s:head theme="ajax" />
	</head>
	<body>
		<center>
			<s:tabbedPanel id="nkcpTabPanel" theme='ajax' selectedTab="${param.selectedTab}">
				<s:div id='nkdcTab' label='内控调查' theme='ajax'>
					<div align="center">
						<iframe id="nkdcFrame"
							src="${contextPath}/nkcp/template/listDiaoCha.action?categoryId=<s:property value="categoryId" />"
							frameborder="0" width="100%" height="400px"></iframe>
					</div>
				</s:div>
				<s:div id='nkcsTab' label='内控测试' theme='ajax'>
					<div align="center">
						<iframe id="nkcsFrame"
							src="${contextPath}/nkcp/template/listCeShi.action?categoryId=<s:property value="categoryId" />"
							frameborder="0" width="100%" height="400px"></iframe>
					</div>
				</s:div>
			</s:tabbedPanel>
		</center>
	</body>
</html>