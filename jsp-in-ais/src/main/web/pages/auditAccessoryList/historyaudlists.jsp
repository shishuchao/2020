<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title></title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<%--    <STYLE type="text/css">
        .datagrid-row {
            height: 30px;
        }

        .datagrid-cell {
            height: 10%;
            padding: 1px;
        }
    </STYLE>--%>
</head>
<body class="easyui-layout" style="height:100%">
<div id="searchHistory" class="searchWindow" style="width: 820px;">
    <div class="search_head">
        <s:form id="myform" name="myform" action="historyaduProlist" namespace="/auditAccessoryList" method="post">
            <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td class="EditHead" style="width: 18%;">被审计单位名称</td>
                    <td class="editTd" style="width: 32%;">
                        <s:textfield cssClass="noborder" name="middleLedgerProblem.audit_object_name" maxlength="50"
                                     cssStyle="width:80%"/>
                    </td>
                    <td class="EditHead" style="width: 15%;">项目名称</td>
                    <td class="editTd" style="width: 35%;">
                        <s:textfield cssClass="noborder" name="middleLedgerProblem.project_name" maxlength="50"
                                     cssStyle="width:80%"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width: 15%;">问题点</td>
                    <td class="editTd" colspan="3" style="width: 35%;">
                        <s:textfield cssClass="noborder" name="middleLedgerProblem.problem_name" maxlength="50"
                                     cssStyle="width:200px;"/>
                    </td>
                </tr>
            </table>
        </s:form>
    </div>
    <div class="serch_foot">
        <div class="search_btn">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
               onclick="$('#searchHistory').window('close')">取消</a>
        </div>
    </div>
</div>
<div region="center">
    <table id="historyaduProlist"></table>
</div>
<script type="text/javascript">
    //查询条件
    function doSearch() {
        $('#historyaduProlist').datagrid({
            queryParams: form2Json('myform')
        });
        $('#searchHistory').dialog('close');
    }

    //编码链接
    function toOPenWindow(id) {
        var viewHistoryaud = "${contextPath}/proledger/problem/viewDecideLedgerProblem.action?sourceSite=historyview&id="+id;
        //var viewHistoryaud = "${contextPath}/operate/manu/problemToManu.action?view=${param.view}&formId=" + id + "&interaction=${interaction}";
        /* window.open("
        ${contextPath}/proledger/problem/viewDecideLedgerProblem.action?id="+id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no"); */
        window.parent.addTab('tabs', '查看被审历史年度问题', 'tempframe', viewHistoryaud, true);
    }

    //重置查询条件
    function restal() {
        resetForm('myform');
       /* doSearch();*/
    }

    //查询
    showWin('searchHistory');
    $(function () {
        $('#historyaduProlist').datagrid({
            url: "<%=request.getContextPath()%>/auditAccessoryList/historyaduProlist.action?querySource=grid&cruProId=<%=request.getAttribute("cruProId")%>",
            method: 'post',
            showFooter: false,
            rownumbers: true,
            pagination: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            fitColumns: false,
            idField: 'id',
            border: false,
            singleSelect: true,
            remoteSort: false,
            toolbar: [{
                id: 'searchObj',
                text: '查询',
                iconCls: 'icon-search',
                handler: function () {
                    searchWindShow('searchHistory', 850);
                }
            },'-',helpBtn
            ],
            onLoadSuccess:function(){
                initHelpBtn();
            },
            columns: [[
                {
                    field: 'audit_object_name',
                    title: '被审计单位名称',
                    align: 'left',
                    halign:'center',
                    width: '13%',
                    sortable: true
                },
                {
                    field: 'project_name',
                    title: '项目名称',
                    width: '20%',
                    sortable: true,
                    halign:'center',
                    align: 'left'
                },
                {
                    field: 'serial_num',
                    title: '问题编号',
                    align: 'left',
                    halign:'center',
                    width: '12%',
                    sortable: true,
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href=\"javascript:void(0)\" onclick=\"toOPenWindow(\'' + rowData.id + '\');\">' + value + '</a>';
                    }
                },
                {
                    field: 'problem_all_name',
                    title: '问题类别',
                    align: 'left',
                    halign:'center',
                    width: '13%',
                    sortable: true
                },
                {
                    field: 'problem_name',
                    title: '问题点',
                    align: 'left',
                    halign:'center',
                    width: '13%',
                    sortable: true
                },
                {
                    field: 'problem_money',
                    title: '涉及金额（万元）',
                    align: 'right',
                    halign:'center',
                    width: '7%',
                    sortable: true,
                    formatter: aud$gridFormatMoney
                },
                {
                    field: 'problemCount',
                    title: '发生数量',
                    align: 'right',
                    halign:'center',
                    width: '7%',
                    sortable: true
                },
                {
                    field: 'problem_grade_name',
                    title: '审计发现类型',
                    align: 'center',
                    halign:'center',
                    width: '8%',
                    sortable: true
                }/* ,
                {
                    field: 'describe',
                    title: '问题摘要',
                    align: 'left',
                    halign:'center',
                    width: '10%',
                    sortable: true
                },
                {
                    field: 'audit_advice',
                    title: '审计建议',
                    width: '10%',
                    align: 'left',
                    halign:'center',
                    sortable: true
                } */
            ]]
        });
        $('#historyaduProlist').datagrid('doCellTip', {
            position : 'bottom',
            maxWidth : '200px',
            tipStyler : {
                'backgroundColor' : '#EFF5FF',
                borderColor : '#95B8E7',
                boxShadow : '1px 1px 3px #292929'
            }
        });
    });

</script>
</body>
</html>