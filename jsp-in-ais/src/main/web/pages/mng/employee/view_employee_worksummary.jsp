<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<s:form>
			<table id="tableTitle" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						审计人员撰文信息查看
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">						
				<TR>
					<TD class=ListTableTr1 width="19%" height="26">
						标题
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:property value="employeeWorkSummary.summaryTitle" />
					</TD>
				</TR>
				<TR>							
					<TD align=center class=ListTableTr1 width="19%" height="26">
						总结类别
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2  height="26" align="left">
						<s:property value="employeeWorkSummary.summaryType" />
					</TD>
				</TR>
				<TR>	
					<TD class=ListTableTr1 width="19%" height="26">
						提交日期
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:property value="employeeWorkSummary.commitDate" />
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						附件信息
					</td>
					<td class="ListTableTr2" >
						<div id="summaryAccessoryList" align="center">
							<s:property escape="false" value="employeeWorkSummaryAccessories" />
						</div>
					</td>
				</tr>
			</TABLE>
			<div align="center">
				<input type="hidden" name="employeeInfo.id" value="${employeeWorkSummary.employeeInfoId }"/>
				<s:submit action="employeeWorkSummaryList" value="返回"/>		
			</div>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
