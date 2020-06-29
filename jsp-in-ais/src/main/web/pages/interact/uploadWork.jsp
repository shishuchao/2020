<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>


<html>
	<base target="_self">
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
			<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	
		<title>上传附件</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>

	<body>



		<!-- 附件上传的jsp注意!
     在upload.jsp中，先将表单的提交方式设为POST(method="POST")，
     然后将enctype设为multipart/form-data，这并没有什么特别之处 -->
		<s:form action="mutualToManage" method="POST" namespace="/interact/interactProxyToWork"
			enctype="multipart/form-data">

			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable" align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
						&nbsp;上传附件
					</td>
				</tr>
				<tr class="listtablehead">
					<td class="listtabletr2" align="right" >
						<s:file label="上传附件" name="myfile" size="50"/>
						&nbsp;
					</td>
				</tr>
				
			</table>

			<br>
			<div align="center">

				<s:submit name="上 传" value="上 传" />


			</div>
		
		</s:form>
	</body>
</html>


