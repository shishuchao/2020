<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>查看专项填报任务填报</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
</head>
<body>
<div>

    <table id="audBookTable" cellpadding=0 cellspacing=1 border=0 class="ListTable" align="center"  style="margin-top: 10px;">
        <s:hidden name="reportKeyRiskMonitor.formId"/>
        <s:hidden name="reportKeyRiskMonitor.startFormId"/>
        <s:hidden name="reportKeyRiskMonitor.sn"/>
        <s:hidden name="reportKeyRiskMonitor.year"/>
        <s:hidden name="reportKeyRiskMonitor.start_name"/>
        <s:hidden name="reportKeyRiskMonitor.tbyqsm"/>
        <s:hidden name="reportKeyRiskMonitor.tbsm"/>
        <s:hidden name="reportKeyRiskMonitor.start_time"/>
        <s:hidden name="reportKeyRiskMonitor.end_time"/>
        <s:hidden name="reportKeyRiskMonitor.file_id"/>
        <s:hidden name="reportKeyRiskMonitor.dfile_id"/>
        <s:hidden name="reportKeyRiskMonitor.status_name"/>
        <s:hidden name="reportKeyRiskMonitor.status"/>
        <s:hidden name="reportKeyRiskMonitor.applicant_name"/>
        <s:hidden name="reportKeyRiskMonitor.applicant"/>
        <s:hidden name="reportKeyRiskMonitor.applicant_fdepid"/>
        <s:hidden name="reportKeyRiskMonitor.applicant_fdepname"/>
        <s:hidden name="reportKeyRiskMonitor.tb_time"/>
        <s:hidden name="reportKeyRiskMonitor.dutyDeptId"/>
        <s:hidden name="reportKeyRiskMonitor.dutyDeptName"/>
        <tr>
            <td class="EditHead">编号</td>
            <td class="editTd">
                <s:property value="reportKeyRiskMonitor.sn"/>
            </td>
            <td class="EditHead"> 所属年度</td>
            <td class="editTd">
                <s:property value="reportKeyRiskMonitor.year"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead">专项填报任务</td>
            <td class="editTd" colspan="3">
                <s:property value="reportKeyRiskMonitor.start_name"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead">填报要求说明</td>
            <td class="editTd" colspan="3">
                <textarea class='noborder' readonly="readonly"
                          rows="8" style="width:100%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${reportKeyRiskMonitor.tbyqsm}</textarea>
            </td>
        </tr>
        <tr>
            <td class="EditHead" style="width: 15%">填报开始时间</td>
            <td class="editTd">
                <s:property value="reportKeyRiskMonitor.start_time"/>
            </td>
            <td class="EditHead" style="width: 15%">填报截止时间</td>
            <td class="editTd">
                <s:property value="reportKeyRiskMonitor.end_time"/>
            </td>
        </tr>
<%--        <tr>
            <td class="EditHead" style="width:15%;">发起人</td>
            <td class="editTd" style="width:35%;">
                <s:property value="reportKeyRiskMonitor.impPersonName"/>
            </td>
            <td class="EditHead" style="width:15%;">发起单位部门</td>
            <td class="editTd" style="width:35%;">
                <s:property value="reportKeyRiskMonitor.impDeptName"/>
            </td>
        </tr>--%>
        <tr>
            <td class="EditHead">填报文件要求格式</td>
            <td class="editTd" colspan="3">
                <div id="head_${reportKeyRiskMonitor.file_id}" style="float: left"></div>
            </td>
        </tr>
        <tr>
            <td class="EditHead">填报文件</td>
            <td class="editTd" colspan="3">
                <div id="head_${reportKeyRiskMonitor.dfile_id}" style="float: left"></div>
                <%--<div id="content_${reportKeyRiskMonitor.dfile_id}" style="float: right"></div>--%>
            </td>
        </tr>
        <tr>
            <td class="EditHead">填报说明</td>
            <td class="editTd" colspan="3">
                <textarea class='noborder' readonly="readonly"
                          rows="8" style="width:100%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${reportKeyRiskMonitor.tbsm}</textarea>
            </td>
        </tr>
        <tr>
            <td class="EditHead">填报人</td>
            <td class="editTd" >
                <s:property value="reportKeyRiskMonitor.applicant_name"/>
            </td>
            <td class="EditHead">填报时间</td>
            <td class="editTd">
                <s:property value="reportKeyRiskMonitor.tb_time"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead">填报单位部门</td>
            <td class="editTd">
                <s:property value="reportKeyRiskMonitor.applicant_fdepname"/>
            </td>
            <td class="EditHead">填报状态</td>
            <td class="editTd">
                <s:property value="reportKeyRiskMonitor.status_name"/>
            </td>
        </tr>
    </table>
</div>
</body>
<script type="text/javascript">
    $("#reportKeyRiskMonitorForm").find("textarea").each(function(){
        autoTextarea(this);
    });
    $(function () {
        $('#head'+"_${reportKeyRiskMonitor.file_id}").fileUpload({
            fileGuid:'${reportKeyRiskMonitor.file_id}' == ''?'-1':'${reportKeyRiskMonitor.file_id}',
            echoType:2,
            isDel:false,
            isEdit:false,
            uploadFace:1,
            triggerId:'content'+'_${reportKeyRiskMonitor.file_id}'
        });
        $('#head'+"_${reportKeyRiskMonitor.dfile_id}").fileUpload({
            fileGuid:'${reportKeyRiskMonitor.dfile_id}' == ''?'-1':'${reportKeyRiskMonitor.dfile_id}',
            echoType:2,
            isDel:false,
            isEdit:false,
            uploadFace:1,
            triggerId:'content'+'_${reportKeyRiskMonitor.dfile_id}'
        });

        var from = '${from}';
        if(from == '1') {
            var pageWin = window.top;
            if(pageWin && pageWin.reloadHomePage){
                pageWin.reloadHomePage();
            }
        }
    })
</script>
</html>
