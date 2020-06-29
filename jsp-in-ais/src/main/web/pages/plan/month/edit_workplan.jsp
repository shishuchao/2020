<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>月度计划</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<s:head theme="ajax" />
	</head>

	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();">
	</s:if>
	<s:else>
		<body>
	</s:else>

	<s:tabbedPanel id="monthPlanPanel" theme='ajax' selectedTab="${param.selectedTab}">
		
		<s:div id='monthBasicInfoDiv' label='计划信息' theme='ajax'>
			<s:form id="planBasicInfoForm" action="submit" namespace="/plan/month" >
				<s:hidden name="crudObject.fid" />
				<s:hidden name="crudObject.w_writer_person" />
				<s:hidden name="crudObject.w_writer_person_name" />
				<s:hidden name="crudObject.w_write_date" />
				<s:hidden name="crudObject.formId" />
				<s:hidden name="crudObject.year_id" />
				<s:hidden name="yearFormId" />
				<s:hidden name="yearDetailIds" />
				<s:hidden id="w_plan_code" name="crudObject.w_plan_code" />
				<s:hidden id="yearPlanCode" name="yearPlan.w_plan_code" />
				<table id="planTable" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead" style="width: ;">
						<td colspan="4" align="left" class="edithead">
							&nbsp;月度计划信息
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划状态：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.status_name" />
							<s:hidden name="crudObject.status_name" />
							<s:hidden name="crudObject.status" />
						</td>
						<td class="ListTableTr11" nowrap>
							月度计划编号：
						</td>
						<td class="ListTableTr22" id="planCodeDiv">
							<s:property value="crudObject.w_plan_code" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划年度：
						</td>
						<td class="ListTableTr22">
							<s:select 
								list="@ais.framework.util.DateUtil@getIncrementYearList(0,10)"
								name="crudObject.w_plan_year" theme="ufaud_simple"
								templateDir="/strutsTemplate" disabled="true" />
						</td>
						<td align="left" class="listtabletr11">
							<font color=red>*</font>
							计划月度：
						</td>
						<td align="left" class="listtabletr22">
							<s:select id="w_plan_month"
								list="{'1','2','3','4','5','6','7','8','9','10','11','12'}"
								name="crudObject.w_plan_month"
								disabled="!(varMap['w_plan_monthWrite']==null?true:varMap['w_plan_monthWrite'])"
								display="${varMap['w_plan_monthRead']}" theme="ufaud_simple"
								templateDir="/strutsTemplate" onchange="getPlanCode()" emptyOption="true"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap>
							<font color=red>*</font>
							计划名称：
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textfield name="crudObject.w_plan_name" 
								readonly="!(varMap['w_plan_nameWrite']==null?true:varMap['w_plan_nameWrite'])"
								display="${varMap['w_plan_nameRead']}" cssStyle="width:90%" title="计划名称" maxlength="255"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap>
							<font color=red>*</font>
							计划单位：
						</td>
						<td class="ListTableTr22">
							<s:buttonText2 id="audit_dept_name" name="crudObject.audit_dept_name" cssStyle="width:90%"
								hiddenId="audit_dept" hiddenName="crudObject.audit_dept"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=crudObject.audit_dept_name&paraid=crudObject.audit_dept&funname=auditDeptChange()',600,350,'组织机构选择')"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true"
								display="${varMap['audit_deptRead']}"
								doubleDisabled="!(varMap['audit_deptWrite']==null?true:varMap['audit_deptWrite'])" />
						</td>
						<td class="ListTableTr11"  nowrap>
							<font color=red>*</font>
							负责人：
						</td>
						<td class="ListTableTr22">
							<s:buttonText2 id="w_charge_person_name"
								name="crudObject.w_charge_person_name" cssStyle="width:90%"
								hiddenId="w_charge_person" hiddenName="crudObject.w_charge_person"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/frameselect4s.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=crudObject.w_charge_person_name&paraid=crudObject.w_charge_person',600,350)"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true"
								display="${varMap['w_charge_personRead']}"
								doubleDisabled="!(varMap['w_charge_personWrite']==null?true:varMap['w_charge_personWrite'])" />
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11" nowrap>
							<s:if test="varMap['contentRequired']">
								<font color=red>*</font>
							</s:if>
							正文内容：
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="crudObject.content" rows="50"
								readonly="!(varMap['contentWrite']==null?true:varMap['contentWrite'])"
								display="${varMap['contentRead']}"
								cssStyle="width:100%;overflow-y:visible" title="正文内容"/>
							<input type="hidden" id="crudObject.content.maxlength" value="3000"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" nowrap>
							<s:button 
								disabled="!(varMap['uploadw_fileWrite']==null?true:varMap['uploadw_fileWrite'])"
								display="${varMap['uploadw_fileRead']}" 
								onclick="Upload('crudObject.w_file',accelerys)" value="上传附件" />
							<s:hidden name="crudObject.w_file" />
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="accelerys" align="center">
								<s:property escape="false" value="accessoryList" />
							</div>
						</td>
					</tr>
				</table>
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
				</div>
				<div align="right" style="width: 97%">
					<input id="saveButton" type="button" value="保存" onclick="this.style.disabled='disabled';return save('planBasicInfoForm','planTable')"/>
					<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
					&nbsp;&nbsp;&nbsp;
					<s:if test="${taskInstanceId!=null&&taskInstanceId>0}">
						<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/portal/simple/simple-firstPageAction!show.action'" />
					</s:if>
					<s:else>
						<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/plan/month/listAll.action'" />
					</s:else>
				</div>
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
				</div>
				<br/>
			</s:form>
		</s:div>
		
		<s:div id='monthDetailListDiv' label='预选项目信息' theme='ajax'>
			<s:form id="monthDetailPlanSearchForm" action="edit" namespace="/plan/month" >
				<s:hidden name="crudId" />
				<s:hidden name="taskInstanceId" />
				<input name="selectedTab" type="hidden" value="monthDetailListDiv" />
				<table cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead">
						<td align="left" class="listtabletr11">
							计划状态：
						</td>
						<td align="left" class="listtabletr22">
							 <s:select
								list="@ais.plan.constants.PlanState@planStateCodeNameMap"
								name="searchCondition.status"
								theme="ufaud_simple"
								templateDir="/strutsTemplate" emptyOption="true"/>
						</td>
						<td align="left" class="listtabletr11">
							计划编号：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="searchCondition.w_plan_code" cssStyle="width:100%" />
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="left" class="listtabletr11" nowrap="nowrap">
							预选项目名称：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="searchCondition.w_plan_name" cssStyle="width:100%" />
						</td>
						<td align="left" class="listtabletr11">
							计划月度：
						</td>
						<td align="left" class="listtabletr22">
							<s:select
								list="{'1','2','3','4','5','6','7','8','9','10','11','12'}"
								name="searchCondition.w_plan_month"
								theme="ufaud_simple"
								templateDir="/strutsTemplate" emptyOption="true"/>
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="left" class="listtabletr11">
							审计实施单位：
						</td>
						<td align="left" class="listtabletr22">
							<s:buttonText2 id="searchCondition.audit_dept_name"
								name="searchCondition.audit_dept_name" cssStyle="width:90%"
								hiddenName="searchCondition.audit_dept" hiddenId="searchCondition.audit_dept"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=searchCondition.audit_dept_name&paraid=searchCondition.audit_dept',600,350,'组织机构选择')"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" />
						</td>
						<td align="left" class="listtabletr11">
							负责人：
						</td>
						<td align="left" class="listtabletr22">
							<s:buttonText2 id="searchCondition.pro_teamleader_name"
								name="searchCondition.pro_teamleader_name" cssStyle="width:90%"
								hiddenId="searchCondition.pro_teamleader" hiddenName="searchCondition.pro_teamleader"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/frameselect4s.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=searchCondition.pro_teamleader_name&paraid=searchCondition.pro_teamleader',600,350)"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" />
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="right" class="listtabletr1" colspan="4">
							<DIV align="right">
								<s:submit value="查询" />
								&nbsp;
								<input type="button" value="重置"
									onclick="window.location.href='${pageContext.request.contextPath}/plan/month/edit.action?crudId=${crudId}&&taskInstanceId=${taskInstanceId}&&selectedTab=monthDetailListDiv'">
							</DIV>
						</td>
					</tr>
				</table>
				<div align="center">
					<display:table name="monthDetailList" id="row" class="its" cellpadding="1" pagesize="10" 
							pagesize="${baseHelper.pageSize}" partialList="true" 
							size="${baseHelper.totalRows}" sort="external"
							defaultsort="4" defaultorder="descending"
							requestURI="${contextPath}/plan/month/edit.action?selectedTab=monthDetailListDiv" >
						<display:column title="选择" headerClass="center" class="center">
							<input type="checkbox" name="detail_plan_id" value="${row.formId}" onclick="changeButtonState(this,'${row.status_name}')" >
							<input type="hidden" id="${row.formId}_status" value="${row.status_name}" />
							<input type="hidden" id="${row.formId}_isAddByMonth" value="${row.isAddByMonth}" />
							<input type="hidden" id="${row.formId}_detailPlanFormId" value="${row.detail_form_id}" />
						</display:column>
						<display:column property="status_name" title="计划状态" headerClass="center" class="center" sortable="true" />
						<display:column title="计划编号" headerClass="center" sortable="true" sortProperty="w_plan_code" property="w_plan_code" />
						<display:column property="w_plan_year" title="年度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true"/>
						<display:column property="w_plan_month" title="计划月度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true"  comparator="ais.framework.displaytag.NumberComparator"/>
						<display:column property="w_plan_excute_month" title="执行月度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" sortable="true"/>
						<display:column property="w_plan_type_name" title="计划类别" headerClass="center" class="center" sortable="true"/>
						<display:column title="预选项目名称" headerClass="center" class="center" sortable="true" sortProperty="w_plan_name"  style="text-align:left;word-break:break-all;">
							<s:if test="${row.detail_plan_name!=null&&row.detail_plan_name!=''}">
								<a href="/ais/plan/detail/view.action?crudId=${row.detail_form_id}" target="_blank">${row.detail_plan_name}</a>
							</s:if>
							<s:else>
								<a href="/ais/plan/year/viewYearDetail.action?yearDetailId=${row.formId}" target="_blank">${row.w_plan_name}</a>
							</s:else>
						</display:column>
						<display:column property="audit_dept_name" title="审计实施单位" headerClass="center" class="center" sortable="true"/>
						<display:column property="pro_teamleader_name" title="负责人" headerClass="center" class="center" sortable="true"/>
						<display:setProperty name="paging.banner.placement" value="bottom" />
					</display:table>
				</div>
				
					<div align="right" style="width: 97%">
						 <s:if test="varMap['modifyDetailRead']==null?true:varMap['modifyDetailRead']">
							<%--第一次立项过来的时候不能显示按钮,要先保存月度计划才行 --%>
							<s:if test="${yearFormId==null || yearFormId==''}">
								<s:if test="@ais.plan.util.PlanSysParamUtil@isDetailPlanEnabled()">
									<%-- 项目计划开启的情况下只能删除,这里的是月度计划明细信息 --%>
									<input id="deleteButton" type="button" value="删除" onclick="deleteDetail()" />
								</s:if>
								<s:else>
									<%-- 项目计划没有开启的情况下就能新增修改和删除了,因为这里已经是真实的项目计划了 --%>
									<input id="addButton" type="button" value="增加" onclick="addDetailPlan()"/>
									<input id="updateButton" type="button" value="修改" onclick="updateDetailPlan()" disabled="disabled" />
									<input id="deleteButton" type="button" value="删除" onclick="deleteDetail()" disabled="disabled" />
								</s:else>
							</s:if>
						</s:if>
					</div>
				
				<br/>
			</s:form>
		</s:div>

	</s:tabbedPanel>
	<script type="text/javascript">
	
		/*
			修改选中的单条计划
		*/
		function updateDetailPlan(){
			var ids = document.getElementsByName("detail_plan_id");
			for(var i=0;i<ids.length;i++){
				if(ids[i].checked==true){
					var status = document.getElementById(ids[i].value+"_status").value;
					if(status&&status=='计划草稿'){
						var isAddByMonth = document.getElementById(ids[i].value+"_isAddByMonth").value;
						if(isAddByMonth=='Y'){//月度计划添加的明细信息项目计划已经存在
							var detailPlanFormId = document.getElementById(ids[i].value+"_detailPlanFormId").value;
							window.location.href="/ais/plan/detail/edit.action?crudId="+detailPlanFormId;
						}else{
							window.location.href="/ais/plan/detail/edit.action?crudId="+ids[i].value;
						}
					}else{
						alert("计划已经审批或执行，不能修改！");
					}
					break;
				}
			}
		}
	
		/*
			新增项目计划
		*/
		function addDetailPlan(){
			window.location.href="/ais/plan/detail/edit.action?monthFormId=${crudObject.formId}";
		}
		
		/**
		* 审计单位变更的后置动作
		*/
		function auditDeptChange(){
			updateProcessSelection();
		}

		/*
		* 更新流程选择框
		*/
		function updateProcessSelection(){
			var auditDeptId = document.getElementById('audit_dept').value;
			updateProcessDiv(auditDeptId);
		}
		
		/*
			启动前校验，如果没有明细信息提醒用户
		*/
		function beforStartProcess(){

			var flowForm = document.getElementById('planBasicInfoForm');
			if(frmCheck(flowForm,'planTable')==false){
				return false;
			}
			
			var ids = document.getElementsByName("detail_plan_id");
			if(ids.length==0){
				if(!confirm("警告:您的月度计划还没有任何明细计划信息,确认要提交吗?")){
					return false;
				}
			}
			return true;
		}
		
		/*
			获取月度计划编号
		*/

		function getPlanCode(){
			var monthPlanCode = document.getElementById('w_plan_code').value;
			var yearPlanCode = document.getElementById('yearPlanCode').value;
			var month = document.getElementById('w_plan_month').value;
			var newPlanCode = '';
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/plan/month', action:'getMonthPlanCode', executeResult:'false' }, 
				{'yearPlanCode':yearPlanCode, 'month':month,'monthFormId':'${crudObject.formId}'},
				xxx);
			function xxx(data){
				newPlanCode = data['newPlanCode'];
			} 

			document.getElementById('w_plan_code').value = newPlanCode;
			document.getElementById('planCodeDiv').innerHTML = newPlanCode;
		}
		
		/*
			删除选中的单条计划
		*/
		function deleteDetail(){
			var ids = document.getElementsByName("detail_plan_id");
			var selectedOne = false;
			for(var i=0;i<ids.length;i++){
				if(ids[i].checked==true){
					selectedOne = true;
					if(confirm("确认要删除明细信息吗?")){
						window.location.href="/ais/plan/detail/delete.action?crudId="+ids[i].value;
					}
					break;
				}
			}
			if(!selectedOne){
				alert('请选择一条记录!');
			}
		}
		
		/*
			保存表单
		*/
		function save(formId,tableId){	
			var flowForm = document.getElementById(formId);
			document.getElementById('saveButton').disabled=true;
			if(frmCheck(flowForm,tableId)==false){
				document.getElementById('saveButton').disabled=false;
				return false;
			}else{	
				flowForm.action="${contextPath}/plan/month/save.action";
				flowForm.submit();
			}
		}

		/*
			提交表单
		*/
		function toSubmit(option){
		
			if(!beforStartProcess()){
				return false;
			}
			var flowForm = document.getElementById('planBasicInfoForm');
			<s:if test="isUseBpm=='true'">
				if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined)
				{
					var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
					if(actor_name==null||actor_name=='')
					{
						window.alert('下一步处理人不能为空！');
						return false;
					}
				}
			</s:if>
			if(!confirm("确认要提交吗?")){
				return false;
			}
			document.getElementById('submitButton').disabled=true;
			<s:if test="isUseBpm=='true'">
				flowForm.action="<s:url action="submit" includeParams="none"/>";
			</s:if>
			<s:else>
				flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
			</s:else>
			flowForm.submit();

		}
		
		/*
			上传附件
		*/
		function Upload(id,filelist){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_month&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		    //parent.setAutoHeight();
		}
		
		/*
			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
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
			改变底部按钮状态
		*/
		function changeButtonState(checkbox,status){
			if(checkbox.checked){
				var ids = document.getElementsByName("detail_plan_id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked && checkbox.value != ids[i].value){
						ids[i].checked=false;
					}
				}
			}

			var updateButton = document.getElementById('updateButton');
			var deleteButton = document.getElementById('deleteButton');

			deleteButton.disabled=true;
			<s:if test="!@ais.plan.util.PlanSysParamUtil@isDetailPlanEnabled()">
				updateButton.disabled=true;
			</s:if>
			if(status=='计划草稿' && checkbox.checked){
				deleteButton.disabled=false;
				<s:if test="!@ais.plan.util.PlanSysParamUtil@isDetailPlanEnabled()">
					updateButton.disabled=false;
				</s:if>
			}
		}
	</script>
	</body>
</html>
