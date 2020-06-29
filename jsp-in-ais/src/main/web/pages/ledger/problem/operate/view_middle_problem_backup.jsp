<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>查看整改问题一览表明细信息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
			.ListTableTr11 {
				BACKGROUND-COLOR: #F5F5F5;
				width: 8%;
				height: 20;
				vertical-align: middle;
				text-align: right;
			}
			.ListTableTr22 {
				BACKGROUND-COLOR: #ffffff;
				width: 35%;
				height: 20;
				padding-left: 5px;
			}
			.ListTableTrStage {
				BACKGROUND-COLOR: #ffffff;
				width: 15%;
				height: 20;
				vertical-align :"middle"
			}
		</style>
		<script type="text/javascript">
			function back(){
			  window.location.href="${contextPath}/proledger/problem/listDigaoEditProblem.action?project_id=${project_id}&manuscript_id=${manuscript_id}&isView=true";
			}
			function triggerTab(tab){
				var isDisplay = document.getElementById(tab).style.display;
				if(isDisplay==''){
					document.getElementById(tab).style.display='none';
				}else{
					document.getElementById(tab).style.display='';
				}
			}
		</script>
	</head>
	<body>
		<center>
			<br />
			<br />
			<table id="tab1" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
				<tr>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;" style="BACKGROUND-COLOR: #F5F5F5;">
						问题类别:
					</td>
					<td class="ListTableTr22">
						<s:property value="middleLedgerProblem.sort_big_name"/>
					</td>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
						问题子类别:
					</td>
					<td class="ListTableTr22">
						<s:property value="middleLedgerProblem.sort_small_name"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
						问题点:
						<FONT color=red>*</FONT>
					</td>
					<td class="ListTableTr22">
						<s:property value="middleLedgerProblem.problem_name"/>
					</td>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
						发生数:
						<FONT color=red>*</FONT>
					</td>
					<td class="ListTableTr22">
						<s:property value="middleLedgerProblem.problem_money"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;" nowrap="nowrap">
						问题所属开始日期：
					</td>
					<td class="ListTableTr22">
						<s:property value="middleLedgerProblem.creater_startdate"/>
					</td>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;" nowrap="nowrap">
						问题所属结束日期：
					</td>
					<td class="ListTableTr22">
						<s:property value="middleLedgerProblem.creater_enddate"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
						问题定性:
						<FONT color=red>*</FONT>
					</td>
					<td class="ListTableTr22">
						<s:property value="middleLedgerProblem.problem_grade_name"/>
					</td>
					<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;" nowrap="nowrap">
                                                  统计数量单位:
                           <FONT color=red>*</FONT>
					</td>
					<td class="ListTableTr22" id="unitsDiv">
						<s:property value="middleLedgerProblem.p_unit"/>
					</td>
				</tr>
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
				<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
					问题描述:
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="middleLedgerProblem.problem_desc"/>
				</td>
				</tr>
				<tr>
				<td class="ListTableTr11" style="BACKGROUND-COLOR: #F5F5F5;">
					审计建议:
				</td>
				<td class="ListTableTr22" colspan="3">
					<s:property value="middleLedgerProblem.aud_mend_advice"/>
				</td>
				</tr>
			</table>
			<div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="triggerTab('tab2');">问题整改要求</a>
				</div>
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
			    class="ListTable" id="tab2" style="display: none;">
			<tr>
				<td class="ListTableTr11">是否整改:</td>
				<td class="ListTableTr22">
					<s:select list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}"
						name="middleLedgerProblem.isNotMend" id="isNotMend" emptyOption="true" disabled="true"></s:select>
				</td>
				<td class="ListTableTr11">整改期限:</td>
				<td class="ListTableTr22">
					<s:property value="middleLedgerProblem.mend_term" />
				     	至
				    <s:property value="middleLedgerProblem.mend_term_enddate" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">
					整改责任部门:
				</td>
				<td class="ListTableTr22">
					<s:property value="middleLedgerProblem.zeren_dept" />
				</td>
				<td class="ListTableTr11">
					责任单位:
				</td>
				<td class="ListTableTr22">
					<s:property value="middleLedgerProblem.zeren_company" />
				</td>
			</tr>
			<tr>
			    <td class="ListTableTr11">整改负责人:</td>
				<td class="ListTableTr22">
					<s:property value="middleLedgerProblem.zeren_person" />
				</td>
				<td class="ListTableTr11">监督检查人:</td>
				<td class="ListTableTr22">
				    <s:property value="middleLedgerProblem.examine_creater_code" />
				</td>
			</tr>
			<tr>
				<td class="ListTableTr11">整改方式:</td>
				<td class="ListTableTr22">
					<s:property value="middleLedgerProblem.mend_method" />
				</td>
				<td class="ListTableTr11">检查方式:</td>
				<td class="ListTableTr22">
					<s:property value="middleLedgerProblem.examine_method" />
				</td>
			</tr>
			<tr>
					<td class="ListTableTr11">被审计单位行动计划:<font color=DarkGray>(限3000字)</font></td>
					<td class="ListTableTr22" colspan="7">
						<s:textarea
							name="middleLedgerProblem.aud_action_plan" title="被审计单位行动计划" cssStyle="width:90%" readonly="true"/>
					</td>
			</tr>
		</table>
		<s:button value="返回" onclick="back();" />
		</center>
	</body>
</html>
