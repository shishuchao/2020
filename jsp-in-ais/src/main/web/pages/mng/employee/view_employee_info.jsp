<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>审计人员基本信息查看</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css"/>
    <script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
    <s:head theme="ajax"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript">
        function onBodyLoad() {
            if ("${ul}" != "" && "${employeeInfo2.id}" == "") {
                window.parent.$.messager.show({
                    title: '消息',
                    msg: '不存在该审计人员信息！'
                });
            }
        }

        function backDataList() {
            document.forms[0].action = "employeeInfoList4Dept.action";
            document.forms[0].submit();
        }

        function getUserById(id) {
            $.ajax({
                url: '${pageContext.request.contextPath}/mng/employee/getUserById.action',
                type: 'POST',
                data: {'userId': id[0]},
                async: false,
                success: function (data) {
                    data = eval('(' + data + ')');
                    // 排序编号
                    $('#orderNo').val(data.forder != null ? data.forder : '');
                    // 所属单位/部门
                    $('#company').val(data.fdepname);
                    // 出生日期
                    $('#employeeInfoBorn').val(data.fborn);
                    // 性别
                    $('#employeeInfoSex').val(data.fsex);
                    // 人员状态
                    $('#incumbencyStateCode').val(data.fstate);
                    $('#incumbencyState').val(data.fstateName);
                    // 座机
                    $('#officePhone').val(data.fphone != null ? data.fphone : '');
                    // 手机
                    $('#mobileTelephone').val(data.fmobile != null ? data.fmobile : '');
                    // 电子邮箱
                    $('#email').val(data.femail != null ? data.femail : '');
                }
            })
        }

        $(function () {
            var employeeInfo_id = '${employeeInfo2.id}';
            if (employeeInfo_id != '') {
                var srcArray = [
                    // 教育经历
                    '${contextPath}/mng/employee/personnel/getEducationExperience.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 工作履历(加入本单位前)
                    '${contextPath}/mng/employee/personnel/getBeforeJob.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 工作履历(加入本单位后)
                    '${contextPath}/mng/employee/personnel/getAfterJob.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 职业资质
                    '${contextPath}/mng/employee/personnel/getProfessionalCertificate.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 学术科研能力
                    '${contextPath}/mng/employee/personnel/getAcademicCapabilities.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 所获荣誉
                    '${contextPath}/mng/employee/personnel/getHonours.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 绩效情况
                    '${contextPath}/mng/employee/personnel/getPerformance.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 参训情况
                    '${contextPath}/mng/employee/personnel/getParticipation.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 关联关系情况
                    '${contextPath}/mng/employee/personnel/getRelationsStatus.action?isView=1&employeeInfo_id=' + employeeInfo_id,
                    // 其他档案文件
                    '${contextPath}/mng/employee/personnel/getOtherFile.action?isView=1&employeeInfo_id=' + employeeInfo_id
                ];
                $('#tabDiv').tabs({
                    border: false,
                    onSelect: function (title, idx) {
                        var iframe = $(this).tabs('getTab', idx).find('iframe');
                        if (!iframe.attr('src')) {
                            iframe.attr('src', srcArray[idx]);
                        }
                    }
                });
                $('#tabDiv').tabs('getTab', 0).find('iframe').attr('src', srcArray[0]);
            }

            var sysAccounts = [$('#sysAccounts').val()];
            if (sysAccounts[0]) {
                getUserById(sysAccounts);
            }
        });
    </script>
