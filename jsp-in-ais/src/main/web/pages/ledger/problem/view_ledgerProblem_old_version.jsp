<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
 
	<head>
		<title><s:property value="#title" /></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>	
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
			
			// 查看底稿
			function viewManu(){
				window.location.href = '${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId=${ledgerProblem.manuscript_id}&interaction=${interaction}'; 
			}
			
			// 关闭查看问题
		/* 	function closeViewProblem(){

				window.close(true);
			} */
		</script>
	</head>
	<body style="overflow:auto">
		<s:form id="myform">
<!-- 		<div style="width: 98%;position:absolute;top:0px;"  >
	 <a id="" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeViewProblem();">关闭</a>
		</div>
		      -->
			<table cellpadding=1 cellspacing=1 border=0 
				class="ListTable" id="tab1">
				<tr>
					<td class="EditHead" width="15%">所属底稿名称</td>
					<td class="editTd" width="35%">
					<s:property value="ledgerProblem.manuscript_name"/>
<!-- 						<a style="cursor:hand" href="javascript:;" onclick="viewManu()"/><s:property value="ledgerProblem.manuscript_name"/></a> -->
					</td>
					<%-- <td class="EditHead" width="15%">审计小组</td>
					<td class="editTd" width="35%">
						<s:property value="ledgerProblem.taskAssignName"/>
					</td> --%>
					<td class="EditHead" width="15%"></td>
					<td class="editTd" width="35%"></td>
				</tr>
				<tr>
					<td class="EditHead">审计事项</td>
					<td class="editTd" colspan="3">
						<s:property value="manuscript.task_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题类别</td>
					<td class="editTd">
						<s:property value="ledgerProblem.problem_all_name"/>
					</td>
					
					<td class="EditHead">审计问题编号</td>
					<td class="editTd">
						<s:property value="ledgerProblem.serial_num"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题标题</td>
					<td class="editTd" colspan="3">
						<s:property value="ledgerProblem.audit_con"/>			 
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题点</td>
					<td class="editTd">
						<s:property value="ledgerProblem.problem_name"/>
					</td>
					<td class="EditHead">备注(问题点为其他)</td>
					<td class="editTd">
						<s:property value="ledgerProblem.problemComment"/>
					</td>
				</tr>
		<%-- 		<tr>
					<td class="EditHead">是否可量化</td>
					<td class="editTd" >${ledgerProblem.quantify}</td>
					<td class="EditHead"></td>
					<td class="editTd" ></td>
				</tr> --%>
				<tr>
					<td class="EditHead">发生金额</td>
					<td class="editTd">
						<fmt:formatNumber value="${ledgerProblem.problem_money}" pattern="###.############"/>&nbsp;万元
					</td>
					<td class="EditHead">发生数量</td>
					<td class="editTd">
						<s:property value="ledgerProblem.problemCount"/>&nbsp;个
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题所属开始日期</td>
					<td class="editTd">
						<s:property value="ledgerProblem.creater_startdate" />
					</td>
					<td class="EditHead">问题所属结束日期</td>
					<td class="editTd">
						<s:property value="ledgerProblem.creater_enddate" />
					</td>
				</tr>
			<%-- 	<tr>
				
					<td class="EditHead">会计制度类型</td>
					<td class="editTd" >
						<s:property value="ledgerProblem.accountantSystemTypeName" />
					</td>
				</tr> --%>
				<tr>
					<s:if test="ledgerProblem.pro_type == '020312'">
						<td class="EditHead">责任<div>(经济责任审计)</div></td>
						<td class="editTd"><s:property value="ledgerProblem.zeren" /></td>
						<td class="EditHead"></td>
						<td class="editTd"></td>
					</s:if>
					<s:else>
						<td class="EditHead">责任<div>(非经济责任审计)</div></td>
						<td class="editTd"><s:property value="ledgerProblem.zeren" /></td>
						<td class="EditHead"></td>
						<td class="editTd"></td>
					</s:else>
				</tr>
				<tr>
					<td class="EditHead">发现人</td>
					<td class="editTd">
						<s:property value="ledgerProblem.creater_name"/>
					</td>
					<td class="EditHead">发现时间</td>
					<td class="editTd">
						<s:property value="ledgerProblem.problem_date"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计发现类型</td>
					<td class="editTd">
						<s:property value="ledgerProblem.problem_grade_name" />
					</td>
					<td class="EditHead">被审计单位</td>
					<td class="editTd">
						<s:property value="ledgerProblem.m_audit_dept"/>
					</td>

				</tr>
				<tr>
					<td class="EditHead">问题摘要</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="manuscript.describe" title="问题摘要" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<%-- <s:property value="manuscript.describe"/> --%>
						<textarea class='noborder'  name="ledgerProblem.describe" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${ledgerProblem.describe}</textarea>
					</td>
				</tr>	
				<tr>
					<td class="EditHead">定性依据</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="manuscript.audit_law" title="定性依据" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<%-- <s:property value="manuscript.audit_law"/> --%>
						<textarea class='noborder'  name="ledgerProblem.audit_law" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${ledgerProblem.audit_law}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计建议</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="manuscript.audit_advice" title="处理建议" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<%-- <s:property value="manuscript.audit_advice"/> --%>
						<textarea class='noborder'  name="ledgerProblem.audit_advice" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${ledgerProblem.audit_advice}</textarea>
					</td>
				</tr>									
			</table>
		</s:form>
				<!-- <div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="triggerTab('tab2');">问题整改要求</a>
				</div> -->
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
			    class="ListTable" id="tab2" style="display: none;">
			<tr>
				<td class="EditHead">是否需要整改</td>
				<td class="editTd">
					<s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}"
						name="ledgerProblem.isNotMend" id="isNotMend" emptyOption="true" disabled="true"></s:select>
				</td>
				<td class="EditHead">整改期限</td>
				<td class="editTd">
					<s:property value="ledgerProblem.mend_term" />
				     	至
				    <s:property value="ledgerProblem.mend_term_enddate" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					责任单位
				</td>
				<td class="editTd">
					<s:property value="ledgerProblem.zeren_company" />
				</td>
				<td class="EditHead">
					整改责任部门
				</td>
				<td class="editTd">
					<s:property value="ledgerProblem.zeren_dept" />
				</td>
				
			</tr>
			<tr>
			    <td class="EditHead">整改负责人</td>
				<td class="editTd">
					<s:property value="ledgerProblem.zeren_person" />
				</td>
				<td class="EditHead">监督检查人</td>
				<td class="editTd">
				    <s:property value="ledgerProblem.examine_creater_code" />
				</td>
			</tr>
			<tr>
				<td class="EditHead">建议追责方式</td>
				<td class="editTd">
					<s:property value="ledgerProblem.mend_method" />
				</td>
				<td class="EditHead">检查方式</td>
				<td class="editTd">
					<s:property value="ledgerProblem.examine_method" />
				</td>
			</tr>
			<tr>
					<td class="EditHead">整改建议<font color=DarkGray>(限3000字)</font></td>
					<td class="editTd" colspan="7">
						<s:textarea
							name="ledgerProblem.aud_action_plan" title="被审计单位行动计划" cssStyle="width:90%" readonly="true"/>
					</td>
			</tr>
		</table>
		
	</body>
</html>
