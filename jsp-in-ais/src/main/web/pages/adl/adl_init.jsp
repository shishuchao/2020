<!DOCTYPE HTML >
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>审前关注点管理（资源管理）</title>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript">
        var gParam = '';
        // 初始化
        $(function () {
            // 初始化审计疑点列表
            $('#sjydQueryDataTab').datagrid({
                url: "<%=request.getContextPath()%>/adl/querySjyd.action",
                queryParams: {},
                title: '审前关注点详细信息',
                rownumbers: true,
                pagination: true,
                collapsible: false,
                striped: true,
                pageSize: 20,
                loadMsg: '审前关注点加载中，请稍后',
                fit: true,
                idField: "id",
                order: 0,
                fitColumns: true,
                remoteSort: false,
                singleSelect: true,
                checkOnSelect: false,
                selectOnCheck: false,
                onCheck: function (rowIndex, rowData) {
                    var loginname = '${user.floginname}';
                    var ydfxrdm = rowData['ydfxrDm'];
                    if (loginname != ydfxrdm) {
                        top.$.messager.show({title: '提示信息', msg: '只能选择本人录入的关注点，当前人员没有权限！'});
                        $('#sjydQueryDataTab').datagrid('uncheckRow', rowIndex);
                    }
                },
                toolbar: [{
                    text: '查询',
                    id: 'querySjyd2',
                    iconCls: 'icon-search',
                    handler: function () {
                        searchWindShow('query_div', 800);
                    }
                },
                    <s:if test="${flag == '' or flag==null}">
                    '-', {
                        text: '新增',
                        iconCls: 'icon-add',
                        id: 'lrsjyd_openWin',
                        handler: function () {
                            //由于上传附件时就需要UUID，所以新增时，提前拿到UUID
                            clearYdlr();
                            $('#eidtType').val('save');
                            getMaxYdbm();
                            autoTextareatag();
                            openWin('lrsjyd_div', '新增审前关注点');
                        }
                    }, '-', {
                        text: '删除',
                        iconCls: 'icon-delete',
                        id: 'sjydDelBtn',
                        handler: function () {
                            removeSjyd();
                        }
                    }, '-', {
                        text: '处理为无问题',
                        id: 'dealnoreason',
                        iconCls: 'icon-cancel',
                        handler: dealDoubt
                    }, '-', {
                        text: '查看使用情况',
                        iconCls: 'icon-view',
                        handler: function () {
                            getSjydWorkInfo();
                        }
                    }
                    </s:if>
                    <s:if test="${flag == '2'}">
                    '-', {
                        text: '恢复',
                        id: 'resetHistoryDoubt',
                        iconCls: 'icon-recover',
                        handler: function () {
                            setHistoryDoubt("0")
                        }
                    }, '-', {
                        text: '清理',
                        id: 'setHistoryDoubt',
                        iconCls: 'icon-clean',
                        handler: function () {
                            setHistoryDoubt("1")
                        }
                    },
                    </s:if>
                    <s:if test="${flag == '1'}">
                    '-', {
                        text: '查看使用情况',
                        iconCls: 'icon-view',
                        handler: function () {
                            getSjydWorkInfo();
                        }
                    }
                    </s:if>
                ],
                frozenColumns: [[
                    {field: 'id', checkbox: true, hidden: ("${flag}" != ""), width: '120', halign: 'center', align: 'center', sortable: true},
                    {
                        field: 'ydbm', title: '关注点编码', width: '120', halign: 'center', align: 'center', sortable: true,
                        formatter: function (value, rowData, rowIndex) {
							var edit =  ${flag == '' or flag==null} && '${user.floginname}' == rowData['ydfxrDm'];

                            return '<a href="javascript:"' +
                                ' title="' + (edit ? '编辑' : '查看') + '"' +
                                ' onclick="editSjydRowIndex(' + rowIndex + ', ' + (edit ? 'null' : '\'view\'')+ ')"' +
                                '>' +
                                value + '</a>';
                        }
                    },
                    {
                        field: 'ydmc', title: '关注点名称', width: '180', halign: 'center', align: 'left', sortable: true,
                        formatter: function (value, rowData, rowIndex) {
                            if ('${user.floginname}' == rowData['ydfxrDm']) {
                                return ['<label style="color:#6a6aff;">', value, '</label>'].join('');
                            }
                            return value;
                        }
                    }
                ]],
                columns: [[
                    {
                        field: 'ydqjQ',
                        title: '关注点开始时间',
                        width: '130',
                        halign: 'center',
                        align: 'center',
                        formatter: function (value, rowData, rowIndex) {
                            return value && value.length > 10 ? value.substring(0, 10) : value;
                        },
                        sortable: true,
                    },
                    {
                        field: 'ydqjZ',
                        title: '关注点结束时间',
                        width: '130',
                        halign: 'center',
                        align: 'center',
                        formatter: function (value, rowData, rowIndex) {
                            return value && value.length > 10 ? value.substring(0, 10) : value;
                        }, sortable: true
                    },
                    {field: 'bsjdwMc', title: '被审计单位', width: '200', halign: 'center', sortable: true},
                    {field: 'wtlbMc', title: '问题类别', width: '200', halign: 'center', align: 'center', sortable: true},
                    {field: 'zcfgMc', title: '政策法规依据', width: '200', halign: 'center', align: 'center', sortable: true},
                    {field: 'doubt_reason', title: '无问题原因', width: '150', halign: 'center', align: 'center', sortable: true},
                    {field: 'doubt_statusName', title: '处理状态', width: '100', halign: 'center', align: 'center', sortable: true},
                    {field: 'ydly', title: '关注点来源', width: '100', halign: 'center', align: 'center', sortable: true},
                    {
                        field: 'doubt_project_code', title: '处理项目及底稿', width: '300',
                        formatter: function (value, rowData, rowIndex) {
                            var rt = "";
                            if (value) {
                                var projectId = rowData['project_id'];
                                rt = "<label style='color:blue;border-bottom:1px solid blue;cursor:pointer;' onclick=\"viewProject('" + projectId + "')\">" + value + "</label>";
                            }
                            var doubt_manu_code = rowData['doubt_manu_code'];
                            if (doubt_manu_code) {
                                var manuId = rowData['manu_id'];
                                rt += " <strong>/</strong> <label style='color:blue;border-bottom:1px solid blue;cursor:pointer;' onclick=\"viewDg('" + manuId + "')\">" + doubt_manu_code + "</label>";
                            }
                            return rt;
                        }
                    },
                    {field: 'historyDoubtShowName', title: '是否历史关注点', width: '120', halign: 'center', align: 'center', sortable: true},
                    {field: 'ydfxrMc', title: '关注点发现人', width: '100', halign: 'center', align: 'center', sortable: true},
                    {
                        field: 'tjrq',
                        title: '提交日期',
                        width: '150',
                        align: 'center',
                        sortable: true,
                        formatter: function (value, rowData, rowIndex) {
                            return value && value.length >= 10 ? value.substring(0,10) : value;
                        }
                    }
                ]]
            });

            //加载左侧被审计单位树

            var obj = $('#orgTree')[0];
            // var dpetId= '1';

            var dpetId = '${magOrganization.fid}';
            showSysTree(obj, {
                //url:'<%=request.getContextPath()%>/ais/adl/getOrgTree.action',
                url: '${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action?departmentId=' + dpetId,
                container: obj,
                noMsg: true,
                defaultDeptId: dpetId,
                param: {
                    'rootId': 1,
                    'beanName': 'AuditingObjectTree',
                    'treeId': 'id',
                    'treeText': 'name',
                    'treeParentId': 'parentId',
                    'treeOrder': 'currentCode',
                    'treeAtrributes': 'currentCode'
                },

                /* onTreeClick:function(node,treeDom){
                     $('#childBasefrm').attr('src',frmUrl+node.id);
                 },
                 onTreeLoadSuccess:function(node,data){
                     if(data.length == 1){
                         $('#childBasefrm').attr('src', frmUrl+data[0].id);
                     }
                 },*/
                onTreeClick: function (node, treeDom) {
                    $('#resetSjyd').click();
                    if (node.attributes) {
                        var attrJson = $.parseJSON(node.attributes);
                        $('#audobjCurrentCode').val(attrJson.currentCode);
                    }
                    $('#queryAd_bsjdwDm').val(node.id);
                    $('#queryAd_bsjdwMc').val(node.text);
                    querySjyd();
                }
            });

            autoTextarea($('#dealDoubtReason')[0]);
            $('#ydnr').attr('maxlength', 1000);
            $('#zcfgMc').attr('maxlength', 3000);
            $('#lrsjyd_div').show();
            $('#lrsjyd_div').dialog({
                closed: true,
                collapsible: false,
                maximizable: false,
                minimizable: false,
                modal: true,
                width: 900,
                height: 450,
                onClose: function () {
                },
                onOpen: function () {
                    $('#doubtFile').fileUpload('reloadFile');
                },
                buttons: [{
                    text: '保存',
                    iconCls: 'icon-save',
                    handler: function () {
                        adl$save();
                    }
                }, {
                    text: '关闭',
                    iconCls: 'icon-cancel',
                    handler: function () {
                        $('#lrsjyd_div').dialog('close');
                    }
                }]

            });
            //初始化查看关注点窗口
            generateWin('viewlrsjyd_div');
            $('#viewlrsjyd_div').show();
            $('#viewlrsjyd_div').window({
                onOpen: function () {
                    $('#view_doubtFile').fileUpload('reloadFile');
                    $('#viewlrsjyd_div').css("overflow", "auto");
                }
            });
            //初始化查看底稿窗口
            $('#viewDgDiv').window({
                width: 900,
                height: 400,
                modal: true,
                collapsible: false,
                maximizable: false,
                minimizable: false,
                closed: true
            });

            //初始化查看项目信息窗口
            $('#viewProjectDiv').window({
                width: 900,
                height: 400,
                modal: true,
                collapsible: false,
                maximizable: false,
                minimizable: false,
                closed: true
            });
            //查询
            showWin('query_div');
            // 清空审前关注点录入
            $('#clearSjydlr').bind('click', function () {
                clearYdlr();
                getMaxYdbm();
            });


            // 清空录入关注点表单
            function clearYdlr() {
                var arr = ['id', 'ydmc', 'ydbm', 'ydqjQ', 'ydqjZ', 'bsjdwDm', 'bsjdwMc', 'ydnr', 'wtlbDm', 'wtlbMc', 'zcfgDm', 'zcfgMc', 'doubt_reason', 'fj'];
                $.each(arr, function (i, ele) {
                    $('#' + ele).val('');
                });

                var num = Math.random();
                var rnm = Math.round(num * 9000000000 + 1000000000);
                $('#fj').val(rnm);
                $('#doubtFile').fileUpload({
                    'fileGuid': rnm
                });
            }

            // 获得最大关注点编码
            function getMaxYdbm() {
                $.ajax({
                    dataType: 'json',
                    url: "<%=request.getContextPath()%>/adl/getMaxYdbm.action",
                    type: "POST",
                    success: function (data) {
                        $('#ydbm').val(data.ydbm);
                    }
                });
            }

            // 清空查询表单

            $('#resetSjyd').bind('click', function () {
                /* 		$("#queryAd.tjrq").datebox("setValue","");
                        $("#queryAd.ydqjQ").datebox("setValue","");
                        $("#queryAd.ydqjZ").datebox("setValue","");
                         var arr = ['ydmc','ydbm','ydqjQ','ydqjZ','ydnr','bsjdwDm','bsjdwMc','ydfxrMc','tjrq'];
                        $.each(arr, function(i, ele){
                            $('input[name='+'queryAd\\.'+ele+']').val('');
                        }); */
                resetForm('sjyd_query_form');
                //	document.getElementById("sjyd_query_form").reset();
            });


            $('#lr_openWtlbTree').bind('click', function () {
            });


            //  关注点使用情况win
            $('#sjydWorkInfoData').window({
                width: 1024,
                height: 370,
                modal: true,
                collapsible: false,
                maximizable: true,
                minimizable: false,
                closed: true
            });

            // 关注点处理无问题window
            $('#dealDoubtWin').window({
                width: 1000,
                height: 450,
                modal: true,
                collapsible: false,
                maximizable: true,
                minimizable: false,
                closed: true,
                onClose: function () {
                    $('#dealDoubt_id').val("");
                    $('#dealDoubtReason').val('');
                },
                onOpen: function () {
                    // 产生随机id
                    var num = Math.random();
                    var rnm = Math.round(num * 9000000000 + 1000000000);
                    $('#deal_reason_guid').val(rnm);
                    $('#doubtReasionFile').fileUpload({
                        'fileGuid': rnm
                    });
                    $('#doubtReasionFile').fileUpload('reloadFile');
                    $('#dealDoubtBtnBar,#dealDoubt_fileUploadBtn').show();
                }
            });
            $('#dealDoubtBtn').bind('click', function () {
                if ($('#dealDoubtReason').val() == '') {
                    $.messager.show({title: '提示信息', msg: '无问题原因不能为空!'});
                    return false;
                }
                $.ajax({
                    dataType: 'json',
                    url: "<%=request.getContextPath()%>/adl/dealDoubt.action",
                    data: {
                        "reason_guid": $('#deal_reason_guid').val(),
                        "doubt_reason": $('#dealDoubtReason').val(),
                        "doubutId": $('#dealDoubt_id').val()
                    },
                    type: "POST",
                    success: function (data) {
                        $.messager.alert('提示信息', data.msg, data.type, function () {
                            if (data.type != 'error') {
                                $('#dealDoubtWin').window('close');
                                querySjyd();
                            }
                        });
                    },
                    error: function (data) {
                        $.messager.show({title: '提示信息', msg: '请求失败！请检查网络配置或者与管理员联系！'});
                    }
                });
            });
            $('#closeDoubtBtn').bind('click', function () {
                $('#dealDoubtWin').window('close');
            });

            // 设置为历史关注点
            function setHistoryDoubt(isHistory) {
                var title = "";
                if (parseInt(isHistory)) {
                    title = "确认要清理该关注点吗？";
                } else {
                    title = "确认要恢复该关注点吗？";
                }
                $.messager.confirm('确认', title, function (flag) {
                    if (flag) {
                        var rows = $('#sjydQueryDataTab').datagrid('getSelections');
                        if (rows && rows.length > 0) {
                            var rowIdsArr = [];
                            $.each(rows, function (i, row) {
                                rowIdsArr.push(row['id']);
                            });
                            var ids = rowIdsArr.join(',');
                            //ids="'xxxxxxxxx','xxxxxxxxxxx'" 这样直接传回去ajax报错
                            $.ajax({
                                url: "<%=request.getContextPath()%>/adl/setHistoryDoubt.action",
                                data: {"ids": ids, "isHistory": isHistory},
                                type: "post",
                                dataType: 'json',
                                success: function (data) {
                                    $.messager.alert('提示信息', data.msg, data.type, function () {
                                        if (data.type != 'error') {
                                            querySjyd();
                                        }
                                    });
                                },
                                error: function (data) {
                                    $.messager.show({title: '提示信息', msg: '请求失败！请检查网络是否通畅或者与管理员联系！'});
                                }
                            });
                        } else {
                            $.messager.show({title: '提示信息', msg: '请选择要设置的关注点！'});
                        }
                    }
                });
            }

            // 保存审前关注点
            function adl$save() {
                $.ajax({
                    dataType: 'json',
                    url: "<%=request.getContextPath()%>/adl/saveSjyd.action?editType=" + $('#eidtType').val(),
                    data: $('#lrsjyd_form').serialize(),
                    type: "POST",
                    beforeSend: function () {
                        var ids = ['ydmc', 'ydbm', 'ad_bsjdwMc'];
                        var names = ['关注点名称', '关注点编码', '被审计单位'];
                        var ids2 = ['ydqjQ', 'ydqjZ'];
                        var names2 = ['关注点期间起', '关注点期间止'];
                        if ($('#ydqjQ').datebox('getValue') == '' || $('#ydqjZ').datebox('getValue') == '') {
                            showMessage1("【关注点期间】不能为空");
                            return false;
                        }
                        return !checkIsExistsSameYdbm() && validateBeforeSaveSjyd(ids, names) && validateDate(ids2, names2);
                    },
                    success: function (data) {
                        if (data.type == 'success') {
                            showMessage1(data.msg);
                            querySjyd();
                        }
                    },
                    error: function (data) {
                        $.messager.show({title: '提示信息', msg: '请求失败,请检查网络是否通畅或者与管理员联系！'});
                    }
                });
            }


            // 检查是否有重复关注点编码
            function checkIsExistsSameYdbm() {
                var adId = $('#id').val();
                if (adId) {
                    return false;
                }
                var flag = false;
                $.ajax({
                    dataType: 'json',
                    async: false,
                    url: "<%=request.getContextPath()%>/adl/isExistsSameYdbm.action",
                    data: {ydbm: $('#ydbm').val()},
                    type: "post",
                    success: function (data) {
                        if (data.type == 'error') {
                            flag = true;
                            $('#ydbm').val('');
                            $.messager.show({title: '提示信息', msg: data.msg});
                        }
                    },
                    error: function (data) {
                        $.messager.show({title: '提示信息', msg: '请求失败,请检查网络是否通畅或者与管理员联系！'});
                    }
                });
                return flag;
            }

            $('#ydbm').bind('change', checkIsExistsSameYdbm);

            // 响应菜单栏  处理无问题 按钮
            function dealDoubt() {
                var rows = isSelectedRows('sjydQueryDataTab');
                if (rows && rows.length == 1) {
                    var row = rows[0];
                    var doubt_status = row['doubt_status'];
                    var doubtid = row['id'];
                    if (!doubt_status || doubt_status == '010') {
                        $('#doubt_reason').val("");
                        $('#dealDoubt_id').val(doubtid);
                        openWin('dealDoubtWin');
                    } else {
                        $.messager.show({title: '提示信息', msg: '关注点已是处理状态！'});

                    }
                } else {
                    showMessage1('请选择一条记录进行操作！');
                }
            }

            // 查看关注点处理信息
            function dealDoubtViewInfo(doubtid) {
                if (doubtid) {
                    var flag = false;
                    $.ajax({
                        dataType: 'json',
                        async: false,
                        url: "<%=request.getContextPath()%>/adl/isExistsSameYdbm.action",
                        data: {'doubtid': doubtid},
                        type: "post",
                        success: function (data) {
                            if (data.type == 'error') {

                            }
                        },
                        error: function (data) {
                            $.messager.show({title: '提示信息', msg: '请求失败,请检查网络是否通畅或者与管理员联系！'});
                        }
                    });
                    return flag;
                } else {
                    $.messager.show({title: '提示信息', msg: '无法获得关注点ID，不能查看处理情况！'});
                    return false;
                }
            }

            // 查看疑点使用情况
            function getSjydWorkInfo() {
                var rows = $('#sjydQueryDataTab').datagrid('getSelections');
                if (rows && rows.length == 1) {
                    var row = rows[0];
                    $.ajax({
                        dataType: 'json',
                        url: "<%=request.getContextPath()%>/adl/getSjydWorkInfo.action",
                        data: {'ydbm': row['ydbm']},
                        type: "post",
                        success: function (data) {
                            if (data.type == 'error') {
                                $.messager.show({title: '提示信息', msg: data.msg});
                            } else {
                                // 加载返回的数据，生成table
                                $('#sjydWorkInfoDataTab').datagrid('loadData', data);
                                openWin('sjydWorkInfoData');
                            }
                        },
                        error: function (data) {
                            $.messager.show({title: '提示信息', msg: '请求失败,请检查网络是否通畅或者与管理员联系！'});
                        }
                    });

                } else {
                    showMessage1('请选择一条记录进行操作！');
                }
            }

            var loginname = '${user.floginname}';

            // 删除审前关注点
            function removeSjyd() {
                var rows = $('#sjydQueryDataTab').datagrid('getChecked');
                if (rows && rows.length > 0) {
                    top.$.messager.confirm('提示信息', '确定删除这些关注点吗？', function (isDel) {
                        if (isDel) {
                            var delIdArr = [];
                            var flag = false;
                            $.each(rows, function (i, row) {
                                var ydfxrDm = row['ydfxrDm'];
                                if (loginname && loginname != ydfxrDm) {
                                    showMessage1('当前登陆人员只能删除本人录入的关注点！');
                                    flag = true;
                                    return false;
                                }
                                var doubt_status = row['doubt_status'];
                                if (doubt_status && ('050' == doubt_status || '055' == doubt_status)) {
                                    showMessage1('不能删除已处理的关注点！');
                                    flag = true;
                                    return false;
                                }
                                delIdArr.push(row.id);
                            });

                            if (flag) return;
                            $.ajax({
                                dataType: 'json',
                                url: "<%=request.getContextPath()%>/adl/deleteSjyd.action",
                                data: {ids: delIdArr.join(",")},
                                type: "post",
                                success: function (data) {
                                    showMessage1(data.msg);
                                    var count = data.count;
                                    if (data.type == 'success' && count == rows.length) {
                                        $.each(rows, function (i, row) {
                                            var index = $('#sjydQueryDataTab').datagrid('getRowIndex', row);
                                            $('#sjydQueryDataTab').datagrid('deleteRow', index);
                                        });
                                    }
                                    $('#sjydQueryDataTab').datagrid('reload');
                                },
                                error: function (data) {
                                    showMessage1('请求失败,请检查网络是否通畅或者与管理员联系！');
                                }
                            });
                        }
                    });
                } else {
                    showMessage1('请选择要删除的记录！');
                }
            }

            // 编辑/查看审前关注点
            editSjydRowIndex = function (rowIndex, viewType) {
                if (viewType == null) {
                    $('#eidtType').val('edit');
                }
                var rows = [$('#sjydQueryDataTab').datagrid('getData').rows[rowIndex]];
                editSjyd(viewType, rows);
            };

            // 编辑审前关注点
            function editSjyd(viewType, rows) {
                var title = "";
                var bol = true;
                var fjid = "";
                if (rows == null) {
                    if (viewType == '' || viewType == null) {
                        rows = isSelectedRows('sjydQueryDataTab');
                    } else {
                        rows = $('#sjydQueryDataTab').datagrid('getSelections');
                    }
                }
                if ('undefined' == viewType) {
                    $('#ydqjZ').datebox('setValue', '${ad.ydqjZ}');
                    $('#ydqjQ').datebox('setValue', '${ad.ydqjQ}');
                }
                if (rows && rows.length == 1) {
                    var row = rows[0];
                    var muuid = row.fj;
                    if (viewType == '' || viewType == null) {
                        autoTextareatag();
                        $('#fj').val(row.fj);
                        title = "修改审前关注点信息";
                        fjid = "doubtFile"
                    } else {
                        title = "查看审前关注点信息";
                        bol = false;
                        fjid = "view_doubtFile"
                    }
                    $('#' + fjid).fileUpload('property', 'fileGuid', muuid);
                    $('#' + fjid).fileUpload('reloadFile')
                    /*if(row.ydfxrDm != '
                    ${user.floginname}' && viewType != 'view'){
			showMessage1('只能编辑本人创建的疑点！');
			return;
		}*/
                    $.ajax({
                        url: '<%=request.getContextPath()%>/adl/getSjydInfoById.action?adlView=' + viewType,
                        data: {'id': row.id, 'flag': $('#flag').val()},
                        type: "post",
                        dataType: 'json',
                        //cache:false,
                        success: function (data) {
                            if (data.type === 'success' || data.type == 'info') {
                                var rowData = data.ad;
                                var doubt_status = rowData['doubt_status'];
                                if (!viewType && doubt_status && "010" != doubt_status) {
                                    showMessage1("不能编辑已处理的关注点");
                                    return;
                                }
                                for (var p in rowData) {
                                    if (bol) {
                                        if (p == 'ydnr' || p == 'zcfgMc') {
                                            $('#' + p).val(rowData[p] ? rowData[p] : '');
                                        } else if (p == 'ydqjQ' || p == 'ydqjZ' || p == 'tjrq') {
                                            var value = rowData[p];
                                            $('input[id=' + p + ']').datebox('setValue', value && value.length > 10 ? value.substring(0, 10) : value);
                                        } else if (p == 'bsjdwMc') {
                                            $('#ad_bsjdwMc').val(rowData[p]);
                                        } else if (p == 'bsjdwDm') {
                                            $('#ad_bsjdwDm').val(rowData[p]);
                                        } else {
                                            $('input[id=' + p + ']').val(rowData[p]);
                                            $('label[name=' + p + ']').text(rowData[p]);
                                        }
                                    } else {
                                        $('#view_' + p).html(rowData[p]);
                                        if (p == 'ydqjQ' || p == 'ydqjZ' || p == 'tjrq') {
                                            $('#view_' + p).html(rowData[p] && rowData[p].length > 10 ? rowData[p].substring(0, 10) : rowData[p]);
                                        }
                                        if (p == 'zcfgMc' || p == 'ydnr' || p == 'doubt_reason') {
                                            var text = rowData[p];
                                            if (text != null && text != '') {
                                                text = rowData[p].replaceAll('/n', '<br/>');
                                            }
                                            $('#view_' + p).html(text);
                                        }
                                    }
                                }
                                //查看打开查看窗口，编辑打开编辑窗口
                                if (bol) {
                                    openWin('lrsjyd_div', title);
                                } else {
                                    openWin('viewlrsjyd_div', title);
                                }
                            } else {
                                showMessage1(data.msg);
                            }
                        },
                        error: function (data) {
                            showMessage1('请求失败,请检查网络是否通畅或者与管理员联系！');
                        }
                    });
                } else {
                    showMessage1('请选择一条记录进行操作！');
                }
            }

            // 格式化显示长文本内容，超过maxlen后截取
            function showShortContent(value, rowData, rowIndex) {
                var content = [];
                var maxLen = 20;
                if (value) {
                    var str = value.replace(" ", "").replace("'", "").replace(/"/, "'");
                    content.push("<label title=\"");
                    content.push(str);
                    content.push("\" ");
                    var len = value.length;
                    if (len > maxLen) {
                        content.push(" onclick=\"alert(\"" + str + "\")\" style='cursor:pointer;'>");
                        content.push(value.substr(0, maxLen));
                        content.push("......");
                    } else {
                        content.push(">");
                        content.push(value);
                    }
                    content.push("</label>");
                }
                return content.join("");
            }

            // 判断是否有选中的记录
            function isSelectedRows(id) {

                /* var rows = $('#'+id).datagrid('getSelections');
                if(rows && rows.length > 1){
                    top.$.messager.show({title:'提示信息',msg:'只能选择一条记录操作！'});
                    return false;
                }  */
                var row = $('#' + id).datagrid('getChecked');
                if (row == '') {
                    top.$.messager.show({title: '提示信息', msg: '请选择记录后再进行操作！'});
                    return false;
                }
                return row;
            }

            $('#sjydWorkInfoDataTab').datagrid({
                //url : "<%=request.getContextPath()%>/adl/getSjydWorkInfo.action",
                rownumbers: true,
                pagination: true,
                nowrap: true,
                singleSelect: true,
                striped: true,
                fit: true,
                fitColumns: false,
                height: 330,
                columns: [[
                    {field: 'sysjdwMc', title: '使用审计单位', width: '150', align: 'left'},
                    {field: 'syrMc', title: '使用人', width: '100', align: 'left'},
                    {field: 'syxmMc', title: '使用项目', width: '200', align: 'left'},
                    {field: 'bsjdwMc', title: '被审计单位', width: '100', align: 'left'},
                    {field: 'sffxwt', title: '是否发现问题', width: '100', align: 'left'},
                    {field: 'wtxz', title: '审计发现类型', width: '100', align: 'left'},
                    {field: 'wtms', title: '问题描述', width: '100', align: 'left'},
                    {
                        field: 'sjje', title: '涉及金额(万元)', width: '100', align: 'left',
                        formatter: function (value, rowData, rowIndex) {
                            return splitMoney(value);
                        }
                    }
                ]]
            });


            function selectAuditObject() {

                var auditDeptId = document.getElementById("bsjdwDm").value;//计划单位
                showPopWin('${contextPath}/pages/system/search/searchdatamuti.jsp?url=${contextPath}/mng/audobj/object/auditedDeptList.action&paraname=ad.bsjdwMc&paraid=ad.bsjdwDm&showRootNode=_show&funname=resetJjzrr()&where=' + auditDeptId, 600, 450, '被审计单位');

            }


            //问题类别树
            $('#wtlbTrigger').bind('click', function () {
                var treeTarget = $('#wtlbTrigger')[0];
                var wtlbtree = showSysTree(treeTarget, {
                    title: '请选择问题点',
                    onlyLeafClick: true,
                    param: {
                        'rootId': '1',
                        'beanName': 'LedgerTemplateNewTree',
                        'treeId': 'id',
                        'treeText': 'name',
                        'treeParentId': 'fid',
                        'treeOrder': 'orderNO',
                        'treeAtrributes': 'isSort,bewrite'
                    },
                    onAfterSure: function () {
                        var jqTree = wtlbtree.win.param.jqtree;
                        var node = $(jqTree).tree('getSelected');
                        //alert(node.attributes)
                        if (node.attributes) {
                            var attrs = node.attributes.replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\t/g, '\\t');
                            var json = eval('(' + attrs + ')');
                            if (typeof json.bewrite != 'undefined') {
                                $('#zcfgMc').val($('#zcfgMc').val() + json.bewrite);
                            }
                        }
                    }
                })
            });

        });


        //查看底稿
        function viewDg(formId) {
            /* var w = $(document).width();
            var h = $(document).height();
            var left = w/2 - 300;
            var top  = h/2 - 200;
            window.open("
            ${contextPath}/operate/manu/viewAll.action?crudId="+formId,"","left="+left+"px, top="+top+"px, height=600px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no"); */
            var myurl = "${contextPath}/operate/manu/viewAll.action?crudId=" + formId;
            $("#viewDgFrame").attr("src", myurl);
            openWin('viewDgDiv');
        }

        //查看项目信息
        function viewProject(projectId) {
            /* var w = $(document).width();
            var h = $(document).height();
            var left = w/2 - 300;
            var top  = h/2 - 100;
              window.open("
            ${contextPath}/adl/getProjectInfo.action?projectId="+projectId,"","left="+left+"px, top="+top+"px, height=400px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no"); */
            var myurl = "${contextPath}/adl/getProjectInfo.action?projectId=" + projectId;
            $("#viewProjectFrame").attr("src", myurl);
            openWin('viewProjectDiv');
        }


        // 保存审前关注点前校验
        function validateBeforeSaveSjyd(ids, names) {
            for (var i = 0; i < ids.length; i++) {
                var obj = document.getElementById(ids[i]);
                if (!obj.value) {
                    //	$.messager.alert('提示信息','【'+names[i]+'】不能为空', 'error', function(){ obj.focus(); });
                    $.messager.show({title: '提示信息', msg: '【' + names[i] + '】不能为空'});
                    return false;
                }
            }
            return true;
        }

        // 判断日期 d2>d1 true or false
        function isD2MoreThanD1(d1, d2) {
            var v1 = d1.datebox('getValue');
            var v2 = d2.datebox('getValue');
            v1 = v1.replace(' ', '');
            v2 = v2.replace(' ', '');
            return v2 > v1 ? true : false;
        }

        function validateDate(ids, names) {
            var d1 = $("#" + ids[0]);
            var d2 = $("#" + ids[1]);
            if (d1 && d2 && !isD2MoreThanD1(d1, d2)) {
                //$.messager.alert('提示信息','【'+names[1]+'】应该大于【'+names[0]+'】', 'error', function(){ d2.focus(); });
                $.messager.show({title: '提示信息', msg: '【' + names[1] + '】应该大于【' + names[0] + '】'});
                return false;
            }
            return true;
        }


        // 把url转换json
        function url2json(formId) {
            var json = {};
            if (formId) {
                formId = formId.trim();
                var url = $('#' + formId).serialize();
                if (url) {
                    var arr1 = url.split("&");
                    $.each(arr1, function (i, s1) {
                        var arr2 = s1.split("=");
                        json[arr2[0]] = arr2[arr2.length - 1];
                    });
                }
            }
            return json;
        }

        //json 转化成 string 递归对象的各个属性，形成string串
        function object2string(o) {
            try {
                var r = [];
                // 如果为字符串string，则返回
                if (typeof o == "string" || o == null) {
                    var tmpArr = new Array();
                    tmpArr.push("'");
                    tmpArr.push(o);
                    tmpArr.push("'");
                    return tmpArr.join("");
                } else if (typeof o == "number" || typeof o == "boolean" || typeof o == "function" || o == null) {
                    var tmpArr = new Array();
                    tmpArr.push(o);
                    return tmpArr.join("");
                }
                //如果对object对象，则遍历object的元素
                if (o) {
                    var objType = jQuery.type(o);
                    if (objType === "object") {
                        r[0] = "{"
                        for (var i in o) {
                            r[r.length] = i;
                            r[r.length] = ":";
                            r[r.length] = object2string(o[i]);
                            r[r.length] = ",";
                        }
                        r[r.length - 1] = "}";
                    } else if (objType === "array") {
                        r[0] = "["
                        for (var i = 0; i < o.length; i++) {
                            r[r.length] = object2string(o[i]);
                            r[r.length] = ",";
                        }
                        r[r.length - 1] = "]";
                    }
                    return r.join("");
                }
                return o.toString();
            } catch (e) {
            }
        }

        function splitMoney(str) {
            try {
                if (str) {
                    var a1 = str.toString().split('.');
                    var s = a1[0];
                    var end = a1.length == 2 ? '.' + a1[1] : '.00';
                    var len = s.length;
                    var count = Math.floor(len / 3);
                    var mod = len % 3;
                    var f = [];
                    mod > 0 ? f.push(s.substr(0, mod)) : null;
                    for (var i = 0; i < count; i++) {
                        f.push(s.substr(i * 3 + mod, 3));
                    }
                    return f.join(',') + end;
                }
                return '0.00';
            } catch (e) {
                $.messager.show({title: '提示信息', msg: e.message});
            }
        }

        function queryF() {
            querySjyd();
            $('#query_div').window('close');
        }

        /*  function restal(){
            //resetForm('sjyd_query_form');
            document.getElementById("sjyd_query_form").reset();
            $("[name=queryAd.isHistory]:checkbox").attr("checked", false);
            queryF();
        }  */

        function autoTextareatag() {
            var objarr = [$('#zcfgMc')[0], $('#ydnr')[0]];
            $.each(objarr, function (i, arr) {
                autoTextarea(arr);
            });
        }

        //查询审前关注点
        function querySjyd() {
            var node = $('#resetSjyd').tree('getSelected');
            //查询时不应该获取左边选择的树节点为查询条件
            if (node != null && node != undefined) {
                //gParam =  'queryAd.bsjdwDm='+node.id+'&queryAd.bsjdwMc='+node.text;
                //$('#queryAd_bsjdwDm').val(node.id);
                //$('#queryAd_bsjdwMc').val(node.text);
            }
            var param = form2Json('sjyd_query_form');
            $('#sjydQueryDataTab').datagrid('reload', param);

            //一下代码会出现问题，如果用下面代码，easyUI的pageSize参数将不会传递回去，
            //那么rows参数为空，会默认pageSize为10，所以每次点击数的节点时，分页条数都为10 by wudi
            /*var form = $('#sjyd_query_form').serialize();
            $.ajax({
                dataType:'json',
                url : '
            <%=request.getContextPath()%>/adl/querySjyd.action',
		data: form,
		type: 'POST',
		beforeSend: function(){},
		success: function(data){
			if(data.type == 'success'){
				// 加载返回的数据，生成table
				if(data.total == 0){
					var item = $('#sjydQueryDataTab').datagrid('getRows');
					if (item) {
						for (var i = item.length - 1; i >= 0; i--) {
							var index = $('#sjydQueryDataTab').datagrid('getRowIndex', item[i]);
							$('#sjydQueryDataTab').datagrid('deleteRow', index);
						}
					}
				}else{
					$('#sjydQueryDataTab').datagrid('loadData',data);
				}
			}else{
				$.messager.show({title:'提示信息',msg:data.msg});
			}
		},
		error:function(data){
			$.messager.show({title:'提示信息',msg:'请求失败,请检查网络是否通畅或者与管理员联系！'});
		}
	});*/
        }


    </script>

