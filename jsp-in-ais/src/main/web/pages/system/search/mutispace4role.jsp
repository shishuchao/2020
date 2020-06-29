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
		addUser(sarray[i]);//prolist.
     }
     
     reCount();
   }
 }
}


function delAll()
{
  if (confirm('你确认要删除全部数据吗？'))
  {
  delAllData();//prolist.
  document.all.topcount.innerHTML="0";
  document.all.bottomcount.innerHTML="0";
  }
}

function reCount()
{
  var count=getRowsCount();//prolist.
  document.all.topcount.innerHTML=count;
  document.all.bottomcount.innerHTML=count;
}

function GetParamater()
{
	var rs=getUser();//prolist.
	var namevalue=rs[1];
	var idvalue=rs[0];
	var fun=document.all.funname.value;
	var paraname=document.all.paraName.value;
	var paraid=document.all.paraID.value;
	var win=window.parent.parent;
	var ids=idvalue.split(",");
	for(var i in ids){if(ids[i]=='${user.floginname}'){alert("禁止对本人授权!");return false;}}
	document.all.loginNames.value=idvalue;
	document.forms[0].submit();
          	
}
function initData(){
<%
	String initid=(String)request.getAttribute("logins");
	String initname=(String)request.getAttribute("names");
	initid=initid==null?"":initid;
	initname=initname==null?"":initname;
%>
var paraname=document.all.paraName.value;
var paraid=document.all.paraID.value;
var initid='<%=initid%>';
var initname='<%=initname%>';
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
		addUser(ts);//prolist.
		
		}
     }
     reCount();
   }
}
function doClear(){

if (confirm('你确认要删除全部数据吗？'))
  {
  delAllData();//prolist.
  document.all.topcount.innerHTML="0";
  document.all.bottomcount.innerHTML="0";
  }
document.getElementById('loginNames').value='';
GetParamater();
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
					<div id="prolist" ondelrow="reCount()"></div>
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
					<input type=hidden id="paraID" value="">
					<input type=hidden id="paraName"  value="">
					<input type="hidden" id="funname"  value="">
				</td>
			</tr>
		</table>
		<form id="m4r" action="<%=request.getContextPath()%>/system/authAuthorityAction!saveRole4users.action" method="post">
		<input type=hidden id="loginNames" name="loginNames" value="">
		<input type=hidden id="roleId" name="roleId" value="<%=request.getParameter("roleId")%>">
		<input type=hidden id="roleName" name="roleName" value="<%=request.getParameter("roleName")%>">
		</form>
<SCRIPT>
var objTable;
var array=new Array();
var trbgcolor='#ECF1FF';
var addflag = 0;
var oelement=document.all.prolist;

 objTable=document.createElement("TABLE");
 objTable.border =0;
 objTable.cellSpacing =1;
 objTable.cellPadding =3;
 //objTable.runtimeStyle.borderStyle = 'solid';
 //objTable.runtimeStyle.borderCollapse = 'separate';
 //objTable.runtimeStyle.borderWidth = '1px';
 //objTable.runtimeStyle.borderColor = '#24b4d8';
 objTable.setAttribute('borderStyle','solid');
 objTable.setAttribute('borderCollapse','separate');
 objTable.setAttribute('borderWidth','1px');
 objTable.setAttribute('borderColor','#24b4d8');
 oelement.appendChild(objTable); 

Array.prototype.remove=function(dx)
{
   if(isNaN(dx)||dx>this.length){return false;}
   for(var i=0,n=0;i<this.length;i++)
   {
       if(this[i]!=this[dx])
       {
           this[n++]=this[i]
       }
   }
   this.length-=1
}
//customer
//addUser(floginname,fname,fdeptname)
function addUser()
{
    var canadd=true;
  var o=arguments[0].split(",");
  for (var j=0;j<array.length;j++)
  {
    if (array[j]==o[1])
    {
      canadd=false;
      break;
    }
  
  }
  if (canadd)
  {
  objTable.insertRow();
  array[array.length]=o[1];
  var rowcount=objTable.rows.length-1;
  var row;
  try{
  	row=objTable.rows(rowcount);
  }catch(e){
  	row=objTable.rows[rowcount];
  }
  //row.runtimeStyle.background=trbgcolor;
  row.background=trbgcolor;
  row.vAlign="bottom";
  row.id=oelement.id+"_"+rowcount;
  row.insertCell();
  row.insertCell();
  row.insertCell();
  row.insertCell();
  row.insertCell();
 
  try{
	  CreatePK(row.cells(1),o[1]);
	  CreateNormalBox(row.cells(0),"\u767b\u5f55\u540d\u79f0",o[1],true);
	  CreateNormalBox(row.cells(2),"\u771f\u5b9e\u59d3\u540d",o[2],true);
	  CreateDelBtn(row.cells(4));
  }catch(e){
	  CreatePK(row.cells[1],o[1]);
	  CreateNormalBox(row.cells[0],"\u767b\u5f55\u540d\u79f0",o[1],true);
	  CreateNormalBox(row.cells[2],"\u771f\u5b9e\u59d3\u540d",o[2],true);
	  CreateDelBtn(row.cells[4]);
  }
  }
  else
  {
   
  }

}
function addObject()
{
    var canadd=true;
  var o=arguments[0].split(",");
  for (var j=0;j<array.length;j++)
  {
    if (array[j]==o[0])
    {
      canadd=false;
      break;
    }
  
  }
  if (canadd)
  {
  objTable.insertRow();
  array[array.length]=o[0];
  var rowcount=objTable.rows.length-1;
  var row;
  try{
  	row=objTable.rows(rowcount);
  }catch(e){
  	row=objTable.rows[rowcount];
  }
  //row.runtimeStyle.background=trbgcolor;
  row.background=trbgcolor;
  row.vAlign="bottom";
  row.id=oelement.id+"_"+rowcount;
  row.insertCell();
  row.insertCell();
  row.insertCell();
 
  try{
	  CreatePK(row.cells(1),o[0]);
	  CreateNormalBox(row.cells(0),"\u767b\u5f55\u540d\u79f0",o[1],true);
	 
	  CreateDelBtn(row.cells(2));
  }catch(e){
	  CreatePK(row.cells[1],o[0]);
	  CreateNormalBox(row.cells[0],"\u767b\u5f55\u540d\u79f0",o[1],true);
	 
	  CreateDelBtn(row.cells[2]);
  }
  }
  else
  {
   
  }

}
function addProject()
{
    var canadd=true;
  var o=arguments[0].split(",");
  var rowcount=arguments[1];
  for (var j=0;j<array.length;j++)
  {
    if (array[j]==o[0])
    {
      canadd=false;
      break;
    }
  
  }
  if (canadd)
  {
  objTable.insertRow();
  array[array.length]=o[0];
  var rowcount=objTable.rows.length-1;
  var row;
  try{
  	row=objTable.rows(rowcount);
  }catch(e){
  	row=objTable.rows[rowcount];
  }
  //row.runtimeStyle.background=trbgcolor;
  row.background=trbgcolor;
  row.vAlign="bottom";
  row.id=oelement.id+"_"+rowcount;
  row.insertCell();
  row.insertCell();
  row.insertCell();
  row.insertCell();
  row.insertCell();
 
  try{
	  CreatePK(row.cells(1),o[0]);
	  CreateNormalBox(row.cells(0),"\u9879\u76ee\u540d\u79f0",o[1],true);
	  CreateNormalBox(row.cells(2),"\u542f\u52a8\u65f6\u95f4",o[2],true);
	  CreateNormalBox(row.cells(4),"\u5173\u95ed\u65f6\u95f4",o[3],true);
	  CreateDelBtn(row.cells(4));
  }catch(e){
	  CreatePK(row.cells[1],o[0]);
	  CreateNormalBox(row.cells[0],"\u9879\u76ee\u540d\u79f0",o[1],true);
	  CreateNormalBox(row.cells[2],"\u542f\u52a8\u65f6\u95f4",o[2],true);
	  CreateNormalBox(row.cells[4],"\u5173\u95ed\u65f6\u95f4",o[3],true);
	  CreateDelBtn(row.cells[4]);
  }
  }
  else
  {
   
  }
}
function getProject()
{
 var rsid="";
 var rsname="";
  if (objTable!=null&&objTable.rows!=null)
  {
  
  for (var i=0;i<objTable.rows.length;i++)
  {
	 var id=objTable.rows(i).cells(1).children[0];
    var project_name=objTable.rows(i).cells(0).children[1];
   if (i<objTable.rows.length-1){
   	rsid+=id.value+",";
  	rsname+=project_name.value+",";
  	}
   else{
    rsid+=id.value;
  rsname+=project_name.value;
   }
  }
  }
  var array=new Array();
   array[0]=rsid;
  array[1]=rsname;
  return array;
}
function getUser()
{
 var rsid="";
 var rsname="";
  if (objTable!=null&&objTable.rows!=null)
  {
  
  for (var i=0;i<objTable.rows.length;i++)
  {
   var uesrid=objTable.rows(i).cells(1).children[0];
   var loginname=objTable.rows(i).cells(0).children[1];
   var name=objTable.rows(i).cells(2).children[1];
   if (i<objTable.rows.length-1){
   	rsid+=loginname.value+",";
  	rsname+=name.value+",";
  	}
   else{
    rsid+=loginname.value;
  rsname+=name.value;
   }
  }
  }
  var array=new Array();
  array[0]=rsid;
  array[1]=rsname;
  return array;
}
function getObject()
{
 var rsid="";
 var rsname="";
  if (objTable!=null&&objTable.rows!=null)
  {
  
  for (var i=0;i<objTable.rows.length;i++)
  {
   var id=objTable.rows(i).cells(1).children[0];
   var name=objTable.rows(i).cells(0).children[1];
   if (i<objTable.rows.length-1){
   	rsid+=id.value+",";
  	rsname+=name.value+",";
  	}
   else{
    rsid+=id.value;
  rsname+=name.value;
   }
  }
  }
  var array=new Array();
  array[0]=rsid;
  array[1]=rsname;
  return array;
}

function getRowsCount()
{
 return objTable.rows.length;
}

function delAllData()
{
  array=new Array();
  for (var i=objTable.rows.length-1;i>=0;i--)
  {
     objTable.deleteRow(i);
  }
  
}
function CreateNormalBox(cell,cn_name,arg,isreadonly)
{
  var count=document.createElement("input");
  count.type="text";
  count.readOnly=isreadonly;
  count.value=arg;
  count.size=10;
  var countname=document.createElement("font");
  countname.innerHTML=cn_name+": ";
  cell.appendChild(countname);
  cell.appendChild(count);

}
function CreateNormalText(cell,cn_name,arg)
{
  var span=document.createElement("span");
  span.innerHTML=arg;
  span.size=30;
  var proname=document.createElement("font");
  proname.innerHTML=cn_name+": ";
  cell.appendChild(proname);
  cell.appendChild(span);
}


function CreateDelBtn(cell)
{
  var del=document.createElement("input");
  del.type="button";
  del.value="\u5220\u9664";
  try{
	  del.attachEvent("click",delOppRow); //onclick
  }catch(e){
	  del.addEventListener("click",delOppRow);
  }
  cell.appendChild(del);
}
//id key
function CreatePK(cell,arg)
{
  var hiddenid=document.createElement("input");
  hiddenid.type="hidden";
  hiddenid.value=arg;
  cell.appendChild(hiddenid);
}



function delOppRow()
{
   if (confirm("\u786e\u8ba4\u8981\u5220\u9664\u5417\uff1f"))
   {
   var row=event.srcElement.parentElement.parentElement;
   var id=row.rowIndex;
   var pk;
   try{
   	pk=row.cells(1).children[0].value;
   }catch(e){
    pk=row.cells[1].children[0].value; 
   }
   for (var i=0;i<array.length;i++)
   {
     if (array[i]==pk)
     {
       array.remove(i);
       break;
     }
   }
   

   objTable.deleteRow(id);
   var e=createEventObject();
   odelrow.fire(e);
  
   }
}

function CreateBoxWEvent(cell,cn_name,arg,isreadonly,size,event)
{
  var count=document.createElement("input");
  count.type="text";
  count.readOnly=isreadonly;
  count.value=arg;
  count.size=size;
  count.attachEvent("onkeyup",event);
  count.attachEvent("onfocus",getFocus);
   var countname=document.createElement("font");
  countname.innerHTML=cn_name+"：";
  cell.appendChild(countname);
  cell.appendChild(count);
}
         
</SCRIPT>
	</body>
</html>
