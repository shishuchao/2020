<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<script type="text/javascript">
function deleteBudget(id,deptCode){
	if(confirm("请确认是否删除！")){
		window.location.href='${contextPath}/assist/baseInfo/baseInfoAction!deleteBudgetInfo.action?budgetInfo.id='+ id 
							+ '&deptCode='+ deptCode + '&status=1';
		return true;
	}else{
		return false;
	}
}
</script>
<body>
<CENTER>
	<display:table name="budgetList" id="row" requestURI="${contextPath}/assist/baseInfo/baseInfoAction!listBudgetInfo.action" class="its"
			pagesize="${baseHelper.pageSize}" partialList="true" 
			size="${baseHelper.totalRows}" sort="external"
			defaultsort="2" defaultorder="descending" >
			<display:column title="年度" property="year" sortable="true" sortName="year"></display:column>
			<display:column title="部门" property="deptName" sortable="true" sortName="deptName"></display:column>
			<display:column title="预算" property="budger" sortable="true" sortName="budger"></display:column>
			<display:column title="已使用" property="used" sortable="true" sortName="used"></display:column>
			<display:column title="使用率" property="useRate" sortable="true" sortName="useRate"></display:column>
			<display:column title="操作">
			<s:if test="${status == '1'}">
				<a href="javascript:void(0);" onclick="window.location.href='${contextPath}/assist/baseInfo/baseInfoAction!editBudgetInfo.action?budgetInfo.id=${row.id}&deptCode=${deptCode}&status=1'">修改</a>&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="return deleteBudget('${row.id}','${deptCode}')">删除</a>
			</s:if>
			<s:else>
				<a href="javascript:void(0);" onclick="window.location.href='${contextPath}/assist/baseInfo/baseInfoAction!editBudgetInfo.action?budgetInfo.id=${row.id}&deptCode=${deptCode}&status=2'">查看</a>
			</s:else>
			</display:column>
	</display:table>
	<s:if test="${status == '1'}">
		<br>
		<br>
		<s:button value="增加" onclick="window.location.href='${contextPath}/assist/baseInfo/baseInfoAction!editBudgetInfo.action?deptCode=${deptCode}&status=1'"></s:button>
	</s:if>
</CENTER>
</body>
</html>