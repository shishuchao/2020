<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
    <title>编辑重点风险事项监控填报任务</title>
    <link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-fileUpload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
        <style type="text/css">
    .datebox-button table td{
     text-align: center !important;
    }
    
    </style>
    <script type="text/javascript">
        $(function () {
            if('${suc}' == '1') {
                showMessage1('保存成功！');
            }
            changeJjzrr('${keyRiskMonitor.taskType}');
            if('${keyRiskMonitor.formId}' == '') {
                $('#file_id').hide();
            }

            $("#keyRiskMonitorForm").find("textarea").each(function(){
                autoTextarea(this);
            });
            $('#head'+"_${keyRiskMonitor.file_id}").fileUpload({
                fileGuid:'${keyRiskMonitor.file_id}' == ''?'-1':'${keyRiskMonitor.file_id}',
                echoType:2,
                isDel:true,
                isEdit:true,
                uploadFace:1,
                triggerId:'content'+'_${keyRiskMonitor.file_id}'
            });


            $('#taskType').combobox({
                url:'${contextPath}/pages/riskManagement/keyRiskMonitor/startKeyRiskMonitor/taskType.json',
                valueField:'pkey',
                textField:'ptext',
                editable:false,
                panelHeight:80,
                onLoadSuccess:function(data){
                },
                onChange:function(newVal,oldVal){
                    $('#applicant_name').val('');
                    $('#applicant').val('');
                    $('#dutyDeptName').val('');
                    $('#dutyDeptId').val('');
                    changeJjzrr(newVal);
                }
            });
        });
        /*   保存 */
        function toSave() {
            if(audEvd$validateform('keyRiskMonitorForm')){
                if (check()){
                    var keyRiskMonitorForm = document.getElementById('keyRiskMonitorForm');
                    keyRiskMonitorForm.submit();
                }

            }
        }
        /* 提交 */
        function toSubmit(){
            if(audEvd$validateform('keyRiskMonitorForm')){
                if (check() && checkFile()){
                    var keyRiskMonitorForm = document.getElementById('keyRiskMonitorForm');
                    keyRiskMonitorForm.action="toSubmit.action";
                    keyRiskMonitorForm.submit();
                }

            }
        }

        function check(){
            var t = true;
            var s = $("#start_time").datebox('getValue');
            var e = $("#end_time").datebox('getValue');
            if(s!='' && e!=''){
                var s_date=new Date(s.replace("-","/"));
                var e_date=new Date(e.replace("-","/"));
                if(s_date.getTime()>e_date.getTime()){
                    $.messager.alert("错误","日期区间开始必须小于等于结束!");
                    return false;
                }
            }
            return t;
        }

        function checkFile(){
            var c = true ;
            $.ajax({
                url:'<%=request.getContextPath()%>/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/checkTbFile.action',
                type:'post',
                dataType:'json',
                data:{'file_id':'${keyRiskMonitor.file_id}'},
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

        //根据选择的审计单位查询出责任人
        function getDutyDeptId(){
            if($('#applicant').val() != '') {
                $.ajax({
                    url:'${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/getDeptOrUser.action',
                    async:false,
                    type:'post',
                    data:{'type':'1','applicant':$('#applicant').val()},
                    success:function(data){
                        $('#dutyDeptId').val(data.dutyDeptId);
                        $('#dutyDeptName').val(data.dutyDeptName);
                    }
                });
            }
        }

        function getApplicant(){
            if($('#dutyDeptId').val() != '') {
                $.ajax({
                    url:'${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/getDeptOrUser.action',
                    async:false,
                    type:'post',
                    data:{'type':'2','dutyDeptId':$('#dutyDeptId').val()},
                    success:function(data){
                        if(data.suc == '1') {
                            $('#applicant_name').val(data.applicant_name);
                            $('#applicant').val(data.applicant);
                        } else {
                            showMessage1("填报单位[" + data.dept +"]缺失联系人！" );
                        }
                    }
                });
            }
        }

        function getApplicant02(){
            if($('#dutyDeptId').val() != '') {
                $.ajax({
                    url:'${contextPath}/riskManagement/keyRiskMonitor/reportKeyRiskMonitor/getDeptOrUser.action',
                    async:false,
                    type:'post',
                    data:{'type':'3','dutyDeptId':$('#dutyDeptId').val()},
                    success:function(data){
                        if(data.suc == '1') {
                            $('#applicant_name').val(data.applicant_name);
                            $('#applicant').val(data.applicant);
                        } else {
                            showMessage1("填报单位[" + data.dept +"]被审计单位反馈账号！" );
                        }
                    }
                });
            }
        }

        function  changeJjzrr(value){
            if(value=="审计单位" || value=="被审计单位"){//责任人弹出的选择框为组织机构框
                $('#applicant_img').hide();
                $('#tr_dutyDeptId').show();
            } else if(value=="审计人员"){//责任人弹出的选择框为所有的项目组成员
                $('#applicant_img').show();
                $('#tr_dutyDeptId').hide();
            } else {
                $('#applicant_img').hide();
                $('#tr_dutyDeptId').hide();
            }
        }

        function getDeptOrObj(obj) {
            var taskType = $("#taskType").combobox('getValue');
            if(taskType == '审计单位') {
                getAuditDept(obj);
            } else {
                getAuditObj(obj);
            }
        }

        function getAuditDept(obj) {
            showSysTree(obj,
                { url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                    title:'请选择填报单位',
                    checkbox:true,
                    param:{
                        'p_item':3
                    },
                    cache:false,
                    onAfterSure:getApplicant
                });
        }

        function getAuditObj(obj) {
            showSysTree(obj,
                { url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                    title:'请选择填报单位',
                    checkbox:true,
                    param:{
                        'departmentId':'${magOrganization.fid}'
                    },
                    cache:false,
                    onAfterSure:getApplicant02
                })
        }
    </script>
</head>

<body onload="sucFun();"  style="overflow: auto;overflow-x:hidden;" class="easyui-layout">
<div region="center" style="overflow-x:hidden ">
    <div region="south" border="false" style="text-align:right;padding-right:20px;">
        <s:if test="${keyRiskMonitor.formId != null}">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="this.style.disabled='disabled';toSubmit()">提交</a>&nbsp;&nbsp;
        </s:if>
        <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';toSave()">保存</a>&nbsp;&nbsp;
        <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location.href='<%=request.getContextPath()%>/riskManagement/keyRiskMonitor/startKeyRiskMonitor/startKeyRiskMonitorList.action'">返回</a>
    </div>

    <s:form id="keyRiskMonitorForm" action="saveInfo" namespace="/riskManagement/keyRiskMonitor/startKeyRiskMonitor">
        <table id="audBookTable" cellpadding=0 cellspacing=1 border=0 class="ListTable" align="center">
            <tr>
                <s:hidden name="keyRiskMonitor.formId"/>
                <s:hidden name="keyRiskMonitor.status"/>
                <s:hidden name="keyRiskMonitor.status_name"/>
                <s:hidden name="keyRiskMonitor.creater"/>
                <s:hidden name="keyRiskMonitor.create_name"/>
                <s:hidden name="keyRiskMonitor.create_depId"/>
                <s:hidden name="keyRiskMonitor.create_depName"/>
                <s:hidden name="keyRiskMonitor.create_time"/>
                <s:hidden name="keyRiskMonitor.serialNumber"/>
                <s:hidden name="keyRiskMonitor.start_code"/>
                <s:hidden name="keyRiskMonitor.file_id"/>
                    <%--<s:hidden name="keyRiskMonitor.dutyDeptName"/>--%>
                <input type="hidden" name="suc" id="sucFlag" value="${suc}"/>
                <td class="EditHead"><font color="red">*</font> 所属年度</td>
                <td class="editTd">
                    <select class="easyui-combobox" name="keyRiskMonitor.year" id="pro_year" editable="false">

                        <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
                            <s:if test="${keyRiskMonitor.year == key}">
                                <option selected="selected"  value="<s:property value=" key "/>"><s:property value="value" /> </option>
                            </s:if>
                            <s:else>
                                <option value="<s:property value=" key "/>"><s:property value="value" /> </option>
                            </s:else>

                        </s:iterator>
                    </select>
                </td>
                <td class="EditHead">编号</td>
                <td class="editTd">
                    <s:property value="keyRiskMonitor.start_code"/>
                </td>
            </tr>
            <tr>
                <td class="EditHead"><font color="red">*</font>专项填报任务</td>
                <td class="editTd">
                    <input type="text" id="start_name" name="keyRiskMonitor.start_name"  editable="false"
                           value="${keyRiskMonitor.start_name}" class="noborder editElement required len200 " title="专项填报任务" />
                </td>
                <%--<td class="EditHead">关联填报任务</td>
                <td class="editTd">
                    <s:buttonText2 name="keyRiskMonitor.relatedSkrms" cssClass="noborder" id="relatedSkrms" hiddenId="relatedSkrmIds"
                                   hiddenName="keyRiskMonitor.relatedSkrmIds"  doubleOnclick="showSysTree(this,
								{ title:'请选择关联专项填报任务',
								  checkbox:true,
                                  param:{
                                    'beanName':'StartKeyRiskMonitor',
									'treeId'  :'formId',
									'treeText':'start_name',
									'treeParentId':'formPid',
									'treeOrder':'start_code',
									'rootParentId':'0'
                                  }
								})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" readonly="true" />
                </td>--%>
                <td class="EditHead"><font class="editElement"  color=red>*</font>任务对象类型</td>
                <td class="editTd">
                    <s:if test="${view !=true}">
                        <input id="taskType" name="keyRiskMonitor.taskType" value="${keyRiskMonitor.taskType}" editable="false" class="editElement required" title="任务对象类型">
                    </s:if>
                    <s:else>
                        <span id='view_taskType' class="noborder viewElement clear" style='width:50%;display:inline;'>${keyRiskMonitor.taskType}</span>
                    </s:else>
                </td>
            </tr>
            <tr>
                <td class="EditHead">
                    <font color="red">*</font>填报要求说明
                    <div><font color="DarkGray">（1000字以内）</font></div>
                </td>
                <td class="editTd" colspan="3">
						<textarea type='text' id='tbyqsm' name='keyRiskMonitor.tbyqsm' title="填报要求说明"
                                  class="noborder editElement required clear len1000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${keyRiskMonitor.tbyqsm}</textarea>
                </td>
            </tr>
            <tr>
                <td class="EditHead"><font color="red">*</font>填报开始时间</td>
                <td class="editTd">
                    <input type="text" id="start_time" name="keyRiskMonitor.start_time"  editable="false" title="填报开始时间"
                           value="${keyRiskMonitor.start_time}" class="noborder editElement required easyui-datebox"/>
                </td>
                <td class="EditHead"><font color="red">*</font>填报截止时间</td>
                <td class="editTd" >
                    <input type="text" id="end_time" name="keyRiskMonitor.end_time"  editable="false" title="填报截止时间"
                           value="${keyRiskMonitor.end_time}" class="noborder editElement required  easyui-datebox"/>
                </td>
            </tr>
            <tr id="tr_dutyDeptId">
                <td class="EditHead"><font color="red">*</font>填报单位</td>
                <td class="editTd" colspan="3">
                    <s:buttonText2 title="填报单位" id="dutyDeptName"  hiddenId="dutyDeptId" name="keyRiskMonitor.dutyDeptName" cssClass="noborder editElement" cssStyle="width:72%" hiddenName="keyRiskMonitor.dutyDeptId"
                                   doubleOnclick="getDeptOrObj(this)"
                                   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" readonly="true" />
                </td>
            </tr>
            <tr>
                <td class="EditHead"><font class="editElement"  color=red>*</font>填报人</td>
                <td class="editTd" colspan='3'>
                    <input type='text' id='applicant_name' name='keyRiskMonitor.applicant_name' title="填报人" value="${keyRiskMonitor.applicant_name}" style="width:72%"
                           class="noborder editElement clear required" readonly/>
                    <input type='hidden' id='applicant' name='keyRiskMonitor.applicant' title="填报人ID"  value="${keyRiskMonitor.applicant}"
                           class="noborder editElement clear"/>
                    <img id="applicant_img" style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class="editElement "
                          onclick="showSysTree(this,
                                  {	  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  title:'组织机构选择',
                                  checkbox:true,
                                  defaultDeptId:'${user.fdepid}',
                                  param:{
                                  'p_item':3
                                  },
                                  type:'treeAndUser',
                                  onAfterSure:getDutyDeptId
                                   })"></img>
                </td>
            </tr>
            <tr id="file_id">
                <td class="EditHead"><font color="red">*</font>填报文件要求格式</td>
                <td class="editTd" colspan="3">
                    <div id="head_${keyRiskMonitor.file_id}" style="float: left"></div>
                    <div id="content_${keyRiskMonitor.file_id}" style="float: right"></div>
                </td>
            </tr>
        </table>
    </s:form>
</div>
<%--<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />--%>
</body>

<script type="text/javascript">

    function sucFun(){
        if($("#suc").val()=='1'){
            $("#suc").val('');
            showMessage2('保存成功');
        }
    }
</script>
</html>
