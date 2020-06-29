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
<div>
    <s:form id="saveMaintain" action="saveMaintain" namespace="/agency/maintain">
        <div style="width: 100%;position:fixed;top:0;" id="div1" align="center">
            <s:hidden name="maintain.formId" id="formId"/>
            <table class="ListTable" align="center" style='width: 98.3%; padding: 0; margin: 0;'>
                <tr class="EditHead">
                    <td>
                        <span style='float: right; text-align: right;'>
                            <a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveMaintainBut()">保存</a>
                            <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeMaintain()">关闭</a>
                        </span>
                    </td>
                </tr>
            </table>
        </div>
        <div style="position: relative;" id="div2">
            <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%;margin-top: 40px;">
                <s:hidden name="parentTabId" id="parentTabId"/>
                <tr>
                    <td class="EditHead" width="15%">
                        <font color="red">*</font>
                        机构分类
                    </td>
                    <td class="editTd" width="30%">
                        <select id="agencyType" class="easyui-combobox" data-options="panelHeight:'auto'" name="maintain.agencyType" style="width:150px;" editable="false">
                            <option value="">&nbsp;</option>
                            <s:iterator value="basicUtil.agencyTypeList" id="entry">
                                <s:if test="${maintain.agencyType==code}">
                                    <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="code"/>"><s:property value="name"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </td>
                    <td class="EditHead" width="15%"><font color="red">*</font>机构名称</td>
                    <td class="editTd" width="30%">
                        <s:textfield name="maintain.agencyName" cssClass="noborder" id="agencyName" maxlength="200" title="中介机构名称"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead"><font color="red">*</font>统一社会信用代码</td>
                    <td class="editTd">
                        <s:textfield name="maintain.registrationNum" cssClass="noborder" id="registrationNum" maxlength="200" title="统一社会信用代码"/>
                    </td>
                    <td class="EditHead"><font color="red">*</font>是否经集团审核</td>
                    <td class="editTd">
                        <select editable="false" id="groupDesignated" class="easyui-combobox" name="maintain.groupDesignated" style="width:150px;" panelHeight="auto">
                            <option value="">&nbsp;</option>
                            <s:iterator value='#@java.util.LinkedHashMap@{"否":"否","是":"是"}' id="status">
                                <s:if test="${maintain.groupDesignated==key}">
                                    <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="key"/>"><s:property value="value"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">
                        机构英文简称
                    </td>
                    <td class="editTd">
                        <s:textfield name="maintain.agencyName_en" cssClass="noborder" id="agencyName_en" maxLength="200" title="机构英文简称"/>
                    </td>
                    <td class="EditHead">
                        纳税人分类
                    </td>
                    <td class="editTd">
                        <s:hidden id="taxpayerTypeName" name="maintain.taxpayerTypeName"/>
                        <select id="taxpayerType" class="easyui-combobox" data-options="panelHeight:'auto',onSelect:onTaxpayerTypeChanged" name="maintain.taxpayerType" style="width:150px;" editable="false">
                            <option value="">&nbsp;</option>
                            <s:iterator value="basicUtil.taxpayerTypeList" id="entry">
                                <s:if test="${maintain.taxpayerType==code}">
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
                    <td class="EditHead">
                        纳税人信用等级
                    </td>
                    <td class="editTd">
                        <s:hidden id="taxpayerLevelName" name="maintain.taxpayerLevelName"/>
                        <select id="taxpayerLevel" class="easyui-combobox" data-options="panelHeight:'auto',onSelect:onTaxpayerLevelChanged" name="maintain.taxpayerLevel" style="width:150px;" editable="false">
                            <option value="">&nbsp;</option>
                            <s:iterator value="basicUtil.taxpayerLevelList" id="entry">
                                <s:if test="${maintain.taxpayerLevel==code}">
                                    <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="code"/>"><s:property value="name"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </td>
                    <td class="EditHead">
                        纳税人信用等级所属年度
                    </td>
                    <td class="editTd">
                        <s:select list="@ais.framework.util.DateUtil@getIncrementYearList('${maintain.taxpayerLevelYear}',5,5)" cssClass="easyui-combobox" name="maintain.taxpayerLevelYear" id="taxpayerLevelYear"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">
                        企业性质
                    </td>
                    <td class="editTd">
                        <s:hidden id="companyTypeName" name="maintain.companyTypeName"/>
                        <select id="companyType" class="easyui-combobox" data-options="panelHeight:'auto',onSelect:onCompanyTypeChanged" name="maintain.companyType" style="width:150px;" editable="false">
                            <option value="">&nbsp;</option>
                            <s:iterator value="basicUtil.companyTypeList" id="entry">
                                <s:if test="${maintain.companyType==code}">
                                    <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="code"/>"><s:property value="name"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </td>
                    <td class="EditHead">
                        国家
                    </td>
                    <td class="editTd">
                        <s:textfield id="cityName" name="maintain.countryName" maxLength="100"/>
