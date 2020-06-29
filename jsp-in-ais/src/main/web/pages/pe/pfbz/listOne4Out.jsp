<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'详细信息'"></s:text>
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

		<script type="text/javascript"
			src="${contextPath}/pages/pe/validate/checkboxSelected.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		
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

			<s:form id="myform" action="save" namespace="/pe/pfbz">
				
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="project_table">
					<tr>			
						<td class="ListTableTr11">
							<font color=red>*</font>名称:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="pfbz.name" cssStyle="width:100%"
								maxlength="300" readonly="true"/>
						</td>
						<td class="ListTableTr11">
							<font color=red>*</font>状态:
						</td>
						<td class="ListTableTr22">
						<s:if test="${pfbz.status=='0'}">
						<s:textfield name="pfbz.status" cssStyle="width:100%"
								maxlength="300"  readonly="true" value="未被使用"/>					
				         </s:if>
                         <s:elseif test="${pfbz.status=='1'}">
 						<s:textfield name="pfbz.status" cssStyle="width:100%"
								maxlength="300"  readonly="true" value="正被使用"/>                        
                         </s:elseif>
						</td>
					</tr>
				</table>			
			</s:form>


		<table id="tableTitle" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;标准明细列表
					</td>
				</tr>
			</table>

	<!-- 列表FORM -->
		<s:form namespace="/pe/pfbz_inner">
		    <s:hidden name="id" value="${pfbz.id}"></s:hidden>		    
			<display:table name="pfbz_innerList" id="row" requestURI="${contextPath}/pe/pfbz/listOne.action" class="its" pagesize="5" >
				<display:column>
					<input type="checkbox" name="ids" value="${row.id}">
				</display:column>

				<display:column property="name" title="名称"
					headerClass="center" sortable="true">
				</display:column>

				<display:column  title="分数区间" headerClass="center" sortable="true">
				<input type="text" name="score" value="${row.score}" readonly/> ~<input type="text" name="score1" readonly value="${row.score1}"/>
				</display:column>	
							
			</display:table>               	
		</s:form>
	
		</center>
	</body>
</html>
