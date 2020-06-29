<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
<head>
<title>缺陷问题跟踪评价</title>
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<style type="text/css">
			.EditHead {
				width:20%;
			}
			
			.editTd {
				width:30%;
			}
		</style>
<script type="text/javascript">
//限定字数
$(document).ready(function(){
    $("#examine_result").attr("maxlength",2000);
    $("#mend_result").attr("maxlength",2000);
    $("#responsibility_Mode").attr("maxlength",2000);
    $("#no_rectification_reason").attr("maxlength",2000);
    $("#real_examine_creater").attr("maxlength",2000);
    $("#aud_track_result").attr("maxlength",2000);
    $("#myFirstform").find("textarea").each(function(){
       autoTextarea(this);
    });
    $("#myform").find("textarea").each(function(){
      autoTextarea(this);
    });
    $("#SaveBtn").bind('click', function(){
        var f_mend_opinion_code =$("#f_mend_opinion_code").combobox("getValue");
        if(f_mend_opinion_code != null){
            var f_mend_opinion_name	= $("#f_mend_opinion_code").combobox("getText");
            $("#f_mend_opinion_name").val(f_mend_opinion_name);
        }
        aud$saveForm('scheduleForm', "${contextPath}/intctet/defectRectification/saveProblemEvaluate.action?formId=${interCtrlProblemTracking.formId}", function(data){
            if(data){
                data.msg ? showMessage1(data.msg) : null;
                if(data.type == 'info'){
                    var formId = data.formId;
                    if(formId){
                        $('#formId').val(formId);
                    }

                }
            }
        });
    });
});
        //查看底稿
function viewManu(manuIndex){
   var manuEditUrl = "/ais/intctet/evaluationActualize/editManu.action?view=true&manuId=${param.manuId}";
   aud$openNewTab("底稿查看", manuEditUrl, true)
}
        
function back(){
	window.location.href = "${contextPath}/intctet/rework/edit.action?epId=${project_id}";
}

</script>
</head>
<body style="padding:0px;margin:0px;">
<div class="easyui-panel" style="width:100%;padding:0px;" title="缺陷基本信息" border="0">
	<s:form id="myFirstform" cssStyle="padding:0px;margin:0px;width:100%;">
		<table cellpadding=1 cellspacing=1 border=0  class="ListTable" id="tab1"
			style="padding:0px;margin:0px;width:100%;" >
			<tr>
				<td class="EditHead" style="border-top-width:0px;">所属控制点</td>
				<td class="editTd" colspan="3" style="border-top-width:0px;">
					<s:property  value="interCtrlProblem.controlName" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">所属主流程</td>
				<td class="editTd" colspan="3">
					<s:property value="interCtrlProblem.circuitName" id="circuitName"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">所属子流程</td>
				<td class="editTd" colspan="3">
					<s:property  value="interCtrlProblem.sonCircuitName" id="sonCircuitName"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">被评价单位</td>
				<td class="editTd">
					<s:property  value="interCtrlProblem.accountabilityDept" id="evaDept"/>
				</td>
                <td class="EditHead">底稿索引</td>
				<td class="editTd" >
					<a href=# onclick="viewManu('<s:property  value="interCtrlProblem.manuscriptIndex"/>')">
                        <s:property  value="interCtrlProblem.manuscriptIndex"/>
                    </a>
				</td>
			</tr>
			<tr>
				<td class="EditHead">内控缺陷编号</td>
				<td class="editTd">
					<s:textfield name="interCtrlProblem.defectCode" cssClass="noborder" readonly="true"></s:textfield>
				</td>
                <td class="EditHead">内控缺陷名称</td>
				<td class="editTd">
                    <s:textfield name="interCtrlProblem.defectName" cssClass="noborder" readonly="true"></s:textfield>
                </td>
			</tr>
			<tr>
				<td class="EditHead">涉及单位部门</td>
				<td class="editTd" colspan="3">
					<s:property  value="interCtrlProblem.involveDept" id="involveDept"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">内控缺陷描述</td>
				<td class="editTd" colspan="3">
					<s:property  value="interCtrlProblem.defectDescription" id="defectDescription"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">缺陷成因</td>
				<td class="editTd" colspan="3">
					<s:property  value="interCtrlProblem.defectCause" id="defectCause"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">涉及损失/错报金额</td>
				<td class="editTd">
					<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${interCtrlProblem.relateLoss}</fmt:formatNumber>
					&nbsp;万元</td>
				<td class="EditHead">缺陷类型</td>
				<td class="editTd">
					<s:property  value="interCtrlProblem.defectTypeName" id="defectTypeName"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">风险及影响</td>
				<td class="editTd" colspan="3">
					<s:property value="interCtrlProblem.riskEffect" id="riskEffect"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">认定结果</td>
				<td class="editTd" colspan="3">
					<s:property value="interCtrlProblem.initialIdentify" id="defineResult"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">整改建议</td>
				<td class="editTd" colspan="3">
					<s:property value="interCtrlProblem.mendAdvice" id="mendAdvice"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">整改建议描述</td>
				<td class="editTd" colspan="3">
					<s:property value="interCtrlProblem.suggestDescription" id="suggestDescription"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">整改责任单位</td>
				<td class="editTd">
					<s:property value="interCtrlProblem.accountabilityUnit" id="accountabilityUnit"/>
				</td>
				<td class="EditHead">整改主责部门</td>
				<td class="editTd">
					<s:property value="interCtrlProblem.accountabilityDept" id="accountabilityDept"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">整改责任人</td>
				<td class="editTd">
					<s:property value="interCtrlProblem.personLiable" id="personLiable"/>
				</td>
				<td class="EditHead">联系电话</td>
				<td class="editTd">
					<s:property value="interCtrlProblem.telephone" id="telephone"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">整改期限</td>
				<td class="editTd">
					<s:property value="interCtrlProblem.mendDeadline" id="mendDeadline"/>
				</td>
				<td class="EditHead">整改方式</td>
				<td class="editTd">
					<s:property value="interCtrlProblem.mendMethod" id=""/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">监督检查人</td>
				<td class="editTd">
					<s:property value="interCtrlProblem.checkPeople" id="checkPeople"/>
				</td>
				<td class="EditHead">检查方式</td>
				<td class="editTd">
					<s:property value="interCtrlProblem.checkMethod" id="checkMethod"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">附件</td>
				<td class="editTd" colspan="3">
					<div data-options="fileGuid:'${interCtrlProblem.attachmentId}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
				</td>
			</tr>
		</table>
	</s:form>
