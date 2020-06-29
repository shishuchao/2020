<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:text id="title" name="'流程定义'"></s:text>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" />
	</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<s:head theme="ajax" />
</head>
<body  style="overflow:hidden;" class="easyui-layout">
	<div region="center" border="0px">
		<div class="easyui-tabs" fit="true" id="test" border="0px">
			<%-- <div title="已发布流程" style="overflow:hidden;" border="0px">
				<iframe id="publishedflow" src="${pageContext.request.contextPath}/bpm/definition/list_published.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div> --%>
			<div title="底稿" style="overflow:hidden;" border="0px">
				<iframe id="unpublishedflow" src="${pageContext.request.contextPath}/operate/manuExt/manuUilist.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div>
				<div title="疑点" style="overflow:hidden;" border="0px">
				<iframe id="formController" src="${pageContext.request.contextPath}/operate/doubtExt/mainUisys.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div>
			<div title="取证记录" style="overflow:hidden;" border="0px">
				<iframe id="unusedflow" src="${pageContext.request.contextPath}/project/evidence/listEvidenceManu.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div>
			<div title="审计查询书" style="overflow:hidden;" border="0px">
				<iframe id="formController" src="${pageContext.request.contextPath}/operate/audBook/getlistBooksManu.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div>
		</div>
	</div>
</body>
</html>
