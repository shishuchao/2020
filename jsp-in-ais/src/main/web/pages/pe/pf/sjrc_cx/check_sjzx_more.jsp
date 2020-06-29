<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>绩效考核-中介机构(项目)考核结果明细</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${contextPath}/pages/pe/validateCommon.js'></script>
		<s:head theme="ajax" />
	</head>

	
		<body>
		<s:form id="batch_start_form" name="myform" action="save" namespace="/pe/pf/sjzx">
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;中介机构信息
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						考核对象：
					</td>
					<td class="ListTableTr22">
						<s:textfield  readonly="true" name="o_" value="中介机构(项目)"></s:textfield>
					</td>
					 <td class="ListTableTr11">
						考核状态：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="d_" value="正在考核"></s:textfield>						
					</td>	
					
				</tr>
				<tr>
					<td class="ListTableTr11">
						考核方式：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjzx.peTypeName"></s:textfield>
					</td>
					<td class="ListTableTr11">
						考核体系：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjzx.peSytem_name"></s:textfield>					
					</td>
				</tr>								
				<tr>
					<td class="ListTableTr11">
						项目名称：
					</td>
					<td class="ListTableTr22" >
						<s:textfield readonly="true" name="sjzx.item_name"></s:textfield>
					</td>
					   <td class="ListTableTr11">
						中介机构：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjzx.name"></s:textfield>						
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						计划类别：
					</td>
					<td class="ListTableTr22">
						<s:textfield name="sjzx.plan_type_name"></s:textfield>
					</td>
					<td class="ListTableTr11">
						项目类别：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjzx.pro_type_name"></s:textfield>						
					</td>
				</tr>				
				<tr>
					<td class="ListTableTr11">
						审计单位：
					</td>
					<td class="ListTableTr22">
						<s:textfield name="sjzx.audit_dept_name"></s:textfield>
					</td>
					<td class="ListTableTr11">
						被审计单位：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjzx.audit_object_name"></s:textfield>						
					</td>
				</tr>
				
				<tr>
					<td class="ListTableTr11">
						项目开始日期：
					</td>
					<td class="ListTableTr22">
						<s:textfield name="sjzx.real_start_time"></s:textfield>
					</td>
					<td class="ListTableTr11">
						项目关闭日期：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjzx.real_closed_time"></s:textfield>						
					</td>
				</tr>
				<tr>
						<td class="ListTableTr11">
							相关附件							
						</td>
						<td class="ListTableTr22" colspan="3">
							<div id="projectAnnexList" align="center">
								<s:property escape="false" value="projectAnnexList"/>
							</div>

						</td>
				</tr>															
			</table>
				

	

	


	
<fieldset>
			<legend>
				考核信息
			</legend>
<s:div id="div2">
${html}
</s:div>
</fieldset>	
	

		</s:form>

	</body>
</html>
