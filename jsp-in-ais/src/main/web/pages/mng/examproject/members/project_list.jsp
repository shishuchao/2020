<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
    <title>参与审计项目历史</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript">
        function selall_inform(chk, selected) {
            if (selected == null || selected === '') selected = true;
            for (var i = 0; i < chk.length; i++) chk[i].checked = selected;
        }

        function declareExport(bool) {
            document.getElementById('export').value = bool;
            return true;
        }

        function goEdit(t) {
            location.href = '${contextPath}/mng/examproject/members/audProjectMembersInfo/edit.action?project_members_id=' + t;
        }

        function doSearch() {
            document.getElementById('export').value = "true";
            //$('#itts').datagrid({
            //	queryParams:form2Json('searchForm')
            //});
            document.getElementById("searchForm").submit();
        }
    </script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div>
    <s:form action="toProjectList" name="searchForm" id="searchForm" namespace="/mng/examproject/members/audProjectMembersInfo" method="post">
        <s:hidden id="export" name="export"/>
        <s:hidden id="querySource" name="querySource" value="gid"/>
        <s:hidden id="employeeInfo.id" name="employeeInfo.id" value="${employeeInfo.id}"/>
        <s:hidden id="helper.freeStartDate" name="helper.freeStartDate" value="${helper.freeStartDate}"/>
        <s:hidden id="helper.freeEndDate" name="helper.freeEndDate" value="${helper.freeEndDate}"/>
        <s:hidden id="helper.fullStartDate" name="helper.fullStartDate" value="${helper.fullStartDate}"/>
        <s:hidden id="helper.fullEndDate" name="helper.fullEndDate" value="${helper.fullEndDate}"/>
        <s:hidden id="runningStartDate" name="helper.runningStartDate"/>
        <s:hidden id="runningEndDate" name="helper.runningEndDate"/>
    </s:form>
</div>
<div region="center">
    <table id="its"></table>
</div>
<script type="text/javascript">
    $(function () {
        $('#its').datagrid({
            url: '<%=request.getContextPath()%>/mng/examproject/members/audProjectMembersInfo/toProjectList.action?querySource=gid&employeeInfo.id=<s:property value="employeeInfo.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.runningStartDate=${helper.runningStartDate}&helper.runningEndDate=${helper.runningEndDate}',
            method: 'post',
            showFooter: false,
            rownumbers: true,
            pagination: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            fitColumns: true,
            idField: 'id',
            border: false,
            singleSelect: true,
            remoteSort: false,
            toolbar: [{
                id: 'emexecl',
                text: '导出',
                iconCls: 'icon-export',
                handler: function () {
                    doSearch();
                }
            }],
            columns: [[
                {field: 'pro_type_name', title: '项目类别', width: 100, halign: 'center', align: 'center', sortable: true},
                {field: 'project_name', title: '项目名称', width: 360, halign: 'center', align: 'left', sortable: true},
                {field: 'roleName', title: '项目角色', width: 100, halign: 'center', align: 'left', sortable: true},
                {
                    field: 'real_start_time',
                    title: '开始日期',
                    width: 100,
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, rowData, rowIndex) {
                        if (value != null && value.length >= 10) {
                            return value.substring(0, 10);
                        }
                        return '';
                    }
                },
                {
                    field: 'state',
                    title: '状态',
                    wdith: 100,
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, rowData, rowindex) {
                        if (rowData.state == "Y") {
                            return "在组";
                        }
                        if (rowData.state == "N") {
                            return "离组";
                        }
                        return '';
                    }
                },
                {
                    field: 'real_closed_time',
                    title: '结束日期',
                    width: 100,
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, rowData, rowIndex) {
                        if (value != null && value.length >= 10) {
                            return value.substring(0, 10);
                        }
                        return '';
                    }
                },
                {field: 'audit_dept_name', title: '审计单位', width: 160, halign: 'center', align: 'left', sortable: true},
                {field: 'audit_object_name', title: '被审计单位', width: 180, halign: 'center', align: 'left', sortable: true}
            ]]
        });
    });
</script>
</body>
</html>
