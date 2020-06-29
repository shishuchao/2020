<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>消息管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css"/>
<%--    <STYLE type="text/css">
        div.datagrid-cell {
            text-overflow: ellipsis;
        }

        .datagrid-cell-rownumber {
            height: 21px;
        }
    </STYLE>--%>
</head>
<body class="easyui-layout">

<div id="dlgSearch" class="searchWindow" title="查询条件">
    <div class="search_head">
        <s:form id="searchForm">
            <table class="ListTable" cellpadding=0 cellspacing=0 border=0 align="center">
                <tr>
                    <td class="EditHead" align="left" style="width:15%">
                        所属单位
                    </td>
                    <td class="editTd" align="left" style="width:35%">
                        <s:buttonText2 hiddenName="condition.orgId"
                                       name="condition.orgName"
                                       cssStyle="width:160px;"
                                       cssClass="noborder"
                                       doubleOnclick="showSysTree(this,{
											url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
											title:'&nbsp;&nbsp;&nbsp;请选择审计单位',
											param:{
                                                'p_item':1,
                                                'orgtype':1,
                                                'beanName':'UOrganization',
                                                'id':'${user.fdepid}'
											}
										});"
                                       doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                       doubleCssStyle="cursor:hand;border:0"/>
                    </td>
                    <td class="EditHead" align="left" style="width:15%">
                        接收人
                    </td>
                    <td class="editTd" align="left" style="width:35%">
                        <s:textfield name="condition.toUsers" cssStyle="width: 100%"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" align="left">
                        消息标题
                    </td>
                    <td class="editTd" align="left">
                        <s:textfield name="condition.subject" cssStyle="width: 100%"/>
                    </td>
                    <td class="EditHead" align="left">
                        消息内容
                    </td>
                    <td class="editTd" align="left">
                        <s:textfield name="condition.bodyText" cssStyle="width: 100%"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" align="left">
                        消息阅读状态
                    </td>
                    <td class="editTd" align="left">
                        <s:select name="condition.isRead" list="#@java.util.LinkedHashMap@{'':'','true':'已读','false':'未读'}" cssStyle="width:40%;"/>
                    </td>
                    <td class="EditHead" align="left">
                        邮件发送状态
                    </td>
                    <td class="editTd" align="left">
                        <s:select name="condition.isSend" list="#@java.util.LinkedHashMap@{'':'','true':'已发送','false':'未发送'}" cssStyle="width:40%;"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" align="left">
                        消息类型
                    </td>
                    <td class="editTd" align="left" colspan="3">
                        <s:select name="condition.isSendMail" list="#@java.util.LinkedHashMap@{'':'','true':'邮件','false':'站内消息'}"/>
                    </td>
                </tr>
            </table>
        </s:form>
    </div>

    <div class="search_foot" align="right" style="margin-top:170px;">
        <div class="search_btn">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
        </div>
    </div>
</div>

<div region="center">
    <table id="mytable"></table>
</div>

