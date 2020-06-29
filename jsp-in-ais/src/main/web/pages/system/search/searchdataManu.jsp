<%@ page contentType="text/html; charset=utf-8" %>
<HTML>
<HEAD>
<title>search</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
	<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
	<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script language="javascript">
function RefreshWin(){
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
    if (selectspace.document.all("paranamevalue")!=null&&selectspace.document.all("paraidvalue")!=null)
	{
	      var namevalue=selectspace.document.all("paranamevalue").value;
		  var idvalue=selectspace.document.all("paraidvalue").value;
          var fun=document.all.funname.value;
		  var paraname=document.all.paraName.value;
		  var paraid=document.all.paraID.value;
		  var win=window.parent;
          if (idvalue.indexOf(",") > 0){
             alert("选取的数据只能选择一行！");
             return ;
           }
          if (win.document.all(paraname)==null){
		     alert("数据项名称未找到或不正确，请检查程序！");
		  }else{
                  if (namevalue=="")
                  {
                     alert("请选择要操作的数据！");
                  }
                  else
                  {
                  var temp  = win.document.getElementById(paraname).value;
                  var tempId  = win.document.getElementById(paraid).value;

                   win.document.getElementById(paraname).value=namevalue;
                   win.document.getElementById(paraid).value=idvalue;

		          if(paraname=='crudObject.groupName'){
                     if(temp==namevalue&&temp!=''&&tempId!=null&&tempId==idvalue){
                    	// alert('出错了!');
                     }else{
                        win.document.all('crudObject.audit_dept_name').value='';
                        win.document.all('crudObject.audit_dept').value='';
                     }
                  }
                  
                  
                  if(paraname=='audManuscript.groupName'){
                     if(temp==namevalue&&temp!=''&&tempId!=null&&tempId==idvalue){
                    	// alert('出错了!');
                     }else{
                        win.document.all('audManuscript.audit_dept_name').value='';
                        win.document.all('audManuscript.audit_dept').value='';
                     }
                  }
                  
                  
                   if(paraname=='audDoubt.groupName'){
                     if(temp==namevalue&&temp!=''&&tempId!=null&&tempId==idvalue){
                    	 //alert('出错了!');
                     }else{
                        win.document.all('audDoubt.audit_dept_name').value='';
                        win.document.all('audDoubt.audit_dept').value='';
                     }
                  }
                  
                  try{
	                  if (win.document.all(paraname).type!="hidden"){
	                   //focus()
	                  win.document.all(paraname).focus();
	                   //blur()
	                  win.document.all(paraname).blur();
	                  }
                  }catch(e)
                  {}
                  if (fun!="")
                  {
                	  window.parent.execScript(fun,"javascript");
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
		if (win.document.all(paraname)==null)
		{
		   alert("数据项名称未找到或不正确，请检查程序！");
		}
		 else
		 {
		 
		 		   if(paraname=='crudObject.groupName'){
                     win.document.all('crudObject.audit_dept_name').value='';
                     win.document.all('crudObject.audit_dept').value='';
                  }
                  
                  if(paraname=='audManuscript.groupName'){
                     win.document.all('audManuscript.audit_dept_name').value='';
                     win.document.all('audManuscript.audit_dept').value='';
                  }
                  
                  
                  
                  
                   if(paraname=='audDoubt.groupName'){
                        win.document.all('audDoubt.audit_dept_name').value='';
                        win.document.all('audDoubt.audit_dept').value='';
                  }
			win.document.all(paraid).value="";
			win.document.all(paraname).value="";
			window.parent.hidePopWin(false);
		}
}
</Script>
</HEAD>

<BODY bgcolor="#DEE7FF" topmargin=8 leftmargin=8 onload="RefreshWin();">

<table border=0 cellspacing=0 cellpadding=0 width=99% align=center>
<tr ><td align=center>
<iframe id="selectspace" src="" frameborder=0 width="100%" scrolling="auto"  onload="doAutoHeight()"></iframe>
</td></tr>
<tr><td height=10 nowrap></td></tr>
<tr><td align=right>
<table border=0 align="left" cellspacing=1 cellpadding=1 width=95%>
<tr height="10">
<td width=60%>
<td>
<div id="select" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif" Background="#D2E9FF" Text="确定" onclick="GetParamater()"></div>
</td>
<td width=10 nowrap></td>
<td>
<div id="cancel1" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif" Background="#D2E9FF" Text="取消" onclick="window.parent.hidePopWin(false);"></div>
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
<input type="hidden" id="paraID">
<input type="hidden" id="funname">
</td></tr>
</table>
<script language="javascript">
function doAutoHeight() {
	var height = document.body.clientHeight;
    document.all.selectspace.style.height = height-60;
   }
</script>
</BODY>
</HTML>