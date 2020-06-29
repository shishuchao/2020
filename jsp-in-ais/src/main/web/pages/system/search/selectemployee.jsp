<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>数据快速选取界面</title>
		<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
		<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script language="javascript">
				
			function liftSize(){
				if (document.all.multi.style.display=="none"){
					document.all.multi.style.display="";
					document.all.back1.style.display="";
					document.all.back2.style.display="none";
					document.all.workspace.height="150";
				}else{
					document.all.multi.style.display="none";
					document.all.back1.style.display="none";
					document.all.back2.style.display="";
					document.all.workspace.height=document.body.clientHeight-100;
				}
			}
			
			function RefreshWin(){
				var url="";
				var ay=getParameter(window.location.href);
				var dmethod="list";
				var extend="";
				var org="";
				for (var i=0;i<ay.length;i++){
			   		if (ay[i].name.toLowerCase()=="url"){
				 		url=ay[i].value;
			         	var u1=window.location.search;
			         	var pos1=u1.indexOf("&");
			         	if (pos1!=-1){
			           		var pos2=u1.indexOf("&",pos1+1);
			           		if (pos2!=-1){
			            		extend=u1.substring(pos2,u1.length);
			           		}
			         	}
			   		}
					if (ay[i].name.toLowerCase()=="method"){
						dmethod=ay[i].value;
				    }
					if (ay[i].name.toLowerCase()=="paraname"){
						workspace.document.all.paraName.value=ay[i].value;
					}
					if (ay[i].name.toLowerCase()=="paraid"){
						workspace.document.all.paraID.value=ay[i].value;
					}
					if (ay[i].name.toLowerCase()=="funname"){
						workspace.document.all.funname.value=ay[i].value;
					}
					if (ay[i].name.toLowerCase()=="org"){
						org = ay[i].value;
					}
				}
				
				workspace.initData();
				document.all.multi.src=url+"?method="+dmethod+extend+"&org="+org;
			}
			
			function doClose(){
				window.parent.hidePopWin(false);
			}
			
			function doAutoHeight() {
				try{
					var height = document.body.clientHeight;
				    document.all.multi.style.height = height/2;//上下各一半高度
				}catch(e){}
			}
			
		</script>	
	</head>
	<body  bgcolor="#DEE7FF"  topmargin=10 leftmargin=10 onload="javascript:RefreshWin()">
		<table border=0 cellspacing=0 cellpadding=0 width=100% >
			<tr>
				<td>
					<iframe name="multi" id="multi" src="" frameborder="0"
						scrolling="auto" width="100%"  onload="doAutoHeight()">
					</iframe>
				</td>
			</tr>
			<tr>
				<td height="1">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					<table border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td align="left">
								<div id="select" class="imgbtn" title="选取挑选的数据到下边的选择框内"
									Imgsrc="<%=request.getContextPath()%>/resources/images/select.gif"
									Background="#D2E9FF" Text="选定数据"
									onclick="workspace.getSelected()" ></div>
							</td>
							<td width="5">
								&nbsp;
							</td>
							<td align="left">
								<div id="back1" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/hidden.gif"
									Background="#D2E9FF" Text="隐藏选单"  title="隐藏上部的选单" onClick="liftSize()"></div>
								<div id="back2" style="display: none;" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/show.gif"
									Background="#D2E9FF" Text="显示选单"   title="显示上部的选单"  onClick="liftSize()"></div>
							</td>
							<td width="5">
								&nbsp;
							</td>
							<td align="left">
							<div id="save" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif"
									Background="#D2E9FF" Text="确定"   title="获得选择数据，并返回到主界面" 
									onclick="workspace.GetParamater();"></div>
							</td>
							<td width="5">
								&nbsp;
							</td>
							<td align="left">
							<div id="close" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif"
									Background="#D2E9FF" Text="取消"   title="取消选择数据，并返回到主界面" onclick="doClose()"></div>
							</td>
							<td width="5">
								&nbsp;
							</td>
							<td align="left">
							<div id="clear" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/clear.gif"
									Background="#D2E9FF" Text="清空"   title="清空主界面上已经获得的数据，并返回到主界面"
									onclick="workspace.doClear();"></div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="0.5px">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					<table border=0 cellspacing=0 cellpadding=0 width=100% height="100">
						<tr>
							<td>
								<iframe name="workspace" id="workspace" src="mutispace.jsp"
									frameborder="1" scrolling="auto" width="100%" height="100"></iframe>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>