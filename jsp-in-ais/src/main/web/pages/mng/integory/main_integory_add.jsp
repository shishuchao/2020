<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<s:text id="title" name="'中介机构库'"></s:text>
		<title><s:property value="#title" />
		</title>
		<s:head theme="ajax"/>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>
	<body topmargin="0" leftmargin="0">
		<center>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="100%">
					<s:tabbedPanel id='test' theme="ajax">
						<s:div id='one' label='基本信息' theme='ajax' >
							<iframe src="/ais/resmngt/integory/add_integoryinfo.action" frameborder="0" width="100%" height="500" ></iframe>
						</s:div>
					</s:tabbedPanel>
					</td>
				</tr>
			</table>
		</center>
	</body>