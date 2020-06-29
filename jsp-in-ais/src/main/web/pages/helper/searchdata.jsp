<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
<TITLE>search</TITLE>
<link href="<%=request.getContextPath()%>/css/site.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<Script language=Javascript>
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
     document.all.paraName.value=ay[i].value;
   }
   if (ay[i].name.toLowerCase()=="paraid")
   {
     document.all.paraID.value=ay[i].value;
   }
     if (ay[i].name.toLowerCase()=="funname")
   {
     document.all.funname.value=ay[i].value;
   }
}
document.all.selectspace.src=url+"?method="+dmethod+extend;
}

function GetParamater()
{
    if (selectspace.actioncument.all("paranamevalue")!=null&&selectspace.actioncument.all("paraidvalue")!=null)
	{
	          var namevalue=selectspace.actioncument.all("paranamevalue").value;
		  var idvalue=selectspace.actioncument.all("paraidvalue").value;
                  var fun=document.all.funname.value;
		  var paraname=document.all.paraName.value;
		  var paraid=document.all.paraID.value;
		  var win=window.parent;
                 if (idvalue.indexOf(",") > 0){
                    alert("选取的数据只能选择一行！");
                    return ;
                  }
                 if (win.actioncument.all(paraname)==null)
		  {
		     alert("数据项名称未找到或不正确，请检查程序！");
		  }
		  else
		  {
                  if (namevalue=="")
                  {
                     alert("请选择要操作的数据！");
                  }
                  else
                  {
                   win.actioncument.all(paraname).value=namevalue;
		   win.actioncument.all(paraid).value=idvalue;
                  try{
                  if (win.actioncument.all(paraname).type!="hidden")
                  {
                   //focus()
                  win.actioncument.all(paraname).focus();
                   //blur()
                  win.actioncument.all(paraname).blur();
                  }
                  }
                  catch(e)
                  {}

                  if (fun!="")
                  {
                    win.execScript(fun,"javascript");
                  }
                  //window.close();
                  window.parent.hidePopWin(false);
                  }
                  }
	}
	else
	{
	  alert("无法获取到有效参数!");
	}

}
function doClear(){
var paraname=document.all.paraName.value;
		  var paraid=document.all.paraID.value;
		  var win=window.parent;
		  if (win.actioncument.all(paraname)==null)
		  {
		     alert("数据项名称未找到或不正确，请检查程序！");
		  }
		  else
		  {
win.actioncument.all(paraid).value="";
win.actioncument.all(paraname).value="";
window.parent.hidePopWin(false);
}
}
</Script>
</HEAD>

<BODY bgcolor="#DEE7FF" topmargin=8 leftmargin=8 onload="RefreshWin();">

<table border=0 cellspacing=0 cellpadding=0 width=99% align=center>
<tr><td align=center>
<iframe id="selectspace" src="" frameborder=0 width="100%" height="400"></iframe>
</td></tr>
<tr><td height=10 nowrap></td></tr>
<tr><td align=right>
<table border=0 cellspacing=1 cellpadding=1 width=95%>
<tr>
<td width=60%>
<td>
<div id="select" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/images/save.gif" Background="#D2E9FF" Text="保存" onclick="GetParamater()"></div>
</td>
<td width=10 nowrap></td>
<td>
<div id="cancel1" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/images/cancel.gif" Background="#D2E9FF" Text="取消" onclick="window.parent.hidePopWin(false);"></div>
</td>
<td width=10 nowrap></td>
<td>
<div id="clear" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/images/clear.gif"
									Background="#D2E9FF" Text="清空"
									onclick="doClear();"></div>
						
</td>
</tr>
</table>
</td></tr>
<tr><td>
<!--数据存储位置-->
<input type="hidden" id="paraName">
<input type="hidden" id="paraID">
<input type="hidden" id="funname">
</td></tr>
</table>
</BODY>
</HTML>
