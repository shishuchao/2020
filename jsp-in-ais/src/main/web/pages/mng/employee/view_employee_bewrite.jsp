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
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						文章标题
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:property value="employeeBewrite.articleTitle"/>
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						文章类别
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:property value="employeeBewrite.articleType" />
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						指导人
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:property value="employeeBewrite.coachMan"/>
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						合著人
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:property value="employeeBewrite.joinWriteMan"/>
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						发表媒体
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:property value="employeeBewrite.appearMedia" />
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						发表日期									
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:property value="employeeBewrite.appearDate" />
					</TD>
				</TR>							
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%">
						所获奖项		
					</TD>
					<TD class=ListTableTr2 colspan="3" align="left">
						<s:property value="employeeBewrite.palm" />
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						附件信息
					</td>
					<td class="ListTableTr2" colspan="3">
						<div id="accessoryList" align="center">
							<s:property escape="false" value="employeeBewriteAccessories" />
						</div>
					</td>
				</tr>	
			</TABLE>
			<div align="center">
				<input type="hidden" name="employeeInfo.id" value="${employeeBewrite.employeeInfoId }"/>
				<s:submit action="employeeBewriteList" value="返回"/>
			</div>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
