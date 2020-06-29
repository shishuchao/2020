<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head>					
		<title>培训信息详情</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="<c:url value='/styles/main/ais.css'/>" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<s:form>
			<table id="tableTitle" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" width="100%">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						审计人员培训信息查看
					</td>
				</tr>
			</table>
			<TABLE id="edu" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						培训项目
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:property value="employeeEducate.educateItem" />
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						培训类别
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:property value="employeeEducate.educateType" />
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD align=center class=ListTableTr1 width="20%" >
						培训机构
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:property value="employeeEducate.educateOrganization" />
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						培训期次
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:property value="employeeEducate.educateExpect" />
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >									
						开始时间
					</TD>
					<TD class=ListTableTr22  align="left">
						<s:property value="employeeEducate.beginDate" />
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						结束时间
					</TD>
					<TD class=ListTableTr22  align="left">
						<s:property value="employeeEducate.endDate" />
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						所获证书
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:property value="employeeEducate.certificate" />
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						培训考评
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:property value="employeeEducate.educateJudge" />
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 width="19%" >
						培训内容
					</TD>
					<TD class=ListTableTr2 colspan="3" align="left">
						<s:property value="employeeEducate.educateContent" />
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 width="19%" >
						备注
					</TD>
					<TD class=ListTableTr2 colspan="3" align="left">
						<s:property value="employeeEducate.remark" />
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						附件信息
					</td>
					<td class="ListTableTr2" colspan="3">
						<div id="accessoryFileList" align="center">
							<s:property escape="false" value="employeeEducateAccessories" />
						</div>
					</td>
				</tr>							
			</TABLE>
			<div align="center">
				<input type="hidden" name="employeeInfo.id" value="${employeeEducate.employeeInfoId }"/>
				<s:submit action="employeeEducateList" value="返回"/>
			</div>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
