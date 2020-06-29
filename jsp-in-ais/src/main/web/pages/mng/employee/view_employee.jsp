<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="ais.resmngt.employee.model.EmployeeInfo"%><html>
<head><title>信息查看</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<s:head theme="ajax"/>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript">
	function onBodyLoad(){
		<%if(request.getAttribute("employeeInfo2")==null){%>
			window.parent.$.messager.show({
				title:'提示信息',
				msg:'不存在该审计人员信息！'
			});
			window.parent.closedlg(true);
		<%}%>
	}
</script>
</head>
	<body topmargin=0 onload="onBodyLoad()" class="easyui-layout">
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false">
		<%
			if (ais.sysparam.util.SysParamUtil.getSysParam("ais.prepare.employee.link") == null
				|| ais.sysparam.util.SysParamUtil.getSysParam("ais.prepare.employee.link").equals("Y")) {
		%>
			<div id='basemsg' title='基本信息' style="overflow:hidden;">
				<iframe name="if1" src="${contextPath}/mng/employee/employeeInfoView.action?ul=${ul}"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			</div>
		<%
			}
		%>
			<div id='one' title='排程计划' style="overflow:hidden;">
				<iframe name="if1" src="${contextPath}/mng/examproject/members/audProjectMembersInfo/toPlanList.action?employeeInfo.id=<s:property value="employeeInfo2.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			</div>
			<div id='two' title='在审项目' style="overflow:hidden;">
				<iframe name="if1" src="${contextPath}/mng/examproject/members/audProjectMembersInfo/toProjectList.action?employeeInfo.id=<s:property value="employeeInfo2.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			</div>
			<div id='three' title='已审项目' style="overflow:hidden;">
				<iframe name="if1" src="${contextPath}/mng/examproject/members/audProjectMembersInfo/toJoinAuditProjectHistoryList.action?employeeInfo.id=<s:property value="employeeInfo2.id"/>&employeeInfo.personnelCode=<s:property value="employeeInfo2.personnelCode"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
			</div>
		</div>	
	</div>
	</body>
</html>
