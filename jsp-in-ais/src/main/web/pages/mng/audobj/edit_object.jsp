<%@ page import="ais.resmngt.audobj.model.AuditingObject" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE HTML>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>被审计单位</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/base64_Encode_Decode.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/pages/mng/audobj/obj.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/validate.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <STYLE type="">
        .fontStyle {
            margin-right: 5px;
            color: red;
        }
    </STYLE>
</head>

<script type="text/javascript">
    $(function () {
        if ($("#flag").val() == 1) {
            $("#flag").val("");
        }
        <%
			String auditObjectName = ((AuditingObject)request.getAttribute("auditingObject")).getName();
			auditObjectName = URLEncoder.encode(auditObjectName, "UTF-8");
		%>

        $('#ao-tabs').tabs({
            onSelect: function (title) {
                if (title == '历史被审项目') {
                    $('#inthistorylist').attr('src', '${contextPath}/mng/audobj/object/listinhis.action?auditingObjectEdit.id=${auditingObjectEdit.id}');
                } else if (title == '经济责任人') {
                    $('#economydutylist').attr('src', '${contextPath}/mng/economyduty/economyDutyAction!list.action?audobjid=${auditingObjectEdit.id}&status=edit');
                } else if (title == '反馈账号') {
                    $('#auditlist').attr('src', '${contextPath}/auditAccessoryList/editAuditobjAccount.action?audit_object=${auditingObjectEdit.id}&audit_object_name='+encodeURI(encodeURI("${auditingObject.getName()}"))+'&view=edit');
                } /*else if (title == '被审计单位资料查看') {
                    $('#auditobject').attr('src', '${contextPath}/auditobject/material/initAuditObjectData.action?auditObject=${auditingObjectEdit.id}&view=true');
                }*/
            }
        });
    });

    function Upload(id, filelist) {
        var guid = document.getElementById(id).value;
        var num = Math.random();
        var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
        window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_auditing_object&table_guid=other_resource_file&guid=' + guid + '&param=' + rnm + '&deletePermission=true', filelist, 'dialogWidth:700px;dialogHeight:450px;status:yes');
    }

    function vNum() {
        if (!isPlusInteger(document.getElementById('auditingObjectEdit.superiorCode').value)) {
            $.messager.show({title: '消息', msg: '上级机构编码 应为数字！'});
            return false;
        }
        if (!isPlusInteger(document.getElementById('auditingObjectEdit.currentCode').value)) {
            $.messager.show({title: '消息', msg: '本级机构编码 应为数字！'});
            return false;
        }
        return true;
    }

    /*
     * 保存表单
     */
    function saveObj() {

        if (!validataForm('myform')) {
            return;
        }

        if (!checkHasCurrentCode()) {	//验证本级编码有无重复
            var eAbbreviationId = $('#eAbbreviationId').val();
            var audobjid = "${auditingObjectEdit.id}";
            $.ajax({
                type: "POST",
                url: "${contextPath}/mng/audobj/object/eAbbreviationbyrepeat.action",
                data: {"eAbbreviation": eAbbreviationId, "Auditingid": audobjid},
                dataType: "json",
                success: function (resultMap) {
                    if (resultMap.auditingidhh != 1) {
                        top.$.messager.show({title: '消息', msg: '英文简称重复 ！'});
                        return;
                    } else {
                        $.ajax({
                            url: '${contextPath}/mng/audobj/object/save.action',
                            dataType: 'json',
                            type: "post",
                            data: $('#myform').serialize(),
                            success: function (data) {
                                if (data.flag == 'success') {
                                    top.$.messager.show({title: '消息', msg: '保存成功!'});
                                    /* if(parent.left$tree && data.isNew == '0'){
                                        parent.aud$locationLeftTreeNode(data.nodeId);
                                    } */
                                    if (data.isNew == '1') {
                                        $('#id').val(data.id);
                                    }
                                    $('#isSubmit').val('否');
                                } else {
                                    top.$.messager.show({title: '消息', msg: '保存失败：' + data.msg});
                                }
                            },
                            error: function (data) {
                                if (data.responseText) {
                                    top.$.messager.show({title: '提示', msg: data.responseText.replaceAll('window.history.back\\(\\)','')});
                                } else {
                                    top.$.messager.show({title: '消息', msg: '保存失败!'});
                                }
                            }

                        });
                    }
                }
            });
        }
    }

    function submitObj() {
        var id = $('#id').val();
       /*  var bigdataSjyId = $("#bigdataSjyId")[0].children[1].children[2].value; */
        $.ajax({
            url: '${contextPath}/mng/audobj/object/submitObj.action',
            dataType: 'json',
            type: "post",
            async:false,
            data: {'id': id
            },
            success: function (data) {
                if (data.flag == '1') {
                    top.$.messager.show({title: '消息', msg: '提交更新成功!'});
                    if (parent.left$tree) {
                        parent.aud$locationLeftTreeNode(data.nodeId);
                    }
                } else {
                    top.$.messager.show({title: '消息', msg: '请先保存基本信息!'});
                }
            }

        });
    }

    function expObj() {
        document.forms[0].action = 'expAuditingObject.action';
        document.forms[0].submit();
    }

    function deleteFile(fileId, guid, isDelete, isEdit, appType) {
        $.messager.confirm('确认', '确认删除吗?', function (boolFlag) {
            if (boolFlag) {
                DWREngine.setAsync(false);
                DWREngine.setAsync(false);
                DWRActionUtil.execute(
                    {namespace: '/commons/file', action: 'delFile', executeResult: 'false'},
                    {
                        'fileId': fileId,
                        'deletePermission': isDelete,
                        'isEdit': isEdit,
                        'guid': guid,
                        'appType': appType
                    },
                    xxx);

                function xxx(data) {
                    document.getElementById("otherResourceFileList").innerHTML = data['accessoryList'];
                }
            }
        });
    }

    function delAudObj() {
        $.messager.confirm('确认', '确认删除吗?', function (boolFlag) {
            if (boolFlag) {
                $.ajax({
                    url: '${contextPath}/mng/audobj/object/jsonDelete.action',
                    data: {'auditingObject.id': '${auditingObjectEdit.id}'},
                    type: 'POST',
                    async: false,
                    dataType: 'json',
                    success: function (result) {
                        if (result.status == 'ok') {
                            parent.$.messager.show({title: '提示信息', msg: '删除成功！'});
                            parent.$('#zcfgTreeSelect').tree("reload");
                        } else {
                            parent.$.messager.show({title: '提示信息', msg: result.msg});
                        }
                    },
                    error: function () {
                        parent.$.messager.show({title: '提示信息', msg: '系统错误，请联系管理员！'});
                    }
                });
            }
        });
    }

    /*
     * 验证本级编码是否重复
     */
    function checkHasCurrentCode() {
        var currentId = document.getElementsByName("auditingObjectEdit.currentCode").value;
        var audobjid = "${auditingObjectEdit.id}";
        if (audobjid != "") {
            return false;
        }
        var hasCurrentCode = false;
        DWREngine.setAsync(false);
        DWRActionUtil.execute(
            {namespace: '/mng/audobj/object', action: 'checkHasCurrentCode', executeResult: 'false'},
            {'currentId': currentId},
            xxx);

        function xxx(rs) {
            if (eval(rs['isHaveCurrentCode'])) {
                hasCurrentCode = true;
            }
        }

        if (hasCurrentCode) {
            $.messager.show({title: '消息', msg: '本级机构编码重复！'});
        }
        return hasCurrentCode;
    }

    function setfmid(obj, otherName) {
        var str;
        str = obj.options[obj.selectedIndex].text;
        document.getElementsByName(otherName)[0].value = str;
    }

    function findFatherDep() {
        $.ajax({
            type: "POST",
            url: "${contextPath}/mng/audobj/object/objselecttree!checkAuthValues.action",
            success: function (msg) {
                if (msg != 1) {
                    $.messager.show({title: '提示信息', msg: msg});
                    return false;
                } else {
                    return true;
                    //showPopWin('${contextPath}/pages/system/search/searchdata.jsp?url=${contextPath}/mng/audobj/object/objselecttree.action&paraname=auditingObjectEdit.parentName&paraid=auditingObjectEdit.superiorCode&currentId=${auditingObjectEdit.id}&showRootNode=_show&returnCurrent=1',500,480,'上级单位')
                }
            }
        });

    }

    function getCurrenCode(audobjid) {
        $.ajax({
            type: "POST",
            url: "${contextPath}/mng/audobj/object/getCurrenCode.action?audobjid=" + audobjid,
            success: function (code) {
                if (code == 'no') {
                    $('#superiorCode').attr('value', '');
                    $('#parentName').attr('value', '');
                } else {
                    $('#superiorCode').attr('value', code);
                }
            }
        });
    }

    function goback() {
        window.history.back(-1);
    }

    function viewHistory() {
        var url = "${contextPath}/mng/audobj/object/viewHistory.action?id=${auditingObjectEdit.id}";
        // aud$openNewTab('历史变更信息查看', url, false);
        new aud$createTopDialog({
            title: '历史变更信息查看',
            url: url
        }).open();
    }


    function newADD() {
        var isSubmit = $('#isSubmit').val();
        if (isSubmit == "否"){
            showMessage1("请先提交更新后再新增!");
            return;
        }
        window.location = 'edit.action?auditingObject.parentId=${auditingObjectEdit.id}&_superiorCode='
    }
