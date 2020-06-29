<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE HTML >
<html>
<title>三年计划</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-parseExcel.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

<script type="text/javascript">
var isView = "${view}" == true || "${view}" == "true" ? true : false;
var tabTitle = isView ? '查看' : '编辑';

//刷新三年计划列表
function refreshParentWin(){
    var tabWin = aud$parentDialogWin();
    tabWin && tabWin.yearPlanList ? tabWin.yearPlanList.refresh() : null;
}

$(function(){
    //设置编辑或者查看
    isView ?  $('.editElement').remove() : $('.viewElement').remove();

    if(!isView){
        $('#mSaveBtn').bind('click', function(){
            saveYearPlan();
        });
        $('#mPostBtn').bind('click', function(){
            if($('#crudObject_planStatus').val() == '1000'&&'${isUseBpm}' == 'true'){
                $('#submitButton2Start').click();
			}else{
                $('#submitButton').click();
			}
        });

        setPostBtnStatus();

    }else{
        $("#mSaveBtn,#mPostBtn").remove();
    }

    function setPostBtnStatus(){
        if($('#crudObject_planStatus').val() != '1002'){
            $("#mPostBtn").show();
        }else{
            $("#mPostBtn").hide();
        }
    }

    var textareaIds = ["importantPlanDesc","economicAuditDesc"];
    $.each(textareaIds, function(n, tsuffix){
        autoTextarea(isView ?  $('#view_'+tsuffix)[0] : $('#crudObject_'+tsuffix)[0]);
    });

    var currentYear = '${crudObject.planYearStart}' == '0'?"${curYear}":'${crudObject.planYearStart}';
    if(!isView){
        var offsetYear = 38;
        var yearArr = [];
        for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
            yearArr.push({
                'code':i,
                'name':i
            });
        }

        aud$genSelectOption('crudObject_planYearStart', yearArr, currentYear, {
			'panelHeight':offsetYear > 10 ? '200px' : 'auto',
            onChange:function(newValue,oldValue){
                $('#crudObject_planYearEnd').html(parseInt(newValue)+2);
                $('#planYearEnd').val(parseInt(newValue)+2);
			}
        });
	}

	if('${crudObject.planYearEnd}' == '0'){
        $('#crudObject_planYearEnd').html(parseInt(currentYear)+2);
        $('#planYearEnd').val(parseInt(currentYear)+2);
    }


    function saveYearPlan(){
        if('${crudObject.formId}' != ''){
            //此处先保存审计项目
        }
        if(checkDeprecatedTerm()){
			aud$saveForm('planForm', "${contextPath}/plan/3year/save.action", function(data){
				if(data){
					data.msg ? showMessage1(data.msg) : null;
					if(data.type == 'info'){
                        setTimeout(function () {
                            refreshParentWin();
                            if(data.isAdd){
                                window.location.href='${contextPath}/plan/3year/edit.action?crudId='+data.formId;
                            }else{
                                window.location.reload();
                            }
                            //aud$closeTab();
                        },500);

					}
				}
			});
		}
    }


});

function checkDeprecatedTerm(){
    var ret = true;
    var start = $('#crudObject_planYearStart').combobox('getValue');
    $.ajax({
        url : "${contextPath}/plan/3year/checkDeprecatedTerm.action",
        dataType:'json',
        type: "post",
        data: {
            'planYearStart':start,
            'planYearEnd':$('#crudObject_planYearEnd').text(),
            'auditDept':$('#crudObject_auditDept').val(),
            'formId':$('#crudObject_formId').val()
        },
        cache:false,
		async:false,
        success: function(data){
            if(data.type == 'error'){
                showMessage1(data.msg);
                ret = false;
            }
        },
        error:function(data){
            top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
        }
    });
    return ret;
}


/*
           启动前校验
       */
function beforStartProcess(){
    var bool = true;//提交表单判断参数
    bool = audEvd$validateform('planForm');
    if(!bool){
        bool = false;
        return false;
    }

    if(!checkDeprecatedTerm()){
        bool = false;
        return false;
    }
    var flowForm = document.getElementById('planForm');

    flowForm.submit();
    return true;
}

