<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>复制底稿</title>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript">
        $(function () {
            try {
                aud$loadClose();
            } catch (e) {
            }

            function saveManus() {
                try {
                    var auditObjectSelect = $('#auditObjectSelect').combobox('getValue');
                    if(auditObjectSelect==''){
                    	showMessage1('被审计单位必输');
                    	return false;
                    }
                    var manuCom_task_name = $('#manuCom_task_name').val();
                    if(manuCom_task_name==''){
                    	showMessage1('审计事项必输');
                    	return false;
                    }
                    var manuCom_ms_name = $('#manuCom_ms_name').val();
                    if(manuCom_ms_name==''){
                    	showMessage1('底稿名称必输');
                    	return false;
                    }
                	
                	aud$saveForm('manuForm', "${contextPath}/project/saveCopyManus.action", function (data) {
                        if (data) {
                            data.msg ? showMessage1(data.msg) : null;
                            if (data.type == 'info') {
                                try {
                                    var tabWin = aud$parentDialogWin();
                                    if (tabWin.doSearch) {
                                        tabWin.doSearch();
                                        setTimeout(aud$closeTab, 0);
                                    }
                                } catch (e) {
                                }
                            }
                        }
                    });
                } catch (e) {
                    alert("saveManus:\n" + e.message);
                }
            }

            $('#gSaveBtn').bind('click', function () {
                saveManus();
            })
            $('#gCloseBtn').bind('click', function () {
                aud$closeTab();
            })


            //被审计单位下拉
            var auditData = [];
            var aoCodes = "${audit_object}".split(",");
            var aoNames = "${audit_object_name}".split(",");
            for (var i = 0; i < aoCodes.length; i++) {
                auditData.push({
                    'code': aoCodes[i],
                    'name': aoNames[i]
                });
            }
            aud$genSelectOption("auditObjectSelect", auditData);
            $('#auditObjectSelect').combobox({
                'editable': false,
                'panelHeight': 'auto',
                onSelect: function (r) {
                    //QUtil.showJson(r)
                    $('#manuCom_audit_dept_name').val(r.text);
                }
            });
        });

        function aud$taskClick(node) {
            var obj = (new Function('return ' + node.attributes))();
            //QUtil.showJson(obj)
            $('#manuCom_task_code').val(obj.taskCode);
            $('#manuCom_taskPid').val(obj.taskPid);
        }
    </script>
    <style type="text/css">
        input[class~=editElement] {
            width: 85% !important;
        }
    </style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' border='0' fit='true'>
<div region='north' border='0' style='padding:0px;overflow:hidden;'>
    <div id='btnBar'
         style='text-align:right;padding:3px 5px 3px 0px;border-bottom:1px solid #cccccc;background-color:#fafafa;'>
        <a id='gSaveBtn' class="easyui-linkbutton editElement" iconCls="icon-save" style='border-width:0px;'>保存</a>
        <a id='gCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>
    </div>
</div>
<div region='center' border='0' title="" split="true" id="layoutCenter" style="overflow-x:hidden;">
    <!-- 底稿表单 -->
    <form id="manuForm" name="manuForm">
        <input type="hidden" name="curProjectId" value="${curProjectId}"/>
        <input type="hidden" name="manuCom.project_id" value="${curProjectId}"/>
        <input type="hidden" name="manuIds" value="${manuIds}"/>
        <table class="ListTable" align="center" style='table-layout:fixed;margin-top:-2px;padding:0px;width:100%;'>
            <tr>
                <td class="EditHead" style="width:15%;border-left-width:0px;" nowrap>底稿状态</td>
                <td class="editTd" style="width:35%;border-right-width:0px;">
                    <input type='hidden' name="manuCom.ms_status" value="010"/>
                    <span>底稿草稿</span>
                </td>

                <td class="EditHead" nowrap>
                    <font class='editElement' color='red'>*</font>被审计单位
                </td>
                <td class="editTd" style="border-right-width:0px;">
                    <input type='hidden' id='manuCom_audit_dept_name' name='manuCom.audit_dept_name'
                           class="noborder editElement clear required" title="被审计单位"/>
                    <select id="auditObjectSelect" name="manuCom.audit_dept"></select>
                </td>

            </tr>
            <tr>
                <td class="EditHead" style="width:15%;" nowrap>
                    <font class='editElement' color='red'>*</font>审计事项
                </td>
                <td class="editTd" style="width:35%;border-right-width:0px;">
                    <input type='text' id='manuCom_task_name' name='manuCom.task_name' title="审计事项"
                           class="noborder editElement clear required" readonly/>
                    <input type='hidden' id = 'manuCom_task_id' name='manuCom.task_id' title="审计事项ID"
                           class="noborder editElement clear required"/>
                    <a class="easyui-linkbutton  editElement" iconCls="icon-search" style='border-width:0px;'
                       onclick="showSysTree(this,{
                               title:'审计事项选择',
                               param:{
                               'serverCache':false,
                               'plugId':'audTask_${curProjectId}',
                               'leafCondition':'template_type=2',
                               'rootParentId':'-1',
                               'whereHql':'project_id=\'${curProjectId}\'',
                               'beanName':'AudTask',
                               'treeId'  :'taskTemplateId',
                               'treeText':'taskName',
                               'treeParentId':'taskPid',
                               'treeOrder':'taskCode',
                               'treeAtrributes':'taskCode,taskPid,template_type'
                               },
                               onAfterSure:function(dms, mcs){
                               $('#manuCom_ms_name').val(mcs[0]);
                               },
                               onTreeClick:aud$taskClick
                               })"></a>
                    <input type='hidden' id="manuCom_task_code" name='manuCom.task_code' title="审计事项Code"
                           class="noborder editElement clear required" readonly/>
                    <input type='hidden' id="manuCom_taskPid" name='taskPid' title="审计事项pid"
                           class="noborder editElement clear required" readonly/>
                </td>
                <td class="EditHead" style="border-left-width:0px;" nowrap>
                    <font class='editElement' color='red'>*</font>底稿名称
                </td>
                <td class="editTd" style="border-right-width:0px;">
                    <input type="text" id="manuCom_ms_name" name="manuCom.ms_name"
                           class="noborder editElement clear required" title="底稿名称"/>
                </td>

            </tr>
            <tr>
                <td class="EditHead" style="border-left-width:0px;" nowrap>撰写人</td>
                <td class="editTd" style="border-right-width:0px;">
                    <input type='hidden' name="manuCom.ms_author" value="${user.floginname}"/>
                    <input type='hidden' name="manuCom.ms_author_name" value="${user.fname}"/>
                    <span>${user.fname}</span>
                </td>
                <td class="EditHead" nowrap>创建日期</td>
                <td class="editTd" style="border-right-width:0px;">
                    <input type='hidden' name="manuCom.ms_date" value="${curDate}"/>
                    <span>${curDate}</span>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>