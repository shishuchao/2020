<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>审计人员基本信息查看</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css" />
		<s:head theme="ajax"/>
		<script type="text/javascript">
			function onBodyLoad(){
				if("${ul}"!=""&&"${employeeInfo.id}"==""){
					alert("不存在该审计人员信息!");
				}
			}
		</script>
	</head>
	<body onload="onBodyLoad()">
		<center>
				<table id="tableTitle" cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable" width="100%">
					<tr class="listtablehead">
						<td colspan="4" align="left" class="edithead">
							审计人员基本信息查看
						</td>
					</tr>
				</table>
					<s:div id='one' label='基本信息' theme='ajax' labelposition='top'>
						<TABLE id="tab1" class=ListTable >
							<TR>
								<TD class="ListTableTr11" width="10%" >
									姓名
									<FONT color=red>*</FONT>
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.name" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									人员编码
									<FONT color=red>*</FONT>
								</TD>
								<TD class="ListTableTr22" width="35%" align="left">
									<s:property value="employeeInfo.personnelCode" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									人员类型
									<FONT color=red>*</FONT>
								</TD>
								<TD class="ListTableTr22" width="35%" align="left">
									<s:property value="employeeInfo.type" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									身份证号
								</TD>
								<TD class="ListTableTr22" width="35%" align="left">
									<s:property value="employeeInfo.identityCard" />
								</TD>
							</tr>
							<tr>
								<TD class="ListTableTr11" width="10%" >
									性别asdsadsad
									<FONT color=red>*</FONT>
								</TD>
								<TD class="ListTableTr22" width="34%" align="left">
									<s:property value="employeeInfo.sex" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									出生日期
								</TD>
								<TD class="ListTableTr22" width="35%" align="left">
									<s:property value="employeeInfo.birthday" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									民族
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.nation" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									婚否
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.married" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									籍贯
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.nativePlace" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									政治面貌
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.polityVisage" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									毕业院校
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.graduateAcademy" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									专业
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.speciality" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									学历
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.diploma" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									毕业时间
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.graduateDate" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									职称级别
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.technicalPost" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									职业资格
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.competence" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									所属单位
									<FONT color=red id="_font1">*</FONT>
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.company" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									入职时间
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.beginWorkDate" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									是否离退休
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.isRetire" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									电子邮箱
								</TD>
								<TD class=ListTableTr22 width="35%" align="left" nowrap="nowrap">
									<s:property value="employeeInfo.email" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									职务
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.duty" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									手机
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.mobileTelephone" />
								</TD>
							</TR>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									是否为系统用户
									<FONT color=red>*</FONT>
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.isSysAccounts" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									办公电话
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.officePhone" />
								</TD>
							</tr>
							<TR>
								<TD class="ListTableTr11" width="10%" >
									系统帐号
								</TD>
								<TD class=ListTableTr22 width="35%" align="left" id="sysacc">
									<s:property value="employeeInfo.sysAccounts" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									离职时间
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.dimissionDate" />
								</TD>
							</tr>
							<tr>
								<TD class="ListTableTr11" width="10%" >
									调出时间
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.outDate" />
								</TD>
								<TD class="ListTableTr11" width="10%" >
									在职状态
									<FONT color=red>*</FONT>
								</TD>
								<TD class=ListTableTr22 width="35%" align="left">
									<s:property value="employeeInfo.incumbencyState" />
								</TD>
							</TR>
						</TABLE>
					</s:div>
					<%-- 
					<s:div id='two' label='培训信息' theme='ajax'>
						<iframe src="${contextPath}/mng/employee/employeeEducateList.action?employeeInfo.id=<s:property value="%{employeeInfo.id}"/>" frameborder="0" width="100%" height="398"></iframe>
					</s:div>
					<s:div id='three' label='撰文信息' theme='ajax'>
						<iframe src="${contextPath}/mng/employee/employeeBewriteList.action?employeeInfo.id=<s:property value="%{employeeInfo.id}"/>" frameborder="0" width="100%" height="398"></iframe>
					</s:div>
					<s:div id='four' label='工作总结' theme='ajax'>
						<iframe src="${contextPath}/mng/employee/employeeWorkSummaryList.action?employeeInfo.id=<s:property value="%{employeeInfo.id}"/>" frameborder="0" width="100%" height="398"></iframe>
					</s:div>
					
					<s:div id='five' label='岗位资格' theme='ajax'>
						<iframe src="${contextPath}/mng/employee/employeeCompetencyList.action?employeeInfo.id=<s:property value="%{employeeInfo.id}"/>" frameborder="0" width="100%" height="398"></iframe>
					</s:div>
					--%>
				<s:if test="${empty(requestScope.ul)}">
				<br>
				<s:form>

					<s:hidden name="listStatus"/>
				</s:form>
				</s:if>
		</center>
	</body>
</html>
