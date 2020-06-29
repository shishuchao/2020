<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>

		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>

		<script type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></script>

		<script type="text/javascript"
			src="<%=request.getContextPath()%>/hztz/js/itemManage/checkboxSelected.js"></script>	
		<title>时效性考核</title>
		<script language="javascript">
function doSubmit()
{	
     
       document.forms[0].submit();
}
</script>
	</head>
	<body>
	
			
		<table id="tableTitle" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						&nbsp;时效性查询
					</td>
				</tr>
			</table>

		<s:form action="listAll.action" namespace="/pe/timeless">
	
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						审计单位
					</td>
					<TD class=listtabletr1>
					<s:buttonText name="sjdw" hiddenName="sjdwCode" cssStyle="width:150px" doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&p_item=1&orgtype=1&paraname=sjdw&paraid=sjdwCode',600,450)" doubleSrc="/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false" />
					</TD>

					<TD align=center class=listtabletr1>
						开始时间
					</TD>
					<TD class=listtabletr1>
						<s:textfield name="beginDate" readonly="true" title="单击选择日期" 	onclick="calendar()" ></s:textfield>
					</TD>
					<TD align=center class=listtabletr1>
						结束时间
					</TD>
					<TD class=listtabletr1>
						<s:textfield name="endDate" readonly="true" title="单击选择日期" 	onclick="calendar()" ></s:textfield>
					</TD>					
				</tr>
				
				<tr class="listtablehead" align="right">
						<td colspan="6" align="right" class="listtabletr1">
							<div align="right">
							<s:button onclick="return doSubmit();" value="查询"/>

							</div>
						</td>
					</tr>				
					

			</TABLE>
			
			
			
			
		</s:form>

		<br>

		<!-- 列表FORM -->
		<s:form namespace="/pe/timeless">
			<display:table name="tlList" id="row" requestURI="${contextPath}/pe/timeless/listAll.action"
				class="its" pagesize="10" export="true">

	
				<display:column property="audit_dept_name" title="审计单位"
					headerClass="center" sortable="true">
				</display:column>

				<display:column property="week_time" title="延迟上报次数（周报）"
					headerClass="center" sortable="true">
				</display:column>
				<display:column property="week_score" title="单项扣分（周报）"
					headerClass="center" sortable="true">
				</display:column>				
				
				<display:column property="month_time" title="延迟上报次数（月报）"
					headerClass="center" sortable="true">
				</display:column>
				<display:column property="month_score" title="单项扣分（月报）"
					headerClass="center" sortable="true">
				</display:column>


				<display:column property="report_time" title="延迟上报次数（报告初稿）"
					headerClass="center" sortable="true">
				</display:column>
				<display:column property="report_score" title="单项扣分（报告初稿）"
					headerClass="center" sortable="true">
				</display:column>
				
				<display:column property="total_time" title="延迟上报次数（总的）"
					headerClass="center" sortable="true">
				</display:column>
				<display:column property="total_score" title="总扣分"
					headerClass="center" sortable="true">
				</display:column>												
				
			</display:table>




		</s:form>







	</body>
</html>
