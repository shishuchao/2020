<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<title>教育经历</title>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
</head>

<body>
<div id="container" class='easyui-layout' fit='true'>
    <div region="center">
        <table id='sDTable'></table>
    </div>
</div>
<div id='queryCond1'>
    <input type='text' name='query_like_orgName' class="noborder"/>
    <input type='hidden' readonly/>
    <a class="easyui-linkbutton editElement " iconCls="icon-search" style='border-width:0px;'
       onclick="showSysTree(this,{
		title:'所属单位选择',
		param:{
		'rootParentId':'0',
		'beanName':'UOrganizationTree',
		'treeId' :'fid',
		'treeText':'fname',
		'treeParentId':'fpid',
		'treeOrder':'fcode'
		}
	})"></a>
</div>
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp"/>
<script type="text/javascript">
    var rowIndexdd;
    var editFlag = undefined;

    $.extend($.fn.datagrid.defaults.editors, {
        qtree: {
            init: function (container, options) {
                var wrap = $('<div></div>').appendTo(container);
                var input = $('<input type="text" style="width:80%" readonly>').appendTo(wrap[0]).bind('click', function () {
                    trigger.trigger('click');
                });
                input.validatebox(options);

                $('<input type="hidden" readonly>').appendTo(wrap[0]);
                var trigger = $("<label></label>")
                    .appendTo(wrap[0]).bind('click', function () {
                        aud$editorQtree(this);
                    });
                return input;
            },
            getValue: function (target) {
                return $(target).val();
            },
            setValue: function (target, value) {
                $(target).val(value);
            },
            resize: function (target, width) {
                var input = $(target);
                if ($.boxModel == true) {
                    input.width(width - (input.outerWidth() - input.width()));
                } else {
                    input.width(width);
                }
            }
        },
        textarea: {
            init: function (container, options) {
                var input = $('<textarea class="easyui-validatebox" style="display:block;word-break: break-all;word-wrap: break-word;" rows=' + options.rows + '></textarea>').appendTo(container);
                return input.validatebox(options);
            },
            getValue: function (target) {
                return $(target).val();
            },
            setValue: function (target, value) {
                $(target).val(value);
            },
            resize: function (target, width) {
                var input = $(target);
                if ($.boxModel == true) {
                    input.width(width - (input.outerWidth() - input.width()));
                } else {
                    input.width(width);
                }
            }
        },
        text: {
            init: function (container, options) {
                var input = $('<input type="text" class="datagrid-editable-input" style="width: 230px; height: 20px;">').appendTo(container);
                return input.validatebox(options);
            },
            getValue: function (target) {
                return $(target).val();
            },
            setValue: function (target, value) {
                $(target).val(value);
            },
            resize: function (target, width) {
                var input = $(target);
                if ($.boxModel == true) {
                    input.width(width - (input.outerWidth() - input.width()));
                } else {
                    input.width(width);
                }
            }
        }
    });

    function aud$editorQtree(target) {
        var rowIndex = rowIndexdd;
        /*showSysTree(target,
                { title:'请选所属单位',
                     param:{
                        'serverCache':false,
                     'rootId':'1',
                    'beanName':'UOrganization',
                    //'whereHql':'ftype=\'C\'',
                    'treeId'  :'fid',
                    'treeText':'fname',
                    'treeParentId':'fpid',
                    'treeOrder':'fcode',
                     },
                      onAfterSure:function(fid) {
                          resetJjzrr(fid);
                      }
        });*/
        showSysTree(this,
            {
                url: '${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                param: {},
                cache: false,
                //checkbox:true,
                onAfterSure: function (fid) {
                    resetJjzrr(fid);
                }
            });
    }

    function resetJjzrr(fid) {
        var aa = fid[0];
        //重新设置被审计单位名称，取出上级单位
        $.ajax({
            type: "POST",
            url: "${contextPath}/plan/detail/concatAuditingObjectName.action",
            data: {"aoId": aa},
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data.type == 'info') {
                    callback(aa, data.msg);
                } else {
                    showMessage1(data.msg);
                }
            }
        });
    }

    function callback(id, name) {
        debugger;
        $("#sDTable").datagrid('endEdit', rowIndexdd);
        var row = $('#sDTable').datagrid('getRows')[rowIndexdd];
        $('#sDTable').datagrid('updateRow', {
            index: rowIndexdd,
            row: {
                id: row.id,
                employeeInfo_id: row.employeeInfo_id,
                begin_worktime: row.begin_worktime,
                end_worktime: row.end_worktime,
                company: name,
                companyCode: id,
                dept: '',
                deptCode: '',
                post: row.post,
                duty: row.duty,
                remarks: row.remarks,
                isSubmit: '0'
            }
        });
        $("#sDTable").datagrid('beginEdit', rowIndexdd);
        editFlag = rowIndexdd;
    }

    $(function () {
        var employeeInfo_id = '${employeeInfo_id}';

        frloadOpen();

        var initRemoveFun = QUtil.removeDatagridRows;
        QUtil.removeDatagridRows = function (paramJson, noMsg) {
            var gridObj = $(paramJson.gridObject);
            var rows = gridObj.datagrid('getChecked');
            var pkName = paramJson.pkName ? paramJson.pkName : 'id';
            var delIdArr = new Array();
            var transientRows = new Array();
            if (paramJson.removeFilter) {
                delIdArr = paramJson.removeFilter(rows);
            } else {
                $.each(rows, function (i, row) {
                    if (!row[pkName]) {
                        transientRows.push(row);
                    } else {
                        delIdArr.push(row[pkName]);
                    }
                });
            }
            if (transientRows.length > 0) {
                QUtil.removeViewRows(transientRows, paramJson.gridObject);
            }
            if ((delIdArr.length <= 0 && transientRows.length <= 0) || delIdArr.length > 0) {
                initRemoveFun(paramJson, noMsg);
            }
            $.ajax({url: '${contextPath}/mng/employee/writeBackEmployee.action?id=${employeeInfo_id}', async: false});
        };

        var bodyW = $('body').width();
        var g1 = new createQDatagrid({
            // 表格dom对象，必填
            gridObject: $('#sDTable')[0],
            // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
            boName: 'AfterJob',
            // 对象主键,删除数据时使用-默认为“id”；必填
            pkName: 'id',
            <s:if test="${isSubmit == '1'}">
            whereSql: ' employeeInfo_id=\'' + employeeInfo_id + '\' and isSubmit=\'1\' ',
            </s:if>
            <s:else>
            whereSql: ' employeeInfo_id=\'' + employeeInfo_id + '\'  ',
            </s:else>
            order: 'asc',
            sort: 'begin_worktime',
            winWidth: 800,
            winHeight: 250,
            gridJson: {
                checkOnSelect: false,
                selectOnCheck: false,
                singleSelect: false,
                rownumbers: false,
                <s:if test="${isView != '1'}">
                toolbar: [
                    <s:if test="${isSubmit != '1'}">
                    {
                        text: '新增',
                        iconCls: 'icon-add',
                        handler: function () {
                            if (!$('#sDTable').datagrid('validateRow', editFlag)) {
                                showMessage1("必填项不能为空");
                                return;
                            }
                            $("#sDTable").datagrid('endEdit', editFlag);

                            var length = $("#sDTable").datagrid('getRows').length;
                            $("#sDTable").datagrid('insertRow', {//在指定行添加数据，appendRow是在最后一行添加数据
                                index: length,
                                row: {
                                    id: '',
                                    employeeInfo_id: employeeInfo_id,
                                    begin_worktime: '',
                                    end_worktime: '',
                                    company: '',
                                    companyCode: '',
                                    dept: '',
                                    deptCode: '',
                                    post: '',
                                    duty: '',
                                    remarks: '',
                                    isSubmit: '0'
                                }
                            });

                            $("#sDTable").datagrid('clearSelections');
                            $("#sDTable").datagrid('beginEdit', length);
                            $("#sDTable").datagrid('selectRow', length);
                            editFlag = length;
                            rowIndexdd = length;
                        }
                    }
                    </s:if>
                    <s:else>
                    {
                        text: '新增',
                        iconCls: 'icon-add',
                        handler: function () {
                            if (!$('#sDTable').datagrid('validateRow', editFlag)) {
                                showMessage1("必填项不能为空");
                                return;
                            }
                            $("#sDTable").datagrid('endEdit', editFlag);

                            var length = $("#sDTable").datagrid('getRows').length;
                            $("#sDTable").datagrid('insertRow', {//在指定行添加数据，appendRow是在最后一行添加数据
                                index: length,
                                row: {
                                    id: '',
                                    employeeInfo_id: employeeInfo_id,
                                    begin_worktime: '',
                                    end_worktime: '',
                                    company: '',
                                    companyCode: '',
                                    dept: '',
                                    deptCode: '',
                                    post: '',
                                    duty: '',
                                    remarks: '',
                                    isSubmit: '1'
                                }
                            });

                            $("#sDTable").datagrid('clearSelections');
                            $("#sDTable").datagrid('beginEdit', length);
                            $("#sDTable").datagrid('selectRow', length);
                            editFlag = length;
                            rowIndexdd = length;
                        }
                    }
                    </s:else>
                    , '-', {
                        text: '保存',
                        iconCls: 'icon-save',
                        handler: function () {
                            if (!$('#sDTable').datagrid('validateRow', editFlag)) {
                                showMessage1("必填项不能为空");
                                return;
                            }
                            $("#sDTable").datagrid('endEdit', editFlag);

                            if (!checkTemplateStatus()) {
                                return;
                            }

                            //使用JSON序列化datarow对象，发送到后台。
                            var rows = $("#sDTable").datagrid('getChanges');
                            var rowstr = JSON.stringify(rows);
                            $.ajax({
                                url: '${contextPath}/mng/employee/personnel/saveAfterJob.action',
                                async: false,
                                type: 'POST',
                                data: {'rowstr': rowstr},
                                success: function (data) {
                                    if (data == '1') {
                                        showMessage1('保存成功！');
                                        g1.refresh();
                                    }
                                }
                            });
                        }
                    }
                ],
                </s:if>
                onLoadSuccess: function(){
                    $('#sDTable').datagrid('doCellTip', {
                        position: 'bottom',
                        maxWidth: '200px',
                        tipStyler: {
                            'backgroundColor': '#EFF5FF',
                            borderColor: '#95B8E7',
                            boxShadow: '1px 1px 3px #292929'
                        }
                    });
                    frloadClose();
                },
                columns: [[
                    {field: 'id', title: '选择', checkbox: true, align: 'center', show: 'false'},
                    {
                        field: 'begin_worktime', title: '开始时间', width: 120, align: 'center', halign: 'center', sortable: true,
                        editor: {
                            type: 'datebox',
                            options: {
                                editable: false,
                                /*required : true*/
                            }
                        }
                    },
                    {
                        field: 'end_worktime', title: '结束时间', width: 120, align: 'center', halign: 'center', sortable: true,
                        editor: {
                            type: 'datebox',
                            options: {
                                editable: false,
                                /*required : true*/
                            }
                        }
                    },
                    {
                        field: 'company', title: '所属单位(应选择至末级机构)', width: bodyW * 0.30 + 'px', align: 'left', halign: 'center', sortable: true, type: 'custom', id: 'company',
                        editor: {//设置其为可编辑
                            type: 'qtree',
                        }
                    },
                    {
                        field: 'dept', title: '末级机构（非必填）', width: bodyW * 0.2 + 'px', align: 'left', halign: 'center', sortable: true,
                        editor: {//设置其为可编辑
                            type: 'text'
                        }
                    },
                    {
                        field: 'post', title: '岗位职务', width: bodyW * 0.15 + 'px', align: 'center', halign: 'center', sortable: true,
                        editor: {//设置其为可编辑
                            type: 'text'
                        }
                    },
                    {
                        field: 'duty', title: '工作职责', width: bodyW * 0.25 + 'px', align: 'left', halign: 'center', sortable: true, type: 'custom', target: $('#queryCond2')[0],
                        editor: {//设置其为可编辑
                            type: 'text'
                        }
                    }
                    /*{field:'remarks',title:'备注', width:bodyW*0.15 + 'px',align:'left', halign:'center', sortable:true, show:'true',
                        editor: {//设置其为可编辑
                         type: 'text'
                     }
                    },*/
                ]],
                onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
                    editFlag = undefined;//重置
                },
                onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
                    <s:if test="${isView != 'y'}">
                    if (editFlag != undefined) {
                        $("#sDTable").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
                    }
                    if (editFlag == undefined) {
                        $("#sDTable").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
                        editFlag = rowIndex;
                    }
                    rowIndexdd = rowIndex;
                    </s:if>
                }
            }
        }).batchSetBtn([
            {'index': 1, 'display': ${isView != 1}},
            {'index': 2, 'display': ${isView != 1}},
            {'index': 3, 'display': ${isView != 1}}, //导出到excel
            {'index': 4, 'display': false}, //查询
            {'index': 5, 'display': false},
            {'index': 6, 'display': false},
            {'index': 7, 'display': false},
            {'index': 8, 'display': false}  //刷新
        ]);
    });
    function checkTemplateStatus() {
        var rows = $('#sDTable').datagrid("getRows");

        if (rows && rows.length) {
            var rlen = rows.length;
            for (var i = 0; i < rlen; i++) {
                var row = rows[i];

                if (!row.begin_worktime || row.begin_worktime.replace(/\s+/g, "").length == 0) {
                    editFlag = i;
                    $('#sDTable').datagrid('selectRow', editFlag).datagrid('beginEdit', editFlag);
                    showMessage1("第"+(i+1)+"行[开始时间]不能为空");
                    return false;
                }
                if (!row.end_worktime || row.end_worktime.replace(/\s+/g, "").length == 0) {
                    editFlag = i;
                    $('#sDTable').datagrid('selectRow', editFlag).datagrid('beginEdit', editFlag);
                    showMessage1("第"+(i+1)+"行[结束时间]不能为空");
                    return false;
                }
            }
        }

        return true;
    }
</script>
</body>
</html>
