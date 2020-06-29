<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
   String url = request.getParameter("url");
   String params = request.getParameter("params");
   StringBuffer turl = new StringBuffer(url);
   if(null != params && !"".equals(params)){
	   turl.append("?");
	   String[] param = params.split("\\|");
	   for(int i = 0; i < param.length;i++){
		   String str = param[i];
		   String[] par = str.split(":");
		   turl.append(par[0]).append("=").append(par[1]).append("&");
	   }
	   turl.deleteCharAt(turl.length() - 1);
   }
   String rurl = turl.toString();
%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="refresh" content="3;url=<%=rurl %>">
		<title>系统提示</title>
		<style type="text/css">

body {
    background:    fff;
    font:        MessageBox;
    font:        Message-Box;
}

marquee {
    border:        1px solid #bac5d1;
    background:    #e7eef6;
    height:        12px;
    font-size:    1px;
    margin:        1px;
    width:        400px;
    -moz-binding:    url("marquee-binding.xml#marquee");
    -moz-box-sizing:    border-box;
    display:        block;
    overflow:        hidden;
}

marquee span {
    height:            18px;
    margin:            1px;
    width:            6px;
    background:        #2e7de4;
    float:            left;
    font-size:        1px;
    font-color:black;
}

.progressBarHandle-0 {
    filter:        alpha(opacity=20);
    -moz-opacity:    0.20;
}

.progressBarHandle-1 {
    filter:        alpha(opacity=40);
    -moz-opacity:    0.40;
}

.progressBarHandle-2 {
    filter:        alpha(opacity=60);
    -moz-opacity:    0.6;
}

.progressBarHandle-3 {
    filter:        alpha(opacity=80);
    -moz-opacity:    0.8;
}

.progressBarHandle-4 {
    filter:        alpha(opacity=100);
    -moz-opacity:    1;    
}


.progressBarHandle-5 {
    filter:        alpha(opacity=100);
    -moz-opacity:    1.2;    
}

.progressBarHandle-6 {
    filter:        alpha(opacity=100);
    -moz-opacity:    1.4;    
}

.progressBarHandle-7 {
    filter:        alpha(opacity=100);
    -moz-opacity:    1.8;    
}
.progressBarHandle-8 {
    filter:        alpha(opacity=100);
    -moz-opacity:    2;    
}
.progressBarHandle-9 {
    filter:        alpha(opacity=100);
    -moz-opacity:    2.2;    
}



</style>
	</head>
	<body>
		<table width="100%" height="100%">
			<tr>
				<td valign="top">
					<center>
					底稿导出中，请稍候... ...
					<marquee direction="right" scrollamount="8" scrolldelay="100">
					    <span class="progressBarHandle-0"></span>
					    <span class="progressBarHandle-1"></span>
					    <span class="progressBarHandle-2"></span>
					    <span class="progressBarHandle-3"></span>
					    <span class="progressBarHandle-4"></span>
					    <span class="progressBarHandle-5"></span>
					    <span class="progressBarHandle-6"></span>
					    <span class="progressBarHandle-7"></span>
					    <span class="progressBarHandle-8"></span>
					    <span class="progressBarHandle-9"></span>
					</marquee>
					</center>
				</td>
			</tr>
		</table>
	</body>
</html>
