<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>


<html>
	<base target="_self">
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>上传附件---工作底稿</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	</head>

	<body>

		<s:form action="saveFile" method="POST" namespace="/commons/file"
			enctype="multipart/form-data">
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;上传底稿
					</td>
				</tr>
				<tr class="listtablehead">
					<td class="listtabletr2" align="right">
						<s:fielderror />
						<s:file label="上传附件" name="myfile" size="96%" />
						<s:hidden name="remark" value="%{#session.user['fname']}" />
						<input type="hidden" name="guid"
							value="<s:property value="#parameters.guid" />" />
						<input type="hidden" name="appType"
							value="<s:property value="#parameters.appType" />" />
						<input type="hidden" name="uploadPermission"
							value="<s:property value="#parameters.uploadPermission" />" />
						<input type="hidden" name="deletePermission"
							value="<s:property value="#parameters.deletePermission" />" />
						<input type="hidden" name="isEdit"
							value="<s:property value="#parameters.isEdit" />" />
						<input type="hidden" name="isEdit2"
							value="<s:property value="#parameters.isEdit2" />" />
						<input type="hidden" name="reload"
							value="<s:property value="#parameters.reload" />" />
						<input type="hidden" name="project_id"
							value="<s:property value="#parameters.project_id" />
						" />
					</td>
				</tr>
			</table>
			<center>
				<s:submit value="提交" />
				<input type="button" value="关闭" onclick="window.close();">
			</center>
		</s:form>
	</body>
</html>

