<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<title>skin管理</title>
<script>
		//等比例显示图片
 function   RatImg(img, imgWidth, imgHeight)   
  {   
   var newImg = document.createElement("img");
    newImg.src = img;

    var width = newImg.width;
    var height = newImg.height;
    var proportion = width / height;
         
    var wp = width / imgWidth; 
    var hp = height / imgHeight; 
         
    if(wp > 1 || hp > 1)
    { 
        if(wp > hp) 
        { 
            width = imgWidth; 
            height = imgWidth / proportion; 
        } 
        else
        { 
            width = imgHeight * proportion; 
            height = imgHeight; 
        }
    }
    img.style.width = width; 
    img.style.height = height;     


  }   
</script>
</head>

<style>
input {
	border: 1px double #7F9DB9;
}

textarea {
	border: 1px double #7F9DB9;
}
</style>



<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<link href="${contextPath}/styles/blue/ufaud.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/styles/displaytag/maven-base.css"
	rel="stylesheet" type="text/css">
<link href="${contextPath}/styles/displaytag/maven-theme.css"
	rel="stylesheet" type="text/css">
<link href="${contextPath}/styles/displaytag/site.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/styles/displaytag/screen.css"
	rel="stylesheet" type="text/css">
<link href="${contextPath}/styles/displaytag/print.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>

<script type="text/javascript">
//删除一条skin
function updateSkin2Default(skinName,skinCode){
	b=window.confirm("确定将 "+skinName+" 置为默认?");
	if(!b){
		return;
	}
	var url = '${contextPath}/skin/updateSkin2Default.action?skinCode='+skinCode;
	window.location = url;	
}

//删除全部skin
//liululu
function updateAllSkin2Default(){
	$.messager.confirm("确认","确定全部置为默认？",function(result){
		if(!result){
			return;
		}
		form.action = "${contextPath}/skin/updateAllSkin2Default.action";
		form.submit();
	})
	
	
}

//提交表单
function submitSkin(){
	var skin =  document.getElementsByName("uploadSkin")[0].value;
	var skincodeVal="";
	var uploadSkinCode;
	var bool = true;
	for(var i = 0 ; i< document.getElementsByName('skinCode').length; i++){
		uploadSkinCode = document.getElementsByName('skinCode')[i].checked;
		
		if(uploadSkinCode == true){
			skincodeVal=document.getElementsByName('skinCode')[i].value;
			break;
		}
	}

	if(skin=="" && uploadSkinCode == true){
		showMessage1("请选择需要上传的图片!");
		bool = false;
	}
	if(uploadSkinCode == false){
		showMessage1("请选择图片标签编号!");
		return false;
		bool = false;
	}
   

	//提交表单
	if(bool){
		//判断选择是是否是jpg格式的图片
		if(skin.indexOf(".png") != -1){//判断图片的格式
		}else{
			showMessage1("请选择正确的图片格式!");
			return false;
		}
		//提交表单
		form.action = "${contextPath}/skin/saveSkin.action";
		form.submit();
			
		
	}//提交表单结束

}




//图片预览
var  img=null; 
var picSizeBool = false;
 
function  orsc(){  
	if(img.readyState!="complete")return  false;  
	alert("图片大小："+img.offsetWidth+"X"+img.offsetHeight);  
}  

