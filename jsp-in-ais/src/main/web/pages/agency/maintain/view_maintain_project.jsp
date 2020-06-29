<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>中介机构查看-服务项目</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/jquery.multiSelect.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <link href="<%=request.getContextPath()%>/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
</head>
<body class="easyui-layout" style="margin:0;padding:0;">
<div region="center">
    <table id="mytable" style="height:100%"></table>
</div>
<script type="text/javascript">
    $(function () {
        $('#mytable').datagrid({
            url: '/ais/agency/maintain/viewMaintainProject.action?formId=${formId}',
            queryParams: {
                querySource: 'grid'
            },
            rownumbers: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            fitColumns: false,
            border: false,
            showFooter: true,
            columns: [[
                {field: 'project_name', title: '项目名称', width: 500},
                {field: 'status', title: '状态', width: 80},
                {field: 'project_code', title: '项目编号', width: 180},
                {field: 'project_type_name', title: '项目类别', width: 150},
                {field: 'audit_object_name', title: '服务企业', width: 200},
                {field: 'pro_teamleader_name', title: '组长', width: 120},
                {field: 'pro_auditleader_name', title: '主审', width: 120},
                {
                    field: 'point', title: '打分', width: 100, formatter: function (value, row, rowIndex) {
                        if (row.isFooter || row.point_time) {
                            return value;
                        }
                        return '未打分';
                    }
                },
                {field: 'point_time', title: '打分时间', width: 100}
            ]],
            onLoadSuccess: onMyTableLoadSuccess
        });
    });

    function onMyTableLoadSuccess() {
        var rows = $('#mytable').datagrid('getData').rows;
        if (rows.length) {
            var sumPoint = 0, sumCount = 0;
            $.each(rows, function (i, row) {
                if (row.point_time) {
                    sumPoint += parseFloat(row.point);
                    sumCount++;
                }
            });
            $('#mytable').datagrid('reloadFooter', [{point: '平均分：' + Math.round(sumPoint / sumCount * 100) / 100, isFooter: true}]);
        }
    }
</script>
</body>
</html>