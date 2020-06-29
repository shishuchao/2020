<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>项目列表-项目浏览页</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ufaudTextLengthValidator.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>

    <style type="text/css">
        #div1 {
            z-index: 2;
        }
        #div2 {
            z_index: 1;
        }
    </style>
</head>
<body style="margin: 0;padding: 0;overflow:auto;" class="easyui-layout">
<div fit="true" class='easyui-layout' region="center" border='0' style="overflow: auto; width: 100%;height: 100%;">
    <div region="center" border='0'>
        <div style="width: 100%;position:absolute;top:0px;" id="div1" align="center">
            <table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
                <tr class="EditHead">
                    <td>
						<span style='float: right; text-align: right;'>
 	                       <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeUseFeedback()">关闭</a>
						    </span>
                    </td>
                </tr>
            </table>
        </div>
        <div style="position: relative;" id="div2">
            <s:form id="saveUseFeedback" action="saveUseFeedback" namespace="/agency/useFeedback">

            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%;margin-top: 40px;">
                <s:hidden name="useFeedback.formId" id="formId"/>
                <s:hidden name="useFeedback.createTime"/>
                <s:hidden name="useFeedback.creater"/>
                <s:hidden name="useFeedback.createrName"/>
                <s:hidden name="useFeedback.createAudit_dept"/>
                <s:hidden name="useFeedback.createAudit_dept_name"/>
                <s:hidden name="useFeedback.serviceEnterprise" id="serviceEnterprise"/>
                <s:hidden name="useFeedback.point" id="point"/>
                <s:hidden name="useFeedback.submitMsg"/>
                <s:hidden name="parentTabId" id="parentTabId"/>
                <tr>
                    <td class="EditHead" style="width: 15%">中介机构分类</td>
                    <td class="editTd" style="width:35%">

                        <s:property value="useFeedback.agencyTypeName"/>
                    </td>
                    <td class="EditHead" style="width: 20%">中介机构名称</td>
                    <td class="editTd" style="width:30%">
                        <s:property value="useFeedback.agencyName"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width: 20%">统一社会信用代码</td>
                    <td class="editTd" style="width:30%">
                        <s:property value="useFeedback.registrationNum"/>
                    </td>
                    <td class="EditHead" style="width: 20%">服务企业</td>
                    <td class="editTd" style="width:30%">
                        <s:property value="useFeedback.serviceEnterpriseName"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width: 15%">项目名称</td>
                    <td class="editTd">
                        <s:property value="useFeedback.projectName"/>
                    </td>
                    <td class="EditHead" style="width: 15%"> 年度</td>
                    <td class="editTd" style="width:35%">
                        <s:property value="useFeedback.year"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width: 15%"> 合同金额（万元）</td>
                    <td class="editTd" style="width:35%">
                        <s:property value="%{formatMoneyWithSeparator(useFeedback.contractMoney)}"/>
                    </td>

                    <td class="EditHead" style="width: 20%">中介机构的选取方式</td>
                    <td class="editTd" style="width:30%">
                        <s:property value="useFeedback.agencySelectionName"/>
                    </td>

                </tr>
                <tr>
                    <td class="EditHead"> 现场工作时间（计划）
                    </td>
                    <td class="editTd">

                        <s:property value="useFeedback.scenePlanStart"/>
                        &nbsp;&nbsp; -- &nbsp;&nbsp;
                        <s:property value="useFeedback.scenePlanEnd"/>
                    </td>
                    <td class="EditHead"> 现场工作时间（实际）
                    </td>
                    <td class="editTd">
                        <s:property value="useFeedback.sceneActualStart"/>
                        &nbsp;&nbsp; -- &nbsp;&nbsp;
                        <s:property value="useFeedback.sceneActualEnd"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead"> 成果具体时间（计划）
                    </td>
                    <td class="editTd">
                        <s:property value="useFeedback.achievementsPlanStart"/>
                        &nbsp;&nbsp; -- &nbsp;&nbsp;
                        <s:property value="useFeedback.achievementsPlanEnd"/>
                    </td>

                    <td class="EditHead"> 成果具体时间（实际）
                    </td>
                    <td class="editTd">
                        <s:property value="useFeedback.achievementsActualStart"/>
                        &nbsp;&nbsp; -- &nbsp;&nbsp;
                        <s:property value="useFeedback.achievementsActualEnd"/>
                    </td>
                </tr>


                <tr>
                    <td class="EditHead"> 服务内容
                        <div></div>
                    </td>
                    <td class="editTd" colspan="3">
                        <s:textarea id="serviceContent" name="useFeedback.serviceContent" cssClass="noborder" readonly="readonly" cssStyle="width:99%;height:100px;overflow-y:visible;line-height:150%;"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead" style="width: 15%">录入时间</td>
                    <td class="editTd" style="width:35%">
                        <s:property value="useFeedback.createTime"/>
                    </td>

                    <td class="EditHead" style="width: 20%">录入人</td>
                    <td class="editTd" style="width:30%">
                        <s:property value="useFeedback.createrName"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width: 15%">录入人所在单位或部门</td>
                    <td class="editTd" style="width:35%">
                        <s:property value="useFeedback.createAudit_dept_name"/>
                    </td>
                    <td class="EditHead" style="width: 20%"></td>
                    <td class="editTd" style="width:30%">
                    </td>
                </tr>
            </table>
        </div>
        </s:form>
        <div cellpadding=0 cellspacing=0 border=0 region="center" style="margin:20px 0;margin-left:18px; width: 98%;">
            <table id="dg" class="easyui-datagrid" title="服务评价" style="height:auto;"></table>
        </div>
    </div>
