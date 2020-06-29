<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>编辑年度计划</title>

<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>

<s:if test="${crudObject.formId != null && crudObject.formId != '' && taskInstanceId!=null&&taskInstanceId!=''&&taskInstanceId!='-1'}">
	<body onload="end();">
</s:if>
<s:else>
	<body>
</s:else>
	<s:form id="planBasicInfoForm" action="submit" namespace="/plan/year">

		<div class="easyui-layout" fit="true" id="layout">
			<div style="width: 60%;position:absolute;top:0px;right:10px;text-align: right;z-index: 1000;">
				<s:hidden name="fromAdjust" value="${fromAdjust}"/>
				<s:if test="${crudObject.formId != null && crudObject.formId != ''}">
					<s:if test="${needAudit == 'Y' && fromAdjust == 'yes'}">
						<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp?name=${crudObject.audit_dept_name}" />
					</s:if>
					<s:elseif test="${fromAdjust != 'yes'}">
						<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp?name=${crudObject.audit_dept_name}" />
					</s:elseif>
				</s:if>
				<s:if test="${fromAdjust == 'yes'}">
					<a id="backButton" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/plan/year/listAllAdjust!listAllAdjustMain.action'" >返回</a>
				</s:if>
				<s:else>
					<a id="saveButton" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';return save('planBasicInfoForm','planTable')">保存</a>
					<s:if test="${taskInstanceId!=null&&taskInstanceId>0}">
						<a id="backButton" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/bpm/taskinstance/pending.action?processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}'" >返回</a>
					</s:if>
					<s:else>
						<a id="backButton" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/plan/year/listAll.action'" >返回</a>
					</s:else>
				</s:else>
			</div>

			<div region="center">
				<div class="easyui-tabs" fit="true" id="yearTabs" border='0'>
					<div title="基本信息">
						<s:token/>
						<s:hidden name="crudObject.fid" />
						<s:hidden name="crudObject.w_writer_person" />
						<s:hidden name="crudObject.w_writer_person_name" />
						<s:hidden name="crudObject.w_write_date" />
						<s:hidden name="crudObject.formId" id="formId"/>
						<s:hidden name="crudObject.status"/>
						<s:hidden name="crudObject.status_name"/>
						<s:hidden name="crudObject.adjusting"/>
						<s:hidden name="processName" />
						<s:hidden name="project_name" />
						<s:hidden name="formNameDetail" />
						<s:hidden id="w_plan_code" name="crudObject.w_plan_code" />
						<table id="planTable" cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center" style="width: 98%">
							<tr>
								<td class="EditHead" style="width:15%;">计划状态</td>
								<td class="editTd" style="width:35%;"><s:property value="crudObject.status_name"/></td>
								<td class="EditHead"  style="width:15%;">年度计划编号</td>
								<td class="editTd" id="planCodeDiv" style="width:35%;"><s:property value="crudObject.w_plan_code" /></td>
							</tr>
							<tr>
								<td class="EditHead" nowrap><font color=red>*</font>&nbsp;计划名称</td>
								<td class="editTd" colspan="3">
									<s:if test="${fromAdjust eq 'yes'}">
										<input class="noborder" style="width: 75%" name="crudObject.w_plan_name" value="${crudObject.w_plan_name }" id='w_plan_name' maxlength="50" readonly="true" title="计划名称" />
									</s:if>
									<s:else>
										<input class="noborder" data-options="required:true,validType:'length[0,50]'" type="text" style="width: 73.5%"
											   name="crudObject.w_plan_name" value="${crudObject.w_plan_name }" id='w_plan_name' maxlength="255" title="计划名称" />
									</s:else>
								</td>
							</tr>
							<tr>
								<td class="EditHead" nowrap> 计划年度</td>
								<td class="editTd">
									<s:if test="${fromAdjust eq 'yes'}">
										<s:textfield id="workPlanYear" name="crudObject.w_plan_year" readonly="true" cssClass="noborder"/>
									</s:if>
									<s:else>
										<select id="workPlanYear" class="easyui-combobox" name="crudObject.w_plan_year" style="width:150px;" data-options="panelHeight:'auto',editable:false">
											<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)">
												<s:if test="${crudObject.w_plan_year==key}">
													<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
												</s:if>
												<s:else>
													<option value="<s:property value="key"/>"><s:property value="value"/></option>
												</s:else>
											</s:iterator>
										</select>
									</s:else>
								</td>
								<td class="EditHead"><font color=red>*</font>&nbsp;审计单位</td>
								<td class="editTd">
									<s:if test="${fromAdjust eq 'yes'}">
										<s:hidden name="crudObject.audit_dept" id="auditDeptId"/>
										<s:textfield id="audit_dept_name" name="crudObject.audit_dept_name" readonly="true" cssClass="noborder"/>
									</s:if>
									<s:else>
										<s:buttonText2 cssClass="noborder" id="audit_dept_name" name="crudObject.audit_dept_name" hiddenId="auditDeptId" hiddenName="crudObject.audit_dept" doubleOnclick="showSysTree(this,{
											title:'请选择审计单位',
											defaultDeptId:'${magOrganization.fid}',
											url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?isMag=1&p_item=1&orgtype=1',
											onAfterSure:auditDeptChange
										})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" maxlength="100" doubleCssStyle="cursor:pointer;border:0" readonly="true" display="!(varMap['audit_deptRead']==null?true:varMap['audit_deptRead'])" doubleDisabled="!(varMap['audit_deptWrite']==null?true:varMap['audit_deptWrite'])" />
									</s:else>

								</td>
							</tr>
							<tr>
								<td class="EditHead">计划管理员</td>
								<td class="editTd">
									<s:if test="${fromAdjust eq 'yes'}">
										<s:hidden name="crudObject.w_charge_person"/>
										<s:textfield id="w_charge_person_name" name="crudObject.w_charge_person_name" readonly="true" cssClass="noborder"/>
									</s:if> <s:else>
									<s:buttonText2 cssClass="noborder" id="wChargePerson" name="crudObject.w_charge_person_name" hiddenId="w_charge_person" hiddenName="crudObject.w_charge_person" doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
										  title:'请选择计划管理员',
										  type:'treeAndUser',
										  singleSelect:true,
										  defaultDeptId:'${user.fdepid}',
										  defaultUserId:'${user.fname}'
										})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" maxlength="100" doubleCssStyle="cursor:hand;border:0" readonly="true" display="!(varMap['w_charge_personRead']==null?true:varMap['w_charge_personRead'])" doubleDisabled="!(varMap['w_charge_personWrite']==null?true:varMap['w_charge_personWrite'])" />
								</s:else>
								</td>
								<td class="EditHead" nowrap><font color=red>*</font>&nbsp;计划编制日期</td>
								<td class="editTd">
									<s:if test="${fromAdjust eq 'yes'}">
										<input type="text" id="finishProDate" name="crudObject.planDate" value="${crudObject.planDate }" editable="false" Class="easyui-datebox noborder"/>
									</s:if>
									<s:else>
										<input value="${crudObject.planDate }" id="finishProDate" name="crudObject.planDate" type="text" class="easyui-datebox noborder" editable="false"/>
									</s:else>
								</td>
							</tr>
							<tr>
								<td class="EditHead" nowrap>
									风险评估结果<!-- 审计对象及范围 --><br/><div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
								</td>
								<td class=editTd colspan="3">
										<%-- <s:if test="${fromAdjust eq 'yes'}">
                                            <textarea class='noborder'  name="crudObject.audObjAndScope" readonly="readonly"
                                                      rows="5" style="width:98%;line-height:150%;" UNSELECTABLE='on'>${crudObject.audObjAndScope}</textarea>
                                        </s:if>
                                        <s:else> --%>
									<s:textarea  cssClass="noborder" id="audObjAndScope" name="crudObject.audObjAndScope" rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" onblur="doWhithOne(this)"/>
										<%-- </s:else> --%>
									<input type="hidden" id="crudObject.audObjAndScope.maxlength" value="2000">
								</td>
							</tr>
							<tr>
								<td class="EditHead" nowrap>
									审计重点<br/><div style="text-align:right"><font color=DarkGray>(限2000字)</font></div>
								</td>
								<td class="editTd" colspan="3">
										<%-- <s:if test="${fromAdjust eq 'yes'}">
                                            <textarea class='noborder'  name="crudObject.audImportant" id="audImportant" readonly="readonly"
                                                      rows="5" style="width:98%;line-height:150%;" UNSELECTABLE='on'>${crudObject.audImportant}</textarea>
                                        </s:if>
                                        <s:else> --%>
									<s:textarea  cssClass="noborder" id="audImportant" name="crudObject.audImportant" rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" onblur="doWhithOne(this)"/>
										<%-- </s:else> --%>
									<input type="hidden" id="crudObject.audImportant.maxlength" value="2000">
								</td>
							</tr>
							<tr>
								<td class="EditHead" nowrap>
									工作要求<br/><div style="text-align:right"><font color=DarkGray>(限2000字)</font></div>
								</td>
								<td class="editTd" colspan="3">
										<%-- <s:if test="${fromAdjust eq 'yes'}">
                                            <textarea class='noborder'  name="crudObject.audRequest" id="audRequest" readonly="readonly"
                                                      rows="5" style="width:98%;line-height:150%;" UNSELECTABLE='on'>${crudObject.audRequest}</textarea>
                                        </s:if>
                                        <s:else> --%>
									<s:textarea  cssClass="noborder" id="audRequest" name="crudObject.audRequest" rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" onblur="doWhithOne(this)"/>
										<%-- </s:else> --%>
									<input type="hidden" id="crudObject.audRequest.maxlength" value="2000">
								</td>
							</tr>
							<tr>
								<!-- fileUpload 组件文件上传 -->
								<td class="EditHead" nowrap>
									<div style='float:right;'>附件</div>
									<div id='addFileBtnID' style='float:right;margin:15px -60px 0 0;'></div>
									<s:hidden id="w_file" name="crudObject.w_file" />

								</td>
								<td class="editTd" colspan="3" >
									<s:if test="${fromAdjust eq 'yes'}">
										<div data-options="fileGuid:'${crudObject.w_file}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
									</s:if>
									<s:else>
										<div data-options="fileGuid:'${crudObject.w_file}'"  class="easyui-fileUpload"></div>
									</s:else>

								</td>
							</tr>
						</table>
					</div>
					<s:if test="${crudObject.formId != null && crudObject.formId != ''}">
						<div title="预选项目" style="overflow: hidden;">
							<iframe  id="yuxuan" src="<%=request.getContextPath()%>/plan/year/statisView.action?crudId=${crudId}&back=${taskInstanceId}&fromAdjust=${fromAdjust}" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden" ></iframe>
						</div>

						<%--<div title="重要项目" style="overflow: hidden;">--%>
							<%--<iframe  id="yuxuan" src="<%=request.getContextPath()%>/plan/year/statisView.action?searchCondition.plan_grade=1000&crudId=${crudId}&back=${taskInstanceId}&fromAdjust=${fromAdjust}" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden" ></iframe>--%>
						<%--</div>--%>

						<%--<div title="一般项目" style="overflow: hidden;">--%>
							<%--<iframe  id="normal" src="<%=request.getContextPath()%>/plan/year/statisView.action?searchCondition.plan_grade=1001&crudId=${crudId}&back=${taskInstanceId}&fromAdjust=${fromAdjust}" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="hidden" ></iframe>--%>
						<%--</div>--%>

						<%--<s:if test="${fromAdjust != null && fromAdjust == 'yes'}">--%>
							<%--<div title="外部监督项目" style="overflow: hidden;">--%>
								<%--<iframe  id="externalAudPro" src="${contextPath}/plan/year/statisView.action?prosource=external&crudId=${crudId}&back=${taskInstanceId}&fromAdjust=${fromAdjust}" width="100%"--%>
										 <%--height="100%" marginheight="0"  marginwidth="0" frameborder="0" scrolling="hidden" ></iframe>--%>
							<%--</div>--%>
						<%--</s:if>--%>
					</s:if>
				</div>
			</div>
			<div region="south" style="height: 200px;">
				<div align="center">
					<jsp:include flush="false" page="/pages/bpm/list_transition.jsp" />
					<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
				</div>
			</div>
		</div>

	</s:form>
