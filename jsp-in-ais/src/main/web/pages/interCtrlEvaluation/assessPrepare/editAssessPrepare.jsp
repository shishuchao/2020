<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控-创建方案添加、修改、查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript">
$(function(){
	if("${goEaTool}"){
		var curTabId = aud$getActiveTabId();
		$('body').data('curTabId', curTabId);
		setTimeout(function(){
			//alert($('body').data('curTabId')+"\n"+aud$getActiveTabId())
			aud$closeTab($('body').data('curTabId'));
		}, 50);
		var eaToolUrl = '${contextPath}/intctet/evaluationActualize/showEvaluationTool.action?projectId=${projectId}';
		aud$openNewTab("评价工具", eaToolUrl);
	}

	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var curDate = "${curDate}";
	var curTabId = aud$getActiveTabId();
	var parentTabId = '${parentTabId}';
	var projectFormId = '${projectFormId}';
	if(isView){
		$('.editElement').hide()
		$('body').layout('remove', 'north');
	}else{
		$('.viewElement').hide()
	}
	
	//autosize textarea
	try{
		var textareaIds = ["description","asscopeview","worktask","personteam","progressplan","costbudget"];	
		$.each(textareaIds, function(n, tsuffix){			
			autoTextarea(isView ?  $('#view_'+tsuffix)[0] : $('#crudObject_'+tsuffix)[0]);
		});	
	}catch(e){}
	

	
	$('#mPostBtn').bind('click', function(){
		//评价方案提交前，检查评价范围、评价内容、分组、组员是否已经添加  checkPostPrepare
		$.ajax({
			url : "${contextPath}/intctet/prepare/assessScheme/checkPostPrepare.action",
			dataType:'json',
			type: "post",
			data:{
				'projectId':"${projectFormId}"
			},
			beforeSend:function(){
				 aud$loadOpen();
				 return true;
			},
			success: function(data){
				aud$loadClose();
				if(data.type != "info"){
					top.$.messager.alert("提示信息", data.msg, data.type, function(){
						var tabIndex = data.tabIndex;
						if(tabIndex){
  							parent.$('#qtab').tabs('enableTab',tabIndex);
  							parent.$('#qtab').tabs('select',tabIndex);							
						}
					});
				}else{
					if($('#submitButton').length){
						$('#submitButton').trigger('click');
					}else if($('#submitButton2Start').length){
						$("#submitButton2Start").trigger('click');
					}
				}
			},
			error:function(data){
				aud$loadClose();
				top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
			}
		});
	});
	
	//如果方案已经保存，评价范围、评价内容、评价组织页签变为可编辑
	if($('#crudObject_formId').val()){
		parent.$('#qtab').tabs('enableTab',1).tabs('enableTab',2).tabs('enableTab',3);
		$('#mPostBtn').show();
	}else{
		$('#mPostBtn').hide();
	}
	
	"${formState}" == "3" ? $('#mPostBtn').remove() : null;
	
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	
	var fileGuid = $('#crudObject_attachmentId').val();
	// 附件上传初始化
    $('#'+fileContainer).fileUpload({
    	topWindow:false,
        fileGuid:fileGuid,
        isAdd:!isView,
        isEdit:!isView,
        isDel:!isView,
        isView:true,
        isDownload:true,
        isdebug:false
    });
	//window.dvSave = save;
	if(!isView){		
		$("#saveBtn").bind('click', function(){
		   	  aud$saveForm('assessPrepareForm', "${contextPath}/intctet/prepare/assessScheme/saveAssess.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						 data.ascode ? $('#crudObject_ascode').val(data.ascode) : null;
						 data.formId ? $('#crudObject_formId').val(data.formId) : null;
						//启用确定评价范围
						parent.$('#qtab').tabs('enableTab',1);
						parent.$('#qtab').tabs('select',1);
						$('#mPostBtn').show();
					 }
				 }
			 }); 
		});
	}else{
		$("#saveBtn").remove();
	}
	
	$('#dvlayout').layout('resize'); 
	
	//编辑状态，启用项目送审资料清单
	$('#ap_formId').val() ? parent.$('#qtab').tabs('enableTab',1) : null;
});

	//更新父页面送审资料iframe请求url的参数
	function aud$setDatumParam(isload){
		parent.$('#sureFw').data('isload',isload);
	}
	
	//保存创建方案
	function save(){
		var formId = parent.$('#formId').val();
	   	  aud$saveForm('assessPrepareForm', "${contextPath}/intctet/prepare/assessScheme/saveAssess.action", function(data){
			 if(data){
				 data.msg ? showMessage1(data.msg) : null;	
				 if(data.type == 'info'){
					 var formId = data.formId;
					 if(formId){
					 	$('#crudObject_ascode').val(data.ascode);
						$('#crudObject_formId').val(formId);
						aud$setDatumParam(false);
						//启用确定评价范围
						parent.$('#qtab').tabs('enableTab',1);
						parent.$('#qtab').tabs('select',1);
					 }
					 
					 if(isClose){
						 var curTabId = aud$getActiveTabId() || parent.aud$getActiveTabId();
						 if(curTabId && parentTabId){	
							window.setTimeout(function(){
							 	aud$closeTab(curTabId, parentTabId);							
							},100);
						 }
					 }
				 }
			 }
		 }); 
	}
	
	
	function toSubmit(option){
		var formId = 'assessPrepareForm';
		var flowForm = document.getElementById(formId);
			<s:if test="isUseBpm=='true'">
				if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
					var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
					if(actor_name==null||actor_name==''){
						window.alert('下一步处理人不能为空！');
						return false;
					}
				}
			</s:if>
			if(confirm('确认提交吗?')){
				document.getElementById('submitButton').disabled=true;
			 	<s:if test="isUseBpm=='true'">
					flowForm.action="<s:url action="submit" includeParams="none"/>";
				</s:if>
				<s:else>
					flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
				</s:else>  
				flowForm.action="<s:url action="submit" includeParams="none"/>";
				flowForm.submit();
			}else{
				return false;
			}
		
	}
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' id='dvlayout' class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div id='btnBar' style='text-align:right;padding-right:15px;margin-bottom:5px;border-bottom:1px solid #cccccc;width:100%;'>
 			<a id='saveBtn'  class="easyui-linkbutton" iconCls="icon-save" style='border-width:0px;'>保存</a>			
			<a id='mPostBtn' class="easyui-linkbutton" iconCls="icon-ok" style='border-width:0px;'>提交</a>
		</div>	
	</div>
	<div region='center' border='0'>
		 <form  id='assessPrepareForm' name='assessPrepareForm' method="POST" style="margin:0px;padding:0px;">  	   		
			<input type='hidden' id="crudObject_projectFormId" name="crudObject.projectFormId"  class="noborder editElement clear" value="${projectFormId}"/>
			<input type='hidden' id="crudObject_formId" name="crudObject.formId"  class="noborder editElement clear" value="${crudObject.formId}"/>  
			<input type='hidden' id='crudObject_attachmentId' name='crudObject.attachmentId' value="${crudObject.attachmentId}"
			 class="noborder editElement" style='width:500px;'/> 				
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font color=red>*</font>编号</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='crudObject_ascode' name='crudObject.ascode' value="${crudObject.ascode}"
						title='编号' class="noborder editElement clear" readonly="readonly" disabled="disabled" />
						<span id='view_ascode' class="noborder viewElement clear" >${crudObject.ascode}</span>
					</td>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>名称</td>
					<td class="editTd" style="width:35%;">
						 <input type='text' id='crudObject_asname' name='crudObject.asname' value="${crudObject.asname}"
						title='名称' class="noborder editElement clear required"/>
						<span id='view_asname' class="noborder viewElement clear require">${crudObject.asname}</span> 
					</td>
				</tr>
				<tr>
					<td class="EditHead">描述<br/><div style="text-align:right"><font color=DarkGray>(限1000字)</font></div></td>
					<td class="editTd"  colspan='3'>
						 <textarea  id='crudObject_description' name='crudObject.description' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${crudObject.description}</textarea>
						<textarea id='view_description' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.description}</textarea> 
					</td>
				</tr>
					<tr>
					<td class="EditHead">评价范围总述</td>
					<td class="editTd"  colspan='3'>
						<textarea  id='crudObject_asscopeview' name='crudObject.asscopeview' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${crudObject.asscopeview}</textarea>
						<textarea id='view_asscopeview' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.asscopeview}</textarea> 
					</td>
				</tr>
					<tr>
					<td class="EditHead">工作任务</td>
					<td class="editTd"  colspan='3'>
						<textarea  id='crudObject_worktask' name='crudObject.worktask' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${crudObject.worktask}</textarea>
						<textarea id='view_worktask' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.worktask}</textarea> 
					</td>
				</tr>
					<tr>
					<td class="EditHead">人员组织</td>
					<td class="editTd"  colspan='3'>
						 <textarea  id='crudObject_personteam' name='crudObject.personteam' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${crudObject.personteam}</textarea>
						<textarea id='view_personteam' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.personteam}</textarea> 
					</td>
				</tr>
					<tr>
					<td class="EditHead">进度安排</td>
					<td class="editTd"  colspan='3'>
						<textarea  id='crudObject_progressplan' name='crudObject.progressplan' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${crudObject.progressplan}</textarea>
						<textarea id='view_progressplan' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.progressplan}</textarea> 
					</td>
				</tr>
					<tr>
					<td class="EditHead">费用预算</td>
					<td class="editTd"  colspan='3'>
						<textarea  id='crudObject_costbudget' name='crudObject.costbudget' class="noborder editElement clear len1000" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;'>${crudObject.costbudget}</textarea>
						<textarea id='view_costbudget' class="noborder viewElement clear" 
						style='border-width:0px;height:50px;width:99%;overflow:hidden;padding:5px;' readonly>${crudObject.costbudget}</textarea> 
					</td>
				</tr>
			</table>
			
 	    	<div align = "right"  style='padding:5px;border-bottom:0px solid #cccccc;'>
				<div id='flowBtn' style="display:none;">
	            	<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />			
				</div>
                <!-- 显示流程处理意见，催办时间，下一步处理环节，下一步处理人；-->
                <jsp:include flush="false" page="/pages/bpm/list_transition.jsp" />
                <!-- 显示流程流转信息 -->
	           <jsp:include flush="true"  page="/pages/bpm/list_taskinstanceinfo.jsp" />
 	   		</div>
	  </form>	
	</div>
	<div region="south" style="overflow:hidden;" border='0' title="">
	     <div id="edit_attachFile" class="editElement"></div>
	     <div id="view_attachFile" class="viewElement"></div>
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>