<%--                        <s:hidden id="countryName" name="maintain.countryName"/>--%>
<%--                        <select id="country" class="easyui-combobox" data-options="panelHeight:'auto',onSelect:onCountryChanged" name="maintain.country" style="width:150px;" editable="false">--%>
<%--                            <option value="">&nbsp;</option>--%>
<%--                            <s:iterator value="basicUtil.geoCountryList" id="entry">--%>
<%--                                <s:if test="${maintain.country==code}">--%>
<%--                                    <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>--%>
<%--                                </s:if>--%>
<%--                                <s:else>--%>
<%--                                    <option value="<s:property value="code"/>"><s:property value="name"/></option>--%>
<%--                                </s:else>--%>
<%--                            </s:iterator>--%>
<%--                        </select>--%>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">
                        省份
                    </td>
                    <td class="editTd">
                        <s:textfield id="cityName" name="maintain.provinceName" maxLength="100"/>
<%--                        <s:hidden id="provinceName" name="maintain.provinceName"/>--%>
<%--                        <select id="province" class="easyui-combobox" data-options="panelHeight:'auto',onSelect:onProvinceChanged" name="maintain.province" style="width:150px;" editable="false">--%>
<%--                            <option value="">&nbsp;</option>--%>
<%--                            <s:iterator value="basicUtil.getGeoProvinceList('${maintain.country}')" id="entry">--%>
<%--                                <s:if test="${maintain.province==code}">--%>
<%--                                    <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>--%>
<%--                                </s:if>--%>
<%--                                <s:else>--%>
<%--                                    <option value="<s:property value="code"/>"><s:property value="name"/></option>--%>
<%--                                </s:else>--%>
<%--                            </s:iterator>--%>
<%--                        </select>--%>
                    </td>
                    <td class="EditHead">
                        城市
                    </td>
                    <td class="editTd">
                        <s:textfield id="cityName" name="maintain.cityName" maxLength="100"/>
