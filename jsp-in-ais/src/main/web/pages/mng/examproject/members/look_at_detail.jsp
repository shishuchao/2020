<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
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
        function onBodyLoad() {
            <%if(request.getAttribute("employeeInfo")==null){%>
            $.messager.show({
                title: '提示信息',
                msg: '不存在该审计人员信息！',
                timeout: 5000,
                showType: 'slide'
            });
            <%}%>
        }
    </script>
</head>
<body topmargin=0 onload="onBodyLoad()" class="easyui-layout">
<div region="center">
    <div class="easyui-tabs" fit="true" border="false">
        <div id='one' title='排程计划' style="overflow:hidden;">
            <iframe src="${contextPath}/mng/examproject/members/audProjectMembersInfo/toPlanList.action?employeeInfo.id=<s:property value="employeeInfo.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}"
                    frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
        </div>
        <div id='two' title='在审项目' style="overflow:hidden;">
            <iframe src="${contextPath}/mng/examproject/members/audProjectMembersInfo/toProjectList.action?employeeInfo.id=<s:property value="employeeInfo.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.runningStartDate=${helper.runningStartDate}&helper.runningEndDate=${helper.runningEndDate}"
                    frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
        </div>
        <div id='three' title='已审项目' style="overflow:hidden;">
            <iframe src="${contextPath}/mng/examproject/members/audProjectMembersInfo/toJoinAuditProjectHistoryList.action?employeeInfo.id=<s:property value="employeeInfo.id"/>&helper.freeStartDate=${helper.freeStartDate}"
                    frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
        </div>
    </div>
</div>
</body>
</html>
