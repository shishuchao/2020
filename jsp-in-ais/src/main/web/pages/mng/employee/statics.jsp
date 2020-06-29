<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>审计人员基本信息列表2</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type="text/javascript" src="${contextPath}/dwr/engine.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">

<div region="center">
    <table id="list"></table>
</div>

<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form namespace="/mng/employee" action="employeeInfoList" id="searchForm" name="searchForm">
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td class="EditHead">
                        审计单位
                    </td>
                    <td class="editTd">
                        <s:buttonText
                                id="department"
                                name="employeeInfo.department"
                                hiddenId="departmentCode"
                                hiddenName="employeeInfo.departmentCode"
                                doubleOnclick="showSysTree(this, {
                                    url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                    checkbox:true,
                                    param:{
                                    'p_item':3
                                    },
                                    title:'请选择审计单位'
                                })"
                                doubleSrc="/easyui/1.4/themes/icons/search.png" cssClass="noborder" doubleCssStyle="cursor:hand;border:0;" cssStyle="width:300px" readonly="true" doubleDisabled="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        审计人员
                    </td>
                    <td class="editTd">
                        <s:textfield name="employeeInfo.name" cssStyle="width:300px"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">
                        排程空闲查询
                    </td>
                    <td class="editTd">
                        <input type="text" editable="false" class="easyui-datebox noborder" name="free_begin_date" id="free_begin_date" title="单击选择日期">
                        -
                        <input type="text" editable="false" class="easyui-datebox noborder" name="free_end_date" id="free_end_date" title="单击选择日期">
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

<script type="text/javascript">
    $(function () {
        loadDlgSearch();

        initDatagrid();
    });

    function loadDlgSearch() {
        loadSelectH();
        showWin('dlgSearch');
    }

    // 查询
    function doSearch() {
        $('#list').datagrid({
            queryParams: form2Json('searchForm')
        });
        $('#dlgSearch').dialog('close');
    }

    // 重置
    function restal() {
        resetForm('searchForm');
        $('#companyCode').val('${employeeInfo.departmentCode}');
        $('#company').val('${employeeInfo.department}');
    }

    // 取消
    function doCancel() {
        $('#dlgSearch').dialog('close');
    }

    function viewEmployeeInfo(id) {
        var viewUrl = '${contextPath}/mng/employee/employeeInfoView.action?employeeInfo.id=' + id;
        aud$openNewTab('审计人员查看', viewUrl, true);
    }

    // 初始化生成表格
    function initDatagrid() {
        var bodyW = $('body').width();
        $('#list').datagrid({
            url: '${contextPath}/mng/employee/statics.action?querySource=grid',
            method: 'POST',
            showFooter: false,
            rownumbers: true,
            pagination: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            pageSize: 15,
            pageList: [10, 15, 20],
            fitColumns: true,
            border: false,
            singleSelect: true,
            toolbar: [
                {
                    id: 'search',
                    text: '查询',
                    iconCls: 'icon-search',
                    handler: function () {
                        searchWindShow('dlgSearch', 600, 200);
                    }
                },'-',helpBtn
            ],
            onLoadSuccess:function(){
                initHelpBtn();
            },
            columns: [[
                {field: 'audit_dept_name', title: '审计单位', width: bodyW * 0.2 + 'px', halign: 'center', align: 'left', sortable: true},
                {
                    field: 'employee_name', title: '审计人员', width: bodyW * 0.1 + 'px', halign: 'center', align: 'left', sortable: true, formatter: function (value, row, rowIndex) {
                        return '<a href="javascript:void(0);" onclick="viewEmployeeInfo(\'' + row.employee + '\');\">' + value + '</a>';
                    }
                },
                {field: 'planCount', title: '排程计划数', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center'},
                {field: 'runningProjectCount', title: '在审项目数', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center'},
                {field: 'closedProjectCount', title: '已审项目数', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center'},
                {field: 'leadProjectCount', title: '担任组长次数', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center'},
                {field: 'chargeProjectCount', title: '担任主审次数', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center'},
                {field: 'auditProjectCount', title: '担任参审次数', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center'}
            ]]
        });
    }
</script>
</body>
</html>
