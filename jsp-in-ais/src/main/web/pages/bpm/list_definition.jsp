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
	<SCRIPT type="text/javascript">
		function refreshPublishedflow(){
			document.getElementsByTagName('iframe')[0].contentWindow.location.reload();
		}
		function refreshUnpublishedflow(){
			document.getElementsByTagName('iframe')[1].contentWindow.location.reload();
		}
		function refreshUnusedflow(){
			document.getElementsByTagName('iframe')[2].contentWindow.location.reload();
		}
	</SCRIPT>
</head>
<body  style="overflow:hidden;" class="easyui-layout">
	<div region="center" border="0px">
		<div class="easyui-tabs" fit="true" id="test" border="0px">
			<div title="已发布流程" style="overflow:hidden;" border="0px">
				<iframe id="publishedflow" src="${pageContext.request.contextPath}/bpm/definition/list_published.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div>
			<div title="未发布流程" style="overflow:hidden;" border="0px">
				<iframe id="unpublishedflow" src="${pageContext.request.contextPath}/bpm/definition/list_unpublished.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div>
			<div title="已失效流程" style="overflow:hidden;" border="0px">
				<iframe id="unusedflow" src="${pageContext.request.contextPath}/bpm/definition/list_invalid.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div>
			<div title="设置表单校验" style="overflow:hidden;" border="0px">
				<iframe id="formController" src="${pageContext.request.contextPath}/bpm/definition/nobpm/list.action"
					frameborder=0 width="100%" height="100%"></iframe>
			</div>
		</div>
	</div>
</body>
</html>
