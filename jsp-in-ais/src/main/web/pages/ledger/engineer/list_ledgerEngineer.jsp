<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<html>
<head>
<title>列表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
	type="text/css">
<script type='text/javascript'
	src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
</head>
<script type="text/javascript">
    function deleteForm(id){
        if(window.confirm("确定执行删除操作吗?")){
        	 window.location.href="${pageContext.request.contextPath}/ledger/ledgerEngineer/delete.action?id="+id;
        }else{
        	return false;
        }
        
    }

    function resetButton(){
    	document.getElementsByName("ledgerEngineer.a_project_code")[0].value="";
    	document.getElementsByName("lledgerEngineer.w_project_name")[0].value="";
    	document.getElementsByName("ledgerEngineer.contract_company")[0].value="";
    	document.getElementsByName("ledgerEngineer.auditedDept")[0].value="";
    }
</script>
<body>
<center>
<table>
	<tr class="listtablehead">
		<td colspan="5" align="left" class="edithead">
					<s:property
								escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ledger/ledgerEngineer/list.action')" />
					</td>
	</tr>
</table>
<s:form id="queryform" action="list"
	namespace="/ledger/ledgerEngineer" method="post">
	<table id="table" cellpadding=0 cellspacing=1 border=0
		bgcolor="#409cce" class="ListTable">
		<tr class="listtablehead">
			<td align="left" class="listtabletr11">审计项目编号：</td>
			<td align="left" class="listtabletr22"><s:textfield
				name="ledgerEngineer.a_project_code" cssStyle="width:100%" /></td>
			<td align="left" class="listtabletr11">工程项目名称：</td>
			<td align="left" class="listtabletr22"><s:textfield
				name="lledgerEngineer.w_project_name" cssStyle="width:100%" /></td>
		</tr>
		<tr class="listtablehead">
			<td align="left" class="listtabletr11">施工单位：</td>
			<td align="left" class="listtabletr22"><s:textfield
				name="ledgerEngineer.contract_company" cssStyle="width:100%" /></td>
			<td align="left" class="listtabletr11">审计单位：</td>
			<td align="left" class="listtabletr22"><s:textfield
				name="ledgerEngineer.auditedDept" cssStyle="width:100%" /></td>
		</tr>
		<tr class="listtablehead">
			<td align="right" class="listtabletr1" colspan="4">
			<DIV align="right"><s:submit value="查询"
				cssStyle="width:100" /> 
				<s:button value="重置" cssStyle="width:100"
				onclick="resetButton();"></s:button></DIV>
			</td>
		</tr>
	</table>
</s:form> 
<display:table name="list" id="row"
	requestURI="${contextPath}/ledger/ledgerEngineer/list.action"
	class="its" pagesize="15">
	<display:column property="a_project_code" title="审计项目编号"
		sortable="true"></display:column>
	<display:column property="w_project_name" title="工程项目名称"
		sortable="true"></display:column>
	<display:column property="contract_company" title="施工单位" sortable="true"></display:column>
	<display:column property="auditedDept" title="审计单位" sortable="true"></display:column>

	<display:column title="审计项目投资总额" sortable="true">
		<fmt:formatNumber value="${row.w_invest_sum}" pattern="###,###.##"
			type="currency" minFractionDigits="2"></fmt:formatNumber>
	</display:column>

	<display:column title="送审金额" sortable="true">
		<fmt:formatNumber value="${row.deliver_money}" pattern="###,###.##"
			type="currency" minFractionDigits="2"></fmt:formatNumber>
	</display:column>

	<display:column title="审定金额" sortable="true">
		<fmt:formatNumber value="${row.shending_money}" pattern="###,###.##"
			type="currency" minFractionDigits="2"></fmt:formatNumber>
	</display:column>
	<display:column title="核减金额" sortable="true">
		<fmt:formatNumber value="${row.hejian_jine}" pattern="###,###.##"
				type="currency" minFractionDigits="2"></fmt:formatNumber>
	</display:column>
	<display:column property="hejian_ratio" title="核减率" sortable="true"></display:column>
	<display:column property="deliver_time" title="送审日期"
		sortable="true"></display:column>
		
	<display:column title="操作" headerClass="center" class="center">
		<a
			href="<s:url action="edit"><s:param name="id" value="'${row.id}'"/></s:url>">修改</a>&nbsp;&nbsp;
		<a href="javascript:void(0);" onclick="return deleteForm('${row.id}');">删除</a>&nbsp;&nbsp;
		<a
			href="<s:url action="view"><s:param name="id" value="'${row.id}'"/></s:url>"
			target="_blank">查看</a>&nbsp;&nbsp;
	</display:column>
</display:table> <br>
<br>
<input type="button" name="add" value="添加"
	onclick="javascript:window.location='<s:url action="edit"><s:param name="id" value="0"/></s:url>'">
</center>
</body>
</html>