function toSubmit(){
    var bool = true;//提交表单判断参数
    bool = audEvd$validateform('planForm');
    if(!bool){
        bool = false;
        return false;
    }

    if(!checkDeprecatedTerm()){
        bool = false;
        return false;
    }

    <s:if test="isUseBpm=='true'">
    if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
        var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
        if(actor_name==''){
            window.parent.$.messager.show({
                title:'提示信息',
                msg:"下一步处理人不能为空",
                timeout:5000,
                showType:'slide'
            });
            return false;
        }
    }
    </s:if>

    if(bool){
        top.$.messager.confirm('确认', '确认提交吗？', function(r) {
            if (r) {
                var url = "<s:url action="directSubmit" includeParams="none"/>";
                <s:if test="isUseBpm=='true'">
                url = "<s:url action="submit" includeParams="none"/>";
                </s:if>
                $('#planForm').form('submit',{
                    url:url,
                    onSubmit:function(){
                        var bool = true;//提交表单判断参数
                        bool = audEvd$validateform('planForm');
                        if(!bool){
                            return false;
                        }
                        if(!checkDeprecatedTerm()){
                            return false;
                        }
                        return bool;
                    },
                    success:function(data){
                        var json = $.parseJSON(data);
                        if(json.msg != ''){
                            showMessage1(json.msg);
						}

                        setTimeout(function () {
                            refreshParentWin();
                            aud$closeTab();
                        },500);
                    }
                });
                return true;
            } else {
                return false;
            }

        });
    }
}

