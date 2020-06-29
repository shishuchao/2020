<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<html>
	<head>
		<title>添加岗位资格信息</title>
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
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_employee_competency&table_guid=accessories&guid='+guid+'&deletePermission=true&isEdit=false&param='+rnm,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
		</script>
	</head>
	<body>
		<s:form action="employeeCompetencySave" namespace="/mng/employee">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						审计人员岗位资格信息添加
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<TR>							
					<TD align=center class=ListTableTr1 >
						是否有内审岗位资格
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:select name="employeeCompetency.hasCompetencyCard" listKey="key" listValue="value"
								list="#@java.util.LinkedHashMap@{'是':'是','不是':'不是'}" />
					</TD>
				</TR>
				
				<TR>							
					<TD align=center class=ListTableTr1 >
						资格证编号
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="employeeCompetency.competencyCardCode" cssStyle="width:300px" maxlength="100"/>
					</TD>
				</TR>
				
				<TR>
					<TD class=ListTableTr1 >
						颁发单位
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="employeeCompetency.awardOrganize" cssStyle="width:300px" maxlength="100"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 >
						取得日期
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="employeeCompetency.acquireDate" readonly="true"
							 maxlength="10" title="单击选择日期"  cssStyle="width:300px" 
							 onclick="calendar()"></s:textfield>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 >
						年检日期
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="employeeCompetency.checkDate" readonly="true"
							 maxlength="10" title="单击选择日期"  cssStyle="width:300px" 
							 onclick="calendar()"></s:textfield>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 >
						年检结果
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="employeeCompetency.checkResult" cssStyle="width:300px" maxlength="100"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 >
						备注
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="employeeCompetency.remark" cssStyle="width:300px" maxlength="100"/>
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						<s:button onclick="Upload('employeeCompetency.accessories', accessoriesList)" value="上传附件"></s:button>
						<s:hidden name="employeeCompetency.accessories"/>
					</td>
					<td class="ListTableTr2" colspan="3"><br>
						<div id="accessoriesList" align="center">
							<s:property escape="false" value="employeeCompetencyAccessoriesByDelete" />	
						</div>
					</td>
				</tr>
			</TABLE>
			<div align="center">			
				<input type="button" onclick="save()" value="保存" />
				&nbsp;&nbsp;
				<s:button onclick="document.location='employeeCompetencyList.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}'" value="返回"/>
			</div>
			<s:hidden name="employeeInfo.id"/>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