</script>
<body style="overflow:hidden;">
<div class="easyui-tabs" fit="true" border="0" id="ao-tabs">
    <div id='one' title='基本信息'>
        <div class='easyui-layout' border='0' fit='true'>
            <div region='north' style="height:32px;overflow:hidden;" border='0'>

            </div>
            <div region='center' border='0'>
                <s:form id="myform" action="save" namespace="/mng/audobj/object">
                    <div style="text-align:left;padding:5px;">
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-export'" onclick="expObj();"
                           id="exp_id">导出本级及下级</a>&nbsp;&nbsp;
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveObj()"
                           id="save_id">保存</a>&nbsp;&nbsp;
                        <s:if test="${not empty(auditingObjectEdit.id) and auditingObjectEdit.id!='0'}">
                            <s:if test="${not empty(auditingObjectEdit.parentId) and auditingObjectEdit.parentId!='0'}">
                                <a class="easyui-linkbutton" name="delete" data-options="iconCls:'icon-delete'"
                                       onclick="delAudObj()">删除</a>&nbsp;&nbsp;
                            </s:if>
                            <a class="easyui-linkbutton" name="add" data-options="iconCls:'icon-add'"
                               onclick="newADD()">新增</a>&nbsp;&nbsp;
                        </s:if>
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="submitObj()"
                           id="save_id">提交更新</a>&nbsp;&nbsp;
                        <s:if test="${status == 'edit'}">
                            <span>基本信息更新记录：<a href="javascript:;" onclick="viewHistory()">${hisNum}</a></span>
                        </s:if>
                    </div>
                    <input type="hidden" id="flag" value="${refresh}"/>
                    <table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="tab1">
                        <tr>
                            <td class="EditHead" style="width: 15%">
                                <font color=red class="fontStyle">*</font>组织机构编码
                            </td>
                            <td class="editTd" style="width: 35%">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.currentCode"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="64"></s:textfield>
                            </td>
                            <td class="EditHead" style="width: 15%" nowrap="nowrap">
                                上级组织机构编码
                            </td>
                            <td class="editTd" style="width: 35%">
                                <s:if test="${auditingObjectEdit.superiorCode == '0'}">
                                    <s:textfield cssClass="noborder" id="superiorCode"
                                                 name="auditingObjectEdit.superiorCode" maxLength="100" readonly="true"></s:textfield>
                                </s:if>
                                <s:else>
                                    <s:textfield cssClass="noborder" id="superiorCode"
                                                 name="auditingObjectEdit.superiorCode" maxLength="100"></s:textfield>
                                </s:else>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                <font color=red class="fontStyle">*</font>单位名称
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.name"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="100"></s:textfield>
                            </td>
                            <td class="EditHead">
                                上级单位
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.parentName"
                                             readonly="true"></s:textfield>
                                <s:hidden name="parentId"></s:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                法人机构编码
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.corporationCode"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="255"></s:textfield>
                            </td>
                            <td class="EditHead">
                                机构英文名称
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.nameEng"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="255"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                注册资本
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.regCapital"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="255"></s:textfield>
                            </td>
                            <td class="EditHead">
                                管理主体
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.mngSubject"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="255"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                注册地
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.regAddress"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="255"></s:textfield>
                            </td>
                            <td class="EditHead">
                                投资主体
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.invSubject"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="255"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                占股比
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.shareRatio"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="255"></s:textfield>
                            </td>
                            <td class="EditHead">
                                成立日期
                            </td>
                            <td class="editTd">
                                <%--<s:textfield cssClass="noborder" name="auditingObjectEdit.establishDate"--%>
                                             <%--readonly="${auditingObjectEdit.source=='1'?true:false}"--%>
                                             <%--maxlength="255"></s:textfield>--%>
                                <s:if test="${auditingObjectEdit.source eq '1'}">
                                    <s:textfield cssClass="noborder" name="auditingObjectEdit.establishDate" readonly="true" maxlength="255"></s:textfield>
                                </s:if>
                                <s:else>
                                <input type="text" id="establishDate" name="auditingObjectEdit.establishDate" value="${auditingObjectEdit.establishDate}"
                                        Class="easyui-datebox noborder" editable="false"/>
                                </s:else>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                法人级次
                            </td>
                            <td class="editTd" colspan="3">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.orgLevelName"
                                             readonly="${auditingObjectEdit.source=='1'?true:false}"
                                             maxlength="255"></s:textfield>
                                <s:hidden name="auditingObjectEdit.orgLevelCode"></s:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead" nowrap>
                                <font color=red class="fontStyle">*</font>所属审计单位
                            </td>
                            <td class="editTd">
                                <s:buttonText name="auditingObjectEdit.departmentName" cssClass="noborder"
                                              hiddenName="auditingObjectEdit.departmentId"
                                              doubleOnclick="showSysTree(this,
												{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
												   // json格式，url使用的参数
												   param:{
														'p_item':1,
													    'orgtype':1
												},
												  title:'请选择审计单位',
												  // 单击确定按钮后执行清空被审计单位（根据实际业务逻辑编写相关代码）
												  onAfterSure:function(){
												    $('#departmentId').val('');
												    $('#departmentName').val('');
												  }
												})"
                                              doubleSrc="/easyui/1.4/themes/icons/search.png"
                                              doubleCssStyle="cursor:pointer;border:0" readonly="true"/>
                            </td>
                            <td class="EditHead" nowrap>
                                <font color="red" class="fontStyle">*</font>是否属于覆盖范围
                            </td>
                            <td class="editTd">
                                <select class="easyui-combobox" name="auditingObjectEdit.auditCover"
                                        style="width:150px;" editable="false">
                                    <option value="">&nbsp;&nbsp;</option>
                                    <s:iterator value='#@java.util.LinkedHashMap@{"1":"是","0":"否"}'>
                                        <s:if test="${auditingObjectEdit.auditCover == key}">
                                            <option selected="selected" value="${key}">${value}</option>
                                        </s:if>
                                        <s:else>
                                            <option value="${key}">${value}</option>
                                        </s:else>
                                    </s:iterator>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                本级及以下资产总额(万元)
                            </td>
                            <td class="editTd">
                                <input name="auditingObjectEdit.generalAssetsA" value="${auditingObjectEdit.generalAssetsA}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">
                            </td>
                            <td class="EditHead">
                                本单位资产总额(万元)
                            </td>
                            <td class="editTd">
                                <input name="auditingObjectEdit.generalAssetsO" value="${auditingObjectEdit.generalAssetsO}" class="easyui-numberbox" data-options="precision:2,groupSeparator:','">
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                总部办公地址
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.officeAddress"
                                             maxlength="255"></s:textfield>
                            </td>
                            <td class="EditHead">
                                单位负责人
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.director"
                                             maxlength="255"></s:textfield>
                                <s:hidden name="auditingObjectEdit.directorCode"></s:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                财务负责人
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.financialDirector"
                                             maxlength="255"></s:textfield>
                            </td>
                            <td class="EditHead">
                                财务联系人
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.financialLinkman"
                                             maxlength="255"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                公司性质
                            </td>
                            <td class="editTd">
                                <s:hidden name="auditingObjectEdit.comTypeName"></s:hidden>
                                <select class="easyui-combobox" name="auditingObjectEdit.comTypeCode"
                                        style="width:150px;" editable="false"
                                        onchange="setfmid(this,'auditingObjectEdit.comTypeName');">
                                    <option value="">&nbsp;</option>
                                    <s:iterator value="basicUtil.comattributeList" id="entry">
                                        <s:if test="${auditingObjectEdit.comTypeCode==code}">
                                            <option selected="selected" value="<s:property value='code'/>"><s:property
                                                    value='name'/></option>
                                        </s:if>
                                        <s:else>
                                            <option value="<s:property value='code'/>"><s:property
                                                    value='name'/></option>
                                        </s:else>
                                    </s:iterator>
                                </select>
                            </td>
                            <td class="EditHead">
                                单位电话
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.officePhone"
                                             maxlength="20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                单位传真
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.faxCode"
                                             maxlength="20"></s:textfield>
                            </td>
                            <td class="EditHead">
                                人员数量
                            </td>
                            <td class="editTd">
                                <s:textfield cssClass="noborder" name="auditingObjectEdit.employeesNum"
                                             maxlength="20"></s:textfield>
                            </td>
                        </tr>
                            <%-- <tr>
                                <td class="EditHead">
                                    中文简称
                                </td>
                                <td class="editTd">
                                    <s:textfield cssClass="noborder" name="auditingObjectEdit.cAbbreviation" maxlength="32"></s:textfield>
                                </td>
                                <td class="EditHead">
                                    <font color=red class="fontStyle">*</font>英文简称
                                </td>
                                <td class="editTd">
                                    <s:textfield cssClass="noborder" id="eAbbreviationId" name="auditingObjectEdit.eAbbreviation" maxlength="32"></s:textfield>
                                </td>
                            </tr> --%>
                        <tr>
                            <td class="EditHead">
                                最近更新人
                            </td>
                            <td class="editTd">
                                <s:property value="auditingObjectEdit.updatePersonName"/>
                                <s:hidden name="auditingObjectEdit.updatePersonCode"></s:hidden>
                                <s:hidden name="auditingObjectEdit.updatePersonName"></s:hidden>
                            </td>
                            <td class="EditHead">
                                最近更新时间
                            </td>
                            <td class="editTd">
                                <s:property value="auditingObjectEdit.updateDate"/>
                                <s:hidden name="auditingObjectEdit.updateDate"></s:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                状态
                            </td>
                            <td class="editTd">
                                <s:select list="#@java.util.LinkedHashMap@{'Y':'启用','D':'已删除'}" listValue="value"
                                          name="auditingObjectEdit.audstate"
                                          listKey="key" value="%{auditingObjectEdit.audstate}" cssStyle="width:160px;"
                                          cssClass="easyui-combobox"></s:select>
                            </td>
                            <td class="EditHead">
                                是否已提交
                            </td>
                            <td class="editTd">
                                <input type="text" id="isSubmit" value="${auditingObjectEdit.isSubmit}"
                                       readonly="readonly" style="color: Gray;" class="noborder">
                            </td>
                        </tr>
                        <tr>
                            <td class="EditHead">
                                最近一次审计期间结束
                            </td>
                            <td class="editTd" colspan="3">
                                <s:if test="${auditingObjectEdit.last_audit_end_time != null or auditingObjectEdit.source eq '1'}">
                                    <s:textfield
                                            cssClass="noborder"
                                            name="auditingObjectEdit.last_audit_end_time"
                                            readonly="true"
                                            maxlength="255"/>
                                </s:if>
                                <s:else>
                                    <input type="text"
                                           id="establishDate"
                                           name="auditingObjectEdit.last_audit_end_time"
                                           value="${auditingObjectEdit.last_audit_end_time}"
                                           class="easyui-datebox noborder"
                                           editable="false"/>

                                </s:else>
                            </td>
                        </tr>
                       <%--  <s:if test="${not  empty  auditList}">
                            <tr id="c_datasrcid_td">
                                <td class="EditHead" nowrap>
                                    业财数据源
                                </td>
                                <td class="editTd" colspan="3" id="bigdataSjyId" >
                                    <select   class="easyui-combobox"  style="width:150px;"   data-options="panelHeight:'auto'">
                                        <c:forEach items="${auditList}" var="sjy">
                                            <s:if test= "${defaultSjy eq sjy.key}">
                                                <option value="${sjy.key}" selected="selected" >${sjy.value}</option>
                                            </s:if>
                                            <s:else>
                                                <option value="${sjy.key}">${sjy.value}</option>
                                            </s:else>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </s:if> --%>

                    <%--<tr>--%>
                            <%--<td class="EditHead">--%>
                            <%--sap单位编码--%>
                            <%--</td>--%>
                            <%--<td class="editTd">--%>
                            <%--<s:textfield cssClass="noborder"  name="auditingObjectEdit.sapCurrentCode" maxlength="20"></s:textfield>--%>
                            <%--</td>--%>
                            <%----%>
                            <%--<td class="EditHead">--%>
                            <%--</td>--%>
                            <%--<td class="editTd">--%>
                            <%--</td>--%>
                            <%--</tr>--%>
                        <s:hidden name="auditingObjectEdit.otherResourceFile"
                                  id="auditingObjectEdit.otherResourceFile"></s:hidden>
                        <s:hidden name="auditingObjectEdit.createDepartmentName"/>
                        <s:hidden name="auditingObjectEdit.createDepartmentCode"/>
                        <s:hidden name="auditingObjectEdit.createPersonName"/>
                        <s:hidden name="auditingObjectEdit.createPersonCode"/>
                        <s:hidden name="auditingObjectEdit.createDate"/>
                        <s:hidden name="auditingObjectEdit.associateDeptCode"/>
                        <s:hidden name="auditingObjectEdit.associateDept"/>
                        <s:hidden name="status"/>
                    </table>
                    <s:hidden name="auditingObjectEdit.id" id="id"/>
                </s:form>
            </div>
            <%-- <div region="south" style="overflow:hidden;" border='0' >
                    <div id="doubtFile" class="easyui-fileUpload"
                         data-options="fileGuid:'${auditingObjectEdit.otherResourceFile}',
                                       isAdd:true,
                                       isEdit:true,
                                       isDel:true,
                                       isView:true,
                                       isDownload:true,
                                       isdebug:true,
                                       spaceSumibtFiles:false" ></div>
            </div> --%>
        </div>
    </div>
    <s:if test="${not empty(auditingObjectEdit.id)}">
        <div id='three' title='历史被审项目' style="width: 100%;overflow:hidden;">
            <iframe id="inthistorylist"
                    src=""
                    frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
        </div>
        <%-- 将经济责任人添加到被审计单位 --%>
        <div id='seven' title='经济责任人' style="width: 100%;overflow:hidden;">
            <iframe id='economydutylist'
                    src=""
                    frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
        </div>
        <div id='eight' title='反馈账号' style="width: 100%;overflow:hidden;">
            <iframe id='auditlist'
                    src=""
                    frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
        </div>
