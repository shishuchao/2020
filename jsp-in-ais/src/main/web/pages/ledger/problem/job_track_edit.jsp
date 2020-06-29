<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE HTML>
<html>
	<head>
	<title>整改跟踪流程表单</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/ufaudTextLengthValidator.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>	
	<script type="text/javascript">
		//初始化
		$(function(){
			$('#mend_result').attr('maxlength',3000);
			$('#no_rectification_reason').attr('maxlength',3000);
			$('#examine_result').attr('maxlength',3000);
			$('#aud_track_result').attr('maxlength',3000);
		});
		function toSubmit(option){
			jQuery("#problemTracking_form").attr("action","submit.action");
			jQuery("#problemTracking_form").submit();
		}
		function beforStartProcess(){
			return true;
		}
		//上传附件
		function Upload(id,filelist){
			//var rnm = $("#"+id).val();
			window.showModalDialog('${pageContext.request.contextPath}/commons/file/welcome.action?table_name=mng_auditing_object&table_guid=other_resource_file&guid='+id+'&param='+id+'&deletePermission=true',file_idList,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
	</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:auto;" class="easyui-layout">
		<div id="problemTracking_div" title="整改结果跟踪记录"
			style='overflow:hidden;padding:0px;'>
			<form id='problemTracking_form' name='problemTracking_form'
				method="POST" action="saveProblemTracking.action"
				namespace="proledger/problem"
				style='height:70%;overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;'>
				<table class="ListTable" align="center">
					<tr>
						<td class="EditHead" style="width:15%">审计问题编号</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" id="serial_num" name="problemTracking.serial_num" cssStyle="width:180px;" readonly="true" />
						</td>
						<td class="EditHead" style="width:15%">跟踪人</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" id="tracker_name" name="problemTracking.tracker_name" readonly="true" cssStyle="width:180px;" /> 
							<s:hidden id="tracker_code" name="problemTracking.tracker_code" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">是否追责</td>
						<td class="editTd">
						<s:if test="varMap['responsibilityWrite']==null?true:varMap['responsibilityWrite']">
							<select class="easyui-combobox" name="problemTracking.responsibility" id="responsibility" style="width:180px;" editable="false" data-options="panelHeight:'auto'">
								 <option value="">&nbsp;</option>
								 <s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
									 <s:if test="${problemTracking.responsibility==key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
									 </s:if>
									 <s:else>
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									 </s:else>
								 </s:iterator>
							</select>
						</s:if>
						<s:else>
							${problemTracking.responsibility}		
							<s:hidden name="problemTracking.responsibility"></s:hidden>			
						</s:else>
						</td>
						<td class="EditHead">追责方式</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" maxlength="100" name="problemTracking.responsibility_Mode" id="responsibility_Mode" cssStyle="width:180px;height:20px;overflow-y:hidden" readonly="!(varMap['responsibility_ModeWrite']==null?true:varMap['responsibility_ModeWrite'])"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改状态</td>
						<td class="editTd">
						<s:if test="varMap['mend_state_codeWrite']==null?true:varMap['mend_state_codeWrite']">
							<select class="easyui-combobox" id="mend_state_code" name="problemTracking.mend_state_code" style="width:180px;" editable="false" data-options="panelHeight:'auto'">
								 <option value="">&nbsp;</option>
								 <s:iterator value="basicUtil.fllowOpinionList" id="entry">
									<s:if test="${problemTracking.mend_state_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									 </s:if>
									 <s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									 </s:else>
								 </s:iterator>
							</select>
						</s:if>
						<s:else>
							<s:if test="problemTracking.mend_state_code == 1">
								已全部整改
							</s:if>
							
							<s:if test="problemTracking.mend_state_code == 2">
								未整改
							</s:if>
							
							<s:if test="problemTracking.mend_state_code == 3">
								部分整改
							</s:if>
							<s:hidden name="problemTracking.mend_state_code"></s:hidden>
							<s:hidden name="problemTracking.mend_state"></s:hidden>
						</s:else>
						</td>
						<td class="EditHead">实际整改期限</td>
						<td class="editTd">
						<s:if test="varMap['examine_enddateWrite']==null?true:varMap['examine_enddateWrite']">
							<s:textfield  name="problemTracking.examine_enddate" id="examine_enddate"
								maxlength="20" title="单击选择日期"  cssClass="easyui-datebox noborder" />
						</s:if>
						<s:else>
							${problemTracking.examine_enddate}
							<s:hidden name="problemTracking.examine_enddate"></s:hidden>
						</s:else>
						
						</td>
					</tr>
					<tr>
						<td class="EditHead">反馈日期</td>
						<td class="editTd">
						<s:if test="varMap['feedback_dateWrite']==null?true:varMap['feedback_dateWrite']">
							<s:textfield name="problemTracking.feedback_date" id="feedback_date"
								maxlength="20" title="单击选择日期"  cssClass="easyui-datebox noborder"/>
						</s:if>
						<s:else>
							${problemTracking.feedback_date }
							<s:hidden name="problemTracking.feedback_date"></s:hidden>
						</s:else>
						
						</td>
						<td class="EditHead">实际检查人</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" maxlength="100" name="problemTracking.real_examine_creater" id="real_examine_creater" cssStyle="width:180px;height:20px;overflow-y:hidden" readonly="!(varMap['real_examine_createrWrite']==null?true:varMap['real_examine_createrWrite'])" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">被审计单位反馈的整改结果<br/><font color=DarkGray>(限3000字)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="problemTracking.mend_result" id="mend_result" title="被审计单位反馈整改结果" cssStyle="width:100%;height:70px;"  readonly="!(varMap['mend_resultWrite']==null?true:varMap['mend_resultWrite'])"/>
							<input type="hidden" id="problemTracking.mend_result.maxlength" value="3000" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">到期未整改原因<br/><font color=DarkGray>(限3000字)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="problemTracking.no_rectification_reason" id="no_rectification_reason" title="到期未整改原因" cssStyle="width:100%;height:70px;" readonly="!(varMap['no_rectification_reasonWrite']==null?true:varMap['no_rectification_reasonWrite'])" /> 
							<input type="hidden" id="problemTracking.no_rectification_reason.maxlength" value="3000" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计单位跟踪检查结果<br/><font color=DarkGray>(限3000字)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="problemTracking.examine_result" id="examine_result" title="审计单位跟踪检查结果" cssStyle="width:100%;height:70px;" readonly="!(varMap['examine_resultWrite']==null?true:varMap['examine_resultWrite'])"/> 
							<input type="hidden" id="problemTracking.examine_result.maxlength" value="3000" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">整改跟踪结论<br/><font color=DarkGray>(限3000字)</font></td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="problemTracking.aud_track_result" id="aud_track_result" cssStyle="width:100%;height:70px;" readonly="!(varMap['aud_track_resultWrite']==null?true:varMap['aud_track_resultWrite'])"></s:textarea> 
							<input type="hidden" id="problemTracking.aud_track_result.maxlength" value="3000" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">附件</td>
						<td class="editTd" colspan="3">
							<div data-options="fileGuid:'${problemTracking.fj}'" class="easyui-fileUpload"></div>
						</td>
					</tr>
				</table>
				<%
					String view = (String)request.getAttribute("view");
					if(!"view".equals(view)){
				%>
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
				</div>
				<%} %>
				<div style='text-align:center;' id='trackBtnDiv'
					style='padding:15px;'>
					<%
						if(!"view".equals(view)){
					%>
						<jsp:include flush="true"
								page="/pages/bpm/list_toBeStart.jsp" /> &nbsp;&nbsp; 
						<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="problemTracking_form.submit();">保存</a>
					<%} %>
					&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="window.location.href='${contextPath}/proledger/problem/jobtrackList.action?project_id=${project_id}&crudIdStrings=${crudIdStrings}'">返回</a>
				</div>
				<s:hidden name="crudIdStrings"></s:hidden>
				<s:hidden name="project_id"></s:hidden>
				<s:hidden name="problemTracking.middleLedgerProblem_id"></s:hidden>
				<s:hidden name="problemTracking.problem_name"></s:hidden>
				<s:hidden name="problemTracking.formId"></s:hidden>
				<s:hidden name="problemTracking.stateCode"></s:hidden>
				<s:hidden name="problemTracking.stateName"></s:hidden>
				<s:hidden name="problemTracking.fj" />
				<div align="center">
					<jsp:include flush="true"
						page="/pages/bpm/list_taskinstanceinfo.jsp" />
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
		$("#problemTracking_form").find("textarea").each(function(){
			autoTextarea(this);
		});
	</script>
</html>
