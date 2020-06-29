<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
	<head>
		<title>整改跟踪</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript">
		//限定字数
		$(document).ready(function(){
			$("#examine_result").attr("maxlength",2000);
			$("#mend_result").attr("maxlength",2000);
			$("#responsibility_Mode").attr("maxlength",2000);
			$("#no_rectification_reason").attr("maxlength",2000);
			$("#real_examine_creater").attr("maxlength",2000);
			$("#aud_track_result").attr("maxlength",2000);
			//$("#responsibility_Mode").attr("maxlength",200);
			$("#myFirstform").find("textarea").each(function(){
				autoTextarea(this);
			});
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		});
		
		
		
		
		//把引用的底稿或者疑点渲染为链接，点击引用底稿的名称
		function manu(){
			
			//默认加载tab1
			document.getElementById("tab1").style.display='';
			document.getElementById("tab2").style.display='none';
			document.getElementById("tab3").style.display='none';
			
			
          var code3=document.getElementsByName("middleLedgerProblem.linkManuName")[0].value; 
        
          var code4=document.getElementsByName("middleLedgerProblem.linkManuId")[0].value; 
      
          var codeArray3=code3.split(',');
          var codeArray4=code4.split(',');
          //alert(codeArray3[0]);
          var tt1='';
          var tt2='';
          var tt3='';
          var tt4='';
          var tt5='';
          var strName1='引用备忘';
          var strName2='引用疑点';
          var strName4='引用重大事项';
          var strName3='引用发现';
          var strName5='引用底稿';
          if(codeArray3!=null)
          {
            for(var a=0;a<codeArray4.length;a++){
             if(codeArray4[a]!=null&&codeArray4[a]!='')
             {
              if(tt3=='')
              {
               tt3='<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
              }else{
              tt3=tt3+'&nbsp;&nbsp;<a href=# onclick=go1(\"'+codeArray4[a]+'\")>'+codeArray3[a]+'</a>';
              }
             }
            }
           p2.innerHTML= tt3 ;
         }

       }
		
		 //查看底稿
	    function go1(s){
	      window.open("${contextPath}/operate/manu/view.action?crudId="+s+"&project_id=${project_id}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	    }
	    
		</script>
	</head>
	<body>
		<div style="position: fixed; top: 0; background-color: #f2f2f4; width: 100%; text-align: right; z-index: 9999;">
			<div style="margin: 10px 10px;">
				<s:if test="interaction==null || interaction==''">
					<s:if test="${isEdit == 'isEdit'}">
						<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveForm()">保存</a>
						&nbsp;&nbsp;
					</s:if>
				</s:if>
				<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">返回</a>
			</div>
		</div>
		<div style="width:100%; padding:0px; margin-top: 40px;">
		<!-- 	<div style="padding:10px;background: #FAFAFA; border: 1px solid #ccc;" align="left">问题属性信息
			</div> -->
			<div class="easyui-panel" style="width:99%;padding:0px;" title="问题属性信息">
			<s:form id="myFirstform">
			<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab1" >
					<tr style='display:none;'>
						<td class="EditHead">问题类别</td>
						<td class="editTd" >
							<%-- <s:textfield id="problem_all_name" name="middleLedgerProblem.problem_all_name" cssStyle="width:70%" disabled="true" />&nbsp;&nbsp; --%>
							<s:property  value="middleLedgerProblem.problem_all_name" />
							<s:hidden id="sort_big_code" name="middleLedgerProblem.sort_big_code" />
							<s:hidden id="sort_big_name" name="middleLedgerProblem.sort_big_name" />
							<s:hidden id="sort_small_code" name="middleLedgerProblem.sort_small_code" />
							<s:hidden id="sort_small_name" name="middleLedgerProblem.sort_small_name" />
							<s:hidden id="sort_three_code" name="middleLedgerProblem.sort_three_code" />
							<s:hidden id="sort_three_name" name="middleLedgerProblem.sort_three_name" />
						</td>
						<td class="EditHead">审计问题编号</td>
						<td class="editTd" >
							<%-- <s:textfield name="middleLedgerProblem.serial_num" cssStyle="width:75%" disabled="true" />&nbsp;&nbsp; --%>
							<s:property  value="middleLedgerProblem.serial_num" />
						</td>
					</tr>
					<tr style='display:none;'>
						<td class="EditHead" width="15%">问题点</td>
						<td class="editTd" width="35%">
							<%-- <s:textfield name="middleLedgerProblem.problem_name" id="problem_name" cssStyle="width:70%" disabled="true" />  --%>
							<s:property  value="middleLedgerProblem.problem_name" id="problem_name"/>
							<s:hidden name="middleLedgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						</td>
						<td class="EditHead" id="problemCommentText"  width="18%">备注（问题点为其他）</td>
						<td class="editTd" width="35%">
						<%-- <s:textarea name="middleLedgerProblem.problemComment" id="problemComment" disabled="true" cssStyle="width:74%;height:30px;display:none" /> --%>
						<s:property  value="middleLedgerProblem.problemComment" id="problemComment"/>
						</td>
					</tr>
			<%-- 		<tr>
						<td class="EditHead">是否可量化</td>
						<td class="editTd" colspan="3">
							<s:select  name="middleLedgerProblem.quantify" id="quantify" disabled="true" list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" listValue="value" listKey="key" />
							<s:property  value="middleLedgerProblem.quantify" id="quantify"/>
						</td>
					</tr> --%>
					<tr style='display:none;'>
						<td class="EditHead">发生金额</td>
						<td class="editTd">
							<%-- <s:textfield name="middleLedgerProblem.problem_money" id="problem_money" disabled="true" cssStyle="width:70%" doubles="true" maxlength="15" /> --%>
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.problem_money}</fmt:formatNumber>
							&nbsp;万元</td>
						<td class="EditHead">发生数量</td>
						<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.problemCount" id="problemCount" disabled="true" cssStyle="width:74%" doubles="true" maxlength="5" /> --%>
						<s:property  value="middleLedgerProblem.problemCount" id="problemCount"/>
						&nbsp;个</td>
						
					</tr>
					
					<tr style='display:none;'>
						<td class="EditHead">问题所属开始日期</td>
						<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.creater_startdate" id="creater_startdate" disabled="true"  cssStyle="width:70%" maxlength="20" /> --%>
						<s:property  value="middleLedgerProblem.creater_startdate" id="creater_startdate"/>
						</td>
						<td class="EditHead">问题所属结束日期</td>
						<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.creater_enddate" id="creater_enddate" disabled="true"  cssStyle="width:74%" maxlength="20" /> --%>
						<s:property  value="middleLedgerProblem.creater_enddate" id="creater_enddate"/>
						</td>
					</tr>
					<tr style='display:none;'>
						<td class="EditHead">审计发现类型</td>
						<td class="editTd">
						<%-- <s:select list="basicUtil.problemMethodList" listKey="code" listValue="name" emptyOption="true" disabled="true" name="middleLedgerProblem.problem_grade_code"></s:select> --%>
						<s:property  value="middleLedgerProblem.problem_grade_name" id="problem_grade_name"/>
						</td>
	                 <%--    <td class="EditHead">会计制度类型</td>
						<td class="editTd">
						<s:select cssStyle="width:74%" id="accountantSystemTypeName" name="middleLedgerProblem.accountantSystemTypeName" disabled="true" list="basicUtil.accountingTypeList" listKey="code" listValue="name" headerKey="" headerValue="" theme="ufaud_simple" templateDir="/strutsTemplate" />
						<s:property  value="middleLedgerProblem.accountantSystemTypeName" id="accountantSystemTypeName"/>
						</td> --%>
					</tr>
					<tr style='display:none;'>
						<s:if test="middleLedgerProblem.pro_type == '020312'">
							<td class="EditHead">责任<div>(经济责任审计)</div></td>
							<td class="editTd" colspan="3">
							<%-- <s:select  name="middleLedgerProblem.zeren" disabled="true" list="#@java.util.LinkedHashMap@{'领导责任':'领导责任','主管责任':'主管责任','直接责任':'直接责任'}" listValue="value" listKey="key"  emptyOption="true"></s:select> --%>
							<s:property  value="middleLedgerProblem.zeren" id="zeren"/>
							</td>
						</s:if>
						<s:else>
							<td class="EditHead">责任<div>(非经济责任审计)</div></td>
							<td class="editTd" colspan="3">
							<%-- <s:select  name="middleLedgerProblem.zeren" disabled="true" list="#@java.util.LinkedHashMap@{'领导违规':'领导违规','损失浪费':'损失浪费','管理不规范':'管理不规范'}" listValue="value" listKey="key"  emptyOption="true"></s:select> --%>
							<s:property  value="middleLedgerProblem.zeren" id="zeren"/>
							</td>
						</s:else>
					</tr>
					<tr style='display:none;'>
						<td class="EditHead">
							关联底稿
						</td>
						<td>
							<span id="p2"></span>
							<%--<s:textfield name="middleLedgerProblem.linkManuName"  cssStyle='width:260px' disabled="true" />--%>
							<!--一般文本框-->
							<s:hidden name="middleLedgerProblem.linkManuName"></s:hidden>
							<s:hidden name="middleLedgerProblem.linkManuId" />
						</td>
						<td class="EditHead">
							被审计单位
						</td>
						<td>
							<%-- <s:textfield name="middleLedgerProblem.audit_object_name" cssStyle='width:260px' disabled="true" /> --%>
							<s:property  value="middleLedgerProblem.audit_object_name" id="audit_object_name"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">问题标题</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.audit_con" id="audit_con"/>
						</td>
						<td class="EditHead">审计发现类型</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.problem_grade_name" id="audit_con"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">问题摘要</td>
						<td class="editTd" colspan="5">
							<%-- <s:textarea name="middleLedgerProblem.describe" title="问题摘要" cssClass='autoResizeTexareaHeight' disabled="true" cssStyle="width:100%;color:gray;height:60" /> --%>
							<textarea class='noborder'  name="middleLedgerProblem.describe" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.describe}</textarea>						
						</td>
					</tr>					
					<tr>
						<td class="EditHead">定性依据</td>
						<td class="editTd" colspan="5">
						<textarea class='noborder'  name="middleLedgerProblem.audit_law" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_law}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计建议</td>
						<td class="editTd" colspan="5">
						<textarea class='noborder'  name="middleLedgerProblem.audit_advice" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
						</td>
					</tr>
				</table>
				</s:form>
			</div>
			<br/>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="问题整改要求">
			<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab2" >
				<tr>
					<%--<td class="EditHead">是否整改</td>
					<td class="editTd">
						<s:select list="#@java.util.LinkedHashMap@{'否':'否'}"  
							name="middleLedgerProblem.isNotMend" id="isNotMend"  headerKey="是" headerValue="是"></s:select>
					</td> --%>
					<s:hidden name="middleLedgerProblem.isNotMend" id="isNotMend" value="是"/>
					<td class="EditHead" style="width:15%;">整改期限</td>
					<td class="editTd" style="width:33%; ">
						<s:property value="middleLedgerProblem.mend_term" />
					     	至
					    <s:property value="middleLedgerProblem.mend_term_enddate" />
					</td>
					<td class="EditHead" style="width:15%;">监督检查人</td>
					<td class="editTd" style="width:33%;">
					 <s:property value="middleLedgerProblem.examine_creater_name" />
					</td>
				</tr>
				<!-- 
				<tr>
					<td class="EditHead">整改方式</td>
					<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.mend_method" cssStyle='width:260px' disabled="true" /> --%>
						<s:property value="middleLedgerProblem.mend_method" />
					</td>
					<td class="EditHead">检查方式</td>
					<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.examine_method" cssStyle='width:260px' disabled="true" /> --%>
						<s:property value="middleLedgerProblem.examine_method" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						整改责任单位
					</td>
					<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.zeren_company" cssStyle='width:260px' disabled="true" /> --%>
						<s:property value="middleLedgerProblem.zeren_company" />
					</td>
					<td class="EditHead">
						责任部门
					</td>
					<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.zeren_dept" cssStyle='width:260px' disabled="true" /> --%>
						<s:property value="middleLedgerProblem.zeren_dept" />
					</td>
				</tr>
				<tr>
				    <td class="EditHead">责任人</td>
					<td class="editTd">
						<%-- <s:textfield name="middleLedgerProblem.zeren_person" cssStyle='width:260px' disabled="true" /> --%>
						<s:property value="middleLedgerProblem.zeren_person" />
					</td>
					<td class="EditHead">联系电话</td>
					<td class="editTd">
						<%-- <s:textfield name="projectStartObject.telephone" cssStyle='width:260px' disabled="true" /> --%>
						<s:property value="middleLedgerProblem.telephone" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						附件
					
					</td>
					<td class="editTd" colspan="3">
					
					<s:if test="${param.view ne 'view' }">
						<div data-options="fileGuid:'${middleLedgerProblem.file_id}'"  class="easyui-fileUpload"></div>
					</s:if>
					<s:else>
					<div data-options="fileGuid:'${middleLedgerProblem.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</s:else>
						
					</td>
				</tr>
				 -->
			</table>
			</div>
			<br/>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="问题整改结果">
			<%-- <s:form id="myform" action="updateTrackingProblem" namespace="/proledger/problem"> --%>
				<table  class="ListTable" id="tab3">
					<tr>
						<td class="EditHead" style="width:25%">
							被审单位反馈整改结果
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
							<div>	<a class="easyui-linkbutton" iconCls="icon-view" href="javascript:void(0)" onclick="viewHistory()">查看历次反馈</a></div>
						</td>
						<td class="editTd" colspan="3">
						<%--<s:textarea name="middleLedgerProblem.mend_result" id="mend_result" cssClass='noborder' title="被审计单位反馈整改结果"
								  rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" readonly="true" />--%>
							<s:textarea readonly="true" name="middleLedgerProblem.mend_result" id="mend_result" cssClass='noborder' title="被审计单位反馈整改结果"
										rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							<input type="hidden" id="middleLedgerProblem.mend_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							计划整改开始日期
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.planStartDate"/>
						</td>
						<td class="EditHead">
							计划整改结束日期
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.planEndDate"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							实际整改开始日期
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.examine_startdate"/>
						</td>
						<td class="EditHead">
							实际整改结束日期
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.examine_enddate"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<label style="color: red;">*</label>整改状态
						</td>
						<td class="editTd">
							<%--<select readonly="true" id="mend_state_code" class="easyui-combobox" name="middleLedgerProblem.mend_state_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<s:iterator value="basicUtil.fllowOpinionList" id="entry">
									<s:if test="${middleLedgerProblem.mend_state_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>--%>
							<s:property value="middleLedgerProblem.mend_state"/>
						</td>
						<td class="EditHead">
							整改责任部门
						</td>
						<td class="editTd">
							<input readonly="true" type="text" class="noborder" name="middleLedgerProblem.mendDept" value="${middleLedgerProblem.mendDept}" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<label style="color: red;"></label>审计完善制度数量（修订数）
						</td>
						<td class="editTd">
							<input readonly="true" type="text" class="noborder easyui-validatebox" data-options="validType:'number'" name="middleLedgerProblem.improveRegulation" value="${middleLedgerProblem.improveRegulation}" maxlength="10"/>
						</td>
						<td class="EditHead">
							修订制度说明
						</td>
						<td class="editTd">
							<input readonly="true" type="text" class="noborder" name="middleLedgerProblem.impRegulationRemark" value="${middleLedgerProblem.impRegulationRemark}" maxlength="400"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<label style="color: red;"></label>审计完善制度数量（新制定数）
						</td>
						<td class="editTd">
							<input readonly="true" type="text" class="noborder easyui-validatebox" data-options="validType:'number'" name="middleLedgerProblem.newRegulation" value="${middleLedgerProblem.newRegulation}" maxlength="10"/>
						</td>
						<td class="EditHead">
							新增制度说明
						</td>
						<td class="editTd">
							<input readonly="true" type="text" class="noborder" name="middleLedgerProblem.newRegulationRemark" value="${middleLedgerProblem.newRegulationRemark}" maxlength="400"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<label style="color: red;"></label>审计问责处理人次（经济处罚）
						</td>
						<td class="editTd">
							<input readonly="true" type="text" class="noborder easyui-validatebox" data-options="validType:'number'" name="middleLedgerProblem.punishPersonEconomic" value="${middleLedgerProblem.punishPersonEconomic}" maxlength="10"/>
						</td>
						<td class="EditHead" nowrap>
							<label style="color: red;"></label>审计问责处理人次（党纪政纪处理）

						</td>
						<td class="editTd">
							<input readonly="true" type="text" class="noborder easyui-validatebox" data-options="validType:'number'" name="middleLedgerProblem.punishPersonLaw" value="${middleLedgerProblem.punishPersonLaw}" maxlength="10"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							<label style="color: red;"></label>审计问责处理人次（移送司法机关）
						</td>
						<td class="editTd">
							<input  readonly="true" type="text" class="noborder easyui-validatebox" data-options="validType:'number'" name="middleLedgerProblem.punishPersonGov" value="${middleLedgerProblem.punishPersonGov}" maxlength="10"/>
						</td>
						<td class="EditHead" nowrap>已纠正违纪违规金额（万元）</td>
						<td class="editTd">
							<%--<input readonly="true" type="text" class="noborder money editElement" name="middleLedgerProblem.yjzwjwgje" value="${middleLedgerProblem.yjzwjwgje}" maxlength="20"/>--%>
							<s:textfield readonly="true" cssClass="noborder money editElement" name="middleLedgerProblem.yjzwjwgje" value="%{formatMoneyWithSeparator(middleLedgerProblem.yjzwjwgje)}"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>清退个人不当得利（万元）</td>
						<td class="editTd">
							<%--<input readonly="true" type="text" class="noborder money editElement" name="middleLedgerProblem.qtgrbddl" value="${middleLedgerProblem.qtgrbddl}" maxlength="20"/>--%>
							<s:textfield readonly="true" cssClass="noborder money editElement" name="middleLedgerProblem.qtgrbddl" value="%{formatMoneyWithSeparator(middleLedgerProblem.qtgrbddl)}"></s:textfield>
						</td>
						<td class="EditHead" nowrap>补缴各类税款（万元）</td>
						<td class="editTd">
							<%--<input readonly="true" type="text" class="noborder money editElement" name="middleLedgerProblem.bjglsk" value="${middleLedgerProblem.bjglsk}" maxlength="20"/>--%>
							<s:textfield readonly="true" cssClass="noborder money editElement" name="middleLedgerProblem.bjglsk" value="%{formatMoneyWithSeparator(middleLedgerProblem.bjglsk)}"></s:textfield>
						</td>
					</tr>
					<%-- <tr>
						<td class="EditHead">审计单位跟踪检查结果
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea id="examine_result" name="middleLedgerProblem.examine_result" readonly="true" cssClass="noborder"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="审计单位跟踪检查结果"/>
							<input type="hidden" id="middleLedgerProblem.examine_result.maxlength" value="200"/>
						</td>
						
					</tr> --%>
					<%-- <tr>
						<td class="EditHead">整改跟踪结论
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea id="aud_track_result" name="middleLedgerProblem.aud_track_result" readonly="true" cssClass="noborder"
							cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="整改跟踪结论"/>
							<input type="hidden" id="middleLedgerProblem.aud_track_result.maxlength" value="200"/>
						</td>
					</tr> --%>
					<s:if test="interaction==null || interaction==''">
					<tr id="fujian">
						<td class="EditHead">
						附件
						<s:hidden id="f_mend_accessory" name="middleLedgerProblem.f_mend_accessory" />
						<s:hidden id="file_id" name="middleLedgerProblem.file_id" />
					</td>
					<td class="editTd" colspan="3">
						<%--<s:if test="${param.view ne 'view' }">
							<div data-options="fileGuid:'${problemTracking.file_id}'"  class="easyui-fileUpload"></div>
						</s:if>
						<s:else>
							<div data-options="fileGuid:'${problemTracking.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</s:else>--%>
							<div data-options="fileGuid:'${problemTracking.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</td>
					</tr>
					</s:if>    
			    </table>
			    <%-- <s:hidden name="isEdit" />
				<s:hidden name="project_code" />
				<s:hidden name="project_id" />
				<s:hidden name="permission" />
				<s:hidden name="middleLedgerProblem.project_id" value="%{project_id}" />
				<s:hidden name="middleLedgerProblem.id" />
				<s:hidden name="id" />
				<s:hidden name="wpd_stagecode" id="zwq"/> --%>
				<%-- <div align="center">
					<s:if test="interaction==null || interaction==''">
						<s:if test="${isEdit == 'isEdit'}">
							<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveForm()">保存</a>
								&nbsp;&nbsp;
						</s:if>
					</s:if>
					<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">返回</a>
				</div>
			</s:form> --%>
			</div>
			<br>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="问题整改结果评价">
			<s:form id="myform" action="updateTrackingProblemEvaluate" namespace="/proledger/problem">
				<table class="ListTable" cellpadding=1 cellspacing=1 id="tab4">
					<tr>
						<td class="EditHead" style="width:25%">审计单位跟踪检查结果
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="problemTracking.examine_result" id="examine_result" cssClass='noborder' title="审计单位跟踪检查结果"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
							<input type="hidden" id="problemTracking.examine_result.maxlength" value="2000"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							<label style="color: red;">*</label>整改状态评价
						</td>
						<td class="editTd">
							<select id="f_mend_opinion_code" class="easyui-combobox" name="problemTracking.f_mend_opinion_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${problemTracking.f_mend_opinion_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						    <s:hidden name="projectStartObject.supervisor_name" />
						    <s:hidden id="f_mend_opinion_name" name="problemTracking.f_mend_opinion_name"></s:hidden>
						</td>
						<td class="EditHead" style="width:15%;"></td>
						<td class="editTd"></td>
					</tr>
					<tr>
						<td class="EditHead" style="width:15%;">跟踪检查人</td>
						<td class="editTd" style="width:33%;">
							<s:property id="tracker_name" value="problemTracking.tracker_name"/>
							<s:hidden name="problemTracking.tracker_name"/>
							<s:hidden name="problemTracking.tracker_code"/>
						</td>
						<td class="EditHead" style="width:15%;">跟踪检查时间</td>
						<td class="editTd" style="width:33%;">
							<s:property value="problemTracking.feedback_date"/>
							<s:hidden name="problemTracking.feedback_date"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">增收节支类型</td>
						<td class="editTd">
							<select id="increase_type_code" class="easyui-combobox" name="problemTracking.increase_type_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.increaseTypeList" id="entry">
									<s:if test="${problemTracking.increase_type_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<s:hidden id="increase_type" name="problemTracking.increase_type"></s:hidden>
						</td>
						<td class="EditHead">增收节支金额（万元）</td>
						<td class="editTd">
							<%--<input type="text" class="noborder money editElement" name="problemTracking.increase_money" value="${problemTracking.increase_money}" maxlength="20"/>--%>
							<s:textfield cssClass="noborder money editElement" name="problemTracking.increase_money" value="%{formatMoney(problemTracking.increase_money)}"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">损失浪费类型</td>
						<td class="editTd">
							<select id="loss_type_code" class="easyui-combobox" name="problemTracking.loss_type_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.lossTypeList" id="entry">
									<s:if test="${problemTracking.loss_type_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<s:hidden id="loss_type" name="problemTracking.loss_type"></s:hidden>
						</td>
						<td class="EditHead">损失浪费金额（万元）</td>
						<td class="editTd">
							<%--<input type="text" class="noborder money editElement" name="problemTracking.loss_money" value="${problemTracking.loss_money}" maxlength="20"/>--%>
							<s:textfield cssClass="noborder money editElement" name="problemTracking.loss_money" value="%{formatMoney(problemTracking.loss_money)}"></s:textfield>
						</td>
					</tr>
					<s:if test="interaction==null || interaction==''">
					<tr id="fujian">
						<td class="EditHead">
						附件
						<s:hidden id="f_mend_accessory" name="problemTracking.f_mend_accessory" />
						<s:hidden id="file_id" name="problemTracking.file_id" />
					</td>
					<td class="editTd" colspan="3">
						<s:if test="${param.view ne 'view' }">
							<div data-options="fileGuid:'${problemTracking.f_mend_accessory}'"  class="easyui-fileUpload"></div>
						</s:if>
					<s:else>
							<div data-options="fileGuid:'${problemTracking.f_mend_accessory}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</s:else>
					</td>
					</tr>
					</s:if>    
			    </table>
			    <s:hidden name="isEdit" />
				<s:hidden name="project_code" />
				<s:hidden name="project_id" />
				<s:hidden name="permission" />
				<s:hidden name="middleLedgerProblem.project_id" value="%{project_id}" />
				<s:hidden name="middleLedgerProblem.id" />
				<%-- <s:hidden name="id" value="middleLedgerProblem.id"/> --%>
				<s:hidden name="wpd_stagecode" id="zwq"/>
				<input type="hidden" name="middleLedgerProblem_id" value="${middleLedgerProblem_id }">
				<input type="hidden" name="id" value="${id}">
