<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<html>
	<head>		
		<title>添加培训信息</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>		
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/deleteFile.js"></script>		
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript">
			function save(){
				if(frmCheck(document.forms[0],'edu')&&validateDate())
					document.forms[0].submit();	
			}
			
			function validateDate(){
				var begin = document.getElementById('employeeEducate.beginDate').value;
				var end = document.getElementById('employeeEducate.endDate').value;
				if(begin > end){
					alert('培训结束时间必须大于等于培训开始时间!');
					return false;
				}
				return true;
			}
			
	 		function deleteFile(fileId, guid, bool, appType){
	 			if(window.confirm("确认删除吗?")){
	 				send("${contextPath}/commons/file/delFile.action?fileId=" + fileId + "&&deletePermission=" + bool + "&&isEdit=false&&guid=" + guid + "&&appType=" + appType, guid);
	 			}
	 		}
	 		
			function Upload(id, filelist){
				var guid = document.getElementById(id).value;
				var num = Math.random();
				var rnm = Math.round(num * 9000000000 + 1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog("${contextPath}/commons/file/welcome.action?table_name=mng_employee_educate&table_guid=accessories&guid=" + guid + "&deletePermission=true&isEdit=false&param=" + rnm, filelist, "dialogWidth:700px;dialogHeight:450px;status:yes");
			}
		</script>
	</head>
	<body>
		<s:form action="employeeEducateSave" namespace="/mng/employee" method="post">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						审计人员培训信息添加
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
						<s:textfield name="employeeEducate.educateItem" size="33" maxlength="32"/>
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						培训类别
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:select name="employeeEducate.educateTypeCode" headerKey="" headerValue="" list="basicUtil.educateTypeList" listKey="code" listValue="name"/>
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD align=center class=ListTableTr1 width="20%" >
						培训机构
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:textfield name="employeeEducate.educateOrganization" size="33"  maxlength="100"/>
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						培训期次
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:textfield name="employeeEducate.educateExpect" size="33"  maxlength="30"/>
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >									
						培训开始时间
					</TD>
					<TD class=ListTableTr22  align="left">
						<s:textfield name="employeeEducate.beginDate" readonly="true" maxlength="10" title="单击选择日期" size="33" onclick="calendar()"></s:textfield>
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						培训结束时间
					</TD>
					<TD class=ListTableTr22  align="left">
						<s:textfield name="employeeEducate.endDate" readonly="true" maxlength="10" title="单击选择日期" size="33" onclick="calendar()"></s:textfield>
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						所获证书
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:textfield name="employeeEducate.certificate" size="33"  maxlength="50"/>
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						培训考评
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:textfield name="employeeEducate.educateJudge" size="33"  maxlength="100"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 width="19%" >
						培训内容
					</TD>
					<TD class=ListTableTr2 colspan="3" align="left">
						<s:textarea name="employeeEducate.educateContent" title="培训内容"></s:textarea>
						<input type="hidden" id="employeeEducate.educateContent.maxlength" value="2000">
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 width="19%" >
						备注
					</TD>
					<TD class=ListTableTr2 colspan="3" align="left">
						<s:textfield name="employeeEducate.remark" size="100"  maxlength="100"/>
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						<s:button onclick="Upload('employeeEducate.accessories', accessoriesList)" value="上传附件"></s:button>
						<s:hidden name="employeeEducate.accessories"/>
					</td>
					<td class="ListTableTr2" colspan="3">
						<div id="accessoriesList" align="center">
							<s:property escape="false" value="employeeEducateAccessoriesByDelete"/>	
						</div>
					</td>
				</tr>
			</table>		
			<div align="center">
				<input type="button" onclick="save()" value="保存"/>
				&nbsp;&nbsp;
				<s:button onclick="javascript:document.location='employeeEducateList.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}'" value="返回"/>
			</div>	
			<s:hidden name="employeeInfo.id"/>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