function imageView(){
	var skin =  document.getElementsByName("uploadSkin")[0].value;
	var uploadSkinCode;
	var bool = false;
	var wid;//上传图片的宽
	var hid;//上传图片的高
	
	//判断选择是是否是jpg格式的图片
	if(skin.indexOf(".jpg") != -1 || skin.indexOf(".JPG") != -1){//判断图片的格式

		//判断是否选择图片标签序号
		for(var i = 0 ; i<7; i++){
			uploadSkinCode = document.getElementsByName('uploadSkinCode')[i].checked;
			if(uploadSkinCode == true){
				//图片编号不为空，给相应的图片附以宽高的值
				var num = document.getElementsByName('uploadSkinCode')[i].value;
				if(num == 1){
					wid = "800";
					hid = "429";
				}
				if(num == 2){
					wid = "800";
					hid = "79";
				}
				if(num == 3){
					wid = "1500";
					hid = "66";
				}
				if(num == 4){
					wid = "526";
					hid = "385";
				}
				if(num == 5){
					wid = "600";
					hid = "53";
				}
				if(num == 6){
					wid = "1";
					hid = "53";
				}
				if(num == 7){
					wid = "355";
					hid = "53";
				}
				break;
			}
		}

		//图片和图片标签序号都不为空
		if(skin!="" && uploadSkinCode == true){
			//---获得图片的大小
			if(img){img.removeNode(true);}  
			img=document.createElement("img");  
			img.style.position="absolute";  
			img.style.visibility="hidden";  
			img.attachEvent("onreadystatechange",orsc);  
			document.body.insertAdjacentElement("beforeend",img);  
			img.src=skin; 
			bool = true;
		}else{
			alert("请选择图片或者图片标签！");
			bool = false;
		}
	if(bool){
		var url = "${contextPath}/skin/readOneSkin.action?path="+skin;
		window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
	}else{
		alert("请选择正确的图片格式!");
	}
}

function sucFun(){
 		if($("#sucFlag").val()=='1'){
 			$("#sucFlag").val('');
 			$.messager.show({title:'提示信息',msg:'保存成功!'});
 		}        		
		}

		$(function(){
			var num = Math.random();
			$('#navi_version').attr('src','${contextPath}/index/assets/global/img/a7/navi_version.png?num='+num);
			$('#yonyou').attr('src','${contextPath}/index/assets/global/img/a7/yonyou.png?num='+num);
			$('#aisplatform').attr('src','${contextPath}/index/assets/global/img/a7/aisplatform.png?num='+num);
			$('#navi_title').attr('src','${contextPath}/index/assets/global/img/a7/navi_title.png?num='+num);
		});

</script>
<body onload="sucFun();">
<center>
<s:form action="saveSkin" method="POST" namespace="/skin" enctype="multipart/form-data" name="form">
	<table cellpadding=0 cellspacing=1 border=0  
		class="ListTable" width="100%">
			<input type="hidden" name="sucFlag" id="sucFlag" value="${sucFlag}"/>
		<tr class="">
			<td class="EditHead" style="text-align: left;width: 100%;">
			  <s:property escape="false"
				value="@ais.framework.util.NavigationUtil@getNavigation('/ais/skin/uploadSkin.action')" />
			</td>
		</tr>
	</table>

	<table cellpadding=0 cellspacing=1 border=0
		class="ListTable" align="center" width="100%">
		<tr>
			<td class="EditHead">上传图片</td>
			<td class="editTd"><s:fielderror /> <s:file
				name="uploadSkin" size="50" accept="jpeg/*"/> <span>&nbsp;支持.png格式
			&nbsp;&nbsp; </span></td>
		</tr>
		<tr>
			<td class="EditHead">图片标签编号</td>
			<td colspan="5" class="editTd">
			<s:radio
				name="skinCode"
				list="#@java.util.LinkedHashMap@{'yonyou':'系统登录图片（左上）【尺寸：145*30】  png','navi_version':'系统portal图片(左上)【尺寸：396*52】  png'}"
				label="%{getText('')}" />
			<br>
			<s:radio
				name="skinCode"
				list="#@java.util.LinkedHashMap@{'aisplatform':'系统登录图片（居中）【尺寸：676*59】  png','navi_title':'系统portal图片(居中)【尺寸：766*67】  png'}"
				label="%{getText('')}" /></td>
		</tr>

	</table>
	<div align="right">
	    <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="submitSkin()">提交</a>&nbsp;&nbsp;&nbsp;&nbsp;
	   <%-- <a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="updateAllSkin2Default()">全部置为默认</a>--%>
	</div>
	<br>
	<table cellpadding=0 cellspacing=1 border=0
		class="ListTable" align="center">
		<tr class="">
			<td class="EditHead" align="center" style="width: 50%">系统登录图片（左上）</td>
			<td class="EditHead" align="center" style="width: 50%">系统portal图片(左上)</td>
		</tr>
		<tr class="">
			<td class="editTd">
				<img alt="" src="" height="60" id="yonyou">
			</td>
			<td class="editTd">
				<img alt="" src="" height="60" id="navi_version">
			</td>
		</tr>
		<tr class="">
			<td class="EditHead" align="center" style="width: 50%">系统登录图片（居中）</td>
			<td class="EditHead" align="center" style="width: 50%">系统portal图片(居中)</td>
		</tr>
		<tr class="">
			<td class="editTd">
				<img alt="" src="" height="60" id="aisplatform">
			</td>
			<td class="editTd">
				<img alt="" src="" height="60" id="navi_title">
			</td>
		</tr>
	</table>
</s:form>
</center>
</body>
</html>

