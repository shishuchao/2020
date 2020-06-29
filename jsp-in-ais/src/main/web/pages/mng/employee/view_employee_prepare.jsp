<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>审计人员基本信息查看</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<s:head theme="ajax" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript">
			function onBodyLoad() {
				if ("${ul}" != "" && "${employeeInfo2.id}" == "") {
					window.parent.$.messager.show({
						title:'消息',
						msg:'不存在该审计人员信息！'
					});
				}
			}
			function backDataList(){
					document.forms[0].action="employeeInfoList4Dept.action";
					document.forms[0].submit();
			}
		</script>
	</head>
	<body onload="onBodyLoad()" style="margin: 0;padding: 0;overflow:auto;" class="easyui-layout">
	
			<s:if test="${empty(requestScope.ul)}">
				<s:form>
					<div style="text-align:left;padding:5px;">
						<s:form action="" namespace="/mng/employee">
						<s:hidden name="employeeInfo.company"></s:hidden>
						<s:hidden name="employeeInfo.companyCode"></s:hidden>
						<s:hidden name="employeeInfo.name"></s:hidden>
						<s:hidden name="employeeInfo.diplomaCode"></s:hidden>
						<s:hidden name="employeeInfo.technicalPostCode"></s:hidden>
						<s:hidden name="employeeInfo.specialityCode"></s:hidden>
						<s:hidden name="employeeInfo.dutyCode"></s:hidden>
						<s:hidden name="employeeInfo.competenceCode"></s:hidden>
						<s:hidden name="employeeInfo.beginWorkDate1"></s:hidden>
						<s:hidden name="employeeInfo.beginWorkDate2"></s:hidden>
						<s:hidden name="employeeInfo.birthday1"></s:hidden>
						<s:hidden name="employeeInfo.birthday2"></s:hidden>
						<s:hidden name="employeeInfo.typeCode"></s:hidden>
						<input type="hidden" name="listStatus" id="listStatus" value="${listStatus}">
						</s:form>
					</div>
				</s:form>
			</s:if>
			<s:div id='one' label='基本信息' theme='ajax' labelposition='top'>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="tableTitle">
					<tr>
						<td colspan="4" align="left" class="EditHead">
							<font style="float: left;">基本信息</font>
							<div align="right">
							</div>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead width="15%">
							是否为外部审计人才
						</td>
						<td class="editTd" width="400px" align="left">
							<s:property value="employeeInfo2.isSysAccounts"/>
							<s:hidden id="isSysAccounts" name="employeeInfo2.isSysAccounts"/>
						</td>
						<td nowrap class=EditHead>
							系统账号
						</td>
						<td class=editTd align="left">
							<div id="sysacc">
								<s:property value="employeeInfo2.sysAccounts"/>
								<s:hidden id="sysAccounts" name="employeeInfo2.sysAccounts"/>
							</div>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							姓名
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.name"/>
						</td>
						<td nowrap class=EditHead>排序编号</td>
						<td class="editTd">
							<s:property value="employeeInfo2.orderNo" id="orderNo"/>
						</td>
					</tr>

					<tr>
						<td class=EditHead>
							所属单位/部门
						</td>
						<td class="editTd" align="left">
							<s:textfield disabled="true" name="employeeInfo2.company" id="company"/>
						</td>
						<td nowrap class=EditHead>
							工号
						</td>
						<td class="editTd" align="left">
							<s:property value="employeeInfo2.personnelCode" id="personnelCode"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							出生日期
						</td>
						<td class="editTd" align="left">
							<input type="text" id="employeeInfoBorn" editable="false" disabled class="easyui-datebox noborder" style="width:150px;" value="${employeeInfo2.birthday}"/>
						</td>
						<td nowrap class=EditHead>
							性别
						</td>
						<td class="editTd" align="left">
							<s:textfield disabled="true" name="employeeInfo2.sex" id="employeeInfoSex"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							籍贯
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.nativePlaceName" id="nativePlaceName"/>
						</td>
						<td nowrap class=EditHead>
							婚姻状况
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.married" id="married"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							民族
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.nation" id="nation"/>
						</td>
						<td nowrap class=EditHead>
							政治面貌
						</td>
						<td class=editTd>
							<s:property value="employeeInfo2.polityVisage" id="polityVisage"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							人员类型
						</td>
						<td class="editTd" align="left">
							<s:property value="employeeInfo2.type"/>
						</td>
						<td nowrap class=EditHead>
							职称级别
						</td>
						<td id="zcTd" class=editTd align="left" nowrap="nowrap">
							<s:property value="employeeInfo2.technicalPost" id="technicalPost"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							职位
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.duty" id="duty"/>
						</td>
						<td nowrap class=EditHead>专业岗位</td>
						<td class="editTd">
							<s:property value="employeeInfo2.professionalPosition" id="professionalPosition"/>
						</td>
					</tr>

					<tr>
						<td class=EditHead>
							参加工作时间
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.graduateDate" id="graduateDate"/>
						</td>
						<td class="EditHead">
							入司时间
						</td>
						<td class="editTd">
							<s:property value="employeeInfo2.beginWorkDate" id="beginWorkDate"/>
						</td>
					</tr>

					<tr>
						<td class=EditHead>
							加入本公司审计部时间
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.entryTime" id="entryTime"/>
						</td>
						<td class="EditHead">
							内审从业起始时间
						</td>
						<td class="editTd">
							<s:property value="employeeInfo2.joinCorpDate" id="joinCorpDate"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							IT技能<FONT color="gray"><br/>(请着重说明数据分析能力与编程能力)</FONT>
						</td>
						<td class="editTd">
							<s:property value="employeeInfo2.itskill" id="itskill"/>
						</td>
						<td nowrap class=EditHead>精通领域</td>
						<td class="editTd">
							<s:property value="employeeInfo2.masterfield" id="masterfield"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							人员特长
						</td>
						<td class=editTd align="left">
							<s:if test="${employeeInfo2.strongPoint=='null' || employeeInfo2.strongPoint==null || employeeInfo2.strongPoint==''}"></s:if>
							<s:else>
								<s:property value="employeeInfo2.strongPoint"/>
							</s:else>
							<input type="hidden" id="strongPointCode" name="employeeInfo2.strongPointCode"/>
						</td>
						<td nowrap class=EditHead></td>
						<td class=editTd align="left"></td>
					</tr>

					<tr>
						<td class=EditHead>
							人员状态
						</td>
						<td class=editTd align="left">
							<s:textfield disabled="true" name="employeeInfo2.incumbencyState" id="incumbencyState"/>
						</td>
						<td class=EditHead>
							离职时间
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.dimissionDate" id="dimissionDate"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							座机
						</td>
						<td class=editTd align="left">
							<s:textfield disabled="true" name="employeeInfo2.officePhone" id="officePhone"/>
						</td>
						<td nowrap class=EditHead>
							手机
						</td>
						<td class=editTd align="left">
							<s:textfield disabled="true" name="employeeInfo2.mobileTelephone" id="mobileTelephone"/>
						</td>
					</tr>

					<tr>
						<td nowrap class=EditHead>
							电子邮箱
						</td>
						<td class=editTd align="left">
							<s:textfield disabled="true" name="employeeInfo2.email" id="email"/>
						</td>
						<td nowrap class=EditHead>岗位类别</td>
						<td class=editTd align="left">${employeeInfo2.postCategoryName }
						</td>
					</tr>
					<tr>
						<td nowrap class=EditHead>
							紧急联系人
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.emergency" id="emergency"/>
						</td>
						<td nowrap class=EditHead>
							紧急联系人电话
						</td>
						<td class=editTd align="left">
							<s:property value="employeeInfo2.emergencyPhone" id="emergencyPhone"/>
						</td>
					</tr>
				</table>
			</s:div>
	</body>
</html>