<script type="text/javascript">
	var fromAdjust = "${fromAdjust}"; //是否从计划调整模块中过来
	$(function(){
        $('#planBasicInfoForm').height($(document).height()-20);
        setTimeout(function () {
            $('#layout').layout('resize');
            //$('#yearTabs').tabs('resize');
        },500);
        var south = $('#layout').layout('panel','south');
        if('${taskInstanceId}'==null||'${taskInstanceId}'==''||'${taskInstanceId}'=='0'){
            south.panel('close');
        }
		var tip = "${tip}";
		var flag="${flag}";
		if(tip == "1" && flag != "2"){
			top.$.messager.show({
				title:'提示消息',
				msg:"保存成功!",
				timeout: 5000,
				showType:'slide'

			});
		}
		if(fromAdjust != 'yes'){
			if('${crudObject.w_plan_year}' != null){
				$('#workPlanYear').combobox('select','${crudObject.w_plan_year}');
			}
			$('#workPlanYear').combobox({
			    onChange:function(newValue,oldValue){
			        getPlanCode();
			        var value = $('#w_plan_name').val().replace(oldValue, newValue);
			        $('#w_plan_name').val(value)
			    }
			});
			//auditDeptChange();
		} else {
			if('${crudObject.formId}' != null && '${crudObject.formId}' != ''){
	            $('#yearTabs').tabs('select','预选项目');
	        }
		}


		$('#audObjAndScope').attr('maxlength',2000);
		$('#audImportant').attr('maxlength',2000);
		$('#audRequest').attr('maxlength',2000);
		$('#w_plan_name').focus();

		if($('#formId').val()==null||$('#formId').val()==''){
			var now = new Date();
			var year = now.getFullYear();       //年
			var month = now.getMonth() + 1;     //月
			var day = now.getDate();            //日
			var clock = year + "-";
			if(month < 10)
				clock += "0";
			clock += month + "-";
			if(day < 10)
				clock += "0";
			clock += day + " ";
			$('#finishProDate').datebox('setValue', clock);
		}

		$("#planTable").find("textarea").each(function(){
			autoTextarea(this);
		});

		/*if(fromAdjust == 'yes'){
			$('#yearTabs').tabs('select','预选项目');
		}*/
	});
	/**
	 * 审计单位变更的后置动作
	 */
	function auditDeptChange() {
		getPlanCode();
		updateProcessSelection();
	}
	/*
		获取年度计划编号
	 */
	function getPlanCode() {
		var year = $('#workPlanYear').combobox('getValue');
		var auditDeptId = document.getElementById('auditDeptId').value;
		if (year != '' && auditDeptId != '') {
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);
			DWRActionUtil.execute({
				namespace : '/plan/year',
				action : 'getPlanCodeOfDept',
				executeResult : 'false'
			}, {
				'auditDeptId' : auditDeptId,
				'year' : year
			}, xxx);
			function xxx(data) {
				newPlanCode = data['planCode'];
				if (newPlanCode != '') {
					document.getElementById('w_plan_code').value = newPlanCode;
					document.getElementById('planCodeDiv').innerHTML = newPlanCode;
					var audit_dept_name =  $('#audit_dept_name').val();
					var year = $('#workPlanYear').combobox('getValue');
					$('#w_plan_name').val(audit_dept_name + year + '年度计划');
				}
			}
		}
	}

	/*
	 * 更新流程选择框
	 */
	function updateProcessSelection() {
		var auditDeptId = document.getElementById('auditDeptId').value;
		if('${taskInstanceId}' == '0'&&'${crudObject.formId}' != null && '${crudObject.formId}' != '')
			updateProcessDiv(auditDeptId);
	}

	/*
		判断年度计划是否已经存在，一个单位只能有一个特定年份的年度计划
	 */
	function isYearPlanExist(year,audit_dept) {
		var isHave = false;
		$.ajax({
			url:'${contextPath}/plan/year/isYearPlanExist.action',
			data:{'year':year,'audit_dept':audit_dept,'currentYearFormId' : '${crudObject.formId}'},
			async:false,
			type:'POST',
			success:function(data) {
				isHave = data;
			}
		});
		return isHave;
	}
	
	/*
	判断年度计划是否已经存在，一个单位只能有一个特定年份的年度计划
 */
	function isHaveThreeYearPlan() {
		var isHave = true;
		/* 修改为年度计划不必须有三年计划 by zxl 19.4.16
		if('${fromAdjust}' != 'yes') {
			var w_plan_year = $('#workPlanYear').combobox('getValue');
			var auditDept = $('#auditDeptId').val();
			$.ajax({
				url:'${contextPath}/plan/year/isHaveThreeYearPlan.action',
				type:'post',
				async:false,
				data:{'auditDept':auditDept,'w_plan_year':w_plan_year},
				success:function(data){
					isHave = data;
				}
			});
		}
		*/
		return isHave;
	}

	/*
		启动前校验，如果没有明细信息提醒用户
	 */
	function beforStartProcess() {
		if('${fromAdjust}' != 'yes') {
			// var num = $('#yuxuan')[0].contentWindow.getRowNum() + $('#normal')[0].contentWindow.getRowNum();
            var num = $('#yuxuan')[0].contentWindow.getRowNum();
			if(num == 0) {
				top.$.messager.show({
					title:'提示消息',
					msg:"项目计划不能为空！",
					timeout: 5000,
					showType:'slide'
				});
				return false;
			}
		}
		if (!validateWorkPlanInput()){
			return false;
		}
		$('#submitButton2Start').linkbutton('disable');
		document.getElementById('planBasicInfoForm').action =  "<s:url action="start" includeParams="none"/>";
		var planCode = document.getElementById('w_plan_code').value;
		var year;
		var audit_dept;
		if('${fromAdjust}' != 'yes') {
			year = $('#workPlanYear').combobox('getValue');
			audit_dept = $('#auditDeptId').val();
		} else {
			year = $('#workPlanYear').val();
			audit_dept = $('#auditDeptId').val();
		}
		if (isYearPlanExist(year,audit_dept) == 'true') {
			top.$.messager.show({
				title:'提示消息',
				msg:"已经存在\""+planCode+"\"的年度计划,不能再次创建!",
				timeout: 5000,
				showType:'slide'
			});
			return false;
		}
		
		if (isHaveThreeYearPlan() == 'false') {
			top.$.messager.show({
				title:'提示消息',
				msg:"三年计划未审批,不能创建年度计划!",
				timeout: 5000,
				showType:'slide'
			});
			return false;
		}
		
		var flowForm = document.getElementById('planBasicInfoForm');
		if (frmCheck(flowForm, 'planTable') == false) {
			return false;
		}
		return true;
	}

	// add by qfucee, 2013.3.19, 保存年度计划前校验必填项
	function validateWorkPlanInput() {
		var flag = true;
		var arr = [];
		arr.push({
			id : 'w_plan_name',
			text : '计划名称'
		});
		if(fromAdjust != 'yes'){
            arr.push({
                id : 'workPlanYear',
                text : '计划年度'
            });
            arr.push({
                id : 'wChargePerson',
                text : '计划管理员'
            });
        }

		arr.push({
			id : 'audit_dept_name',
			text : '审计单位'
		});
		arr.push({
			id:'finishProDate',
			text:'计划编制日期'
		});

		$.each(arr, function(i, json) {
			var obj = $('#' + json.id);
			if(json.id == 'finishProDate'){
				var datev=obj.datebox('getValue');
				if(datev == ''){
				    $.messager.alert('提示信息', '【' + json.text + '】必填！', 'error', function() {
						obj.focus();
					});
					flag = false;
				}
			}else if(json.id == 'workPlanYear'){
				var datev=obj.combobox('getValue');
				if(datev == ''){
				    $.messager.alert('提示信息', '【' + json.text + '】必填！', 'error', function() {
						obj.focus();
					});
					flag = false;
				}
			}else{
				if (!obj.val()) {
					flag = false;
					$.messager.alert('提示信息', '【' + json.text + '】必填！', 'error', function() {
						obj.focus();
					});
					return false;
				}
			}
		});
		return flag;
	}

	/*
		保存表单
	 */
	function save(formId, tableId) {
		if (!validateWorkPlanInput()){
			return;
		}	
		var planCode = document.getElementById('w_plan_code').value;
		var year;
		var audit_dept;
		if('${fromAdjust}'!= 'yes') {
			year = $('#workPlanYear').combobox('getValue');
			audit_dept = $('#auditDeptId').val();
		} else {
			year = $('#workPlanYear').val();
			audit_dept = $('#auditDeptId').val();
		}
		if (isYearPlanExist(year, audit_dept) == 'true') {
			top.$.messager.show({
				title:'提示消息',
				msg:"已经存在\""+planCode+"\"的年度计划,不能再次创建!",
				timeout: 5000,
				showType:'slide'
			});

			return false;
		}
		
		if (isHaveThreeYearPlan() == 'false') {
			top.$.messager.show({
				title:'提示消息',
				msg:"三年计划未审批,不能创建年度计划!",
				timeout: 5000,
				showType:'slide'
			});
			return false;
		}
		
		var flowForm = document.getElementById(formId);
		flowForm.action = "${contextPath}/plan/year/save.action?flag_tjsp=1";
		flowForm.submit();
	}
	function updateSave(){
		var flowForm = document.getElementById("planBasicInfoForm");
		flowForm.action = "${contextPath}/plan/year/updateSave.action?fromAdjust=yes";
		flowForm.submit();
	}

	/*
		提交表单
	 */
	function toSubmit(option) {

		if (!beforStartProcess()) {
			return false;
		}
		var flowForm = document.getElementById('planBasicInfoForm');
		<s:if test="isUseBpm=='true'">
		if (document.getElementsByName('isAutoAssign')[0].value == 'false' || document.getElementsByName('formInfo.toActorId')[0] != undefined) {
			var actor_name = document.getElementsByName('formInfo.toActorId')[0].value;
			if (actor_name == null || actor_name == '') {
				top.$.messager.alert('错误','处理人员不能为空！','error');
				return false;
			}
		}
		</s:if>
		top.$.messager.confirm('提示消息', '确认要提交吗？', function(r) {
			if (r) {
				<s:if test="isUseBpm=='true'">
				flowForm.action = "<s:url action="submit" includeParams="none"/>";
				</s:if>
				<s:else>
				flowForm.action = "<s:url action="directSubmit" includeParams="none"/>";
				</s:else>
				flowForm.submit();
			}else{
				return false;
			}
		});

	}

	/*
		上传附件
	 */
	function Upload(id, filelist) {
		var guid = document.getElementById(id).value;
		var num = Math.random();
		var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_year&talbe_guid=w_file&guid=' + guid + '&&param=' + rnm + '&&deletePermission=true', filelist, 'dialogWidth:700px;dialogHeight:450px;status:yes');
	}

	/*
		1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
		2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
			getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
	 */
	function deleteFile(fileId, guid, isDelete, isEdit, appType, title) {
		var boolFlag = window.confirm("确认删除吗?");
		if (boolFlag == true) {
			DWREngine.setAsync(false);
			DWRActionUtil.execute({
				namespace : '/commons/file',
				action : 'delFile',
				executeResult : 'false'
			}, {
				'fileId' : fileId,
				'deletePermission' : isDelete,
				'isEdit' : isEdit,
				'guid' : guid,
				'appType' : appType,
				'title' : title
			}, xxx);
			function xxx(data) {
				document.getElementById(guid).parentElement.innerHTML = data['accessoryList'];
			}
		}
	}
