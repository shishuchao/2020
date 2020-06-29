<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script language="javascript">
		
			function RefreshWin()
			{
				var url="";
				var ay=getParameter(window.location.href);
				for (var i=0;i<ay.length;i++){
					if (ay[i].name.toLowerCase()=="url"){
						url=ay[i].value;
					}
					if (ay[i].name.toLowerCase()=="paraname"){
						document.all.paraName.value=ay[i].value;
					}
					if (ay[i].name.toLowerCase()=="paraid"){
						document.all.paraID.value=ay[i].value;
					}
					 if (ay[i].name.toLowerCase()=="funname"){
					     document.all.funname.value=ay[i].value;
					 }
				}
				document.all.selectspace.src=url;
				
			}
			
			function GetParamater(){
				if (selectspace.document.all("paranamevalue")!=null&&selectspace.document.all("paraidvalue")!=null){
					selectspace.getSelectedValue();
				    var namevalue=selectspace.document.all("paranamevalue").value;
					var idvalue=selectspace.document.all("paraidvalue").value;
					var paraname=document.all.paraName.value;
					var paraid=document.all.paraID.value;
	                var fun=document.all.funname.value;
					var win=window.parent;
			        if (win.document.all(paraname)==null){
			        	alert("数据项名称未找到或不正确，请检查程序！");
			        }else{
			        	if (namevalue==""){
			        		alert("请选择要操作的数据！");
			        	}else{
			        		win.document.all(paraname).value=namevalue;
			        		win.document.all(paraid).value=idvalue;
			        		try{
			        			if (win.document.all(paraname).type!="hidden"){
			        				win.document.all(paraname).focus();
			        				win.document.all(paraname).blur();
			        			}
			        			if (fun!=""){
			                       win.execScript(fun,"javascript");
			                    }
			        		}catch(e){
			        		}
			        		doClose();
			        	}
			        }
				}else{
					alert("无法获取到有效参数!");
				}
			}
			
			function doClose(){
				window.parent.hidePopWin(false);
			}
			
			function doClear(){
				var paraname=document.all.paraName.value;
				var paraid=document.all.paraID.value;
				var win=window.parent;
				if (win.document.all(paraname)==null){
					alert("数据项名称未找到或不正确，请检查程序！");
				}else{
					win.document.all(paraid).value="";
					win.document.all(paraname).value="";
					doClose();
				}
			}
			function doAutoHeight() {
				var height = document.body.clientHeight;
			    document.all.selectspace.style.height = height-60;
			   }
		</Script>
	</HEAD>

	<BODY bgcolor="#DEE7FF" topmargin=8 leftmargin=8 onload="RefreshWin();">

		<table border=0 cellspacing=0 cellpadding=0 width=99% align=center>
			<tr>
				<td align=center>
					<iframe id="selectspace" src="" frameborder=0 width="100%"
						onload="doAutoHeight()"></iframe>
				</td>
			</tr>
			<tr>
				<td height=10 nowrap></td>
			</tr>
			<tr>
				<td align=right>
					<table border=0 cellspacing=1 cellpadding=1 width=95%>
						<tr>
							<td width=60%>
							<td>
								<div id="select" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif"
									Background="#D2E9FF" Text="保存" onclick="GetParamater()"></div>
							</td>
							<td width=10 nowrap></td>
							<td>
								<div id="cancel1" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif"
									Background="#D2E9FF" Text="取消" onclick="doClose()"></div>
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
					<!--数据存储位置-->
					<input type="hidden" id="paraName">
					<input type="hidden" id="paraID">
					<input type="hidden" id="funname">
				</td>
			</tr>
		</table>
	</BODY>
</HTML>
