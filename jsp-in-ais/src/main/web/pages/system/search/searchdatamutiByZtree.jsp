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
   //如果对于参数名称，需要特殊显示，可以 设置参数名称为displayparaname
   if (ay[i].name.toLowerCase()=="displayparaname")
   {
     document.all.displayparaName.value=ay[i].value;
   }
    if (ay[i].name.toLowerCase()=="displayparaid")
   {
     document.all.displayparaId.value=ay[i].value;
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
//document.all.selectspace.src=url;
}

function GetParamater()
{
	
    if (selectspace.document.all("paranamevalue")!=null&&selectspace.document.all("paraidvalue")!=null)
	{
			selectspace.getSelectedValue();
	          var namevalue=selectspace.document.all("paranamevalue").value;
		  var idvalue=selectspace.document.all("paraidvalue").value;
		  var displaynamevalue=selectspace.document.all("displayparanamevalue").value;
		  var displayidvalue=selectspace.document.all("displayparaidvalue").value;
                  var fun=document.all.funname.value;
		  var paraname=document.all.paraName.value;
		  var displayparaname=document.all.displayparaName.value;
		   var displayparaid=document.all.displayparaId.value;
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
                   
		   		if(idvalue!=null && idvalue!=''){
		   				if(idvalue.length>2000){  //id值超过数据库最大限制，则无法保存
							alert("您所选择的数据长度超过限制,请重新选择");
							return false ;
						}else{
							win.document.all(paraname).value=namevalue;
							//win.document.all(displayparaname).value=displaynamevalue;
							//.document.all(displayparaid).value=displayidvalue;
							win.document.all(paraid).value=idvalue;
						}
		   		}else{
		   			win.document.all(paraname).value=namevalue;
		   			//win.document.all(displayparaname).value=displaynamevalue;
		   			//win.document.all(displayparaid).value=displayidvalue;
		   			win.document.all(paraid).value=idvalue;
		   		}
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
		  var paraname=document.all.paraName.value; 
		  var displayparaname=document.all.displayparaName.value; 
		  var displayparaid=document.all.displayparaId.value;
		  var win=window.parent;
		  if (win.document.all(paraname)==null) {
		     alert("数据项名称未找到或不正确，请检查程序！");
		  } else {
				win.document.all(paraid).value="";
				win.document.all(paraname).value="";
				win.document.all(displayparaname).value="";
				win.document.all(displayparaid).value="";
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
<div id="select" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif" Background="#D2E9FF" Text="确定" onclick="GetParamater()"></div>
</td>
<td width=10 nowrap></td>
<td>
<div id="cancel1" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif" Background="#D2E9FF" Text="取消" onclick="doClose()"></div>
</td>
<td width=10 nowrap></td>
<td>
<div id="clear" class="imgbtn"
									Imgsrc="<%=request.getContextPath()%>/resources/images/clear.gif"
									Background="#D2E9FF" Text="清空"
									onclick="doClear();"></div>
						
</td>
</tr>
</table>
</td></tr>
<tr><td>
<!--数据存储位置-->
<input type="hidden" id="paraName">
<input type="hidden" id="displayparaName">
<input type="hidden" id="displayparaId">
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