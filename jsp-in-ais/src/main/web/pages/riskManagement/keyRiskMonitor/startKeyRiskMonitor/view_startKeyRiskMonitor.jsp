<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
    <title>查看重点风险事项监控填报任务</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>

</head>
<body>

<div data-options="region:'center',split:true">
    <table id="audBookTable" cellpadding=1 cellspacing=1 border=0 class="ListTable">
        <tr>
            <td class="EditHead">编号</td>
            <td class="editTd">
                <s:property value="keyRiskMonitor.start_code"/>
            </td>
            <td class="EditHead"> 所属年度</td>
            <td class="editTd">
                <s:property value="keyRiskMonitor.year"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead">专项填报任务</td>
            <td class="editTd">
                <s:property value="keyRiskMonitor.start_name"/>
            </td>
            <td class="EditHead">任务类型</td>
            <td class="editTd">
                <s:property value="keyRiskMonitor.taskType"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead" >填报要求说明</td>
            <td class="editTd" colspan="3">
                   <textarea class='noborder' readonly="readonly"
                                      rows="8" style="width:100%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${keyRiskMonitor.tbyqsm}</textarea>
            </td>
        </tr>
        <tr>
            <td class="EditHead" style="width: 15%">填报开始时间</td>
            <td class="editTd">
                <s:property value="keyRiskMonitor.start_time"/>
            </td>
            <td class="EditHead" style="width: 15%"> 填报截止时间</td>
            <td class="editTd">
                <s:property value="keyRiskMonitor.end_time"/>
            </td>
        </tr>
<%--        <tr>
            <td class="EditHead">填报单位</td>
            <td class="editTd" colspan="3">
                <s:property value="keyRiskMonitor.dutyDeptName"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead">填报人</td>
            <td class="editTd" colspan="3">
                <s:property value="keyRiskMonitor.applicant_name"/>
            </td>

        </tr>--%>
        <tr>
            <s:hidden name="keyRiskMonitor.file_id"/>
            <td class="EditHead" style="width:15%;">填报文件要求格式</td>
            <td class="editTd" colspan="3">
                <div id="head_${keyRiskMonitor.file_id}" style="float: left"></div>
            </td>
        </tr>
    </table>
</div>
<div border="0" style="overflow: auto;height: 70%;">
    <table id='sDTable' title="填报明细"></table>
</div>

<div id="deblockDiv" title="驳回" style='overflow:hidden;padding:0px;display: none'>
        <input type="hidden" id="deFormId">
        <table class="ListTable" align="center" >
            <tr>
                <td class="EditHead">
                    <font color="red">*</font>驳回原因
                </td>
                <td class="editTd">
                    <textarea id="reason" style="height: 80px;width: 99%;" class="noborder"></textarea>
                </td>
            </tr>
        </table>
    <br>
    <div style='text-align:center;'>
        <a  id='sureId'  class="easyui-linkbutton"  iconCls="icon-ok">确定</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a  id='closeId' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>
    </div>
</div>
</body>

