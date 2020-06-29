<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta content="noindex, nofollow" name="robots" />
		<script src="common/fck_dialog_common.js" type="text/javascript"></script>
	<script type='text/javascript'
			src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='/ais/dwr/engine.js'></script>
		<script type="text/javascript">

var oEditor		= window.parent.InnerDialogLoaded() ;
var FCK			= oEditor.FCK ;
var FCKLang		= oEditor.FCKLang ;
var FCKConfig	= oEditor.FCKConfig ;
var FCKRegexLib	= oEditor.FCKRegexLib ;

// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;
var oImage = oEditor.FCK.Selection.GetSelectedElement() ;

window.onload = function()
{
	// First of all, translate the dialog box texts
	oEditor.FCKLanguageManager.TranslatePage(document) ;
	window.parent.SetOkButton( true ) ;
}
var mybool=true;
function Ok()
{
	if(mybool){
	var img=GetE('imgUrl').value;
	if(!mycheck()){
	 alert("请选择jpg gif bmp jpeg png 类型的图片");
	 return false;
	}
	mysubmit();
	return false;
	}else{
	var img=document.getElementById('imgUrl').value;
	if(img.length>1){
		var oImage = FCK.CreateElement( 'IMG' ) ;
		//oImage = FCK.InsertElementAndGetIt( oImage ) ;
		SetAttribute(oImage, 'src', img) ;
	}
		return true ;
	}
	
}


function  mysubmit(){
/*
	uploadImg=document.getElementById('uploadImg');
	imgUrl=document.getElementById('imgUrl').value;
	DWREngine.setVerb("POST");
	DWREngine.setAsync(false);
	DWRActionUtil.execute(
	{ namespace:'/portal/simple', action:'portalImgFileAction',method:'saveImg', executeResult:'true' }, 
	 {'uploadImg':uploadImg,'imgUrl':imgUrl},xxx);
     function xxx(data){
     	if(data['imgUrl'] != null && data['imgUrl'] != ""){
     		alert(data['imgUrl']);
     		temp=data['imgUrl'];
     	}
     	temp="";
	}
*/

document.frames[0].document.getElementsByName('myform')[0].submit();
}
function mycheck(){
	url=document.frames[0].document.getElementsByName('uploadImg')[0].value;
	suitType="jpg gif bmp jpeg png";
	if(url.length>0&&url.lastIndexOf('.')!=-1){
		url=url.substring(url.lastIndexOf('.')+1,url.length);
		if(suitType.indexOf(url.toLowerCase())!=-1)
			return true;
	}
	return false;
}

</script>
</head>

<body  style="overflow: hidden">

<!-- 
	<table cellspacing="3" cellpadding="2" width="100%" border="0">
		<tr>
			<td nowrap="nowrap">
				<label for="txtFind" fcklang="DlgReplaceFindLbl">
					å¾çå°å:</label>&nbsp;
			</td>
			<td width="100%">
				<input id="imgUrl" style="width: 100%" tabindex="1" type="text" />
			</td>
			<td>
				
			</td>
		</tr>
	</table>
 -->
	<!-- 555555 -->
	<form action="/ais/portal/simple/portalImgFileAction!saveImg.action" enctype="multipart/form-data" method="post" name="myform">
	<table cellspacing="3" cellpadding="2" width="100%" border="0">
		<tr>
			<td nowrap="nowrap">
				<label for="txtFind" fcklang="DlgReplaceFindLbl">
					查找:</label>&nbsp;
			</td>
			<td width="100%">
				<iframe src="fck_extimg2.jsp" name="myform" frameborder="0" align="top" scrolling="no" style="width:330;height: 50;"></iframe>
				<input id="imgUrl"  name="imgUrl" style="width: 100%" tabindex="1" type="hidden"  value="${imgUrl}"/>
				<!-- 
				<input type="file"  id="uploadImg" name="uploadImg" size="50" value="" />
				 -->
			</td>
		</tr>
	
	</table>
	
	 
	</form>
	
<script type="text/javascript">
	var obj=document.getElementById('imgUrl');
	obj.onpropertychange=function(){
		if(obj.value.length>2){
			mybool=false;
			Ok();
			window.close();
		}
	}
</script>
</body>
</html>