</div>
<div class="easyui-panel" style="width:100%;padding:0px;" title="整改措施" border="0">
	<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab2" 
		style="width:100%;margin:0px;padding:0px;">
		<tr>
			<td class="EditHead" style="border-top-width:0px;">整改措施描述</td>
			<td class="editTd" colspan="3" style="border-top-width:0px;">
                <s:property  value="interCtrlProblem.mendMeasureDescription" />
			</td>
		</tr>
		<tr>
			<td class="EditHead">整改负责部门/个人</td>
			<td class="editTd" colspan="3">
				<s:property value="interCtrlProblem.mendDeptPerson" id="mendDeptPerson"/>
			</td>
		</tr>
		<tr>
			<td class="EditHead">计划开始时间</td>
			<td class="editTd">
				<input name="interCtrlProblem.planStartTime" value="${interCtrlProblem.planStartTime }" readonly="readonly" class="noborder" style="width:140px;">
			</td>
			<td class="EditHead">计划完成时间</td>
			<td class="editTd">
				<input name="interCtrlProblem.planEndTime" value="${interCtrlProblem.planEndTime }" readonly="readonly" class="noborder" style="width:140px;">
			</td>
		</tr>
		<tr>
			<td class="EditHead">录入人</td>
			<td class="editTd">
				<s:property value="interCtrlProblem.writePerson" />
			</td>
			<td class="EditHead">录入时间</td>
			<td class="editTd">
				<s:property value="interCtrlProblem.writeTime" />
			</td>
		</tr>
		<tr>
			<td class="EditHead">附件</td>
			<td class="editTd" colspan="3">
				<div data-options="fileGuid:'${interCtrlProblem.mend_measure_file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
			</td>
		</tr>
	</table>
</div>
<div class="easyui-panel" style="width:100%;padding:0px;" title="整改进度查看" border="0"> 
	<table  class="ListTable" id="tab3" style="width:100%;padding:0px;margin:0px;" >
		<tr>
			<td class="EditHead" style="border-top-width:0px;">整改状态</td>
			<td class="editTd" colspan="3" style="border-top-width:0px;">
				<select id="mendMethod" class="easyui-combobox" name="interCtrlProblem.mendMethod" editable="false" style="width:160px;" data-options="panelHeight:100" disabled="disabled">
						<option value="">&nbsp;</option>
						<s:iterator value="basicUtil.fllowOpinionList" id="entry">
							  <s:if test="${interCtrlProblemTracking.mend_state_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       	  <s:else>
								  <option value="<s:property value="code"/>"><s:property value="name"/></option>
						      </s:else>
						</s:iterator>
				</select>
			</td>
		</tr>
		<tr>
			<td class="EditHead">整改进度描述
				<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
			</td>
			<td class="editTd" colspan="3">
				<s:textarea name="interCtrlProblem.mend_result" id="mend_result" cssClass='noborder' title="整改进度描述"
							rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" readonly="true"/>
				<input type="hidden" id="interCtrlProblem.mendDescription.maxlength" value="200"/>
			</td>
		</tr>
		<tr>
			<td class="EditHead">到期未整改原因
				<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
			</td>
			<td class="editTd" colspan="3">
				<s:textarea id="no_rectification_reason" name="interCtrlProblem.no_rectification_reason" readonly="true" cssClass="noborder"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
				<input type="hidden" id="interCtrlProblem.no_rectification_reason.maxlength" value="200"/>
			</td>
		</tr>
		<tr>
			<td class="EditHead">是否追责</td>
			<td class="editTd">
				<s:property value="interCtrlProblem.responsibility"/>
			</td>
			<td class="EditHead">追责方式</td>
			<td class="editTd" >
				<s:property value="interCtrlProblem.responsibility_Mode"/>
			</td>
		</tr>
		<tr>
			<td class="EditHead">实际开始时间</td>
			<td class="editTd">
				<input name="interCtrlProblem.examine_startdate" value="${interCtrlProblem.examine_startdate }" readonly="readonly" class="noborder" style="width:140px;">
			</td>
			<td class="EditHead">实际完成时间</td>
			<td class="editTd">
				<input name="interCtrlProblem.examine_enddate" value="${interCtrlProblem.examine_enddate }" readonly="readonly" class="noborder" style="width:140px;">
			</td>
		</tr>
		<tr>
			<td class="EditHead">反馈人</td>
			<td class="editTd">
				<s:property value="interCtrlProblem.auditobj_tracker_name"/>
			</td>
			<td class="EditHead">反馈时间</td>
			<td class="editTd">
				<s:property value="interCtrlProblem.mend_date"/>
			</td>
		</tr>
		<s:if test="interaction==null || interaction==''">
			<tr id="fujian">
				<td class="EditHead">附件
					<s:hidden id="feedback_file_id" name="interCtrlProblem.feedback_file_id" />
				</td>
				<td class="editTd" colspan="3">
					<div data-options="fileGuid:'${interCtrlProblem.feedback_file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
				</td>
			</tr>
		</s:if>
	</table>
