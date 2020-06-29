<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>任务填报</title>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
    <script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript">
        /*
        保存
         */
        function toSave() {
            if(audEvd$validateform('reportKeyRiskMonitorForm')){
                var reportKeyRiskMonitorForm = document.getElementById('reportKeyRiskMonitorForm');
                $.ajax({
                    url:'<%=request.getContextPath()%>/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/checkTbFile.action',
                    type:'post',
                    dataType:'json',
                    data:$("#reportKeyRiskMonitorForm").serialize(),
                    success:function(data){
                        if(data=="0"){
                            showMessage1("填报文件为必填项！");
                        }else{
                            reportKeyRiskMonitorForm.submit();
                        }
                    }
                });

            }
        }


        function check(){
            var c = true ;
            $.ajax({
                url:'<%=request.getContextPath()%>/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/checkTbFile.action',
                type:'post',
                dataType:'json',
                data:$("#reportKeyRiskMonitorForm").serialize(),
                async:false,
                success:function(data){
                    if(data=="0"){
                        c = false ;
                        showMessage1("填报文件为必填项！");
                    }
                }
            });
            return c;
        }

        function beforStartProcess() {
            var result = check();
            if(result) {
                $('#submitButton2Start').linkbutton('disable');
                reportKeyRiskMonitorForm.action =  "<s:url action="start" includeParams="none"/>";
            }
            return result;
        }

        function toSubmit(act){
            var result = check();
            if(result) {
                <s:if test="isUseBpm=='true'">
                if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
                    var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
                    if(actor_name==''){
                        $.messager.show({title:'提示信息',msg:'下一步处理人不能为空！'});
                        return false;
                    }
                }
                </s:if>
                jQuery("#reportKeyRiskMonitorForm").attr("action","submit.action?from=${from}");
                jQuery("#reportKeyRiskMonitorForm").submit();
            }
            return result;
        }
    </script>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
<body onload="end();sucFun();" style="margin: 0;padding: 0;overflow: hidden;" class="easyui-layout">
</s:if>
<s:else>
<body onload="sucFun();" style="margin: 0;padding: 0;overflow: hidden;" class="easyui-layout">
</s:else>
<div region="center" fit='true'>

    <s:form id="reportKeyRiskMonitorForm" action="saveInfo" namespace="/riskManagement/keyRiskMonitor/reportKeyRiskMonitor">
        <div style="width: 98%;position:absolute;top:0px;" id="div1" align="center" >
            <table class="ListTable" align="center" style='width: 98.3%; padding: 0px; margin: 0px;'>
                <tr class="EditHead">
                    <td >
						<span style='float: left; text-align: left;'>
						<s:property value="#title" /></span>
                    </td>
                    <td>
						<span style='float: right; text-align: right;'>
							<s:if test="crudObject.formId!=null">
                                <jsp:include flush="true"
                                             page="/pages/bpm/list_toBeStart.jsp" />
                            </s:if>
							<a href="javascript:void(0);" id="root" class="easyui-linkbutton"  data-options="iconCls:'icon-save'" onclick="toSave();">保存</a>&nbsp;
							<s:if test="${from ne '1'}">
                            <s:if test="${ param.todoback ne '1' }">
							  <a class="easyui-linkbutton" style="margin-left: -5px" data-options="iconCls:'icon-undo'"
                                 onclick="this.style.disabled='disabled';window.location.href='${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/listReportKeyRiskMonitor.action'">返回</a>
                            </s:if>
		 					<s:else>
                                <s:if test="${taskInstanceId!=null&&taskInstanceId>0} && ${todoback == '1' }">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"
                                       onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'">返回</a>
                                </s:if>
                            </s:else>
                            </s:if>
						</span>
                    </td>
                </tr>
            </table>
        </div>



        <div class="position:relative">
            <table id="audBookTable" cellpadding=0 cellspacing=1 border=0 class="ListTable" align="center"  style="margin-top: 40px;">
                <s:hidden name="from" value="${from}"/>
                <s:hidden name="crudObject.formId"/>
                <s:hidden name="crudObject.startFormId"/>
                <s:hidden name="crudObject.sn"/>
                <s:hidden name="crudObject.year"/>
                <s:hidden name="crudObject.start_name"/>
                <s:hidden name="crudObject.tbyqsm"/>
                <s:hidden name="crudObject.start_time"/>
                <s:hidden name="crudObject.end_time"/>
                <s:hidden name="crudObject.file_id"/>
                <s:hidden name="crudObject.dfile_id"/>
                <s:hidden name="crudObject.status_name"/>
                <s:hidden name="crudObject.status"/>
                <s:hidden name="crudObject.applicant_name"/>
                <s:hidden name="crudObject.applicant"/>
                <s:hidden name="crudObject.applicant_fdepid"/>
                <s:hidden name="crudObject.applicant_fdepname"/>
                <s:hidden name="crudObject.tb_time"/>
                <s:hidden name="crudObject.dutyDeptId"/>
                <s:hidden name="crudObject.dutyDeptName"/>
                <s:hidden name="crudObject.tb"/>
                <s:hidden name="crudObject.impDept"/>
                <s:hidden name="crudObject.impDeptName"/>
                <s:hidden name="crudObject.impPersonName"/>
                <s:hidden name="crudObject.impPerson"/>
                <s:hidden name="crudObject.taskType"/>
                <s:hidden name="crudObject.source"/>
                <s:hidden name="suc" id="suc" />
                <tr>
                    <td class="EditHead" style="width:15%;">编号</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.sn"/>
                    </td>
                    <td class="EditHead" style="width:15%;"> 所属年度</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.year"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%;">专项填报任务</td>
                    <td class="editTd" style="width:35%;" colspan="3">
                        <s:property value="crudObject.start_name"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%;">填报要求说明</td>
                    <td class="editTd" style="width:35%;" colspan="3">
                        <s:property value="crudObject.tbyqsm"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%;">填报开始时间</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.start_time"/>
                    </td>
                    <td class="EditHead" style="width:15%;">填报截止时间</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.end_time"/>
                    </td>
                </tr>