</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
<body style='padding:0px;margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true' onload="end();">
</s:if>
<s:else>
<body style='padding:0px;margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true'>
</s:else>

	<div region='north' border='0' style='padding:0px;margin:0px;overflow:hidden;'>
		<div id='btnBar' style='text-align:right;padding-right:10px;border-bottom:1px solid #cccccc;width:100%;'>
			<a id='mSaveBtn'  class="easyui-linkbutton" iconCls="icon-save" style='border-width:0px;'>保存</a>
			<c:choose>
				<c:when test="${crudObject.planStatus eq '1000' and isUseBpm eq 'true'}">
					<s:if test="crudObject.formId!=null">
						<a id='mPostBtn'  class="easyui-linkbutton" iconCls="icon-ok" style='border-width:0px;'>提交审批</a>
					</s:if>
				</c:when>
				<c:when test="${crudObject.planStatus ne '1002'}">
					<a id='mPostBtn'  class="easyui-linkbutton" iconCls="icon-ok" style='border-width:0px;'>提交</a>
				</c:when>
			</c:choose>

 			<a id='mCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;' onclick="aud$closeTab();">关闭</a>
		</div>	
	</div>
	<div region='center' border='0' title="" split="true" id="layoutCenter">
		<form id="planForm" name="planForm" method="post">
			<input type="hidden" id="crudObject_formId" name="crudObject.formId" value="${crudObject.formId}"/>
			<table class="ListTable" align="center" style='width:100%;table-layout:fixed;margin-top:-2px;'>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>计划状态</td>
					<td class="editTd">
						<input type='hidden' id='crudObject_planStatus' name='crudObject.planStatus' value="${crudObject.planStatus}" readonly/>
						<span id='view_planStatusName'>${crudObject.planStatusName}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap>三年计划编号</td>
					<td class="editTd">
						<input type='hidden' id='crudObject_planCode' name='crudObject.planCode' value="${crudObject.planCode}" readonly/>
						<span id='view_planCode'>${crudObject.planCode}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><label class="editElement" style="color: red">*</label>计划名称</td>
					<td class="editTd">
						<input type='text' id='crudObject_planName' name='crudObject.planName' value="${crudObject.planName}"
							   title='计划名称' class="noborder editElement clear required"/>
						<span id='view_planName' class="noborder viewElement clear" >${crudObject.planName}</span>
					</td>
					<td class="EditHead" style="width:15%;" nowrap><label class="editElement" style="color: red">*</label>三年计划期间</td>
					<td class="editTd">
						<select id='crudObject_planYearStart' name='crudObject.planYearStart' class="editElement clear required"></select>
						<input type='hidden' id='planYearEnd' name='crudObject.planYearEnd' value="${crudObject.planYearEnd}" readonly/>
						<span id='view_planYearStart' class="viewElement clear">${crudObject.planYearStart}</span>
						-<span id='crudObject_planYearEnd'>${crudObject.planYearEnd}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><label class="editElement" style="color: red">*</label>审计单位</td>
					<td class="editTd"   style="width:35%;">
						<input type='text' id='crudObject_auditDeptName' name='crudObject.auditDeptName' value="${crudObject.auditDeptName}"
						 title='审计单位' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='crudObject_auditDept' name='crudObject.auditDept' value="${crudObject.auditDept}"
						 title='审计单位Code' class="noborder editElement clear " readonly/>
						<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
									title:'请选择审计单位',
									defaultDeptId:'${user.fdepid}',
									url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
									onAfterSure:updateProcess
									})"></a>
						<span id='view_auditDeptName' class="noborder viewElement clear" >${crudObject.auditDeptName}</span>
					</td>
					<td class="EditHead">计划编制人</td>
					<td class="editTd">
						<span id='view_creator'  class="clear" >${crudObject.creator}</span>
						<input type='hidden' id='crudObject_creator' name='crudObject.creator' value="${crudObject.creator}"
							   title='计划编制人' class="noborder editElement clear" readonly/>
						<input type='hidden' id='crudObject_creatorId' name='crudObject.creatorId' value="${crudObject.creatorId}"
							   class="noborder editElement clear " readonly/>
						<%-- <a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
						   onclick="showSysTree(this,
								   { url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
								   title:'请选择计划编制人',
								   type:'treeAndUser',
								   defaultDeptId:'${user.fdepid}',
								   defaultUserId:'${user.fname}'
								   })"></a>
						<span id='view_creator' class="noborder viewElement clear" >${crudObject.creator}</span> --%>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap>计划编制日期</td>
					<td class="editTd" colspan="3">
						<span id='view_createTime' class="clear" >${crudObject.createTimeFormat}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="text-align: left;" nowrap colspan="4">
						一、围绕事业部三年期战略确定对重大项目、重要战略议题、重点BU等的审计计划<font class='editElement' color='red'>（限2000字以内）</font>
					</td>
				</tr>
				<tr>
					<td class="editTd"  colspan="4">
						<textarea  id='crudObject_importantPlanDesc' name='crudObject.importantPlanDesc' class="noborder editElement clear len2000"  title="围绕事业部三年期战略确定对重大项目、重要战略议题、重点BU等的审计计划"
								   style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${crudObject.importantPlanDesc}</textarea>
						<textarea id='view_importantPlanDesc' class="noborder viewElement clear"
								  style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.importantPlanDesc}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="text-align: left;" nowrap colspan="4">
						二、根据经济责任审计三年全覆盖目标确定任中、任期审计项目<font class='editElement' color='red'>（限2000字以内）</font>
					</td>
				</tr>
				<tr>
					<td class="editTd"  colspan="4">
						<textarea  id='crudObject_economicAuditDesc' name='crudObject.economicAuditDesc' class="noborder editElement clear len2000"  title="根据经济责任审计三年全覆盖目标确定任中、任期审计项目"
								   style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;'>${crudObject.economicAuditDesc}</textarea>
						<textarea id='view_economicAuditDesc' class="noborder viewElement clear"
								  style='border-width:0px;height:60px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.economicAuditDesc}</textarea>
					</td>
				</tr>
			</table>
			<!-- 项目计划 -->
			<jsp:include flush="true" page="/pages/plan/3year/showWorkPlanDetailBU.jsp" />
			<%-- <jsp:include flush="false" page="/pages/bpm/list_transition.jsp" />
			<div style="display: none;">
				<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
			</div>
			<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" /> --%>
		</form>		
	</div>
<script type="text/javascript">
    function updateProcess() {
        updateProcessDiv($('#crudObject_auditDept').val());
    }
</script>
</body>
</html>