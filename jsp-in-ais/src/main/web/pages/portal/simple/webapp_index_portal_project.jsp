<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="ais.framework.util.MyProperty"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page
	import="java.io.OutputStream"%>
	
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>

<%@ page import="org.springframework.web.context.WebApplicationContext"%>

<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@ page import="ais.misc.BASE64Encoder" %>
<html>
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
		<!-- 消息js -->
		<script type='text/javascript' src='/ais/dwr/interface/InnerMsgService.js'></script>	
		<%// 下面的一行在本页的body.onload和onresize里加入了事件getMsg和resizeDiv,如要取消右下角消息时,要记得删除body事件 %>
		<jsp:include flush="true" page="/pages/msg/innerMsg_showPop.jsp" />		
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
		
		<%//add by fsj 20101113--增加联网审计审前调查
		WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
		ais.unitary.nc.service.UnitaryNCService s=	(ais.unitary.nc.service.UnitaryNCService)ctx.getBean("unitaryNCService");
        ais.unitary.nc.model.UnitaryNC unitaryNC = s.findUnitaryNCObject();
        String ncHost = unitaryNC==null?"":unitaryNC.getHost();
        String ncPort = unitaryNC==null?"":unitaryNC.getPort();
        BASE64Encoder encoder = new BASE64Encoder();
		String p=encoder.encodeBuffer((user.getFloginname()+",1").getBytes()).trim();
        %>		
		<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
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
		window.open(url,"","height=400px, width=500px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
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
		window.open(url,"","height=280px, width=300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
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
 
  //内部消息数量 add by chensb
 var innerMsgCnt="0";//站内消息数
 var innerMsgSubjects=new Array();
 function readInnerMsg(){
	 DWREngine.setAsync(true);
	 try
	 {
	   InnerMsgService.getInnerMsgCntAndTopNByIsRead('<%=user.getFloginname()%>',false,5,'msgId,subject',function(data){
		 innerMsgSubjects=data.toString().split("$");
		 $("innerMsgCnt").innerText="站内消息 ("+innerMsgSubjects[0]+")";
		 $("innerMsg_List_td").innerHTML=innerMsgSubjects[1];
		
		 if ("0"==innerMsgSubjects[0]){
			 closeDiv();//关闭消息
		 }else{//如果有新增的消息时，把不显示的打开，如没有新消息且是关闭的，就一直关闭吧。
			 if ( $("loft_win").style.visibility=="hidden" &&innerMsgCnt!=innerMsgSubjects[0]){
			    getMsg(); //显示消息
		   }
		 }
		 innerMsgCnt=innerMsgSubjects[0];
	   });
	   
	 }catch(E){
		　clearInterval(readInnerMsg_timer);
	  }	
 } 
 readInnerMsg();
 var readInnerMsg_timer=setInterval('readInnerMsg()',300000);　　//1000毫秒=1秒,默认5分钟
//站内消息 by chensb end

</script>
	</head>
	<body onload="openNewWindow();initAutoHeight();" onresize="doResize();" scroll="no" topmargin="0">
		<div style="clear: both; height: 85px;">
			<jsp:include page="header.jsp"></jsp:include>
			<div id="toolbar" style="width: 100%; text-align: left;"></div>
			<div id="mention">
				<table border=0 width="100%">
					<tr>
						<script>
							Date.prototype.getWeek = function(){
								return ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"][curr_date.getDay()];
							}
							var curr_date = new Date();
							document.writeln("<td class='text1' style='text-align: center; width: 150px; '>" + curr_date.getYear() + "年" + (curr_date.getMonth()+1) + "月" + curr_date.getDate() + "日&nbsp;&nbsp;" + curr_date.getWeek() + "</td>");
						</script>
						<td style="text-align: left">
							
							<li class="text1">
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
						<td>
							<s:if test="${idea_number!=0}">
								<a style="cursor: hand;" class="text1" 
									onclick="window.open('<s:url action="issuesProjectList" namespace="/project/feedback/online"><s:param name="information.type" value="3"/><s:param name="view" value="1"/></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">您有${idea_number }个项目可以反馈</a>
							</s:if>
							<s:else>
								<a style="cursor: hand;" class="text1" 
									onclick="window.open('<s:url action="issuesProjectList" namespace="/project/feedback/online"><s:param name="information.type" value="3"/><s:param name="view" value="1"/></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">点击查看反馈信息</a>
							</s:else>
						</td>
						
						<s:if test="${manu_number}!=0">
							<td>
								<a style="cursor: hand;" class="text1" 
									onclick="window.open('<s:url action="feedbackManu" namespace="/operate/feedback"></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">您有${manu_number}条底稿未反馈</a>
							</td>
						</s:if>
						
						<s:if test="${projectInReworkCount!=0}">
							<td>
								<a style="cursor: hand;" class="text1" 
									onclick="window.open('${contextPath}/project/listAll.action?crudObject.searchStage=rework_closed&crudObject.stageStatus=0','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">您有${projectInReworkCount}个项目已经进入整改跟踪阶段</a>
							</td>
						</s:if>
						
						<s:if test="${projectProblemInReworkCount!=0}">
							<td>
								<a style="cursor: hand;" class="text1" 
									onclick="window.open('${contextPath}/proledger/problem/findLedgerProblemMendLedgerList.action','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">您有${projectProblemInReworkCount}个审计问题已进入整改跟踪</a>
							</td>
						</s:if>
						
						<td style="text-align: right">
							<img alt="站内消息" src="<%=request.getContextPath()%>/images/msg.jpg"><a style="cursor: hand;" id="innerMsgCnt" class="text1" target="_blank" onclick="window.open('${contextPath}/pages/msg/innerMsg_index.jsp','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">站内消息</a>
							<s:if test="user.floginname!='guest'">
								<a style="cursor: hand;" class="text1" onclick="openwindow('/ais/general/acntMng.action','',350,320)">账号管理</a>
								<%--<a style="cursor: hand;" class="text1" onclick="openwindow('/ais/general/changePassWord.jsp','',310,280)">密码维护</a>--%>
							</s:if>
							&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/portal/xxian.gif" class="text1" width="2" height="12">&nbsp;&nbsp;<a style="cursor: hand;" class="text1" onclick="window.location='<%=request.getContextPath()%>/system/uSystemAction!loginOut.action'">注销</a>&nbsp;&nbsp;
							<div id="show" style="display:inline"><img src="<%=request.getContextPath()%>/images/portal/xxian.gif" class="text1" width="2" height="12"><img alt="隐藏标题图片" align="top" src="<%=request.getContextPath()%>/images/portal/mm_1.gif" onclick="fullscreen()" onmouseout="this.src='<%=request.getContextPath()%>/images/portal/mm_1.gif'" onmouseover="this.src='<%=request.getContextPath()%>/images/portal/mm_2.gif'" style="cursor: hand;height:20px"/>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/portal/xxian.gif" class="text1" width="2" height="12"></div>
						</td>
					</tr>
				</table>
			</div>
			<iframe name="basefrm" id="basefrm"
				src="<%=request.getContextPath()%>/portal/simple/simple-firstPageAction!show.action"
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
		/*
		onAllLoad(function(){
			var tb = new createToolbar("toolbar");
			insDefaultMenu(tb, "首　　页", "<%=request.getContextPath()%>/portal/simple/simple-firstPageAction!show.action","basefrm");
			insMainMenu4protal(tb, "审计管理系统", false,"<%=request.getContextPath()%>/portal/simple/simple-firstPageAction!menu.action?showmenu=gl", "");
			insMainMenu4protal(tb, "在线作业系统", false,"<%=request.getContextPath()%>/portal/simple/simple-firstPageAction!menu.action?showmenu=zx", "");
			insMainMenu(tb, "分析预警系统", false,"http://<%=ncHost+":"+ncPort%>/login2.jsp?p=<%=p%>", "");
		});*/
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

