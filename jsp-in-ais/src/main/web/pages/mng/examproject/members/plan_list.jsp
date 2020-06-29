<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>计划信息</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script language="javascript" type="text/javascript">
        function selall_inform(chk, selected) {
            if (selected == null || selected === '') selected = true;
            for (var i = 0; i < chk.length; i++) chk[i].checked = selected;
        }
    </script>
    <script language="javascript" type="text/javascript">

        function declareExport(bool) {
            document.getElementById('export').value = bool;
            doSearch();
            return true;
        }

        function goEdit(t) {
            location.href = '${contextPath}/mng/examproject/members/audProjectMembersInfo/edit.action?project_members_id=' + t;
        }

        function doSearch() {
            document.getElementById('export').value = "true";
            $('#itts').datagrid({
                queryParams: form2Json('searchForm')
            });
        }
    </script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div>
    <s:form action="toPlanList" name="searchForm" id="searchForm" namespace="/mng/examproject/members/audProjectMembersInfo" method="post">
        <s:hidden id="export" name="export"></s:hidden>
        <s:hidden id="querySource" name="querySource" value="gid"></s:hidden>
        <s:hidden id="employeeInfo.id" name="employeeInfo.id" value="${employeeInfo.id}"></s:hidden>
        <s:hidden id="helper.freeStartDate" name="helper.freeStartDate" value="${helper.freeStartDate}"></s:hidden>
        <s:hidden id="helper.freeEndDate" name="helper.freeEndDate" value="${helper.freeEndDate}"></s:hidden>
        <s:hidden id="helper.fullStartDate" name="helper.fullStartDate" value="${helper.fullStartDate}"></s:hidden>
        <s:hidden id="helper.fullEndDate" name="helper.fullEndDate" value="${helper.fullEndDate}"></s:hidden>

    </s:form>
</div>
<div region="center">
    <table id="its"></table>
</div>
<script type="text/javascript">
    function doSearch() {
        document.getElementById('export').value = "true";
        //$('#itts').datagrid({
        //	queryParams:form2Json('searchForm')
        //});
        document.getElementById("searchForm").submit();
    }

    $(function () {
        $('#its').datagrid({
            url: '<%=request.getContextPath()%>/mng/examproject/members/audProjectMembersInfo/toPlanList.action?querySource=grid&employeeInfo.id=<s:property value="employeeInfo.id"/>&helper.freeStartDate=${helper.freeStartDate}&helper.freeEndDate=${helper.freeEndDate}&helper.fullStartDate=${helper.fullStartDate}&helper.fullEndDate=${helper.fullEndDate}',
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
                {field: 'plan_type_name', title: '计划类别', width: 100, align: 'center', sortable: true},
                {field: 'pro_type_name', title: '项目类别', width: 100, sortable: true, align: 'left'},
                {
                    field: 'roleName',
                    title: '项目角色',
                    width: 180,
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'project_name',
                    title: '计划名称',
                    width: 180,
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'nodeState',
                    title: '计划状态',
                    width: 100,
                    halign: 'center',
                    sortable: true,
                    align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        //liululu 返回值字段名称写错了
                        return rowData.nodeState;
                    }
                },
                {
                    field: 'real_start_time',
                    title: '开始日期',
                    width: 100,
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if (value != null) {
                            return value.substring(0, 10);
                        }
                    }
                }, {
                    field: 'real_closed_time',
                    title: '结束日期',
                    width: 100,
                    halign: 'center',
                    sortable: true,
                    align: 'center',
                    formatter: function (value, row, index) {
                        if (value != null) {
                            return value.substring(0, 10);
                        }
                    }
                },
                {
                    field: 'audit_dept_name',
                    title: '审计单位',
                    width: 180,
                    halign: 'center',
                    align: 'left',
                    sortable: true
                }, {
                    field: 'audit_object_name',
                    title: '被审计单位',
                    width: 180,
                    halign: 'center',
                    sortable: true,
                    align: 'left'
                }
            ]]
        });
    });
</script>
</body>
</html>
