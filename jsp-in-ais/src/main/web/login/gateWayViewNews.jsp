<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="false" %>
<%@ page import="ais.framework.acegi.SecurityContextUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html>
<head>
<title>新闻浏览</title>
<meta http-equiv="X-UA-Compatible" content="IE=8/9/10/11/Edge">
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />	
<style>
body{
	margin:0px;
	padding:0px;
	text-align:center;
	overflow:hidden;
}
*{
	font-size:13px;
	font-family:'微软雅黑';
}
.view_newshead{
	text-align:left;
	overflow:hidden;
	background-color:rgb(149,207,255);
}
.view_newstitle{
	padding:30px 10px 10px 10px;
	text-align:center;
	font-size:25px;
	font-weight:bolder;
}
.view_newsbody{
	margin-left: auto; 
	margin-right: auto;
	padding:0px 10px 10px 10px;
	line-height:25px;
}
.view_newscontent_wrap{
	padding:10px;
	border:1px solid #cccccc;
	margin-top:10px;
	margin-bottom:10px;
}
.view_newscontent{
	text-align:left;
	border-width:0px;
	padding:5px 10px 5px 10px;
	line-height:20px;
}
.view_newsbottom{
	color:gray;
	height:97px;
	text-align:center;
	overflow:hidden;
}
.view_newsbottom .newsbottom_bar{
	margin-bottom:5px;
	padding:10px;
	background-image:url(/ais/cloud/homeimg/ztNewsFoot.png);
	background-size:contain;
}
.returnTop{
	padding:10px 10px 10px 3px;
	border:1px solid #cccccc;
	background-color:#fcfcfc; 
	width:20px; 
	height:15px;
	position:absolute;
	right:18px;
	bottom:2px;
	font-weight:bolder;
	color:gray;
	cursor:pointer;
	display:none;
}
.returnFoot{
	padding:5px;
	border:1px solid #cccccc;
	background-color:#fcfcfc; 
	width:35px; 
	height:15px;
	position:absolute;
	right:18px;
	top:40px;
	font-weight:bolder;
	color:gray;
	cursor:pointer;
}
</style>		
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
<script type="text/javascript">
$(function(){
	var url = window.location.href;
	var arr = url.split('?');
	if(arr && arr.length > 1){
		var paramStr = arr[arr.length-1];
		var pArr = paramStr.split('&');
		var id = "";
		$.each(pArr,function(i,obj){
			var arr = obj.split('=');
			if(arr[0] == 'id'){
				id = arr[1];
				return false;
			}
		});
		//alert(id)
		if(id){
			$.ajax({
				url:"<%=request.getContextPath()%>/portal/firstgateway/gateWayViewNews.action", 
				type:'post',
				data:{'id':id.replace('#','')},
				dataType:'json',
				success:function(data){
					var newJson = data.sjnew;
					//alert(newJson.content)
					//alert(newJson.title)
					if(newJson.createdate){
						$('#createDate').html('【时间：'+newJson.createdate.substr(0,10)+"】");
					}
					$('.view_newstitle').html(newJson.title);
					$('#newsContent').html(changteTxt2Html(newJson.content));

					if(newJson.image && newJson.image.length > 0 && newJson.image[0]){
						 $('#newspic').attr('src',newJson.image[0]);
						 $('#newspicWrap').show();
					}else{
						//alert(2)
						$('#newspicWrap').hide();
					}
					$('#newFrom').text(newJson.fcompanyname ? newJson.fcompanyname : "未知");
				},
				error:function(){
					$.messager.alert('提示信息','请求失败！请检查网络是否通畅或与管理员联系！','error');
				}
			});
			
		}
	}
	function changteTxt2Html(content){
		return content.replace(/\t/gi,'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;')
		.replace(/\n\n|\r\r|\n\r|\r\n/gi,'<br>')
		.replace(/\s/,'&nbsp;&nbsp;&nbsp;&nbsp;');
	}
	
	function setContentFontsize(fsize){
		$('#newsContent,#newsContent *').css({
			'font-size':fsize+"px"
		});
	}
	
	$('#fontsize1').bind('click',function(){ setContentFontsize(20);});
	$('#fontsize2').bind('click',function(){ setContentFontsize(16);});
	$('#fontsize3').bind('click',function(){ setContentFontsize(12);});
	$('#fontsize1,#fontsize2,#fontsize3').css({
		'cursor':'pointer'
	});
	
	function resizeWindow(){
		var minW = 700;
		var maxW = 1100;
		var w = $(window).width()*0.9;
		var h = $(window).height();
		//alert((h-$('#newsHead').height()-20))
		//alert($('#newsHead').height())
		w = w < minW ? minW : w > maxW ? maxW : w;
		$('#newsBody').css({
			'width':w,
			'height':(h-$('#newsHead').height())
		});
		$('#newsHead').css('width',$(window).width());
	}
		
	$(window).bind('resize',function(){
		resizeWindow();
	});
	resizeWindow();
	
//	var picArr = ['6.jpg','7.jpg','8.jpg','u101.jpg','u103.jpg','u105.jpg','u107.jpg'];
//	var picindex = parseInt(picArr.length * Math.random());
//	$('#newspic').attr('src','/ais/cloud/homeimg/'+picArr[picindex]);
	
	$('.returnTop').bind('click',function(){
		var top = $('#newsWrap').scrollTop();
		if(top){
			$('#newsWrap').animate({
				scrollTop:0
			},500)
		}
	});
	$('.returnFoot').bind('click',function(){
		var height = $('#newsWrap')[0].scrollHeight;		
		$('#newsWrap').animate({
			scrollTop:height
		},500);
	});	
	$('#newsWrap').scroll(function(){
		var height = $('#newsWrap')[0].offsetHeight;
		var height2 = $('#newsWrap')[0].scrollHeight;
		var top = $(this).scrollTop();
		if(top){
			$('.returnTop').show();
		}else{
			$('.returnTop').hide();
		}
		if(top >= (height2-height)){
			$('.returnFoot').hide();
		}else{
			$('.returnFoot').show();
		}
	});
})

