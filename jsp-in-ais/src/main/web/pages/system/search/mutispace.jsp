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
//获取选中参数
function getSelected()
{
 var grid=parent.multi.main.ais_divselect;
 var doc=parent.multi.main;
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
     for (var i=0;i<sarray.length;i++)
     {
      //取值js
      if(sarray[i]!=null && sarray[i]!="")
		prolist.addUser(sarray[i]);
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

function GetParamater(){
		var rs=prolist.getUser();
	     var namevalue=rs[1];
		  var idvalue=rs[0];
          var fun=document.all.funname.value;
		  var paraname=document.all.paraName.value;
		  var paraid=document.all.paraID.value;
		  var ifDNJY = document.getElementById('ifDNJY').value;
		  if(ifDNJY == 'y'){
			  if(namevalue != "" && namevalue.split(",").length > 1){
				  alert("只允许选择一个处理人！");
				  return false;
			  }
		  }
		  var win=window.parent.parent;
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
                    //win.document.all(paraname).value=namevalue;
		   			//win.document.all(paraid).value=idvalue;
		   win.document.getElementsByName(paraname)[0].value=namevalue;
		   win.document.getElementsByName(paraid)[0].value=idvalue;
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
function doClear(){
	var paraname=document.all.paraName.value;
	var paraid=document.all.paraID.value;
	var win=window.parent.parent;
	var fun=document.all.funname.value;
	if (win.document.all(paraname)==null)
	{
	   alert("数据项名称未找到或不正确，请检查程序！");
	}
	else
	{
		//win.document.all(paraid).value="";
		//win.document.all(paraname).value="";
		win.document.getElementsByName(paraid)[0].value="";
		win.document.getElementsByName(paraname)[0].value="";
		
	   	if (fun!=""){
	    	win.execScript(fun,"javascript");
	    }
		parent.doClose();
	}
}
function initData(){

var paraname=document.all.paraName.value;
var paraid=document.all.paraID.value;
var win=window.parent.parent;
//var initid=win.document.all(paraid).value;
//var initname=win.document.all(paraname).value;
var obj1=win.document.getElementsByName(paraid);
var obj2=win.document.getElementsByName(paraname);
if(obj1){obj1=obj1[0];obj2=obj2[0];}else{obj1=document.getElementById(paraid);obj2=document.getElementById(paraname);}

var initid=obj1.value;
var initname=obj2.value;
var idarray=new Array();   
  	idarray=initid.split(','); 
  	var namearray=new Array();   
  	namearray=initname.split(',');
   if(idarray!=null || idarray!=""){
  
     for (var i=0;i<idarray.length;i++)
     {
      //取值js
      if(idarray[i]!=null && idarray[i]!=""){
      var ts=i+','+idarray[i]+','+namearray[i]+',,';
		prolist.addUser(ts);
		
		}
     }
     reCount();
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
					<input type="hidden" id="ifDNJY">
					<input type="hidden" id="funname">
					
				</td>
			</tr>
		</table>
	</body>
</html>
