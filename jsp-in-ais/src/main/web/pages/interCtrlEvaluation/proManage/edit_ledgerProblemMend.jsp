<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML>
<s:text id="title" name="'整改问题信息'"></s:text>
<html>
	<head>
		<title>编辑整改措施</title>
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<style type="text/css">
			.EditHead {
				width:20%;
			}
			
			.editTd {
				width:30%;
			}
		</style>
	</head>
	<body style="margin:0px;padding:0px;">
		<center>
			<div class="easyui-panel" style="width:100%;padding:0px;" title="缺陷基本信息" border="0">
				<form id="ledgerForm">
					<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab1" 
					style="width:100%;margin:0px;padding:0px;border:0px;">
						<tr>
							<td class="EditHead" style="border-top-width:0px;">所属控制点</td>
							<td class="editTd" colspan="3" style="border-top-width:0px;">
								<s:property  value="interCtrlProblem.controlName" />
							</td>
						</tr>
						<tr>
							<td class="EditHead">所属主流程</td>
							<td class="editTd" colspan="3">
								<s:property value="interCtrlProblem.circuitName" id="circuitName"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">所属子流程</td>
							<td class="editTd" colspan="3">
								<s:property  value="interCtrlProblem.sonCircuitName" id="sonCircuitName"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">被评价单位</td>
							<td class="editTd">
								<s:property  value="interCtrlProblem.evaDept" id="evaDept"/>
							</td>
							<td class="EditHead">底稿索引</td>
							<td class="editTd" >
								<s:property  value="interCtrlProblem.manuscriptIndex" />
							</td>
						</tr>
						<tr>
							<td class="EditHead">内控缺陷编号</td>
							<td class="editTd">
								<s:textfield name="interCtrlProblem.defectCode" cssClass="noborder" readonly="true"></s:textfield>
							</td>
							<td class="EditHead">内控缺陷名称</td>
							<td class="editTd">
								<s:textfield name="interCtrlProblem.defectName" cssClass="noborder" readonly="true"></s:textfield>
							</td>
						</tr>
						<tr>
							<td class="EditHead">涉及单位部门</td>
							<td class="editTd" colspan="3">
								<s:property  value="interCtrlProblem.involveDept" id="involveDept"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">内控缺陷描述</td>
							<td class="editTd" colspan="3">
								<s:property  value="interCtrlProblem.defectDescription" id="defectDescription"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">缺陷成因</td>
							<td class="editTd" colspan="3">
								<s:property  value="interCtrlProblem.defectCause" id="defectCause"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">涉及的损失/错报的金额</td>
							<td class="editTd">
								<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${interCtrlProblem.relateLoss}</fmt:formatNumber>
								&nbsp;万元</td>
							<td class="EditHead">缺陷类型</td>
							<td class="editTd">
								<s:property  value="interCtrlProblem.defectTypeName" id="defectTypeName"/>
							</td>
							
						</tr>
						<tr>
							<td class="EditHead">风险及影响</td>
							<td class="editTd" colspan="3">
								<s:property value="interCtrlProblem.riskEffect" id="riskEffect"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">认定结果</td>
							<td class="editTd" colspan="3">
								<s:property value="interCtrlProblem.defineResult" id="defineResult"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">整改建议</td>
							<td class="editTd" colspan="3">
								<s:property value="interCtrlProblem.mendAdvice" id="mendAdvice"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">整改建议描述</td>
							<td class="editTd" colspan="3">
								<s:property value="interCtrlProblem.suggestDescription" id="suggestDescription"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">整改责任单位</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.accountabilityUnit" id="accountabilityUnit"/>
							</td>
							<td class="EditHead">整改主责部门</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.accountabilityDept" id="accountabilityDept"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">整改责任人</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.personLiable" id="personLiable"/>
							</td>
							<td class="EditHead">联系电话</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.telephone" id="telephone"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">整改期限</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.mendDeadline" id="mendDeadline"/>
							</td>
							<td class="EditHead">整改方式</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.mendMethod" id=""/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">监督检查人</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.checkPeople" id="checkPeople"/>
							</td>
							<td class="EditHead">检查方式</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.checkMethod" id="checkMethod"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								附件
							</td>
							<td class="editTd" colspan="3">
								<div data-options="fileGuid:'${interCtrlProblem.attachmentId}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
							</td>
						</tr>
					</table>
				</form>
			</div>	
			<div class="easyui-panel" style="width:100%;padding:0px;overflow-x:hidden" title="整改措施录入" border="0">
				<s:form id="myform" action="updateLedgerProblem" namespace="/intctet/proManage"
					cssStyle="margin:0px;padding:0px;width:100%;">
					<table cellpadding=1 cellspacing=1 border=0 class="ListTable_change" id="tab2"
						style="width:100%;margin:0px;padding:0px;border:0px;">
						<tr>
							<td class="EditHead" style="border-top-width:0px;"><FONT color=red>*</FONT>整改措施描述
								<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
							</td>
							<td class="editTd" colspan="3" style="border-top-width:0px;">
								<s:textarea id="mendMeasureDescription" name="interCtrlProblem.mendMeasureDescription" cssClass="noborder"
								cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
								<input type="hidden" id="interCtrlProblem.mendMeasureDescription.maxlength" value="200"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								整改责任部门/个人
							</td>
							<td class="editTd" colspan="3">
								<s:textfield name="interCtrlProblem.mendDeptPerson" cssClass="noborder" maxlength="100"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead"><FONT color=red>*</FONT>计划开始时间</td>
							<td class="editTd">
								<input type="text" id="mend_term" name="interCtrlProblem.planStartTime" value="${interCtrlProblem.planStartTime }" editable="false" Class="easyui-datebox noborder" style="width:140px;"/>
							</td>
							<td class="EditHead"><FONT color=red>*</FONT>计划完成时间</td>
							<td class="editTd">
								<input type="text" id="mend_term_enddate" name="interCtrlProblem.planEndTime" value="${interCtrlProblem.planEndTime }" editable="false"  Class="easyui-datebox noborder" style="width:140px;"/>
							</td>
						</tr>
						<tr>
						    <td class="EditHead">录入人</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.writePerson"/>
								<s:hidden name="interCtrlProblem.writePerson"/>
								<s:hidden name="interCtrlProblem.writePersonCode"/>
							</td>
							<td class="EditHead">录入时间</td>
							<td class="editTd">
								<s:property value="interCtrlProblem.writeTime"/>
								<s:hidden name="interCtrlProblem.writeTime"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap>附件
								<s:hidden id="file_id" name="interCtrlProblem.mend_measure_file_id" />
							</td>
							<td class="editTd" colspan="3" >
								<div data-options="fileGuid:'${interCtrlProblem.mend_measure_file_id}'"  class="easyui-fileUpload"></div>
							</td>
						</tr>
					</table>
				<s:hidden name="isEdit"/>
				<s:hidden name="permission"/>
				<s:hidden name="project_code" />
				<s:hidden name="project_id" />
				<s:hidden name="interCtrlProblem.proId" value="%{project_id}" />
				<s:hidden name="interCtrlProblem.id" />
			</s:form>
		</div>
		<div style="padding:10px;text-align:right;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm()">保存</a>&nbsp;&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="back()">返回</a>
		</div>
	</center>
	<script language="javascript">
		
		function saveForm(){
			
			var mend_term = $('#mend_term').datebox('getValue');
			var mend_term_enddate = $('#mend_term_enddate').datebox('getValue');
			var mendMeasureDescription = $('#mendMeasureDescription').val();
			if(mendMeasureDescription==null||mendMeasureDescription==''){
				alert("整改措施描述不能为空!");
				return false;
			}
			if(mend_term==null||mend_term==''){
	            alert("计划开始日期不能为空!");
           		return false;
			}
			if(mend_term_enddate==null||mend_term_enddate==''){
	            alert("计划结束日期不能为空!");
	            return false;
			}
			var dts=new Date(Date.parse(mend_term.replace(/-/g,"/")));
       		var dte=new Date(Date.parse(mend_term_enddate.replace(/-/g,"/")));
			if(dte<dts){
				alert("结束日期不能小于开始日期!");
	            return false;
			}
			myform.submit();
			window.parent.saveCloseWin();
		}
		
		function back(){
		  /* window.location.href="${contextPath}/proledger/problem/overallMendLedger.action?project_id=${project_id}&isEdit=${isEdit}&permission=${permission}"; */
			window.location.href="/ais/intctet/proManage/auditDeptTabFile.action?projectid=${project_id}&wpd_stagecode=rework";
		}
		//上传附件
		function Upload(id,filelist,delete_flag,edit_flag){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=LedgerProblem&table_guid=file_id&guid='+guid+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		}
		//删除方法
 		/*
 			1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 			2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
 				getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
 		*/
	     function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
			var boolFlag=window.confirm("确认删除吗?");
			if(boolFlag==true)
			{
					DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
				{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
				xxx);
				function xxx(data){
				  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
				} 
			}
		}
		//选择监督检查人
       	function  getSupervisor(){
          	var code=document.getElementsByName("project_id")[0].value;
          	showPopWin('/ais/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/proledger/problem/selectMember.action&a=a&project_id='+code+'&paraname=middleLedgerProblem.examine_creater_name&paraid=middleLedgerProblem.examine_creater_code',400,300,'人员选择')
       	}
		$(function(){
			$("#ledgerForm").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
	</script>
	</body>
</html>
