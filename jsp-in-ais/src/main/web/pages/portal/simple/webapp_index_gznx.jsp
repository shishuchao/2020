<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="ais.framework.util.MyProperty"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page
	import="java.io.OutputStream"%>

<%@page import="ais.sysparam.util.SysParamUtil"%><html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="<%=request.getContextPath()%>/resources/css/site.css"
			rel="stylesheet" type="text/css">
		<link href="<%=request.getContextPath()%>/styles/portal/css.css"
			rel="stylesheet" type="text/css">
		<link href="<%=request.getContextPath()%>/styles/portal/portal.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-portal.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/menus.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/examples.js"></script>
			
			
		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>

		<%

		String u="";
		 Cookie[] cookies = request.getCookies();
	     if (cookies != null) {
		     for (int i=0; i< cookies.length; i++) { 
			     if (cookies[i].getName().equals("ais_u")){
				     u = cookies[i].getValue();
				     break; 
			     }
		     }
	     }
		String pStr = MyProperty.getProperties("ais.portal");
	
		ais.user.model.UUser user = (ais.user.model.UUser) session
				.getAttribute("user");
		String name = "";
		if (user != null) {
			name = user.getFname();
		}
		ais.organization.model.UOrganization orga = (ais.organization.model.UOrganization) session
				.getAttribute("organization");
			
		%>
		<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
		}
		.x-toolbar{
			border-color:#a9bfd3;border-style:solid;
			border-width:0 0 1px 0;
			display:block;padding:2px;
			background:#00576c url(../../images/portal/menuback_gznx.gif) repeat-x top left;
			position:relative;
			zoom:1;
		}
		#mention {
			width: 100%;
			height: 18px;
			margin-top: 0px;
			vertical-align: middle;
			text-align: center;
			color:#000;
			background-image:url(../../images/portal/mention.jpg);
			background-repeat: repeat;
		}
		BUTTON{
			color:#FFFFFF;
		}
		#foot {
			text-alin: right;
			margin-bottom: 0px;
			width: 100%;
			height: 37px;
			background: #00576c url(../../images/portal/foot_26.gif) repeat-x top left;
		}
		-->
		</style>
		<title><%=SysParamUtil.getSysParam("ais.portal.title")%></title>
<script>
//zhouting 添加 系统通知
var isOpenWindow = '<s:property  value="isOpenWindow"/>';
function openNewWindow(){
	if(isOpenWindow=="true" ){
		var url = "${contextPath}/portal/simple/sysViewFirst.action?hasRemindMessage=${hasRemindMessage}&hasPersonalProgramme=${hasPersonalProgramme}";
		window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
}
	
//校验是否打开窗口
function isOpenWindow_fun(){
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/portal/simple', action:'sysView', executeResult:'false' }, 
			{'isOpenWindow':isOpenWindow},
			xxx);
			function xxx(data){
			 isOpenWindow = data['isOpenWindow'];
			}
	if(isOpenWindow=="true" ){
		var url = "${contextPath}/portal/simple/sysView.action";
		window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}
}


	
//定时系统提示
var begin;
function go(){
   begin = setInterval('isOpenWindow_fun()',300000);　　//1000毫秒=1秒,默认500000

}

//停止系统提示<%=pStr%>
function stopx(){
　　clearInterval(begin);
}
function openwindow(url,name,iWidth,iHeight)
 {
  var url;                                 //转向网页的地址;
  var name;                           //网页名称，可为空;
  var iWidth;                          //弹出窗口的宽度;
  var iHeight;                        //弹出窗口的高度;
  var iTop = (window.screen.availHeight-iHeight)/2;       //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-iWidth)/2;           //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=no,resizeable=yes,location=no,status=no');
 }                                                                                                                              
  function showOnLine(){
 	openwindow("${contextPath}/system/uSystemAction!onLineUsers.action","在线人员",500,400);
 }
