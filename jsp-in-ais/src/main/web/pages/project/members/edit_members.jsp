<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="ais.project.start.model.ProjectStartObject"%>
<%@page import="ais.project.ProjectContant"%>
<%@page import="ais.project.start.model.ProMember"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目成员管理</title>
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
		<s:head theme="ajax" />
		<style type="text/css">
			#group td,#member td{
				text-align: center;
			}
		</style>
	</head>
	<body>
		
			<s:tabbedPanel id="projectInfoPanel" theme='ajax' selectedTab="${param.selectedTab}">
			
				<s:div id='projectInfoDiv' label='基本信息' theme='ajax'>
					<table id="projectStartTable" cellpadding=0 cellspacing=1 border=0
						bgcolor="#409cce" class="ListTable" align="center">
						<tr>
							<td class="ListTableTr11">
								项目编号：
							</td>
							<td class="ListTableTr22">
								<s:property value="pso.project_code"/>
							</td>
							<td class="ListTableTr11">
								项目名称：
							</td>
							<td class="listtableTr22">
								<s:property value="pso.project_name" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								计划类别：
							</td>
							<td class="ListTableTr22">
								<s:property value="pso.plan_type_name"/>
							</td>
							<td class="ListTableTr11">
								项目类别：
							</td>
							<td class="ListTableTr22">
								<s:property value="pso.pro_type_name"/>
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								项目年度：
							</td>
							<td class="ListTableTr22">
								<s:property value="pso.pro_year" />
							</td>
							<td class="ListTableTr11">
								计划等级：
							</td>
							<td class="ListTableTr22">
								<s:property value="pso.plan_grade_name" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								审计单位：
							</td>
							<td class="ListTableTr22" colspan="3">
								<s:property value="pso.audit_dept_name" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								被审计单位：
							</td>
							<td class="ListTableTr22" colspan="3">
								<s:property value="pso.audit_object_name" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								经济责任人：
							</td>
							<td class="ListTableTr22" colspan="3">
								<s:property value="pso.jjzrrname" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								开始日期：
							</td>
							<td class="ListTableTr22">
								<s:property value="pso.pro_starttime" />
							</td>
							<td class="ListTableTr11">
								结束日期：
							</td>
							<td class="ListTableTr22">
								<s:property value="pso.pro_endtime" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11" nowrap>
								审计期间：
							</td>
							<td class="ListTableTr22" colspan="3">
								<s:property value="pso.audit_start_time" />
								--至--
								<s:property value="pso.audit_end_time" />
							</td>
						</tr>
		
						<tr>
							<td class="ListTableTr11">
								审计目的：
							</td>
							<td class="ListTableTr22" colspan="3">
								<s:property value="pso.audit_purpose" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								审计范围：
							</td>
							<td class="ListTableTr22" colspan="3">
								<s:property value="pso.audit_scope" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								审计依据：
							</td>
							<td class="ListTableTr22" colspan="3">
								<s:property value="pso.audit_basis" />
							</td>
						</tr>
						<tr>
							<td class="ListTableTr11">
								备注：
							</td>
							<td class="ListTableTr22" colspan="3">
								<s:property value="pso.plan_remark" />
							</td>
						</tr>
					</table>
					
					<div id="planFileList" align="center">
						<s:property value="planList" escape="false" />
					</div>

					<br/>
				</s:div>
				<s:div id='projectMemberDiv' label='成员信息' theme='ajax' labelposition='top' loadingText="正在加载内容......">
					<div align="center">
						<iframe id="projectMemberFrame"
							src="${contextPath}/project/members/listMembers.action?projectFormId=<s:property value="pso.formId" />"
							frameborder="0" width="100%" height="440"></iframe>
					</div>
				</s:div>

			</s:tabbedPanel>
		
		<script type="text/javascript">
		
			/**
				打开添加组员页面
			*/
			function openAddMemberPage(){
			  	var url = '${contextPath}/project/members/editMember.action?projectFormId=${projectFormId}';
			  	window.showModelessDialog(url,window,'dialogWidth:800px;dialogHeight:600px;status:no');
			}
			
			/**
				删除组员
			*/
			function deleteMember(){
				var ids = document.getElementsByName("memberCheckBox");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						if(confirm('确定要删除选定的项目成员吗？')){
							window.location.href="${contextPath}/project/members/deleteMember.action?projectFormId=${projectFormId}&&proMemberId="+ids[i].value;
						}
						break;
					}
				}
			}
			
			/**
				打开修改组员信息页面
			*/
			function openModifyMemberPage(){
				var ids = document.getElementsByName("memberCheckBox");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
					  	var url = '${contextPath}/project/members/editMember.action?projectFormId=${projectFormId}&&proMemberId='+ids[i].value;
					  	window.showModelessDialog(url,window,'dialogWidth:800px;dialogHeight:600px;status:no');
						break;
					}
				}
			}
			
			/**
				打开添加组页面
			*/
			function openAddGroupPage(){
			  	var url = '${contextPath}/project/members/editGroup.action?projectFormId=${projectFormId}';
			  	window.showModelessDialog(url,window,'dialogWidth:550px;dialogHeight:250px;status:no');
			}
			
			/**
				打开修改指定组页面
			*/
			function openModifyGroupPage(){
				var ids = document.getElementsByName("groupCheckBox");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
					  	var url = '${contextPath}/project/members/editGroup.action?projectFormId=${projectFormId}&&groupId='+ids[i].value;
					  	window.showModelessDialog(url,window,'dialogWidth:550px;dialogHeight:250px;status:no');
						break;
					}
				}
			}
			
			/**
				删除选中的组
			*/
			function deleteGroup(){
				var ids = document.getElementsByName("groupCheckBox");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						if(confirm('确定要删除选定的项目小组吗？一旦组被删除组下面的所有用户也将被删除!')){
							window.location.href="${contextPath}/project/members/deleteGroup.action?projectFormId=${projectFormId}&&groupId="+ids[i].value;
						}
						break;
					}
				}
			}
		
			/*
				改变底部按钮状态
			*/
			function changeGroupButtonState(checkbox,groupType){
				if(checkbox.checked){
					var ids = document.getElementsByName("groupCheckBox");
					for(var i=0;i<ids.length;i++){
						if(ids[i].checked && checkbox.value != ids[i].value){
							ids[i].checked=false;
						}
					}
				}
				var deleteButton = document.getElementById('deleteGroupButton');

				deleteButton.disabled=true;
				
				if((!checkbox.checked) || (groupType=='fenbu' && checkbox.checked)){
					deleteButton.disabled=false;
				}
			}
			
			/*
				改变底部按钮状态
			*/
			function changeMemberButtonState(checkbox,isAddByPlan){
				if(checkbox.checked){
					var ids = document.getElementsByName("memberCheckBox");
					for(var i=0;i<ids.length;i++){
						if(ids[i].checked && checkbox.value != ids[i].value){
							ids[i].checked=false;
						}
					}
				}
				var deleteButton = document.getElementById('deleteMemberButton');
				var modifyButton = document.getElementById('modifyMemberButton');
				
				deleteButton.disabled=true;
				modifyButton.disabled=true;
				
				if((isAddByPlan!='Y' && checkbox.checked)||(!checkbox.checked)){
					deleteButton.disabled=false;
					modifyButton.disabled=false;
				}
			}
		</script>
			<s:if test="#{act=='list'}">
				<br/>
				<center>
				<input type="button" value="返回" onclick="javascript:window.history.back()"/>
				</center>
			</s:if>
	</body>
</html>