</script>
</head>
<body>
	<div id='newsWrap' style='overflow:auto;'>
		<div id='newsHead' class="view_newshead">
			<image  src='/ais/cloud/homeimg/ztHead.png' ></image>
		</div>
		<div id='newsBody'  class='view_newsbody' >
			<div class="view_newstitle"></div>
			<div style='padding:5px;text-align:center;'>
				<span id='createDate'></span>
				<span>【来源：<label id='newFrom'></label>】</span>
				<span>【字号：<a href='javascript:void(0);' id='fontsize1'>大</a>&nbsp;&nbsp;
					<a href='javascript:void(0);' id='fontsize2'>中</a>&nbsp;&nbsp;
					<a href='javascript:void(0);' id='fontsize3'>小</a>】
				</span>
			</div>
			<div class='view_newscontent_wrap'>
				<div id='newspicWrap' style='text-align:center;padding:5px;'>
					<image id='newspic' style='width:650px;height:450px;border-width:0px;'></image>
				</div>
				<div class="view_newscontent" id='newsContent' ></div>
			</div>
			<div class="view_newsbottom">
				<div class="newsbottom_bar"></div>
				<div class="bottom_txt">版权所有 中国铁路总公司 京 ICP备 10009636号</div>
				<div class="bottom_txt">地址：北京市复兴路10号0431-82098114</div>
				<div class="bottom_txt">技术支持：北京用友审计软件有限公司</div>
			</div>
		</div>
	</div>
	<div class='returnFoot' title='返回到底部'>FOOT</div>
	<div class='returnTop'  title='返回到顶部'>TOP</div>
	
</body>
</html>