</head>
<body id='sjydBody'>
<div id="container" border="0" class='easyui-layout' fit='true'>
    <input type='hidden' id='flag' value='${flag}'/>
    <div region="west" border="0" split="true" style="overflow:auto;width:300px;">
        <div id="orgTree"></div>
        <%--<div id='zcfgTreeSelect'></div>--%>
    </div>
    <div region="center" border="0" style="overflow:hidden;">
        <table id="sjydQueryDataTab"></table>
    </div>
</div>

<!-- 关注点使用情况 -->
<div title='审前关注点使用情况' id='sjydWorkInfoData' style='dispaly:none;'>
    <table id="sjydWorkInfoDataTab"></table>
</div>

<div id="viewlrsjyd_div" title="查看审前关注点信息" style='display:none'>
    <form id='lrsjyd_form' name='sjsx_form' method="POST">
        <table class="ListTable" align="center">
            <tr>
                <td class="EditHead">关注点名称</td>
                <td class="editTd" id='view_ydmc'></td>
                <td class="EditHead">关注点编码</td>
                <td class="editTd" id='view_ydbm'></td>
            </tr>
            <tr>
                <td class="EditHead">关注点期间</td>
                <td class="editTd" colspan=3 style='width:750px;'>
                    <div id='view_ydqjQ' style="float: left"></div>
                    <span style="float: left">至</span>
                    <div id='view_ydqjZ' style="float: left"></div>
                </td>
            </tr>
            <tr>
                <td class="EditHead" nowrap>被审计单位</td>
                <td class="editTd" id='view_bsjdwMc'></td>
                <td class="EditHead" nowrap>问题点</td>
                <td class="editTd" id='view_wtlbMc'></td>
            </tr>
            <tr>
                <td class="EditHead">关注点发现人</td>
                <td class="editTd" id='view_ydfxrMc'></td>
                <td class="EditHead">提交日期</td>
                <td class="editTd" id='view_tjrq'></td>
            </tr>
            <tr>
                <td class="EditHead" nowrap>政策法规依据</td>
                <td class="editTd" id='view_zcfgMc' colspan="3"></td>
            </tr>
            <tr style='height:70px;'>
                <td class="EditHead">关注点内容</td>
                <td class="editTd" colspan=3 id='view_ydnr'></td>
            </tr>
            <tr style='height:70px;'>
                <td class="EditHead">无问题原因</td>
                <td class="editTd" colspan=3 id='view_doubt_reason'></td>
            </tr>
            <tr height='85px;'>
                <td class="EditHead" nowrap>
                    <div style='paddding:10px;text-align:center;'>
                        附件上传
                    </div>
                </td>
                <td class="editTd" colspan='3'>
                    <div id="view_doubtFile" class="easyui-fileUpload"
                         data-options="fileGuid:'',
								               isAdd:false,
								               isEdit:false,
								               isDel:false,
								               isView:true,
								               isDownload:true,
								               isdebug:false,
								               zIndex:9800"></div>
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 新增审前关注点 -->
<s:if test="${flag != 1}">
    <!-- 政策法规树 -->
    <jsp:include flush="true" page="/pages/adl/zcfgTree.jsp"/>
    <div id="lrsjyd_div" title="审前关注点信息" style='display:none'>
        <form id='lrsjyd_form' name='sjsx_form' method="POST">
            <table class="ListTable">
                <tr>
                    <td class="EditHead" width="15%"><font style='color:red'>*</font>&nbsp;关注点名称</td>
                    <td class="editTd">
                        <!--<input type='text'   id='ydmc' name='ad.ydmc' style='width:180px;' class="noborder">-->
                        <s:textfield id="ydmc" name='ad.ydmc' cssStyle='width:180px;' cssClass="noborder" maxLength="50"></s:textfield>
                        <input type='hidden' id='id' name='ad.id' value="">
                        <input type='hidden' id='isassign' name='ad.isassign'>
                        <input type='hidden' id='doubt_status' name='ad.doubt_status'>
                        <input type='hidden' id='doubt_statusName' name='ad.doubt_statusName'>
                        <input type='hidden' id='doubt_manu_code' name='ad.doubt_manu_code'>
                        <input type='hidden' id='manu_id' name='ad.manu_id'>
                        <input type='hidden' id='doubt_project_code' name='ad.doubt_project_code'>
                        <input type='hidden' id='project_id' name='ad.project_id'>
                        <input type='hidden' id='isHistory' name='ad.isHistory'>
                        <input type='hidden' id='historyDoubtShowName' name='ad.historyDoubtShowName'>
                            <%--<input type='hidden' id='bsjdwDm'   name='ad.bsjdwDm'>--%>
                            <%--ad.bsjdwDm已经在选择被审计单位那关联了--%>
                        <input type='hidden' id='bsjdwDm'>
                    </td>
                    <td class="EditHead">关注点编码</td>
                    <td class="editTd">
                        <input type='text' id='ydbm' name='ad.ydbm' style='border:0px;width:180px;' readOnly='readOnly'>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead"><font style='color:red'>*</font>&nbsp;关注点期间</td>
                    <td class="editTd" colspan=3>
                        <input type='text' id='ydqjQ' name='ad.ydqjQ' class="easyui-datebox" editable="false" style="width: 110px;">&nbsp;-&nbsp;
                        <input type='text' id='ydqjZ' name='ad.ydqjZ' class="easyui-datebox" editable="false" style="width: 110px;">
                    </td>
                </tr>
                <tr>

                    <td class="EditHead" nowrap="nowrap"><font style='color:red'>*</font>&nbsp;被审计单位</td>
                    <td class="editTd">
                        <s:buttonText2 id="ad_bsjdwMc" hiddenId="ad_bsjdwDm"
                                       name="ad.bsjdwMc" cssStyle="width:150px" cssClass="noborder"
                                       hiddenName="ad.bsjdwDm"
                                       doubleOnclick="showSysTree(this,{
                                url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								noMsg:true,
								title:'请选择被审计单位',
								checkbox:false,
								param:{'departmentId':'${magOrganization.fid}'},
								onTreeClick:function(node, treeDom){
									if(node.attributes){
										var attrJson = $.parseJSON(node.attributes);
										$.messager.show({title:'提示信息',msg:attrJson.currentCode});
										$('#bsjdwDm').val(attrJson.currentCode);
									}
								}
							})"
                                       doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
                                       doubleCssStyle="cursor:hand;border:0"
                                       readonly="true"
                                       display="${varMap['audit_objectRead']}"
                                       doubleDisabled="!(varMap['audit_objectWrite']==null?true:varMap['audit_objectWrite'])" title="被审单位" maxlength="1500"/>
                    </td>

                    <td class="EditHead" nowrap>问题点</td>
                    <td class="editTd">
                        <input type='text' class="noborder" id='wtlbMc' name='ad.wtlbMc' style="width:180px;" readonly="true"/>
                        <input type='hidden' id='wtlbDm' name='ad.wtlbDm'/><img style="cursor:hand;border:0"
                                                                                src="/ais/resources/images/s_search.gif" id="wtlbTrigger"></img>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">关注点发现人</td>
                    <td class="editTd">
                        <input type='text' id='ydfxrMc' name='ad.ydfxrMc' style='border:0px;' readOnly value='${user.fname }'/>
                        <input type='hidden' id='ydfxrDm' name='ad.ydfxrDm' value='${user.floginname }'/>
                    </td>
                    <td class="EditHead">提交日期</td>
                    <td class="editTd">
                        <input type='text' id='tjrq' name='ad.tjrq' class="easyui-datebox" value='${curDate }' editable="false" style="width: 110px;" style="width: 110px;"/>
                    </td>
                </tr>
                <tr style='height:70px;'>
                    <td class="EditHead" nowrap>
                        政策法规依据
                        <br/>
                        <a id="lr_openZcfgTree" mc='zcfgMc' dm='zcfgDm' href="javascript:void(0);" class="easyui-linkbutton"
                           data-options="iconCls:'icon-search'">引用法规制度</a>
                        <br/>
                        <div style="text-align:right"><font color=DarkGray>(请限1500字)</font></div>
                    </td>
                    <td class="editTd" colspan=3>
                        <s:textarea id='zcfgMc' cssClass="noborder" name='ad.zcfgMc' cssStyle='width:100%;height:70px'
                                    onblur="doWhithOne(this)" title="政策法规依据"/>
                        <input type='hidden' id='zcfgDm' name='ad.zcfgDm'/>
                    </td>
                </tr>
                <tr style='height:70px;'>
                    <td class="EditHead">关注点内容<br><font color="#a9a9a9">(限1000字以内)</font></td>
                    <td class="editTd" colspan=3>
                        <s:textarea id='ydnr' name='ad.ydnr' cssStyle='width:100%;height:70px' title="关注点内容"
                                    onblur="doWhithOne(this)" cssClass="noborder"></s:textarea>
                        <input type="hidden" id="ad.ydnr.maxlength" value="1000"/>
                    </td>
                </tr>
                <tr height='85px;'>
                    <td class="EditHead" nowrap>
                        <div style='paddding:10px;text-align:center;'>
                            附件上传
                            <input type='hidden' id="fj" name="ad.fj" value='${ad.fj}'/>
                        </div>
                    </td>
                    <td class="editTd" colspan='3'>
                        <div id="doubtFile" class="easyui-fileUpload"
                             data-options="fileGuid:'${ad.fj }',
								               isAdd:true,
								               isEdit:true,
								               isDel:true,
								               isView:true,
								               isDownload:true,
								               isdebug:false,
								               zIndex:9800"></div>
                    </td>
                </tr>
            </table>
        </form>
        <input id="eidtType" type="hidden" value=""/>
    </div>
