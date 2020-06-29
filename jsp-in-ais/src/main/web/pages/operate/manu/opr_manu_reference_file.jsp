<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>引用附件</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div region="north" data-options="split:false,collapsible:false" style="height:60px;overflow:hidden;">
    <s:form id="searchForm" name="searchForm" action="queryFileSelect" namespace="/operate/manu" method="post">
        <s:token/>
        <s:hidden name="project_id"/>
        <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
            <tr>
                <td align="left" class="EditHead">文件名称</td>
                <td align="left" class="editTd">
                    <s:textfield cssClass="noborder" cssStyle="width:500px;" name="file_name" maxlength="100"/>
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()" style="margin-left:100px;">查询</a>
                </td>
            </tr>
        </table>
    </s:form>
</div>
<div region="center">
    <table id="fileSelectList"></table>
</div>
<script type="text/javascript">
    function doSearch() {
        $('#fileSelectList').datagrid({
            queryParams: form2Json('searchForm')
        });
    }

    function mySure() {
        var selectedRows = $('#fileSelectList').datagrid('getChecked');//返回是个数组
        if (selectedRows.length == 0) {
            $.messager.alert('提示信息', '请选择附件!', 'info');
            return false;
        }

        var file_ids = new Array();
        $.each(selectedRows, function (i, item) {
            file_ids.push(item.fileId);
        });

        $.ajax({
            type: "POST",
            dataType: "text",
            url: "${contextPath}/operate/manu/copyFile.action",
            async: false,
            data: {file_ids: file_ids, project_id: '${project_id}', fileGuid: '${fileGuid}'},
            success: function () {
                parent.closeWinUI_file();
            }
        });

    }

    function formatFileSize(fileSize) {
        try {
            if (fileSize) {
                if (fileSize > 1000) {
                    fileSize = parseFloat(fileSize / 1024).toFixed(1) + "M";
                } else {
                    fileSize = fileSize + "K";
                }
            } else {
                fileSize = '--';
            }
            return fileSize;
        } catch (e) {
            isdebug ? alert("fileUpload.formatFileSize:\n" + e.message) : null;
        }
    }

    $(function () {
        // 初始化生成表格
        $('#fileSelectList').datagrid({
            url: "<%=request.getContextPath()%>/operate/manu/queryFileSelect.action?querySource=grid&project_id=${project_id}&t=" + new Date().getTime(),
            method: 'POST',
            showFooter: false,
            rownumbers: true,
            pagination: false,
            striped: true,
            autoRowHeight: false,
            fit: true,
            fitColumns: false,
            idField: 'fileId',
            border: false,
            singleSelect: false,
            remoteSort: false,
            toolbar: [{
                id: 'mySure',
                text: '确定',
                iconCls: 'icon-ok',
                handler: function () {
                    mySure();
                }
            }],
            columns: [[
                {field: 'fileId', title: "复选框", width: '7%', checkbox: true},
                {field: 'fileName', title: '附件名称', width: '25%', halign: 'center', align: 'left', sortable: true},
                {
                    field: 'fileSize', title: '大小', width: '80px', halign: 'center', align: 'right', sortable: true,
                    formatter: function (value, currow, index) {
                        return value ? formatFileSize(parseFloat(value / 1024).toFixed(1)) : value;
                    }
                },
                {field: 'fileTime', title: '上传时间', width: '165px', halign: 'center', align: 'center', sortable: true},
                {field: 'uploader_name', title: '上传人', width: '80px', halign: 'center', align: 'center', sortable: true},
                {field: 'fileEditTime', title: '修改时间', width: '165px', halign: 'center', align: 'center', sortable: true},
                {field: 'remark_name', title: '修改人', width: '80px', halign: 'center', align: 'center', sortable: true}
            ]]
        });
    });
</script>
</body>
</html>