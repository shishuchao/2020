<%@page import="ais.user.model.UUser"%>
<%@page import="ais.sysparam.util.SysParamUtil"%>
<%@page import="ais.framework.util.StringUtil"%>
<%@ page language="java" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="ais.portal.simple.model.Information"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
	<head>
		<title>门户1</title>

		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<%
			response.setHeader("Expires","0");
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Pragma","no-cache");
		%>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom:0px;
	background-color: #C9CACB;
}
a {
	text-decoration: none;
}

a:link {
	color: #47a;
	text-decoration: none;
}

a:visited {
	color: #666;
	text-decoration: none;
}

a:active,a:hover {
	color: #900;
	text-decoration: none;
}
div{
	display:block;
	width:100%;
	white-space:nowrap;
	float:left;
	white-space:nowrap;
	overflow:hidden;
	word-break:break-all;
    -o-text-overflow: ellipsis;    /**//* for Opera */
    text-overflow:ellipsis;        /**//* for IE */
}
div:after{
	content:"...";
	padding-left:3px;
	font-size:12px;
}
.main_left_top{
	width: 4px;
	height: 4px;
	background-image: url(${contextPath}/images/portal/main-left-top.jpg);
	empty-cells: show;
}
.main_right_top{
	width: 5px;
	height: 4px;
	background-image: url(${contextPath}/images/portal/main-right-top.jpg);
	empty-cells: show;
}
.main_top{
	height: 4px;
	background-image: url(${contextPath}/images/portal/main-top.jpg);
	background-repeat: repeat-x;
	empty-cells: show;
}
.main_left{
	width: 4px;
	background-image: url(${contextPath}/images/portal/main-left.jpg);
	background-repeat: repeat-y;
	empty-cells: show;
}
.main_right{
	width: 4px;
	background-image: url(${contextPath}/images/portal/main-right.jpg);
	empty-cells: show;
	background-repeat: repeat-y;
}
.main_bottom{
	height: 4px;
	background-image: url(${contextPath}/images/portal/main-bottom.jpg);
	empty-cells: show;
	background-repeat: repeat-x;
}
.main_left_bottom{
	width: 4px;
	height: 5px;
	background-image: url(${contextPath}/images/portal/main-left-bottom.jpg);
	empty-cells: show;
}
.main_right_bottom{
	width: 5px;
	height: 5px;
	background-image: url(${contextPath}/images/portal/main-right-bottom.jpg);
	empty-cells: show;
}
.btn{
	padding: 2 4 0 4;
	font-size:12px;
	height:23;
	background-color:#ece9d8;
	border-width:1;
}
.name {
	font-family: "宋体";
	font-size: 9pt;
	color: #000000;
	line-height: normal;
}
.input {
	font-family: "宋体";
	font-size: 9pt;
	background-color:#bad0ef;
	height: 20px;
	width: 122px;
}
.line {
	border-bottom-width: 1px;
	border-bottom-style: dashed;
	border-bottom-color: #666666;
	font-family: "宋体";
	font-size: 9pt;
	color: #333333;
	vertical-align: bottom;
	text-align: left;
	text-indent: 6px;
	height: 25px;
}
.span1{
	border:#F29A10 1px solid;
	color:white;
	font-size:7px;
	height:8px;
	width:3px;
	background-color:#F29A10;
}
-->
</style>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/object-swap.js"></script>
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		<script type="text/javascript">
			var focus_width = 239;
			var focus_height = 150;
			var text_height = 20;
			var swf_height = focus_height + text_height;
			var pics = "";
			var links = "";
			var texts = "";
			<%
				String picsStr = "";
				String linksStr = "";
				String textsStr = "";
				java.util.Map map = (java.util.Map) request.getAttribute("map");
				List newsList = (List) map.get("picTrends");
				for(int i=0; i<newsList.size(); i++){
					Information inf = ((Information)newsList.get(i));
					String image = request.getContextPath()+"/images/portal/pic/"+inf.getUuid2()+inf.getCategory2_name();
					if(image!=null&&!"".equals(image)){
						picsStr += (image!=null?image:"") + "|";
						
						String url= request.getContextPath()+"/portal/simple/information/viewByType.action?id="+((Information)newsList.get(i)).getId();
						linksStr += url + "|";
						String title = ((Information)newsList.get(i)).getTitle();
						textsStr += (title.length()>19?(title.substring(0,19)+"..."):title) + "|";
					}
				}
				if(picsStr != null && !picsStr.equals("")){
			%>
				pics = '<%=picsStr.substring(0, picsStr.length() - 1)%>';
			<%
				}if(linksStr != null && !linksStr.equals("")){
			%>
				links = '<%=linksStr.substring(0, linksStr.length() - 1)%>';
			<%
				}if(textsStr != null && !textsStr.equals("")){
			%>
				texts = '<%=textsStr.substring(0, textsStr.length() - 1)%>';
			<%
				}
			%>
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
			var result = 'false';
			function submitForm(){
				var userType = "${sessionScope.user.floginname}";
				var userName = document.getElementById('userName').value.replace(/\s+$|^\s+/g,"");
				var passWord = document.getElementById('passWord').value.replace(/\s+$|^\s+/g,"");
				
				if(userType!='guest'){
					alert('对不起！您是系统用户不必在此登录！');
					return;
				}
				if(!userName){
					alert('用户名不能为空！');
					return;
				}
				if(!passWord){
					alert('密码不能为空！');
					return;
				}
				var judge1 = true;
		       var judge2 = false;
		       var pro_id = "";
		       //判断该用户是否存在
		  		DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/feedback/idea', action:'checkUserPassWord', executeResult:'false' }, 
				{'userName':userName,'passWord':passWord},
				xxx2);
				function xxx2(data){
					judge1 = data['bool_js'];
					judge2 = data['bool_js1'];//工作底稿反馈校验
					pro_id = data['info'];//工作底稿返回的id
				}
				if(!judge1){
				alert("登陆失败！帐户密码无效，请确认是否存在或过期。");
				return false;
				}
				document.getElementById('pageForm').submit();
			}
		</script>		
	</head>

	<body>
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="268" align="left" valign="top">
					<table width="268" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="3" background="${contextPath}/images/portal/ycsy_13.gif" height="17">
							</td>
						</tr>
						<tr>
							<td width="15" height="542" valign="top"
								background="${contextPath}/images/portal/ycsy_14.gif">
							</td>
							<td width="239" align="center" valign="top" bgcolor="#E6E6E6">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="9%" height="25" align="center" valign="middle"
											bgcolor="#adc6dd" style="border-left:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
                                            <img src="/ais/images/portal/Play.png" width="20" height="20" />
										</td>
										
										<td width="70%" align="left" valign="middle" bgcolor="#adc6dd"
											class="name" style="border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
											
														图片新闻
												
										</td>
										<td width="20%" align="center" valign="middle"
											bgcolor="#adc6dd" style="border-right:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
											<a style="font:8pt"
											onclick="window.open('<s:url action="searchByType" namespace="/portal/simple/information"><s:param name="helper.infoType" value="3"/><s:param name="view" value="1"/></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
											href="javascript:void(0);">更多</a>
										</td>
									</tr>
                                    <tr >
                                    <td height="1">
                                    </td>
                                    </tr>
									<tr>
										<td height="170" colspan="3" align="center" valign="top">
										<div style="display: 'none'">
											<s:iterator value="map['picTrends']" id="row">
												<img border="0" height="120" width="85" src="${contextPath }/images/portal/pic/${row.uuid2}${row.category2_name}">
											</s:iterator>
										</div>
										<script type="text/javascript">
											document.writeln('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="' + focus_width + '" height="' + swf_height + '">');
											document.writeln('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="<%=request.getContextPath()%>/images/portal/news.swf"><param name="quality" value="high"><param name="bgcolor" value="#eeeeee">');
											document.writeln('<param name="menu" value="false"><param name="wmode" value="opaque">');
											document.writeln('<param name="FlashVars" value="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=' + focus_width + '&borderheight=' + focus_height + '&textheight=' + text_height + '">');
											document.writeln('<embed src="<%=request.getContextPath()%>/images/portal/news.swf" wmode="opaque" FlashVars="pics=' + pics + '&links=' + links + '&texts=' + texts + '&borderwidth=' + focus_width + '&borderheight=' + focus_height + '&textheight=' + text_height + '" menu="false" bgcolor="#ffffff" quality="high" width="' + focus_width + '" height="' + swf_height + '" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
											document.writeln('</object>');
										</script>
										</td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="9%" height="25" align="center" valign="middle"
											bgcolor="#adc6dd" style="border-left:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
                                            <img src="/ais/images/portal/Play.png" width="20" height="20" />
										</td>
										<td width="70%" align="left" valign="middle" bgcolor="#adc6dd"
											class="name" style="border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
											
														审计通知
												
										</td>
										<td width="20%" align="center" valign="middle"
											bgcolor="#adc6dd" style="border-right:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;"><a title="more..." style="font:11px"
											href="${contextPath}/bpm/systemprompt/viewTenDays.action" >
											更多
											</a>
										</td>
									</tr>
									<tr>
										<td height="<s:property value="map['systemNotify'].size*20"/>" colspan="3" align="center" valign="top">
											<table width="90%" border="0" cellspacing="0" cellpadding="0" valign="top">
												<s:iterator value="map['systemNotify']" id="row">
													<tr>
														<td height="25" class="line" nowrap="nowrap"> 
														<div><span class='span1'>></span>&nbsp;
															<a
																onclick="window.open('/ais/bpm/systemprompt/viewDetailSystemPrompt.action?id=${row.id }','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
																href="javascript:void(0);" title="${row.description}">
																${row.description}
															</a></div>
														</td>
													</tr>
												</s:iterator>
											</table>
										</td>
									</tr>
									<tr>
										<td colspan="3">
											&nbsp;
										</td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="9%" height="25" align="center" valign="middle"
											bgcolor="#adc6dd" style="border-left:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
                                            <img src="/ais/images/portal/Play.png" width="20" height="20" />
										</td>
										<td width="70%" align="left" valign="middle" bgcolor="#adc6dd"
											class="name" style="border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
														学习园地
										</td>
										<td width="20%" align="center" valign="middle"
											bgcolor="#adc6dd" style="border-right:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
											<a style="font:11px"
											onclick="window.open('${contextPath }/portal/simple/information/gardenPlotSearch.action?view=1','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
											href="javascript:void(0);">更多</a>
										</td>
									</tr>
									<tr>
										<td height="235" colspan="3" align="center" valign="top">
											<table width="90%" border="0" cellspacing="0" cellpadding="0">
												<s:iterator value="map['studyGraden']" id="row">
												<tr>
													<td height="25" class="line"><div>
													<s:if test="${row.new}">
															<span style="font-size:8px;text-align:left;color:#F29110;font-weight:bold;">NEW </span>&nbsp;
														</s:if>
														<s:else><span class='span1'>></span>&nbsp;</s:else>
													<a
															onclick="window.open('${contextPath }/portal/simple/information/gardenPlotView.action?studyGardenPlot.id=${row.id }','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
															href="javascript:void(0);" title="${row.title }">
														${row.title}</a></div>
													</td>
												</tr>
											</s:iterator>
											</table>
										</td>
									</tr>
								</table>
							</td>
							<td width="14" height="542"
								background="${contextPath}/images/portal/ycsy_16.gif">
							</td>
						</tr>
						<tr>
							<td colspan="3" background="${contextPath}/images/portal/ycsy_18.gif" height="14">
							</td>
						</tr>
					</table>

					<table width="268" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td background="" height="32">
								<s:if test="${not empty(map['contactUs'])}">
								<s:iterator value="map['contactUs']" id="row">
									<a href="javascript:;" onclick="window.open('${contextPath}/portal/simple/information/viewByType.action?information.type=11&information.id=${row.id}','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');">
										<img src="${contextPath}/images/portal/ycsy_19.gif" alt="${row.title }" height="32" width="268" border="0"/>
									</a>
								</s:iterator>
								</s:if>
								<s:else><img src="${contextPath}/images/portal/ycsy_19.gif" alt="联系我们" height="32" width="268" border="0"/></s:else>
							</td>
						</tr>
					</table>


				</td>
				<td align="center" valign="top">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr>
							<td class="main_left_top"></td>
							<td class="main_top"></td>
							<td class="main_right_top"></td>
						</tr>
						<tr>
							<td class="main_left"></td>
							<td align="center" style="padding-top: 12px;" bgcolor="#FFFFFF">
								<table width="98%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="3%" height="25" align="center" valign="middle"
											bgcolor="#c6c6c6" style="border-left:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
										<img src="/ais/images/portal/Play.png" width="20" height="20" />
										</td>
										<td width="7%" align="left" valign="middle" style="background-color:#c6c6c6;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;"
											class="name">
											待办事项
										</td>
										<!-- <td width="10%" align="center" valign="middle" style="background-color:#c6c6c6;border:#7d8e98 solid 1px"
											class="name">
											待办事项
										</td> -->
										<td align="right" valign="middle" colspan="2"
											style="height:23px;background-color:#e5e6e6;border:#7d8e98 solid 1px;font:11px"><a
											onclick="window.open('${contextPath}/bpm/taskinstance/pending.action','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
											href="javascript:void(0);">
											更多</a>&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
										<td height="<s:property value="map['pendings'].size*20"/>" colspan="3" align="center" valign="top">
											<table width="98%" border="0" cellspacing="0" cellpadding="0">
												<s:iterator value="map['pendings']" id="row">
													<tr>
														<td height="25" class="line" width="20%">
														<div><span class='span1'>></span>&nbsp;
																<s:property value="processName"/>
																
														</div>
														</td>
														<td height="25" class="line">
															<div><a
																onclick="window.location='${contextPath}${row.editUrl}'"
																href="javascript:void(0);" title="${row.processName}">
																<s:property value="formNameDetail"/></a>
															</div>
														</td>
														<td height="25" class="line" width="8%">
																<s:property value="fromActorName"/>&nbsp;
														</td>
														<td height="25" class="line" width="12%">
															<s:date name="create" format="yyyy-MM-dd"/>
														</td>
													</tr>
												</s:iterator>
											</table>
										</td>
									</tr>
									<tr>
										<td colspan="3">
											&nbsp;
										</td>
									</tr>
								</table>

								<%
									String outUserCanView = SysParamUtil.getSysParam("ais.portal.outsystemusercanviewinfo");
									UUser user = (UUser)session.getAttribute("user");
									boolean isOutUser = StringUtil.isEmpty(user.getFcode()); //是否是外部用户
									boolean canView = "enabled".equals(outUserCanView); //是否可查看审计新闻和部门公告
								%>
								<table width="98%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="3%" height="25" align="center" valign="middle"
											bgcolor="#c6c6c6" style="border-left:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
										<img src="/ais/images/portal/Play.png" width="20" height="20" />
										</td>
										<td width="7%" align="left" valign="middle"
											style="background-color:#c6c6c6;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;" class="name">
											审计新闻
										</td>
										<td align="right" valign="middle" colspan="2"
											style="height:23px;background-color:#e5e6e6;border:#7d8e98 solid 1px;font:11px">
											<%
												if((!isOutUser) || (isOutUser && canView)){
											%>
												<a onclick="window.open('<s:url action="searchByType" namespace="/portal/simple/information"><s:param name="helper.infoType" value="3"/><s:param name="view" value="1"/></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
													href="javascript:void(0);">更多</a>
											<%
												}
											%>
											&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
										<td height="199" colspan="3" align="center" valign="top">
											<table width="98%" border="0" cellspacing="0" cellpadding="0">
												<s:iterator value="map['trends']" id="row">
													<tr>
														<td height="25" class="line"><div>
														<s:if test="${row.new}">
															<span style="font-size:8px;text-align:left;color:#F29110;font-weight:bold;">NEW </span>&nbsp;
														</s:if>
														<s:else><span class='span1'>> </span>&nbsp;</s:else>
															<%
																if((!isOutUser) || (isOutUser && canView)){
															%>
																<a onclick="window.open('<s:url action="viewByType" namespace="/portal/simple/information"><s:param name="information.id" value="'${row.id}'"/><s:param name="information.type" value="${row.type}"/><s:param name="reception" value="portal"/></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
																		href="javascript:void(0);" title="${row.title}">${row.title}</a>
															<%
																}else{
															%>
																${row.title}
															<%
																}
															%>
															</div>
														</td>
													</tr>													
												</s:iterator>
											</table>
										</td>
									</tr>
									<tr>
										<td colspan="3">
											&nbsp;
										</td>
									</tr>
								</table>

								<table width="98%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="50%">
											<table width="97%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="100%" align="center" valign="top">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td width="6%" height="25" align="center" valign="middle"
																	bgcolor="#c6c6c6" style="border-left:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
																	<img src="/ais/images/portal/Play.png" width="20" height="20" />
																</td>
																<td width="18%" align="left" valign="middle" height="25"
																	style="background-color:#c6c6c6;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;" class="name">
																				部门公告
																</td>
																<td align="right" valign="middle" 
																	bgcolor="#d6d6d6" style="background-color:#e5e6e6;border:#7d8e98 solid 1px;font:11px" height="25">
																	<%
																		if((!isOutUser) || (isOutUser && canView)){
																	%>
																		<a onclick="window.open('<s:url action="searchByType" namespace="/portal/simple/information"><s:param name="helper.infoType" value="1"/><s:param name="view" value="1"/></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
																			href="javascript:void(0);">更多</a>
																	<%
																		}
																	%>
																	&nbsp;&nbsp;&nbsp;&nbsp;
																</td>
															</tr>
															<tr>
																<td height="143" colspan="3" align="center" valign="top">
																	<table width="95%" border="0" cellspacing="0"
																		cellpadding="0">
																		<s:iterator value="map['bulletins']" id="row">
																		<tr>
																			<td height="25" class="line"><div>
																				<s:if test="${row.new}">
																					<span style="font-size:8px;text-align:left;color:#F29110;font-weight:bold;">NEW </span>&nbsp;
																				</s:if>
																				<s:else><span class='span1'>></span>&nbsp;</s:else>
																					<%
																						if((!isOutUser) || (isOutUser && canView)){
																					%>
																						<a onclick="window.open('<s:url action="viewByType" namespace="/portal/simple/information"><s:param name="information.id" value="'${row.id}'"/><s:param name="information.type" value="${row.type}"/><s:param name="reception" value="portal"/></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
																							href="javascript:void(0);" title="${row.title}">${row.title}</a>
																					<%
																						}else{
																					%>
																						${row.title}
																					<%
																						}
																					%>
																				</div>
																			</td>
																		</tr>
																	</s:iterator>
																	</table>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
										<td align="center" valign="top" width="50%">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="100%" align="center" valign="top">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td width="6%" height="25" align="center" valign="middle"
																	bgcolor="#c6c6c6" style="border-left:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
																	<img src="/ais/images/portal/Play.png" width="20" height="20" />
																</td>
																<td width="18%" align="left"  height="25" valign="middle"
																	bgcolor="#d6d6d6" style="background-color:#c6c6c6;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;" class="name">
																				部门简介
																</td>
																<td width="80%" align="center" valign="middle"
																	bgcolor="#d6d6d6" style="background-color:#e5e6e6;border:#7d8e98 solid 1px;font:11px">&nbsp;
																</td>
															</tr>
															<tr>
																<td height="143" colspan="3" align="left" valign="top">
																<s:iterator value="map['deptSynopsis']" id="row">
																	<table width="100%" border="0" cellspacing="0"
																		cellpadding="0">
																		<tr>
                                                                            <td width="25%" height="143" align="left"
                                                                                valign="middle">
                                                                                    <a href="javascript:;"
																	onclick="window.open('/ais/portal/simple/information/viewByType.action?information.type=${row.type}&information.id=${row.id }','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')" >
																							<s:if test="${row.haveFiles=='yes'}">
																								<img border="0" height="120" width="85" src="${contextPath }/images/portal/pic/${row.uuid2}${row.category2_name}" >
																							</s:if>
																							<s:else>
																								<img border="0" height="120" width="85" src="${contextPath}/images/portal/deptSynopsis.jpg" >
																							</s:else>
																						</a>
                                                                            </td>
																			<td width="75%"  align="left" valign="middle" height="143" style='font-family: "宋体";font-size: 9pt;color: #333333;line-height:150%' valign="top" >
																							<a href="javascript:;" title="<s:property value="content"/>"
																								onclick="window.open('/ais/portal/simple/information/viewByType.action?information.type=${row.type}&information.id=${row.id }','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
																							><s:if test="content.length()>130">
																								<s:property value="content.substring(0,130)"/>....
																							</s:if>
																							<s:else>
																								<s:property value="content"/>
																							</s:else></a>
																			</td>
																		</tr>
																	</table>
																</s:iterator>
																</td>
															</tr>
														</table>
													</td>
											</tr>
											</table>
										</td>
									</tr>
								</table>
								<table width="98%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="10" colspan="3" align="center" valign="top">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td width="3%" height="25" align="center" valign="middle"
											bgcolor="#c6c6c6" style="border-left:#7d8e98 solid 1px;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
										<img src="/ais/images/portal/Play.png" width="20" height="20" />
										</td>
										<td width="7%" align="left" height="25" valign="center" bgcolor="#d6d6d6"
											class="name" style="background-color:#c6c6c6;border-top:#7d8e98 solid 1px;border-bottom:#7d8e98 solid 1px;">
														友情链接
										</td>
										<td width="90%" align="right" valign="middle"
											bgcolor="#d6d6d6" style="border:#7d8e98 solid 1px;font:11px">
											<a onclick="window.open('<s:url action="searchByType" namespace="/portal/simple/information"><s:param name="helper.infoType" value="10"/></s:url>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')"
													href="javascript:void(0);">
												更多</a>&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
									<tr>
                                    
										<td height="58" colspan="3" align="center" valign="middle">
                                        <marquee onmouseover=this.stop() onmouseout=this.start() scrollamount="2" behavior="alternate" width="100%" height="39">
											<%
													java.util.Map map1 = (java.util.Map) request.getAttribute("map");
													List linkList1 = (List) map1.get("friendLinks");
													for (int i = 0; i < linkList1.size(); i++) {
														Information info = (Information) linkList1.get(i);
											%>
												<%if("yes".equals(info.getHaveFiles())) {%>
													<a href="<%=info.getInfkey()%>" target="_blank" title="<%=info.getTitle()%>">
														<img alt="<%=info.getTitle()%>" border="0" src="${contextPath }/images/portal/pic/<%=info.getUuid2()+info.getCategory2_name()%>" width="162" height="42">
													</a>
												<%}else{ %>
													<a href="<%=info.getInfkey()%>" target="_blank" title="<%=info.getTitle()%>">
														<img alt="<%=info.getTitle()%>" border="0" src="${contextPath }/images/portal/friendsLink.jpg" width="162" height="42">
													</a>
												<%} %>
												&nbsp;&nbsp;&nbsp;
											<%} %>
                                             </marquee>
										</td>
                                       
									</tr>
								</table>
							<td class="main_right"></td>
						</tr>
						<tr>
							<td class="main_left_bottom"></td>
							<td class="main_bottom"></td>
							<td class="main_right_bottom"></td>
						</tr>
					</table>	
				</td>
			</tr>
		</table>
	</body>
</html>

