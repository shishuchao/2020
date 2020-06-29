<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>	
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/deleteFile.js"></script>		
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript">	
			function save(){	
				if(frmCheck(document.forms[0],'tab1'))
					document.forms[0].submit();	
			}
			
	 		function deleteFile(fileId, guid, bool, appType){
	 			if(window.confirm("确认删除吗?")){
	 				send("${contextPath}/commons/file/delFile.action?fileId=" + fileId + "&&deletePermission=" + bool + "&&isEdit=false&&guid=" + guid + "&&appType=" + appType, guid);
	 			}
	 		}
	 		
			function Upload(id,filelist){
				var guid=document.getElementById(id).value;
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_employee_worksummary&table_guid=accessories&guid='+guid+'&deletePermission=true&isEdit=false&param='+rnm,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
		</script>
	</head>
	<body>
		<s:form action="employeeWorkSummarySave" namespace="/mng/employee">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						审计人员工作总结添加
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1  width="20%">
						标题
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2>
						<s:textfield name="employeeWorkSummary.summaryTitle" cssStyle="width:300px" maxlength="100"/>
					</TD>
				</TR>
				<TR>							
					<TD class=ListTableTr1 >
						总结类别
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:select name="employeeWorkSummary.summaryTypeCode" list="basicUtil.summaryTypeList" listKey="code" listValue="name" />
					</TD>
					</TR>
				<TR>
					<TD class=ListTableTr1 >
						提交日期
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="employeeWorkSummary.commitDate" readonly="true" maxlength="10" title="单击选择日期"  cssStyle="width:300px" onclick="calendar()"></s:textfield>
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						<s:button onclick="Upload('employeeWorkSummary.accessories', accessoriesList)" value="上传附件"></s:button>
						<s:hidden name="employeeWorkSummary.accessories"/>
					</td>
					<td class="ListTableTr2" colspan="3"><br>
						<div id="accessoriesList" align="center">
							<s:property escape="false" value="employeeWorkSummaryAccessoriesByDelete" />	
						</div>
					</td>
				</tr>
			</TABLE>
			<div align="center">			
				<input type="button" onclick="save()" value="保存" />
				&nbsp;&nbsp;
				<s:button onclick="document.location='employeeWorkSummaryList.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}'" value="返回"/>
			</div>
			<s:hidden name="employeeInfo.id"/>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
