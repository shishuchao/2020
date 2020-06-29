<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:text id="title" name="'添加流程定义'"></s:text>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>

	<body>
		<center>
			<s:form action="save" theme="simple">
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="2" align="left" class="edithead">
							&nbsp;
							<s:property value="#title" />
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							流程名称
							<font color=red>*</font>
						</td>
						<td class="listtabletr2">
							<s:textfield name="bpmDefinition.name" />
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							业务对象
							<font color=red>*</font>
						</td>
						<td class="listtabletr2">
							<s:select name="bpmDefinition.table_code" list="bpmTableList"
								listKey="code" listValue="name" />
						</td>
					</tr>
					<tr>
						<td class="listtabletr1">
							表单类型
							<font color=red>*</font>
						</td>
						<td class="listtabletr2">
							<s:select name="bpmDefinition.form_type"
								list="@ais.bpm.util.FormTypeConstant@getFormTypeList()"
								listKey="code" listValue="name" />
						</td>
					</tr>

				</table>
				<s:hidden name="bpmDefinition.id" />
				<s:hidden name="bpmDefinition.xml_webflow" />
				<s:hidden name="bpmDefinition.xml_jbpm" />
				<s:submit value="保存" />
				<input type="button" name="back" value="返回"
					onclick="javascript:window.location='<s:url action="list_unpublished"></s:url>'">
			</s:form>

		</center>
	</body>
</html>
