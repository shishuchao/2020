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
			//初始化底稿查看窗口
			$(function(){
				$('#manu_div').window({   
					width:document.documentElement.clientWidth || document.body.clientWidth,   
					height:document.documentElement.clientHeight || document.body.clientHeight,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
			});
			$(function(){
				$("#tab1").find("textarea").each(function(){
					autoTextarea(this);
				});
			});
			function manuscriptView(){
				var temp = '${contextPath}/operate/manu/viewAll.action?crudId=${middleLedgerProblem.manuscript_id}&interaction=${interaction}&view=${param.view}';
				//window.parent.parent.addTab('tabs','审计底稿','tempframe',temp,true);
				$('#manu_iframe').attr("src",temp);
				$('#manu_div').window('open');
			}
		</script>
	</head>
	<body>
		<div region="north">
		   <a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="history.go(-1)" >返回</a>							        
		 </div>
		<div region="center">
			<table cellpadding=1 cellspacing=1 border=0 
				class="ListTable" id="tab1">
	
				<tr>
					<td class="EditHead" style="width:15%">底稿名称</td>
					<td class="editTd" style="width:35%">
						<a href="javascript:void(0);" onclick="manuscriptView()" id="manuscriptView"><s:property value="middleLedgerProblem.manuscript_name"/></a>
					</td>
			<%-- 		<td class="EditHead" style="width:15%">审计小组</td>
					<td class="editTd" style="width:35%">
						<s:property value="middleLedgerProblem.taskAssignName"/>
					</td> --%>
					<td class="EditHead" style="width:15%"></td>
					<td class="editTd" style="width:35%">
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计事项</td>
					<td class="editTd" colspan="3">
						<s:property value="middleLedgerProblem.task_name"/>
					</td>
				</tr>
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
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.audit_con" title="问题标题" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<%-- <s:property value="middleLedgerProblem.audit_con" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.audit_con" title="问题标题" readonly="readonly"
								style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_con}</textarea>
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
				<tr>
					<td class="EditHead">发生金额</td>
					<td class="editTd">
						<fmt:formatNumber value="${middleLedgerProblem.problem_money}" pattern="###.############"/>&nbsp;万元
					</td>
					<td class="EditHead">发生数量</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problemCount"/>&nbsp;个
					</td>
				</tr>
				<tr>
					<td class="EditHead">问题所属开始日期</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.creater_startdate" />
					</td>
					<td class="EditHead">问题所属结束日期</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.creater_enddate" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计发现类型</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problem_grade_name" />
					</td>
				<%-- 	<td class="EditHead">会计制度类型</td>
					<td class="editTd" >
						<s:property value="middleLedgerProblem.accountantSystemTypeName" />
					</td> --%>
						<td class="EditHead"></td>
						<td class="editTd"></td>
				</tr>
				<tr>
					<s:if test="middleLedgerProblem.pro_type == '020312'">
						<td class="EditHead">责任<div>(经济责任审计)</div></td>
						<td class="editTd"><s:property value="middleLedgerProblem.zeren" /></td>
						<td class="EditHead"></td>
						<td class="editTd"></td>
					</s:if>
					<s:else>
						<td class="EditHead">责任<div>(非经济责任审计)</div></td>
						<td class="editTd"><s:property value="middleLedgerProblem.zeren" /></td>
						<td class="EditHead"></td>
						<td class="editTd"></td>
					</s:else>
				</tr>
					<tr>
					<td class="EditHead">发现人</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.creater_name"/>
					</td>
					<td class="EditHead">发现时间</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.problem_date"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">被审计单位</td>
					<td class="editTd" colspan="3">
						<s:property value="middleLedgerProblem.audit_object_name"/>
					</td>
				</tr>

				<tr>
					<td class="EditHead">问题摘要</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.describe" title="问题摘要" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<%-- <s:property value="middleLedgerProblem.describe" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.describe" title="问题摘要" readonly="readonly"
								style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.describe}</textarea>
					</td>
				</tr>	
				<tr>
					<td class="EditHead">定性依据</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='noborder' name="middleLedgerProblem.audit_law" title="定性依据" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<%-- <s:property value="middleLedgerProblem.audit_law" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.audit_law" title="定性依据" readonly="readonly"
								style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_law}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计建议</td>
					<td class="editTd" colspan="3">
						<%-- <s:textarea cssClass='autoResizeTexareaHeight' name="middleLedgerProblem.audit_advice" title="审计建议" readonly="true"
							cssStyle="width:100%;height:70;" /> --%>
						<%-- <s:property value="middleLedgerProblem.audit_advice" /> --%>
						<textarea class='noborder'  name="middleLedgerProblem.audit_advice" title="审计建议" readonly="readonly"
								style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
					</td>
				</tr>										
			</table>
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
		</div>
		<div id="manu_div" title="审计底稿查看" style="overflow:hidden;padding:0px">
	  		<iframe id="manu_iframe" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
	</body>
</html>