<%--                <tr>
                    <td class="EditHead" style="width:15%;">发起人</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.impPersonName"/>
                    </td>
                    <td class="EditHead" style="width:15%;">发起单位部门</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.impDeptName"/>
                    </td>
                </tr>--%>
                <tr>
                    <td class="EditHead" style="width:15%;">填报文件要求格式</td>
                    <td class="editTd" style="width:35%;" colspan="3">
                        <div id="head_${crudObject.file_id}" style="float: left"></div>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%;"><font color="red">*</font>填报文件</td>
                    <td class="editTd" colspan="3">
                        <div id="head_${crudObject.dfile_id}" style="float: left" class="required"></div>
                        <div id="content_${crudObject.dfile_id}" style="float: right"></div>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%;">填报说明</td>
                    <td class="editTd" style="width:35%;" colspan="3">
                        <textarea type='text' id='tbsm' name='crudObject.tbsm'
                                  class="noborder editElement clear" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${crudObject.tbsm}</textarea>
                    </td>
                </tr>
                <s:if test="${crudObject.reason != null && crudObject.reason != ''}">
                    <tr>
                        <td class="EditHead" style="width:15%;">驳回原因</td>
                        <td class="editTd" style="width:35%;" colspan="3">
                            <s:property value="crudObject.reason"></s:property>
                        </td>
                    </tr>
                </s:if>
                <tr>
                    <td class="EditHead" style="width:15%;">填报人</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.applicant_name"/>
                    </td>
                    <td class="EditHead" style="width:15%;">填报时间</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.tb_time"/>
                    </td>
                </tr>
                <tr>
                    <td class="EditHead" style="width:15%;">填报单位部门</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.applicant_fdepname"/>
                    </td>
                    <td class="EditHead" style="width:15%;">填报状态</td>
                    <td class="editTd" style="width:35%;">
                        <s:property value="crudObject.status_name"/>
                    </td>
                </tr>
            </table>
        </div>

        <s:if test="${taskInstanceId ne -1}">
            <div align="center">
                <jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
            </div>
        </s:if>

        <div align="center">
            <jsp:include flush="true"
                         page="/pages/bpm/list_taskinstanceinfo.jsp" />
        </div>
    </s:form>
</div>
</body>
<script type="text/javascript">
    $("#reportKeyRiskMonitorForm").find("textarea").each(function(){
        autoTextarea(this);
    });
    $(function () {
        $('#head'+"_${crudObject.file_id}").fileUpload({
            fileGuid:'${crudObject.file_id}' == ''?'-1':'${crudObject.file_id}',
            echoType:2,
            isDel:false,
            isEdit:false,
            uploadFace:1,
            triggerId:'content'+'_${crudObject.file_id}'
        });
        $('#head'+"_${crudObject.dfile_id}").fileUpload({
            fileGuid:'${crudObject.dfile_id}' == ''?'-1':'${crudObject.dfile_id}',
            echoType:2,
            isDel:true,
            isEdit:true,
            uploadFace:1,
            triggerId:'content'+'_${crudObject.dfile_id}'
        });
    })
    function sucFun(){
        if($("#suc").val()=='1'){
            $("#suc").val('');
            showMessage1('保存成功！');
        }
    }

    function doStart(){
        document.getElementById('reportKeyRiskMonitorForm').action = "start.action";
        document.getElementById('reportKeyRiskMonitorForm').submit();
    }

</script>
</html>
