<%@ page contentType="text/html; charset=utf-8"%>

<html>
	<HEAD>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<TITLE>数据快速选取界面</TITLE>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/site.css">
		<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script language="JavaScript">
			function liftSize(){
			  if (document.all.multi.style.display=="none")
			  {
			      document.all.multi.style.display="";
			      document.all.back1.style.display="";
			      document.all.back2.style.display="none";
			      document.all.workspace.height="150";
			  }
			  else
			  {
			      document.all.multi.style.display="none";
			      document.all.back1.style.display="none";
			      document.all.back2.style.display="";
			     document.all.workspace.height=document.body.clientHeight-100;
			  }
			}
			function RefreshWin()
			{
			var url="";
			var ay=getParameter(window.location.href);
			var dmethod="list";
			var extend="";
			for (var i=0;i<ay.length;i++)
			{
			
			   if (ay[i].name.toLowerCase()=="url")
			   {
				 url=ay[i].value;
			
			         var u1=window.location.search;
			         var pos1=u1.indexOf("&");
			         if (pos1!=-1)
			         {
			           var pos2=u1.indexOf("&",pos1+1);
			           if (pos2!=-1)
			           {
			             extend=u1.substring(pos2,u1.length);
			           }
			         }
			   }
			   if (ay[i].name.toLowerCase()=="method")
			   {
			     dmethod=ay[i].value;
			   }
			
			   if (ay[i].name.toLowerCase()=="paraname")
			   {
			     workspace.document.all.paraName.value=ay[i].value;
			   }
			   if (ay[i].name.toLowerCase()=="paraid")
			   {
			     workspace.document.all.paraID.value=ay[i].value;
			   }
			     if (ay[i].name.toLowerCase()=="funname")
			   {
			     workspace.document.all.funname.value=ay[i].value;
			   }
			}
			workspace.initData();
			document.all.multi.src=url+"?method="+dmethod+extend;
			}
			function doClose(){
			//window.close();
			window.parent.hidePopWin(false);
			}
		</script>
	</head>
	<BODY bgcolor="#DEE7FF"  topmargin=10 leftmargin=10 onload="javascript:RefreshWin()">
		<table border=0 cellspacing=0 cellpadding=0 width=100%>
			<tr>
				<td>
					<iframe name="multi" id="multi" src="" frameborder="0"
						scrolling="auto" width="100%"  onload="document.all.multi.style.height = document.body.clientHeight-252;">
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
							<td width="200">
								&nbsp;
							</td>
							<td align="left">
								<a id="select" class="easyui-linkbutton" iconCls="icon-select" href="javascript:void(0)" onclick="workspace.getSelected()" title="选取挑选的数据到下边的选择框内">选定数据</a>
								<!-- <div id="select" class="imgbtn" title="选取挑选的数据到下边的选择框内"
									Imgsrc="<%=request.getContextPath()%>/resources/images/select.gif"
									Background="#D2E9FF" Text="选定数据"
									onclick="workspace.getSelected()">
								</div> -->
							</td>
							<td width="10">
								&nbsp;
							</td>
							<td align="left">
								<a id="back1" class="easyui-linkbutton" iconCls="icon-hidden" href="javascript:void(0)" onclick="liftSize()" title="隐藏上部的选单">隐藏选单</a>
								<a id="back2" class="easyui-linkbutton" iconCls="icon-show" href="javascript:void(0)" style="display: none;" onclick="liftSize()" title="显示上部的选单">显示选单</a>
								<!-- <div id="back1" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/hidden.gif"
									Background="#D2E9FF" Text="隐藏选单"  title="隐藏上部的选单" onClick="liftSize()"></div> -->
								<!-- <div id="back2" style="display: none;" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/show.gif"
									Background="#D2E9FF" Text="显示选单"   title="显示上部的选单"  onClick="liftSize()"></div> -->
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1px">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					<table border=0 cellspacing=0 cellpadding=0 width=100%>
						<tr valign="top">
							<td><% String id=request.getParameter("paraid"); String name=request.getParameter("paraName");%>
								<iframe name="workspace" id="workspace" 
								src="<%=request.getContextPath()%>/system/authAuthorityAction!role4users.action?roleId=<%=id%>&roleName=<%=name%>"
								frameborder="1" scrolling="auto" width="100%" height="100%"></iframe>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table border=0 cellspacing=0 cellpadding=0 width=100%  height="10">
						<tr>
							<td width="70%">
								&nbsp;
							</td>
							<td align="left">
								<a id="save" class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="workspace.GetParamater();" title="获得选择数据，并返回到主界面">确定</a>
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								<a id="close" class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="doClose()" title="取消选择数据，并返回到主界面">取消</a>
							</td>
							<td>
								&nbsp;
							</td>
							<td>
								<a id="clear" class="easyui-linkbutton" iconCls="icon-reload" href="javascript:void(0)" onclick="workspace.doClear();" title="清空主界面上已经获得的数据，并返回到主界面">清空</a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<script language="javascript">
			function doAutoHeight() {
				var height = document.body.clientHeight;
			    document.all.multi.style.height = height-252;
			}
		</script>
	</body>
</html>