</script>
<script type="text/javascript">
	function showYuxuanProject(){
		//document.getElementById('planBasicInfoForm').action = "statisView.action";
		//document.getElementById('planBasicInfoForm').submit();
		window.location.href = "<%=request.getContextPath()%>/plan/year/statisView.action?crudId=${crudId}&back=${taskInstanceId}&fromAdjust=${fromAdjust}";
	}
	function doStart(){
		document.getElementById('planBasicInfoForm').action = "start.action";
		document.getElementById('planBasicInfoForm').submit();
	}
	function setNull(name){document.getElementsByName(name)[0].value="";}
	
	function doWhithOne(src){
	    var tmp=src.value.length;
	    if(tmp/1>2000){
	        top.$.messager.show({
				title:'提示消息',
				msg:src.title+'输入不能大于2000字!',
				timeout:5000,
				showType:'slide'
			});
	        src.value = src.value.substring(0, 2000);
	        src.focus();
	        return;
	    }
	}

	function coverAuditObject(){
	    var coverRate = encodeURI('${coverRate}');
        aud$openNewTab('审计计划单位覆盖情况','${contextPath}/plan/3year/queryCoverUncoverAuditObject.action?yearPlanId=${workPlan3Year.formId}&covered=${covered}&uncovered=${uncovered}&coverRate='+coverRate,false);
	}
	
	function importAdjust() {
		 $.ajax({
			type:'post',
			url:'/ais/plan/year/adjustDefinition.action',
			dataType:'json',
			data:{'year_id':'${crudId}','audit_dept':'${crudObject.audit_dept}'},
			async:false,
			success:function(data){
				 $("#definition_id").val(data);
				$("#definition_id").change();
			}
		});
	}
	
	function refresh() {
		window.location.reload();
	}
	</script>
</body>
</html>