<%--        <div id='nine' title='被审计单位资料查看' style="width: 100%;overflow:hidden;">
            <iframe id='auditobject'
                    src=""
                    frameborder=0 width="100%" height="100%" scrolling="no"></iframe>
        </div>--%>
    </s:if>
</div>
<div id="subwindow" class="easyui-window" title="" style="width:500px;height:500px;padding:5px;" closed="true">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
            <iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%"
                    scrolling="auto"></iframe>
        </div>
        <div region="south" border="false" style="text-align:right;padding:5px 0;">
            <div style="display: inline;" align="right">
                <a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveF()">确定</a>
                <a class="easyui-linkbutton" iconCls="icon-empty" href="javascript:void(0)" onclick="cleanF()">清空</a>
                <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function queryData(url, title, width, height) {
        if ($('#item_ifr').attr('src') == '') {
            $('#item_ifr').attr('src', url);
        }
        $('#subwindow').window({
            title: title,
            width: width,
            height: height,
            modal: true,
            shadow: true,
            closed: false,
            collapsible: false,
            maximizable: false,
            minimizable: false
        });
    }

    function saveF() {
        var ayy = $('#item_ifr')[0].contentWindow.saveF();
        document.all('industryCode').value = ayy[0];
        document.all('industryName').value = ayy[1];
        closeWin();
    }

    function cleanF() {
        document.all('industryCode').value = '';
        document.all('industryName').value = '';
        closeWin();
    }

    function closeWin() {
        $('#subwindow').window('close');
    }
</script>
</body>
</html>