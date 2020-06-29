<%@ page contentType="text/html; charset=utf-8"%>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>mutispace</title>
		<link href="<%=request.getContextPath()%>/resources/css/site.css"
			rel="stylesheet" type="text/css">
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/resources/js/normal.js"></script>
		<script language="javascript" type="text/javascript"
			src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script language="Javascript">
function getSelected()
{
 var grid=parent.multi.ais_divselect;
 var doc=parent.multi;
 if (grid==null)
 {
   alert("对不起，请先返回列表页面再进行选取！");
 }
 else
 {
   var vs=doc.getCheckValue();
   var sarray=new Array();   
  	sarray=vs.split(';'); 
   if(vs==null || vs==""){
   alert("请选取要加入的数据！");
   }
   else
   {
   	var len=sarray.length;
     for (var i=0;i<len;i++)
     {
      if(sarray[i]!=null && sarray[i]!="")
		prolist.addProject(sarray[i],i);
     }
     
    reCount();
   }
 }
}


function delAll()
{
  if (confirm('你确认要删除全部数据吗？'))
  {
  prolist.delAllData();
  document.all.topcount.innerHTML="0";
  document.all.bottomcount.innerHTML="0";
  }
}

function reCount()
{
  var count=prolist.getRowsCount();
  document.all.topcount.innerHTML=count;
  document.all.bottomcount.innerHTML=count;
}

function GetParamater()
{
		var rs=prolist.getProject();
		
	     var namevalue=rs[1];
		  var idvalue=rs[0];
          var fun=document.all.funname.value;
		  var paraname=document.all.paraName.value;
		  var paraid=document.all.paraID.value;
		  var iframeName=document.all.returnIframe.value;
		  
		  var win=window.parent.parent.frames[iframeName];
		  
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
                  parent.doClose();
                  }
                  }
	

}
</script>
	</head>
	<body topmargin=5 leftmargin=5>

		<table border=0 cellspacing=0 cellpadding=0 width=100%>
			<tr>
				<td>
					当前已选中数据：&nbsp;
					<b><font id="topcount" color="red">0</font>
					</b>&nbsp;个&nbsp;&nbsp;
					<input type="button" value="删除全部" onclick="delAll()">
				</td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td>
					<div class="datalist" id="prolist" ondelrow="reCount()"></div>
				</td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td>
					当前已选中数据：&nbsp;
					<b><font id="bottomcount" color="red">0</font>
					</b>&nbsp;个&nbsp;&nbsp;
					<input type="button" value="删除全部" onclick="delAll()">
				</td>
			</tr>
			<tr>
				<td>
					<input type=hidden id="paraID">
					<input type=hidden id="paraName">
					<input type="hidden" id="funname">
					<input type="hidden" id="returnIframe">
				</td>
			</tr>
		</table>
	</body>
</html>
