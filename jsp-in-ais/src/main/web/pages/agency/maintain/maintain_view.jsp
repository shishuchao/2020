<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>中介机构基本信息</title>
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
</head>
<body style="margin: 0;padding: 0;overflow:auto;" class="easyui-layout">
<div>
    <s:form id="saveMaintain" action="saveMaintain" namespace="/agency/maintain">
        <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%;margin-top: 40px;">
            <s:hidden name="maintain.formId"/>
            <tr>
                <td class="EditHead" width="15%">
                    <font color="red">*</font>
                    机构分类
                </td>
                <td class="editTd" width="30%">
                    <s:property value="maintain.agencyTypeName"/>
                </td>
                <td class="EditHead" width="15%"><font color="red">*</font>机构名称</td>
                <td class="editTd" width="30%">
                    <s:property value="maintain.agencyName"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead"><font color="red">*</font>统一社会信用代码</td>
                <td class="editTd">
                    <s:property value="maintain.registrationNum"/>
                </td>
                <td class="EditHead"><font color="red">*</font>是否经集团审核</td>
                <td class="editTd">
                    <s:property value="maintain.groupDesignated"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">
                    机构英文简称
                </td>
                <td class="editTd">
                    <s:property value="maintain.agencyName_en"/>
                </td>
                <td class="EditHead">
                    纳税人分类
                </td>
                <td class="editTd">
                    <s:property value="maintain.taxpayerTypeName"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">
                    纳税人信用等级
                </td>
                <td class="editTd">
                    <s:property value="maintain.taxpayerLevelName"/>
                </td>
                <td class="EditHead">
                    纳税人信用等级所属年度
                </td>
                <td class="editTd">
                    <s:property value="maintain.taxpayerLevelYear"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">
                    企业性质
                </td>
                <td class="editTd">
                    <s:property value="maintain.companyTypeName"/>
                </td>
                <td class="EditHead">
                    国家
                </td>
                <td class="editTd">
                    <s:property value="maintain.countryName"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">
                    省
                </td>
                <td class="editTd">
                    <s:property value="maintain.provinceName"/>
                </td>
                <td class="EditHead">
                    城市
                </td>
                <td class="editTd">
                    <s:property value="maintain.cityName"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">
                    注册地址
                </td>
                <td class="editTd">
                    <s:property value="maintain.address"/>
                </td>
                <td class="EditHead">
                    成立日期
                </td>
                <td class="editTd">
                    <s:property value="maintain.setupDate"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">是否独立法人</td>
                <td class="editTd">
                    <s:property value="maintain.isLegalPerson"/>
                </td>
                <td class="EditHead">法定代表人/负责人</td>
                <td class="editTd">
                    <s:property value="maintain.legalPerson"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">出资额或注册资本<br>（万元）</td>
                <td class="editTd">
                    <fmt:formatNumber pattern="#,##0.00"  minFractionDigits="2" >${maintain.registeredCapital}</fmt:formatNumber>
                </td>
                <td class="EditHead">注册资金币种</td>
                <td class="editTd">
                    <s:property value="maintain.registeredCurrencyName"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">营业期限（起始）</td>
                <td class="editTd">
                    <s:property value="maintain.businessDateBegin"/>
                </td>
                <td class="EditHead">营业期限（终止）</td>
                <td class="editTd">
                    <s:property value="maintain.businessDateEnd"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">经营范围</td>
                <td class="editTd" colspan="3">
                    <s:textarea id="businessScope" name="maintain.businessScope" disabled="true" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">
                    通讯地址
                </td>
                <td class="editTd" colspan="3">
                    <s:textarea id="contactsAddress" name="maintain.contactsAddress" disabled="true" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">联系人</td>
                <td class="editTd">
                    <s:property value="maintain.contacts"/>
                </td>
                <td class="EditHead">联系电话</td>
                <td class="editTd">
                    <s:property value="maintain.contactsNum"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">
                    单位传真
                </td>
                <td class="editTd">
                    <s:property value="maintain.contactsFax"/>
                </td>
                <td class="EditHead">证书编号</td>
                <td class="editTd">
                    <s:property value="maintain.zsbh"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">注册人数（个）</td>
                <td class="editTd" colspan="3">
                    <s:textfield name="maintain.zcrs" disabled="true" cssClass="noborder" id="zcrs" onblur="value=value.replace(/[^\d]/g,'')" onkeydown="value=value.replace(/[^\d]/g,'')" maxlength="5" title="注册人数"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(指注册会计师人数，或注册造价师人数，或注册资产评估师人数)
                </td>
            </tr>

            <tr>
                <td class="EditHead">机构资质</td>
                <td class="editTd" colspan="3">
                    <s:textarea id="jgzz" name="maintain.jgzz" disabled="true" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">综合评价等级
                </td>
                <td class="editTd" colspan="3">
                    <s:textarea id="evaluateGrade" name="maintain.evaluateGrade" disabled="true" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">
                    在行业协会检查中不合格
                    <br>
                    或被要求整改情况
                </td>
                <td class="editTd" colspan="3">
                    <s:textarea id="rework" name="maintain.rework" cssClass="noborder" disabled="true" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
                </td>
            </tr>

            <tr>
                <td class="EditHead">近三年平均年营业收入
                </td>
                <td class="editTd" colspan="3">
                    <s:textarea id="business_income" name="maintain.business_income" disabled="true" cssClass="noborder" cssStyle="width:99%;overflow-y:visible;line-height:150%;"/>
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
    </s:form>
</div>
</body>
</html>
	