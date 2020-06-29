<%@ page contentType="text/html; charset=utf-8" %>
<HTML>
<HEAD><meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE> 选择部门 </TITLE>
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script language=Javascript>

 function RefreshWin()
{
//var document=window.dialogArguments.document;
var url="";
//获取参数
var ay=getParameter(window.location.href);
for (var i=0;i<ay.length;i++)
{
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
}

 function GetParamater()
 {
 //var document=window.dialogArguments.document;
     var paraname=document.all.paraName.value;
     var paravalue=document.all.paraID.value;
     var depname=document.all.depname.value;
     var depid=document.all.depid.value;
     var fun=document.all.funname.value;
     var win=window.opener;
     if (depname!=null)
     {
       if (depname.value=="")
       {
         alert("请选取要操作的数据！");
       }
       else
       {
          win.document.all(paraname).value=depname;
          win.document.all(paravalue).value=depid;
          if (fun!=""){
            win.execScript(fun,"javascript");
          }
           win.focus();
          window.close();
       }
     }
 }
function RightGo(id,name)
{


  document.all.depid.value=id;
  document.all.depname.value=name;
}

</script>
</HEAD>
<BODY  topmargin=10 leftmargin=10 onload="javascript:RefreshWin()">
<table border=0 cellspacing=0 cellpadding=0 width=300 align=center>
<tr><td align=right>
<table border=0 cellspacing=0 cellpadding=0 width=95% align=center>
<tr>
<td width=40%></td>
<td align=right>
<div id="save" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif" Background="#D2E9FF" Text="确定" onclick="GetParamater()"></div>
</td>
<td align=left>
<div id="cancel" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif" Background="#D2E9FF" Text="取消" onclick="window.close()"></div>
</td>
</tr>
</table>
</td></tr>
<tr><td height=5 nowrap></td></tr>
<tr><td>
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00" topVisible="FALSE">
<p title="" sid="1" pid="0"></p>
<p title="组织机构调用" sid="2" pid="1" click="RightGo('1','v1')"></p>
<p title="人员调用" sid="3" pid="1" click="RightGo('2','v2')"></p>
<p title="选单页调用" sid="4" pid="1" click="RightGo('3','v3')"></p>
</div>
</td></tr>
<input type=hidden id="depid" >
<input type=hidden id="depname" >
<input type=hidden id="paraID" >
<input type=hidden id="paraName" >
<input type="hidden" id="funname">
</table>
</BODY>
</HTML>
