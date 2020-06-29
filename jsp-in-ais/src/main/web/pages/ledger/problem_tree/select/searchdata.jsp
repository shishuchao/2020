<%@ page contentType="text/html; charset=utf-8"%>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>search</TITLE>
<link href="<%=request.getContextPath()%>/resources/css/site.css"
	rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<Script language=Javascript>
	function RefreshWin() {
		var url = "";
		var ay = getParameter(window.location.href);
		var dmethod = "list";
		var pItem = "";
		var orgType = "";
		var extend = "";
		for ( var i = 0; i < ay.length; i++) {
			if (ay[i].name.toLowerCase() == "url") {
				url = ay[i].value;
			}
			if (ay[i].name.toLowerCase() == "method") {
				dmethod = ay[i].value;
			}
			if (ay[i].name.toLowerCase() == "paraname") {
				document.all.paraName.value = ay[i].value;
			}
			if (ay[i].name.toLowerCase() == "paraid") {
				document.all.paraID.value = ay[i].value;
			}
			if (ay[i].name.toLowerCase() == "funname") {
				document.all.funname.value = ay[i].value;
			}
			if (ay[i].name.toLowerCase() == "p_item") {
				pItem = "&p_item=" + ay[i].value + "";
			}
			if (ay[i].name.toLowerCase() == "orgtype") {
				orgType = "&orgtype=" + ay[i].value + "";
			}
			if (ay[i].name.toLowerCase() == "urlpara") {
				var fun = ay[i].value;
				try {
					extend = eval("window.parent." + fun + "()");
				} catch (e) {
				}
			}
		}
		document.all.selectspace.src = url + "?method=" + dmethod + pItem
				+ orgType + extend;
	}

	function GetParamater() {
		if (selectspace.document.all("paranamevalue") != null
				&& selectspace.document.all("paraidvalue") != null) {
			var namevalue = selectspace.document.all("paranamevalue").value;
			var idvalue = selectspace.document.all("paraidvalue").value;
			var fun = document.all.funname.value;
			var paraname = document.all.paraName.value;
			var paraid = document.all.paraID.value;
			var win = window.parent;
			if (idvalue.indexOf(",") > 0) {
				alert("选取的数据只能选择一行！");
				return;
			}
			if (win.document.all(paraname) == null) {
				alert("数据项名称未找到或不正确，请检查程序！");
			} else {
				if (namevalue == "") {
					alert("请选择要操作的数据！");
				} else {
					win.document.all(paraname).value = namevalue;
					win.document.all(paraid).value = idvalue;
					try {
						if (win.document.all(paraname).type != "hidden") {
							//focus()
							win.document.all(paraname).focus();
							//blur()
							win.document.all(paraname).blur();
						}
					} catch (e) {
					}

					if (fun != "") {
						win.execScript(fun, "javascript");
					}
					//window.close();
					window.parent.hidePopWin(false);
				}
			}
		} else {
			alert("无法获取到有效参数!");
		}

	}
	function doClear() {
		var win = window.parent;
		try {
			win.document.all('ledgerProblem.problem_code').value = "";
			win.document.all('ledgerProblem.problem_name').value = "";
		} catch (e) {
		}
		try {
			win.document.all('middleLedgerProblem.problem_code').value = "";
			win.document.all('middleLedgerProblem.problem_name').value = "";
			win.document.all('middleLedgerProblem.sort_small_code').value = "";
			win.document.all('middleLedgerProblem.sort_small_name').value = "";
			win.document.all('middleLedgerProblem.sort_big_code').value = "";
			win.document.all('middleLedgerProblem.sort_big_name').value = "";
		} catch (e) {
		}
		window.parent.hidePopWin(false);
	}
</Script>
</HEAD>

<BODY bgcolor="#DEE7FF" topmargin=8 leftmargin=8 onload="RefreshWin();">

	<table border=0 cellspacing=0 cellpadding=0 width=99% align=center>
		<tr>
			<td align=center><iframe id="selectspace" src="" frameborder=0
					width="100%" scrolling="auto" onload="doAutoHeight()"></iframe></td>
		</tr>
		<tr>
			<td height=10 nowrap></td>
		</tr>
		<tr>
			<td align=right>
				<table border=0 align="left" cellspacing=1 cellpadding=1 width=95%>
					<tr height="10">
						<td width=60%>
						<td>
							<div id="select" class="imgbtn"
								Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif"
								Background="#D2E9FF" Text="确定" onclick="GetParamater()"></div>
						</td>
						<td width=10 nowrap></td>
						<td>
							<div id="cancel1" class="imgbtn"
								Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif"
								Background="#D2E9FF" Text="取消"
								onclick="window.parent.hidePopWin(false);"></div>
						</td>
						<td width=10 nowrap></td>
						<td>
							<div id="clear" class="imgbtn"
								Imgsrc="<%=request.getContextPath()%>/resources/images/clear.gif"
								Background="#D2E9FF" Text="清空" onclick="doClear();"></div>

						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<!--数据存储位置--> <input type="hidden" id="paraName"> <input
				type="hidden" id="paraID"> <input type="hidden" id="funname">
			</td>
		</tr>
	</table>
	<script language="javascript">
		function doAutoHeight() {
			var height = document.body.clientHeight;
			document.all.selectspace.style.height = height - 60;
		}
	</script>
</BODY>
</HTML>