<%--				<div align="center">--%>
<%--					<s:if test="interaction==null || interaction==''">--%>
<%--						<s:if test="${isEdit == 'isEdit'}">--%>
<%--							<a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="saveForm()">保存</a>--%>
<%--								&nbsp;&nbsp;--%>
<%--						</s:if>--%>
<%--					</s:if>--%>
<%--					<a class="easyui-linkbutton" iconCls="icon-undo" href="javascript:void(0)" onclick="back()">返回</a>--%>
<%--				</div>--%>
			</s:form>
			</div>
			<div id="sidebar"  title='上传附件' style='width:100%;overflow: hidden;' >
	  			<iframe id="upload"  frameborder="0" scrolling="hidden" style="width:100%;height:100%;" src="" ></iframe>
	  		</div>
			<div id="viewHistory"  title='历史反馈' style='width:100%;overflow: hidden;' >
				<iframe id="track"  frameborder="0" scrolling="hidden" style="width:100%;height:100%;" src="" ></iframe>
			</div>
		</div>
		<script type="text/javascript">
			function viewHistory() {
				var trackUrl = "/ais/proledger/problem/feedbackListForAuditObject.action?view=view&middleLedgerProblem_id=${middleLedgerProblem_id}";
				$('#track').attr("src", trackUrl);
				$('#viewHistory').window('open');
			}

			/*
             * 上传附件
             */
			function Upload(id, filelist) {
				var guid = id;
				var num = Math.random();
				var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid=' + guid + '&&param=' + rnm + '&&deletePermission=true', filelist, 'dialogWidth:700px;dialogHeight:450px;status:yes');
				/*
				var viewURL =  '${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true';
				$('#upload').attr("src",viewURL);
				$('#sidebar').window('open');
			 	*/
			}

			$('#sidebar').window({
				width: 700,
				height: 450,
				modal: true,
				shadow: true,
				closed: true,
				collapsible: false,
				maximizable: false,
				minimizable: false
			});
			$('#viewHistory').window({
				width: $('body').width() * 0.95 < 800 ? 800 : $('body').width() * 0.95,
				height: 450,
				top: $('body').height() * 0.7 < 500 ? 500 : $('body').height() * 0.7,
				modal: true,
				shadow: true,
				closed: true,
				collapsible: false,
				maximizable: false,
				minimizable: false
			});

			/*
             * 删除附件
             */
			function deleteFile(fileId, guid, isDelete, isEdit, appType, title) {
				var boolFlag = window.confirm("确认删除吗?");
				if (boolFlag == true) {
					DWREngine.setAsync(false);
					DWRActionUtil.execute(
							{namespace: '/commons/file', action: 'delFile', executeResult: 'false'},
							{'fileId': fileId, 'deletePermission': isDelete, 'isEdit': isEdit, 'guid': guid, 'appType': appType, 'title': title},
							xxx);

					function xxx(data) {
						document.getElementById(guid).parentElement.innerHTML = data['accessoryList'];
					}
				}
			}

			function triggerTab(tab) {
				/**
				 var isDisplay = document.getElementById(tab).style.display;
				 if(isDisplay==''){
					document.getElementById(tab).style.display='none';
				}else{
					document.getElementById(tab).style.display='';
				}*/
				if (tab == "tab1") {
					document.getElementById("tab1").style.display = '';
					document.getElementById("tab2").style.display = 'none';
					document.getElementById("tab3").style.display = 'none';
				}
				if (tab == "tab2") {
					document.getElementById("tab1").style.display = 'none';
					document.getElementById("tab2").style.display = '';
					document.getElementById("tab3").style.display = '';

				}
			}

			function saveForm() {
				if (!audEvd$validateform('myform')){
					return false;
				}
				var f_mend_opinion_code = $("#f_mend_opinion_code").combobox("getValue");
				if (f_mend_opinion_code == null || f_mend_opinion_code == ''){
					showMessage2('请选择整改状态评价！');
					return false;
				}
				if (f_mend_opinion_code != null) {
					var f_mend_opinion_name = $("#f_mend_opinion_code").combobox("getText");
					$("#f_mend_opinion_name").val(f_mend_opinion_name);
				}
				var url = "${contextPath}/proledger/problem/updateTrackingProblemEvaluate.action";
				myform.action = url;
				myform.submit();
				window.parent.saveCloseWin();
				window.parent.reloadtrackList();
			}

			function back() {
				//window.parent.closeWin();
				window.history.back(-1);
				// window.location.href="${contextPath}/proledger/problem/auditTrackingList.action?project_id=${project_id}&isEdit=true";
			}

		</script>
	</body>
</html>
