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
<div id='queryCond0'>
    <select id="query_educationCode" name="query_educationCode"></select>
</div>
<div id='queryCond1'>
    <select id="query_degreeCode" name="query_degreeCode"></select>
</div>
<div id='queryCond2'>
    <select id="query_majorCode" name="query_majorCode"></select>
</div>

<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp"/>
<script type="text/javascript">
    var rowIndexdd;
    var editFlag = undefined;

    $(function () {
        var statusArr = [{
            'code': '0',
            'name': '否'
        }, {
            'code': '1',
            'name': '是'
        }];
        var isSubmit = '${isSubmit}';
        var employeeInfo_id = '${employeeInfo_id}';
        var diplomaTypeArr = eval('${diplomaTypeArr}');
        var xueweiTypeArr = eval('${xueweiTypeArr}');
        var specialtyTypeArr = eval('${specialtyTypeArr}');

        frloadOpen();

        aud$genSelectOption('query_educationCode', diplomaTypeArr);
        aud$genSelectOption('query_degreeCode', xueweiTypeArr);
        aud$genSelectOption('query_majorCode', specialtyTypeArr);

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
            boName: 'EducationExperience',
            // 对象主键,删除数据时使用-默认为“id”；必填
            pkName: 'id',
            <s:if test="${isSubmit == '1'}">
            whereSql: ' employeeInfo_id=\'' + employeeInfo_id + '\' and isSubmit=\'1\' ',
            </s:if>
            <s:else>
            whereSql: ' employeeInfo_id=\'' + employeeInfo_id + '\'  ',
            </s:else>
            order: 'asc',
            sort: 'start_time',
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
                                    start_time: '',
                                    stop_time: '',
                                    graduateUniversity: '',
                                    isElite: '',
                                    isOverseas: '',
                                    education: '',
                                    educationCode: '',
                                    secondMajor: '',
                                    secondMajorCode: '',
                                    major: '',
                                    majorCode: '',
                                    isMax: '否',
                                    remarks: '',
                                    isSubmit: '0'
                                }
                            });

                            $("#sDTable").datagrid('clearSelections');
                            $("#sDTable").datagrid('beginEdit', length);
                            $("#sDTable").datagrid('selectRow', length);
                            editFlag = length;
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
                                    start_time: '',
                                    stop_time: '',
                                    graduateUniversity: '',
                                    isElite: '',
                                    isOverseas: '',
                                    education: '',
                                    educationCode: '',
                                    secondMajor: '',
                                    secondMajorCode: '',
                                    major: '',
                                    majorCode: '',
                                    isMax: '0',
                                    remarks: '',
                                    isSubmit: '1'
                                }
                            });

                            $("#sDTable").datagrid('clearSelections');
                            $("#sDTable").datagrid('beginEdit', length);
                            $("#sDTable").datagrid('selectRow', length);
                            editFlag = length;
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
                            //使用JSON序列化datarow对象，发送到后台。
                            var rows = $("#sDTable").datagrid('getChanges');
                            var rowstr = JSON.stringify(rows);

                            if (!checkTemplateStatus()) {
                                return;
                            }

                            $.ajax({
                                url: '${contextPath}/mng/employee/personnel/saveExperience.action',
                                async: false,
                                type: 'POST',
                                data: {'rowstr': rowstr},
                                success: function (data) {
                                    if (data == '1') {
                                        showMessage1('保存成功！');
                                        $("#sDTable").datagrid('reload');
                                    }
                                }
                            });
                        }
                    }
                ],
                </s:if>
                onLoadSuccess: function () {
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
                        field: 'start_time', title: '开始时间', width: 120, align: 'center', halign: 'center', sortable: true,
                        editor: {
                            type: 'datebox',
                            options: {
                                editable: false,
                                /*required : true*/
                            }
                        }
                    },
                    {
                        field: 'stop_time', title: '结束时间', width: 120, align: 'center', halign: 'center', sortable: true,
                        editor: {
                            type: 'datebox',
                            options: {
                                editable: false,
                                /*required : true*/
                            }
                        }
                    },
                    {
                        field: 'graduateUniversity', title: '毕业院校', width: bodyW * 0.15 + 'px', align: 'left', halign: 'center', sortable: true,
                        editor: {//设置其为可编辑
                            type: 'text',
                            options: {required: true}
                        }
                    },
                    {
                        field: 'isElite', title: '是否211/985', width: 110, align: 'center', halign: 'center', sortable: true,
                        editor: {//设置其为可编辑
                            type:
                                'combobox',
                            options: {
                                required: true,
                                editable: false,
                                panelHeight: 'auto',
                                valueField: 'code',
                                textField: 'name',
                                data: statusArr,
                                onChange: function (oldval, newval) {
                                    if (oldval == '1' || (oldval != null && newval == '1')) {
                                    }
                                }
                            }
                        },
                        formatter: function (value, row, index) {
                            var vtext = "";
                            $.each(statusArr, function (i, jdata) {
                                if (jdata['code'] == value) {
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
                            var rtVal = vtext ? vtext : value;
                            row['isElite'] = rtVal;
                            return rtVal;
                        }
                    },
                    {
                        field: 'isOverseas', title: '是否海外学历', width: 110, align: 'center', halign: 'center', sortable: true,
                        editor: {//设置其为可编辑
                            type:
                                'combobox',
                            options: {
                                required: true,
                                editable: false,
                                panelHeight: 'auto',
                                valueField: 'code',
                                textField: 'name',
                                data: statusArr,
                                onChange: function (oldval, newval) {
                                    if (oldval == '1' || (oldval != null && newval == '1')) {
                                    }
                                }
                            }
                        },
                        formatter: function (value, row, index) {
                            var vtext = "";
                            $.each(statusArr, function (i, jdata) {
                                if (jdata['code'] == value) {
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
                            var rtVal = vtext ? vtext : value;
                            row['isOverseas'] = rtVal;
                            return rtVal;
                        }
                    },
                    {
                        field: 'educationCode', title: '学历', width: bodyW * 0.15 + 'px', align: 'left', halign: 'center', sortable: true, type: 'custom', target: $('#queryCond0')[0], show: 'true',
                        editor: {
                            type: 'combobox',
                            options: {
                                required: true,
                                data: diplomaTypeArr,
                                valueField: "code",
                                textField: "name"
                            }
                        },
                        /*formatter:function(value, row) {
                            return row.education;
                        }*/
                        formatter: function (value, row, index) {
                            var vtext = "";
                            $.each(diplomaTypeArr, function (i, jdata) {
                                if (jdata['code'] == value) {
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
                            var rtVal = vtext ? vtext : value;
                            row['education'] = rtVal;
                            return rtVal;
                        }
                    },
                    {
                        field: 'majorCode', title: '所学专业', width: bodyW * 0.15 + 'px', align: 'left', halign: 'center', sortable: true, type: 'custom', target: $('#queryCond2')[0],
                        editor: {//设置其为可编辑
                            type: 'combobox',
                            options: {
                                required: true,
                                data: specialtyTypeArr,
                                valueField: "code",
                                textField: "name"
                            }
                        },
                        /*formatter:function(value, row) {
                            return row.major;
                        }*/
                        formatter: function (value, row, index) {
                            var vtext = "";
                            $.each(specialtyTypeArr, function (i, jdata) {
                                if (jdata['code'] == value) {
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
                            var rtVal = vtext ? vtext : value;
                            row['major'] = rtVal;
                            return rtVal;
                        }
                    },
                    /*{field:'degreeCode',title:'学位', width:bodyW*0.1 + 'px',align:'center', halign:'center', sortable:true,type:'custom', target:$('#queryCond1')[0],
                        editor: {//设置其为可编辑
                             type: 'combobox',
                             options:  {
                                 data: xueweiTypeArr, valueField: "code", textField: "name"
                             }
                         },
                         formatter:function(value, row) {
                             return row.degree;
                         }
                    },*/
                    {
                        field: 'secondMajorCode', title: '第二学位专业', width: bodyW * 0.15 + 'px', align: 'left', halign: 'center', sortable: true, type: 'custom', target: $('#queryCond2')[0],
                        editor: {//设置其为可编辑
                            type: 'combobox',
                            options: {
                                data: specialtyTypeArr,
                                valueField: "code",
                                textField: "name"
                            }
                        },
                        /*formatter:function(value, row) {
                            return row.major;
                        }*/
                        formatter: function (value, row, index) {
                            var vtext = "";
                            $.each(specialtyTypeArr, function (i, jdata) {
                                if (jdata['code'] == value) {
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
                            var rtVal = vtext ? vtext : value;
                            row['secondMajor'] = rtVal;
                            return rtVal;
                        }
                    },
                    {
                        field: 'isMax', title: '是否最高学历', width: 110, align: 'center', halign: 'center', sortable: true, show: 'true',
                        editor: {
                            type:
                                'combobox',
                            options: {
                                required: true,
                                editable: false,
                                panelHeight: 'auto',
                                valueField: 'code',
                                textField: 'name',
                                data: statusArr,
                                onChange: function (oldval, newval) {
                                    if (oldval == '1' || (oldval != null && newval == '1')) {
                                    }
                                }
                            }
                        },
                        formatter: function (value, row, index) {
                            var vtext = "";
                            $.each(statusArr, function (i, jdata) {
                                if (jdata['code'] == value) {
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
                            var rtVal = vtext ? vtext : value;
                            row['isMax'] = rtVal;
                            return rtVal;
                        }
                    },
                    {
                        field: 'remarks', title: '备注', width: bodyW * 0.15 + 'px', align: 'left', halign: 'center', sortable: true, show: 'true',
                        editor: {//设置其为可编辑
                            type: 'text'
                        }
                    }
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
        var rtFlag = 0;
        var flag = true;
        var rows = $('#sDTable').datagrid("getRows");
        //alert("rows="+rows)
        if (rows && rows.length) {
            var rlen = rows.length;
            for (var i = 0; i < rlen; i++) {
                var row = rows[i];
                if (!row.start_time || row.start_time.replace(/\s+/g, "").length == 0) {
                    editFlag = i;
                    $('#sDTable').datagrid('selectRow', editFlag).datagrid('beginEdit', editFlag);
                    showMessage1("第"+(i+1)+"行[开始时间]不能为空");
                    return false;
                }
                if (!row.stop_time || row.stop_time.replace(/\s+/g, "").length == 0) {
                    editFlag = i;
                    $('#sDTable').datagrid('selectRow', editFlag).datagrid('beginEdit', editFlag);
                    showMessage1("第"+(i+1)+"行[结束时间]不能为空");
                    return false;
                }

                if(row.start_time && row.stop_time){
                    var startTime = row.start_time.replace(/\s+/g, "").replace(/-/g,"\/");
                    var endTime = row.stop_time.replace(/\s+/g, "").replace(/-/g,"\/");
                    if(Date.parse(new Date(startTime)) > Date.parse(new Date(endTime))){
                        showMessage1("第"+(i+1)+"行[结束时间]不能早于[开始时间]");
                        return false;
                    }
                }
                if (!row.graduateUniversity || row.graduateUniversity.replace(/\s+/g, "").length == 0) {
                    editFlag = i;
                    $('#sDTable').datagrid('selectRow', editFlag).datagrid('beginEdit', editFlag);
                    showMessage1("第"+(i+1)+"行[毕业院校]不能为空");
                    return false;
                }

                // 启用状态 1-启用，0-不启用
                var isMax = row['isMax'];
                if (isMax == '是') {
                    rtFlag++;
                    if (rtFlag > 1) {
                        flag = false;
                        showMessage1("最高学历只能存在一个。");
                    }
                }
            }
        }
        return flag;
    }

    $.extend($.fn.datagrid.defaults.editors, {
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
</script>
</body>
</html>