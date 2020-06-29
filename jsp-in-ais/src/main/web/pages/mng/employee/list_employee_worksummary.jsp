<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>工作总结管理主页</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>	
	</head>
	<script type="text/javascript">
	function summaryEdit(){
		var cbxs = document.getElementsByName("employeeWorkSummary_ids");
		var cbx_count = 0;
		var cbx_no = -1;
		for(var i=0;i<cbxs.length;i++){
			if(cbxs[i].checked){
				cbx_count++;
				cbx_no = i;
			}
		}
		if(cbx_count>1){
			alert("不能同时修改多个工作总结！");
			return false;
		}
		if(cbx_no==-1){
			alert("没有选择要修改的工作总结!");
			return false;
		}
		document.forms[1].action="employeeWorkSummaryEdit.action";
		document.forms[1].submit();
	}
	//重置
	function cleanForm(){
		document.getElementsByName("employeeWorkSummary.summaryTitle")[0].value = "";
		document.getElementsByName("employeeWorkSummary.summaryTypeCode")[0].selectedIndex = -1;
		document.getElementsByName("commitDate1")[0].value = "";
		document.getElementsByName("commitDate2")[0].selectedIndex = -1;
		
		document.forms[0].action="${contextPath}/mng/employee/employeeWorkSummarySearch.action";
		document.forms[0].submit();
	}
	</script>
	<body>
		<s:form namespace="/mng/employee">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						标题
					</td>
					<TD class="listtabletr1">
						<s:textfield name="employeeWorkSummary.summaryTitle" cssStyle="width:200px;" />
					</TD>
					<TD align="center" class="listtabletr1">
						总结类型
					</TD>
					<TD class="listtabletr1">
						<s:select name="employeeWorkSummary.summaryTypeCode" cssStyle="width:100px;" headerKey="" headerValue="" list="basicUtil.summaryTypeList4Search" listKey="code" listValue="name"/>
					</TD>
					<TD class="listtabletr1">
						提交日期
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="commitDate1" readonly="true" cssStyle="width:100px;" maxlength="10" title="单击选择日期" size="10" onclick="calendar()"></s:textfield>
						--<s:textfield name="commitDate2" readonly="true" cssStyle="width:100px;" maxlength="10" title="单击选择日期" size="10" onclick="calendar()"></s:textfield>
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit action="employeeWorkSummarySearch" value="查询"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:button onclick="cleanForm()" value="重置" />
						</div>
					</td>
				</tr>
			</TABLE>
			<s:hidden name="employeeInfo.id"/>
			<s:hidden name="listStatus"/>
		</s:form>
		<s:form namespace="/mng/employee"
			onsubmit="return delOrEdit('employeeWorkSummary_ids','工作总结');">
			<display:table requestURI="${contextPath}/mng/employee/employeeWorkSummarySearch.action" name="list" id="row" class="its" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				defaultsort="2" defaultorder="descending" >
				<display:column>
					<s:if test="listStatus == 'edit'">
						<input type="checkbox" name="employeeWorkSummary_ids" value="${row.id}">
					</s:if>
				</display:column>
				<display:column title="标题" sortName="summaryTitle" sortable="true" headerClass="center">
					<a href="${contextPath}/mng/employee/employeeWorkSummaryView.action?employeeWorkSummary.id=${row.id}&listStatus=${listStatus}">${row.summaryTitle}</a>
				</display:column>
				<display:column property="summaryType" sortName="summaryType" title="总结类别" sortable="true" headerClass="center" />
				<display:column property="commitDate" sortName="commitDate" title="提交日期" sortable="true" headerClass="center" />
			</display:table>
			<s:if test="listStatus == 'edit'">
				<div align="right">
					<input type="button" value="增加" onclick="window.location.href='${contextPath}/mng/employee/employeeWorkSummaryAdd.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}'">
					&nbsp;&nbsp;
					<s:submit action="employeeWorkSummaryDelete" value="删除"/>
					&nbsp;&nbsp;
					<s:button onclick="summaryEdit()" value="修改" />
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeWorkSummary_ids', true)" value="全选">
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeWorkSummary_ids', false)" value="全不选">
					&nbsp;&nbsp;
					<input type="button" value="返回" onclick="parent.window.location='${contextPath}/mng/employee/employeeInfoList.action?listStatus=edit'">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</s:if>
			<s:hidden name="listStatus"/>
			<s:hidden name="employeeInfo.id"/>
		</s:form>
	</body>
</html>