</div>
</div>
</body>
<script type="text/javascript">
    var editIndex = undefined;
    $(function () {

        $('#serviceContent').attr('maxlength', 1000); //服务内容
        $("#saveUseFeedback").find("textarea").each(function () {
            autoTextarea(this);
        });

        if ("${reV}" == '1') {
            top.$.messager.show({
                title: '提示消息',
                msg: "保存成功！",
                timeout: 5000,
                showType: 'slide'
            });
        }

        var bodyW = $('body').width();
        $('#dg').datagrid({
            url: '<%=request.getContextPath()%>/agency/useFeedback/getUseScoringItemList.action?formId=${useFeedback.formId}',
            method: 'post',
            singleSelect: false,
            fitColumns: true,
            rownumbers: true,
            showFooter: true,
            onLoadSuccess: heji,
            onClickRow: onClickRow,
            columns: [[
                {field: 'orderNumber', halign: 'center', align: 'center', width: bodyW * 0.1 + 'px', title: '序号'},
                {field: 'score', halign: 'center', align: 'left', width: bodyW * 0.2 + 'px', title: '评分项'},
                {field: 'describe', halign: 'center', align: 'left', width: bodyW * 0.5 + 'px', title: '评分标准说明'},
                {field: 'fullMarks', halign: 'center', align: 'center', width: bodyW * 0.1 + 'px', title: '评分项满分分值'},
                {field: 'mark', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center', title: '评分'},
                {field: 'useRemarks', halign: 'center', align: 'left', width: bodyW * 0.3 + 'px', editor: 'text', title: '备注'}
            ]]
        }).datagrid('doCellTip', {
            position: 'bottom',
            maxWidth: '150px',
            tipStyler: {
                'backgroundColor': '#EFF5FF',
                borderColor: '#95B8E7',
                boxShadow: '1px 1px 3px #292929'
            }
        });
    });

    function resetGsdjh() {
        var maintainFormId = document.getElementById("maintainFormId").value;
        if (maintainFormId != null && maintainFormId != "") {
            $.ajax({
                url: '<%=request.getContextPath()%>/agency/maintain/getMaintainByFormId.action',
                async: false,
                type: 'POST',
                data: {'maintainFormId': maintainFormId},
                success: function (data) {
                    document.getElementById("reNum").value = data.registrationNum;
                }
            });
        }
    }

    /* 修改统计数据	 */
    function heji() {
        var f = true;
        var rows = $('#dg').datagrid('getRows');
        var k = 0.0;
        var full = 0.0;
        if (rows) {
            for (var i = 0; i < rows.length; i++) {

                if (typeof (rows[i].mark) == 'number') {
                    if (rows[i].mark != 0) {
                        if (rows[i].mark > rows[i].fullMarks) {
                            top.$.messager.show({
                                title: '提示消息',
                                msg: "第" + (i + 1) + '行评分要小于满分分值！',
                                titmeout: '5000',
                                showType: 'slide'
                            });
                            f = false;
                        } else {
                            k += rows[i].mark;
                        }
                    }
                }
                if (typeof (rows[i].mark) == 'string') {
                    var mark = ((rows[i].mark) * 1);
                    if (mark > rows[i].fullMarks) {
                        top.$.messager.show({
                            title: '提示消息',
                            msg: "第" + (i + 1) + '行评分要小于满分分值！',
                            titmeout: '5000',
                            showType: 'slide'
                        });
                        f = false;
                    } else {
                        k += mark;
                    }
                }


                if (typeof (rows[i].fullMarks) == 'number') {
                    full += rows[i].fullMarks;
                }
                if (typeof (rows[i].fullMarks) == 'string') {
                    var fm = ((rows[i].fullMarks) * 1);
                    full += rows[i].fullMarks;
                }

            }
        }
        document.getElementById("point").value = k;
        $('#dg').datagrid('reloadFooter', [{orderNumber: '合计', fullMarks: full, mark: k}]);
        $('#dg').datagrid('reloadFooter');
        return f;
    }

    /* 返回 */
    function backUseFeedback() {
        window.location.href = "<%=request.getContextPath()%>/agency/useFeedback/getUseFeedbackList.action"
    }

    function closeUseFeedback() {
        var parentTabId = document.getElementById("parentTabId").value;
        var tabId = aud$getActiveTabId();
        /*   		var frameWin = aud$getTabIframByTabId(parentTabId);
                if (frameWin){
                    frameWin.$("#mytable").datagrid('reload');
                } */
        aud$closeTab(tabId, parentTabId)
    }

    function submitUseFeedbackBut() {
        var saveuseFeedback = document.getElementById("saveUseFeedback");
        if (!checkUseFeedback()) {
            return false;
        }
        var rows = $("#dg").datagrid('getRows');
        var rowstr = JSON.stringify(rows);
        var useFeedbackFormId = document.getElementById("formId").value;
        $.ajax({
            url: '<%=request.getContextPath()%>/agency/useFeedback/saveUseScoringItemList.action',
            async: false,
            type: 'POST',
            data: {'rowstr': rowstr, useFeedbackFormId: useFeedbackFormId},
            success: function (data) {
                if (useFeedbackFormId == null || useFeedbackFormId == '') {
                    document.getElementById("formId").value = data
                }
                saveuseFeedback.action = "submitUseFeedback.action";
                saveuseFeedback.submit();
            }
        });
    }

    /* 保存 */
    function saveUseFeedbackBut() {
        var saveuseFeedback = document.getElementById("saveUseFeedback");
        if (!checkUseFeedback()) {
            return false;
        }
        var rows = $("#dg").datagrid('getRows');
        var rowstr = JSON.stringify(rows);
        var useFeedbackFormId = document.getElementById("formId").value;
        $.ajax({
            url: '<%=request.getContextPath()%>/agency/useFeedback/saveUseScoringItemList.action',
            async: false,
            type: 'POST',
            data: {'rowstr': rowstr, useFeedbackFormId: useFeedbackFormId},
            success: function (data) {
                if (useFeedbackFormId == null || useFeedbackFormId == '') {
                    document.getElementById("formId").value = data
                }
                saveuseFeedback.submit();
            }
        });
    }

    /**
     保存校验
     */
    function checkUseFeedback() {
        var agencyType = $("#agencyType").combobox("getValues");
        if (agencyType == null || agencyType == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '中介机构分类不能为空！',
                titmeout: '5000',
                showType: 'slide'
            });
            return false;
        }
        var agencyName = document.getElementById("agencyName").value;// 中介机构名称
        if (agencyName == null || agencyName == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '中介机构名称不能为空！',
                timeout: 5000,
                showType: 'slide'
            });
            return false;
        }


        var registrationNum = document.getElementById("reNum").value;// 工商編號
        if (registrationNum == null || registrationNum == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '工商登记号不能为空！',
                timeout: 5000,
                showType: 'slide'
            });
            return false;
        }
        var audit_dept_name = document.getElementById("audit_dept_name").value;// 工商編號
        if (audit_dept_name == null || audit_dept_name == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '使用单位不能为空！',
                timeout: 5000,
                showType: 'slide'
            });
            return false;
        }

        var projectName = document.getElementById("projectName").value;//
        if (projectName == null || projectName == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '项目名称不能为空！',
                timeout: 5000,
                showType: 'slide'
            });
            return false;
        }

        var year = $("#year").combobox("getValues");
        if (year == null || year == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '年度不能为空！',
                titmeout: '5000',
                showType: 'slide'
            });
            return false;
        }
        var quarter = $("#quarter").combobox("getValues");
        if (quarter == null || quarter == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '季度不能为空！',
                titmeout: '5000',
                showType: 'slide'
            });
            return false;
        }


        var agencySelection = $("#agencySelection").combobox("getValues");
        if (agencySelection == null || agencySelection == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '选取方式不能为空！',
                titmeout: '5000',
                showType: 'slide'
            });
            return false;
        }


        if (!validateDate('scenePlanStart', 'scenePlanEnd', '现场工作时间（计划）')) {
            return false;
        }
        if (!validateDate('sceneActualStart', 'sceneActualEnd', '现场工作时间（实际）')) {
            return false;
        }
        if (!validateDate('achievementsPlanStart', 'achievementsPlanEnd', '成果出具时间（计划）')) {
            return false;
        }
        if (!validateDate('achievementsActualStart', 'achievementsActualEnd', '成果出具时间（实际）')) {
            return false;
        }
        if (!heji()) {
            return false;
        }
        return true;
    }

    /* 	使用部门  确定 */
    function changSubmit() {
        var audit_dept = document.getElementById("audit_dept").value;
        if (audit_dept != null && audit_dept != "") {
            $.ajax({
                url: '<%=request.getContextPath()%>/systemnew/getOrgByDept.action',
                async: false,
                type: 'POST',
                data: {'audit_dept': audit_dept},
                success: function (data) {
                    document.getElementById("serviceEnterprise").value = data.id;
                    document.getElementById("serviceEnterpriseName").value = data.name;

                }
            });
        }

    }

    /*
    校验两个日期大小顺序
*/
    function validateDate(beginDateId, endDateId, msg) {
        var s1 = $('#' + beginDateId);
        var e1 = $('#' + endDateId);
        if (s1 && e1) {
            var s = s1.datebox('getValue');
            var e = e1.datebox('getValue');
            if (s != '' && e != '') {
                var s_date = new Date(s.replace("-", "/"));
                var e_date = new Date(e.replace("-", "/"));
                if (s_date.getTime() > e_date.getTime()) {
                    $.messager.alert("错误", msg + "开始必须小于等于结束!");
                    return false;
                }
            }
        }
        return true;
    }

    function saveScoringItem() {
        alert(1)

        return true;
    }


    function endEditing() {
        if (editIndex == undefined) {
            return true
        }
        if ($('#dg').datagrid('validateRow', editIndex)) {
            $('#dg').datagrid('endEdit', editIndex);
            editIndex = undefined;
            heji();
            return true;
        } else {
            return false;
        }
    }

    function onClickRow(index) {
        if (editIndex != index) {
            if (endEditing()) {
                $('#dg').datagrid('selectRow', index)
                    .datagrid('beginEdit', index);
                editIndex = index;
            } else {
                $('#dg').datagrid('selectRow', editIndex);
            }
        }
    }

    function accept() {
        if (endEditing()) {
            $('#dg').datagrid('acceptChanges');
        }
    }

    function reject() {
        $('#dg').datagrid('rejectChanges');
        editIndex = undefined;
    }

    function getChanges() {
        var rows = $('#dg').datagrid('getChanges');
        alert(rows.length + ' rows are changed!');
    }
</script>
</html>
	