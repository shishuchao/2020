<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>字段编辑</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript">
		</script>
	</head>
	<body class="easyui-layout">
			<div style="width: 100%; margin-top: 15px;">
				<div fit=true style="overflow: visibility;">
					<form action="<%=request.getContextPath()%>/bpm/tableField/saveOrUpdate.action" id="MyForm" method="post" onsubmit="return validateTableFieldName();">
						<s:token/>
						<table cellpadding=0 cellspacing=1 border=0 class="ListTable" width="100%" align="center">
						    <tr>
						        <td colspan="5" align="left" style="text-align:left" class="EditHead">
						            <div style="display: inline;width:80%;">
						                &nbsp;&nbsp;所属表单：<s:property value="%{bpmTable.name}" />
						            </div>
						        </td>
						    </tr>
						</table>						
						<table id="planTable" align="center" cellpadding=0 cellspacing=0 border=0 class="ListTable">
								<tr>
									<td class="EditHead">
										<font color="red">*</font>字段编号
									</td>
									<td class="editTd">
										<s:textfield cssClass="noborder" name="bpmTableField.code" size="50"></s:textfield>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										<font color="red">*</font>字段名称
									</td>
									<td class="editTd">
										<s:textfield cssClass="noborder" name="bpmTableField.name" size="50"></s:textfield>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										数据库对应字段名称
									</td>
									<td class="editTd">
										<s:textfield cssClass="noborder" name="bpmTableField.dbfield" size="50"></s:textfield>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										字段类型
									</td>
									<td class="editTd">
										<select  class="easyui-combobox" name="bpmTableField.type" style="width:160px;" editable="false" data-options="panelHeight:'auto'">
									       <s:iterator value="@ais.bpm.model.BpmTableField@findAllTableFieldList()" id="entry">
									       		<s:if test="${bpmTableField.type==entry}">
									       			<option selected="selected" value="${entry}">${entry }</option>
									       		</s:if>
									       		<s:else>
									       			<option value="${entry}">${entry }</option>
									       		</s:else>
									       </s:iterator>
									    </select> 	
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										字段描述
									</td>
									<td class="editTd">
										<s:textfield cssClass="noborder" name="bpmTableField.description" size="50"></s:textfield>
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										是否为人员字段
									</td>
									<td class="editTd">
										<s:checkboxlist name="bpmTableField.persons"
											list="#@java.util.LinkedHashMap@{'1':''}"></s:checkboxlist>
										说明：勾选即为人员字段
									</td>
								</tr>
								<tr>
									<td class="EditHead">
										是否不使用
									</td>
									<td class="editTd">
										<s:checkboxlist name="bpmTableField.used"
											list="#@java.util.LinkedHashMap@{'0':''}"></s:checkboxlist>
										说明：勾选即为不使用
									</td>
								</tr>
								<s:hidden name="bpmTableField.table_code"></s:hidden>
								<s:hidden name="bpmTableField.id"></s:hidden>
								<s:hidden name="bpmTable.name"></s:hidden>
							</div>
							<tr>
								<td class="EditHead" colspan="2">
									<div style="text-align:right;padding-right:8px;">
										<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="ToSave()" >保存</a>
									</div>
								</td>
							</tr>
						</table>
					</form>		
				</div>
			</div>
	</body>
	<script type="text/javascript">
		function validateTableFieldName()
		{
			var tableFieldCode=document.getElementsByName("bpmTableField.code")[0];
			var tableFieldName=document.getElementsByName("bpmTableField.name")[0];
			if(!new RegExp("^[a-zA-z]{1}[a-zA-z0-9_]*$").test(tableFieldCode.value))
			{
				showMessage1("字段编号必须以字母开头，且只能包含字母、数字、下划线！");
				tableFieldCode.focus();
				return false;
			}
			else if(tableFieldName.value=="")
			{
				showMessage1("字段名称不能为空！");
				tableFieldName.focus();
				return false;
			}
			return true;
		}
		function ToSave(){
			if(!validateTableFieldName()){
				return;
			}
			MyForm.submit();
			showMessage1('保存成功！');
		}
	</script>
</html>
