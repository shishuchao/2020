<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>培训信息管理主页</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>	
	</head>
	<script type="text/javascript">
	function educateEdit(){
		var cbxs = document.getElementsByName("employeeEducate_ids");
		var cbx_count = 0;
		var cbx_no = -1;
		for(var i=0;i<cbxs.length;i++){
			if(cbxs[i].checked){
				cbx_count++;
				cbx_no = i;
			}
		}
		if(cbx_count>1){
			alert("不能同时修改多个培训信息！");
			return false;
		}
		if(cbx_no==-1){
			alert("没有选择要修改的培训信息!");
			return false;
		}
		document.forms[1].action="employeeEducateEdit.action";
		document.forms[1].submit();
	}
	function cleanForm(){
		document.getElementsByName("employeeEducate.educateItem")[0].value = "";
		document.getElementsByName("employeeEducate.educateTypeCode")[0].selectedIndex = -1;
		document.getElementsByName("employeeEducate.educateExpect")[0].value = "";
		document.getElementsByName("employeeEducate.educateOrganization")[0].value = "";
		
		document.forms[0].action="${contextPath}/mng/employee/employeeEducateSearch.action";
		document.forms[0].submit();
	}
	</script>
	<body>
		<s:form namespace="/mng/employee">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						培训项目
					</td>
					<TD class="listtabletr1">
						<s:textfield name="employeeEducate.educateItem" />
					</TD>
					<TD align="center" class="listtabletr1">
						培训类别
					</TD>
					<TD class="listtabletr1">
						<s:select name="employeeEducate.educateTypeCode" headerKey="" headerValue="" list="basicUtil.educateTypeList4Search" listKey="code" listValue="name"/>
					</TD>
				</tr>
				<tr class="listtablehead">
					<TD align="center" class="listtabletr1">
						培训期次
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="employeeEducate.educateExpect" />
					</TD>
					<TD class="listtabletr1">
						培训机构
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="employeeEducate.educateOrganization" />
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="4" align="right" class="listtabletr1">
						<div align="right">
							<s:submit action="employeeEducateSearch" value="查询"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:button value="重置" onclick="cleanForm()" />
						</div>
					</td>
				</tr>
			</TABLE>
			<s:hidden name="employeeInfo.id"/>
			<s:hidden name="listStatus"/>
		</s:form>
		<s:form namespace="/mng/employee" onsubmit="return delOrEdit('employeeEducate_ids','培训信息');">
			<display:table requestURI="${contextPath}/mng/employee/employeeEducateSearch.action" name="list" id="row" class="its" 
				pagesize="${baseHelper.pageSize}" partialList="true" 
				size="${baseHelper.totalRows}" sort="external"
				defaultsort="2" defaultorder="descending">
				<display:column>
					<s:if test="listStatus == 'edit'">
						<input type="checkbox" name="employeeEducate_ids" value="${row.id}">
					</s:if>	
				</display:column>
				<display:column title="培训项目" headerClass="center" sortable="true" sortName="educateItem">
					<a href="${contextPath}/mng/employee/employeeEducateView.action?employeeEducate.id=${row.id}&listStatus=${listStatus}">${row.educateItem}</a>
				</display:column>
				<display:column property="educateType" title="培训类别" headerClass="center" sortName="educateType" sortable="true" />
				<display:column property="educateOrganization" title="培训机构" headerClass="center" sortName="educateOrganization" sortable="true" />
				<display:column property="educateExpect" title="培训期次" headerClass="center" sortName="educateExpect" sortable="true" />
				<display:column property="beginDate" title="开始时间" sortName="beginDate" sortable="true" headerClass="center" class="center"/>
				<display:column property="endDate" title="结束时间" sortName="endDate" sortable="true" headerClass="center" class="center"/>
				<display:column property="educateJudge" title="培训考评" sortName="educateJudge" sortable="true" headerClass="center" class="center"/>
			</display:table>
			<s:if test="listStatus == 'edit'">
				<div align="right">
					<input type="button" value="增加" onclick="window.location.href='${contextPath}/mng/employee/employeeEducateAdd.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}'">
					&nbsp;&nbsp;
					<s:submit action="employeeEducateDelete" value="删除"/>
					&nbsp;&nbsp;
					<s:button onclick="educateEdit()" value="修改"/>
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeEducate_ids', true)" value="全选">
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeEducate_ids', false)" value="全不选">
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
