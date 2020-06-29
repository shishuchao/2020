<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>审计疑点列表</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
</head>
<body class="easyui-layout">
<div id="searchDoubt" class="searchWindow">
    <div class="search_head">
        <s:form id="searchForm" name="searchForm" action="listAll" namespace="/plan/year" method="post">
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr>
                    <td align="left" class="EditHead" width="15%">疑点名称</td>
                    <td align="left" class="editTd" width="35%">
                        <s:textfield cssClass="noborder" name="audDoubt.doubt_name" maxlength="50" cssStyle='width:80%'/>
                    </td>
                    <td align="left" class="EditHead" width="15%">审计事项</td>
                    <td align="left" class="editTd" width="35%">
                        <s:textfield cssClass="noborder" name="audDoubt.task_name" maxlength="50" cssStyle='width:80%'/>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">开始日期</td>
                    <td align="left" class="editTd">
                        <s:textfield name="audDoubt.start_search" cssStyle="width:80%" maxlength="50" cssClass="easyui-datebox noborder"/>
                    </td>
                    <td align="left" class="EditHead">结束日期</td>
                    <td align="left" class="editTd">
                        <s:textfield name="audDoubt.end_search" cssStyle='width:80%'
                                     maxlength="50" cssClass="easyui-datebox noborder"/>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">撰写人</td>
                    <td align="left" class="editTd">
                        <s:textfield cssClass="noborder" name="audDoubt.doubt_author" maxlength="50" cssStyle='width:80%'/>
                    </td>
                    <td align="left" class="EditHead">疑点编码</td>
                    <td align="left" class="editTd">
                        <s:textfield cssClass="noborder" name="audDoubt.doubt_code" maxlength="50" cssStyle='width:80%'/>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="EditHead">疑点状态</td>
                    <td align="left" class="editTd">
                        <select id="" class="easyui-combobox" name="audDoubt.doubt_status" style="width:80%;" editable="false" panelHeight="auto">
                            <option value="">　</option>
                            <option value="010">未处理</option>
                            <option value="050">已处理无问题</option>
                            <option value="055">已处理有问题</option>
                        </select>
                    </td>
                    <td align="left" class="EditHead">被审计单位</td>
                    <td align="left" class="editTd">
                        <select id="audit_dept" class="easyui-combobox" panelHeight="auto" name="audDoubt.audit_dept" editable="false">
                            <option value="">&nbsp;</option>
                            <s:iterator value="auditObjectMap" id="entry">
                                <s:if test="${audDoubt.audit_dept==key}">
                                    <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="key"/>"><s:property value="value"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </td>
                </tr>
            </table>
        </s:form>
    </div>
    <div class="serch_foot">
        <div class="search_btn">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="query()">查询</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetDoubtList()">重置</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#searchDoubt').window('close')">取消</a>
        </div>
    </div>
</div>
<div region="center" border='0'>
    <table id="doubtList"></table>
</div>
<div id="veiwDoubt" style="padding:10px"></div>
<div id="veiwManu" style="padding:10px"></div>
<div id="outManuOwnerDlg">
    <s:form id="outManuOwnerForm" method="post">
        <s:hidden id="doubt_id" name="doubt_id"/>
        <table class="ListTable" width="100%" style="height:100%;">
            <tr>
                <td class="editTd" colspan="2" style="height:30px;">
                    <a href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="outDoubtHandleDoubt();">处理</a>
                    <a href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="$('#outManuOwnerDlg').window('close')">返回</a>
                </td>
            </tr>
            <tr>
                <td class="EditHead" style="width:150px;">
                    <div style="text-align: center; float: right;">
                        <font color='red'>*</font>无问题原因:<br><font color=DarkGray>(限1000字)</font>
                    </div>
                </td>
                <td class="editTd">
                    <s:textarea id="no_doubt_reason" name="audDoubt.doubt_reason" cssClass='noborder' cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
                </td>
            </tr>
        </table>
    </s:form>
</div>

