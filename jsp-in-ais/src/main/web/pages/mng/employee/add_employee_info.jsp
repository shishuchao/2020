<!DOCTYPE HTML >
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>添加审计人员基本信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/employeeValidate/validate.js"></script>
    <link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <%-- <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script> --%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-parseExcel.js"></script>
    <link href="${contextPath}/styles/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${contextPath}/scripts/jquery.searchableSelect.js"></script>

    <s:head theme="simple"/>
</head>
<body>
<div id="tabDiv" class="easyui-tabs" fit="true" border=0>
    <div title="基本信息">
        <div style="width: 100%;position:absolute;padding-top:0;text-align: right;z-index: 1000;" class="EditHead">
            <div style="text-align:right;width:100%;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="save('yes')">保存</a>&nbsp;&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="clearAll()">重置</a>&nbsp;&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location='employeeInfoList.action?listStatus=edit'">返回</a>
                &nbsp;&nbsp;
            </div>
        </div>
        <div class="easyui-layout" fit="true">
           <div region="center">
               <s:form action="employeeInfoSave" namespace="/mng/employee" id="myform">
                   <s:token/>
                   <s:hidden name="employeeInfo.creator" value="${user.floginname}"/>
                   <s:hidden name="listStatus"/>
                   <s:hidden name="employeeInfo.id"/>
                   <s:hidden name="employeeInfo.zhushenNum"/>
                   <s:hidden id="psncode"/>
                   <s:hidden name="employeeInfo.department"/>
                   <s:hidden name="employeeInfo.departmentCode"/>
                   <s:hidden name="isOnlySave" value="no"/>
                   <table id="tab1" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="padding: 0;margin-top: 40px;">
                       <tr>
                           <td nowrap class=EditHead width="15%">
                               <FONT color=red>*</FONT>&nbsp;是否为外部审计人才
                           </td>
                           <td class=editTd width="400px" align="left">
                               <select editable="false" name="employeeInfo.isSysAccounts" class="easyui-combobox" PanelHeight="auto">
                                   <option value="">&nbsp;</option>
                                   <s:iterator value='#@java.util.LinkedHashMap@{"否":"否", "是":"是"}'>
                                       <s:if test="${employeeInfo.isSysAccounts == key}">
                                           <option selected="selected" value=${key}>${value}</option>
                                       </s:if>
                                       <s:else>
                                           <option value=${key}>${value}</option>
                                       </s:else>
                                   </s:iterator>
                               </select>
                           </td>
                           <td nowrap class=EditHead>
                               <FONT color=red>*</FONT>&nbsp;系统账号
                           </td>
                           <td class=editTd align="left">
                               <s:buttonText2 name="employeeInfo.sysAccounts" id="sysAccounts"
                                              cssStyle="color:gray;width:40%;" cssClass="noborder"
                                              doubleOnclick="onSysAccountsClick(this)"
                                              doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                              readonly="true"
                                              doubleCssStyle="cursor:pointer;border:0;color:Gray;"
                                              doubleDisabled="false" maxlength="500" title="系统账号"/>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               <FONT color=red>*</FONT>&nbsp;姓名
                           </td>
                           <td class=editTd align="left">
                               <s:textfield cssClass="noborder" readonly="true" cssStyle="color:Gray;width:40%;" name="employeeInfo.name" size="37" maxlength="16"/>
                               <FONT id="msg1" color="gray">选择系统账号后，自动关联生成</FONT>
                           </td>
                           <td nowrap class=EditHead>排序编号</td>
                           <td class="editTd">
                               <s:textfield cssClass="noborder" id="orderNo" name="employeeInfo.orderNo" cssStyle="width:40%;" size="37" maxlength="18"/>
                           </td>
                       </tr>

                       <tr>
                           <td class=EditHead>
                               所属单位/部门
                           </td>
                           <td class="editTd" align="left">
                               <s:textfield cssClass="noborder" cssStyle="color:gray;width:40%;" readonly="true" name="employeeInfo.company" size="37" maxlength="16"/>
                               <FONT id="msg3" color="gray">选择系统账号后，自动关联生成</FONT>
                               <s:textfield cssClass="noborder" id="companyCode" name="employeeInfo.companyCode" cssStyle="color:gray;display:none"/>
                           </td>
                           <td nowrap class=EditHead>
                               <FONT color=red>*</FONT>&nbsp;工号
                           </td>
                           <td class="editTd" align="left">
                               <s:textfield id="personnelCode" cssClass="noborder" readonly="true" cssStyle="color:gray;width:40%;" name="employeeInfo.personnelCode" size="37" maxlength="16"/>
                               <FONT id="msg2" color="gray">选择系统账号后，自动关联生成</FONT>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               出生日期
                           </td>
                           <td class="editTd" align="left">
                               <input type="text" id="employeeInfoBorn" editable="false" class="easyui-datebox noborder" name="employeeInfo.birthday" title="单击选择日期" style="width:150px;" value="${employeeInfo.birthday}"/>
                           </td>
                           <td nowrap class=EditHead>
                               <FONT color=red>*</FONT>&nbsp;性别
                           </td>
                           <td class="editTd" align="left">
                               <select id="employeeInfoSex" editable="false" name="employeeInfo.sex" class="easyui-combobox" PanelHeight="auto">
                                   <option value="">&nbsp;</option>
                                   <s:iterator value='#@java.util.LinkedHashMap@{"男":"男", "女":"女"}'>
                                       <s:if test="${employeeInfo.sex == key}">
                                           <option selected="selected" value=${key}>${value}</option>
                                       </s:if>
                                       <s:else>
                                           <option value=${key}>${value}</option>
                                       </s:else>
                                   </s:iterator>
                               </select>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               籍贯
                           </td>
                           <td class=editTd align="left">
                               <select editable="false" id="nativePlace" class="easyui-combobox" name="employeeInfo.nativePlace" PanelHeight="auto">
                                   <option value="">&nbsp;</option>
                                   <s:iterator value="basicUtil.nativeplacList">
                                       <s:if test="${employeeInfo.nativePlace == code}">
                                           <option selected="selected" value=${code}>${name }</option>
                                       </s:if>
                                       <s:else>
                                           <option value=${code}>${name}</option>
                                       </s:else>
                                   </s:iterator>
                               </select>
                           </td>
                           <td nowrap class=EditHead>
                               婚姻状况
                           </td>
                           <td class=editTd align="left">
                               <s:select name="employeeInfo.married" list="#@java.util.LinkedHashMap@{'':'','已婚':'已婚','未婚':'未婚'}" cssClass="easyui-combobox" cssStyle="width:40%;"/>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               民族
                           </td>
                           <td class=editTd align="left">
                               <select editable="false" id="nationCode" name="employeeInfo.nationCode" class="easyui-combobox" PanelHeight="auto">
                                   <option value="">&nbsp;</option>
                                   <s:iterator value="basicUtil.nationList">
                                       <s:if test="${employeeInfo.nationCode == code}">
                                           <option selected="selected" value=${code}>${name}</option>
                                       </s:if>
                                       <s:else>
                                           <option value=${code}>${name}</option>
                                       </s:else>
                                   </s:iterator>
                               </select>
                           </td>
                           <td nowrap class=EditHead>
                               政治面貌
                           </td>
                           <td class=editTd>
                               <select editable="falsb" id="polityVisageCode" name="employeeInfo.polityVisageCode" class="easyui-combobox" PanelHeight="auto">
                                   <option value="">&nbsp;</option>
                                   <s:iterator value="basicUtil.polityVisageList">
                                       <s:if test="${employeeInfo.polityVisageCode == code}">
                                           <option selected="selected" value=${code}>${name}</option>
                                       </s:if>
                                       <s:else>
                                           <option value=${code}>${name}</option>
                                       </s:else>
                                   </s:iterator>
                               </select>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               人员类型
                           </td>
                           <td class="editTd" align="left">
                               <select editable="false" name="employeeInfo.typeCode" class="easyui-combobox" PanelHeight="auto">
                                   <option value="">&nbsp;</option>
                                   <s:iterator value="basicUtil.typeList">
                                       <s:if test="${employeeInfo.typeCode==code}">
                                           <option selected="selected" value=${code}>${name }</option>
                                       </s:if>
                                       <s:else>
                                           <option value=${code}>${name }</option>
                                       </s:else>
                                   </s:iterator>
                               </select>
                           </td>
                           <td nowrap class=EditHead>
                               职称级别
                           </td>
                           <td id="zcTd" class=editTd align="left" nowrap="nowrap">
                               <s:buttonText2 id="technicalPost" name="employeeInfo.technicalPost"
                                              hiddenId="technicalPostCode" hiddenName="employeeInfo.technicalPostCode"
                                              cssClass="noborder"
                                              doubleOnclick="queryData('/ais/mng/employee/quertTechnicalPost.action','职称级别',440,410,'technicalPostCode','technicalPost')"
                                              doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                              doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               职位
                           </td>
                           <td class=editTd align="left">
                               <s:buttonText2 id="duty" name="employeeInfo.duty"
                                              hiddenId="dutyCode" hiddenName="employeeInfo.dutyCode"
                                              cssClass="noborder"
                                              doubleOnclick="queryData('/ais/mng/employee/queryDuty.action',' 职位 ',440,410,'dutyCode','duty')"
                                              doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                              doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
                           </td>
                           <td nowrap class=EditHead>专业岗位</td>
                           <td class="editTd">
                               <select editable="false" name="employeeInfo.professionalPositionCode" class="easyui-combobox" PanelHeight="auto">
                                   <option value="">&nbsp;</option>
                                   <s:iterator value="basicUtil.professionalPositionList">
                                       <s:if test="${employeeInfo.professionalPositionCode == code}">
                                           <option value=${code} selected="selected">${name}</option>
                                       </s:if>
                                       <s:else>
                                           <option value=${code}>${name}</option>
                                       </s:else>
                                   </s:iterator>
                               </select>
                           </td>
                       </tr>

                       <tr>
                           <td class=EditHead>
                               参加工作时间
                           </td>
                           <td class=editTd align="left">
                               <input id="graduateDate" type="text" editable="false" class="easyui-datebox noborder" name="employeeInfo.graduateDate" title="单击选择日期" style="width:150px;" value="${employeeInfo.graduateDate}"/>
                           </td>
                           <td class="EditHead">
                               入司时间
                           </td>
                           <td class="editTd">
                               <input id="beginWorkDate" type="text" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="employeeInfo.beginWorkDate" value="${employeeInfo.beginWorkDate}">
                           </td>
                       </tr>

                       <tr>
                           <td class=EditHead>
                               加入本公司审计部时间
                           </td>
                           <td class=editTd align="left">
                               <input type="text" id="entryTime" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="employeeInfo.entryTime" value="${employeeInfo.entryTime}">
                           </td>
                           <td class="EditHead">
                               内审从业起始时间
                           </td>
                           <td class="editTd">
                               <input id="joinCorpDate" type="text" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="employeeInfo.joinCorpDate" value="${employeeInfo.joinCorpDate}">
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               IT技能<FONT color="gray"><br/>(请着重说明数据分析能力与编程能力)</FONT>
                           </td>
                           <td class="editTd">
                               <s:textfield cssClass="noborder" id="itskill" name="employeeInfo.itskill" cssStyle="width:40%;" size="37" maxlength="200"/>
                           </td>
                           <td nowrap class=EditHead>精通领域</td>
                           <td class="editTd">
                               <s:textfield cssClass="noborder" id="masterfield" name="employeeInfo.masterfield" cssStyle="width:40%;" size="37" maxlength="18"/>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               人员特长
                           </td>
                           <td class=editTd align="left">
                               <input type="hidden" id="strongPointCode" name="employeeInfo.strongPointCode"/>
                               <select multiple="multiple" id="strongPointCode1" editable="false" name="employeeInfo.strongPointCode1" style="width:35%;">
                                   <c:forEach items="${basicUtil.specialityList}" var="s">
                                       <option value='${s.code }'>${s.name }</option>
                                   </c:forEach>
                               </select>
                           </td>
                           <td nowrap class=EditHead></td>
                           <td class=editTd align="left"></td>
                       </tr>

                       <tr>
                           <td class=EditHead>
                               人员状态
                           </td>
                           <td class=editTd align="left">
                               <s:textfield cssClass="noborder" id="incumbencyState" readonly="true" name="employeeInfo.incumbencyState" cssStyle="width:40%;"/>
                               <s:hidden id="incumbencyStateCode" name="employeeInfo.incumbencyStateCode"/>
                           </td>
                           <td class=EditHead>
                               离职时间
                           </td>
                           <td class=editTd align="left">
                               <input id="dimissionDate" type="text" editable="false" class="easyui-datebox noborder" title="单击选择日期" style="width:150px;" name="employeeInfo.dimissionDate" value="${employeeInfo.dimissionDate}">
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               座机
                           </td>
                           <td class=editTd align="left">
                               <s:textfield cssClass="noborder" id="officePhone" name="employeeInfo.officePhone" cssStyle="width:40%;"/>
                           </td>
                           <td nowrap class=EditHead>
                               手机
                           </td>
                           <td class=editTd align="left">
                               <s:textfield cssClass="noborder" id="mobileTelephone" name="employeeInfo.mobileTelephone" cssStyle="width:40%;"/>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               电子邮箱
                           </td>
                           <td class=editTd align="left">
                               <s:textfield cssClass="noborder" id="email" name="employeeInfo.email" size="37" cssStyle="width:40%;" maxlength="127"/>
                           </td>
                           <td nowrap class=EditHead>岗位类别</td>
                           <td class=editTd align="left">
                               <s:hidden id="postCategoryCode" name="employeeInfo.postCategoryCode"/>
                               <select id="postCategory" editable="false" multiple="multiple" style="width:35%">
                                   <c:forEach items="${basicUtil.empPostCategoryList}" var="s">
                                       <option value="${s.code}">${s.name}</option>
                                   </c:forEach>
                               </select>
                           </td>
                       </tr>

                       <tr>
                           <td nowrap class=EditHead>
                               紧急联系人
                           </td>
                           <td class=editTd align="left">
                               <s:textfield cssClass="noborder" id="emergency" name="employeeInfo.emergency" cssStyle="width:40%;" size="37" maxlength="16"/>
                           </td>
                           <td nowrap class=EditHead>
                               紧急联系人电话
                           </td>
                           <td class=editTd align="left">
                               <s:textfield cssClass="noborder" id="emergencyPhone" name="employeeInfo.emergencyPhone" cssStyle="width:40%;" size="37" maxlength="16"/>
                           </td>
                       </tr>
                   </table>
               </s:form>
           </div>
        </div>
    </div>
    <s:if test="${not empty(employeeInfo.id)}">
        <div title="教育经历" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="工作履历(加入本单位前)" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="工作履历(加入本单位后)" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="职业资质" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="学术科研能力" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="所获荣誉" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="绩效情况" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="参训情况" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="关联关系情况" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
        <div title="其他档案文件" style="overflow: hidden">
            <iframe width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
        </div>
    </s:if>
