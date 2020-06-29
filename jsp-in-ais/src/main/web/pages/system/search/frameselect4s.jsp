<%@ page contentType="text/html; charset=utf-8" %>

<html>
<HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> 数据快速选取界面 </TITLE>
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
<script language="JavaScript">
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
   if (ay[i].name.toLowerCase()=="paraname2")
   {
     document.all.paraName2.value=ay[i].value;
   }
   if (ay[i].name.toLowerCase()=="paraid")
   {
     document.all.paraID.value=ay[i].value;
   }
   if (ay[i].name.toLowerCase()=="paraid2")
   {
     document.all.paraID2.value=ay[i].value;
   }
   if (ay[i].name.toLowerCase()=="funname")
   {
    document.all.funname.value=ay[i].value;
   }
}
document.all.multi.src=url+"?method="+dmethod+extend;
//document.all.multi.src=url;
//alert(document.all.multi.src);
}
function GetParamater()
{
		var rs=window.multi.main.getCheckValue();
		if(rs.indexOf(";")!=-1){
			alert("只能选择一项.");
			return(false);
		}
		var array=rs.split(",");
		var namevalue=array[2];
		var idvalue=array[1];
	    var fun=document.all.funname.value;
		var paraname=document.all.paraName.value;
		var paraid=document.all.paraID.value;

		if(array.length==5){//根据需求增加的两个属性
		    var namevalue2=array[3];
			var idvalue2=array[4];
			var paraname2=document.all.paraName2.value;
			var paraid2=document.all.paraID2.value;
		}	    
		var win=window.parent;
		  
        if (win.document.all(paraname)==null){
		     alert("数据项名称未找到或不正确，请检查程序！");
		}
		else
		{
             if (namevalue=="" || namevalue==undefined)
             {
                 alert("请选择要操作的数据！");
                     
             }
             else
             {
                 win.document.all(paraname).value=namevalue;              
		         win.document.all(paraid).value=idvalue;		         
		         if(array.length==5){
		         	win.document.all(paraname2).value=namevalue2;
		         	win.document.all(paraid2).value=idvalue2;
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
                 catch(e){}
				 if (fun!="")
                 {
                    win.execScript(fun,"javascript");
                 }
                 doClose();
             }
       }
	

}
function doClose(){
//window.close();
window.parent.hidePopWin(false);
}
function doClear(){
		  var paraname=document.all.paraName.value;
		  var paraname2=document.all.paraName2.value;
		  var paraid=document.all.paraID.value;
		  var paraid2=document.all.paraID2.value;
		  var win=window.parent;
		  if (win.document.all(paraname)==null)
		  {
		     alert("数据项名称未找到或不正确，请检查程序！");
		  }
		  else
		  {
		  win.document.all(paraid).value="";
		  win.document.all(paraname).value="";
		  win.document.all(paraid2).value="";
		  win.document.all(paraname2).value="";
          doClose();
		  }
}
function doAutoHeight() {
	var height = document.body.clientHeight;
    document.all.multi.style.height = height-60;
   }
</script>
</head>
<BODY bgcolor="#DEE7FF" topmargin=8 leftmargin=8 onload="RefreshWin();">

<table border=0 cellspacing=0 cellpadding=0 width=99% align=center>
<tr><td align=center>
<iframe name="multi"  id="multi" src="" frameborder=0 width="100%" onload="doAutoHeight()"></iframe>
</td></tr>
<tr><td height=10 nowrap></td></tr>
<tr><td align=right>
<table border=0 cellspacing=1 cellpadding=1 width=95%>
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
<input type="hidden" id="paraName2">
<input type="hidden" id="paraID">
<input type="hidden" id="paraID2">
<input type="hidden" id="funname">
</td></tr>
</table>
</BODY>
</html>