</head>
<body onload="onBodyLoad()" style="margin: 0;padding: 0;overflow:auto;" class="easyui-layout">
<center>
    <s:if test="${empty(requestScope.ul)}">
        <div style="text-align:left;padding:5px;">
            <s:form namespace="/mng/employee">
                <s:hidden name="employeeInfo2.company"/>
                <s:hidden name="employeeInfo2.companyCode"/>
                <s:hidden name="employeeInfo2.name"/>
                <s:hidden name="employeeInfo2.diplomaCode"/>
                <s:hidden name="employeeInfo2.technicalPostCode"/>
                <s:hidden name="employeeInfo2.specialityCode"/>
                <s:hidden name="employeeInfo2.dutyCode"/>
                <s:hidden name="employeeInfo2.competenceCode"/>
                <s:hidden name="employeeInfo2.beginWorkDate1"/>
                <s:hidden name="employeeInfo2.beginWorkDate2"/>
                <s:hidden name="employeeInfo2.birthday1"/>
                <s:hidden name="employeeInfo2.birthday2"/>
                <s:hidden name="employeeInfo2.typeCode"/>
                <s:hidden id="incumbencyStateCode" name="employeeInfo.incumbencyStateCode"/>
                <!-- <input type="button" Class="noborder" value="返回" onclick="backDataList();"/> -->
                <!-- <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.history.back()">返回</a> -->
                <input type="hidden" name="listStatus" id="listStatus" value="${listStatus}">
            </s:form>
        </div>
    </s:if>
    <%
        if (request.getParameter("btnReturn") != null) {

    %>
    <a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="history.go(-1)">返回</a>
    <%
        }
    %>
    <s:div id='one' label='基本信息' theme='ajax' labelposition='top'>
        <table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="margin-top: 35px">
            <tr>
                <td colspan="4" align="left" class="EditHead">
                    <font style="float: left;">基本信息</font>
                    <div align="right">
                    </div>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead width="15%">
                    <FONT color=red>*</FONT>&nbsp;是否为外部审计人才
                </td>
                <td class="editTd" width="400px" align="left">
                    <s:property value="employeeInfo2.isSysAccounts"/>
                    <s:hidden id="isSysAccounts" name="employeeInfo2.isSysAccounts"/>
                </td>
                <td nowrap class=EditHead>
                    系统账号
                </td>
                <td class=editTd align="left">
                    <div id="sysacc">
                        <s:property value="employeeInfo2.sysAccounts"/>
                        <s:hidden id="sysAccounts" name="employeeInfo2.sysAccounts"/>
                    </div>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    姓名
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.name"/>
                </td>
                <td nowrap class=EditHead>排序编号</td>
                <td class="editTd">
                    <s:property value="employeeInfo2.orderNo" id="orderNo"/>
                </td>
            </tr>

            <tr>
                <td class=EditHead>
                    所属单位/部门
                </td>
                <td class="editTd" align="left">
                    <s:textfield disabled="true" name="employeeInfo2.company" id="company"/>
                </td>
                <td nowrap class=EditHead>
                    工号
                </td>
                <td class="editTd" align="left">
                    <s:property value="employeeInfo2.personnelCode" id="personnelCode"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    出生日期
                </td>
                <td class="editTd" align="left">
                    <input type="text" id="employeeInfoBorn" editable="false" disabled class="easyui-datebox noborder" style="width:150px;" value="${employeeInfo2.birthday}"/>
                </td>
                <td nowrap class=EditHead>
                    <FONT color=red>*</FONT>&nbsp;性别
                </td>
                <td class="editTd" align="left">
                    <s:textfield disabled="true" name="employeeInfo2.sex" id="employeeInfoSex"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    籍贯
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.nativePlaceName" id="nativePlaceName"/>
                </td>
                <td nowrap class=EditHead>
                    婚姻状况
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.married" id="married"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    民族
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.nation" id="nation"/>
                </td>
                <td nowrap class=EditHead>
                    政治面貌
                </td>
                <td class=editTd>
                    <s:property value="employeeInfo2.polityVisage" id="polityVisage"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    人员类型
                </td>
                <td class="editTd" align="left">
                    <s:property value="employeeInfo2.type"/>
                </td>
                <td nowrap class=EditHead>
                    职称级别
                </td>
                <td id="zcTd" class=editTd align="left" nowrap="nowrap">
                    <s:property value="employeeInfo2.technicalPost" id="technicalPost"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    职位
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.duty" id="duty"/>
                </td>
                <td nowrap class=EditHead>专业岗位</td>
                <td class="editTd">
                    <s:property value="employeeInfo2.professionalPosition" id="professionalPosition"/>
                </td>
            </tr>

            <tr>
                <td class=EditHead>
                    参加工作时间
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.graduateDate" id="graduateDate"/>
                </td>
                <td class="EditHead">
                    入司时间
                </td>
                <td class="editTd">
                    <s:property value="employeeInfo2.beginWorkDate" id="beginWorkDate"/>
                </td>
            </tr>

            <tr>
                <td class=EditHead>
                    加入本公司审计部时间
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.entryTime" id="entryTime"/>
                </td>
                <td class="EditHead">
                    内审从业起始时间
                </td>
                <td class="editTd">
                    <s:property value="employeeInfo2.joinCorpDate" id="joinCorpDate"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    IT技能<FONT color="gray"><br/>(请着重说明数据分析能力与编程能力)</FONT>
                </td>
                <td class="editTd">
                    <s:property value="employeeInfo2.itskill" id="itskill"/>
                </td>
                <td nowrap class=EditHead>精通领域</td>
                <td class="editTd">
                    <s:property value="employeeInfo2.masterfield" id="masterfield"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    人员特长
                </td>
                <td class=editTd align="left">
                    <s:if test="${employeeInfo2.strongPoint=='null' || employeeInfo2.strongPoint==null || employeeInfo2.strongPoint==''}"></s:if>
                    <s:else>
                        <s:property value="employeeInfo2.strongPoint"/>
                    </s:else>
                    <input type="hidden" id="strongPointCode" name="employeeInfo2.strongPointCode"/>
                </td>
                <td nowrap class=EditHead></td>
                <td class=editTd align="left"></td>
            </tr>

            <tr>
                <td class=EditHead>
                    人员状态
                </td>
                <td class=editTd align="left">
                    <s:textfield disabled="true" name="employeeInfo2.incumbencyState" id="incumbencyState"/>
                </td>
                <td class=EditHead>
                    离职时间
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.dimissionDate" id="dimissionDate"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    座机
                </td>
                <td class=editTd align="left">
                    <s:textfield disabled="true" name="employeeInfo2.officePhone" id="officePhone"/>
                </td>
                <td nowrap class=EditHead>
                    手机
                </td>
                <td class=editTd align="left">
                    <s:textfield disabled="true" name="employeeInfo2.mobileTelephone" id="mobileTelephone"/>
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    电子邮箱
                </td>
                <td class=editTd align="left">
                    <s:textfield disabled="true" name="employeeInfo2.email" id="email"/>
                </td>
                <td nowrap class=EditHead>岗位类别</td>
                <td class=editTd align="left">${employeeInfo2.postCategoryName }
                </td>
            </tr>

            <tr>
                <td nowrap class=EditHead>
                    紧急联系人
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.emergency" id="emergency"/>
                </td>
                <td nowrap class=EditHead>
                    紧急联系人电话
                </td>
                <td class=editTd align="left">
                    <s:property value="employeeInfo2.emergencyPhone" id="emergencyPhone"/>
                </td>
            </tr>
        </table>

        <div id="tabDiv" class="easyui-tabs" cellpadding=0 cellspacing=0 border=0 align="center" style="width:98%">
            <div title="教育经历">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="工作履历(加入本单位前)">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="工作履历(加入本单位后)">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="职业资质">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="学术科研能力">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="所获荣誉">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="绩效情况">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="参训情况">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="关联关系情况">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
            <div title="其他档案文件">
                <iframe width="100%" height="300" frameborder="0" scrolling="no"></iframe>
            </div>
        </div>
    </s:div>
</center>
</body>
</html>
