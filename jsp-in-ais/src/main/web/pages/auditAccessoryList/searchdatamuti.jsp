<%@ page contentType="text/html; charset=utf-8" %>
<HTML>
<HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>search</TITLE>
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<Script language=Javascript>
function RefreshWin()
{
var ay=getParameter(window.location.href);
var url="";
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
		extend=u1.substring(pos1+1,u1.length);
     }
   }
}
document.all.selectspace.src=url+"?"+extend;
}

function GetParamater()
{
	
    if (selectspace.document.all("paranamevalue")!=null&&selectspace.document.all("paraidvalue")!=null)
	{
			selectspace.getSelectedValue();
	          var namevalue=selectspace.document.all("paranamevalue").value;
		  var idvalue=selectspace.document.all("paraidvalue").value;
                  var fun=document.all.funname.value;
		  var paraname=document.all.paraName.value;
		  var paraid=document.all.paraID.value;
		  var win=window.parent;
                 

                 if (win.document.all(paraname)==null)
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
                   win.document.all(paraname).value=namevalue;
		   win.document.all(paraid).value=idvalue;
                  try{
                  if (win.document.all(paraname).type!="hidden")
                  {
                   //focus()
                  win.document.all(paraname).focus();
                   //blur()
                  win.document.all(paraname).blur();
                  }
                  }
                  catch(e)
                  {}

                  if (fun!="")
                  {
                    win.execScript(fun,"javascript");
                  }
                  
                  doClose()
                  }
                  }
	}
	else
	{
	  alert("无法获取到有效参数!");
	}

}
function doClose(){
//window.close();
window.parent.hidePopWin(false);
}
function doClear(){
var paraname=document.all.paraName.value;
		  var paraid=document.all.paraID.value;
		  var win=window.parent;
		  if (win.document.all(paraname)==null)
		  {
		     alert("数据项名称未找到或不正确，请检查程序！");
		  }
		  else
		  {
win.document.all(paraid).value="";
win.document.all(paraname).value="";
doClose();
}
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
<script language="javascript">
function doAutoHeight() {
	var height = document.body.clientHeight;
    document.all.selectspace.style.height = height-40;
   }
</script>
</BODY>
</HTML>