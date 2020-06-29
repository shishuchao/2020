<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>		
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<s:head theme="ajax" />
	</head>
	<body> 
		<s:form namespace="/mng/employee">
			<table id="tableTitle" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						审计人员其它信息编辑
					</td>
				</tr>
			</table>
			<s:tabbedPanel id='test' theme="ajax">
				<%--  
				<s:div id='one' label='培训信息' theme='ajax'>
					<iframe src="${contextPath}/mng/employee/employeeEducateList.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}" frameborder="0" width="100%" height="398"></iframe>
				</s:div>							
				<s:div id='two' label='撰文信息' theme='ajax'>
					<iframe src="${contextPath}/mng/employee/employeeBewriteList.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}" frameborder="0" width="100%" height="398"></iframe>
				</s:div>
				<s:div id='three' label='工作总结' theme='ajax'>
					<iframe src="${contextPath}/mng/employee/employeeWorkSummaryList.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}" frameborder="0" width="100%" height="398"></iframe>
				</s:div>
				--%>
				<s:div id='four' label='岗位资格' theme='ajax'>
					<iframe src="${contextPath}/mng/employee/employeeCompetencyList.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}" frameborder="0" width="100%" height="398"></iframe>
				</s:div>
			</s:tabbedPanel>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
