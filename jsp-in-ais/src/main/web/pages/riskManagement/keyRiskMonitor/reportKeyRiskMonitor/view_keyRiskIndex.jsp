<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>重点风险事项查看</title>
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
    <script type="text/javascript">
        $(function () {
            $('#sDTable').datagrid({
                url:"<%=request.getContextPath()%>/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/view.action?querySource=grid&formId=${formId}",
                method:'post',
                showFooter:false,
                rownumbers:true,
                pagination:true,
                striped:true,
                autoRowHeight:false,
                fit: true,
                fitColumns:true,
                idField:'formId',
                border:false,
                singleSelect:true,
                pageSize:20,
                remoteSort: false,
                frozenColumns:[[
                    {field:'applicant_name',title:'填报人',halign:'center',align:'center',sortable:true, width:'9%'},
                    {field:'applicant_fdepname',title:'填报人所在单位部门',halign:'center',align:'center',sortable:true, width:'9%'},
                ]],
                columns:[[
                    {field:'status_name',
                        title:'填报状态',
                        halign:'center',
                        width:'15%',
                        sortable:true,
                        align:'center'
                    },
                    {field:'dfile_id',
                        title:'填报文件',
                        halign:'center',
                        width:'15%',
                        sortable:true,
                        align:'center',
                        formatter:function(value, rowData) {
                            var t = rowData.dfile_id;
                            var c = "<div  id=\"head_"+t+"\" ></div>";
                            /*div id="head_${reportKeyRiskMonitor.file_id}" style="float: left"></div>*/
                            return c;
                        }
                    },
                    {field:'tbsm',
                        title:'填报说明',
                        halign:'center',
                        width:'15%',
                        sortable:true,
                        align:'center'
                    },
                    {field:'tb_time',
                        title:'填报时间',
                        halign:'center',
                        width:'15%',
                        sortable:true,
                        align:'center'
                    },
                    {field:'rework_closed',
                        title:'操作',
                        halign:'center',
                        align:'center',
                        sortable:true,
                        width:'6%',
                        formatter:function(value,rowData,rowIndex){
                            return "<a href='#' onclick=\"view('" + rowData.year + "','"+rowData.dutyDeptId+"','"+rowData.formId+"')\">查看</a>";
                        }
                    }
                ]]
            });
            //单元格tooltip提示
            $('#sDTable').datagrid('doCellTip', {
                position : 'bottom',
                maxWidth : '200px',
                tipStyler : {
                    'backgroundColor' : '#EFF5FF',
                    borderColor : '#95B8E7',
                    boxShadow : '1px 1px 3px #292929'
                }

            });
            $('#head'+"_${reportKeyRiskMonitor.file_id}").fileUpload({
                fileGuid:'${reportKeyRiskMonitor.file_id}' == ''?'-1':'${reportKeyRiskMonitor.file_id}',
                echoType:2,
                isDel:false,
                isEdit:false,
                uploadFace:1,
                triggerId:'content'+'_${reportKeyRiskMonitor.file_id}'
            });
            /*var fileListDiv = "wordAttachFile_"+dfile_id;*/
            $('#head'+"_${reportKeyRiskMonitor.dfile_id}").fileUpload({
                fileGuid:'${reportKeyRiskMonitor.dfile_id}' == ''?'-1':'${reportKeyRiskMonitor.dfile_id}',
                isDel:false,
                isEdit:false,
                uploadFace:1,
                echoType:2,
            });
        });

        function view(year, dutyDeptId,formId) {
            var url = "${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/viewre.action?crudId="+formId;
            window.location.href=url;
        }


    </script>
</head>
<body style="margin: 0;padding: 0;overflow: scroll;" class="easyui-layout"  fit='true'>
<div title="专项填报查看">
    <table id="audBookTable" cellpadding=0 cellspacing=1 border=0 class="ListTable" align="center"  style="margin-top: 10px;">
        <s:hidden name="reportKeyRiskMonitor.formId"/>
        <s:hidden name="reportKeyRiskMonitor.startFormId"/>
        <s:hidden name="reportKeyRiskMonitor.sn"/>
        <s:hidden name="reportKeyRiskMonitor.year"/>
        <s:hidden name="reportKeyRiskMonitor.start_name"/>
        <s:hidden name="reportKeyRiskMonitor.tbyqsm"/>
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
            <td class="EditHead" style="width:15%;">编号</td>
            <td class="editTd" style="width:35%;">
                <s:property value="reportKeyRiskMonitor.sn"/>
            </td>
            <td class="EditHead" style="width:15%;"> 所属年度</td>
            <td class="editTd" style="width:35%;">
                <s:property value="reportKeyRiskMonitor.year"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead" style="width:15%;">专项填报任务</td>
            <td class="editTd" style="width:35%;" colspan="3">
                <s:property value="reportKeyRiskMonitor.start_name"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead" style="width:15%;">填报要求说明</td>
            <td class="editTd" style="width:35%;" colspan="3">
                <s:property value="reportKeyRiskMonitor.tbyqsm"/>
            </td>
        </tr>
        <tr>
            <td class="EditHead" style="width:15%;">填报开始时间</td>
            <td class="editTd" style="width:35%;">
                <s:property value="reportKeyRiskMonitor.start_time"/>
            </td>
            <td class="EditHead" style="width:15%;">填报截止时间</td>
            <td class="editTd" style="width:35%;">
                <s:property value="reportKeyRiskMonitor.end_time"/>
            </td>
        </tr>
<%--        <tr>
            <td class="EditHead" style="width:15%;">分发的填报部门</td>
            <td class="editTd" style="width:35%;">
                <s:property value="reportKeyRiskMonitor.impDeptName"/>
            </td>
            <td class="EditHead" style="width:15%;"></td>
            <td class="editTd" style="width:35%;"></td>
        </tr>--%>
        <tr>
            <td class="EditHead" style="width:15%;">填报文件要求格式</td>
            <td class="editTd" style="width:35%;" colspan="3">
                <div id="head_${reportKeyRiskMonitor.file_id}" style="float: left"></div>
            </td>
        </tr>
    </table>
</div>
<br/>
<%--<s:if test="reportKeyRiskMonitor.impDeptName != null">
    <table id='sDTable' style="margin-top: 20px;" title="分发的填报部门填报明细"></table>
</s:if>--%>

</body>
</html>
