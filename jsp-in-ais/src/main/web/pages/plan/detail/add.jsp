<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<base target="_self">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>计划明细</title>
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
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	</head>
	<body>
	<center>
		<s:form id="planForm" action="savePlanItem" namespace="/plan/detail">
			<s:hidden name="crudObject.year_id" />
			<s:hidden name="crudObject.formId" />
			<s:hidden name="crudObject.source_plan_form_id" />
			<s:hidden name="crudObject.status_name" />
			<s:hidden name="crudObject.status" />
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;预选项目信息
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color=red>*</font>
						计划年度：
					</td>
					<td class="ListTableTr22">
						<s:select
							list="@ais.framework.util.DateUtil@getIncrementYearList(0,10)"
							name="crudObject.w_plan_year" disabled="true"
							theme="ufaud_simple" templateDir="/strutsTemplate" />
					</td>
					<td class="ListTableTr11">
						<font color=red>*</font>
						计划月度：
					</td>
					<td class="ListTableTr22">
						<s:select
							list="{'1','2','3','4','5','6','7','8','9','10','11','12'}"
							name="crudObject.w_plan_month" disabled="false"
							theme="ufaud_simple" templateDir="/strutsTemplate" />
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color=red>*</font>预选项目名称：
					</td>
					<td class="ListTableTr22">
						<s:textfield name="crudObject.w_plan_name" cssStyle="width:100%" maxlength="255" title="计划名称" />
					</td>
					<td class="ListTableTr11">
						<font color=red>*</font>负责人：
					</td>
					<td class="ListTableTr22">
						<s:buttonText2 id="pro_teamleader_name"
							hiddenId="pro_teamleader" name="crudObject.pro_teamleader_name"
							cssStyle="width:90%" hiddenName="crudObject.pro_teamleader"
							doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/frameselect4s.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=crudObject.pro_teamleader_name&paraid=crudObject.pro_teamleader',600,350)"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true" title="负责人" maxlength="500"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						计划等级：
					</td>
					<td class="ListTableTr22">
						<s:select id="plan_grade" name="crudObject.plan_grade"
							list="basicUtil.planLevelList" listKey="code" listValue="name" 
							theme="ufaud_simple"
							templateDir="/strutsTemplate" emptyOption="true"/>
					</td>
					<td class="ListTableTr11">
						<font color=red>*</font>
						项目类别：
					</td>
					<td class="ListTableTr22">
						<s:doubleselect id="pro_type" doubleId="pro_type_child"
							doubleList="projectTypeMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="crudObject.pro_type" list="projectTypeMap.keySet()"
							doubleName="crudObject.pro_type_child" theme="ufaud_simple"
							templateDir="/strutsTemplate"
							disabled="!(varMap['pro_typeWrite']==null?true:varMap['pro_typeWrite'])"
							doubleDisabled="!(varMap['pro_type_childWrite']==null?true:varMap['pro_type_childWrite'])"
							display="${varMap['pro_typeRead']}"  onchange="projectTypeChangeHandler()" 
							emptyOption="true" doubleEmptyOption="true"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<font color=red>*</font>审计实施单位：
					</td>
					<td class="ListTableTr22">
						<s:buttonText2 id="audit_dept_name" hiddenId="audit_dept"
							name="crudObject.audit_dept_name" cssStyle="width:90%"
							hiddenName="crudObject.audit_dept"
							doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=crudObject.audit_dept_name&paraid=crudObject.audit_dept',600,350,'组织机构选择')"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true" maxlength="100" title="审计单位"/>
					</td>
					<td id="auditObjectTd" class="ListTableTr11">
						<font color=red>*</font>
						被审计单位：
					</td>
					<td class="ListTableTr22">
						<s:buttonText2 id="audit_object_name" hiddenId="audit_object"
							name="crudObject.audit_object_name" cssStyle="width:90%"
							hiddenName="crudObject.audit_object"
							doubleOnclick="selectAuditObject()"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							display="${varMap['audit_objectRead']}"
							doubleDisabled="!(varMap['audit_object_buttonWrite']==null?true:varMap['audit_object_buttonWrite'])" 
							maxlength="1500" title="被审计单位"/>
					</td>
				</tr>
				<tr id="jjzrrTr" style="display: none;">
					<td class="ListTableTr11" id="jjzrrTd">
						&nbsp;
					</td>
					<td class="ListTableTr22" colspan="3">
					    <s:buttonText2 id="jjzrr" name="crudObject.jjzrrname" hiddenId="jjzrrName"
							cssStyle="width:95%" hiddenName="crudObject.jjzrrid"
							doubleOnclick="selectJJZRR()"
							doubleSrc="${contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							/>
					</td>
				</tr>
				<tr id="reworkTr"  style="display: none;">
					<s:if test="@ais.plan.util.PlanSysParamUtil@isReworkByProblem()">
						<td class="ListTableTr11">
							后续问题点：
						</td>
						<td class="ListTableTr22">
							<s:buttonText2 id="reworkProProblemName" hiddenId="reworkProProblemCode"
								name="crudObject.reworkProjectProblemName" cssStyle="width:90%"
								hiddenName="crudObject.reworkProjectProblemCode"
								doubleOnclick="selectReworkProjectProblem()"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" />
						</td>
					</s:if>
					<td class="ListTableTr11" id="reworkTd">
						&nbsp;
					</td>
					<s:if test="@ais.plan.util.PlanSysParamUtil@isReworkByProblem()">
						<td class="ListTableTr22" colspan="1">
					</s:if>
					<s:else>
						<td class="ListTableTr22" colspan="3">
					</s:else>
						<s:buttonText2 id="reworkProName" hiddenId="reworkProId"
							name="crudObject.reworkProjectNames" cssStyle="width:90%"
							hiddenName="crudObject.reworkProjectIds"
							doubleOnclick="selectReworkProject()"
							doubleSrc="${contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true" />
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						项目开始日期：
					</td>
					<td class="ListTableTr22">
						<s:textfield id="pro_starttime" name="crudObject.pro_starttime"
							readonly="true" cssStyle="width:90%" maxlength="15"
							title="单击选择日期" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
					<td class="ListTableTr11">
						项目结束日期：
					</td>
					<td class="ListTableTr22">
						<s:textfield id="pro_endtime" name="crudObject.pro_endtime"
							readonly="true" cssStyle="width:90%" maxlength="15"
							title="单击选择日期" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
				</tr>
				
				<tr>
					<td class="ListTableTr11" nowrap>
						<font color=red>*</font>
						审计期间开始：
					</td>
					<td class="ListTableTr22">
						<s:textfield id="audit_start_time" name="crudObject.audit_start_time"
								readonly="true" cssStyle="width:90%" maxlength="15"
								title="单击选择日期" onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
					<td class="ListTableTr11" nowrap>
						<font color=red>*</font>
						审计期间结束：
					</td>
					<td class="ListTableTr22">
						<s:textfield id="audit_end_time" name="crudObject.audit_end_time"
								readonly="true" cssStyle="width:90%" maxlength="15"
								title="单击选择日期" onclick="calendar()"
								theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" nowrap>
						正文内容：<br/><div style="text-align:left"><font color=DarkGray>(请限3000字)</font></div>
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea name="crudObject.content" rows="20" 
							cssStyle="width:100%;height:100px;overflow-y:visible" title="正文内容"/>
						 <input type="hidden" id="crudObject.content.maxlength" value="3000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						审计方式：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:select id="handle_modus" name="crudObject.handle_modus"
						list="basicUtil.completed_FormList" listKey="code" listValue="name"
						disabled="!(varMap['handle_modusWrite']==null?true:varMap['handle_modusWrite'])"
						display="${varMap['handle_modusRead']}" theme="ufaud_simple"
						templateDir="/strutsTemplate" emptyOption="true"/>
						
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						审计目的：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="audit_purpose" name="crudObject.audit_purpose" 
							cssStyle="width:100%;height:20;overflow-y:visible" title="审计目的"/>
						<input type="hidden" id="crudObject.audit_purpose.maxlength" value="1000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						审计范围：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="audit_scope" name="crudObject.audit_scope" 
							cssStyle="width:100%;height:20;overflow-y:visible" title="审计范围"/>
						<input type="hidden" id="crudObject.audit_scope.maxlength" value="1000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						审计依据：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="audit_basis" name="crudObject.audit_basis" 
							cssStyle="width:100%;height:20;overflow-y:visible" title="审计依据"/>
						<input type="hidden" id="crudObject.audit_basis.maxlength" value="1000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						备注：
					</td>
					<td class="ListTableTr22" colspan="3">
						<s:textarea id="plan_remark" name="crudObject.plan_remark"
							cssStyle="width:100%;height:20;overflow-y:visible" title="备注"/>
						<input type="hidden" id="crudObject.plan_remark.maxlength" value="1000"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						<s:button onclick="Upload('crudObject.w_file',accelerys)" value="上传附件" />
						<s:hidden name="crudObject.w_file" />
					</td>
					<td class="ListTableTr22" colspan="3">
						<div id="accelerys" align="center">
							<s:property escape="false" value="accessoryList" />
						</div>
					</td>
				</tr>
			</table>
			<div align="right" style="width:97%">
				&nbsp;&nbsp;
				<input id="saveButton" type="button" value="保存" onclick="this.style.disabled='disabled';save()">
				&nbsp;&nbsp;
				<input type="button" value="返回" onclick="this.style.disabled='disabled';window.navigate('${contextPath}/plan/year/edit.action?crudId=${crudObject.year_id}&selectedTab=yearDetailListDiv&taskInstanceId=${yearPlanTaskInstanceId}');">
			</div>
		</s:form>
	</center>

		<script language="javascript">

			/*
			* 	选择后续审计项目问题类别
			*/
			function selectReworkProjectProblem(){
		
				showPopWin('${contextPath}/pages/system/search/searchdatamuti.jsp?url=${contextPath}/plan/detail/problemTreeView.action&paraname=crudObject.reworkProjectProblemName&paraid=crudObject.reworkProjectProblemCode&funname=problemChange()',600,450,'审计问题点选择');
		
			}
	
			/**
			* 后续问题更改后的动作
			*/
			function problemChange(){
				document.getElementById('reworkProName').value=='';
				document.getElementById('reworkProId').value=='';
			}
		
			/*
			* 项目类别变更时候更新表单项目
			*/
			function projectTypeChangeHandler(){
				
				var isReworkEnable = <s:property value="@ais.project.ProjectSysParamUtil@isReworkProTypeEnabled()" />;
				var reworkProjectTypeCode = '<s:property value="@ais.project.ProjectContant@ZXHXSJ" />';
				var isJJZRREnable = <s:property value="@ais.project.ProjectSysParamUtil@isJjzrrProTypeEnabled()" />;
				var jjzrrProjectTypeCode = '<s:property value="@ais.project.ProjectContant@JJZRR" />';
				var currentProjectCode = document.getElementById('pro_type').value;
				
				if(isReworkEnable && currentProjectCode==reworkProjectTypeCode){
					document.getElementById('reworkTr').style.display='';
					document.getElementById('reworkTd').innerHTML='<font color=red>*</font>后续项目';
				}else if(isJJZRREnable && currentProjectCode==jjzrrProjectTypeCode){
					document.getElementById('jjzrrTr').style.display='';
					document.getElementById('jjzrrTd').innerHTML='<font color=red>*</font>经济责任人';
				}else{
					//切换后的项目类别不是经济责任人审计也不是专项后续审计
					document.getElementById('reworkTr').style.display='none';
					document.getElementById('jjzrrTr').style.display='none';
					document.getElementById('reworkTd').innerHTML='';//清空*,否则校验不通过
					document.getElementById('jjzrrTd').innerHTML='';//清空*,否则校验不通过
					document.getElementById('reworkProName').value='';
					document.getElementById('reworkProId').value='';
					document.getElementById('jjzrr').value='';
					document.getElementById('jjzrrName').value='';
				}
			}
			projectTypeChangeHandler();//页面加载完成先调用一次初始化页面

			/**
			* 选择被审计单位
			*/
			function selectAuditObject(){
				
				var auditDeptId = document.getElementById("audit_dept").value;//计划单位
				showPopWin('${contextPath}/pages/system/search/searchdatamuti.jsp?url=${contextPath}/mng/audobj/object/auditedDeptList.action&paraname=crudObject.audit_object_name&paraid=crudObject.audit_object&showRootNode=_show&funname=resetJjzrr()&where='+auditDeptId,600,450,'被审单位');
				
			}
			/*
			* 选择经纪人
			*/
			function selectJJZRR(){
				var auditObj = document.getElementById('audit_object').value;
				if(auditObj==''){
					alert('请先选择被审计单位!');
					return false;
				}
				
				showPopWin('${pageContext.request.contextPath}/pages/mng/economyduty/mutiselect.jsp?url=${pageContext.request.contextPath}/pages/mng/economyduty/econduty_sel.jsp&paraname=crudObject.jjzrrname&paraid=crudObject.jjzrrid&audobjid='+auditObj,600,450,'经济责任人');
				
			}
			
			/**
			* 校验经济责任人长度
			*/
			function validateJjzrr(){
				var jjzrrName = document.getElementById('jjzrr').value;
				if(jjzrrName.length > 640){
					alert('经济责任人名称输入超长,请重新选择!');
					return false;
				}
				return true;
			}
			
			/*
				选择后续审计的项目
			*/
			function selectReworkProject(){
				var isReworkByProblem = <s:property value="@ais.plan.util.PlanSysParamUtil@isReworkByProblem()" />;
				if(isReworkByProblem){
					var problemCode = document.getElementById('reworkProProblemCode').value;
					if(problemCode==''){
						alert('请先选择后续问题点!');
						return false;
					}
				  	var url = '${contextPath}/plan/detail/selectReworkProject.action?problemCodes='+problemCode;
				  	window.showModelessDialog(url,window,'dialogWidth:800px;dialogHeight:600px;status:no');
				}else{
				  	var url = '${contextPath}/plan/detail/selectReworkProject.action';
				  	window.showModelessDialog(url,window,'dialogWidth:800px;dialogHeight:600px;status:no');
				}
			}
		
			/*
			* 被审计单位改变的时候需要重置经济责任人的值
			*/
			function resetJjzrr(){
				document.getElementById('jjzrr').value='';
				document.getElementById('jjzrrName').value='';
			}
			
			function Upload(id,filelist){	
				var guid=document.getElementById(id).value;
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog('${pageContext.request.contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
				校验两个日期大小顺序
			*/
			function validateDate(beginDateId,endDateId){
				var s1 = document.getElementById(beginDateId);
				var e1 = document.getElementById(endDateId);
				if(s1 && e1){
					var s = s1.value;
					var e = e1.value;
					if(s!='' && e!=''){
						var s_date=new Date(s.replace("-","/"));
						var e_date=new Date(e.replace("-","/"));
						if(s_date.getTime()>e_date.getTime()){
							window.alert("日期区间开始必须小于结束!");
							return false;
						}
					}
				}
				return true;
			}
			
			function save()
			{	
				if(!validateDate('pro_starttime','pro_endtime')){
					return false;
				}
				if(!validateDate('audit_start_time','audit_end_time')){
					return false;
				}
				
				if(!validateJjzrr()){
					return false;
				}
				document.getElementById('saveButton').disabled=true;
				if(frmCheck(document.forms[0],'planTable')==false){
					document.getElementById('saveButton').disabled=false;
					
					return false;
				}
				else
				{	
					planForm.submit();
				}
			}
		</script>
	</body>
</html>
