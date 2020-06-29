<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:if test="id == 0">
	<s:text id="title" name="'添加编号规则评细定义'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'修改编号规则评细定义'"></s:text>
</s:else>
<html>
<head>
	<title><s:property value="#title" /></title>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script language="javascript">
		$(function(){
			loadPage();
			resizePage();
			$('#toolbar').datagrid({
				toolbar:[{
						id:'searchObj',
						text:'保存',
						iconCls:'icon-save',
						handler:function(){
							 saveForm(); 
						}
					},
					{
						id:'addDoubt',
						text:'返回列表',
						iconCls:'icon-undo',
						handler:function(){
							backList();
						}
					}
				]
			});
			loadSelectH();
		});       
		function backList(){
			myform.action = "${contextPath}/code/ruledetail/codeRuleDetail/list.action";
			myform.submit();
		}

		//流水号
		function createCode(){
		  document.getElementsByName("codeRuleDetail.d_field_name")[0].value='流水号';
		}
		
		function saveForm(){
			var bool = true;//提交表单判断参数
			//保存表单
			if(bool){
				$.messager.confirm('提示信息', '您确定操作吗?', function(isFlag){
					if(isFlag){
						var url = "${contextPath}/code/ruledetail/codeRuleDetail/save.action";
						myform.action = url;
						myform.submit();
					}
				});
			}else{
			 	return false;
			}
		}
	</script>
</head>

<body>
	<div class="pageIndex">
		<div class="pageHeader">
			<table id="toolbar"></table>
		</div>
		<div class="pageContent" style="overflow:auto;">
			<s:form id="myform" action="save" namespace="/code/ruledetail/codeRuleDetail">
				<table cellpadding=0 cellspacing=0 border=0  class="talbeStyle" style="width: 100%">
					<tr>
						<td class="EditHead">编码段名</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield cssClass="noborder" name="codeRuleDetail.d_field_name" cssStyle="width:160px"/>
							<!--一般文本框-->
							<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="createCode()">流水号</a>&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td class="EditHead">值</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield cssClass="noborder" name="codeRuleDetail.d_field_value"
								cssStyle="width:160px"/>
							<!--一般文本框-->
						</td>
					</tr>
					<tr>
						<td class="EditHead">编码类型</td>
						<!--标题栏-->
						<td class="editTd">
							<select class="easyui-combobox" editable="false" name="codeRuleDetail.d_field_type" style="width:150px;" panelHeight='auto' >
						   	    <option value="">&nbsp;</option>
						      		<s:iterator value="#@java.util.LinkedHashMap@{'条件':'条件','取值':'取值'}" id="status">
										<s:if test="${codeRuleDetail.d_field_type==key}">
								       		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
								       	</s:if>
								       	<s:else>
								         <option value="<s:property value="key"/>"><s:property value="value"/></option>
										</s:else>
							      </s:iterator>
						    <select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">字段</td>
						<!--标题栏-->
						<td class="editTd">
							<select class="easyui-combobox" editable="false" name="codeRuleDetail.d_table_name" style="width:150px;" panelHeight='auto'>
						   	    <option value="">&nbsp;</option>
						      	<s:if test="${rule_id=='1'}">
							      	<s:iterator value="basicUtil.rszcCodeRuleProjectList" id="status">
										<s:if test="${codeRuleDetail.d_table_name==code}">
											<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								       	</s:if>
								       	<s:else>
								        	 <option value="<s:property value="code"/>"><s:property value="name"/></option>
										</s:else>
								    </s:iterator>
							    </s:if>
						      	<s:if test="${rule_id=='2'}">
							      	<s:iterator value="basicUtil.rszcCodeRuleScriptList" id="status">
										<s:if test="${codeRuleDetail.d_table_name==code}">
											<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								       	</s:if>
								       	<s:else>
								        	 <option value="<s:property value="code"/>"><s:property value="name"/></option>
										</s:else>
								    </s:iterator>
							    </s:if>
						      	<s:if test="${rule_id=='3'}">
							      	<s:iterator value="basicUtil.rszcCodeRuleProblemList" id="status">
										<s:if test="${codeRuleDetail.d_table_name==code}">
											<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
								       	</s:if>
								       	<s:else>
								        	 <option value="<s:property value="code"/>"><s:property value="name"/></option>
										</s:else>
								    </s:iterator>
							    </s:if>
						    </select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">函数</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="codeRuleDetail.d_function"
								cssStyle="width:160px"/>
							<!--一般文本框-->
						</td>
					</tr>
					<tr>
						<td class="EditHead">比较符</td>
						<!--标题栏-->
						<td class="editTd">
							<select editable="fasle" class="easyui-combobox" name="codeRuleDetail.d_comparesign" style="width:150px;" panelHeight='auto'>
						   	    <option value="">&nbsp;</option>
						      	<s:iterator value="#@java.util.LinkedHashMap@{'=':'等于','like':'包含'}">
									<s:if test="${codeRuleDetail.d_comparesign==code}">
							       		<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
							       	</s:if>
							       	<s:else>
							        	<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
							    </s:iterator>
						    <select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">比较值</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield cssClass="noborder" name="codeRuleDetail.d_compare_value"
								cssStyle="width:160px"/>
							<!--一般文本框-->
						</td>
					</tr>
					<tr>
						<td class="EditHead">测试值</td>
						<!--标题栏-->
						<td class="editTd" cssStyle="width:160px">
							<s:textfield  cssClass="noborder"  name="codeRuleDetail.test_value"
								cssStyle="width:160px" />
							<!--一般文本框-->
						</td>
					</tr>
					<tr>
						<td class="EditHead">位数</td>
						<!--标题栏-->
						<td class="editTd" >
							<s:textfield name="codeRuleDetail.d_digit" cssClass="noborder" cssStyle="width:160px" />
						</td>
					</tr>
				</table>
				<s:hidden name="codeRuleDetail.id" />
				<s:hidden name="rule_id" />
				<s:hidden name="isTZS" />
				<s:hidden name="isReadOnlyType" />
			</s:form>
		<div>
	<div>
</body>
</html>
