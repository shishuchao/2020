<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:text id="title" name="'添加流程定义'"></s:text>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	</head>

		<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" >
		<div region="center" >
			<s:form action="save" theme="simple" id="MyForm" namespace="/bpm/definition/nobpm">
				<table cellpadding=1 cellspacing=1 border=0 class="ListTable">
					<tr>
						<td class="EditHead" style="width: 100px">
							<font color="red">*</font>&nbsp;流程名称
						</td>
						<td class="editTd" style="width: 200px">
							<s:textfield  name="noBpmDefinition.name" cssClass="noborder" />
						</td>
						<td class="EditHead" >
							<font style="float: left;">
							<%-- 	<s:doubleselect doubleList="definitionMap[top]" 
									doubleListKey="code" firstName="选择业务对象"
									secondName="选择表单类型" doubleListValue="name" listKey="code"
									listValue="name" name="bpmDefinition.table_code"
									list="definitionMap.keySet()"
									doubleName="bpmDefinition.form_type" theme="ufaud_simple"
									templateDir="/strutsTemplate">
								</s:doubleselect> --%>
									<s:doubleselect doubleList="definitionMap[top]"
						doubleListKey="code" firstName="选择业务对象：" secondName="选择表单类型："
						doubleListValue="name" listKey="code" listValue="name"
						name="noBpmDefinition.table_code" list="definitionMap.keySet()"
						doubleName="noBpmDefinition.form_type" theme="ufaud_simple"
						templateDir="/strutsTemplate"></s:doubleselect>
							</font>	
						</td>
					</tr>
				</table>
				<s:hidden name="noBpmDefinition.id" />
			<%-- 	<s:hidden name="bpmDefinition.id" />
				<s:hidden name="bpmDefinition.name" />
				<s:hidden name="bpmDefinition.xml_webflow" />
				<s:hidden name="bpmDefinition.xml_jbpm" /> --%>
				<div style=" text-align:right;margin-top:15px;padding-right:15px;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onclick="ToSave()" >保存</a>&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"  onclick="toBack()">返回</a>
				</div>
			</s:form>
		</div>
<%-- 		<center>
		<s:actionmessage />
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
							<s:textfield name="noBpmDefinition.name" />
						</td>
					</tr>
					<s:doubleselect doubleList="definitionMap[top]"
						doubleListKey="code" firstName="选择业务对象：" secondName="选择表单类型："
						doubleListValue="name" listKey="code" listValue="name"
						name="noBpmDefinition.table_code" list="definitionMap.keySet()"
						doubleName="noBpmDefinition.form_type" theme="ufaud_simple"
						templateDir="/strutsTemplate"></s:doubleselect>
				</table>
				<s:hidden name="noBpmDefinition.id" />
				<s:submit value="保存" />
				<input type="button" name="back" value="返回"
					onclick="javascript:window.location='<s:url action="list" includeParams="none"></s:url>'">
			</s:form>

		</center> --%>
	</body>
		<script type="text/javascript">
		function ToSave(){
			var name = document.getElementsByName('noBpmDefinition.name')[0].value;
			if (name == "" || name == null){
				showMessage1('流程名称不能为空！');
				return false;
			}
			var MyForm = document.getElementById("MyForm");
			MyForm.submit();

		   }
			function toBack(){
				window.location.href="${contextPath}/bpm/definition/nobpm/list.action"
			}
		</script>
</html>