<script type="text/javascript">
    $(function(){
        $('#deblockDiv').window({
            width:450,
            height:180,
            modal:true,
            collapsible:false,
            maximizable:false,
            minimizable:false,
            closed:true
        });

        $('#sureId').click(function () {
            deblocking();
        });

        $('#closeId').click(function(){
            $('#deblockDiv').window('close');
        });
    });
    $("#").find("textarea").each(function(){
        autoTextarea(this);
    });

    function viewInfo(url){
        window.location.href=url;
    }
    function view(url) {
        aud$openNewTab('查看', url, true);
    }
    function findFile() {
        var rows=$('#sDTable').datagrid("getRows");
        if(rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                var dfile_id = rows[i].dfile_id;
                var fileListDiv = "head_" + dfile_id;
                $('#' + fileListDiv).fileUpload({
                    fileGuid: dfile_id,
                    isDel: false,
                    isEdit: false,
                    isAdd: false,
                    uploadFace: 1,
                    echoType: 2
                });
            }
        }
    }

    function openWindow(formId) {
        $('#deblockDiv').show();
        $('#deFormId').val(formId);
        $('#reason').val('');
        $('#deblockDiv').window('open');
    }

    function deblocking() {
        var formId = $('#deFormId').val();
        var reason = $('#reason').val();
        if(reason == '') {
            showMessage1("请填写驳回原因！");
            ('#reason').focus();
        } else {
            if(reason.length > 1000) {
                showMessage1("长度不超过1000个字符！");
                ('#reason').focus();
            } else {
                $.ajax({
                    url:'${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/deblocking.action',
                    type:'post',
                    async:false,
                    data:{'formId':formId,'type':'12','reason':reason},
                    success:function(data) {
                        if(data == '1') {
                            showMessage1('驳回成功');
                            $('#deblockDiv').window('close');
                            $('#sDTable').datagrid('reload');
                            var activeTabId = '${activeTabId}';
                            var frameWin = aud$getTabIframByTabId(activeTabId);
                            if (frameWin){
                                frameWin.refresh();
                            }
                        }
                    }
                });
            }
        }
    }
    var datagrid;
    $(function(){
        showWin('dlgSearch');
        $('#sDTable').datagrid({
            url:"<%=request.getContextPath()%>/riskManagement/keyRiskMonitor/startKeyRiskMonitor/getReportKeyRiskIndexList.action?querySource=grid&startFormId=${keyRiskMonitor.formId }",
            method:'post',
            showFooter:false,
            rownumbers:true,
            singleSelect:true,
            pagination:true,
            striped:true,
            autoRowHeight:true,
            fit: true,
            pageSize: 20,
            fitColumns:true,
            idField:'id',
            border:false,
            remoteSort: false,
            columns:[[
                {field:'dutyDeptName',title:'填报单位', width:'10%',align:'left',halign:'center'},
                /*{field:'applicant_fdepname',title:'填报人所在单位', width:'12%',align:'left',halign:'center'},*/
                {field:'applicant_name',title:'填报人', width:'10%',align:'left',halign:'center'},
                {field:'status_name',title:'填报状态',width:'8%',align:'center'},
                {field:'dfile_id',title:'填报文件',width:'15%',align:'center',
                    formatter:function(value, rowData, rowIndex) {
                        var c = "<div  id=\"head_"+rowIndex+"\" ></div>";
                        return c;
                    },},
                {field:'tbsm',title:'填报说明',width:'20%',align:'left',halign:'center'},
                {field:'tb_time',title:'填报时间',width:'10%',align:'center',
                    formatter:function(value,rowData,rowIndex) {
                        window.setTimeout(function () {
                            initFileUploadPlug('head_', rowIndex, rowData['dfile_id'], 'monitor');
                            $('#datagrid-row-r1-1-' + rowIndex).height($('#datagrid-row-r1-2-' + rowIndex).height());
                        }, 50);

                        if(value != null && typeof(value) != 'undefined') {
                            return value.substring(0,10);
                        }
                    }
                },
                <s:if test="${isView != 'y'}">
                {field:'operation',title:'操作', width:'10%',align:'center', sortable:true,
                    formatter:function(value,rowData,rowIndex){
                        var viewUrl='${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/viewrepo.action?formId=' + rowData.formId + '&isView=Y';
                        var url;
                        if('${keyRiskMonitor.formId}' == rowData.startFormId) {
                            url= '<a href=\'#\' onclick="view(\'' + viewUrl + '\')">查看</a>';
                            if(rowData.status == '030') {
                                url += ' <a href="#" onclick="openWindow(\''+rowData.formId+'\')">驳回</a>';
                            }
                        } else {
                            url= '<a href=\'#\' onclick="view(\'' + viewUrl + '\')">关联查看</a>'
                        }
                        return url;
                    }
                }
                </s:if>
            ]],
            onLoadSuccess:function() {
               // findFile();
            }
        });
        $('#head'+"_${keyRiskMonitor.file_id}").fileUpload({
            fileGuid:'${keyRiskMonitor.file_id}' == ''?'-1':'${keyRiskMonitor.file_id}',
            echoType:2,
            isDel:false,
            isEdit:false,
            uploadFace:1,
            triggerId:'content'+'_${keyRiskMonitor.file_id}'
        });

        //初始化上传文件控件
        function initFileUploadPlug(prefix,index, attachmentId,triggerPrefix){
            $('#' + prefix + index).fileUpload({
                fileGuid: attachmentId,
                /*
                   文件上传后，回显方式选择， 默认：1
                1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
                2：以文件名列表形式展示，一个文件名称就是一行
                3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
                */
                echoType: 2,
                // 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
                isDel: false,
                isAdd:false,
                isEdit: false
            });
        }

    })


</script>
</html>
