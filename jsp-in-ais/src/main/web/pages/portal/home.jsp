<%@ page language="java" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><%=SysParamUtil.getSysParam("ais.portal.title")%></title>
		
		<link href="${contextPath}/resources/css/site.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/portal/css.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/portal/portal.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${contextPath}/scripts/portal/ext-base.js"></script>	
		<script type="text/javascript"
			src="${contextPath}/scripts/portal/ext-all.js"></script>	
		<script type="text/javascript"
			src="${contextPath}/scripts/portal/menus.js"></script>	
			
		<s:head theme="ajax" />
		
		<script type="text/javascript">
			var focus_width = 174;
			var focus_height = 155;
			var text_height = 20;
			var swf_height = focus_height + text_height;
			var pics = "";
			var links = "";
			var texts = "";
		</script>

		<script type="text/javascript">
			function ellipsisStr(str, len){
				if(str.length > len)
					document.write(str.substr(0, len) + "...");
				else
					document.write(str);
			}
			function onLinkChange(url){
				if(url != "")
					window.open(url,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
			}
			
			function feedback(){
			window.open("${contextPath}/project/feedback/idea/loginLink.action","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
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
		</script>

	</head>
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
		%>
	<body>
		<div style="clear: both; height: 110px;">
			<jsp:include page="../header.jsp"></jsp:include>
			<div id="toolbar" style="width: 955px; text-align: left;">
			</div>
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
								当前用户：${sessionScope.user.fname }
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所在部门：${sessionScope.organization.fname }
							
							</li>
						</td>
						<td style="text-align: right">
							<font color="#6a7a98">${passwordOverstep}</font>&nbsp;&nbsp;
							<a style="cursor: hand;" class="text1" onclick="openwindow('/ais/general/changePassWord.jsp','',310,280)">密码维护</a>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/portal/xxian.gif" class="text1" width="2" height="12">&nbsp;&nbsp;<a style="cursor: hand;" class="text1" onclick="window.location='<%=request.getContextPath()%>/system/uSystemAction!loginOut.action'">注销</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</table>
			</div>
			<div id="content">
				<div id="content_left">
					<div class="bmgg">
						<s:include value="portlet/studyGarden.jsp"></s:include>
					</div>
					<div class="bmgg">
						<s:include value="portlet/friendLinks.jsp"></s:include>
					</div>
				</div>
	
				<div id="content_center">
					<div class="sjdt">
						<jsp:include page="portlet/pendings.jsp"></jsp:include>
					</div>
					<div class="sjdt">
						<jsp:include page="portlet/trends.jsp"></jsp:include>
					</div>
				</div>
	
				<div id="content_right">
					<div class="gzzn">
						
						<jsp:include page="portlet/projects.jsp"></jsp:include>
					</div>
					<div class="gzzn">
						<jsp:include page="portlet/bulletins.jsp"></jsp:include>
					</div>
				</div>
			</div>
			<div id="foot">
				<table width="95%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="70%" height="36">
							&nbsp;
						</td>
						<td width="30%" valign="bottom" class="text1">
							${copyright }&nbsp;
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
	<script type="text/javascript">		
		onAllLoad(function(){
			var tb = new createToolbar("toolbar");
			//insDefaultMenu(tb, "首　　页", "${contextPath}/portal/systemPortal.action","_self");
			<s:iterator value="menus">
			    var bt = insMainMenu1(tb, "${title}", false, "${url}", "_blank",${enabled});
			</s:iterator>
			
		});
	</script>
</html>