<%--                        <s:hidden id="cityName" name="maintain.cityName"/>--%>
<%--                        <select id="city" class="easyui-combobox" data-options="panelHeight:'auto',onSelect:onCityChanged" name="maintain.city" style="width:150px;" editable="false">--%>
<%--                            <option value="">&nbsp;</option>--%>
<%--                            <s:iterator value="basicUtil.getGeoProvinceList('${maintain.province}')" id="entry">--%>
<%--                                <s:if test="${maintain.city==code}">--%>
<%--                                    <option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>--%>
<%--                                </s:if>--%>
<%--                                <s:else>--%>
<%--                                    <option value="<s:property value="code"/>"><s:property value="name"/></option>--%>
<%--                                </s:else>--%>
<%--                            </s:iterator>--%>
<%--                        </select>--%>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">
                        注册地址
                    </td>
                    <td class="editTd">
                        <s:textfield id="address" name="maintain.address" cssClass="noborder" maxLength="500" />
                    </td>
                    <td class="EditHead">
                        成立日期
                    </td>
                    <td class="editTd">
                        <input id="setupDate" type="text" editable="false" class="easyui-datebox noborder" name="maintain.setupDate" title="单击选择日期" style="width:150px;" value="${maintain.setupDate}"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">是否独立法人</td>
                    <td class="editTd">
                        <select editable="false" class="easyui-combobox" name="maintain.isLegalPerson" style="width:150px;" panelHeight="auto">
                            <option value="">&nbsp;</option>
                            <s:iterator value='#@java.util.LinkedHashMap@{"否":"否","是":"是"}' id="status">
                                <s:if test="${maintain.isLegalPerson==key}">
                                    <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="key"/>"><s:property value="value"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </td>
                    <td class="EditHead">法定代表人/负责人</td>
                    <td class="editTd">
                        <s:textfield name="maintain.legalPerson" cssClass="noborder" id="legalPerson" maxlength="100" title="法定代表人/负责人"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">出资额或注册资本<br>（万元）</td>
                    <td class="editTd">
                        <input id="registeredCapital" style="width: 150px" name="maintain.registeredCapital" class="easyui-numberbox" value="${maintain.registeredCapital}" data-options="precision:2,groupSeparator:','">
                    </td>
                    <td class="EditHead">注册资金币种</td>
                    <td class="editTd">
                        <s:hidden id="registeredCurrencyName" name="maintain.registeredCurrencyName"/>
                        <select id="registeredCurrency" class="easyui-combobox" data-options="panelHeight:'auto',onSelect:onCurrencyChanged" name="maintain.registeredCurrency" style="width:150px;" editable="false">
                            <option value="">&nbsp;</option>
                            <s:iterator value="basicUtil.currencyTypeList" id="entry">
                                <s:if test="${maintain.registeredCurrency==code}">
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
                    <td class="EditHead">营业期限（起始）</td>
                    <td class="editTd">
                        <input id="businessDateBegin" type="text" editable="false" class="easyui-datebox noborder" name="maintain.businessDateBegin" title="单击选择日期" style="width:150px;" value="${maintain.businessDateBegin}"/>
                    </td>
                    <td class="EditHead">营业期限（终止）</td>
                    <td class="editTd">
                        <input id="businessDateEnd" type="text" editable="false" class="easyui-datebox noborder" name="maintain.businessDateEnd" title="单击选择日期" style="width:150px;" value="${maintain.businessDateEnd}"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">经营范围</td>
                    <td class="editTd" colspan="3">
                        <s:textarea id="businessScope" name="maintain.businessScope" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">
                        通讯地址
                    </td>
                    <td class="editTd" colspan="3">
                        <s:textarea id="contactsAddress" name="maintain.contactsAddress" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">联系人</td>
                    <td class="editTd">
                        <s:textfield name="maintain.contacts" cssClass="noborder" id="contacts" maxlength="100" title="联系人"/>
                    </td>
                    <td class="EditHead">联系电话</td>
                    <td class="editTd">
                        <s:textfield name="maintain.contactsNum" cssClass="noborder" id="contactsNum" maxlength="100" title="联系电话"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">
                        单位传真
                    </td>
                    <td class="editTd">
                        <s:textfield name="maintain.contactsFax" cssClass="noborder" id="contactsFax" maxlength="100" title="单位传真"/>
                    </td>
                    <td class="EditHead">证书编号</td>
                    <td class="editTd">
                        <s:textfield name="maintain.zsbh" cssClass="noborder" id="zsbh" maxlength="100" title="证书编号"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">注册人数（个）</td>
                    <td class="editTd" colspan="3">
                        <s:textfield name="maintain.zcrs" cssClass="noborder" id="zcrs" onblur="value=value.replace(/[^\d]/g,'')" onkeydown="value=value.replace(/[^\d]/g,'')" maxlength="5" title="注册人数"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(指注册会计师人数，或注册造价师人数，或注册资产评估师人数)
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">机构资质</td>
                    <td class="editTd" colspan="3">
                        <s:textarea id="jgzz" name="maintain.jgzz" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                        <input type="hidden" id="maintain.jgzz.maxlength" value="1000"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">综合评价等级
                    </td>
                    <td class="editTd" colspan="3">
                        <s:textarea id="evaluateGrade" name="maintain.evaluateGrade" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                        <input type="hidden" id="maintain.evaluateGrade.maxlength" value="1000"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">
                        在行业协会检查中不合格
                        <br>
                        或被要求整改情况
                    </td>
                    <td class="editTd" colspan="3">
                        <s:textarea id="rework" name="maintain.rework" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                        <input type="hidden" id="maintain.rework.maxlength" value="1000"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">近三年平均年营业收入
                    </td>
                    <td class="editTd" colspan="3">
                        <s:textarea id="business_income" name="maintain.business_income" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                        <input type="hidden" id="maintain.business_income.maxlength" value="1000"/>
                    </td>
                </tr>

                <tr>
                    <td class="EditHead">创建人</td>
                    <td class="editTd">
                        <s:property value="maintain.updatePersonName"/>
                    </td>
                    <td class="EditHead">创建人所在部门</td>
                    <td class="editTd">
                        <s:property value="maintain.createrDeptName"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">创建时间</td>
                    <td class="editTd">
                        <s:property value="maintain.createTime"/>
                    </td>
                    <td class="EditHead">最近更新人</td>
                    <td class="editTd">
                        <s:property value="maintain.updatePersonName"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead">最近更新人所在部门</td>
                    <td class="editTd">
                        <s:property value="maintain.updatePersonDeptName"/>
                    </td>
                    <td class="EditHead">最近更新时间</td>
                    <td class="editTd">
                        <s:property value="maintain.updateTime"/>
                    </td>
                </tr>

            </table>
        </div>
    </s:form>
