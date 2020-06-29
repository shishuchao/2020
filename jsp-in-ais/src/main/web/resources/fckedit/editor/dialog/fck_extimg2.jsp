<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script type="text/javascript">
	<%if(request.getAttribute("message")!=null){%>
		<%=request.getAttribute("message")%>
	<%}%>
		//parent.document.getElementsByName('imgUrl')[0].value=xxx;
	</script>
	</head>
	<body style="overflow: hidden" marginheight="0" bgcolor="#F1F1E3">
		<div style="width: 100%">
			<form action="/ais/portal/simple/portalImgFileAction!saveImg.action"
				enctype="multipart/form-data" method="post" name="myform"
				style="width: 100%">
				<table cellspacing="0" cellpadding="0" width="100%"
					style="width: 100%;height: 100%" border="0" align="left">
					<tr>
						<td width="100%" align="left" valign="top">
							<input type="file" id="uploadImg" name="uploadImg" size="35"
								value="" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
