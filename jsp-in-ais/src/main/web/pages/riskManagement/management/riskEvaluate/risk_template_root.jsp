<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	//总体方案页面，也就是审计方案模板的根节点页面
	String pb = (String) request.getParameter("refresh");
	String taskId = (String) request.getParameter("taskId");
	String templateId = (String) request.getParameter("templateId");
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>风险库维护：总体风险修改</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow-y:auto;" >
	<table class="ListTable" align="center">
		<input type="hidden" name="refreshCode">
		<tr>
			<td class="EditHead">
				<font color="red">*</font>&nbsp;编号
			</td>
			<td class="editTd">
				<s:textfield cssClass="noborder" name="riskTemplate.templateCode"/>
			</td>

			<td class="EditHead">
				<font color="red">*</font>&nbsp;名称
			</td>
			<td class="editTd">
				<s:textfield cssClass="noborder" name="riskTemplate.templateName"/>
			</td>
		</tr>
<%-- 		<tr>
			<td class="EditHead">
				描述
			</td>
			<td class="editTd" colspan="3">
				<s:textarea cssClass="noborder" name="riskTemplate.risk_description" cssStyle="width:100%;overflow-y:hidden"/>
			</td>
		</tr> --%>
	</table>
	<s:hidden name="riskTemplate.templateId" />
	<s:hidden name="riskTemplate.year" />
	<s:hidden name="riskTemplate.tradePlate" />
	<s:hidden name="riskTemplate.version" />
	<s:hidden name="riskTaskTemplate.taskId" id="taskId" />
	<s:hidden name="riskTaskTemplate.taskPid" />
	<s:hidden name="templateId" />
	<s:hidden name="taskId" />
	<s:hidden name="type" />
	<s:hidden name="pro_id" />
	<s:hidden name="path" />
	<s:hidden name="node" />
		
	<div id="addType_div"></div>
</body>
</html>
