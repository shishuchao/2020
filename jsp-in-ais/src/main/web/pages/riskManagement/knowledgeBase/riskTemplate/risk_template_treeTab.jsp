<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<!DOCTYPE HTML>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>风险事项详细信息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
</head>
<body id="body1" class='easyui-layout' fit='true' style='margin:0px;overflow:hidden' >
	<div region="center" border="0" style="overflow:hidden;" >
		<div class='easyui-tabs' border="0" style="overflow:hidden;width:100%;" fit='true'>
			<input type='hidden' id='test' value='<%=request.getParameter("selectedTab")%>'/>
			<div id='main' title='风险库' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("main")){%> selected="true"<%} %> style="overflow:hidden;">
				<iframe id="basefrm1" name="baseifrm"
					src="${contextPath}/riskManagement/knowledgeBase/riskTemplate/showContentRoot.action?isView=${isView}&node=${node}&path=${path}&selectedTab=main&taskId=<%=request.getParameter("taskId")%>&templateId=<%=request.getParameter("templateId")%>"
					frameborder="0" style="width:100%;height:100%" ></iframe>
			</div>
		
		    <s:if test="'1' == '${type}'">
			    <div id='item' title='风险类别' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %> style="overflow:hidden;">
					<iframe id="basefrm2"
					src="${contextPath}/riskManagement/knowledgeBase/riskTemplate/showContentType.action?isView=${isView}&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&selectedTab=item&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&templateId=<%=request.getParameter("templateId")%>"
					frameborder="0" width="100%" height="100%"></iframe>
			    </div>
			</s:if>
		    <s:if test="'2' == '${type}'">
				<div id='item' title='风险事项' <% if(StringUtils.isNotBlank(request.getParameter("selectedTab")) && request.getParameter("selectedTab").equals("item")){%> selected="true"<%} %> style="overflow:hidden;">
					<iframe id="basefrm2"
					src="${contextPath}/riskManagement/knowledgeBase/riskTemplate/showContentLeaf.action?isView=${isView}&node=<%=request.getParameter("node")%>&path=<%=request.getParameter("path")%>&selectedTab=item&type=<%=request.getParameter("type")%>&taskPid=<%=request.getParameter("taskPid")%>&taskId=<%=request.getParameter("taskId")%>&templateId=<%=request.getParameter("templateId")%>"
					frameborder="0" width="100%" height="100%"  ></iframe>
			    </div>
		    </s:if>
		</div>
	</div>
	<script language="javascript">
		$(function(){
			$('li:eq(0)').bind('click',function(){
				$("#basefrm1")[0].contentWindow.reload();
			});
		});
		function doAutoHeight1() {
			if(document.body.clientHeight>165)
		    document.all.basefrm1.style.height = document.body.clientHeight-60;
		}
	
		function doAutoHeight2() {
			if(document.body.clientHeight>165)
		    document.all.basefrm2.style.height = document.body.clientHeight-60;
		}
		function doAutoHeight3() {
			if(document.body.clientHeight>165)
		    document.all.basefrm3.style.height = document.body.clientHeight-60;
		}
	</script>
</body>
</html>
