<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<title>效绩情况</title>
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
<div id='queryCond7'>
    <select id="query_perCode" name="query_perCode"></select>
</div>
<div id='queryCond10'>
    <select id="query_yearCode" name="query_yearCode"></select>
</div>
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp"/>
<script type="text/javascript">
    var rowIndexdd;
    var editFlag = undefined;

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

	function handle(formId) {
		var winUrl = "${contextPath}/workprogram/auditDeptTabFile.action?isView=view&wpd_stagecode=rework&comfirm=y&projectid=" + formId;
		aud$openNewTab("整改行动确认", winUrl, true, false);
	}

	function checkTemplateStatus() {
		var rtFlag = 0;
		var flag = true;
		var rows = $('#sDTable').datagrid("getRows");
		//alert("rows="+rows)
		if (rows && rows.length) {
			var rlen = rows.length;
			for (var i = 0; i < rlen; i++) {
				var row = rows[i];
				var per_year = row['year'];

                if (!row.year || row.year.replace(/\s+/g, "").length == 0) {
                    editFlag = i;
                    $('#sDTable').datagrid('selectRow', editFlag).datagrid('beginEdit', editFlag);
                    showMessage1("第"+(i+1)+"行[年份]不能为空");
                    return false;
                }
                if (!row.performance_results || row.performance_results.replace(/\s+/g, "").length == 0) {
                    editFlag = i;
                    $('#sDTable').datagrid('selectRow', editFlag).datagrid('beginEdit', editFlag);
                    showMessage1("第"+(i+1)+"行[绩效结果]不能为空");
                    return false;
                }

				for (var j = 0; j < i; j++) {
					var rowj = rows[j];
					var per_year_j = rowj['year'];
					if (per_year == per_year_j) {
                        editFlag = i;
                        $('#sDTable').datagrid('selectRow', editFlag).datagrid('beginEdit', editFlag);
						flag = false;
						showMessage1("["+per_year+"]年绩效已存在，不能重复提交同一年度绩效！");
					}
				}
			}
		}
		return flag;
	}

    $(function () {
        var statusArr = [{
            'code': '0',
            'name': '否'
        }, {
            'code': '1',
            'name': '是'
        }];
        var employeeInfo_id = '${employeeInfo_id}';
        var perListArr = eval('${perListArr}');
        var yearListArr = eval('${yearListArr}');

        frloadOpen();

		aud$genSelectOption('query_perCode', perListArr);
		aud$genSelectOption('query_yearCode', yearListArr);


		// 重写公共的datagrid删除方法
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
            boName: 'EmployeePerformance',
            // 对象主键,删除数据时使用-默认为“id”；必填
            pkName: 'id',
            <s:if test="${isSubmit == '1'}">
            whereSql: ' employeeInfo_id=\'' + employeeInfo_id + '\' and isSubmit=\'1\' ',
            </s:if>
            <s:else>
            whereSql: ' employeeInfo_id=\'' + employeeInfo_id + '\'  ',
            </s:else>
            //  order:'asc',
            //  sort:'sn',
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
                                    year: '',
                                    performance_results: '',
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
                                    year: '',
                                    performance_results: '',
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
                                url: '${contextPath}/mng/employee/personnel/savePerformance.action',
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
                        field: 'year', title: '年份', width: bodyW * 0.15 + 'px', align: 'center', halign: 'center', sortable: true, type: 'custom', target: $('#queryCond10')[0], show: 'true',
                        editor: {
                            type: 'combobox',
                            options: {
                                editable: false,
                                valueField: "code",
                                textField: "name",
                                data: yearListArr,
                            }
                        },
                        formatter: function (value, row, index) {
                            var vtext = "";
                            $.each(yearListArr, function (i, jdata) {
                                if (jdata['code'] == value) {
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
                            var rtVal = vtext ? vtext : value;
                            /*row['education'] = rtVal;*/
                            return rtVal;
                        }
                    },
                    {
                        field: 'performance_results', title: '绩效结果', width: bodyW * 0.15 + 'px', align: 'center', halign: 'center', sortable: true, type: 'custom', target: $('#queryCond7')[0], show: 'true',
                        editor: {
                            type: 'combobox',
                            options: {
                                data: perListArr,
                                valueField: "code",
                                textField: "name"
                            }
                        },
                        formatter: function (value, row, index) {
                            var vtext = "";
                            $.each(perListArr, function (i, jdata) {
                                if (jdata['code'] == value) {
                                    vtext = jdata['name'];
                                    return false;
                                }
                            });
                            // 下拉得到的值是code，这块需要自己手动把name值赋给对应的字段
                            var rtVal = vtext ? vtext : value;
                            /* row['education'] = rtVal;*/
                            return rtVal;
                        }
                    },
                    {
                        field: 'remarks', title: '备注说明', width: bodyW * 0.35 + 'px', align: 'left', halign: 'center', sortable: true, show: 'true',
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
</script>
</body>
</html>
