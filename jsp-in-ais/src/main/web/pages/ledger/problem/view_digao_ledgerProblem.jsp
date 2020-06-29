<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
		  
	<head>
		<title><s:property value="#title" /></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<s:head />
		<script type="text/javascript">
		$(document).ready(function(){
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
			function triggerTab(tab){
				var isDisplay = document.getElementById(tab).style.display;
				if(isDisplay==''){
					document.getElementById(tab).style.display='none';
				}else{
					document.getElementById(tab).style.display='';
				}
			}
			function toOpenView(id,interaction){
				window.location.href = "${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId="+id+"&interaction="+interaction;
//				window.parent.addTab('tabs','查看审计底稿','tempframe',viewUrl,true); 
			}
		</script>
	</head>
	<body style="overflow:auto">
		<s:form id="myform">
			<table cellpadding=1 cellspacing=1 border=0 
				class="ListTable" id="tab1">
				<s:if test="${middleLedgerProblem.manuscript_name != null && middleLedgerProblem.manuscript_name !='' }">
				<tr>
					<td class="EditHead" style="width:15%">底稿名称</td>
					<td class="editTd" style="width:35%">
						<%-- <a style="cursor:hand" href="${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId=${middleLedgerProblem.manuscript_id}&interaction=${interaction}" target="_blank"> --%>
						<a style="cursor:hand" href="javascript:void(0)" onclick="toOpenView('${middleLedgerProblem.manuscript_id}','${interaction}')">
						<s:property value="middleLedgerProblem.manuscript_name"/></a>
					</td>
					<%-- <td class="EditHead" style="width:15%">审计小组</td>
					<td class="editTd" style="width:35%">
						<s:property value="middleLedgerProblem.taskAssignName"/>
					</td> --%>
					<td class="EditHead" style="width: 15%">审计事项</td>
					<td class="editTd" style="width: 35%">
						<s:property value="middleLedgerProblem.task_name"/>
					</td>
				</tr>
				</s:if>
				<tr>
					<td class="EditHead">问题类别</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problem_all_name"/>
					</td>
					<td class="EditHead">审计问题编号</td>
					<td class="editTd" colspan="3">
						<s:property value="middleLedgerProblem.serial_num"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题标题</td>
					<td class="editTd">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.audit_con" title="问题标题" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<%-- <s:property value="middleLedgerProblem.audit_con"/> --%>
						<%-- <textarea class='noborder'  name="middleLedgerProblem.audit_con" readonly="readonly"
								rows="1" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_con}</textarea> --%>
						<s:property value="middleLedgerProblem.audit_con"/>
					</td>
					<td class="EditHead">被审计单位</td>
					<td class="editTd" >
						<s:property value="middleLedgerProblem.audit_object_name"/>
					</td>
				</tr>	
				<tr>
					<td class="EditHead">问题点</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problem_name"/>
					</td>
					<td class="EditHead">备注（问题点为其他）</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problemComment"/>
					</td>
				</tr>
			<%-- 	<tr>
					<td class="EditHead">是否可量化</td>
					<td class="editTd" colspan="3">${middleLedgerProblem.quantify}</td>
				</tr> --%>
				<tr>
					<td class="EditHead">涉及金额</td>
					<td class="editTd">
						<fmt:formatNumber value="${middleLedgerProblem.problem_money}" pattern="###.############"/>&nbsp;万元
					</td>
					<td class="EditHead">发生数量</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problemCount"/>&nbsp;个
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计发现类型</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problem_grade_name" />
					</td>
					<td class="EditHead">重要程度</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.ofsDetail"/>
						<%-- <s:if test="${middleLedgerProblem.ofsDetail != ''}">
							&nbsp;<s:property value="middleLedgerProblem.ofsDetail"/>
						</s:if> --%>
					</td>
				</tr>
				<tr>
					<s:if test="middleLedgerProblem.pro_type == '020312'">
						<td class="EditHead">责任<div>(经济责任审计)</div> </td>
						<td class="editTd" >
							<s:property value="middleLedgerProblem.zeren" />		
						</td>
					</s:if>
					<s:else>
							<td class="EditHead">责任<div>(非经济责任审计)</div></td>
						<td class="editTd" >
							<s:property value="middleLedgerProblem.zeren" />		
						</td>
					</s:else>
					</td>
					<td class="EditHead">问题发现日期</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problem_date"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题录入人</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.creater_name"/>
					</td>
					<td class="EditHead">问题发现人</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.lp_owner"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">是否采纳审计意见</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.sfcnsjyj" />
					</td>
					<td class="EditHead">关联底稿</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.linkManuName"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">违规违纪类型</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.wgwjlxName" />
					</td>
					<td class="EditHead">违规违纪金额</td>
					<td class="editTd">
						<fmt:formatNumber value="${middleLedgerProblem.wgwjje}" pattern="###.############"/>&nbsp;万元
					</td>
				</tr>
				
				<%-- <tr>
					<td class="EditHead">问题所属开始日期</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.creater_startdate" />
					</td>
					<td class="EditHead">问题所属结束日期</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.creater_enddate" />
					</td>
				</tr> --%>
				<%-- <tr>
					<td class="EditHead">与本单位经营战略相关度</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.tacticRelevancy"/>
						</td>
						<td class="EditHead">发生频率</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.occurrence"/>
						</td>
					</tr>
				<tr> --%>
					<td class="EditHead">问题描述</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.describe" title="问题摘要" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.describe" readonly="readonly"
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.describe}</textarea>
					</td>
				</tr>	
				<tr>
					<td class="EditHead">定性依据</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.audit_law" title="定性依据" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.audit_law" readonly="readonly"
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_law}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计建议</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.audit_advice" title="审计建议" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.audit_advice" readonly="readonly"
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
					</td>
				</tr>										
			</table>
		</s:form>
				 <s:if test="${sourceSite =='historyview' || sourceSite == 'syView' || sourceSite == 'syEdit' || sourceSite == 'historyedit' }">
		     <jsp:include flush="true" page="/pages/ledger/problem/other/view_history_ledgerProblem_rec.jsp" /> 
		   </s:if>
				<!-- <div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="triggerTab('tab2');">问题整改要求</a>
				</div> -->
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
			    class="ListTable" id="tab2" style="display: none;">
			<tr>
				<td class="EditHead">是否需要整改</td>
				<td class="editTd">
					<s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}"
						name="middleLedgerProblem.isNotMend" id="isNotMend" emptyOption="true" disabled="true"></s:select>
				</td>
				<td class="EditHead">整改期限</td>
				<td class="editTd">
					<s:property value="middleLedgerProblem.mend_term" />
				     	至
				    <s:property value="middleLedgerProblem.mend_term_enddate" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					责任单位
				</td>
				<td class="editTd">
					<s:property value="middleLedgerProblem.zeren_company" />
				</td>
				<td class="EditHead">
					整改责任部门
				</td>
				<td class="editTd">
					<s:property value="middleLedgerProblem.zeren_dept" />
				</td>
				
			</tr>
			<tr>
			    <td class="EditHead">整改负责人</td>
				<td class="editTd">
					<s:property value="middleLedgerProblem.zeren_person" />
				</td>
				<td class="EditHead">监督检查人</td>
				<td class="editTd">
				    <s:property value="middleLedgerProblem.examine_creater_code" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">建议追责方式</td>
				<td class="editTd">
					<s:property value="middleLedgerProblem.mend_method" />
				</td>
				<td class="EditHead">检查方式</td>
				<td class="editTd">
					<s:property value="middleLedgerProblem.examine_method" />
				</td>
			</tr>
			<tr>
					<td class="EditHead">整改建议<font color=DarkGray>(限3000字)</font></td>
					<td class="editTd" colspan="7">
						<s:textarea
							name="middleLedgerProblem.aud_action_plan" title="被审计单位行动计划" cssStyle="width:90%" readonly="true"/>
					</td>
			</tr>
		</table>
	</body>
</html>
