<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑内控分类</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css" />
	</head>
	<body onload="fillData()">
		<table id="ceShiTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
			<tr>
				<td class="ListTableTr11">
					名称：
				</td>
				<td class="ListTableTr22">
					<input id="name" type="text" />
				</td>
			</tr>
		</table>
		<div align="right" style="width: 97%">
			<input type="button" value="确定" onclick="queding()" />
			<input type="button" value="取消" onclick="quxiao()" />
		</div>
		<script type="text/javascript">
			
			function quxiao(){
				window.close();
			}
			
			function queding(){
				var newName = document.getElementById('name').value;
				window.returnValue = newName;
				window.close();
			}
			
			function fillData(){
				var pwindow = window.dialogArguments;
				var pName = pwindow.document.getElementById('name').value;
				if(pName!=null && pName!=''){
					document.getElementById('name').value = pName;
				}
			}
			
		</script>
	</body>
</html>
