
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
	<s:text id="title" name="'中介机构（周期）考核信息'"></s:text>
<html>
	<head>
		<title><s:property value="#title" /></title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>		
		<s:head />		
	</head>

	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						&nbsp;
						<s:property value="#title" />
					</td>
				</tr>
			</table>

			<s:form id="myform" namespace="/pe/pf/sjrc" action="save" >
				
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">
                    <tr>
				
						<td class="ListTableTr11">
							编号:
						</td>
						<td class="ListTableTr22">
						    <s:property value="crudObject.formId"/>							
						</td>
						<td class="ListTableTr11">
							名称:
						</td>
						<td class="ListTableTr22">							
							 <s:property value="crudObject.name"/>
						</td>
					</tr>															
				</table>
				
			<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>
		    <div align="right" style="width:97%"> 		
				<input type="button" value="返回" onclick="javascript:history.go(-1);">				
			</div>            
			</s:form>


	<!-- 列表FORM -->
		

		</center>
		
	</body>
</html>
