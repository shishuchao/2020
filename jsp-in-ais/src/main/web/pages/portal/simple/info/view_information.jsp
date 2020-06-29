<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="ais.framework.util.MyProperty"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>
			<s:if test="information.type==@ais.portal.simple.model.Information@TRENDS">
				审计新闻--${information.title}
			</s:if>
			<s:elseif
				test="information.type==@ais.portal.simple.model.Information@BULLETIN_BOARD">
				部门公告--${information.title}
			</s:elseif>
		</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<style type="text/css">
.style1 {
	width: 100%;
	height: 20px;
	color: #999999;
	text-align: center;
	font-family: "宋体";
	font-size: 9pt;
	display: block;
	padding-top: 10px;
}

.style3 {
	width: 90%;
	text-align: left;
	display: block;
	font-family: "宋体";
	font-size: 10pt;
	font-style: normal;
	line-height: 25px;
	color: #666666;
	text-indent: 2em;
}

.style4 {
	width: 100%;
	height: 30px;
	color: #006cb5;
	text-align: center;
	font-family: "宋体";
	font-size: 14pt;
	font-weight: bold;
	display: block;
	padding-top: 30px;
}


</style>
	</head>

	<body>
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
		<center>
			<s:form id="myform"
				action="/portal/simple/information/viewByType.action">
				<%-- <div id="header">
					<jsp:include page="../header.jsp"></jsp:include>
				</div> --%>
				<div id="content_1" style="width:100%">
					<br>
					<br>
					<br>
					<span class="style4"><s:property value="information.title" />
					</span>
					<hr />
					<span class="style1">${information.createdate}</span>
					<br>
					<br>
					<div class="style3">
						<s:if
							test="information.type==@ais.portal.simple.model.Information@HOTLINK">
							网址 ${information.infkey}
						</s:if>
						<s:elseif
							test="information.type==@ais.portal.simple.model.Information@FEEDBACK">
							Email ${information.infkey}
						</s:elseif>
						<s:if
							test="information.type!=@ais.portal.simple.model.Information@HOTLINK">
							${information.content}
						</s:if>
						<s:if test="information.type==@ais.portal.simple.model.Information@TRENDS">
							<s:iterator id="img" value="information.image">
								<s:if test="${not empty(img)}">
									<img alt="${information.title }" src="${img}" align="center" style="width: 800px;">
								</s:if>
							</s:iterator>
						</s:if>
					</div>
					<br>
					<br>
					<br>
					<br>
						<div id="accelerys" align="center">
							<s:property escape="false" value="filesList" />
						</div>
					<%-- <span class="gb"><s:if
							test="${not empty(clk_pic) and clk_pic=='Y'}">
							<s:button value="关闭" onclick="javascript:window.close();" />
						</s:if> <s:else>
							<s:button value="关闭" onclick="javascript:window.close();" />
						</s:else> </span> --%>

				</div>
				<%-- <div id="foot">
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
				</div> --%>
				<s:hidden name="information.id" />
			</s:form>
		</center>
	</body>
</html>