<script type="text/javascript">
    $(function () {
        var isEditDoubt = function (flag) {
            if (flag) {
                $('#doubtList').datagrid({
                    toolbar: [{
                        id: 'searchObj',
                        text: '查询',
                        iconCls: 'icon-search',
                        handler: function () {
                            searchWindShow('searchDoubt', 800);
                        }
                    }, '-',
                        {
                            id: 'addDoubt',
                            text: '新增',
                            iconCls: 'icon-add',
                            handler: function () {
                                addDoubtFrame();
                            }
                        }, '-',
                        {
                            id: 'batchSubmitObj',
                            text: '删除',
                            iconCls: 'icon-delete',
                            handler: function () {
                                piliangDel();
                            }
                        }, '-',
                        {
                            id: 'outManuOwner',
                            text: '消除疑点',
                            iconCls: 'icon-cancel',
                            handler: function () {
                                outDoubt();
                            }
                        }, '-', {
                            id: 'inManuOwner',
                            text: '恢复',
                            iconCls: 'icon-recover',
                            handler: function () {
                                inDoubt();
                            }
                        }, '-', helpBtn
                    ]
                });
            }
        };
        var isViewDoubt = function (flag) {
            if (flag) {
                $('#doubtList').datagrid({
                    toolbar: [{
                        id: 'searchObj',
                        text: '查询',
                        iconCls: 'icon-search',
                        handler: function () {
                            searchWindShow('searchDoubt', 800);
                        }
                    }, '-', helpBtn
                    ]
                });
            }
        };

        //taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
        var doubtListUrl = "/operate/doubtExt/doubtListJson.action?querySource=grid&flushdata=true&taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&interaction=${interaction}";
        if ('${taskPid}' == "-1" || '${taskPid}' == '') {
            doubtListUrl = doubtListUrl + '&audDoubt.flushdata=2&audDoubt.doubt_type=YD&audDoubt.project_id=<%=request.getParameter("project_id")%>&audDoubt.task_id=-1';
        } else {
            doubtListUrl = doubtListUrl + '&audDoubt.flushdata=2&audDoubt.doubt_type=YD&audDoubt.project_id=<%=request.getParameter("project_id")%>&audDoubt.task_id=<%=request.getParameter("taskId")%>';
        }
        var isView = '<%=request.getParameter("isView")%>';
        var view = '<%=request.getParameter("view")%>';
        //是否为查看疑点
        if (isView == 'true' || view == 'view') {
            isViewDoubt(1);
            doubtListUrl = doubtListUrl + "&isAll=<%=request.getParameter("isAll")%>";
        } else {
            isEditDoubt(1);
        }
        $('#doubtList').datagrid({
            url: '${pageContext.request.contextPath}' + doubtListUrl,
            method: 'post',
            showFooter: true,
            rownumbers: true,
            pagination: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            pageSize: 20,
            idField: 'doubt_id',
            fitColumns: true,
            border: false,
            remoteSort: false,
            frozenColumns: [[
                {field: 'doubt_id', halign: 'center', checkbox: true, align: 'center'},
                {
                    field: 'doubt_name',
                    title: '疑点名称',
                    width: 180,
                    halign: 'center',
                    align: 'left',
                    sortable: true,
                    formatter: function (value, row, rowIndex) {
                        if ('${user.floginname}' == row.doubt_author_code && '010' == row.doubt_status && 'view' != '${view}') {
                            return "<a title='单击编辑' href=\"javascript:void(0)\" onclick=\"editDoubt('" + row.doubt_id + "','" + row.doubt_author_code + "','" + row.doubt_status + "')\">" + row.doubt_name + "</a>"
                        } else {
                            return "<a title='单击查看' href=\"javascript:void(0)\" onclick=\"viewDoubt('" + row.doubt_id + "')\">" + row.doubt_name + "</a>"
                        }
                    }
                }
            ]],
            columns: [[
                {
                    field: 'doubt_statusName',
                    title: '疑点状态',
                    width: 100,
                    halign: 'center',
                    align: 'left',
                    sortable: true,
                    formatter: function (value, row, rowIndex) {
                        return row.doubt_statusName;
                    }
                },
                {
                    field: 'doubt_code',
                    title: '疑点编码',
                    width: 100,
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, row, rowIndex) {
                        return row.doubt_code;
                    }
                },
                {
                    field: 'audit_dept_name',
                    title: '被审计单位',
                    width: 100,
                    halign: 'center',
                    align: 'left',
                    sortable: true
                },
                {
                    field: 'task_name',
                    title: '审计事项',
                    width: 250,
                    halign: 'center',
                    align: 'left',
                    sortable: true,
                    formatter: function (value, row, rowIndex) {
                        return row.task_name;
                    }
                },
                {
                    field: 'doubt_author',
                    title: '撰写人',
                    width: 60,
                    halign: 'center',
                    align: 'left',
                    sortable: true,
                    formatter: function (value, row, rowIndex) {
                        return row.doubt_author;
                    }
                },
                {
                    field: 'fileCount',
                    title: '附件',
                    width: 40,
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, row, rowIndex) {
                        return row.fileCount;
                    }
                },
                {
                    field: 'doubt_manu_name',
                    title: '关联底稿',
                    width: 180,
                    halign: 'center',
                    align: 'center',
                    sortable: true,
                    formatter: function (value, row, rowIndex) {
                        var doubt_manu = row.doubt_manu;
                        if (row.doubt_manu_name != '' && row.doubt_manu_name != null) {
                            var manuId = doubt_manu.split(',');

                            return "<a href=\"javascript:void(0)\" onclick=\"viewManu('" + manuId[0] + "')\">" + row.doubt_manu_name + "</a>";
                        } else {
                            return "";
                        }
                    }
                },
                {
                    field: 'doubt_date_view',
                    title: '创建日期',
                    width: 90,
                    halign: 'center',
                    align: 'center',
                    sortable: true
                }/* ,
						{field:'fff',
							title:'操作',
							halign:'center',
							align:'right',
							width: 90,
							sortable:true,
							formatter:function(value,row,rowIndex){
								//doubt_author_code,doubt_status
								var param = [row.doubt_id,row.doubt_author_code,row.doubt_status];
								var btn2 = "修改,editDoubt,"+param.join(',');
								return ganerateBtn(btn2);
							}
						} */
            ]],
            onLoadSuccess: function (data) {
                if (isView == 'true' || view == 'view') {
                    $(".datagrid-view2 .datagrid-btable tr").each(function () {
                        $(this).find('td:last').hide();
                    });
                    $(".datagrid-header-row td:last").hide();
                    $("#addDoubt").remove();
                }
                initHelpBtn();
            }
        });


        showWin('veiwDoubt', "查看疑点详情");
        showWin('veiwManu', "查看关联底稿详情");
        showWin('searchDoubt');
        $('#outManuOwnerDlg').window({
            width:700,
            height:230,
            modal:true,
            title:"消除疑点",
            collapsible:false,
            maximizable:true,
            minimizable:true,
            closed:true
        });
        autoTextarea($("#no_doubt_reason").get(0));
        $("#no_doubt_reason").attr("maxlength",1000);

        loadSelectH();
    });

    function query() {
        $('#doubtList').datagrid({
            queryParams: form2Json('searchForm')
        });
        $('#searchDoubt').window('close');
    }

    //重置查询条件
    function resetDoubtList() {
        document.getElementsByName("audDoubt.audit_dept")[0].value = "";
        document.getElementsByName("audDoubt.doubt_status")[0].value = "";
        resetForm('searchForm');
        //	query();
    }

    //增加疑点
    function addDoubtFrame() {
        if (isGoOn()) {
            return false;
        }
        if ('<%=request.getParameter("taskId")%>' == '-1') {//从“我的疑点”进入的，先建疑点后选择审计事项
            window.location.href = "/ais/operate/doubt/editDoubt.action?type=FX&project_id=<%=request.getParameter("project_id")%>"
                + "&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
        } else {//从审计事项进入，需要判断是否有权增加
            var auth = '0';
            $.ajax({
                url: "${pageContext.request.contextPath}/operate/task/checkTaskAssign.action",
                type: "POST",
                data: {"project_id": "<%=request.getParameter("project_id")%>", "taskTemplateId": "<%=request.getParameter("taskId")%>", "taskPid": "<%=request.getParameter("taskPid")%>"},
                async: false,
                success: function (data) {
                    auth = data;
                }
            });
// 				    if(auth == '0') {
// 				    	alert("没有权限增加！");
// 				    	return false;
// 				    }
// 		  			if('<%=request.getParameter("taskPid")%>'=='-1'||'<%=request.getParameter("taskPid")%>'=='null'){
// 		    			alert('不能在根节点增加，请先选择事项节点！');
// 		    			return false;
// 		  			}
            window.location.href = "/ais/operate/doubt/editDoubt.action?type=FX&project_id=<%=request.getParameter("project_id")%>"
                + "&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
        }
    }

    //chankan yidian
    function doubtView() {
        var rows = $('#doubtList').datagrid('getChecked');//返回是个数组
        if (rows != null && rows.length > 0) {
            if (rows.length == 1) {
                var row = rows[0];
                var doubt_id = row.doubt_id;
                $.ajax({
                    url: "${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
                    type: "POST",
                    data: {'checkStatus': '000', 'doubt_id': doubt_id},
                    async: false,
                    success: function (data) {
                        checkCode = data;
                    }
                });
                if (checkCode == '1' || checkCode == '2') {

                } else {
                    showMessage1("疑点已删除,请刷新数据后重新操作！");
                    $("#doubtList").datagrid('reload');
                    return false;
                }
                var width = ($(window).width() - 1200) * 0.5;
                var height = ($(window).height() - 550) * 0.2;
                var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id=" + doubt_id;
                parent.addTab("tabs", "审计疑点查看", "doubtViewTab", myurl, false);
            } else {
                $.messager.show({title: '提示信息', msg: '请选择一条记录!'});
            }
        } else {
            $.messager.show({title: '提示信息', msg: '请选择一条记录!'});
        }
    }

    //编辑疑点
    function editDoubt(doubt_id, doubt_author_code, doubt_status) {
        if (isGoOn()) {
            return false;
        }
        var rows = $('#doubtList').datagrid('getChecked');
        if (doubt_id == '' || doubt_id == null) {
            showMessage1('请选择数据');
            return false;
        } else {
            if ('${user.floginname}' == doubt_author_code) {

            } else {
                showMessage1('没有权限修改！');
                return false;
            }
            if ('010' == doubt_status) {
                var checkCode = '0';
                $.ajax({
                    url: "${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
                    type: "POST",
                    async: false,
                    data: {"checkStatus": "010", "doubt_id": doubt_id},
                    success: function (data) {
                        checkCode = data;
                    }
                });
                if (checkCode == '1') {

                } else {
                    showMessage1('不能修改,疑点已处理或已删除,请刷新数据后重新操作！');
                    $("#doubtList").datagrid('reload');
                    return false;
                }
            } else {
                showMessage1('不能修改,疑点已处理或已删除,请刷新数据后重新操作！');
                return false;
            }
            window.location.href = "/ais/operate/doubt/editDoubt.action?type=FX&doubt_id=" + doubt_id + "&project_id=<%=request.getParameter("project_id")%>"
                + "&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
        }
    }

    function isGoOn() {
        var flag = false;
        $.ajax({
            url: '${contextPath}/operate/manuExt/isGoOn.action',
            type: 'POST',
            data: {"project_id": '${project_id}'},
            dataType: 'json',
            async: false,
            success: function (data) {
                if (data == 2) {
                    showMessage1('实施方案正在调整，暂不允许登记疑点！');
                    flag = true;
                } else {
                    flag = false;
                }
            },
            error: function () {
                $.messager.alert("系统错误，请联系系统管理员！", 'info');
                flag = true;
            }
        });
        return flag;
    }

    //批量删除疑点
    function piliangDel() {
        //实施方案调整时允许注销和删除底稿
//    		 if(isGoOn()){
//     			  return false;
//     		  }
        var rows = $('#doubtList').datagrid("getChecked");
        var str = "";
        //一条数据，走单独删除
        if (rows.length < 1) {
            showMessage1('请选择一条记录!');
            return false;
        }
        if (rows && rows.length == 1) {
            delDoubt();
        } else {

            for (i = 0; i < rows.length; i++) {
                var doubt_author_code = rows[i].doubt_author_code;
                var doubt_status = rows[i].doubt_status;
                var project_id = rows[i].project_id;
                var id = rows[i].doubt_id;
                if ('${user.floginname}' == doubt_author_code) {

                } else {
                    showMessage1("所选取的疑点 [" + rows[i].doubt_name + "] 没有权限删除！");
                    return false;
                }
                if (rows[i].doubt_status == '010') {
                    var checkCode = '0';
                    $.ajax({
                        url: "${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
                        type: "POST",
                        async: false,
                        data: {"checkStatus": "010", "doubt_id": id},
                        success: function (data) {
                            checkCode = data;
                        }
                    });
                    if (checkCode == '1') {

                    } else {
                        showMessage1("所选取的疑点 [" + rows[i].doubt_name + "] 不能删除,疑点已处理或已删除,请刷新数据后重新操作！");
                        window.location.reload();
                        return false;
                    }
                } else {
                    showMessage1("所选取的疑点 [" + rows[i].doubt_name + "] 已处理状态不能删除!");
                    return false;
                }
            }
            $.messager.confirm('确认对话框', "确认删除这 " + rows.length + " 条数据吗？", function (r) {
                if (r) {
                    for (i = 0; i < rows.length; i++) {
                        str += rows[i].doubt_id + ",";
                    }
                    jQuery.ajax({
                        url: "${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action",
                        type: "POST",
                        data: {'audDoubt.doubt_id': str},
                        success: function (data) {
                            showMessage1("删除成功！");
                            window.location.reload();
                        },
                        error: function () {
                            showMessage1("删除疑点出错了！");
                        }
                    });
                }
            });
        }
    }

    //删除疑点
    function delDoubt() {
        var rows = $("#doubtList").datagrid("getChecked");
        if (isSingle(rows)) {
            var row = rows[0];
            var doubt_id = row.doubt_id;
            var doubt_author_code = row.doubt_author_code;
            var doubt_status = row.doubt_status;
            if (doubt_id == null || doubt_id == '') {
                showMessage1("数据错误，请刷新后重试！");
                return;
            }
            if ('${user.floginname}' == doubt_author_code) {

            } else {
                showMessage1("没有删除权限！");
                return false;
            }
            if ('010' == doubt_status) {
                var checkCode = '0';
                $.ajax({
                    url: "${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
                    type: "POST",
                    async: false,
                    data: {"checkStatus": "010", "doubt_id": doubt_id},
                    success: function (data) {
                        checkCode = data;
                    }
                });
                if (checkCode == '1') {

                } else {
                    showMessage1("不能删除,疑点已处理或已删除,请刷新数据后重新操作！");
                    return false;
                }
            } else {
                showMessage1("已处理状态不能删除！");
                return false;
            }
            top.$.messager.confirm('确认', '确认删除疑点吗?', function (flag) {
                if (flag) {
                    //上面条件都不满足，进行删除
                    $.ajax({
                        url: "${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action",
                        type: "POST",
                        async: false,
                        data: {"audDoubt.doubt_id": doubt_id},
                        success: function (data) {
                            showMessage1('删除成功！');
                            window.location.reload();
                        }
                    });
                }
            });
        }
    }

    //是否选中一条记录
    function isSingle(rows) {
        if (rows != null && rows.length > 0) {
            if (rows.length == 1) {
                return true;
            } else {
                showMessage1('请选择一条记录!');
                return false;
            }
        } else {
            showMessage1('请选择一条记录!');
            return false;
        }
    }

    //查看疑点
    function viewDoubt(doubt_id) {
        var checkCode = '0';
        $.ajax({
            url: "${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
            type: "POST",
            data: {'checkStatus': '000', 'doubt_id': doubt_id},
            async: false,
            success: function (data) {
                checkCode = data;
            }
        });
        if (checkCode == '1' || checkCode == '2') {

        } else {
            showMessage1("疑点已删除,请刷新数据后重新操作！");
            $("#doubtList").datagrid('reload');
            return false;
        }
        var width = ($(window).width() - 1200) * 0.5;
        var height = ($(window).height() - 550) * 0.2;
        var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id=" + doubt_id;
        parent.addTab("tabs", "审计疑点查看", "doubtViewTab", myurl, false);
        //$('#veiwDoubt').window("open").window("resize",{width:1200,height:550,left:width,top:height}).window("refresh",myurl);
    }

    //处理审计疑点
    function outDoubt() {
        if (isGoOn()) {
            return false;
        }
        var rows = $('#doubtList').datagrid('getChecked');//返回是个数组
        if (rows != null && rows.length > 0) {
            if (rows.length == 1) {
                var row = rows[0];
                var doubt_author_code = row.doubt_author_code;
                var doubt_status = row.doubt_status;
                var doubt_id = row.doubt_id;
                if ('${user.floginname}' == doubt_author_code) {

                } else {
                    showMessage1("没有权限处理！");
                    return false;
                }
                var checkCode = '0';
                $.ajax({
                    url: "${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
                    type: "POST",
                    async: false,
                    data: {"checkStatus": "010", "doubt_id": doubt_id},
                    success: function (data) {
                        checkCode = data;
                    }
                });
                if ('010' == doubt_status) {
                    if (checkCode == '1') {

                    } else {
                        showMessage1("不能处理,疑点已处理或已删除,请刷新数据后重新操作！");
                        return false;
                    }

                } else {
                    showMessage1("已经是已处理状态！");
                    return false;
                }
                <%--var title = "录入处理无问题原因";--%>
                <%--window.location.href = '${contextPath}/operate/doubt/editDoubtReason.action?chuli=1&doubt_id='+doubt_id;--%>
                $('#doubt_id').val(doubt_id);
                $('#no_doubt_reason').val('');
                $("#outManuOwnerDlg").window("open");
            } else {
                $.messager.show({title: '提示信息', msg: '请选择一条记录!'});
            }
        } else {
            $.messager.show({title: '提示信息', msg: '请选择一条记录!'});
        }
    }

    function outDoubtHandleDoubt() {
        var doubt_id = $('#doubt_id').val();
        var no_doubt_reason = $('#no_doubt_reason').val();
        if (no_doubt_reason == null || no_doubt_reason == '') {
            top.$.messager.show({
                title:"提示信息",
                msg:"无问题原因不能为空!",
                timeout:5000
            });
            return;
        }

        top.$.messager.confirm('确认', '确认要处理疑点吗?', function(flag){
            if (flag){
                $.ajax({
                    url:"${contextPath}/operate/doubt/saveDoubtReason.action",
                    type:"post",
                    data:$("#outManuOwnerForm").serialize(),
                    async:false,
                    success:function(){
                        top.$.messager.show({
                            title:"提示信息",
                            msg:"处理成功！",
                            timeout:5000
                        });
                        $('#doubtList').datagrid({
                            queryParams: form2Json('searchForm')
                        });
                        $('#outManuOwnerDlg').window('close');
                    },
                    error:function(){
                        alert("系统错误，请联系系统管理员！");
                    }
                });
            }
        });
    }

    //恢复疑点状态为未处理
    function inDoubt(s) {
//    	 if(isGoOn()){
// 			  return false;
// 		  }
        var rows = $("#doubtList").datagrid("getChecked");
        if (rows != null && rows.length > 0) {
            if (rows.length == 1) {
                var row = rows[0];
                var doubt_author_code = row.doubt_author_code;
                var doubt_status = row.doubt_status;
                var doubt_id = row.doubt_id;
                if ('${user.floginname}' == doubt_author_code) {

                } else {
                    showMessage1("没有权限恢复！");
                    return false;
                }
                var checkCode = '0';
                $.ajax({
                    url: "${pageContext.request.contextPath}/operate/doubt/checkStatus.action",
                    type: "POST",
                    async: false,
                    data: {"checkStatus": "050", "doubt_id": doubt_id},
                    success: function (data) {
                        checkCode = data;
                    }
                });
                if (checkCode == '1') {

                } else if (checkCode == '2') {
                    showMessage1("该疑点已经生成底稿，不可恢复！");
                    return false;
                } else {
                    showMessage1("不能恢复,疑点未处理或已删除,请刷新数据后重新操作！");
                    return false;
                }
                top.$.messager.confirm('确认', '确认恢复疑点吗?', function (flag) {
                    if (flag) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/operate/doubtExt/doubtIn.action",
                            type: "post",
                            data: {'audDoubt.doubt_id': doubt_id, 'audDoubt.doubt_status': '010'},
                            success: function () {
                                showMessage1('恢复成功！');
                                window.location.reload();
                            }
                        });
                    }
                });
            } else {
                $.messager.show({title: '提示信息', msg: '请选择一条记录!'});
            }
        } else {
            $.messager.show({title: '提示信息', msg: '请选择一条记录!'});
        }
    }

    function viewManu(id) {
        var width = ($(window).width() - 1200) * 0.5;
        var height = ($(window).height() - 550) * 0.2;
        var myurl = "${pageContext.request.contextPath}/operate/manu/viewAll.action?view=${param.view}&crudId=" + id;
        parent.addTab("tabs", "查看关联底稿", "manuViewTab", myurl, false);
        //$('#veiwManu').window("open").window("resize",{width:1200,height:550,left:width,top:height}).window("refresh",myurl);
    }
</script>
</body>
</html>