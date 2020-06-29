<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" import="nc.vo.sm.login.LoginRequestInfo" %>
<%@ page import="ais.system.common.*" %>
<%@page import="java.net.URLDecoder"%>
<%

		String func_code = request.getParameter("func_code")==null?"":request.getParameter("func_code");
		String accountcode = request.getParameter("accountcode");
		String integrateConfig = "";
		String cas_login_name = "";
		String passwd = "000000";
		String pro_id="";
	    String pjstartdate="";
	    String pjenddate="";
		String params = request.getParameter("p")==null?"":request.getParameter("p");
		String indexhidder = request.getParameter("indexhidder")==null?"":request.getParameter("indexhidder");

		if(indexhidder.equals("1") && !params.equals("")){
			params = Base64.getFromBASE64(params);
			params = URLDecoder.decode(params,"UTF-8");
			System.out.println(params);
			String[] paramArray = params.split(",");
			pro_id=paramArray[0];
			pjstartdate=paramArray[1];
	        pjenddate=paramArray[2];
	        cas_login_name = paramArray[3];
	        integrateConfig = cas_login_name.length()==0?"0":LoginRequestInfo.getIntegrateConfigFromXML();
		}

%>
<html>
<HEAD>
	<TITLE>UFIDA New Century</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
 	<link rel="SHORTCUT ICON"  href="logo/images/ufida.ico">
    <link rel="BOOKMARK" href="logo/images/ufida.ico">
	<script LANGUAGE="JavaScript">
		function removeMe(){
			if(document.all){
				NCApplet.removeMe();
			}else{
				NCApplet[1].removeMe();
			}
		}
		function resize(){
 			var w = document.body.clientWidth;
			var h = document.body.clientHeight;
			if(document.all){
				NCApplet.setAppsize(w,h);
			}else{
				NCApplet[1].setAppsize(w,h);
			}
		}
		function on_load(){
			resize();
			mytimer();
		}
		function mytimer(){
			window.status="";
			setTimeout("mytimer()",1000);
		}

		function senddata(myurl, pro_id, type, fn, content){
            var myform=document.getElementById("myform");
            var mytarget="mywindow";
            if(myurl!=null) {
                myform.action=myurl;
            }
            else {
                myform.action="http://10.60.80.253:335/ais/operate/doubt/edit.action";
            }
            myform.pro_id.value=pro_id;
            myform.type.value=type;
            myform.attach_name.value=fn;
            myform.content.value=content;
            myform.mod_id.value=fn;
            myform.bns_id.value='queryanaly';
            myform.target=mytarget;
            // 控制新窗口的大小
            //var popupWin = window.open(myurl, mytarget, 'scrollbars=yes,width=400,height=300');
            //prompt("ppp",myform.content.value);
            myform.submit();
		}

		function openfapreport(myurl, pro_id, loginname){
            var mytarget="_blank";
            if(myurl!=null) {
                myurl=myurl + '?pro_id='+ pro_id;
                //myurl=myurl + '?pro_id='+ pro_id + '&loginname='+loginname;
            }
            else {
                myurl = '/fap/initproject.jsp?pro_id='+pro_id+'&loginname='+loginname;
            }
            var popupWin = window.open(myurl, mytarget,'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		}

		var _info = navigator.userAgent;
		var _ie=(_info.indexOf("MSIE")>0 && _info.indexOf("Win")>0 && _info.indexOf("Windows 3.1") < 0);
		function isIE()
		{
			return _ie;
		}
		function editPortlet(){
			alert("抱歉,暂时没有实现");
		}
		//alert('<%=cas_login_name%>');
	</script>
</HEAD>
<BODY scroll=no style=overflow-x:hidden TOPMARGIN=0 LEFTMARGIN=0 onload="on_load()" onbeforeunload="removeMe()" onresize="resize()">
	<form id="myform" name="myform" method=post>
	    <!--内容-->
	    <input name="content" type="hidden">
	    <!--项目id-->
	   
	    <input name="pro_id" type="hidden" value="<%=pro_id%>">
	    <input type="hidden" name="pjstartdate" value="<%=pjstartdate%>"/>
	<input type="hidden" name="pjenddate" value="<%=pjenddate%>"/>
	    <!--类型：  BW:备忘，YD:疑点 FX:发现 DS:重大事项-->
	    <input name="type" type="hidden">
	   <!--模块id-->
	    <input name="mod_id" type="hidden">
	    <!--业务id(凭证id)-->
	    <input name="bns_id" type="hidden">
	   <!--附件名称-->
	    <input name="attach_name" type="hidden">
	    
	</form>
	<%

		String schme = request.getScheme();
		String serverName = request.getServerName();
		String port = request.getServerPort()+"";
		String headStr = schme+"://"+serverName+":"+port+"/";
		String clientExePath = headStr+"Client/NC_Client_1.5.0_07.exe";
		String clientType = request.getParameter("clienttype");
		if(clientType == null || clientType.trim().length() <= 0){
			clientType = "standard";
		}
		// 解决宽屏显示器直接访问login.jsp显示不正常的问题
		if(request.getParameter("height")==null || request.getParameter("width")==null) {
            //response.sendRedirect("index.jsp");
    		%>
        	<script language="JavaScript">
        	    window.location.href="index.jsp?params=<%=params%>";
        	</script>
            <%
		}
	%>
	<c:set var="lHeight" value='<%=LoginRequestInfo.getLoginAppletHeight(request.getParameter("key"),request.getParameter("height"))%>'/>
	<c:set var="lWidth" value='<%=LoginRequestInfo.getLoginAppletWidth(request.getParameter("key"),request.getParameter("width"))%>'/>
	<c:set var="sHeight" value='<%=LoginRequestInfo.getScreenHeight(request.getParameter("key"),request.getParameter("height"))%>'/>
	<c:set var="sWidth" value='<%=LoginRequestInfo.getScreenWidth(request.getParameter("key"),request.getParameter("width"))%>'/>
	<OBJECT classid="clsid:EAF5041C-A17F-456B-B098-930A9DD2F886" codebase="<%=clientExePath%>" width=0 height=0 align=center hspace=0 vspace=0 name="NC管理软件客户端配置程序"></OBJECT>
	<OBJECT classid="clsid:CAFEEFAC-0015-0000-0007-ABCDEFFEDCBA" name="NCApplet" style="top:0;left:0;position:absolute;" width="${sWidth}" height="${sHeight}" >
		<PARAM name="java_code" value="nc.ui.sm.login.AppletContainer.class">
		<PARAM name="java_archive" value="/Client/NC_Login_v50.jar">
		<PARAM name="type" value="application/x-java-applet;version=1.4.2">
		<PARAM name="scriptable" value="true">
		<PARAM name="MAYSCRIPT" value="true">
		<PARAM name="boxbgcolor" value="#ffffff">
		<PARAM name="LOGINUITYPE" value="<%=LoginRequestInfo.getLoginUIType()%>">
		<PARAM name="SERVER_WORKINGDIR" value='<%=LoginRequestInfo.getWorkDir()%>'>
		<PARAM name="ClientHome" value='<%=System.getProperty("nc.client.location")%>'>
		<PARAM name="SCHEME" value="<%=schme%>">
		<PARAM name="SERVER_HOST_NAME" value="<%=request.getServerName()%>">
		<PARAM name="SERVER_IP" value="<%=serverName%>">
		<PARAM name="SERVER_PORT" value="<%=port%>">
		<PARAM name="CONTEXT_PATH" value="<%=request.getContextPath()%>">
		<PARAM name="USER_WIDTH" value="${sWidth}">
		<PARAM name="USER_HEIGHT" value="${sHeight}">
		<PARAM name="clienttype" value="<%=clientType%>">
		<PARAM name="isClientCacheCode" value="Y">
		<PARAM name="autoTest" value="${param.autotest}">
		<PARAM name="AT_SERVER_PORT" value='<%=System.getProperty("SERVER_PORT")%>'>
		<PARAM name="ACCOUNT" value="<%=LoginRequestInfo.getAccoutInfo()%>">
		<PARAM name="SERVERTIME" value="<%=LoginRequestInfo.getServerTime()%>">
		<PARAM name="LOGINKEY" value='<%=request.getParameter("key")==null?"":request.getParameter("key")%>'>
        <PARAM name="LOGIN_ORGANIZATION" value="">
        <PARAM name="CAS_LOGIN_NAME" value='<%=cas_login_name%>'>
        <PARAM name="LOGIN_PASSWORD" value='<%=passwd%>'>
        <PARAM name="LOGIN_ACCOUNDCODE" value='<%=accountcode%>'>
        <PARAM name="FUNC_CODE" value='<%=func_code%>'>
        <PARAM name="PROJECT_ID" value='<%=pro_id%>'>
        <PARAM name="PJSTARTDATE" value='<%=pjstartdate%>'>
        <PARAM name="PJENDDATE" value='<%=pjenddate%>'>
        <PARAM name="INTEGRATECONFIG" value='<%=integrateConfig%>'>
		<COMMENT>
		<EMBED type="application/x-java-applet;version=1.4.2"
		name="NCApplet" width="${sWidth}" height="${sHeight}"
		pluginspage="http://java.sun.com/products/plugin/"
		java_code="nc.ui.sm.login.AppletContainer.class"
		java_archive="/Client/NC_Login_v50.jar"
		scriptable="true" MAYSCRIPT="true"
		boxbgcolor="#ffffff" LOGINUITYPE="<%=LoginRequestInfo.getLoginUIType()%>"
		SERVER_WORKINGDIR='<%=LoginRequestInfo.getWorkDir()%>'
		ClientHome='<%=System.getProperty("nc.client.location")%>'
		SCHEME="<%=request.getScheme()%>"
		SERVER_HOST_NAME="<%=request.getServerName()%>"
		SERVER_IP="<%=serverName%>"
		SERVER_PORT="<%=port%>"
		clienttype="<%=clientType%>"
		CONTEXT_PATH="<%=request.getContextPath()%>"
		USER_WIDTH="${sWidth}"
		USER_HEIGHT="${sHeight}"
		isClientCacheCode="${param.iecache}"
		autoTest="${param.autotest}"
		AT_SERVER_PORT='<%=System.getProperty("SERVER_PORT")%>'
		ACCOUNT="<%=LoginRequestInfo.getAccoutInfo()%>"
		SERVERTIME="<%=LoginRequestInfo.getServerTime()%>"
		LOGINKEY='<%=request.getParameter("key")==null?"":request.getParameter("key")%>'
        LOGIN_ORGANIZATION=""
        CAS_LOGIN_NAME='<%=cas_login_name%>'
        LOGIN_PASSWORD='<%=passwd%>'
        LOGIN_ACCOUNDCODE='<%=accountcode%>'
        FUNC_CODE='<%=func_code%>'>
        PROJECT_ID='<%=pro_id%>'
        PJSTARTDATE='<%=pjstartdate%>'
        PJENDDATE='<%=pjenddate%>'
        INTEGRATECONFIG='<%=integrateConfig%>'/>
		<NOEMBED>
			<hr>
			this explore not support plug in
		</NOEMBED>
		</COMMENT>
	</OBJECT>

</BODY>
<a href="javascript:void(0);"></a>
</html>