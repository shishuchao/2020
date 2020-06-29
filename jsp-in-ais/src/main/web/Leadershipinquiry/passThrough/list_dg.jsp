<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>底稿穿透页面</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
<div id="dlgSearch" class="searchWindow">
    <div class="search_head">
        <s:form id="searchForm" name="searchForm" action="dgCountByFwAndNd" namespace="/Leadershipinquiry" method="post">
            <s:token/>
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
                <tr >
                    <td class="EditHead">
                        项目名称
                    </td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:160px;" id="fname" name="project_name"  />
                    </td>
                    <td class="EditHead">底稿名称</td>
                    <td class="editTd">
                        <s:textfield cssClass="noborder" cssStyle="width:160px;"  name="problem_title"  />
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

<div region="center" border='0'>
    <table id="yearList"></table>
</div>
<script type="text/javascript">

    function doSearch(){
        $('#yearList').datagrid({
            queryParams:form2Json('searchForm')
        });
        $('#dlgSearch').dialog('close');
    }
    /*
    * 取消
    */
    function doCancel(){
        $('#dlgSearch').dialog('close');
    }
    /**
     重置
     */
    function restal(){
        resetForm('searchForm');
        // doSearch();
    }
    function freshGrid() {
        $('#dlgSearch').dialog('open');
    }

    function planName(id, w_plan_name) {
        var viewUrl = "${contextPath}/plan/year/viewBU.action?selectedTab=yearDetailListDiv&crudId=" + id;
        aud$openNewTab(w_plan_name, viewUrl, false);
    }

    function planNameSyOff(title, id, startId, processCode) {
        //var url = "${contextPath}/plan/detail/view.action?crudId=" + id;
        var url = "${contextPath}/plan/detail/viewProcess.action?projectId=" + id + "&startId=" + startId + "&processCode=" + processCode;
        aud$openNewTab("离线-" + title, url, true);
    }

    function go2(doubt_id) {
        var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id=" + doubt_id;
        parent.addTab("tabs", "审计疑点查看", "doubtViewTab", myurl, false);
    }

    function goProjectMenu(projectid, prepare_closed, actualize_closed, report_closed, archives_closed, planProcess) {
        var stage = "";
        if (planProcess == 'simplified') {
            stage = 'simplified';
        } else {
            if (prepare_closed && prepare_closed == '0') {
                stage = "prepare";
            } else if (actualize_closed && actualize_closed == '0') {
                stage = "actualize";
            } else if (report_closed && report_closed == '0') {
                stage = "report";
            } else if (archives_closed && archives_closed == '0') {
                stage = "archives";
            } else {
                stage = "prepare";
            }
        }
        var isMyProject = null;
        jQuery.ajax({
            url: '${contextPath}/project/prepare/isMyProject.action',
            type: 'POST',
            data: {"crudId": projectid},
            dataType: 'json',
            async: 'false',
            success: function (data) {
                var udswin = window.open(
                    '${contextPath}/project/prepare/projectIndex.action?crudId='
                    + projectid + '&stage=' + stage + '&source=view&projectview=view&isView=2&view=view', '',
                    'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
                udswin.moveTo(0, 0);
                udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
            },
            error: function () {
            }
        });
    }

    $(function () {
        var bodyW = $('body').width();
        //查询
        showWin('dlgSearch');
        loadSelectH();
        // 初始化生成表格
        $('#yearList').datagrid({
            url: "<%=request.getContextPath()%>/Leadershipinquiry/dgCountByFwAndNd.action?querySource=grid&proyear=${param.proyear}&sjdw=${param.sjdw}&t=" + new Date().getTime(),
            method: 'post',
            showFooter: false,
            rownumbers: true,
            pagination: true,
            striped: true,
            autoRowHeight: false,
            fit: true,
            pageSize: 20,
            fitColumns: true,
            idField: 'formId',
            border: false,
            singleSelect: true,
            remoteSort: true,
            toolbar:[{
                id:'search',
                text:'查询',
                iconCls:'icon-search',
                handler:function(){
                    searchWindShow('dlgSearch',750);
                }
            }
            ],
            onLoadSuccess: function () {
                initHelpBtn();
            },
            frozenColumns: [[
                {
                    field: 'project_name', title: '项目名称', halign: 'center', width: 300, sortable: true, align: 'left',
                },
                {
                    field: 'ms_name', title: '底稿名称', halign: 'center', width: 300, sortable: true, align: 'left',
                },
                {
                    field: 'ms_status',
                    title: '底稿状态',
                    halign: 'center',
                    width: 80,
                    sortable: true,
                    align: 'center',
                    formatter: function (value,rowData,rowIndex) {
                        if(rowData.ms_status == '010'){
                            return '底稿草稿';
                        }
                        else if(rowData.ms_status == '020'){
                            return '正在征求';
                        }
                        else if(rowData.ms_status == '030'){
                            return '等待复核';
                        }
                        else if(rowData.ms_status == '040'){
                            return '正在复核';
                        }
                        else if(rowData.ms_status == '050'){
                            return '复核完毕';
                        }
                        else return '已经注销';
                    }
                }
            ]],
            columns: [[
                {field: 'task_name', title: '审计事项', halign: 'center', width: 270, sortable: true, align: 'left'},
                {field: 'ms_author_name', title: '撰写人', halign: 'center', width: 70, sortable: true, align: 'center'},
                {field: 'prom', title: '问题', halign: 'center', width: 50, sortable: true, align: 'center'},
                {
                    field: 'audit_found', title: '关联疑点', halign: 'center', width: 100, sortable: true, align: 'center',
                    formatter: function (value, row, rowIndex) {
                        var audit_found = row.audit_found;
                        if (null != audit_found) {
                            var manuId = audit_found.split(',');
                            return "<a href=\"javascript:void(0)\" onclick=\"go2('" + manuId[0] + "')\">" + manuId[1] + "</a>"
                        } else {
                            return "";
                        }
                    }
                },
                {
                    field: 'ms_date', title: '创建日期', halign: 'center', width: 100, sortable: true, align: 'center',
                    formatter:function (value,rowData,rowIndex) {
                        if(value!=null)
                            return value.substr(0,10);
                        else
                            return "";
                    }
                },
                {field: 'subms_date', title: '最后修改日期', halign: 'center', width: 100, sortable: true, align: 'center'},
                {
                    field: 'isSureUpload',
                    title: '是否上传签字底稿',
                    halign: 'center',
                    width: 130,
                    sortable: true,
                    align: 'center',
                    formatter: function (value, row, rowIndex) {
                        if (value == '1') {
                            return "已上传";
                        } else {
                            return "未上传";
                        }
                    },
                }
            ]]
        });
        //单元格tooltip提示
        $('#yearList').datagrid('doCellTip', {
            onlyShowInterrupt: true,
            position: 'bottom',
            maxWidth: '200px',
            tipStyler: {
                'backgroundColor': '#EFF5FF',
                borderColor: '#95B8E7',
                boxShadow: '1px 1px 3px #292929'
            }
        });
    });
</script>
</body>
</html>