<script type="text/javascript">
    // 初始化
    $(function () {
        // 查询对话框
        showWin('dlgSearch');

        // 列表
        $('#mytable').datagrid({
            url: '${contextPath}/msg/mng/list.action?querySource=grid',
            method: 'POST',
            queryParams: form2Json('searchForm'),
            striped: true,
            fit: true,
            fitColumns: true,
            autoRowHeight: false,
            border: false,
            remoteSort: true,
            sortName: 'createTime',
            sortOrder: 'desc',
            pagination: true,
            pageSize: 20,
            pageList: [10, 20, 30],
            rownumbers: true,
            toolbar: [
                {
                    id: 'search',
                    text: '查询',
                    iconCls: 'icon-search',
                    handler: function () {
                        searchWindShow('dlgSearch', 750, 250);
                    }
                },'-',
                {
                    id: 'sendAll',
                    text: '再次发送/提醒',
                    iconCls: 'icon-start',
                    handler: function () {
                        var ids = getSelectIds();
                        if (ids.length == 0) {
                            showMessage1('请选择要发送的消息！');
                            return;
                        }
                        doSend(ids);
                    }
                },'-',
                {
                    id: 'delete',
                    text: '删除',
                    iconCls: 'icon-delete',
                    handler: function () {
                        var ids = getSelectIds();
                        if (ids.length == 0) {
                            showMessage1('请选择要删除的消息！');
                            return;
                        }
                        top.$.messager.confirm('提示信息', '确定要删除消息吗？', function (isDelete) {
                            if (isDelete) {
                                doDelete(ids);
                            }
                        });
                    }
                },
                '-',
                helpBtn
            ],
            onLoadSuccess:function(){
                initHelpBtn();
            },
            columns: [[
                {field: 'msgId', checkbox: true, halign: 'center', align: 'center', title: '选择'},
                {
                    field: 'subject', title: '消息标题', halign: 'center', width: 200, sortable: true,
                    formatter: function (value) {
                        if (value) {
                            value = value.replace(/<[^>]+>/g, '');
                            value = '<a title="'  + value + '">' + value + '</a>';
                        }
                        return value;
                    }
                },
                {
                    field: 'bodyText', title: '消息内容', halign: 'center', width: 300,
                    formatter: function (value) {
                        if (value) {
                            value = value.replace(/<[^>]+>/g, '');
                            value = '<a title="'  + value + '">' + value + '</a>';
                        }
                        return value;
                    }
                },
                {field: 'fromUserName', title: '发送人', halign: 'center', align: 'center', width: 100, sortable: true},
                {field: 'fromUser', title: '发送人账号', halign: 'center', width: 100, sortable: true},
                {field: 'toUsersName', title: '接收人', halign: 'center', align: 'center', width: 100, sortable: true},
                {field: 'toUsers', title: '接收人账号', halign: 'center', width: 100, sortable: true},
                {field: 'toAddresses', title: '接收邮箱', halign: 'center', width: 200, sortable: true},
                {
                    field: 'createTime', title: '创建时间', halign: 'center', sortable: true,
                    formatter: function (value) {
                        if (value != '' && value != null) {
                            return value.replace('T', ' ');
                        }
                        return '';
                    }
                },
                {
                    field: 'isRead', title: '消息阅读状态', halign: 'center', align: 'center', sortable: true,
                    formatter: function (value) {
                        return value ? '已读' : '未读';
                    }
                },
                {
                    field: 'isSendMail', title: '是否发送邮件', halign: 'center', align: 'center', sortable: true,
                    formatter: function (value) {
                        return value ? '是' : '否';
                    }
                },
                {
                    field: 'isSend', title: '邮件发送状态', halign: 'center', align: 'center', sortable: true,
                    formatter: function (value) {
                        return value ? '已发送' : '未发送';
                    }
                },
                {
                    field: 'operates', title: '操作', halign: 'center', align: 'center',
                    formatter: function (value, row, rowIndex) {
                        return '<a href="javascript://" onclick="doSend([\'' + row.msgId + '\'])">' + (row.isSendMail ? '重发邮件' : '重发消息') + '</a>';
                    }
                }
            ]]
        })
    });

    // 查询条件-查询
    function doSearch() {
        $('#mytable').datagrid({
            queryParams: form2Json('searchForm'),
        });
        $('#dlgSearch').dialog('close');
    }

    // 查询条件-重置
    function restal() {
        resetForm('searchForm');
    }

    // 查询条件-取消
    function doCancel() {
        $('#dlgSearch').dialog('close');
    }

    // 获取选中行主键
    function getSelectIds() {
        var ids = [];
        var rows = $('#mytable').datagrid('getChecked');
        if (rows.length) {
            $.each(rows, function (i) {
                ids[i] = rows[i].msgId;
            });
        }
        return ids;
    }

    function doSend(ids) {
        $.ajax({
            url: '${contextPath}/msg/mng/send.action',
            type: 'POST',
            data: {msgIds: ids},
            success: function (data) {
                if (data.status == 'ok') {
                    showMessage2(data.msg ? data.msg : '发送/提醒成功');
                } else {
                    var msg = data.msg;
                    if (data.details && data.details.length) {
                        msg = '';
                        $.each(data.details, function (i, row) {
                            msg += '消息"' + row.title + '" 发送失败，' + row.msg + '\n';
                        });
                    }
                    alert(msg);
                }
                $('#mytable').datagrid('reload');
            },
            error: function () {
                showMessage2('调用发送接口失败！');
            }
        });
    }

    function doDelete(ids) {
        $.ajax({
            url: '${contextPath}/msg/mng/delete.action',
            type: 'POST',
            data: {msgIds: ids},
            success: function (data) {
                showMessage2(data.msg);
                if (data.status == 'ok') {
                    $('#mytable').datagrid('reload');
                }
            },
            error: function () {
                showMessage2('调用删除接口失败！');
            }
        });
    }
</script>
</body>
</html>