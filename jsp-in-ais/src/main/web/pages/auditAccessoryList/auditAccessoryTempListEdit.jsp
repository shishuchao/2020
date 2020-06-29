<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
	<head>
		<base target="_self">
		<title>被审计单位资料清单</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	</head>
	
  <body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
  	<s:form id="AuditAccessoryTempList" action="saveAuditAccessoryTempList" namespace="/auditAccessoryList" onsubmit="return toSave()" method="post" >
		<input name="auditAccessoryTempList.aaid" type="hidden" value="${auditAccessoryTempList.aaid}"/>
		<input name="auditAccessoryTempList.templateID" type="hidden" value="${auditAccessoryTempList.templateID}"/>
		<input name="auditAccessoryTempId" type="hidden" value="${auditAccessoryTempList.templateID}"/>
		<div region="center">
		<table cellpadding="0" cellspacing="1" border="0" class="ListTable" align="center">
			<tr>
				<td class="EditHead" style="width:15%">
					<font color=red>*</font>&nbsp;
					资料清单
				</td>
				<td class="editTd" style="width:35%">
					<s:textfield id="auditProgram" name="auditAccessoryTempList.auditProgram" maxlength="100" cssStyle="width:160px;" cssClass="noborder"/>
				</td>
				<td class="EditHead" style="width:15%">
					<font color=red>*</font>&nbsp;
					是否必传
				</td>
				<td class="editTd" style="width:35%">
				   <select id="ifMust" class="easyui-combobox" editable="false" name="auditAccessoryTempList.needDo" style="width:160px;" panelHeight='auto' >
				       <option value="是" <s:if test="${auditAccessoryTempList.needDo == '是'}">selected="selected"</s:if>>是</option>
				       <option value="否" <s:if test="${auditAccessoryTempList.needDo == '否'}">selected="selected"</s:if>>否</option>
				    </select>
				</td>
			</tr>
			
		</table>
		</div>
		<div region="south" border="false" style="text-align:right;padding-right:20px;">
			<div style="display: inline;" align="right">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitF()">保存</a>
				&nbsp;&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="parent.$('#commonPage').window('close');">返回</a>
			</div>
		</div>
	</s:form>
	
	<script type="text/javascript">
		function toSave(){
		   var aatId="${auditAccessoryTempList.aaid}";
		   var aatName = $("#auditProgram").val();
		   if("" == aatName){
			   $.messager.show({title:'消息',msg:'资料清单名称不能为空！'});
			   return false;
		   }else{
			   return true;
		   }
		}
		function submitF(){
			$.messager.confirm('确认', '确定保存吗？', function(r){
				if (!r) return;
			   var boo = toSave();
			   if(!boo){
				   return;
			   }
	           document.getElementById('AuditAccessoryTempList').submit();
	           parent.$('#commonPage').window('close');
	           parent.$('#auditAccessoryTempTable').datagrid('reload');
	           showMessage1('保存成功!');
			});
		}
	</script>
	
  </body>
</html>