</div>
</body>
<script type="text/javascript">
    $(function () {
        $("#saveMaintain").find("textarea").each(function () {
            autoTextarea(this);
        });
        // 通讯地址
        $('#contactsAddress').attr('maxlength', 500);
        //机构资质
        $('#jgzz').attr('maxlength', 1000);
        // 综合评价等级
        $('#evaluateGrade').attr('maxlength', 1000);
        // 在行业协会检查中不合格或被要求整改情况
        $('#rework').attr('maxlength', 1000);
        // 近三年来平均年营业收入
        $('#business_income').attr('maxlength', 1000);
        // 经营范围
        $('#businessScope').attr('maxlength', 2000);

        if ("${suc}" == '1') {
            top.$.messager.show({
                title: '提示消息',
                msg: "保存成功",
                timeout: 5000,
                showType: 'slide'
            });
        }
    });

    /* 返回 */
    function backMaintain() {
        window.location.href = "<%=request.getContextPath()%>/agency/maintain/getListMaintain.action"
    }

    /* 保存 */
    function saveMaintainBut() {
        // 机构分类
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
        // 中介机构名称
        var agencyName = document.getElementById("agencyName").value;
        if (agencyName == null || agencyName == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '中介机构名称不能为空！',
                timeout: 5000,
                showType: 'slide'
            });
            return false;
        }

        // 统一社会信用代码
        var registrationNum = document.getElementById("registrationNum").value;
        if (registrationNum == null || registrationNum == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '统一社会信用代码不能为空！',
                timeout: 5000,
                showType: 'slide'
            });
            return false;
        }
        if (!isSocialCreditCode(registrationNum)) {
            top.$.messager.show({
                title: '提示消息',
                msg: '统一社会信用代码无效！',
                tmeout: '5000',
                showType: 'slide'
            });
            return false;
        }
        if (!checkMaintainBut()) {
            top.$.messager.show({
                title: '提示消息',
                msg: '统一社会信用代码不能重复！',
                tmeout: '5000',
                showType: 'slide'
            });
            return false;
        }

        // 是否经集团审批
        var groupDesignated = $("#groupDesignated").combobox("getValues");
        if (groupDesignated == null || groupDesignated == "") {
            top.$.messager.show({
                title: '提示消息',
                msg: '是否集团指定不能为空！',
                tmeout: '5000',
                showType: 'slide'
            });
            return false;
        }

        var saveMaintain = document.getElementById("saveMaintain");
        saveMaintain.submit();
    }

    function isMobil(s) {
        var patrn = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
        if (!patrn.exec(s)) {
            return false
        }
        return true
    }

    function checkMaintainBut() {
        var formId = document.getElementById("formId").value;
        var registrationNum = document.getElementById("registrationNum").value;
        var flag = false;

        $.ajax({
            url: '<%=request.getContextPath()%>/agency/maintain/checkRegistrationNum.action?formId=' + formId + '&registrationNum=' + registrationNum,
            type: 'post',
            async: false,
            success: function (reV) {

                if (reV == 'suc') {
                    flag = true;
                }
            }
        });
        return flag;
    }

    function closeMaintain() {

        var parentTabId = document.getElementById("parentTabId").value;
        var tabId = aud$getActiveTabId();
        var frameWin = aud$getTabIframByTabId(parentTabId);
        if (frameWin) {
            frameWin.$("#mytable").datagrid('reload');
        }
        aud$closeTab(tabId, parentTabId)

    }

    // function onCountryChanged() {
    //     var country = $('#country').combobox('getValue');
    //     $('#countryName').val($('#country').combobox('getText'));
    //
    //     $('#provinceName').val('');
    //     $('#province').combobox('clear').combobox('loadData', {});
    //
    //     if (country) {
    //         $.ajax({
    //             url: '/ais/basic/codename/queryCodeNameList.action',
    //             data: {
    //                 type: '9050',
    //                 parentCode: $('#country').combobox('getValue')
    //             },
    //             success: function (data) {
    //                 if (data && data.length) {
    //                     var result = [];
    //                     result[0] = {value: "", text: " ", selected: true};
    //                     $.each(data, function (i, row) {
    //                         result[i + 1] = row;
    //                         row.value = row.code;
    //                         row.text = row.name;
    //                     });
    //
    //                     $('#province').combobox('loadData', result);
    //                 }
    //             }
    //         });
    //     }
    //
    //     $('#cityName').val('');
    //     $('#city').combobox('clear').combobox('loadData', {});
    // }
    //
    // function onProvinceChanged() {
    //     var province = $('#province').combobox('getValue');
    //     $('#provinceName').val($('#province').combobox('getText'));
    //
    //     $('#cityName').val('');
    //     $('#city').combobox('clear').combobox('loadData', {});
    //     if (province) {
    //         $.ajax({
    //             url: '/ais/basic/codename/queryCodeNameList.action',
    //             data: {
    //                 type: '9050',
    //                 parentCode: province
    //             },
    //             success: function (data) {
    //                 if (data && data.length) {
    //                     var result = [];
    //                     result[0] = {value: "", text: " ", selected: true};
    //                     $.each(data, function (i, row) {
    //                         result[i + 1] = row;
    //                         row.value = row.code;
    //                         row.text = row.name;
    //                     });
    //
    //                     $('#city').combobox('loadData', result);
    //                 }
    //             }
    //         });
    //     }
    // }
    //
    // function onCityChanged() {
    //     $('#cityName').val($('#city').combobox('getText'));
    // }

    function onCurrencyChanged() {
        $('#registeredCurrencyName').val($('#registeredCurrency').combobox('getText'));
    }

    function onCompanyTypeChanged() {
        $('#companyTypeName').val($('#companyType').combobox('getText'));
    }

    function onTaxpayerLevelChanged() {
        $('#taxpayerLevelName').val($('#taxpayerLevel').combobox('getText'));
    }

    function onTaxpayerTypeChanged() {
        $('#taxpayerTypeName').val($('#taxpayerType').combobox('getText'));
    }
</script>
</html>
	