<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>岗位资格管理主页</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>	
	</head>
	<script type="text/javascript">
	function competencyEdit(){
		var cbxs = document.getElementsByName("employeeCompetency_ids");
		var cbx_count = 0;
		var cbx_no = -1;
		for(var i=0;i<cbxs.length;i++){
			if(cbxs[i].checked){
				cbx_count++;
				cbx_no = i;
			}
		}
		if(cbx_count>1){
			alert("不能同时修改多个任职资格信息！");
			return false;
		}
		if(cbx_no==-1){
			alert("没有选择要修改的任职资格!");
			return false;
		}
		document.forms[1].action="employeeCompetencyEdit.action";
		document.forms[1].submit();
	}
	//重置
	function relText(){
		document.getElementsByName("employeeCompetency.awardOrganize")[0].value="";
		document.getElementsByName("acquireDate1")[0].value="";
		document.getElementsByName("acquireDate2")[0].value="";
		
		document.forms[0].action="${contextPath}/mng/employee/employeeCompetencySearch.action";
		document.forms[0].submit();
	}
	</script>
	<body>
		<s:form namespace="/mng/employee">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						颁发单位
					</td>
					<TD class="listtabletr1">
						<s:textfield name="employeeCompetency.awardOrganize" />
					</TD>
					<TD align="center" class="listtabletr1">
						取得日期
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="acquireDate1" readonly="true" maxlength="20" title="单击选择日期" size="37" onclick="calendar()"></s:textfield>
						--<s:textfield name="acquireDate2" readonly="true" maxlength="20" title="单击选择日期" size="37" onclick="calendar()"></s:textfield>
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit action="employeeCompetencySearch" value="查询"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:button onclick="relText()" value="重置" />
						</div>
					</td>
				</tr>
			</TABLE>
			<s:hidden name="employeeInfo.id"/>
			<s:hidden name="listStatus"/>
		</s:form>
		<s:form namespace="/mng/employee" onsubmit="return delOrEdit('employeeCompetency_ids','岗位资格');">
			<display:table requestURI="${contextPath}/mng/employee/employeeCompetencySearch.action" name="list" id="row" class="its" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				defaultsort="2" defaultorder="descending">
				<display:column>
					<s:if test="listStatus == 'edit'">
						<input type="checkbox" name="employeeCompetency_ids" value="${row.id}">
					</s:if>
				</display:column>
				<display:column title="资格证号" sortName="competencyCardCode" sortable="true" headerClass="center">
					<a href="${contextPath}/mng/employee/employeeCompetencyView.action?employeeCompetency.id=${row.id}&listStatus=${listStatus}">${row.competencyCardCode}</a>
				</display:column>
				<display:column property="awardOrganize" title="颁发单位" sortName="awardOrganize" sortable="true" headerClass="center" class="center" />
				<display:column property="acquireDate" title="取得日期" sortName="acquireDate" sortable="true" headerClass="center" class="center" />
				<display:column property="checkDate" title="年检日期" sortName="checkDate" sortable="true" headerClass="center" class="center" />
				<display:column property="checkResult" title="年检结果" sortName="checkResult" sortable="true" headerClass="center" class="center" />
			</display:table>
			<s:if test="listStatus == 'edit'">
				<div align="right">
					<input type="button" value="增加" onclick="window.location.href='${contextPath}/mng/employee/employeeCompetencyAdd.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}'">
					&nbsp;&nbsp;
					<s:submit action="employeeCompetencyDelete" value="删除"/>
					&nbsp;&nbsp;
					<s:button onclick="competencyEdit()" value="修改" />
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeCompetency_ids', true)" value="全选">
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeCompetency_ids', false)" value="全不选">
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
