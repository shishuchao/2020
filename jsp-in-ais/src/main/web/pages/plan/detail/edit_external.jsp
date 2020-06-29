<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>外部项目录入</title>
     	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
   		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	</head>

<body style="overflow: auto;overflow-x:hidden;" class="easyui-layout">
	<div style="overflow-y:hidden;" region="north">
		<s:form id="planForm" action="saveExternal" namespace="/plan/detail">
			<s:token/>
			<s:hidden name="workPlanExternal.formId"></s:hidden>
			<s:hidden name="workPlanExternal.year"></s:hidden>
			<s:if test="${view != 'view'}">
	 	  	<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%">
				<tr >
					<td colspan="4" align="left" class="topTd">
						外部项目录入
						<div style="float:right">
							<a id="saveButton"  class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';save('planForm')"/>保存</a>
							<s:if test="${workPlanExternal.formId != '' and workPlanExternal.formId != null}">
								<a id="submitButton"  class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="this.style.disabled='disabled';submitForm('planForm')"/>提交</a>
							</s:if>
							<a class="easyui-linkbutton" data-options="iconCls:'icon-return'" onclick="back()"/>返回</a>
						</div>
					</td>
				</tr>
			</table>
			</s:if>
			<table id="planTable" name="planTable"  cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" style="width: 98%">
				<tr>
					<td class="EditHead" style="width:15%">
						<font color=red>*</font>项目名称
					</td>
					<td class="editTd" style="width:35%">
						<s:textfield name="workPlanExternal.w_plan_name"  id="w_plan_name" cssClass="noborder editElement required" title="项目名称" maxlength="100"/>
					</td>
					<td class="EditHead" style="width:15%">
						状态
					</td>
					<td class="editTd" style="width:35%">
						<s:if test="${workPlanExternal.status == '1'}">
							已提交
						</s:if>
						<s:else>
							草稿
						</s:else>
						<s:hidden name="workPlanExternal.status" />
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%" id="aditDeptTd">
						<font color=red>*</font>审计单位
					</td>
					<td class="editTd" style="width:35%">
						<s:textfield name="workPlanExternal.audit_dept_name"  id="audit_dept_name" cssClass="noborder editElement required" title="审计单位" maxlength="100"/>
					</td>
					<td class="EditHead" style="width:15%"  nowrap="nowrap" id="auditObjtTd">
						<font color=red>*</font>被审单位
					</td>
					<td class="editTd" style="width:35%" id="auditObjtContTd">
						<s:textfield cssClass="noborder editElement required" name="workPlanExternal.audit_object_name"  id="audit_object_name" cssStyle="width:150px" readonly="true" maxlength="100"/>
						<input type="hidden" id="audit_object" name="workPlanExternal.audit_object" value="<s:property value='workPlanExternal.audit_object'/>">
						<img style="cursor:pointer;border:0" src="${contextPath}/easyui/1.4/themes/icons/search.png"
								 onclick="showSysTree(this,
										 { url:'${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
										  cache:false,
										 checkbox:true,
										 title:'请选择被审计单位'
								})"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						项目领导
					</td>
					<td class="editTd" style="width:35%">
						<s:textfield name="workPlanExternal.pro_teamcharge_name"  id="pro_teamcharge_name" cssClass="noborder editElement" title="项目领导" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
     					 项目主审
					</td>
					<td class="editTd" style="width:35%">						
						<s:textfield name="workPlanExternal.pro_auditleader_name"  id="pro_auditleader_name" cssClass="noborder editElement" title="项目主审" maxlength="100"/>
                    </td>
					<td class="EditHead" style="width:15%">
						项目参审
					</td>
					<td class="editTd" style="width:35%">
						<s:textfield name="workPlanExternal.pro_teammember_name"  id="pro_teammember_name" cssClass="noborder editElement" title="项目参审" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						<font color=red>*</font>项目开始日期
					</td>
					<td class="editTd" style="width:35%">
						<input type="text" id="pro_starttime" name="workPlanExternal.pro_starttime" value="${workPlanExternal.pro_starttime }"
								class="easyui-datebox editElement required" editable="false" style="width: 150px"/>	
					</td>
					<td class="EditHead" style="width:15%">
						<font color=red>*</font>项目结束日期
					</td>
					<td class="editTd" style="width:35%">
						<input type="text"  id="pro_endtime" name="workPlanExternal.pro_endtime" class="easyui-datebox editElement required" style="width: 150px"
							value="${workPlanExternal.pro_endtime }" editable="false"/>	
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" style="width:15%">
						<font color=red>*</font>审计期间开始
					</td>
					<td class="editTd" style="width:35%" >
						<input type="text" id="audit_start_time" name="workPlanExternal.audit_start_time"  editable="false"
								value="${workPlanExternal.audit_start_time }" class="easyui-datebox editElement required" style="width: 150px"/>		
					</td>
					<td class="EditHead" style="width:15%" nowrap>
						<font color=red>*</font>审计期间结束					
					</td>
					<td class="editTd" style="width:35%">
						<input type="text" id="audit_end_time" value="${workPlanExternal.audit_end_time }" 
							name="workPlanExternal.audit_end_time" class="easyui-datebox editElement required" editable="false" style="width: 150px">	    
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						录入人
					</td>
					<td class="editTd" style="width:35%">
					     <s:property value="workPlanExternal.w_writer_person_name"/>
					     <s:hidden name="workPlanExternal.w_writer_person_name"/>
					     <s:hidden name="workPlanExternal.w_writer_person"/>
					     <s:hidden name="workPlanExternal.fid"/>
					</td>
					<td class="EditHead" style="width:15%">
						录入时间
					</td>
					<td class="editTd" style="width:35%">
						<s:date name="workPlanExternal.w_write_date"  format="yyyy-MM-dd"/>
						 <s:hidden name="workPlanExternal.w_write_date"/>
					 </td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">
						备注
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:textarea id="remarks" name="workPlanExternal.remarks" cssClass="noborder"
							cssStyle="width:90%;height:100px;overflow-y:visible;line-height:150%;" title="备注"/>
					</td>
				</tr>
				<s:if test="${workPlanExternal.formId !=  '' and workPlanExternal.formId != null}">
				<tr>
					<td class="EditHead" style="width:15%">审计通知书
						<s:hidden id="notice_file" name="workPlanExternal.notice_file" />
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:if test="${view != 'view'}">
							<div data-options="fileGuid:'${workPlanExternal.notice_file}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
							<div data-options="fileGuid:'${workPlanExternal.notice_file}',isAdd:'false','isDel':'false'"  class="easyui-fileUpload"></div>
						</s:else>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" style="width:15%"><font color="red">*</font>审计报告
						<s:hidden id="report_file" name="workPlanExternal.report_file" />
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:if test="${view != 'view'}">
							<div data-options="fileGuid:'${workPlanExternal.report_file}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
							<div data-options="fileGuid:'${workPlanExternal.report_file}',isAdd:'false','isDel':'false'"  class="easyui-fileUpload"></div>
						</s:else>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" style="width:15%">审计问题
						<s:hidden id="problem_file" name="workPlanExternal.problem_file" />
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:if test="${view != 'view'}">
							<div data-options="fileGuid:'${workPlanExternal.problem_file}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
							<div data-options="fileGuid:'${workPlanExternal.problem_file}',isAdd:'false','isDel':'false'"  class="easyui-fileUpload"></div>
						</s:else>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" style="width:15%">整改方案
						<s:hidden id="mend_file" name="workPlanExternal.mend_file" />
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:if test="${view != 'view'}">
							<div data-options="fileGuid:'${workPlanExternal.mend_file}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
							<div data-options="fileGuid:'${workPlanExternal.mend_file}',isAdd:'false','isDel':'false'"  class="easyui-fileUpload"></div>
						</s:else>
					</td>
				</tr>
				
				<tr>
					<td class="EditHead" style="width:15%">其他附件
						<s:hidden id="other_file" name="workPlanExternal.other_file" />
					</td>
					<td class="editTd" style="width:35%" colspan="3">
						<s:if test="${view != 'view'}">
							<div data-options="fileGuid:'${workPlanExternal.other_file}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
							<div data-options="fileGuid:'${workPlanExternal.other_file}',isAdd:'false','isDel':'false'"  class="easyui-fileUpload"></div>
						</s:else>
					</td>
				</tr>
				</s:if>
			</table>
			<br>
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
			</div>
			<div  style="overflow: auto;">
				<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>
			<br/>
		</s:form>
	</div>
	<script language="javascript">
	
  	$(function(){
  		$("#planForm").find("textarea").each(function(){
			autoTextarea(this);
		});
  	});
	
	/*
		校验两个日期大小顺序
	*/
	function validateDate(beginDateId,endDateId){
		var s1 = $('#'+beginDateId);
		var e1 = $('#'+endDateId);
		if(s1 && e1){
			var s = s1.datebox('getValue');
			var e = e1.datebox('getValue');
			if(s!='' && e!=''){
				var s_date=new Date(s.replace("-","/"));
				var e_date=new Date(e.replace("-","/"));
				if(s_date.getTime()>e_date.getTime()){
					$.messager.alert("错误","日期区间开始必须小于等于结束!");
					return false;
				}
			}
		}
		return true;
	}
	
	/*
		校验审计期间要小于项目时间
	*/
	function validateDate2(){
		var e1 = $('#pro_endtime').datebox('getValue');
		var e2 = $('#audit_end_time').datebox('getValue');
		if(e1!=''&& e2!=''){
			var e1_date=new Date(e1.replace("-","/"));
			var e2_date=new Date(e2.replace("-","/"));
			if(e2_date.getTime()>e1_date.getTime()){
				$.messager.alert("错误","审计期间结束必须小于等于项目结束时间!");
				return false;
			}
		}
		return true;
	}
	

	/*
	 *上传附件
	*/
	function Upload(id,filelist){
		var guid=id;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	}
	
	/*
	* 删除附件
	*/
	function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
		var boolFlag=window.confirm("确认删除吗?");
		if(boolFlag==true){
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
				xxx);
			function xxx(data){
			  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
			} 
		}
	}
	

	
	/*
		保存表单
	*/
	function save(formId){
		if(audEvd$validateform(formId)) {
			if(!validateDate('pro_starttime','pro_endtime')){
				return false;
			}
			if(!validateDate('audit_start_time','audit_end_time')){
				return false;
			}
			if(!validateDate2()) { 
				return false;
			}
			var flowForm = document.getElementById(formId);
			$('#saveButton').linkbutton('disable');
			flowForm.submit();
		}
	}
	
	/*
		提交表单
	*/
	function submitForm(formId){
		if(audEvd$validateform(formId)) {
			if(!validateDate('pro_starttime','pro_endtime')){
				return false;
			}
			if(!validateDate('audit_start_time','audit_end_time')){
				return false;
			}
			if(!validateDate2()) { 
				return false;
			}
			var flag = true;
			$.ajax({
				url:'${contextPath}/plan/detail/isFileUpload.action',
				type:'post',
				async:false,
				data:{'guid':'${workPlanExternal.report_file}'},
				success:function(data) {
					if(data != '1') {
						flag = false;
						showMessage1('审计报告为必传文件！');
					}
				}
			});
			if(flag) {
				var flowForm = document.getElementById(formId);
				$('#saveButton').linkbutton('disable');
				flowForm.action='submitExternal.action';
				flowForm.submit();
			}
		}
	}
	
	function back(){
		window.location.href='${contextPath}/plan/detail/listExternals.action';
	}
	</script>
	</body>
</html>
