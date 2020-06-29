<%@ page contentType="text/html; charset=utf-8"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<TITLE>数据快速选取界面</TITLE>
		<link href="${pageContext.request.contextPath}/resources/css/site.css" rel="stylesheet" type="text/css">
		<script src="${pageContext.request.contextPath}/resources/js/common.js" type="text/javascript"></script>
		<script language="JavaScript">
		
function liftSize(){
	if (document.all.multi.style.display == "none"){
		document.all.multi.style.display = "";
		document.all.back1.style.display = "";
		document.all.back2.style.display = "none";
		document.all.workspace.height = "240";
	}else{
		document.all.multi.style.display = "none";
		document.all.back1.style.display = "none";
		document.all.back2.style.display = "";
		document.all.workspace.height = "450";
	}
}

function RefreshWin(){
	var url = "";
	var audobjid = "";
	var ay = getParameter(window.location.href);
	for(var i=0; i<ay.length; i++){
		if (ay[i].name.toLowerCase() == "url"){
			url = ay[i].value;
		}
		if (ay[i].name.toLowerCase() == "paraname"){
			workspace.document.all.paraName.value = ay[i].value;
		}
		if (ay[i].name.toLowerCase() == "paraid"){
			workspace.document.all.paraID.value = ay[i].value;
		}
		if (ay[i].name.toLowerCase() == "audobjid"){
			audobjid = ay[i].value;
		}
	}
	workspace.initData();
	document.all.multi.src = url + "?audobjid=" + audobjid;
}

function doClose(){
	window.parent.hidePopWin(false);
}

		</script>
	</head>
	<body topmargin=10 leftmargin=10 onload="javascript:RefreshWin()">
		<table border=0 cellspacing=0 cellpadding=0 width=100%>
			<tr>
				<td>
					<iframe name="multi" id="multi" src="" frameborder="0" scrolling="auto" width="100%" height="250"></iframe>
				</td>
			</tr>
			<tr>
				<td height="5">&nbsp;</td>
			</tr>
			<tr>
				<td align="left">
					<table border=0 cellspacing=0 cellpadding=0 width=30%>
						<tr>
							<td align="left">
								<div id="select" class="imgbtn"
									Imgsrc="${pageContext.request.contextPath}/resources/images/save.gif"
									Background="#D2E9FF" Text="选取"
									onclick="workspace.getSelected()"></div>
							</td>
							<td>&nbsp;</td>
							<td align="left">
								<div id="save" class="imgbtn"
									Imgsrc="${pageContext.request.contextPath}/resources/images/save.gif"
									Background="#D2E9FF" Text="保存"
									onclick="workspace.GetParamater();"></div>
							</td>
							<td>&nbsp;</td>
							<td align="left">
								<div id="close" class="imgbtn"
									Imgsrc="${pageContext.request.contextPath}/resources/images/cancel.gif"
									Background="#D2E9FF" Text="取消" onclick="doClose()"></div>
							</td>
							<td>&nbsp;</td>
							<td align="left">
								<div id="clear" class="imgbtn"
									Imgsrc="${pageContext.request.contextPath}/resources/images/clear.gif"
									Background="#D2E9FF" Text="清空"
									onclick="workspace.doClear();"></div>
							</td>
							<td>&nbsp;</td>
							<td align="left">
								<div id="back1" class="imgbtn"
									Imgsrc="${pageContext.request.contextPath}/resources/images/save.gif"
									Background="#D2E9FF" Text="隐藏" onClick="liftSize()"></div>
								<div id="back2" style="display: none;" class="imgbtn"
									Imgsrc="${pageContext.request.contextPath}/resources/images/save.gif"
									Background="#D2E9FF" Text="显示" onClick="liftSize()"></div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="5">&nbsp;</td>
			</tr>
			<tr>
				<td>
					<table border=0 cellspacing=0 cellpadding=0 width=100%>
						<tr valign="top">
							<td>
								<iframe name="workspace" id="workspace" src="mutispace.jsp" frameborder="1" scrolling="auto" width="100%" height="125"></iframe>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
