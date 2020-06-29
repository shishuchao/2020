<%@ page contentType="text/html; charset=utf-8" %>
<HTML>
<HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>search</TITLE>
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<Script language=Javascript>
function RefreshWin()
{
	var url="";
	var extend="";
	
	var ay=getParameter(window.location.href);
	
	for (var i=0;i<ay.length;i++)
	{
	   if (ay[i].name.toLowerCase()=="url")
	   {
		 url=ay[i].value;
	
	         var u1=window.location.search;
	         var pos1=u1.indexOf("&");
	         if (pos1!=-1)
	         {
	             extend=u1.substring(pos1+1,u1.length);
	         }
	   }
	}
	document.all.selectspace.src=url+"?"+extend;
}

function doClose(){
	window.parent.hidePopWin(false);
}

</Script>
</HEAD>

<BODY bgcolor="#DEE7FF" topmargin=0 leftmargin=0 onload="RefreshWin();">

<table border=0 cellspacing=0 cellpadding=0 width=99% align=center>
<tr ><td align=center>
<iframe id="selectspace" src="" frameborder=0 width="100%"  scrolling="auto"  onload="doAutoHeight()"></iframe>
</td></tr>
<tr><td nowrap></td></tr>
<tr><td align=right>
<table border=0 cellspacing=1 cellpadding=1 width=95% height="10">
<tr>
<td width=60%>
<td>

</td>
<td width=10 nowrap></td>
<td align="right">
<div id="cancel1" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif" Background="#D2E9FF" Text="关闭" onclick="doClose()"></div>
</td>
<td width=10 nowrap></td>
<td>
</td>
</tr>
</table>
</td></tr>
<tr><td>

</td></tr>
</table>
<script language="javascript">
function doAutoHeight() {
	var height = document.body.clientHeight;
    document.all.selectspace.style.height = height-40;
   }
</script>
</BODY>
</HTML>