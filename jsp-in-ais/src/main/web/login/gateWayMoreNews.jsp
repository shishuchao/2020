<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="false" %>
<%@ page import="ais.framework.acegi.SecurityContextUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html>
<head>
<title>新闻列表</title>
<meta http-equiv="X-UA-Compatible" content="IE=8/9/10/11/Edge">
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />	
<style>
body{
	margin:0px;
	padding:0px;
	text-align:center;
}
*{
	font-size:13px;
	font-family:'微软雅黑';
}
div a:link {
	color: currentColor; 
	text-decoration:none;	
} 
input:hover,div a:hover  {
	color: blue; 	
}
.view_newshead{
	text-align:left;
	overflow:hidden;
	background-color:rgb(149,207,255);

	margin:0px;
}

.view_newsbody{
	margin-left: auto; 
	margin-right: auto;
	padding:0px 10px 10px 10px;
	line-height:20px;
}
.view_newscontent_wrap{
	padding:10px;
	border:1px solid #d4dbe6;
	border-top:5px solid #d4dbe6;
	height:350px;
}
.view_newscontent{
	text-align:left;
	border-width:0px;
	padding:5px 10px 5px 10px;
	line-height:30px;
}
.view_newsbottom{
	color:gray;
	height:90px;
	text-align:center;
	overflow:hidden;
}
.view_newsbottom .newsbottom_bar{
	margin-bottom:5px;
	padding:10px;
	background-image:url(/ais/cloud/homeimg/ztNewsFoot.png);
	background-size:contain;
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
		var type = "";
		$.each(pArr,function(i,obj){
			var arr = obj.split('=');
			if(arr[0] == 'type'){
				type = arr[1];
				return false;
			}
		});
		if(type){
			$.ajax({
				url:"<%=request.getContextPath()%>/portal/firstgateway/gateWayViewNewsList.action", 
				type:'post',
				data:{'type':type.replace('#','')},
				dataType:'json',
				success:function(data){
					var typeName = data.typeName;
					var newsList = data.newsList;
					$.each(newsList,function(i, info){
						var row = document.createElement('div');
						var newsUrl = "gateWayViewNews.jsp?id="+info.id;
						if(type == '10'){
							newsUrl = info.infkey;
						}
						$(row).css({
							'line-height':'25px',
							'height':'25px',
							'padding':'2px 5px 5px 10px',
							'clear':'both'
						}).append("<div style='text-align:left;float:left;width:450px;'><li><a target='_blank' href="+newsUrl+">"+info.title+"</a></li></div>")
						.append("<div style='text-align:right;float:right;width:100px;'>"+info.createdate.substr(0,10)+"</div>");
						$('#newsList').append(row);
					});
					$('#newsListHead').append("<div style='float:left;text-align:left;width:300px;font-size:18px;color:gray;'><image src='/ais/cloud/homeimg/newsListLeft.png'></image>&nbsp;&nbsp;"+typeName+"</div>")
					.append("<div style='float:right;width:20px;'><image src='/ais/cloud/homeimg/u40.png' style='margin-top:7px;width:13px;height:13px;'></image></div>");
					
					$('#newsPaging').append();
				},
				error:function(){
					$.messager.alert('提示信息','请求失败！请检查网络是否通畅或与管理员联系！','error');
				}
			});
			
		}
	}


	
	function resizeWindow(){
		var minW = 600;
		var maxW = 800;
		var w = $(window).width()*0.6;
		var h = $(window).height();
		//alert((h-$('#newsHead').height()-20))
		//alert($('#newsHead').height())
		w = w < minW ? minW : w > maxW ? maxW : w;
		$('#newsBody').css({
			'width':w,
			'height':(h-$('#newsHead').height()-15)
		});
		$('#newsHead').css('width',$(window).width());
	}
		
	$(window).bind('resize',function(){
		resizeWindow();
	});
	resizeWindow();
	
})

</script>
</head>
<body>
	<div id='newsHead' class="view_newshead">
		<image  src='/ais/cloud/homeimg/ztHead.png' ></image>
	</div>
	<div id='newsBody'  class='view_newsbody' >
		<div id="newsListHead" style='padding:10px 10px 30px 10px;'></div>
		<div class='view_newscontent_wrap'>
			<div id="newsList" ></div>
		</div>
		<div id="newsPaging" style='padding:10px;height:20px;' >
			<div style='float:right;'>
			<input type='button' value='1' style='background-color:#F9F9F9;border:1px solid #d4dbe6;color:gray;text-align:center;width:20px;'/>
			<input type='button' value='2' style='background-color:#F9F9F9;border:1px solid #d4dbe6;color:gray;text-align:center;width:20px;'/>
			<input type='button' value='3' style='background-color:#F9F9F9;border:1px solid #d4dbe6;color:gray;text-align:center;width:20px;'/>
			<input type='button' value='4' style='background-color:#F9F9F9;border:1px solid #d4dbe6;color:gray;text-align:center;width:20px;'/>
			<input type='button' value='5' style='background-color:#F9F9F9;border:1px solid #d4dbe6;color:gray;text-align:center;width:20px;'/>
			<input type='button' value='下一页' style='background-color:#F9F9F9;border:1px solid #d4dbe6;color:gray;text-align:center;width:60px;'/>
			<input type='button' value='尾页' style='background-color:#F9F9F9;border:1px solid #d4dbe6;color:gray;text-align:center;width:60px;'/>
			</div>
		</div>
		<div class="view_newsbottom">
			<div class="newsbottom_bar"></div>
			<div class="bottom_txt">版权所有 中国铁路总公司 京 ICP备 10009636号</div>
			<div class="bottom_txt">地址：北京市复兴路10号0431-82098114</div>
			<div class="bottom_txt">技术支持：北京用友审计软件有限公司</div>
		</div>
	</div>

</body>
</html>
