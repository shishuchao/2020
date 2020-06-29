<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>月度计划总结</title>
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
	<body>
	
	<s:tabbedPanel id="monthPlanPanel" theme='ajax' selectedTab="${param.selectedTab}">
		
		<s:div id='monthBasicInfoDiv' label='计划信息' theme='ajax'>
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
						</td>
						<td class="ListTableTr11" nowrap>
							月度计划编号：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_plan_code" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划年度：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_plan_year"/>
						</td>
						<td class="ListTableTr11">
							计划月度：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_plan_month"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划名称：
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:property value="crudObject.w_plan_name"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划单位：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.audit_dept_name"/>
						</td>
						<td class="ListTableTr11">
							负责人：
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.w_charge_person_name"/>
						</td>
					</tr>

					<tr>
						<td class="ListTableTr11">
							正文内容：
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="crudObject.content" readonly="true"
								 cssStyle="width:100%;height:20;overflow-y:visible;border:0" title="正文内容"/>
							<input type="hidden" id="crudObject.content.maxlength" value="3000"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							附件：
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="accelerys" align="center">
								<s:property escape="false" value="accessoryList" />
							</div>
						</td>
					</tr>
				</table>
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
				</div>
				<br/>
		</s:div>
		
		<s:div id='monthDetailListDiv' label='明细信息' theme='ajax'>
			<s:form id="monthDetailPlanSearchForm" action="listMonthDetailPlan" namespace="/plan/month" >
				<div align="center">
					<display:table name="monthDetailList" id="row" class="its" cellpadding="1">
						<display:column title="选择" headerClass="center" class="center">
							<input type="checkbox" name="detail_plan_id" disabled="true" value="${row.formId}">
							<input type="hidden" id="${row.formId}_status" value="${row.status_name}" />
						</display:column>
						<display:column property="status_name" title="计划状态" headerClass="center" class="center" />
						<display:column property="w_plan_type_name" title="计划类别" headerClass="center" class="center" />
						<display:column property="w_plan_year" title="计划年度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" />
						<display:column property="w_plan_month" title="计划月度" headerClass="center" style="WHITE-SPACE: nowrap" class="center" />
						<display:column title="明细信息名称" headerClass="center" class="center"  style="text-align:left;word-break:break-all;">
							<a href="/ais/plan/month/viewMonthDetail.action?monthDetailId=${row.formId}" target="_blank">${row.w_plan_name}</a>
						</display:column>
						<display:column property="audit_dept_name" title="审计单位" headerClass="center" class="center" />
						<display:column property="pro_teamleader_name" title="负责人" headerClass="center" class="center" />
						<display:setProperty name="paging.banner.placement" value="bottom" />
					</display:table>
				</div>
				
				<br/>
			</s:form>
		</s:div>
		<s:div id='monthPlanZJDiv' label='工作总结' theme='ajax'>
			<s:form id="monthPlanZJForm" action="saveSummarize" namespace="/plan/month" >
				<s:hidden name="crudId"/>
				<table id="zjTable" cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead" style="width: ;">
						<td colspan="4" align="left" class="edithead">
							&nbsp;月度计划总结
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划年度：
						</td>
						<td class="ListTableTr22">
							${crudObject.w_plan_year }
						</td>
						<td class="ListTableTr11">
							计划月度：
						</td>
						<td class="ListTableTr22">
							${crudObject.w_plan_month }
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							计划编号：
						</td>
						<td class="ListTableTr22">
							${crudObject.w_plan_code }
						</td>
						<td class="ListTableTr11">
							总结单位：
						</td>
						<td class="ListTableTr22">
							${crudObject.zjdw_name }
							<s:hidden name="crudObject.zjdw"/>
							<s:hidden name="crudObject.zjdw_name"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							总结人：
						</td>
						<td class="ListTableTr22">
							${crudObject.zjr_name}
							<s:hidden name="crudObject.zjr"/>
							<s:hidden name="crudObject.zjr_name"/>
						</td>
						<td class="ListTableTr11">
							总结日期：
						</td>
						<td class="ListTableTr22">
							<s:date format="yyyy-MM-dd" name="crudObject.zjrq"/>
							<s:hidden name="crudObject.zjrq"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							总结内容：
						</td>
						<td class="ListTableTr22" colspan=3>
							<s:textarea id="content" name="crudObject.zjzw" 
								value="${crudObject.zjzw}" cssStyle="width:600px" title="总结内容"/>
							<input type="hidden" id="crudObject.zjzw.maxlength" value="3000"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							<s:if test="${crudObject.zj_submitted!='Y'}">
								<s:button onclick="Upload('crudObject.zjfjid',accelerysOfZJ)" value="上传附件" />
								<s:hidden name="crudObject.zjfjid" />
							</s:if>
							<s:else>
								附件：
							</s:else>
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="accelerysOfZJ" align="center">
								<s:property escape="false" value="accessoryListOfZJ" />
							</div>
						</td>
					</tr>
				</table>
				<div align="right" style="width: 97%">
					<s:if test="${crudObject.zj_submitted!='Y'}">
						<s:submit value="保存" onclick="this.style.disabled='disabled';"/>
						<input id="submitZJButton" type="button" value="提交" onclick="this.style.disabled='disabled';submitZJ()">
					</s:if>
				</div>
				<br/>
			</s:form>
		</s:div>
	</s:tabbedPanel>
	<script type="text/javascript">


		/*
			提交总结,一旦提交将不可以修改
		*/
		function submitZJ(){
			var content = document.getElementById('content').value;
			if(content=='' && !confirm('总结内容为空,确认提交吗?一旦提交将不可以再修改!')){
				return false;
			}
			if(!confirm('注意：确认提交吗?一旦提交将不可以再修改!')){
				return false;
			}
			var monthPlanZJForm = document.getElementById('monthPlanZJForm');
			monthPlanZJForm.action="${contextPath}/plan/month/submitSummarize.action";
			monthPlanZJForm.submit();
		}
	
		/*
			上传附件
		*/
		function Upload(id,filelist){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_month&table_guid=zjfjid&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
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
	</script>
	</body>
</html>
