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
						审计人员岗位资格信息查看
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">						
				<TR>
					<TD class=ListTableTr1  width="20%">
						是否具有任职资格证
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2>
						<s:property value="employeeCompetency.hasCompetencyCard"/>
					</TD>
				</TR>
				<TR>							
					<TD align=center class=ListTableTr11 >
						资格证编号
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:property value="employeeCompetency.competencyCardCode"/>
					</TD>
					</TR>
				<TR>
					<TD class=ListTableTr11 >
						颁发单位
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:property value="employeeCompetency.awardOrganize"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr11 >
						取得日期
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:property value="employeeCompetency.acquireDate"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr11 >
						年检日期
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:property value="employeeCompetency.checkDate"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr11 >
						年检结果
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:property value="employeeCompetency.checkResult"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr11 >
						备注
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:property value="employeeCompetency.remark"/>
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						附件信息
					</td>
					<td class="ListTableTr2">
						<div id="accessoryList" align="center">
							<s:property escape="false" value="employeeCompetencyAccessories" />
						</div>
					</td>
				</tr>
			</TABLE>
			<div align="center">		
				<input type=button value="返回" onclick="history.go(-1)">
			</div>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
