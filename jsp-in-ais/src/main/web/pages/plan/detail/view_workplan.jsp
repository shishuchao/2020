<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>项目计划</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	</head>
	<body>
		<s:form id="planForm" action="view" namespace="/plan/detail">
			<table id="planTable" class="ListTable" >
				<tr>
					<td class="EditHead" style="width: 15%">
						计划状态
					</td>
					<td class="editTd" style="width: 35%">
						<s:property value="crudObject.status_name" />
					</td>
					<td class="EditHead" style="width: 15%">
						计划编号
					</td>
					<td class="editTd" style="width: 35%;">
						<s:property value="crudObject.w_plan_code" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						计划年度
					</td>
					<td class="editTd">
						<s:property value="crudObject.w_plan_year" />
					</td>
					<td class="EditHead">
						计划月度
					</td>
					<td class="editTd">
						<s:property value="crudObject.w_plan_month" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计单位
					</td>
					<td class="editTd">
						<s:property value="crudObject.audit_dept_name"/>
					</td>
					<td class="EditHead">
						项目类别
					</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.pro_type_name"/>
						&nbsp;&nbsp;
						<s:property value="crudObject.pro_type_child_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						被审单位
					</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.audit_object_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						项目名称
					</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.w_plan_name" />
					</td>
						<%--<td class="EditHead" style="width:15%">
                            英文项目名称
                        </td>
                        <td class="editTd" colspan="3">
                            <s:property value="crudObject.w_plan_en_name"/>
                        </td>--%>
				</tr>
				<%--<tr>
					<td class="EditHead">上次审计年度</td>
					<td class="editTd">
						<s:property value="crudObject.lastAudYear"/>
					</td>
					<td class="EditHead">上次审计类型</td>
					<td class="editTd">
						<s:property value="crudObject.lastProTypeName"/>
					</td>
				</tr>--%>

				<tr>
					<td class="EditHead">
						计划类别
					</td>
					<td class="editTd">
						<s:property value="crudObject.w_plan_type_name"/>
					</td>
					<td class="EditHead">
						计划等级
					</td>
					<td class="editTd">
						<s:property value="crudObject.plan_grade_name"/>
					</td>
				</tr>

				<!-- 工程项目审计 -->
				<s:if test="crudObject.gcxmsj">
				<tr id="gcxmTr1">
					<td class="EditHead" id="gcxmTd1">
						合同金额
					</td>
					<td class="editTd" >
						<s:property value="crudObject.contractAmount"/>万元
					</td>
					<td class="EditHead" id="gcxmTd2">
						项目管理模式
					</td>
					<td class="editTd" >
						<s:property value="crudObject.managerType"/>
					</td>
				</tr>
				<tr id="gcxmTr2" >
					<td class="EditHead" id="gcxmTd3">
						开工日期
					</td>
					<td class="editTd" >
						<s:property value="crudObject.startProDate"/>
					</td>
					<td class="EditHead" id="gcxmTd4">
						竣工日期
					</td>
					<td class="editTd" >
						<s:property value="crudObject.finishProDate"/>
					</td>
				</tr>
				<tr id="gcxmTr3" >
					<td class="EditHead" id="gcxmTd5">
						项目状态
					</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.proStatus"/>
					</td>
				</tr>
				</s:if>
				<s:if test="crudObject.jjzrr">
					<tr>
						<td class="EditHead">
							经济责任人
						</td>
						<td class="editTd" colspan="3">
							<s:property value="crudObject.jjzrrname"/>
						</td>
						<!-- <td class="EditHead">
							是否为总公司党组管理干部
						</td>
						<td class="editTd" >
							<s:if test="${crudObject.isDangLeader=='true'}">
								是
							</s:if>
							<s:else>
								否
							</s:else>
						</td> -->
					</tr>
				</s:if>
				<s:if test="crudObject.rework">
					<tr>
						<td class="EditHead">
							后续审计项目
						</td>
						<td class="editTd" colspan="3">
							<s:property value="crudObject.reworkProjectNames"/>
						</td>
					</tr>
				</s:if>
				<tr>
					<td class="EditHead">
						审计方式
					</td>
					<td class="editTd">
						<!--<s:select id="handle_modus" name="crudObject.handle_modus"
						list="basicUtil.completed_FormList" listKey="code" listValue="name"
						disabled="true"
						display="${varMap['handle_modusRead']}" theme="ufaud_simple"
						templateDir="/strutsTemplate" emptyOption="true"/>-->
						<s:property escape="false" value="basicUtil.getCOMPLETEDFORMNameByCode('${crudObject.handle_modus}')"/>
					</td>
					<td class="EditHead" id="td_agency01">
						中介机构
					</td>
					<td class="editTd" id="td_agency02">
						<s:property escape="false" value="crudObject.agencyName"/>
					</td>
				</tr>
				<s:if test="${!crudObject.nbzwpg}">
					<tr>
						<td class="EditHead" style="width:15%">
							项目领导
						</td>
						<td class="editTd" style="width:35%">
							<s:property value="crudObject.pro_teamcharge_name"/>
						</td>
						<td class="EditHead" style="width:15%" id="zuzhangTd">
							项目组长
						</td>
						<td class="editTd" style="width:35%">
							<s:property value="crudObject.pro_teamleader_name"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width:15%" id="zhushenTd">
							项目主审
						</td>
						<td class="editTd" style="width:35%">
							<s:property value="crudObject.pro_auditleader_name"/>
						</td>
						<td class="EditHead" style="width:15%">
							项目参审
						</td>
						<td class="editTd" style="width:35%">
							<s:property value="crudObject.pro_teammember_name"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width:15%">
							项目维护人
						</td>
						<td class="editTd" style="width:35%" colspan="3">
							<s:property value="crudObject.pro_maintainer_name"/>
						</td>
					</tr>
				</s:if>
				<s:else>
					<tr>
					<td class="EditHead">
						内控专岗负责人
					</td>
					<td class="editTd" colspan="3">
						<s:property value="crudObject.pro_teamleader_name"/>
					</td>
				</tr>
				</s:else>
			
				<tr>
					<td class="EditHead">
						项目开始日期
					</td>
					<td class="editTd">
						<s:property value="crudObject.pro_starttime"/>
					</td>
					<td class="EditHead">
						项目结束日期
					</td>
					<td class="editTd">
						<s:property value="crudObject.pro_endtime"/>
					</td>
				</tr>
			<s:if test="${!crudObject.nbzwpg}">
				<tr>
					<td class="EditHead" nowrap>
						审计期间开始
					</td>
					<td class="editTd">
						<s:property value="crudObject.audit_start_time"/>
					</td>
					<td class="EditHead" nowrap>
						审计期间结束
					</td>
					<td class="editTd">
						<s:property value="crudObject.audit_end_time"/>
					</td>
				</tr>

				<tr>
					<s:if test="${isSyType == 'Y'}">
						<td class="EditHead" style="width:15%">
							作业模式
						</td>
						<td class="editTd" style="width:35%" id="planProcessTd03">
							<s:if test="${crudObject.xmType == 'syOff'}">
								离线
							</s:if>
							<s:elseif test="${crudObject.xmType == 'bs'}">
								在线
							</s:elseif>
						</td>
					</s:if>

					<s:if test="${isSyType != 'F' } ">
						<s:if test="${planProcessConfig eq 'simple'}">
						</s:if>
						<s:elseif test="${planProcessConfig eq 'complete'}">
						</s:elseif>
						<s:elseif test="${(planProcessConfig == 'both-simple' || planProcessConfig == 'both-complete') && crudObject.xmType != 'syOff'}">
							<td class="EditHead" style="width:15%" id="planProcessTd01">
								审计流程
							</td>
							<s:if test="${isSyType == 'Y'}">
								<td class="editTd" style="width:35%">
									<s:if test="${crudObject.planProcess == 'standard' && crudObject.xmType != null}">
										标准流程
									</s:if>
									<s:elseif test="${crudObject.planProcess == 'simplified' && crudObject.xmType != null}">
										简易流程
									</s:elseif>
								</td>
							</s:if>
							<s:else>
								<td class="editTd" style="width:35%" colspan="3">
									<s:if test="${crudObject.planProcess == 'standard' && crudObject.xmType != null}">
										标准流程
									</s:if>
									<s:elseif test="${crudObject.planProcess == 'simplified' && crudObject.xmType != null}">
										简易流程
									</s:elseif>
								</td>
							</s:else>
						</s:elseif>
					</s:if>
				</tr>

				<s:if test="${crudObject.planProcess == 'simplified'}">
					<tr class="simplifiedEle">
						<td class="EditHead" style="width:15%">
							参考方案
						</td>
						<td class="editTd" style="width:35%" colspan="3">
							<s:property value="crudObject.audTemplateName"/>
						</td>
					</tr>
				</s:if >

				<tr>
					<td class="EditHead" nowrap>
							立项依据
					</td>
					<td class="editTd" colspan="3">
						<textarea class='noborder'  name="crudObject.content" readonly="readonly"
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${crudObject.content}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计目的
					</td>
					<td class="editTd" colspan="3">
						<textarea class='noborder'  name="crudObject.audit_purpose" readonly="readonly"
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${crudObject.audit_purpose}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计安排
					</td>
					<td class="editTd" colspan="3">
						<textarea class='noborder'  name="crudObject.audArrange" readonly="readonly"
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${crudObject.audArrange}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计重点
					</td>
					<td class="editTd" colspan="3">
						<textarea class='noborder'  name="crudObject.audEmphasis" readonly="readonly"
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${crudObject.audEmphasis}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						备注
					</td>
					<td class="editTd" colspan="3">
						<textarea class='noborder'  name="crudObject.plan_remark" readonly="readonly"
								rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${crudObject.plan_remark}</textarea>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						附件
					</td>
					<td class="editTd" colspan="3">
						<div data-options="fileGuid:'${crudObject.w_file}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</td>
				</tr>
			</s:if>
			</table>
			
			<div align="center">
				<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>
			<!-- <div style="text-align:center;padding-right:20px;"><a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="back()">返回</a></div> -->
		</s:form>
	</body>
	<script type="text/javascript">
		function back(){
			window.history.back(-1);
		}
		$(document).ready(function(){
			$("#planForm").find("textarea").each(function(){
				autoTextarea(this);
			});
			if('${crudObject.planProcess}' == 'standard') {
				$('.simplifiedEle').hide();
			}
			var name = gethandleModusName('${crudObject.handle_modus}');
			changeAgency(name);


		});

		function gethandleModusName(n) {
			var handle_modus = eval('${completed_FormList}');
			var name = '';
			for(i in handle_modus) {
				if(handle_modus[i].code == n) {
					name = handle_modus[i].name;
					break;
				}
			}
			return name;
		}

		function changeAgency(value) {
			if(value.indexOf('外包') > 0) {
				$('#td_agency01').show();
				$('#td_agency02').show();
			} else {
				$('#td_agency01').hide();
				$('#td_agency02').hide();
			}
		}
	</script>
</html>
