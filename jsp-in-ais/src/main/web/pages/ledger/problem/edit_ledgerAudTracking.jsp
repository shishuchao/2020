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
<%--		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>--%>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>

		<style type="text/css">
			.EditHead {
				width: 20%;
			}
			
			.editTd {
				width: 30%;
			}
		</style>
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
		<s:if test="${view != 'view'}">
		<div style="position: fixed; top: 0; background-color: #FAFAFA; width: 100%; text-align: right; z-index: 999;">
			<s:if test="interaction==null || interaction==''">
				<s:if test="${isEdit == 'isEdit'}">
					<a class="easyui-linkbutton" style="margin: 5px 10px;" iconCls="icon-save" href="javascript:void(0)" onclick="saveForm()">保存</a>
				</s:if>
			</s:if>
		</div>
		<div style="margin-top: 40px;">
		</s:if>
		<s:else>
		<div>
		</s:else>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="问题属性信息" >
				<%--<div align="center">
					<jsp:include flush="true" page="/pages/ledger/problem/operate/view_middle_ledger_problem.jsp" />
				</div>--%>
				<table cellpadding=1 cellspacing=1 border=0 class="ListTable" id="tab1" >
				<tr>
						<td class="EditHead" style="width:15%">问题类别</td>
						<td class="editTd" style="width:35%">
							<%-- <s:textfield id="problem_all_name" name="middleLedgerProblem.problem_all_name" cssStyle="width:70%" disabled="true" />&nbsp;&nbsp; --%>
							<s:property  value="middleLedgerProblem.problem_all_name" />
							<s:hidden id="sort_big_code" name="middleLedgerProblem.sort_big_code" />
							<s:hidden id="sort_big_name" name="middleLedgerProblem.sort_big_name" />
							<s:hidden id="sort_small_code" name="middleLedgerProblem.sort_small_code" />
							<s:hidden id="sort_small_name" name="middleLedgerProblem.sort_small_name" />
							<s:hidden id="sort_three_code" name="middleLedgerProblem.sort_three_code" />
							<s:hidden id="sort_three_name" name="middleLedgerProblem.sort_three_name" />
						</td>
						<td class="EditHead" style="width:15%">审计问题编号</td>
						<td class="editTd" style="width:35%">
							<s:property  value="middleLedgerProblem.serial_num" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							被审计单位
						</td>
						<td>
							<s:property  value="middleLedgerProblem.audit_object_name" id="audit_object_name"/>
						</td>
						<td class="EditHead">问题标题</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.audit_con" id="audit_con"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">问题点</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.problem_name" id="problem_name"/>
							<s:hidden name="middleLedgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						</td>
						<td class="EditHead" id="problemCommentText">备注（问题点为其他）</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.problemComment" id="problemComment"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" width="15%">涉及金额（万元）</td>
						<td class="editTd" width="35%">
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.problem_money}</fmt:formatNumber>
						</td>
						<td class="EditHead" width="15%">发生数量</td>
						<td class="editTd" width="35%">
						<s:property  value="middleLedgerProblem.problemCount" id="problemCount"/>
						&nbsp;个</td>
					</tr>
					<tr>
						<td class="EditHead">审计发现类型</td>
						<td class="editTd">
							<s:property  value="middleLedgerProblem.problem_grade_name" id="problem_grade_name"/>
						</td>
						<td class="EditHead">重要程度</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.ofsDetail"/>
						</td>
					</tr>
					<tr>
						<s:if test="middleLedgerProblem.pro_type == '020312'">
							<td class="EditHead">责任<div>(经济责任审计)</div></td>
							<td class="editTd">
								<s:property  value="middleLedgerProblem.zeren" id="zeren"/>
							</td>
						</s:if>
						<s:else>
							<td class="EditHead">责任<div>(非经济责任审计)</div></td>
							<td class="editTd">
								<s:property  value="middleLedgerProblem.zeren" id="zeren"/>
							</td>
						</s:else>
						<td class="EditHead">问题发现日期</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.problem_date"/>
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
						<s:hidden name="middleLedgerProblem.linkManuName"></s:hidden>
						<s:hidden name="middleLedgerProblem.linkManuId" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">违规违纪类型</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.wgwjlxName" />
					</td>
					<td class="EditHead">违规违纪金额（万元）</td>
					<td class="editTd">
						<%--<fmt:formatNumber value="${middleLedgerProblem.wgwjje}" pattern="###.############"/>--%>
						<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.wgwjje}</fmt:formatNumber>
					</td>
				</tr>

					<tr>
						<td class="EditHead">问题摘要</td>
						<td class="editTd" colspan="3">
							<textarea class='noborder'  name="middleLedgerProblem.describe" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.describe}</textarea>						
						</td>
					</tr>					
					<tr>
						<td class="EditHead">定性依据</td>
						<td class="editTd" colspan="3">
						<textarea class='noborder'  name="middleLedgerProblem.audit_law" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_law}</textarea>
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计建议</td>
						<td class="editTd" colspan="3">
						<textarea class='noborder'  name="middleLedgerProblem.audit_advice" readonly="readonly"
									  rows="5" style="width:98%;overflow-y:hidden;line-height:150%;" UNSELECTABLE='on'>${middleLedgerProblem.audit_advice}</textarea>
						</td>
					</tr>
				<tr>
					<td colspan="4" style="font-size: 15px;font-weight: bold;color: #777;height: 16px;line-height: 16px">
						问题整改要求
					</td>
				</tr>
				<tr>
					<s:hidden name="middleLedgerProblem.isNotMend" id="isNotMend" value="是"/>
					<td class="EditHead">整改期限</td>
					<td class="editTd">
						<s:property value="middleLedgerProblem.mend_term" />
					     	至
					    <s:property value="middleLedgerProblem.mend_term_enddate" />
					</td>
					<td class="EditHead">监督检查人</td>
					<td class="editTd">
					 <s:property value="middleLedgerProblem.examine_creater_name" />
					</td>
				</tr>
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
						<div data-options="fileGuid:'${middleLedgerProblem.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</td>
				</tr>
					<tr>
						<td colspan="4" style="font-size: 15px;font-weight: bold;color: #777;height: 16px;line-height: 16px">
							问题整改结果
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							被审单位反馈整改结果
							<div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
							<div>	<a class="easyui-linkbutton" iconCls="icon-view" href="javascript:void(0)" onclick="viewHistory()">查看历次反馈</a></div>
						</td>
						<td class="editTd" colspan="3">
						<!-- readonly="true"  去掉不可编辑控制  审计单位也可以进行反馈整改结果 -->
						<s:textarea readonly="true" name="middleLedgerProblem.mend_result" id="mend_result" cssClass='noborder' title="被审计单位反馈整改结果"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;" />
							<input type="hidden" id="middleLedgerProblem.mend_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead" width="15%">
							计划整改开始日期
						</td>
						<td class="editTd"  width="35%">
							<s:property value="middleLedgerProblem.planStartDate"></s:property>
						</td>
						<td class="EditHead" width="15%">
							计划整改结束日期
						</td>
						<td class="editTd"  width="35%">
							<s:property value="middleLedgerProblem.planEndDate"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							实际整改开始日期
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.examine_startdate"></s:property>
						</td>
						<td class="EditHead">
							实际整改结束日期
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.examine_enddate"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							整改状态
						</td>
						<td class="editTd">
							<select readonly="true" id="mend_state_code" class="easyui-combobox" name="middleLedgerProblem.mend_state_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${middleLedgerProblem.mend_state_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						</td>
						<td class="EditHead">
							整改责任部门
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.mendDept"></s:property>
						</td>
					</tr>
						<tr>
						<td class="EditHead" nowrap>
							审计完善制度数量（修订数）
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.improveRegulation"></s:property>
						</td>
						<td class="EditHead">
							修订制度说明
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.impRegulationRemark"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
								审计完善制度数量（新制定数）
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.newRegulation"></s:property>
						</td>
						<td class="EditHead">
							新增制度说明
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.newRegulationRemark"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							审计问责处理人次（经济处罚）
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.punishPersonEconomic"></s:property>
						</td>
						<td class="EditHead" nowrap>
									审计问责处理人次（党纪政纪处理）

						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.punishPersonLaw"></s:property>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							审计问责处理人次（移送司法机关）
						</td>
						<td class="editTd">
							<s:property value="middleLedgerProblem.punishPersonGov"></s:property>
						</td>
						<td class="EditHead" nowrap>已纠正违纪违规金额（万元）</td>
						<td class="editTd">
							<%--<s:property value="middleLedgerProblem.yjzwjwgje"></s:property>--%>
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.yjzwjwgje}</fmt:formatNumber>
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>清退个人不当得利（万元）</td>
						<td class="editTd">
							<%--<s:property value="middleLedgerProblem.qtgrbddl"></s:property>--%>
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.qtgrbddl}</fmt:formatNumber>
						</td>
						<td class="EditHead" nowrap>补缴各类税款（万元）</td>
						<td class="editTd">
							<%--<s:property value="middleLedgerProblem.bjglsk"></s:property>--%>
							<fmt:formatNumber pattern="##################.##"  minFractionDigits="2" >${middleLedgerProblem.bjglsk}</fmt:formatNumber>
						</td>
					</tr>
					<s:if test="${dueTime}">
						<tr>
							<td class="EditHead">
										到期未整改原因
										<div style="text-align:right;"><label style="color: DarkGray;">(限2000字)</label></div>
							</td>
							<td class="editTd" colspan="3">
								<s:textarea  id="no_rectification_reason" name="middleLedgerProblem.no_rectification_reason" cssClass="noborder"
								cssStyle="width:100%;height:100px;overflow-y:visible;line-height:150%;" title="到期未整改原因"/>
								<input type="hidden" id="middleLedgerProblem.no_rectification_reason.maxlength" value="200"/>
							</td>
						</tr>
					</s:if>
					<!--
					<tr id="fujian">
						<s:hidden id="file_id" name="problemTracking.file_id" />

						<td class="EditHead">
								附件
						</td>
						<td class="editTd" colspan="3">

								<div data-options="fileGuid:'${middleLedgerProblem.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>

						</td>
					</tr>
					-->
					<tr id="fujian">
						<td class="EditHead">
						整改证据
						<s:hidden id="auditobj_file_id" name="middleLedgerProblem.auditobj_file_id" />
						<s:hidden id="file_id" name="middleLedgerProblem.file_id" />
						</td>
						<td class="editTd" colspan="3">
							<div data-options="fileGuid:'${middleLedgerProblem.auditobj_file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
						</td>
					</tr>
			    </table>
			</div>
			<br>
			<div class="easyui-panel" style="width:99%;padding:0px;" title="问题整改结果评价">
			<s:form id="myform" action="updateTrackingProblem" namespace="/proledger/problem">
				<table class="ListTable" cellpadding=1 cellspacing=1 id="tab4">
					<tr>
						<td class="EditHead">审计单位跟踪检查结果
						</td>
						<td class="editTd" colspan="3">
						<s:textarea name="middleLedgerProblem.examine_result" id="examine_result" cssClass='noborder' title="审计单位跟踪检查结果"
								rows="5" cssStyle="width:100%;overflow-y:visible;line-height:150%;"/>
							<input type="hidden" id="middleLedgerProblem.examine_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead"><font color="red">*</font>整改状态评价</td>
						<td class="editTd" colspan="3">
							<select id="f_mend_opinion_code" class="easyui-combobox" name="middleLedgerProblem.f_mend_opinion_code" editable="false" style="width:160px;" data-options="panelHeight:100">
						       <option value="">&nbsp;</option>
						       <s:iterator value="basicUtil.fllowOpinionList" id="entry">
							         <s:if test="${middleLedgerProblem.f_mend_opinion_code==code}">
						       			<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						    <s:hidden name="projectStartObject.supervisor_name" />
						    <s:hidden id="f_mend_opinion_name" name="middleLedgerProblem.f_mend_opinion_name"></s:hidden>
						</td>

					</tr>
					<tr>
						<td class="EditHead">跟踪检查人</td>
						<td class="editTd">
							<s:textfield id="tracker_name" name="middleLedgerProblem.tracker_name" readonly="true" cssClass="noborder"/>
							<%--避免保存整改评价信息后整改跟踪人消失的问题--%>
							<%--<input type="hidden" name="middleLedgerProblem.tracker_code">--%>
							<s:hidden name="middleLedgerProblem.tracker_code" />
						</td>
						<td class="EditHead">跟踪检查时间</td>
						<td class="editTd">
							<s:textfield id="tracker_examine_date" name="middleLedgerProblem.tracker_examine_date" readonly="true" cssClass="noborder"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">增收节支类型</td>
						<td class="editTd">
							<select id="increase_type_code" class="easyui-combobox" name="middleLedgerProblem.increase_type_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.increaseTypeList" id="entry">
									<s:if test="${middleLedgerProblem.increase_type_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<s:hidden id="increase_type" name="middleLedgerProblem.increase_type"></s:hidden>
						</td>
						<td class="EditHead">增收节支金额（万元）</td>
						<td class="editTd">
							<%--<input type="text" class="noborder money editElement" name="middleLedgerProblem.increase_money" value="${middleLedgerProblem.increase_money}" maxlength="20"/>--%>
							<s:textfield cssClass="noborder money editElement" name="middleLedgerProblem.increase_money" value="%{formatMoney(middleLedgerProblem.increase_money)}"></s:textfield>
						</td>
					</tr>
					<tr>
						<td class="EditHead">损失浪费类型</td>
						<td class="editTd">
							<select id="loss_type_code" class="easyui-combobox" name="middleLedgerProblem.loss_type_code" editable="false" style="width:160px;" data-options="panelHeight:100">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.lossTypeList" id="entry">
									<s:if test="${middleLedgerProblem.loss_type_code==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
							<s:hidden id="loss_type" name="middleLedgerProblem.loss_type"></s:hidden>
						</td>
						<td class="EditHead">损失浪费金额（万元）</td>
						<td class="editTd">
							<%--<input type="text" class="noborder money editElement" name="middleLedgerProblem.loss_money" value="${middleLedgerProblem.loss_money}" maxlength="20"/>--%>
							<s:textfield cssClass="noborder money editElement" name="middleLedgerProblem.loss_money" value="%{formatMoney(middleLedgerProblem.loss_money)}"></s:textfield>
						</td>
					</tr>
					<s:if test="interaction==null || interaction==''">
					<tr id="fujian">
						<td class="EditHead">
						附件
						<s:hidden id="f_mend_accessory" name="middleLedgerProblem.f_mend_accessory" />
						<s:hidden id="file_id" name="middleLedgerProblem.file_id" />
					</td>
					<td class="editTd" colspan="3">
						<s:if test="${param.view ne 'view' }">
							<div data-options="fileGuid:'${middleLedgerProblem.f_mend_accessory}'"  class="easyui-fileUpload"></div>
						</s:if>
					<s:else>
							<div data-options="fileGuid:'${middleLedgerProblem.f_mend_accessory}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
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
				<s:hidden id="middleLedgerProblem_id" name="middleLedgerProblem.id" />
				<s:hidden name="id" />
				<s:hidden name="wpd_stagecode" id="zwq"/>

			</s:form>
			</div>
			<div id="viewHistory"  title='历史反馈' style='width:100%;overflow: hidden;' >
	  			<iframe id="upload"  frameborder="0" scrolling="hidden" style="width:100%;height:100%;" src="" ></iframe>
	  		</div>
		</div>

		<script type="text/javascript">
		
		function viewHistory(){

			var middleLedgerProblem_id = $('#middleLedgerProblem_id').val();
			var trackUrl = "";
			trackUrl ="/ais/proledger/problem/feedbackListForAuditObject.action?view=view&middleLedgerProblem_id="+middleLedgerProblem_id;
			$('#upload').attr("src",trackUrl);
            $('#viewHistory').window('open');
		}
		/*
		 *上传附件
		*/
		function Upload(id,filelist){
			var guid = id;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			/* var viewURL =  '${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true';
			$('#upload').attr("src",viewURL);
			$('#sidebar').window('open'); */
		}
		$('#viewHistory').window({
			width: $('body').width()*0.95< 800 ? 800 : $('body').width()*0.95,
			height:450,
			top:$('body').height()*0.7< 500 ? 500 : $('body').height()*0.7,
			modal: true,
			shadow: true,
			closed: true,
			collapsible:false,
			maximizable:false,
			minimizable:false
		});
		/*
		* 删除附件
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
			function triggerTab(tab){
				/**
				var isDisplay = document.getElementById(tab).style.display;
				if(isDisplay==''){
					document.getElementById(tab).style.display='none';
				}else{
					document.getElementById(tab).style.display='';
				}*/
				if(tab == "tab1"){
					document.getElementById("tab1").style.display='';
					document.getElementById("tab2").style.display='none';
					document.getElementById("tab3").style.display='none';
				}
				if(tab == "tab2"){
					document.getElementById("tab1").style.display='none';
					document.getElementById("tab2").style.display='';
					document.getElementById("tab3").style.display='';
					
				}
			}
			function saveForm(){
				if (!audEvd$validateform('myform')){
					return false;
				}
				/* var sdate = $('#examine_startdate').datebox('getValue');
				var edate = $('#examine_enddate').datebox('getValue');
				if(sdate!=""&&edate!=""){
					sdate = sdate.replace("-","").replace("-","");
					edate = edate.replace("-","").replace("-","");
					var sn = new Number(sdate);
					var en = new Number(edate);
					if(sn>en){
						alert("实际整改期限结束日期不能小于开始日期!");
						return false;
					}
				} */
				var f_mend_opinion_code =$("#f_mend_opinion_code").combobox("getValue");
				if(f_mend_opinion_code && f_mend_opinion_code != null){
					var f_mend_opinion_name	= $("#f_mend_opinion_code").combobox("getText");
					$("#f_mend_opinion_name").val(f_mend_opinion_name);
				}else{
					alert('整改评价状态不能为空！');
					return false;
				}
				var url = "${contextPath}/proledger/problem/updateTrackingProblem.action";
/*				myform.action = url;
				myform.submit();
				window.parent.saveCloseWin();
				window.parent.reloadtrackList();*/
				$.ajax({
					url:url,
					async:false,
					type:'post',
					data:$('#myform').serialize(),
					success:function(data){
						if(data == '1') {
							showMessage1("保存成功");
							var activeTabId = '${activeTabId}';
							var iframe = aud$getTabIframByTabId(activeTabId);
							if(typeof(iframe) != 'undefined') {
								iframe.$('#reworkWorkProgram').get(0).contentWindow.refresh();
							}
						}
					}
				});
			}
			function back(){
				window.parent.closeWin();
				//window.history.back(-1);
			 // window.location.href="${contextPath}/proledger/problem/auditTrackingList.action?project_id=${project_id}&isEdit=true";
			}
			
		</script>
	</body>
</html>