</script>
	</head>
	<body onload="openNewWindow();initAutoHeight();" onresize="doResize();" scroll="no" topmargin="0">
		<div style="clear: both; height: 85px;">
			<jsp:include page="header.jsp"></jsp:include>
			<div id="toolbar" style="text-align: left;"></div>
			<div id="mention">
				<table border=0 width="100%">
					<tr>
						<script>
							Date.prototype.getWeek = function(){
								return ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"][curr_date.getDay()];
							}
							var curr_date = new Date();
							document.writeln("<td class='text1' style='text-align: center; color:#000;width: 150px; '>" + curr_date.getYear() + "年" + (curr_date.getMonth()+1) + "月" + curr_date.getDate() + "日&nbsp;&nbsp;" + curr_date.getWeek() + "</td>");
						</script>
						<td style="text-align: left">
							
							<li class="text1" style='color:#000;'>
								当前用户：<%
									if (user.getFname() != null) {
									out.print(user.getFname());
								}
							%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所在部门：<%
									if (orga.getFname() != null) {
									out.print(orga.getFname());
								}
							%>
							
							</li>
						</td>
						<td style="text-align: right">
						<s:if test="user.floginname!='guest'">
							<a style="cursor: hand;" class="text1"  style='color:#000;' onclick="openwindow('/ais/general/changePassWord.jsp','',310,280)">密码维护</a>
						</s:if>	
							&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/portal/xxian.gif" class="text1" width="2" height="12">&nbsp;&nbsp;<a style="cursor: hand;color:#000;" class="text1" onclick="window.location='<%=request.getContextPath()%>/system/uSystemAction!loginOut.action'">注销</a>&nbsp;&nbsp;
							<div id="show" style="display:inline"><img src="<%=request.getContextPath()%>/images/portal/xxian.gif" class="text1" width="2" style="color:#000;" height="12"><img alt="隐藏标题图片" align="top" src="<%=request.getContextPath()%>/images/portal/mm_1.gif" onclick="fullscreen()" onmouseout="this.src='<%=request.getContextPath()%>/images/portal/mm_1.gif'" onmouseover="this.src='<%=request.getContextPath()%>/images/portal/mm_2.gif'" style="cursor: hand;height:20px"/>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/portal/xxian.gif" class="text1" width="2" height="12"></div>
						</td>
					</tr>
				</table>
			</div>
			<iframe name="basefrm" id="basefrm"
				src="<%=request.getContextPath()%>/portal/simple/simple-firstPageAction!show_gznx.action"
				width="100%" scrolling="auto" height="502" frameborder="0" border="0" onload="doAutoHeight();">
			</iframe>
			<div id="foot">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="30%" align="right" height="36" valign="bottom" class="text1">
							<%=request.getAttribute("copyright") %>&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</table>
			</div>

		</div>
	</body>
	<script type="text/javascript">
		onAllLoad(function(){
			var tb = new createToolbar("toolbar");
			insDefaultMenu(tb, "首　　页", "<%=request.getContextPath()%>/portal/simple/simple-firstPageAction!show_gznx.action","basefrm");
			<s:iterator value="menuList">
				<s:if test="${fparentid==1}">
					<s:if test="${isHaveChild=='Y'}">
						var N${ffunid} = insMainMenu(tb, "${ffundisplay}", true,"", "${target}");
					</s:if>
					<s:else>
						var N${ffunid} = insMainMenu(tb, "${ffundisplay}", false,"${flink}", "${target}");
					</s:else>
				</s:if>
			    <s:else>
					<s:if test="${isHaveChild=='Y'}">
			    		var N${ffunid} = insMenu(N${fparentid}, "${ffundisplay}", true, "", "${target}");
					</s:if>
					<s:else>
						var N${ffunid} = insMenu(N${fparentid}, "${ffundisplay}", false, "${flink}", "${target}");
					</s:else>			
			    </s:else>
			</s:iterator>
			insDefaultMenu(tb, "联系我们", "<%=request.getContextPath()%>/portal/simple/simple-firstPageAction!contantUs.action","_blank");
		});
 function setAutoHeight() {
	 var iframeElement=document.getElementById("basefrm");
	 var iframeWindow=window.frames[0];
	 var height=iframeWindow.document.body.scrollHeight;
	iframeElement.style.height = iframeWindow.document.body.scrollHeight+200;

}
function doResize(){
	if(document.body.clientHeight>139)
    document.all.basefrm.style.height = document.body.clientHeight-139;
	if(document.body.clientWidth<600){
		document.getElementById("header_default").style.width="600px";
	}else{
		document.getElementById("header_default").style.width="100%";
	}
}
function initAutoHeight(){
	if(document.body.clientHeight>139)
	document.getElementById("basefrm").style.height = document.body.clientHeight-139;
}
function doAutoHeight() {
	var obj = document.getElementById("header_default").style.display;
	if(obj!="block"){
		fullscreen();
	}else{
		nomalscreen();
	}
}
function fullscreen(){
	var toolbar = document.getElementById("toolbar");
	var mention = document.getElementById("mention");  
	toolbar.style.width = window.screen.availWidth;
	mention.style.width = window.screen.availWidth;
	var show = document.getElementById("show");
	show.innerHTML = "<img src=\"<%=request.getContextPath()%>/images/portal/xxian.gif\" class=\"text1\" width=\"2\" height=\"12\"><img title=\"显示标题图片\" align=\"top\" src=\"<%=request.getContextPath()%>/images/portal/mm_1.gif\" onclick=\"nomalscreen()\" onmouseout=\"this.src='<%=request.getContextPath()%>/images/portal/mm_1.gif'\" onmouseover=\"this.src='<%=request.getContextPath()%>/images/portal/mm_2.gif'\" style=\"cursor: hand;height:20px\"/>";
	var basefrm = document.getElementById("basefrm");
	basefrm.style.height = document.body.clientHeight-86;

	document.getElementById("header_default").style.display="none";
}
function nomalscreen(){
	var toolbar = document.getElementById("toolbar");
	var mention = document.getElementById("mention");
	toolbar.style.width = window.screen.availWidth;
	mention.style.width = window.screen.availWidth;
	var show = document.getElementById("show");
	show.innerHTML = "<img src=\"<%=request.getContextPath()%>/images/portal/xxian.gif\" class=\"text1\" width=\"2\" height=\"12\"><img title=\"隐藏标题图片\" align=\"top\" src=\"<%=request.getContextPath()%>/images/portal/mm_1.gif\" onclick=\"fullscreen()\" onmouseout=\"this.src='<%=request.getContextPath()%>/images/portal/mm_1.gif'\" onmouseover=\"this.src='<%=request.getContextPath()%>/images/portal/mm_2.gif'\" style=\"cursor: hand;height:20px\"/>";
	var basefrm = document.getElementById("basefrm");
	if(document.body.clientHeight>139)
			basefrm.style.height = document.body.clientHeight-139;
	document.getElementById("header_default").style.display="block";
}
</script>
</html>

