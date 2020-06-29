<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>系统初始化（仅在系统实施时使用）</title>
	</head>

	<style>
		input{border:1px double #7F9DB9;}
		textarea{border:1px double #7F9DB9;}
	</style>

		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/blue/ufaud.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/displaytag/maven-base.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/displaytag/maven-theme.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/displaytag/site.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/displaytag/screen.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/displaytag/print.css"
			rel="stylesheet" type="text/css">
			
			
			
<script>
	function upload(){
		window.location="${contextPath}/commons/backup/upload.action";
	}
	function backup(){
		window.location="${contextPath}/commons/backup/backup.action";
	}
</script>

<body>
<center>
			<s:text id="title" name="'系统初始化（仅在系统实施时使用）'"></s:text>

			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
		<br><br><br><br><br>
			
		<s:button value="导出基本信息" onclick="backup();"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<s:button value="导入基本信息" onclick="upload();"/>
</center>
</body>
</html>