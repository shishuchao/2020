
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'项目台账查看'"></s:text>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
	</head>
	<SCRIPT type="text/javascript">
	function saveLedger(p_code){
  window.open("${contextPath}/proledger/custom/createLedgerTabs.action?project_id="+p_code+"&isView=true&isEdit=false","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
}
	</SCRIPT>
	<body>
	<center>
		<table>
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					项目台账查看
				</td>
			</tr>
		</table>
			<input id="pro_teamleader" type="hidden" />
			<table cellpadding=1 cellspacing=1 border="1"
				style="border-style: 1px solid;" bordercolor="#7CA4E9">
				<tr>
					<td colspan="4">
						<img src="${contextPath}/resources/images/minus.gif" id="img_one"
							onclick="hve_display(xmtz,img_one)">
						项目台账
						<br>
						<s:hidden name="crudObject.formId"></s:hidden>
						<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
							class="ListTable" id="xmtz" align="center">
							<tr class="titletable1">
								<td width="20%">
									<font color="red">*</font> 项目名称(请先选项目)
								</td>
								<td colspan="3">
									<s:textfield name="crudObject.xm_prj_name" cssStyle="width:70%"
										readonly="true" />
								</td>
							</tr>
							<tr class="titletable1">
								<td width="20%">
									项目编号
								</td>
								<td width="30%">
									<s:textfield name="crudObject.xm_prj_code" cssStyle="width:70%"
										readonly="true" />
								</td>
								<td width="20%">
									项目名称
								</td>
								<td width="30%">
									<s:hidden name="crudObject.xm_formId" />
									<s:hidden name="crudObject.rework_closed" />
									<s:hidden name="crudObject.pro_teamleader" />
								</td>

							</tr>
							<tr class="titletable1">
								<td>
									计划类别
								</td>
								<td>
									<s:textfield name="crudObject.xm_plan_type" readonly="true"
										cssStyle="width:70%" />
									<s:hidden name="crudObject.xm_plan_typeCode"></s:hidden>
								</td>
								<s:hidden name="crudObject.xm_jhCode"></s:hidden>
								<td>
									所属单位
								</td>
								<td>
									<s:textfield name="crudObject.xm_auditee" readonly="true"
										cssStyle="width:70%" />
									<s:hidden name="crudObject.xm_auditeeCode"></s:hidden>
								</td>
							</tr>
							<tr class="titletable1">
								<td>
									被审计单位
								</td>
								<td>
									<s:textfield name="crudObject.xm_audi_obj" readonly="true"
										cssStyle="width:70%" />
									<s:hidden name="crudObject.xm_audi_objCode"></s:hidden>
								</td>
								<td>
									项目类别
								</td>
								<td>
									<s:textfield name="crudObject.xm_prj_type" readonly="true"
										cssStyle="width:35%" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
				<s:button value="台账"
					onclick="saveLedger('${crudObject.xm_formId}');" />
&nbsp;&nbsp;
			<!--<input type="button" value="返回" onclick="javascript:history.go(-1);">
	-->
	<input type="button" value="关闭" onclick="javascript:window.close();">
	</center>
	</body>
</html>