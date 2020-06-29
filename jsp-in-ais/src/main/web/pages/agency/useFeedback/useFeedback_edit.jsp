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
    <link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css"/>
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
            z-index: 200;
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
						<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveUseFeedbackBut()">保存</a>
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="submitUseFeedbackBut()">提交</a>
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
                    <s:hidden name="useFeedback.point" id="point"/>
                    <s:hidden name="useFeedback.submitMsg"/>
                    <s:hidden name="parentTabId" id="parentTabId"/>
                    <tr>
                        <td class="EditHead" style="width:180px;">
                            <font color="red">*</font>
                            中介机构分类
                        </td>
                        <td class="editTd">
                            <select id="agencyType" class="easyui-combobox" data-options="panelHeight:'auto'" name="useFeedback.agencyType" style="width:  150px;" editable="false">
                                <s:iterator value="basicUtil.agencyTypeList" id="entry">
                                    <s:if test="${useFeedback.agencyType==code}">
                                        <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="code"/>"><s:property value="name"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                        </td>
                        <td class="EditHead" style="width: 180px">统一社会信用代码</td>
                        <td class="editTd">
                            <s:textarea cssClass="noborder" id="reNum" name="useFeedback.registrationNum" readonly="true" cssStyle="border:0;width:160px;height:20px;overflow-y:visible"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead"><font color="red">*</font>中介机构名称</td>
                        <td class="editTd">
                            <s:buttonText2 id="agencyName" hiddenId="maintainFormId" cssClass="noborder"
                                           name="useFeedback.agencyName"
                                           hiddenName="useFeedback.maintainFormId"
                                           doubleOnclick="onAgencyNameClick(this)"
                                           cssStyle="width: 80%"
                                           doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                           doubleCssStyle="cursor:pointer;border:0"
                                           readonly="true"
                                           title="中介机构名称" maxlength="500"/>
                        </td>
                        <td class="EditHead"><font color="red">*</font>服务企业</td>
                        <td class="editTd">
                            <s:textfield cssClass="noborder" name="useFeedback.serviceEnterpriseName" id="serviceEnterpriseName" cssStyle="width:150px" readonly="true" maxlength="100"/>
                            <input type="hidden" id="serviceEnterprise" name="useFeedback.serviceEnterprise" value="<s:property value='useFeedback.serviceEnterprise'/>">
                            <img style="cursor:pointer;border:0" src="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" onclick="onServiceEnterpriseNameClick(this)"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead"><font color="red">*</font>项目名称</td>
                        <td class="editTd">
                            <s:buttonText2 id="projectName"
                                           hiddenId="projectId"
                                           name="useFeedback.projectName"
                                           hiddenName="useFeedback.projectId"
                                           doubleOnclick="onProjectNameClick(this)"
                                           doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                           doubleCssStyle="cursor:pointer;border:0"
                                           cssClass="noborder"
                                           cssStyle="width: 80%"
                                           readonly="true"
                                           title="项目名称" maxlength="500"/>

                        </td>
                        <td class="EditHead">年度</td>
                        <td class="editTd">
                            <s:textfield name="useFeedback.year" cssClass="noborder" readonly="true" id="year" maxlength="200" title="年度"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead"><font color="red">*</font>合同金额（万元）</td>
                        <td class="editTd">
                            <input id="contractMoney" name="useFeedback.contractMoney" class="easyui-numberbox" value="${useFeedback.contractMoney}" data-options="precision:2,groupSeparator:','">
                        </td>
                        <td class="EditHead"><font color="red">*</font>中介机构的选取方式</td>
                        <td class="editTd">
                            <select id="agencySelection" class="easyui-combobox" data-options="panelHeight:'auto'" name="useFeedback.agencySelection" style="width:  150px;" editable="false">
                                <option value="">&nbsp;</option>
                                <s:iterator value="basicUtil.agencySelectionList" id="entry">
                                    <s:if test="${useFeedback.agencySelection==code}">
                                        <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="code"/>"><s:property value="name"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead"> 现场工作时间（计划）</td>
                        <td class="editTd">
                            <input type="text" id="scenePlanStart" value="${useFeedback.scenePlanStart }" name="useFeedback.scenePlanStart" class="easyui-datebox" editable="false" style="width: 150px"> &nbsp;&nbsp; -- &nbsp;&nbsp;
                            <input type="text" id="scenePlanEnd" value="${useFeedback.scenePlanEnd }" name="useFeedback.scenePlanEnd" class="easyui-datebox" editable="false" style="width: 150px">
                        </td>
                        <td class="EditHead"> 现场工作时间（实际）</td>
                        <td class="editTd">
                            <input type="text" id="sceneActualStart" value="${useFeedback.sceneActualStart }" name="useFeedback.sceneActualStart" class="easyui-datebox" editable="false" style="width: 150px"> &nbsp;&nbsp; -- &nbsp;&nbsp;
                            <input type="text" id="sceneActualEnd" value="${useFeedback.sceneActualEnd }" name="useFeedback.sceneActualEnd" class="easyui-datebox" editable="false" style="width: 150px">
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead"> 成果具体时间（计划）</td>
                        <td class="editTd">
                            <input type="text" id="achievementsPlanStart" value="${useFeedback.achievementsPlanStart }"
                                   name="useFeedback.achievementsPlanStart" class="easyui-datebox" editable="false" style="width: 150px"> &nbsp;&nbsp; -- &nbsp;&nbsp;
                            <input type="text" id="achievementsPlanEnd" value="${useFeedback.achievementsPlanEnd }"
                                   name="useFeedback.achievementsPlanEnd" class="easyui-datebox" editable="false" style="width: 150px">
                        </td>
                        <td class="EditHead"> 成果具体时间（实际）</td>
                        <td class="editTd">
                            <input type="text" id="achievementsActualStart" value="${useFeedback.achievementsActualStart }"
                                   name="useFeedback.achievementsActualStart" class="easyui-datebox" editable="false" style="width: 150px"> &nbsp;&nbsp; -- &nbsp;&nbsp;
                            <input type="text" id="achievementsActualEnd" value="${useFeedback.achievementsActualEnd}"
                                   name="useFeedback.achievementsActualEnd" class="easyui-datebox" editable="false" style="width: 150px">
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">
                            服务内容
                            <div><font color="#a9a9a9">(1000字以内) </font></div>
                        </td>
                        <td class="editTd" colspan="3">
                            <s:textarea id="serviceContent" name="useFeedback.serviceContent" cssClass="noborder" title="服务内容" cssStyle="width:99%;height:100px;overflow-y:visible;line-height:150%;"/>
                            <input type="hidden" id="useFeedback.serviceContent.maxlength" value="1000"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">录入时间</td>
                        <td class="editTd">
                            <s:property value="useFeedback.createTime"/>
                        </td>
                        <td class="EditHead">录入人</td>
                        <td class="editTd">
                            <s:property value="useFeedback.createrName"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="EditHead">录入人所在单位或部门</td>
                        <td class="editTd">
                            <s:property value="useFeedback.createAudit_dept_name"/>
                        </td>
                        <td class="EditHead"></td>
                        <td class="editTd"></td>
                    </tr>
                </table>
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

    function setNull() {
        var contractMoney = document.getElementById("contractMoney").value;
        if (contractMoney == '0.0') {
            document.getElementById("contractMoney").value = "";
        }
    }

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
            singleSelect: true,
            fitColumns: true,
            rownumbers: false,
            showFooter: true,
            onLoadSuccess: heji,
            onClickRow: onClickRow,
            columns: [[
                {field: 'orderNumber', halign: 'center', align: 'center', width: bodyW * 0.08 + 'px', title: '序号'},
                {field: 'score', halign: 'center', align: 'left', width: bodyW * 0.2 + 'px', title: '评分项'},
                {field: 'describe', halign: 'center', align: 'left', width: bodyW * 0.2 + 'px', title: '评分标准说明'},
                {field: 'fullMarks', halign: 'center', align: 'center', width: bodyW * 0.1 + 'px', title: '评分项满分分值'},
                {field: 'mark', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center', editor: {
                    type: 'numberbox',
                    options: {
                        precision: 1,
                        min: 0,
                        missingMessage: '0-满分分值',
                        inputEvents: {
                            blur: function (e) {
                                var tg = e.data.target;
                                $(tg).numberbox('setValue', $(tg).numberbox('getText'));
                            }
                        }
                    }},
                    title: '评分'
                },
                {field: 'useRemarks', halign: 'center', align: 'left', width: bodyW * 0.2 + 'px', editor: 'textarea', title: '备注'}
            ]]
        }).datagrid('doCellTip', {
            onlyShowInterrupt: 'true',
            position: 'bottom',
            maxWidth: '150px',
            tipStyler: {
                'backgroundColor': '#EFF5FF',
                borderColor: '#95B8E7',
                boxShadow: '1px 1px 3px #292929'
            }
        });
    });

    // 带出统一社会信用代码
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

    function resetUpdateyear() {
        var projectId = document.getElementById("projectId").value;
        if (projectId != null && projectId != "") {
            $.ajax({
                url: '<%=request.getContextPath()%>/agency/useFeedback/getYearByFormId.action',
                async: false,
                type: 'POST',
                data: {'projectId': projectId},
                success: function (data) {
                    document.getElementById("year").value = data.year;
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
                if (typeof(rows[i].mark) == 'number') {
                    k += rows[i].mark;
                }
                if (typeof(rows[i].mark) == 'string') {
                    var score = ((rows[i].mark) * 1);
                    k += score;
                }
                if (typeof(rows[i].fullMarks) == 'number') {
                    full += rows[i].fullMarks;
                }
                if (typeof(rows[i].fullMarks) == 'string') {
                    var fm = ((rows[i].fullMarks) * 1);
                    full += fm;
                }
            }
        }
        full = (full * 10).toFixed() / 10;
        k = (k * 10).toFixed() / 10;

        document.getElementById("point").value = k;
        $('#dg').datagrid('reloadFooter', [{orderNumber: '合计', fullMarks: full, mark: k}]);
        $('#dg').datagrid('reloadFooter');
        return f;
    }

    /* 返回 */
    function backUseFeedback() {
        window.location.href = "<%=request.getContextPath()%>/agency/useFeedback/getUseFeedbackList.action"
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

    function closeUseFeedback() {

        $.messager.confirm('提示信息', '确认放弃当前编辑？', function (is) {
            if (is) {
                var parentTabId = document.getElementById("parentTabId").value;
                var tabId = aud$getActiveTabId();
                var frameWin = aud$getTabIframByTabId(parentTabId);
                if (frameWin) {
                    frameWin.$("#mytable").datagrid('reload');
                }
                aud$closeTab(tabId, parentTabId)
            }
        });

    }

    // 中介机构名称参照
    function onAgencyNameClick(target) {
        showSysTree(
            target,
            {
                url: '${pageContext.request.contextPath}/agency/maintain/getMaintainByType.action',
                param: {
                    'partType': $('#agencyType').combobox('getValues'),
                },
                cache: false,
                checkbox: false,
                title: '请选择中介机构名称',
                onAfterSure: function () {
                    resetGsdjh();
                    $('#projectName').val('');
                    $('#projectId').val('');
                }
            }
        );
    }

    // 服务企业参照
    function onServiceEnterpriseNameClick(target) {
        showSysTree(
            target,
            {
                url: '${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                param: {
                    'p_item': 1,
                    'orgtype': 1
                },
                cache: false,
                checkbox: false,
                title: '请选择服务企业',
                defaultDeptId: '1',
                onAfterSure: function() {
                    $('#projectName').val('');
                    $('#projectId').val('');
                }
            }
        );
    }

    // 项目名称参照
    function onProjectNameClick(target) {
        var agencyId = $('#maintainFormId').val();
        var serviceEnterprise = $('#serviceEnterprise').val();

        if (agencyId == null || agencyId == '') {
            showMessage1('请选择中介机构名称！');
            return;
        }
        if (serviceEnterprise == null || serviceEnterprise == '') {
            showMessage1('请选择服务企业！');
            return;
        }

        showSysTree(
            target,
            {
                url: '${pageContext.request.contextPath}/agency/maintain/getClosedProject.action',
                param: {
                    <%--'userFdepid': '${user.fdepid }',--%>
                    'agencyId': agencyId,
                    'audit_dept': serviceEnterprise
                },
                cache: false,
                checkbox: false,
                title: '请选择项目名称',
                onAfterSure: resetUpdateyear
            }
        );
    }

    // 保存
    function saveUseFeedbackBut() {
        if (!checkUseFeedback()) {
            return false;
        }
        var saveuseFeedback = document.getElementById("saveUseFeedback");
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

    // 保存校验
    function checkUseFeedback() {
        endEditing();
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
        var maintainFormId = document.getElementById("maintainFormId").value;// 中介机构名称
        var flag = "0";
        $.ajax({
            url: '<%=request.getContextPath()%>/agency/useFeedback/checkAgencyAndNameSame.action',
            async: false,
            type: 'POST',
            data: {'maintainFormId': maintainFormId},
            success: function (data) {
                if (data.type != agencyType) {
                    top.$.messager.show({
                        title: '提示消息',
                        msg: '所选“中介机构名称”不是当前“中介机构分类”下的中介机构！',
                        timeout: 5000,
                        showType: 'slide'
                    });
                    flag = "1";
                }
            }
        });
        if (flag == '1') {
            return false;
        }
        var serviceEnterprise = document.getElementById("serviceEnterprise").value;// 服务企业
        if (serviceEnterprise == null || serviceEnterprise == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '服务企业不能为空！',
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

        var year = document.getElementById("year").value;//
        if (year == null || year == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '年度不能为空！',
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

        var contractMoney = document.getElementById("contractMoney").value;
        if (contractMoney == null || contractMoney == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '合同金额不能为空！',
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

        var rows = $('#dg').datagrid('getRows');
        for(var i = 0; i < rows.length; i++) {
            if(rows[i].mark == null || rows[i].mark == '') {
                showMessage1("第" + (i + 1) + "行打分不能为空！");
                onClickRow(i);
                return false;
            } else if(rows[i].mark * 1 > rows[i].fullMarks * 1) {
                showMessage1("第" + (i + 1) + "行打分不能超过评分项满分分值！");
                onClickRow(i);
                return false;
            }
        }
        return true;
    }

    // 校验两个日期大小顺序
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
                $('#dg').datagrid('selectRow', index).datagrid('beginEdit', index);
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
<script>
    //解决numberbox不能输入小数点的bug
    (function ($) {
        $.fn.numberbox.defaults.filter = function (e) {
            var opts = $(this).numberbox('options');
            var s = $(this).numberbox('getText');
            if (e.which == 45) {    //-
                return (s.indexOf('-') == -1 ? true : false);
            }
            var c = String.fromCharCode(e.which);
            if (c == opts.decimalSeparator) {
                return (s.indexOf(c) == -1 ? true : false);
            } else if (c == opts.groupSeparator) {
                return true;
            } else if ((e.which >= 48 && e.which <= 57 && e.ctrlKey == false && e.shiftKey == false) || e.which == 0 || e.which == 8) {
                return true;
            } else if (e.ctrlKey == true && (e.which == 99 || e.which == 118)) {
                return true;
            } else {
                return false;
            }
        }
    })(jQuery);
</script>
</html>
	