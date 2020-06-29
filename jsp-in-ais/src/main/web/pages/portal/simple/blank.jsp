<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>空白页</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
<!--
<!--右下脚弹出窗口开始-->
<%String countDaiban = (String)request.getAttribute("countDaiban");
	if(countDaiban!=null&&new Integer(countDaiban).intValue()>0){
%>
window.onload = getMsg;
window.onresize = resizeDiv;
<%}%>
window.onerror = function(){}
var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer,i = 0;
function enterDaiban(){
	parent.basefrm.location = "/ais/bpm/taskinstance/pending.action";
	closeDiv();
}
function getMsg()
{
   try
   {
    divTop = parseInt(document.getElementById("loft_win").style.top,10);
    divLeft = parseInt(document.getElementById("loft_win").style.left,10);
    divHeight = parseInt(document.getElementById("loft_win").offsetHeight,10);
    divWidth = parseInt(document.getElementById("loft_win").offsetWidth,10);
    docWidth = document.body.clientWidth;
    docHeight = document.body.clientHeight;
    document.getElementById("loft_win").style.top = parseInt(document.body.scrollTop,10) + docHeight + 10;// divHeight
    document.getElementById("loft_win").style.left = parseInt(document.body.scrollLeft,10) + docWidth - divWidth;
    document.getElementById("loft_win").style.visibility="visible";
    objTimer = window.setInterval("moveDiv()",10);
   }
   catch(e){}
}

//初始化位置
function resizeDiv()
{
   i+=1;
   //if(i>300) closeDiv() //想不用自动消失由用户来自己关闭所以屏蔽这句
   try
   {
    divHeight = parseInt(document.getElementById("loft_win").offsetHeight,10);
    divWidth = parseInt(document.getElementById("loft_win").offsetWidth,10);
    docWidth = document.body.clientWidth;
    docHeight = document.body.clientHeight;
    document.getElementById("loft_win").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10);
    document.getElementById("loft_win").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10);
   }
   catch(e){}
}

//最小化
function minsizeDiv()
{
   i+=1
   //if(i>300) closeDiv() //想不用自动消失由用户来自己关闭所以屏蔽这句
   try
   {
    divHeight = parseInt(document.getElementById("loft_win_min").offsetHeight,10);
    divWidth = parseInt(document.getElementById("loft_win_min").offsetWidth,10);
    docWidth = document.body.clientWidth;
    docHeight = document.body.clientHeight;
    document.getElementById("loft_win_min").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10);
    document.getElementById("loft_win_min").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10);
   }
   catch(e){}
}

//移动
function moveDiv()
{
try
{
   if(parseInt(document.getElementById("loft_win").style.top,10) <= (docHeight - divHeight + parseInt(document.body.scrollTop,10)))
   {
    window.clearInterval(objTimer);
    objTimer = window.setInterval("resizeDiv()",1);
   }
   divTop = parseInt(document.getElementById("loft_win").style.top,10);
   document.getElementById("loft_win").style.top = divTop -1;
}
   catch(e){}
}

function minDiv()
{
   closeDiv();
   document.getElementById('loft_win_min').style.visibility='visible';
   objTimer = window.setInterval("minsizeDiv()",1);
}

function maxDiv()
{
   document.getElementById('loft_win_min').style.visibility='hidden';
   document.getElementById('loft_win').style.visibility='visible';
   objTimer = window.setInterval("resizeDiv()",1);
   //resizeDiv()
   getMsg();
}

function closeDiv()
{
   document.getElementById('loft_win').style.visibility='hidden';
   document.getElementById('loft_win_min').style.visibility='hidden';
   if(objTimer) window.clearInterval(objTimer);
}
<!--右下脚弹出窗口结束-->
-->
</script>
<style type="text/css">
<!--
#loft_win {border:#0066FF 1px solid;}
#loft_win_min {border:#0066FF 1px solid;}
.loft_win_head {color: #FFFFFF; font-size:13px; background-color:#0066FF; height:25px; padding:0,5,0,5;}
#contentDiv {background-color:#FFFFFF; border:#0066FF 1px solid; border-left-style:none; border-right-style:none;}
a { font-size:12px; color:#000000;}
a:link {font-size:12px; color:#999999; text-decoration:none;}
a:visited { font-size:12px; color:#999999; text-decoration:none;}
a:hover {font-size:13px; color:#999999; text-decoration:none; border:#FF9900 1px dashed; border-left-style:none; border-right-style:none; border-top-style:none;}
a:actived {font-size:12px; color:#000000; text-decoration:none;}
-->
</style>
  </head>
 
  <body background="${contextPath}/images/portal/blank.gif" style="height:500;">
   <DIV id="loft_win" style="Z-INDEX:99999; LEFT: 0px; VISIBILITY: hidden;WIDTH: 250px; POSITION: absolute; TOP: 0px; HEIGHT: 150px;">
   <TABLE cellSpacing=0 cellPadding=0 width="100%" bgcolor="#FFFFFF" border=0>
    <TR>
     <td width="100%" valign="top" align="center">
      <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
        <td width="70" class="loft_win_head">信息提示</td>
        <td width="26" class="loft_win_head"> </td>
        <td align="right" class="loft_win_head">
         <span style="CURSOR: hand;font-size:12px;font-weight:bold;margin-right:4px;" title=最小化 onclick=minDiv() >- </span><span style="CURSOR: hand;font-size:12px;font-weight:bold;margin-right:4px;" title=关闭 onclick=closeDiv() >×</span>
        </td>
       </tr>
      </table>
     </td>
    </TR>
    <TR>
     <TD height="130" align="center" valign="middle" colSpan=3>
      <div id="contentDiv">
       <table width="100%" height="100%" cellpadding="0" cellspacing="0">
        <tr>
         <td align="center" height="100%">
          <div>
           <a href="javascript:enterDaiban()" >您有<%=countDaiban%>条待办事项未办理，点击进入待办页面进行办理！</a>
<br>
           
          </div>
         </td>
        </tr>
       </table>
      </div>
     </TD>
    </TR>
   </TABLE>
</DIV>

<!--最小化状态-->
<DIV id="loft_win_min" style="Z-INDEX:99999; LEFT: 0px; VISIBILITY: hidden;WIDTH: 250px; POSITION: absolute; TOP: 0px;">
   <TABLE cellSpacing=0 cellPadding=0 width="100%" bgcolor="#FFFFFF" border=0>
    <TR>
     <td width="100%" valign="top" align="center">
      <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
        <td width="70" class="loft_win_head">提示窗口</td>
        <td width="26" class="loft_win_head"> </td>
        <td align="right" class="loft_win_head">
         <span title=还原 style="CURSOR: hand;font-size:12px;font-weight:bold;margin-right:4px;" onclick=maxDiv() >□</span><span title=关闭 style="CURSOR: hand;font-size:12px;font-weight:bold;margin-right:4px;" onclick=closeDiv() >×</span>
        </td>
       </tr>
      </table>
     </td>
    </TR>
   </TABLE>
</DIV>
  </body>
</html>
