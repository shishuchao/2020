<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="ais.framework.util.MyProperty,java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>学习园地--${studyGardenPlot.title}</title>
		<s:head />
		<link href="${contextPath}/styles/portal/css.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/portal/info.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script language="javascript">
		function saveplot(){
			
			var url = "${contextPath}/portal/simple/information/gardenPlotCommentSave4portal.action";
			myform1.action = url;
			document.getElementsByName("addpl")[0].disabled=true;
			myform1.submit();
		}
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
		
		</script>
	</head>

	<body>
		<center>
				<div id="header">
					<jsp:include page="../header.jsp"></jsp:include>
				</div>
				<div id="content_1"style="width:100%">
					<br>
					<br>
					<br>
					<span class="style4"><s:property value="studyGardenPlot.title" />
					</span>
					<hr />
					<span class="style1">${studyGardenPlot.create_date}</span>
					<br>
					<br>
					<div class="style3">
							${studyGardenPlot.content}
					</div>
					<hr />
				
					<br>
					<br>
						<div id="accelerys" align="center">
							<s:property escape="false" value="accessoryList" />
						</div>
					<%-- <span class="gb">
							<s:button value="关闭" onclick="javascript:window.close();" />
						 </span> --%>

				</div>
		</center>
	</body>
</html>
