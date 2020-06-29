<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>绩效考核-审计人才考核明细</title>
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
		<s:form id="batch_start_form" name="myform" action="save" namespace="/pe/pf/sjrc">
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;审计人才信息
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						考核对象：
					</td>
					<td class="ListTableTr22">
						<s:textfield  readonly="true" name="o_" value="审计人才"></s:textfield>
					</td>
					<td class="ListTableTr11">
						考核主体：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="m_" value="所在部门"></s:textfield>						
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						考核方式：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjrc.peTypeName"></s:textfield>
					</td>
					<td class="ListTableTr11">
						考核周期：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true"  name="sjrc.peRangeValue" ></s:textfield>						
					</td>
				</tr>								
				<tr>
					<td class="ListTableTr11">
						考核体系：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjrc.peSytem_name"></s:textfield>
					</td>
					<td class="ListTableTr11">
						人员姓名：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjrc.name"></s:textfield>						
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11">
						人才类别：
					</td>
					<td class="ListTableTr22">
						<s:textfield name="sjrc.type"></s:textfield>
					</td>
					<td class="ListTableTr11">
						性别：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjrc.sex"></s:textfield>						
					</td>
				</tr>				
				<tr>
					<td class="ListTableTr11">
						所在部门：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjrc.department"></s:textfield>
					</td>
					<td class="ListTableTr11">
						现任职务：
					</td>
					<td class="ListTableTr22">
						<s:textfield readonly="true" name="sjrc.duty"></s:textfield>						
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

${html}

</fieldset>	
	
			
			

		</s:form>

	</body>
</html>
