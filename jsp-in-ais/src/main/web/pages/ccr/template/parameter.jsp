<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<html>
	<head>
		<title>模板参数设置</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">

		<s:head theme="ajax" />
		<style type="text/css">
			#tow {
				width: 100%;
				height: 560px;
			}
		</style>
	</head>
	<body>
		<s:tabbedPanel id="setParam" theme="ajax" cssStyle="height:100%;">
			<s:div id='one' label='公式' theme='ajax' >
				<iframe id="formula" width="100%"
	frameborder="0" height="600px" src="${contextPath }/ccrFormula/tree4Celltemplate.action"></iframe>
	
			</s:div>
			<s:div id='three' label='系统基础信息' theme='ajax' >
				<iframe id="basicInfo" width="100%"
	frameborder="0" height="600px" src="${contextPath }/ccrTemplate/basicInfo.action"></iframe>
	</s:div>
			<s:div id="tow" label="汇总参数" theme="ajax">
				<iframe id="paramList" width="100%"
	frameborder="0" height="600px" src="${contextPath }/ccrTemplate/paramSeting.action?templateId=${templateId }&sheetIndex=0"></iframe>
			</s:div>
		</s:tabbedPanel>
	</body>
</html>
