<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>授权结果查看-详细信息</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript">
function setFrameSrc(){
	var url="${contextPath}/system/authAuthorityAction!authRolePerSet2.action?view=view&p_froleid=${authRole.froleid}";
	document.getElementById("mFrame").src=url;
	<s:if test="${authRole.fscopecode=='br' or authRole.fscopecode=='wr'}">
		<s:if test="${not empty(fscopecode)}">
			url='/ais/system/authAuthorityAction!authRoleForData.action?p_froleid=888_${authRole.froleid}&view=view&companyId=${companyId}&fscopecode=${fscopecode}&url=/ais/system/allDataAuthModules.action';
		</s:if>
		<s:else>
			url='/ais/system/authAuthorityAction!authRoleForData.action?p_froleid=888_${authRole.froleid}&view=view&url=/ais/system/allDataAuthModules.action';
		</s:else>
		document.getElementById("mFrame2").src=url;
	</s:if>
	<s:if test="${authRole.fscopecode=='wr'}">
		url='/ais/system/authAuthorityAction!authCtrlRoleSet.action?p_froleid=${authRole.froleid}&view=view';
		document.getElementById("mFrame5").src=url;
	</s:if>
	
	<s:if test="${authRole.fscopecode!='mr'}">
		url='/ais/system/authRoleDetails2.action?p_froleid=${authRole.froleid}';
		document.getElementById("myFrame6").src=url;
	</s:if>
}
</script>
</head>
<body onload="setFrameSrc();" style='pading:0px;margin:0px;overflow:hidden;'>
		<div id="tt"  class="easyui-tabs"  fit="true" border='0' tabPosition='right' style='pading:0px;margin:0px;overflow:hidden;'>
			<div title="操作授权信息" style='pading:0px;margin:0px;overflow:hidden;'>
				<iframe id="mFrame" src="" frameborder=0 width="100%" height="100%" scrolling=no></iframe>
			</div>
			<s:if test="${authRole.fscopecode=='br' or authRole.fscopecode=='wr'}">
				<div title="数据授权信息"  style='pading:0px;margin:0px;overflow:hidden;'>
					<iframe id="mFrame2" src="" frameborder=0 width="100%" height="100%" scrolling='no'></iframe>
				</div>
			</s:if>
			<s:if test="${authRole.fscopecode=='wr'}">
				<div title="可控角色信息"  style='pading:0px;margin:0px;overflow:hidden;'>
					<iframe id="mFrame5" src="" frameborder=0 width="100%" height="100%" scrolling='no'></iframe>
				</div>
			</s:if>
			<s:if test="${authRole.fscopecode!='mr'}">
				<div title="涉及人员列表" style='pading:0px;margin:0px;overflow:hidden;'>
					<iframe id="myFrame6" src="" frameborder=0 width="100%" height="100%" scrolling='no'></iframe>
				</div>
			</s:if>
		</div>
	
</body>
</html>