</s:if>
<%--查询按钮对应模块--%>
<div id="query_div" class="searchWindow">
    <div class="search_head">
        <form id="sjyd_query_form" name="sjyd_query_form" method="post">
            <input type='hidden' id="audobjCurrentCode" name="queryAd.audobjCurrentCode"/>
            <table border=0 align="center" class="ListTable">
                <tr>
                    <td class="EditHead" nowrap>关注点编码</td>
                    <td class="editTd">
                        <input type='text' id='queryAd.ydbm' name='queryAd.ydbm' maxlength="50" class="noborder">
                    </td>
                    <td class="EditHead" nowrap>关注点名称</td>
                    <td class="editTd">
                        <input type='text' id='queryAd.ydmc' name='queryAd.ydmc' maxlength="50" class="noborder">
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" nowrap="nowrap">被审计单位</td>
                    <td class="editTd">
                        <s:buttonText2 id="queryAd_bsjdwMc" hiddenId="queryAd_bsjdwDm"
                                       name="queryAd.bsjdwMc" cssStyle="width:150px" cssClass="noborder"
                                       hiddenName="queryAd.bsjdwDm"
                                       doubleOnclick="showSysTree(this,{
                                url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
								noMsg:true,
								title:'请选择被审计单位',
								checkbox:false,
								param:{'departmentId':'${magOrganization.fid}'},
								onTreeClick:function(node, treeDom){
									if(node.attributes){
										var attrJson = $.parseJSON(node.attributes);
										$('#audobjCurrentCode').val(attrJson.currentCode);
									}
								}
							})"
                                       doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
                                       doubleCssStyle="cursor:hand;border:0"
                                       readonly="true"
                                       display="${varMap['audit_objectRead']}"
                                       doubleDisabled="!(varMap['audit_objectWrite']==null?true:varMap['audit_objectWrite'])" title="被审单位" maxlength="1500"/>
                    </td>
                    <td class="EditHead">关注点发现人</td>
                    <td class="editTd">
                        <input type='text' id='queryAd.ydfxrMc' name='queryAd.ydfxrMc' hiddenId="queryAd.ydfxrDm" hiddenName="queryAd.ydfxrDm" maxlength="50" class="noborder"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">提交日期</td>
                    <td class="editTd">
                        <input type='text' id='queryAd.tjrq' name='queryAd.tjrq' editable="false" class="easyui-datebox"/>
                    </td>
                    <td class="EditHead">历史关注点</td>
                    <td class="editTd">
                        <input type='checkbox' id='queryAd.isHistory' name='queryAd.isHistory' value='1'/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" nowrap>关注点期间</td>
                    <td class="editTd" colSpan='3'>
                        <input type='text' id='queryAd.ydqjQ' name='queryAd.ydqjQ' class="easyui-datebox" editable="false" style="width:110px;"/>&nbsp;-&nbsp;
                        <input type='text' id='queryAd.ydqjZ' name='queryAd.ydqjZ' class="easyui-datebox" editable="false" style="width:110px;"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div style='text-align:right;padding:0px 10px 0px 0px;'>
        <div class="search_btn">
            <a id='querySjyd' class="easyui-linkbutton" iconCls="icon-search" onclick="queryF()">查询</a>
            <a id='resetSjyd' class="easyui-linkbutton" iconCls="icon-reload">重置</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#query_div').window('close')">取消</a>
        </div>
    </div>
