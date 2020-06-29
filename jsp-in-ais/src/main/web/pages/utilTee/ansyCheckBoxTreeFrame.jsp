<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>公共多/单选树iframe(适用subModal.js)</title>
<link rel="stylesheet" href="<%=basePath%>pages/utilTee/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript" src="<%=basePath%>pages/utilTee/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>pages/utilTee/js/jquery.json-2.3.js"></script>
<script type="text/javascript"
	src="<%=basePath%>pages/utilTee/js/jquery.ztree.core-3.4.js"></script>
<script type="text/javascript"
	src="<%=basePath%>pages/utilTee/js/jquery.ztree.excheck-3.4.js"></script>
<link href="<%=basePath%>pages/utilTee/css/site.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
body {
	background-color: white;
}
</style>
<script language="javascript">
//名称id
var nameid = "<%=request.getParameter("nameid")%>";
//名称编码id
var codeid = "<%=request.getParameter("codeid")%>";
//点击确定后回调函数
var afterChecked = "<%=request.getParameter("afterChecked")%>";
//调用真实tree页面
var url = "<%=basePath%>pages/utilTee/ansyCheckBoxTree.jsp";

	var urlAction = location.search;

	$(function() {
		if ("" != urlAction) {
			url = url + urlAction;
		}

		$("#selectspace").attr("src", url);
	})

     //点击确定
	function getSelected() {
		$("#selectspace")[0].contentWindow.CheckedProblemType();
		
		if ("" != afterChecked && null != afterChecked) {
           $("#"+nameid, window.parent.document).after("<div id='doCallBack' style='display:none' onclick='"+afterChecked+"()' ></div>");
           $("#doCallBack", window.parent.document).trigger("click");
		}
		
	}

	function backValue(nameidVaule, codeidValue) {
		$("#" + nameid, window.parent.document).val(nameidVaule);
		$("#" + codeid, window.parent.document).val(codeidValue);
		window.parent.hidePopWin(false);
	}
	
	//点击清空
	function doClear(){
		$("#" + nameid, window.parent.document).val("");
		$("#" + codeid, window.parent.document).val("");
		window.parent.hidePopWin(false);
	}
</script>
</head>
<body style="background: #DEE7FF">
	<table border=0 cellspacing=0 cellpadding=0 width=100% align=center>
		<tr height='90%'>
			<td align=center height=380><iframe id="selectspace"
					frameborder=0 height="100%" width="100%" scrolling="auto"></iframe></td>
		</tr>
		<tr>
			<td height=10 nowrap></td>
		</tr>
		<tr width=100%>
			<td align=right>
				<table border=0 align="left" cellspacing=1 cellpadding=1 width=100%>
					<tr height="10">
						<td width=60%>
						<td>
							<div id="select" class="imgbtn"
								Imgsrc="<%=basePath%>resources/images/save.gif"
								Background="#D2E9FF" Text="确定" onclick="getSelected()"></div> <input
							type="hidden" id="nameid"> <input type="hidden"
							id="codeid">
						</td>
						<td width=10 nowrap></td>
						<td>
							<div id="cancel1" class="imgbtn"
								Imgsrc="<%=basePath%>resources/images/cancel.gif"
								Background="#D2E9FF" Text="取消"
								onclick="window.parent.hidePopWin(false);"></div>
						</td>
						<td width=10 nowrap></td>
						<td>
							<div id="clear" class="imgbtn"
								Imgsrc="<%=basePath%>resources/images/clear.gif"
								Background="#D2E9FF" Text="清空" onclick="doClear();"></div>

						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>