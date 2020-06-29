<!DOCTYPE HTML>
<%@ page language="java"  pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>法律法规</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<SCRIPT type="text/javascript">
			function mcheck() {
				var category_name = document.getElementsByName("assistSuportLawslibMenu.category_name")[0].value;
				var flag = true;
				if (document.getElementsByName('assistSuportLawslibMenu.category_name')[0].value == "") {
					showMessage1('名称不能为空！', '消息');
					return false;
				} else {
					$.ajax({
						type: "POST",
						async: false,
						url: "${contextPath}/pages/assist/suport/lawsLib/checkCategoryName.action?",
						data: {"categoryName": category_name, "parentId": "${nodeid}"},
						dataType: "text",
						success: function (data) {
							if (data == "1") {
								flag = false;
								showMessage1('类别名称重复', '消息', '4000');
							}

						}
					});
					if (!flag) {
						return false;
					}
				}
				var priority = document.getElementsByName("assistSuportLawslibMenu.priority")[0].value;
				if (priority != "" && !isDigit(priority)) {
					showMessage1('优先级只能是数字!', '消息');
					return false;
				}
				if (!$('#man_dept').val()) {
					showMessage1('所属单位不能为空', '消息');
					return false;
				}
				if (!$('#deptName').val()) {
					showMessage1('类别所属单位不能为空', '消息');
					return false;
				}
				return true;
			}

			//数字校验
			function isDigit(s) {
				var patrn = /^[0-9]{1,4}$/;
				if (!patrn.exec(s)) return false;
				return true;
			}

		</SCRIPT>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<s:form action="saveMenu" namespace="/pages/assist/suport/lawsLib" onsubmit="return mcheck()" id="save"
			method="post" theme="simple">
			<table style="width:100%;border:0" >
					<tr>
						<td>
							<span style="float:left;">
								 <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="exsitContent()">保存</a>&nbsp;&nbsp;
							  	 <a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="clearInfo()">重置</a>&nbsp;&nbsp;
							  	 <!-- <s:submit value="保存" align="center" onclick="return exsitContent()"></s:submit>-->
							</span>
						</td>
					</tr>
			</table>		
			<input type="hidden" name="assistSuportLawslibMenu.parentDeptId" value="${assistSuportLawslibMenu.parentDeptId}"/>
			<input type="hidden" name='assistSuportLawslibMenu.canView' value="1">	
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" width="150px">
						父节点名称 
					</td>
					<td class="editTd">
						<!--  
						<s:select  cssClass="easyui-combobox"   cssStyle="width:160px;" list="m_list" listKey="id" listValue="category_name"
							emptyOption="false" name="assistSuportLawslibMenu.parent_id"></s:select>
						-->	
				        <select  class="easyui-combobox" name="assistSuportLawslibMenu.parent_id" style="width:150px;" >
					       <option value="">&nbsp;</option>
					       <s:iterator value="m_list" id="entry">
					       		<s:if test="${id==nodeid}">
					       			<option selected="selected" value="<s:property value="id"/>"><s:property value="category_name"/></option>
					       		</s:if>
					       		<s:else>
						         	<option value="<s:property value="id"/>"><s:property value="category_name"/></option>
						        </s:else> 	
					       </s:iterator>
					    </select> 
						<br>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;类别名
					</td>
					<td class="editTd">
						<s:textfield  cssClass="noborder" cssStyle="width:160px;" name="assistSuportLawslibMenu.category_name" maxlength="40"></s:textfield>
						
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						创建人
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.create_man"></s:hidden>
						${assistSuportLawslibMenu.create_man}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						创建人所属单位
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.man_dept" id='man_dept'></s:hidden>
						${assistSuportLawslibMenu.man_dept}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;类别所属单位
					</td>
					<td class="editTd">
							<s:buttonText2 cssStyle="width:160px;" id="deptName" hiddenId="deptId"  cssClass="noborder"
								name="assistSuportLawslibMenu.deptName" 
								hiddenName="assistSuportLawslibMenu.deptId"
								doubleOnclick="showSysTree(this,{
		                                  title:'类别所属单位',
										  param:{
										  	'rootId':'${assistSuportLawslibMenu.parentDeptId}',
						                    'beanName':'UOrganizationTree',
						                    'treeId'  :'fid',
						                    'treeText':'fname',
						                    'treeParentId':'fpid',
						                    'treeOrder':'fcode'
						                 }                                  
								})"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:pointer;border:0"
								readonly="true" title="所属单位" maxlength="100"/>
						
						
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						创建日期
					</td>
					<td class="editTd">
						<s:hidden name="assistSuportLawslibMenu.create_date" value="${fn:substring(assistSuportLawslibMenu.create_date, 0, 10)}"></s:hidden>
						${assistSuportLawslibMenu.create_date}
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						优先级
					</td>
					<td class="editTd">
						<s:textfield  cssClass="noborder" cssStyle="width:160px;" name="assistSuportLawslibMenu.priority" maxlength="40"></s:textfield>
					</td>
				</tr>
			</table>
			<s:hidden name="nodeid" value="${nodeid}"></s:hidden>
			<s:hidden name="mCodeType" value="${mCodeType}"></s:hidden>
		</s:form>
		<script type="text/javascript">
			function clearInfo(){
				document.getElementById("save").reset();
			}
			function exsitContent(){
				/*
				if(mcheck()){document.getElementById("save").submit();}else{return false;}
				//parent.location.reload();
				window.setTimeout(function(){
					parent.loadParentTree('${nodeid}');					
				}, 200);
				*/
				$('#save').form('submit',{
					onSubmit: mcheck,
					success:function(data){
						window.setTimeout(function(){
							parent.loadParentTree('${nodeid}');					
						}, 200);
					}
				});
			
			} 
		</script>
	</body>
</html>