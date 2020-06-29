<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<head>
		<title>整改跟踪</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/main/manu.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript">
		//把引用的底稿或者疑点渲染为链接，点击引用底稿的名称
		function manu(){
      
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
		<style>
			.a{
				BACKGROUND-COLOR: #ffffff;
				padding-left: 5px;
			}
		</style>
	</head>
	<body onload="manu();">
		<center>
			<table class='ListTable'>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">审计问题整改跟踪信息</td>
				</tr>
			</table>
			<div  style='float:left;'>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="triggerTab('tab1');">问题属性信息</a>
			</div>
			<div  style='float:left;'>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="triggerTab('tab2');">问题整改要求</a>
			</div>
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" id="tab1" style="display: none;" >
					<tr>
						<td class="ListTableTr11">问题类别:</td>
						<td class="ListTableTr22" >
							<s:textfield id="problem_all_name" name="middleLedgerProblem.problem_all_name" cssStyle="width:70%" disabled="true" />&nbsp;&nbsp;
							<s:hidden id="sort_big_code" name="middleLedgerProblem.sort_big_code" />
							<s:hidden id="sort_big_name" name="middleLedgerProblem.sort_big_name" />
							<s:hidden id="sort_small_code" name="middleLedgerProblem.sort_small_code" />
							<s:hidden id="sort_small_name" name="middleLedgerProblem.sort_small_name" />
							<s:hidden id="sort_three_code" name="middleLedgerProblem.sort_three_code" />
							<s:hidden id="sort_three_name" name="middleLedgerProblem.sort_three_name" />
						</td>
						<td class="ListTableTr11">审计问题编号:</td>
						<td class="ListTableTr22" >
							<s:textfield name="middleLedgerProblem.serial_num" cssStyle="width:75%" disabled="true" />&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" width="15%">问题点:</td>
						<td class="ListTableTr22" width="35%">
							<s:textfield name="middleLedgerProblem.problem_name" id="problem_name" cssStyle="width:70%" disabled="true" /> 
							<s:hidden name="middleLedgerProblem.problem_code" id="problem_code"></s:hidden> &nbsp;
						</td>
						<td class="ListTableTr11" id="problemCommentText"  width="15%">备注（问题点为其他）: </td>
						<td class="ListTableTr22" width="35%">
						<s:textarea name="middleLedgerProblem.problemComment" id="problemComment" disabled="true" cssStyle="width:74%;height:30px;display:none" />
						</td>
					</tr>
				<%-- 	<tr>
						<td class="ListTableTr11">是否可量化</td>
						<td class="ListTableTr22" colspan="3">
							<s:select  name="middleLedgerProblem.quantify" id="quantify" disabled="true" list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" listValue="value" listKey="key" />
						</td>
					</tr> --%>
					<tr>
						<td class="ListTableTr11">发生金额:</td>
						<td class="ListTableTr22"><s:textfield name="middleLedgerProblem.problem_money" id="problem_money" disabled="true" cssStyle="width:70%" doubles="true" maxlength="15" />&nbsp;万元</td>
						<td class="ListTableTr11">发生数量:</td>
						<td class="ListTableTr22"><s:textfield name="middleLedgerProblem.problemCount" id="problemCount" disabled="true" cssStyle="width:74%" doubles="true" maxlength="5" />&nbsp;个</td>
						
					</tr>
					
					<tr>
						<td class="ListTableTr11">问题所属开始日期：</td>
						<td class="ListTableTr22"><s:textfield name="middleLedgerProblem.creater_startdate" id="creater_startdate" disabled="true"  cssStyle="width:70%" maxlength="20" /></td>
						<td class="ListTableTr11">问题所属结束日期：</td>
						<td class="ListTableTr22"><s:textfield name="middleLedgerProblem.creater_enddate" id="creater_enddate" disabled="true"  cssStyle="width:74%" maxlength="20" /></td>
					</tr>
					<tr>
						<td class="ListTableTr11">审计发现类型：</td>
						<td class="ListTableTr22"><s:select list="basicUtil.problemMethodList" listKey="code" listValue="name" emptyOption="true" disabled="true" name="middleLedgerProblem.problem_grade_code"></s:select></td>
	               <%--      <td class="ListTableTr11">会计制度类型:</td>
						<td class="ListTableTr22"><s:select cssStyle="width:74%" id="accountantSystemTypeName" name="middleLedgerProblem.accountantSystemTypeName" disabled="true" list="basicUtil.accountingTypeList" listKey="code" listValue="name" headerKey="" headerValue="" theme="ufaud_simple" templateDir="/strutsTemplate" /></td>
					 --%></tr>
					<tr>
						<s:if test="middleLedgerProblem.pro_type == '020312'">
							<td class="ListTableTr11">责任<div>(经济责任审计)</div></td>
							<td class="ListTableTr22" colspan="3"><s:select  name="middleLedgerProblem.zeren" disabled="true" list="#@java.util.LinkedHashMap@{'领导责任':'领导责任','主管责任':'主管责任','直接责任':'直接责任'}" listValue="value" listKey="key"  emptyOption="true"></s:select></td>
						</s:if>
						<s:else>
							<td class="ListTableTr11">责任<div>(非经济责任审计)</div></td>
							<td class="ListTableTr22" colspan="3"><s:select  name="middleLedgerProblem.zeren" disabled="true" list="#@java.util.LinkedHashMap@{'领导违规':'领导违规','损失浪费':'损失浪费','管理不规范':'管理不规范'}" listValue="value" listKey="key"  emptyOption="true"></s:select></td>
						</s:else>
					</tr>
					<tr>
						<td class="ListTableTr11">
							关联底稿
						</td>
						<td>
							<span id="p2"></span>
							<%--<s:textfield name="middleLedgerProblem.linkManuName"  cssStyle='width:260px' disabled="true" />--%>
							<!--一般文本框-->
							<s:hidden name="middleLedgerProblem.linkManuName"></s:hidden>
							<s:hidden name="middleLedgerProblem.linkManuId" />
						</td>
						<td class="ListTableTr11">
							被审计单位
						</td>
						<td>
							<s:textfield name="middleLedgerProblem.audit_object_name" cssStyle='width:260px' disabled="true" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">问题标题:</td>
						<td class="ListTableTr22" colspan="5">
							<s:textarea name="middleLedgerProblem.audit_con" title="问题标题" cssClass='autoResizeTexareaHeight' disabled="true" cssStyle="width:100%;color:gray;height:60" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">问题摘要:</td>
						<td class="ListTableTr22" colspan="5">
							<s:textarea name="middleLedgerProblem.describe" title="问题摘要" cssClass='autoResizeTexareaHeight' disabled="true" cssStyle="width:100%;color:gray;height:60" />
						</td>
					</tr>						
					<tr>
						<td class="ListTableTr11">定性依据:</td>
						<td class="ListTableTr22" colspan="5">
							<s:textarea name="middleLedgerProblem.audit_law" title="定性依据" id="sjjl" cssClass='autoResizeTexareaHeight' disabled="true" cssStyle="width:100%;height:60" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">审计建议:</td>
						<td class="ListTableTr22" colspan="5">
							<s:textarea name="middleLedgerProblem.audit_advice" title="审计建议" cssClass='autoResizeTexareaHeight' disabled="true" cssStyle="width:100%;color:gray;height:60" />
						</td>
					</tr>
				</table>
			<%-- <table class="ListTable" id="tab1" style="display: none;">
				<tr>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
						所属底稿:
						</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.manuscript_name"/>
						</td>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
							审计小组:
							<FONT color=red>*</FONT>
						</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.taskAssignName"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
							被审计单位:
						</td>
						<td class="ListTableTr22" colspan="3">
							<s:property value="middleLedgerProblem.audit_object_name"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">发现人:</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.creater_name"/>
						</td>
						<td class="ListTableTr11">发现时间:</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.problem_date"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">审计事项:</td>
						<td class="ListTableTr22" colspan="3">
							<s:property value="manuscript.task_name"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">问题类别:</td>
						<td class="ListTableTr22" colspan="3">
							<s:property value="middleLedgerProblem.problem_all_name"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">问题点:</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.problem_name"/>
						</td>
						<td class="ListTableTr11">备注（问题点为其他）:</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.problemComment"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">发生金额:</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.problem_money"/>&nbsp;万元
						</td>
						<td class="ListTableTr11">发生数量:</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.problemCount"/>&nbsp;个
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">问题所属开始日期：</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.creater_startdate" />
						</td>
						<td class="ListTableTr11">问题所属结束日期：</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.creater_enddate" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">审计发现类型：</td>
						<td class="ListTableTr22">
							<s:property value="middleLedgerProblem.problem_grade_name" />
						</td>
						<td class="ListTableTr11">会计制度类型:</td>
						<td class="ListTableTr22" >
							<s:property value="middleLedgerProblem.accountantSystemTypeName" />
						</td>
					</tr>
					<tr>
						<s:if test="middleLedgerProblem.pro_type == '020312'">
							<td class="ListTableTr11">责任：<FONT color=red>*(经济责任审计)</FONT></td>
							<td class="ListTableTr22"><s:property value="middleLedgerProblem.zeren" /></td>
							<td class="ListTableTr11"></td>
							<td class="ListTableTr22"></td>
						</s:if>
						<s:else>
							
						</s:else>
					</tr>
					<tr>
						<td class="ListTableTr11">定性依据:</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="middleLedgerProblem.problem_desc" title="定性依据" readonly="true"
								cssStyle="width:90%;color:gray;height:60" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">问题摘要:</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="manuscript.describe" title="问题摘要" readonly="true"
								cssStyle="width:90%;color:gray;height:60" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">审计建议:</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="middleLedgerProblem.aud_mend_advice" title="审计建议" readonly="true"
								cssStyle="width:90%;color:gray;height:60" />
						</td>
					</tr>
			</table>--%>
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
			    class="ListTable" id="tab2" style="display: none;">
				<tr>
					<%--<td class="ListTableTr11">是否整改</td>
					<td class="ListTableTr22">
						<s:select list="#@java.util.LinkedHashMap@{'否':'否'}"  
							name="middleLedgerProblem.isNotMend" id="isNotMend"  headerKey="是" headerValue="是"></s:select>
					</td> --%>
					<s:hidden name="middleLedgerProblem.isNotMend" id="isNotMend" value="是"/>
					<td class="ListTableTr11">整改期限:</td>
					<td class="ListTableTr22">
						<s:property value="middleLedgerProblem.mend_term" />
					     	至
					    <s:property value="middleLedgerProblem.mend_term_enddate" />
					</td>
					<td class="ListTableTr11">监督检查人:</td>
					<td class="ListTableTr22">
						<s:textfield name="middleLedgerProblem.examine_creater_name" cssStyle='width:260px' disabled="true" />
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">整改方式:</td>
					<td class="ListTableTr22">
						<s:textfield name="middleLedgerProblem.mend_method" cssStyle='width:260px' disabled="true" />
					</td>
					<td class="ListTableTr11">检查方式:</td>
					<td class="ListTableTr22">
						<s:textfield name="middleLedgerProblem.examine_method" cssStyle='width:260px' disabled="true" />
					</td>
				</tr>
				<%--<tr>
						<td class="ListTableTr11">被审计单位行动计划<font color=DarkGray>(限3000字)</font></td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea
								name="middleLedgerProblem.aud_action_plan" title="被审计单位行动计划" cssStyle="width:100%"/>
							<input type="hidden" id="middleLedgerProblem.aud_action_plan.maxlength" value="3000">
						</td>
						<td class="ListTableTr11">审计建议:<font color=DarkGray>(限3000字)</font></td>
						<td class="ListTableTr22">
							<s:textarea
								name="middleLedgerProblem.aud_mend_advice" title="审计实施单位整改意见"
								cssStyle="width:90%"/>
								<input type="hidden" id="middleLedgerProblem.aud_mend_advice.maxlength" value="300">
						</td>
				</tr> --%>
				<tr>
					<td class="ListTableTr11">
						整改责任单位:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="projectStartObject.audit_object_name" cssStyle='width:260px' disabled="true" />
					</td>
					<td class="ListTableTr11">
						责任部门:
					</td>
					<td class="ListTableTr22">
						<s:textfield name="projectStartObject.zeren_dept" cssStyle='width:260px' disabled="true" />
					</td>
				</tr>
				<tr>
				    <td class="ListTableTr11">责任人:</td>
					<td class="ListTableTr22">
						<s:textfield name="projectStartObject.zeren_person" cssStyle='width:260px' disabled="true" />
					</td>
					<td class="ListTableTr11">联系电话:</td>
					<td class="ListTableTr22">
						<s:textfield name="projectStartObject.telephone" cssStyle='width:260px' disabled="true" />
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						附件：
					</td>
					<td class="ListTableTr22" colspan="3">
						<div id="file_idList" align="center">
							<s:property escape="false" value="file_idList" />
						</div>
					</td>
				</tr>
			</table>
			<s:form id="myform" action="updateTrackingProblem" namespace="/proledger/problem">
				<table  class="ListTable" id="tab3">
					
					<tr>
						<td class="ListTableTr11">被审计单位反馈的整改结果(最多200字):</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="middleLedgerProblem.mend_result" title="被审计单位反馈整改结果" cssStyle="width:100%;height:70px;" disabled="true"/>
							<input type="hidden" id="middleLedgerProblem.mend_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">是否追责:</td>
						<td class="ListTableTr22">
						<s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" disabled="true"
							name="middleLedgerProblem.responsibility" id="responsibility" emptyOption="true"></s:select>
							<%-- <s:select list="basicUtil.problem_statusList" name="middleLedgerProblem.responsibility" headerKey="" headerValue="" listKey="code" listValue="name" /> --%>
						</td>
						<td class="ListTableTr11">追责方式:</td>
						<td class="ListTableTr22">
							<%-- <s:select list="basicUtil.mendMethodList" listKey="name" id="responsibility_Mode"
								listValue="name" emptyOption="true"
								name="middleLedgerProblem.responsibility_Mode">
							</s:select> --%>
							<%-- <s:hidden name="middleLedgerProblem.responsibility_Mode"></s:hidden> --%>
							<s:textarea name="middleLedgerProblem.responsibility_Mode" disabled="true" cssStyle="height:20px;overflow-y:hidden"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">整改状态:</td>
						<td class="ListTableTr22">
							<s:select list="basicUtil.fllowOpinionList" disabled="true"
								name="middleLedgerProblem.mend_state_code" id="mend_state" listKey="code" listValue="name" emptyOption="true"></s:select>
						</td>
						<td class="ListTableTr11">实际整改期限:</td>
						<td class="ListTableTr22">
							<s:textfield name="middleLedgerProblem.examine_startdate" disabled="true"
								readonly="true" title="单击选择日期" onclick="calendar()"
								cssStyle="width:30%" maxlength="20" />
						     	至
							<s:textfield name="middleLedgerProblem.examine_enddate" disabled="true"
								readonly="true" title="单击选择日期"
								onclick="calendar()" cssStyle="width:30%" maxlength="20" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">到期未整改原因:</td>
						<td class="ListTableTr22">
							<s:textarea name="middleLedgerProblem.no_rectification_reason" disabled="true" cssStyle="height:20px;overflow-y:hidden"/>
						</td>
						<td class="ListTableTr11">实际检查人:</td>
						<td class="ListTableTr22">
							<s:textarea name="middleLedgerProblem.real_examine_creater" disabled="true" cssStyle="height:20px;overflow-y:hidden"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">审计单位跟踪检查结果(最多200字):</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="middleLedgerProblem.examine_result" disabled="true" title="审计单位跟踪检查结果" cssStyle="width:100%;height:70px;" />
							<input type="hidden" id="middleLedgerProblem.examine_result.maxlength" value="200"/>
						</td>
						
					</tr>
					<tr>
						<td class="ListTableTr11">整改跟踪结论:</td>
						<td class="ListTableTr22" colspan="3">
							<s:textarea name="middleLedgerProblem.aud_track_result" disabled="true" cssStyle="width:100%;height:20px;overflow-y:hidden"></s:textarea>
						</td>
					</tr>
					<tr id="fujian">
						<%--<td class="ListTableTr11">
							<s:button
								disabled="!(varMap['uploadw_fileWrite']==null?true:varMap['uploadw_fileWrite'])"
								display="${varMap['uploadw_fileRead']}" onclick="Upload('middleLedgerProblem.f_mend_accessory',accelerys)"
								value="上传附件" ></s:button>
						</td>--%>
						<s:hidden name="middleLedgerProblem.f_mend_accessory" />
						<td class="ListTableTr22" colspan="3">
							<div id="accelerys" align="center">
								<s:property escape="false" value="accessoryList" />
							</div>
						</td>
					</tr>    
					<%-- <tr>
						<td class="ListTableTr11">整改状态:</td>
						<td class="ListTableTr22">
							<s:select list="basicUtil.fllowOpinionList"
								name="middleLedgerProblem.mend_state_code" id="mend_state" listKey="code" listValue="name" emptyOption="true"></s:select>
						</td>
						<td class="ListTableTr11">实际整改期限:</td>
						<td class="ListTableTr22">
							<s:textfield name="middleLedgerProblem.examine_startdate"
								readonly="true" title="单击选择日期" onclick="calendar()"
								cssStyle="width:30%" maxlength="20" />
						     	至
							<s:textfield name="middleLedgerProblem.examine_enddate"
								readonly="true" title="单击选择日期"
								onclick="calendar()" cssStyle="width:30%" maxlength="20" />
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">被审计单位反馈整改结果(最多200字):</td>
						<td class="ListTableTr22">
							<s:textarea name="middleLedgerProblem.mend_result" title="被审计单位反馈整改结果" cssStyle="width:90%" />
							<input type="hidden" id="middleLedgerProblem.mend_result.maxlength" value="200"/>
						</td>
						<td class="ListTableTr11">审计单位跟踪检查结果(最多200字):</td>
						<td class="ListTableTr22">
							<s:textarea name="middleLedgerProblem.examine_result" title="审计单位跟踪检查结果" cssStyle="width:90%" />
							<input type="hidden" id="middleLedgerProblem.examine_result.maxlength" value="200"/>
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">整改跟踪结论:</td>
						<td class="ListTableTr22">
							<s:textarea name="middleLedgerProblem.aud_track_result" cssStyle="width:90%;height:20px;overflow-y:hidden"></s:textarea>
						</td>
						<td class="ListTableTr11">实际检查人:</td>
						<td class="ListTableTr22">
							<s:textarea name="middleLedgerProblem.real_examine_creater"  cssStyle="width:90%;height:20px;overflow-y:hidden"/>
						</td>
					</tr> --%>
					<%-- <tr>
						<td class="ListTableTr11">
							<s:button value="上传附件" onclick="upload('accelerys','middleLedgerProblem.f_mend_accessory')"/>
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="accelerys" align="center">
        						<s:property escape="false" value="accessoryList" />
  							</div> 
						</td>
					</tr> --%>
			    </table>
			    <s:hidden name="isEdit" />
				<s:hidden name="project_code" />
				<s:hidden name="project_id" />
				<s:hidden name="permission" />
				<s:hidden name="middleLedgerProblem.project_id" value="%{project_id}" />
				<s:hidden name="middleLedgerProblem.id" />
				<s:button value="返回" onclick="back();" />
			</s:form>
		</center>
		<script type="text/javascript">
		/* function upload(idName,f_mend_accessory){
			var contextPath = '${contextPath}';
			var deletePermission = 'true';
			var isEdit = "false";
			var width = 650;
			var height = 450;
			uploadFileResource(contextPath,f_mend_accessory,deletePermission,isEdit,idName,width,height,'附件')
		} */
		/*
		 *上传附件
		*/
		function Upload(id,filelist){
			var guid=document.getElementById(id).value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			//parent.setAutoHeight();
		}
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
				var isDisplay = document.getElementById(tab).style.display;
				if(isDisplay==''){
					document.getElementById(tab).style.display='none';
				}else{
					document.getElementById(tab).style.display='';
				}
			}
			function saveForm(){
				var sdate =document.getElementById("middleLedgerProblem.examine_startdate").value;
				var edate =document.getElementById("middleLedgerProblem.examine_enddate").value;
				if(sdate!=""&&edate!=""){
					sdate = sdate.replace("-","").replace("-","");
					edate = edate.replace("-","").replace("-","");
					var sn = new Number(sdate);
					var en = new Number(edate);
					if(sn>en){
						alert("开始时间不能大于结束时间");
						return ;
					}
				}
				var url = "${contextPath}/proledger/problem/updateTrackingProblem.action";
				myform.action = url;
				myform.submit();
				
			}
			function back(){
				window.history.back(-1);
			 // window.location.href="${contextPath}/proledger/problem/auditTrackingList.action?project_id=${project_id}&isEdit=true";
			}
			
		</script>
	</body>
</html>
