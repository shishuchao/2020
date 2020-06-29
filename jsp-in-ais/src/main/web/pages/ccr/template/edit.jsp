<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>编辑模板</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<style type="text/css">
			textarea {
				width: 90%;
				height: 50px;
			}
		</style>
		<s:head theme="simple" />
		<script type="text/javascript">
			function saveForm(){
				var _tcode = document.getElementById('templateCode').value;
				var _tname = document.getElementById('templateName').value;
				if(_tcode == ''){
					alert('模板编号不能为空，请填写模板编号');
					return false;
				}
				if(_tname == ''){
					alert('模板名称不能为空，请填写模板名称');
					return false;
				}
					
					document.forms[0].submit();
			}
			function loadForm(){
				var operateResult = document.getElementById("operateResult").value;
				if(operateResult=='false'){
					alert("保存失败！");
				}
			}
		</script>
	</head>
	<body>
		<s:form action="saveTemplate.action" namespace="/ccrTemplate" name="editForm">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
						<s:if test="${empty(template)}">
							新增报表
						</s:if>
						<s:else>
							修改报表
						</s:else>
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 align="right">
						报表编号
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="35%" align="left">
							<s:textfield id="templateCode" name="template.templateCode" size="20"  title="报表编号" maxlength="50" cssStyle="width:100%"/>
					</TD>
					<TD class=ListTableTr1 width="120" align="right">
						报表名称
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 align="left">
							<s:textfield id="templateName" name="template.templateName" size="20"  title="报表名称" maxlength="50" cssStyle="width:100%"/>
					</TD>
				</TR>
				<%--<TR>
					<TD class=ListTableTr1 style="width: 120px">
						报表类型
					</TD>
					<TD class="ListTableTr2" align="left" colspan="1">
						<s:seletemplate name="template.templateType" list="cellTemplatePojoMap" listKey="key" listValue="value" ></s:seletemplate>
					</TD>
					<TD class=ListTableTr1 style="width: 120px">
						报表类型
					</TD>
					<TD class="ListTableTr2" align="left" colspan="1">
					<s:radio list="#{'1':'一级','2':'二级','3':'三级'}" id="template.level" name="template.level" value="template.level" ></s:radio>
					</TD>
				</TR>
				--%><TR>
					<TD class=ListTableTr1 style="width: 120px">
						报表说明(少于2000字)
					</TD>
					<TD class="ListTableTr2" align="left" colspan="3">
						<s:textarea rows="4" cols="30" name="template.remark" cssStyle="height:50px; width:100%"></s:textarea>
						<input type="hidden" id="template.remark.maxlength" value="2000"/>
					</TD>
				</TR>
			</TABLE>
			<br>
			<div align="center">
				<s:button value="保存" onclick="saveForm()"></s:button>
				<s:button value="返回" onclick="history.go(-1)"></s:button>
			</div>
			<s:hidden name="templateId"/>
			<s:hidden name="template.creator"></s:hidden>
			<s:hidden name="template.createDate"></s:hidden>
			<s:hidden name="template.id"></s:hidden>
		</s:form>
	</body>
</html>
