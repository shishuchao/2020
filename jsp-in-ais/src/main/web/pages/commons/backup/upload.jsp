<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>上传</title>
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
	function cancel(){
		window.location="${contextPath}/commons/backup/index.action";
	}	
</script>

<body>
<center>
			<s:text id="title" name="'上传基本信息文件'"></s:text>

			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
		<br><br><br><br><br>
	<s:form action="restore" method="POST" namespace="/commons/backup" enctype="multipart/form-data">
		<s:file name="zipFile" size="50" />&nbsp&nbsp
		<s:submit value="执行导入基本信息"/>&nbsp&nbsp
		<s:button value="取 消" onclick="cancel();"/>
	</s:form>
</center>	
</body>
</html>