<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
    <!--
  下面箭头的缩放
  -->
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<title>
midarrow
</title>
<script language="JavaScript">
function liftSize(){
var WindowMain = window.parent.document.getElementById('WindowMain');
	if(WindowMain.cols=="185,8,*"){
	     document.seeImg.src="images/arrow_new_r.gif";
		 document.seeImg.title="显示"
		WindowMain.cols="0,8,*";
}else{
document.seeImg.src="images/arrow_new_l.gif";
		WindowMain.cols="185,8,*";
		document.seeImg.title="隐藏"
		}
}
</script>
</head>
<body topmargin="0" leftmargin="0" bgcolor="#B5DAFF">
<table  height="100%" border="0" cellpadding="0" cellspacing="0" background="images/arrow_new_bg.gif">
  <tr ><td width="8"    height="100%" ><div  onClick="liftSize()"  title="隐藏"><img  src="images/arrow_new_l.gif"  name="seeImg" width="8" height="13"  border="0"></div></td></tr>

</table>

</body>
</html>

