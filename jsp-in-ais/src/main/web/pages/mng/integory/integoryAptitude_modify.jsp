<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<html>
	<head>
		<title>执业资质证书信息编辑</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>	
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/deleteFile.js"></script>							
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
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=INTEGORYAPTITUDE&table_guid=fjid&guid='+guid+'&deletePermission=true&isEdit=false&param='+rnm,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
		</script>
	</head>
	<body>
		<s:form action="updateAptitude" namespace="/resmngt/integory">
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						中介机构执业资质信息编辑
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1  width="20%">
						执业资质种类
						<font color="red">*</font>
					</TD>
					<TD class=ListTableTr2>
						<s:doubleselect id="aptitudeCode" doubleId="aptitudeCodeChild"
							doubleList="integoryMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="integoryAptitude.aptitudeCode" list="integoryMap.keySet()"
							doubleName="crudObject.aptitudeCodeChild" theme="ufaud_simple"
							templateDir="/strutsTemplate" emptyOption="false"></s:doubleselect>							
						<s:hidden name="integoryAptitude.integoryId"></s:hidden>
						<s:hidden name="integoryAptitude.id"></s:hidden>
					</TD>
				</TR>
				<TR>							
					<TD align=center class=ListTableTr1 >
						证书编号
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="integoryAptitude.code" cssStyle="width:300px" maxlength="100"/>
					</TD>
					</TR>
				<TR>
					<TD class=ListTableTr1 >
						颁发单位
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield  name="integoryAptitude.promulgateUnit" cssStyle="width:300px" maxlength="100"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 >
						取得日期
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="integoryAptitude.promulgateDate" readonly="true"
							 maxlength="20" title="单击选择日期"  cssStyle="width:300px" 
							 onclick="calendar()"></s:textfield>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 >
						年检日期
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="integoryAptitude.checkDate" readonly="true"
							 maxlength="20" title="单击选择日期"  cssStyle="width:300px" 
							 onclick="calendar()"></s:textfield>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 >
						年检结果
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="integoryAptitude.checkResult" cssStyle="width:300px" maxlength="100"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 >
						备注
					</TD>
					<TD class=ListTableTr2 align="left">
						<s:textfield name="integoryAptitude.remark" cssStyle="width:300px" maxlength="100"/>
					</TD>
				</TR>
				<tr>
					<td class="ListTableTr1">
						<s:button onclick="Upload('integoryAptitude.fjid', accessoriesList)" value="上传附件"></s:button>
						<s:hidden name="integoryAptitude.fjid"/>
					</td>
					<td class="ListTableTr2" colspan="3"><br>
						<div id="accessoriesList" align="center">
							<s:property escape="false" value="accessoryList" />	
						</div>
					</td>
				</tr>
			</TABLE>
			<div align="center">			
				<input type="button" onclick="save()" value="保存" />
				&nbsp;&nbsp;
				<s:submit action="integoryAptitude_List" value="返回"/>
			</div>
			<s:hidden name="integoryId"/>
		</s:form>
	</body>
</html>