</div>

<div id="viewDgDiv" title="查看底稿" style='overflow:hidden;padding:0px;'>
    <iframe id="viewDgFrame" name="viewDgFrame" title="查看底稿" src="" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>
</div>
<div id="viewProjectDiv" title="查看项目信息" style='overflow:hidden;padding:0px;'>
    <iframe id="viewProjectFrame" name="viewProjectFrame" title="查看项目信息" src="" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
</div>
<!-- 关注点处理为无问题window -->
<div title='关注点处理为无问题' id='dealDoubtWin' style="overflow: hidden;">
    <div style="overflow-y: auto;overflow-x: hidden;height: 99%;">
        <div style='border-bottom:1px solid #99bbe8;'>
            <div style='padding:5px;'>无问题原因<font color="#a9a9a9">(限300个字符)</font></div>
        </div>
        <div style='border-bottom:1px solid #99bbe8;'>
            <div style='padding:5px;'>
                <input type='hidden' name='dealDoubt_id' id='dealDoubt_id'/>
                <textarea name='deal_doubt_reason' class="noborder autoSize" id='dealDoubtReason' maxlength="300"
                          title="无问题原因" style="width:100%;height:100px;"></textarea>
                <input type='hidden' id="deal_reason_guid" name="ad.reason_guid" value='${ad.reason_guid}'/>
                <input type="hidden" id="deal_doubt_reason.maxlength" value="300">
            </div>
        </div>
        <div id="deal_fileList" align="center">
            <div id="doubtReasionFile" class="easyui-fileUpload"
                 data-options="fileGuid:-1,
					               isAdd:true,
					               isEdit:true,
					               isDel:true,
					               isView:true,
					               isDownload:true,
					               isdebug:false,
					               spaceSumibtFiles:false,
					               zIndex:9800"></div>
        </div>
        <div id='dealDoubtBtnBar' style='padding:5px; text-align:center;'>
            <button id='dealDoubtBtn' class="easyui-linkbutton" iconCls="icon-ok">处理</button>&nbsp;&nbsp;
            <button id='closeDoubtBtn' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button>
        </div>
    </div>
</div>

</body>
</html>
