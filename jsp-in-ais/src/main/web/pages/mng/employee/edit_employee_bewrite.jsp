<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>	
		<script type="text/javascript"
			src="${contextPath}/scripts/employeeValidate/deleteFile.js"></script>		
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
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_employee_bewrite&table_guid=accessories&guid='+guid+'&deletePermission=true&isEdit=false&param='+rnm,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
		</script>	
	</head>
	<body>			
		<s:form action="employeeBewriteUpdate" namespace="/mng/employee">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1
						class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						审计人员撰文信息修改
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1
						class=ListTable align="center">						
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						文章标题
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:textfield name="employeeBewrite.articleTitle" size="33" maxlength="100"/>
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						文章类别
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:select name="employeeBewrite.articleTypeCode" headerKey="" headerValue="" list="basicUtil.articleTypeList" listKey="code" listValue="name" />
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						指导人
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:textfield name="employeeBewrite.coachMan" size="33" maxlength="30"/>
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						合著人
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:textfield name="employeeBewrite.joinWriteMan" size="33" maxlength="30"/>
					</TD>
				</TR>
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%" >
						发表媒体
					</TD>
					<TD class=ListTableTr2 width="29%"  align="left">
						<s:select name="employeeBewrite.appearMediaCode" headerKey="" headerValue="" list="basicUtil.appearMediaList" listKey="code" listValue="name" />
					</TD>
					<TD align=center class=ListTableTr1 width="20%" >
						发表日期									
					</TD>
					<TD class=ListTableTr2 width="30%"  align="left">
						<s:textfield name="employeeBewrite.appearDate" readonly="true"
							 maxlength="10" title="单击选择日期"  size="33" 
							 onclick="calendar()"></s:textfield>
					</TD>
				</TR>							
				<TR class=ListTableTr1>
					<TD class=ListTableTr1 width="19%">
						所获奖项		
					</TD>
					<TD class=ListTableTr2 colspan="3" align="left">
						<s:textfield name="employeeBewrite.palm" size="33" maxlength="32"/>
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						<s:button onclick="Upload('employeeBewrite.accessories', accessoriesList)" value="上传附件"></s:button>
						<s:hidden name="employeeBewrite.accessories"/>
					</td>
					<td class="ListTableTr2" colspan="3">
						<div id="accessoriesList" align="center">
							<s:property escape="false" value="employeeBewriteAccessoriesByDelete"/>	
						</div>
					</td>
				</tr>		
			</TABLE>
			<div align="center">
				<input type="button" onclick="save()" value="保存"/>
				&nbsp;&nbsp;
				<s:button onclick="document.location='employeeBewriteList.action?employeeInfo.id=${employeeInfo.id}&listStatus=${listStatus}'" value="返回"/>
			</div>
			<s:hidden name="employeeInfo.id"/>
			<s:hidden name="employeeBewrite.id"/>
			<s:hidden name="listStatus"/>
		</s:form>
	</body>
</html>