</div>
<div class="easyui-panel" style="width:100%;padding:0px;" title="整改进度检查评价" border="0">
	<form  id='scheduleForm' name='scheduleForm' method="POST" style="padding:0px;margin:0px;width:100%;">
        <input type="hidden" name="interCtrlProblemTracking.inter_ctrl_problem_id" value="${interCtrlProblemTracking.inter_ctrl_problem_id }">
        <input type="hidden" id="formId" name="interCtrlProblemTracking.formId" value="${interCtrlProblemTracking.formId}">
        <input type="hidden" name="interCtrlProblemTracking.f_mend_accessory" value="${interCtrlProblemTracking.f_mend_accessory}">
        <table class="ListTable" cellpadding=1 cellspacing=1 id="tab4" style="padding:0px;margin:0px;width:100%;">
			<tr>
				<td class="EditHead" style="border-top-width:0px;">整改状态评价</td>
				<td class="editTd" colspan="3" style="border-top-width:0px;">
                    <input type='hidden' id="f_mend_opinion_name" name="interCtrlProblemTracking.f_mend_opinion_name"  class="noborder editElement clear" value="${interCtrlProblemTracking.f_mend_opinion_name}"/>
					<select id="f_mend_opinion_code" class="easyui-combobox" name="interCtrlProblemTracking.f_mend_opinion_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						<option value="">&nbsp;</option>
						<s:iterator value="basicUtil.MendStatusEvaluate" id="entry">
							<s:if test="${interCtrlProblemTracking.f_mend_opinion_code==code}">
								<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
							</s:if>
							<s:else>
								<option value="<s:property value="code"/>"><s:property value="name"/></option>
							</s:else>
						</s:iterator>
					</select>
				</td>
			</tr>
			<tr>
				<td class="EditHead">整改跟踪检查结果描述
					<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
				</td>
				<td class="editTd" colspan="3">
                    <textarea  id='examine_result' name='interCtrlProblemTracking.examine_result' class="noborder editElement clear len2000"
                            style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${interCtrlProblemTracking.examine_result}</textarea>
				</td>
			</tr>

			<tr>
				<td class="EditHead">检查人</td>
				<td class="editTd" >
                    <input type='text' id='tracker_name' name='interCtrlProblemTracking.tracker_name' value="${interCtrlProblemTracking.tracker_name}"
                           title='检查人' class="noborder editElement clear"/>
                     <input type="hidden" id='tracker_code' name="interCtrlProblemTracking.tracker_code" value="${interCtrlProblemTracking.tracker_code}"
					       title='检查人code' />
				</td>
				<td class="EditHead">检查时间</td>
				<td class="editTd">
                    <input type='text' id='feedback_date' name='interCtrlProblemTracking.feedback_date' value="${interCtrlProblemTracking.feedback_date}"
                           title='检查时间' class="noborder editElement clear"/>
				</td>
			</tr>
			
			<tr>
				<td class="EditHead">附件</td>
				<td class="editTd" colspan="3">
					<s:if test="view == 'true'">
						<div data-options="fileGuid:'${interCtrlProblemTracking.f_mend_accessory}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</s:if>
					<s:else>
						<div data-options="fileGuid:'${interCtrlProblemTracking.f_mend_accessory}',isAdd:true,isEdit:true,isDel:true"  class="easyui-fileUpload"></div>
					</s:else>
				</td>
			</tr>
		</table>
		<div  style="padding:10px;text-align:right;">
			<s:if test="view != 'true'">
				<a id="SaveBtn" href="javascript:void(0);" class="easyui-linkbutton"  data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;
			</s:if>
			<!-- <a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">返回</a> -->
		</div>
		
	</form>
</div>
</body>
</html>