</div>

<div id="subwindow" class="easyui-window" title="" style="width:500px;height:500px;padding:5px;" closed="true">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;overflow:hidden">
            <iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" title=""></iframe>
        </div>
        <div region="south" border="false" style="text-align:right;padding:5px 0;">
            <div style="display: inline;" align="right">
                <input type="hidden" id="para1" value="">
                <input type="hidden" id="para2" value="">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="saveF()">确定</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-empty'" href="javascript:void(0)" onclick="cleanF()">清空</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="closeWin()">关闭</a>
            </div>
        </div>
    </div>
</div>

<!-- 自定义查询条件  -->
<select id="query_year" name="query_year" style='width:130px; display:none;'></select>
<select id="query_status" name="query_status" style="width:130px;display:none;"></select>
<select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select>
<!-- ajax请求前后提示 -->
<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />

<script type="text/javascript">

    $(document).ready(function () {
        if ('${employeeInfoSave}') {
            showMessage1("保存成功！");
        }

        initFields();
        initFrames();

        $("#serchForm").find("textarea").each(function () {
            autoTextarea(this);
        });

        var sysAccounts = [$('#sysAccounts').val()];
        if (sysAccounts[0]) {
            getUserById(sysAccounts);
        }
    });

    //-----------------模态窗口------刷新父窗口------------------------------
    function openWindowByUrl(url) {//打开模态窗口
        var arg = new Object();//传递进去的参数
        arg.win = window;//把当前窗口的引用当参数传进去
        newopen = showModalDialog(url, arg, "dialogHeight:548px;dialogWidth:708px;center:yes;status:no;resizable:no;");
    }

    // 初始化各字段控件
    function initFields() {

        //$('#nativePlace').searchableSelect();

        $('#workingAbroad').attr('maxlength', 500);
        $('#encourageMessage').attr('maxlength', 500);
        $("#myform").find("textarea").each(function () {
            autoTextarea(this);
        });

        // 人员特长多选框
        (function(){
            $("#strongPointCode1").attr("value", "");//清空选中项。
            var ids = '${employeeInfo.strongPoint}';//选中框ID。
            var id_Ojbect = ids.split(",");//分割为Ojbect数组。
            var count = $("#strongPointCode1 option").length;//获取下拉框的长度。
            for (var c = 0; c < id_Ojbect.length; c++) {
                for (var c_i = 0; c_i < count; c_i++) {
                    if ($("#strongPointCode1").get(0).options[c_i].text == id_Ojbect[c]) {
                        $("#strongPointCode1").get(0).options[c_i].selected = true;//设置为选中。
                    }
                }
            }
            $("#strongPointCode1").multiSelect({
                    selectAll: false,
                    oneOrMoreSelected: '*',
                    selectAllText: '全选',
                    noneSelected: ''
                }, function () {   //回调函数
                    $('#strongPointCode').attr('name', 'employeeInfo.strongPointCode').val($("#strongPointCode1").selectedValuesString());
                }
            );
        })();

        // 岗位类别多选框
        (function(){
            var postCategoryCode = $('#postCategoryCode');
            var postCategory = $('#postCategory');

            var ids = postCategoryCode.val().split(',');
            postCategory.find('option').each(function (i, option) {
                option.selected = $.inArray(option.value, ids) != -1;
            });

            postCategory.multiSelect({
                selectAll: false,
                oneOrMoreSelected: '*',
                selectAllText: '全选',
                noneSelected: ''
            }, function() {
                postCategoryCode.val($('#postCategory').selectedValuesString());
            });
        })();

        // BUG 5359 限制日期选择范围：出生日期、参加工作时间、加入本公司审计部时间、入司时间、内审从业起始时间、离职时间
        var calValidator = function (date) {
            var now = new Date();
            return date <= now;
        };
        $('#employeeInfoBorn').datebox('calendar').calendar({
            validator: calValidator
        });
        $('#graduateDate').datebox('calendar').calendar({
            validator: calValidator
        });
        $('#entryTime').datebox('calendar').calendar({
            validator: calValidator
        });
        $('#beginWorkDate').datebox('calendar').calendar({
            validator: calValidator
        });
        $('#joinCorpDate').datebox('calendar').calendar({
            validator: calValidator
        });
        $('#dimissionDate').datebox('calendar').calendar({
            validator: calValidator
        });
    }

    // 初始化子表frame
    function initFrames() {
        var employeeInfo_id = '${employeeInfo.id}';
        if (employeeInfo_id != '') {
            var srcArray = [
                '',
                // 教育经历
                '${contextPath}/mng/employee/personnel/getEducationExperience.action?employeeInfo_id=' + employeeInfo_id,
                // 工作履历(加入本单位前)
                '${contextPath}/mng/employee/personnel/getBeforeJob.action?employeeInfo_id=' + employeeInfo_id,
                // 工作履历(加入本单位后)
                '${contextPath}/mng/employee/personnel/getAfterJob.action?employeeInfo_id=' + employeeInfo_id,
                // 职业资质
                '${contextPath}/mng/employee/personnel/getProfessionalCertificate.action?employeeInfo_id=' + employeeInfo_id,
                // 学术科研能力
                '${contextPath}/mng/employee/personnel/getAcademicCapabilities.action?employeeInfo_id=' + employeeInfo_id,
                // 所获荣誉
                '${contextPath}/mng/employee/personnel/getHonours.action?employeeInfo_id=' + employeeInfo_id,
                // 绩效情况
                '${contextPath}/mng/employee/personnel/getPerformance.action?employeeInfo_id=' + employeeInfo_id,
                // 参训情况
                '${contextPath}/mng/employee/personnel/getParticipation.action?employeeInfo_id=' + employeeInfo_id,
                // 关联关系情况
                '${contextPath}/mng/employee/personnel/getRelationsStatus.action?employeeInfo_id=' + employeeInfo_id,
                // 其他档案文件
                '${contextPath}/mng/employee/personnel/getOtherFile.action?employeeInfo_id=' + employeeInfo_id
            ];
            $('#tabDiv').tabs({
                border: false,
                onSelect: function (title, idx) {
                    if (idx > 0) {
                        var iframe = $(this).tabs('getTab', idx).find('iframe');
                        if (!iframe.attr('src')) {
                            iframe.attr('src', srcArray[idx]);
                        }
                    }
                }
            });
        }
    }

    function inputtable() {
        var psncode = document.getElementById('psncode').value;
        window.location = '${contextPath}/mng/employee/employeeInfoAdd_feng.action?psncode=' + psncode;
    }

    function onSysAccountsClick(target) {
        showSysTree(target,
            {
                url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                param:{
                    'p_item':3,
                    'orgtype':1
                },
                type: 'treeAndUser',
                cache: false,
                singleSelect: true,
                title: '请选择系统账号',
                onAfterSure: function (id, name, personnelCode, company, companyCode) {
                    if (!validateSysAcc(id[0], '${employeeInfo.id}')) {
                        return;
                    }
                    getUserById(id);
                    if (name != undefined) {
                        document.getElementsByName('employeeInfo.name')[0].value = name;
                        document.getElementsByName('employeeInfo.sysAccounts')[0].value = id;
                    } else {
                        document.getElementsByName('employeeInfo.sysAccounts')[0].value = '';
                        document.getElementsByName('employeeInfo.name')[0].value = '';
                    }
                    if (personnelCode != undefined) {
                        document.getElementsByName('employeeInfo.personnelCode')[0].value = personnelCode;
                    } else {
                        document.getElementsByName('employeeInfo.personnelCode')[0].value = '';
                    }
                    if (company != undefined) {
                        document.getElementsByName('employeeInfo.department')[0].value = company;
                    } else {
                        document.getElementsByName('employeeInfo.department')[0].value = '';
                    }

                    if (companyCode != undefined) {
                        document.getElementsByName('employeeInfo.departmentCode')[0].value = companyCode;
                    } else {
                        document.getElementsByName('employeeInfo.departmentCode')[0].value = '';
                    }
                    // getUserMsgById(personnelCode);
                }
            })
    }

    function save(isOnlySave) {
        if (!validataForm('myform')) {
            return;
        }

        var mobileTelephone = $('#mobileTelephone');
        if (mobileTelephone.val()) {
            if (!isNum(mobileTelephone.val()) || mobileTelephone.val().length != 11) {
                mobileTelephone.focus();
                showMessage1('手机号必须为11位数字！');
                return;
            }
        }

        document.getElementsByName("isOnlySave")[0].value = isOnlySave;
        myform.submit();
    }

    //验证系统帐号
    function validateSysAcc(loginname, id) {
        var flag = false;
        if (loginname == null || loginname == '') {
            showMessage1("请选择系统账号！");
            return false;
        } else {
            DWREngine.setAsync(false);
            DWRActionUtil.execute(
                {namespace: '/mng/employee', action: 'validateSysAccounts', executeResult: 'false'},
                {'ln': loginname, 'poid': id},
                xxx);

            function xxx(data) {
                if (data['message'] != null && data['message'] != "") {
                    showMessage1(data['message']);
                    flag = false;
                } else {
                    flag = true;
                }
            }
        }
        return flag;
    }

    function nameAndCode() {
        var sysName = document.getElementsByName("employeeInfo.sysAccounts")[0].value;
        //填写姓名 和人员编码
        DWREngine.setAsync(false);
        DWREngine.setAsync(false);
        DWRActionUtil.execute(
            {namespace: '/mng/employee', action: 'findNameAndCode', executeResult: 'false'},
            {'sysAccounts': sysName},
            xxx1);

        function xxx1(data) {
            if (data['name'] != null && data['name'] != '') {
                document.getElementsByName("employeeInfo.name")[0].value = data['name'];
            }
            if (data['personnelCode'] != null && data['personnelCode'] != '') {
                document.getElementsByName("employeeInfo.personnelCode")[0].value = data['personnelCode'];
            }

        }
    }

    //验证人员编码是否重复
    function personCodeValidate() {
        var flag = false;
        var personnelCode = document.getElementsByName("employeeInfo.personnelCode")[0].value;
        DWREngine.setAsync(false);
        DWREngine.setAsync(false);
        DWRActionUtil.execute(
            {namespace: '/mng/employee', action: 'validatePersonCode', executeResult: 'false'},
            {'personnelCode': personnelCode},
            xxx);

        function xxx(data) {
            if (data['message'] != null && data['message'] != "") {
                alert(data['message']);
                flag = false;
            } else {
                flag = true;
            }
        }

        return flag;
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
                if ($('#orderNo').val() == '') {
                    $('#orderNo').val(data.forder != null ? data.forder : '');
                }
                // 所属单位/部门
                document.getElementsByName("employeeInfo.companyCode")[0].value = data.fdepid;
                document.getElementsByName("employeeInfo.company")[0].value = data.fdepname;
                // 人员状态
                $('#incumbencyStateCode').val(data.fstate);
                $('#incumbencyState').val(data.fstateName);
                // // 出生日期
                // $('#employeeInfoBorn').datebox('setValue', getDate(data.fborn));
                // // 性别
                // $('#employeeInfoSex').combobox('setValue', data.fsex != null ? data.fsex : '');
                // // 座机
                // $('#officePhone').val(data.fphone != null ? data.fphone : '');
                // // 手机
                // $('#mobileTelephone').val(data.fmobile != null ? data.fmobile : '');
                // // 电子邮箱
                // $('#email').val(data.femail != null ? data.femail : '');
            }
        })
    }

    function queryData(url,title,width,height,para1,para2){
        var selected = $('#' + para1).val();
        if (selected) {
            url += (url.indexOf('?') == -1 ? '?' : '&' ) + 'selected=' + selected;
        }

        $('#item_ifr').attr('title',title);
        $('#item_ifr').attr('src',url);
        $('#para1').attr('value',para1);
        $('#para2').attr('value',para2);
        $('#subwindow').window({
            title: title,
            width: width,
            height:height,
            modal: true,
            shadow: true,
            closed: false,
            collapsible:false,
            maximizable:false,
            minimizable:false
        });
    }
    function saveF(){
        var ayy = $('#item_ifr')[0].contentWindow.saveF();
        var p1 = $('#para1').attr('value');
        var p2 = $('#para2').attr('value');
        document.all(p1).value=ayy[0];
        document.all(p2).value=ayy[1];
        closeWin();
    }
    function cleanF(){
        var p1 = $('#para1').attr('value');
        var p2 = $('#para2').attr('value');
        document.all(p1).value='';
        document.all(p2).value='';
        closeWin();
    }
    function closeWin(){
        $('#subwindow').window('close');
    }

    <%--function getUserMsgById(id) {--%>
    <%--    $.ajax({--%>
    <%--        url: '${pageContext.request.contextPath}/mng/employee/getUserMsgById.action',--%>
    <%--        type: 'POST',--%>
    <%--        data: {'userId': id[0]},--%>
    <%--        async: false,--%>
    <%--        success: function (data) {--%>
    <%--            if (data != null || data != "") {--%>
    <%--                var str = data.split("#");--%>
    <%--                var birthdate = str[0];//出生日期--%>
    <%--                var nationalityname = str[1]; //民族名称--%>
    <%--                var nationalitycode = str[2];//民族code--%>
    <%--                var nativeplacename = str[3];//籍贯--%>

    <%--                var officephone = str[4];//办公电话--%>
    <%--                var mobile = str[5];//手机--%>
    <%--                var joinworkdate = str[6];//参加工作日期--%>
    <%--                var polityname = str[7];//政治面貌名称--%>
    <%--                var politycode = str[8];--%>
    <%--                var educationcode = str[9];//全日制学历--%>
    <%--                var educationname = str[10];--%>
    <%--                var dutyname = str[11];//职务名称--%>
    <%--                var dutycode = str[12];--%>
    <%--                var joinsysdate = str[13];//入司时间--%>
    <%--                var nativeplacecode = str[14];//籍贯code--%>

    <%--                $('#employeeInfoBorn').datebox('setValue', birthdate != null ? getDate(birthdate) : '');--%>
    <%--                document.getElementById('officePhone').value = officephone != null ? officephone : '';--%>
    <%--                document.getElementById('mobileTelephone').value = mobile != null ? mobile : '';--%>
    <%--                $('#graduateDate').datebox('setValue', joinworkdate != null ? getDate(joinworkdate) : '');//参见工作时间--%>
    <%--                $('#entryTime').datebox('setValue', joinsysdate != null ? getDate(joinsysdate) : '');--%>

    <%--                $('#nationCode').combobox('setValue', nationalityname != null ? nationalityname : '');//名族--%>
    <%--                document.getElementsByName("employeeInfo.nationCode")[0].value = nationalitycode;--%>

    <%--                //$("#nativePlace").val(nativeplacename != null ? nativeplacename : '');--%>
    <%--                $('#duty').val(dutyname != null ? dutyname : '');--%>
    <%--                $('#dutyCode').val(dutycode);--%>

    <%--                $('#polityVisageCode').combobox('setValue', polityname != null ? polityname : '');//政治面貌--%>
    <%--                document.getElementsByName("employeeInfo.polityVisageCode")[0].value = politycode;--%>

    <%--                $('#diplomaCode').combobox('setValue', educationname != null ? educationname : '');//学历--%>
    <%--                document.getElementsByName("employeeInfo.diplomaCode")[0].value = educationcode;--%>

    <%--                //$(".searchable-select-input").val(nativeplacename);--%>
    <%--                //$(".searchable-select-dropdown").val(nativeplacename);--%>
    <%--                //$(".searchable-select-holder").text(nativeplacename);--%>
    <%--                //$('#nativePlace').combobox('setValue', nativeplacename != null ? nativeplacename : '');//籍贯名称--%>
    <%--                //document.getElementsByName("employeeInfo.nativePlace")[0].value = nativeplacecode;--%>

    <%--            }--%>

    <%--        }--%>
    <%--    })--%>
    <%--}--%>
</script>
</body>
</html>
