<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>审计对象被审情况</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
</head>
<body class="easyui-layout" style="margin:0;padding:0;overflow:hidden;">

<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form id="searchForm">
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td class="EditHead" sytle="width:15%">所属审计单位</td>
                    <td class="editTd" sytle="width:35%">
                        <s:buttonText id="audit_dept_name"
                                      hiddenId="audit_dept_id"
                                      name="audit_dept_name"
                                      hiddenName="audit_dept_id"
                                      doubleOnclick="showSysTree(
                                            this,
                                            {
                                                url:'${pageContext.request.contextPath}/systemnew/orgListByCurrentAndLowerLevel.action',
                                                title:'请选择所属审计单位'
                                            }
                                      )"
                                      cssClass="noborder" cssStyle="width:300px"
                                      doubleSrc="/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" sytle="width:15%">被审计单位</td>
                    <td class="editTd" sytle="width:35%">
                        <s:buttonText id="audit_object_name"
                                      hiddenId="audit_object_id"
                                      hiddenName="audit_object_id"
                                      name="audit_object_name"
                                      doubleOnclick="showSysTree(
                                            this,
                                            {
                                                url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                                                cache:false,
                                                checkbox:true,
                                                title:'请选择被审计单位'
                                            }
                                      )"
                                      cssClass="noborder" cssStyle="width:300px"
                                      doubleSrc="/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
                    </td>
                </tr>
            </table>
        </s:form>
    </div>
    <div class="serch_foot">
        <div class="search_btn">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
        </div>
    </div>
</div>

<div region="center" border="0">
    <table id="mytable"></table>
</div>

<script type="text/javascript">
    $(function () {
        showWin('dlgSearch');

        $('#mytable').datagrid({
            url: '${contextPath}/mng/audobj/report/auditingObjectStasticsData.action?querySource=grid',
            method: 'POST',
            queryParams: form2Json('searchForm'),
            rownumbers: true,
            pagination: false,
            striped: true,
            autoRowHeight: false,
            fit: true,
            fitColumns: true,
            border: false,
            singleSelect: true,
            remoteSort: true,
            toolbar: [
                {
                    text: '查询', iconCls: 'icon-search', handler: function () {
                        searchWindShow('dlgSearch');
                    }
                },
                {
                    text: '导出到Excel',
                    iconCls: 'icon-export',
                    handler: function () {
                        var url = '${contextPath}/mng/audobj/report/auditingObjectStasticsData.action?querySource=export' +
                            "&sort=" + $('#mytable').datagrid('options').sortName +
                            "&order=" + $('#mytable').datagrid('options').sortOrder +
                            "&" + $('#searchForm').serialize();
                        window.open(url);
                    }
                },
                '-',
                helpBtn
            ],
            onLoadSuccess: function () {
                initHelpBtn()
            },
            columns: [[
                {field: 'audit_object_name', title: '被审计单位', width: '200px', halign: 'center', align: 'left', sortable: true},
                {field: 'audit_dept_name', title: '所属审计单位', width: '200px', halign: 'center', align: 'left', sortable: true},
                {field: 'last_audit_end_time', title: '上次审计期间结束', width: '150px', halign: 'center', align: 'center', sortable: true},
                {field: 'yearNum', title: '未审期间（年）', width: '100px', halign: 'center', align: 'center'},
                {field: 'projectNum', title: '被审次数（审计项目数）', width: '180px', halign: 'center', align: 'center', sortable: true}
            ]]
        })
    });

    // 查询
    function doSearch() {
        $('#mytable').datagrid({
            queryParams: form2Json('searchForm')
        });
        $('#dlgSearch').dialog('close');
    }

    // 重置
    function restal() {
        resetForm('searchForm');
    }

    // 取消
    function doCancel() {
        $('#dlgSearch').dialog('close');
    }
</script>
</body>
</html>