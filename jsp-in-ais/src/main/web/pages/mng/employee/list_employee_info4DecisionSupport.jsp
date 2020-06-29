<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>审计人员基本信息列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script language="javascript">
			function wait(){
				document.getElementById("submitButton").disabled = true;
				document.getElementById("layer").style.display = "";
				document.getElementById("errorInfo1").style.display = "none";
				document.getElementById("errorInfo2").style.display = "none";
				importForm.submit();
			}
			
			function load(){
				window.location.href="${contextPath}/templatedownload?file=employee_template.xls&&type=employee";
			}
			
			function myReset(){
				document.getElementsByName("employeeInfo.incumbencyStateCode")[0].value = "";
				document.getElementsByName("employeeInfo.name")[0].value = "";
				document.getElementsByName("employeeInfo.diplomaCode")[0].value = "";
				document.getElementsByName("employeeInfo.technicalPostCode")[0].value = "";
				document.getElementsByName("employeeInfo.competenceCode")[0].value = "";
				document.getElementsByName("employeeInfo.company")[0].value = "";
				document.getElementsByName("employeeInfo.companyCode")[0].value = "";
				document.getElementsByName("employeeInfo.dutyCode")[0].value = "";
				document.getElementsByName("employeeInfo.typeCode")[0].value = "";
				document.getElementsByName("employeeInfo.specialityCode")[0].value = "";
			}
		</script>
	</head>
	<body>
		<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
			<tr class="listtablehead">
				<td colspan="4" align="left" class="edithead">
					<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/mng/employee/employeeInfoList4DecisionSupport.action')" />
				</td>
			</tr>
		</table>
		<s:form namespace="/mng/employee" action="employeeInfoSearch4DecisionSupport">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						在职状态
					</td>
					<TD class="listtabletr1">
						<s:select name="employeeInfo.incumbencyStateCode" headerKey="" headerValue="" list="basicUtil.incumbencyStateList4Search" listKey="code" listValue="name"/>
					</TD>
					<TD align="center" class="listtabletr1">
						姓名
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="employeeInfo.name" />
					</TD>
					<TD class="listtabletr1">
						学历
					</TD>
					<TD class="listtabletr1">
						<s:select name="employeeInfo.diplomaCode" headerKey="" headerValue="" list="basicUtil.diplomaList4Search" listKey="code" listValue="name"/>
					</TD>
				</tr>
				<tr class="listtablehead">
					<TD class="listtabletr1">
						职称级别
					</TD>
					<TD class="listtabletr1">
						<s:select name="employeeInfo.technicalPostCode" headerKey="" headerValue="" list="basicUtil.technicalPostList4Search" listKey="code" listValue="name"/>
					</TD>
					<TD class="listtabletr1">
						职业资格
					</TD>
					<TD class=listtabletr1>
						<s:select name="employeeInfo.competenceCode" headerKey="" headerValue="" list="basicUtil.competenceList4Search" listKey="code" listValue="name"/>
					</TD>
					<TD align="center" class="listtabletr1">
						所属单位
					</TD>
					<TD class="listtabletr1">
						<s:buttonText name="employeeInfo.company" hiddenName="employeeInfo.companyCode" cssStyle="width:80%" doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/system/uSystemAction!morgList.action&paraname=employeeInfo.company&paraid=employeeInfo.companyCode',600,350)" doubleSrc="/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
					</TD>
				</tr>
				<tr class="listtablehead">
					<TD class=listtabletr1>
						职务
					</TD>
					<TD class=listtabletr1>
						<s:select name="employeeInfo.dutyCode" headerKey="" headerValue="" list="basicUtil.dutyList4Search" listKey="code" listValue="name"/>
					</TD>
					<TD align=center class=listtabletr1>
						人员类型
					</TD>
					<TD class=listtabletr1>
						<s:select name="employeeInfo.typeCode" headerKey="" headerValue="" list="basicUtil.typeList4Search" listKey="code" listValue="name"/>
					</TD>
					<TD align=center class=listtabletr1>
						专业
					</TD>
					<TD class=listtabletr1>
						<s:select name="employeeInfo.specialityCode" headerKey="" headerValue="" list="basicUtil.specialtyList4Search" listKey="code" listValue="name"/>
					</TD>
				</TR>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit value="查询"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:button value="重置" onclick="myReset()"></s:button>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</TABLE>
			<s:hidden name="listStatus"/>
		</s:form>
		<s:form namespace="/mng/employee" onsubmit="return delOrEdit('employeeInfo_ids');">
			<center>
			<display:table requestURI="${contextPath}/mng/employee/employeeInfoSearch4DecisionSupport.action" name="list" id="row" class="its" pagesize="10" partialList="true" size="resultSize">
				<s:if test="${listStatus == 'edit'}">
					<display:column>
						<input type="checkbox" name="employeeInfo_ids" value="${row.id}">
					</display:column>
				</s:if>
				<display:column title="姓名" headerClass="center" sortable="true">
					<a href="${contextPath}/mng/employee/employeeInfoView4DecisionSupport.action?employeeInfo.id=${row.id}&listStatus=${listStatus}&src=1">${row.name}</a>
				</display:column>
				<display:column property="sex" title="性别" sortable="true" headerClass="center"/>
				<display:column property="type" title="人员类型" sortable="true" headerClass="center"/>
				<display:column property="graduateAcademy" title="毕业院校" headerClass="center" sortable="true"/>
				<display:column property="speciality" title="专业" sortable="true" headerClass="center"/>
				<display:column property="diploma" title="学历" sortable="true" headerClass="center"/>
				<display:column property="technicalPost" title="职称级别" headerClass="center" sortable="true"/>
				<display:column property="competence" title="执业资格" sortable="true" headerClass="center"/>
				<display:column property="company" title="所属单位" headerClass="center" sortable="true"/>
				<display:column property="duty" title="职务" headerClass="center" sortable="true"/>
				<display:column property="incumbencyState" title="在职状态" headerClass="center" sortable="true"/>
				<c:choose>
					<c:when test="${row.employeeType=='1'}">
						<display:column value="专职人员" sortName="employeeType" class="center" title="是否为专职人员" headerClass="center" sortable="true"/>
					</c:when>
					<c:otherwise>
						<display:column value="兼职人员" sortName="employeeType" class="center" title="是否为专职人员" headerClass="center" sortable="true"/>
					</c:otherwise>
				</c:choose>
			</display:table>
			<br>
			<s:if test="${listStatus == 'edit'}">
				<div align="right">
					<input type="button" value="增加" onclick="window.location.href='${contextPath}/mng/employee/employeeInfoAdd.action?listStatus=${listStatus}'">
					&nbsp;&nbsp;
					<s:submit onclick="return window.confirm('确认删除吗？')" action="employeeInfoDelete" value="删除"/>
					&nbsp;&nbsp;
					<s:submit action="employeeInfoEdit" value="修改"/>
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeInfo_ids', true)" value="全选">
					&nbsp;&nbsp;
					<input type="button" onclick="selall_inform('employeeInfo_ids', false)" value="反选">
					&nbsp;&nbsp;
				</div>
			</s:if>
			<s:hidden name="listStatus"/>
			</center>
		</s:form>
		<s:if test="${listStatus == 'edit'}">
			<s:form id="importForm" action="importEmployee"	namespace="/mng/employee" method="post"	enctype="multipart/form-data" onsubmit="wait();">
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable" align="center">
					<tr class="listtablehead">
						<td align="left" class="edithead" colspan="4">
							批量人员导入
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="left" class="listtabletr2">
							选择文件：
						</td>
						<td class="listtabletr2" align="right">
							<s:file name="template" size="66%" cssStyle="font-size:12px"/>
						</td>
						<td class="listtabletr2" align="right">
							<input type="button" value="下载模板" onclick="load()"/>
						</td>
						<td class="listtabletr2" align="right">
							<s:submit id="submitButton" value="导入审计人员"/>
						</td>
					</tr>
				</table>
				<s:hidden name="listStatus"/>
			</s:form>
			<div id="layer" style="display: none" align="center">
				<img src="${contextPath}/images/uploading.gif">
				<br>
				正在读取，请稍候......
			</div>
			<div align="left" id="errorInfo1">
				<s:if test="%{#tipList.size != 0}">
					<s:iterator value="%{#tipList}">
						&nbsp;&nbsp;&nbsp;●<s:property value="%{position}"/>：<s:property value="%{errorInfo}"/><br>
					</s:iterator>
				</s:if>
			</div>
			<div align="left" id="errorInfo2">
				<s:if test="%{#tipMessage != null}">
					&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}"/>
				</s:if>
			</div>
		</s:if>
	</body>
</html>
