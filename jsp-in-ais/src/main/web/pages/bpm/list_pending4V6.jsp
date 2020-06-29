<jsp:directive.page
	import="org.springframework.web.context.WebApplicationContext" />
<jsp:directive.page
	import="org.springframework.web.context.support.WebApplicationContextUtils" />
<jsp:directive.page import="ais.framework.acegi.SecurityContextUtil" />
<%@page import="ais.bpm.model.AudTaskInstance"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>待办事项2</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<SCRIPT type="text/javascript">
			function comUrl(process_id,group_id,fromNode)
			{
				var url=window.location.href;
				url=url.substr(url.indexOf('${pageContext.request.contextPath}'),url.length);
				window.location.href="${pageContext.request.contextPath}/plan/listTobeSubmited.action?adjustType=2000&&definition_id="+process_id+"&&group_id="+group_id+"&&fromNode="+fromNode+"&&backUrl="+url;
			}
			
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('planTable').style.display;
				if(isDisplay==''){
					document.getElementById('planTable').style.display='none';
				}else{
					document.getElementById('planTable').style.display='';
				}
			}
		</SCRIPT>
	</head>
	<body style="overflow:hidden;" class="easyui-layout">
		<div region="center"  fit="true" border="false">
			 <div class='easyui-tabs'  fit="true">
				<div id='daiBanShiXiang' title='待办事项' style="margin: 0;padding: 0;overflow:hidden;" border="false">
					 <iframe id="reworkWorkProgram"
							src="${contextPath}/bpm/taskinstance/pending.action?type=${type}" frameborder="0" width="100%" height="100%" >
					 </iframe>
				</div>
				<div id='yiBanShiXiang' title='已办事项' style="margin: 0;padding: 0;overflow:hidden;" border="false">
					<iframe id="ledgrtFrame"
						src="${pageContext.request.contextPath}/bpm/taskinstance/running.action?type=${type}" frameborder="0" width="100%" height="100%">
					</iframe>
				</div>
			</div>
		</div>
	</body>
</html>
