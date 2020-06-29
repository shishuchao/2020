<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<title>项目进度填报</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
<%--	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>--%>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>

</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" onresize="bodyResize();">
	<s:if test="${param.processCode != ''}">
	<div region="north" style="overflow: hidden;" border="0">
	</s:if>
	<s:else>
	<div region="center" border="0">
	</s:else>
		<div style="padding: 10px; border: 1px solid #cccccc; text-align: left; background-color: #FAFAFA;">项目进度填报
			<s:if test="${param.view ne 'view'}">
			<div style="float: right">
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm(0);">保存</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveForm(1);">提交</a>
			</div>
			</s:if>
		</div>
		<form id="editForm" action="saveProcessInfo.action" name="editForm" namespace="/project/process">
			<s:hidden name="projectProcessInfo.projectId" />
			<s:hidden name="projectProcessInfo.id" />
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="tab1">
				<tr>
					<td class="EditHead" style="width: 15%">
						项目名称
					</td>
					<td class="editTd" style="width: 35%">
						<s:property value="projectStartObject.project_name"/>
					</td>
					<td class="EditHead" style="width: 15%">
						项目编号
					</td>
					<td class="editTd" style="width: 35%">
						<s:property value="projectStartObject.project_code"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计单位
					</td>
					<td class="editTd">
						<s:property value="projectStartObject.audit_dept_name"/>
					</td>
					<td class="EditHead">
						被审计单位
					</td>
					<td class="editTd">
						<s:property value="projectStartObject.audit_object_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						项目类别
					</td>
					<td class="editTd" colspan="3">
						<s:property value="projectStartObject.pro_type_name"/>
					</td>
				</tr>
				<s:if test="${param.view eq 'view'}">
					<tr>
						<td class="EditHead">
							项目当前阶段
						</td>
						<td class="editTd">
							<s:property value="projectProcessInfo.processName"/>
						</td>
						<td class="EditHead">
							完成时间
						</td>
						<td class="editTd">
							<s:property value="projectProcessInfo.finishTime"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							项目进度说明
							<br/><div style="float: right;"><font color=DarkGray>(限1000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea name="projectProcessInfo.remarks" cssClass="noborder" readonly="true"
										cssStyle="width:99%;height:100px;overflow-y:visible;line-height:150%;" title="项目进度说明"/>
						</td>
					</tr>
				</s:if>
				<s:else>
					<tr>
						<td class="EditHead">
							<font color=red>*</font>项目当前阶段
						</td>
						<td class="editTd">
							<input type='hidden' id="processName" name="projectProcessInfo.processName"  class="noborder editElement clear" value="${projectProcessInfo.processName}"/>
							<select id="processCode" class="easyui-combobox" name="projectProcessInfo.processCode" editable="false" style="width:150px;" data-options="panelHeight:'auto'" >
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.projectProcessList" id="entry">
									<s:if test="${projectProcessInfo.processCode==code}">
										<option selected="selected" value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="code"/>"><s:property value="name"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
						<td class="EditHead">
							<div class="finishClass">
								<font color=red>*</font>完成时间
							</div>
						</td>
						<td class="editTd">
							<div class="finishClass">
								<input type="text" id="finishTime" name="projectProcessInfo.finishTime" value="${projectProcessInfo.finishTime}"
								   class="easyui-datebox" editable="false" style="width: 150px"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							项目进度说明
							<br/><div style="float: right;"><font color=DarkGray>(限1000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea id="remarks" name="projectProcessInfo.remarks" cssClass="noborder" onblur="doWhithTwo(this);"
										cssStyle="width:99%;height:100px;overflow-y:visible;line-height:150%;"/>
							<input type="hidden" id="projectProcessInfo.remarks.maxlength" value="1000"/>
						</td>
					</tr>
				</s:else>
				<tr>
					<td class="EditHead">
						录入人
					</td>
					<td class="editTd">
						<s:property value="projectProcessInfo.creator"/>
					</td>
					<td class="EditHead">
						录入时间
					</td>
					<td class="editTd">
						<s:property value="projectProcessInfo.createTime"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<s:if test="${param.processCode != ''}">
	<div region="center" border="0" style="margin-top: 10px; overflow: hidden;" id="mainDiv">
		<div style="padding: 10px; border: 1px solid #cccccc;  background-color: #FAFAFA;" id="capDiv">进度历史更新记录</div>
		<div id="frameDiv">
<%--			<table id="processList"></table>--%>
			<iframe width="100%" height="100%" frameborder="0" scrolling="no" id="listProcess" src=""></iframe>
		</div>
	</div>
	</s:if>

	<script>
		var finishCode = "<s:property value="@ais.project.ProjectContant@PROCESS_FINISH" />";
		function saveForm(isSubmit) {
            var processCode = $("#processCode").combobox('getValue');
            if (!processCode){
            	showMessage1('请选择项目阶段！');
            	return false;
			}

			if (processCode == finishCode){
				var finishTime = $('#finishTime').datebox('getValue');
				if (!finishTime){
					showMessage1('请输入完成时间！');
					return false;
				}
			}


			if (isSubmit==1 &&  $("#processCode").combobox('getValue') == finishCode){
				$.messager.confirm('确认','已完成阶段提交后将不能再次填报进度并且不可以系统交互，是否提交？',function(r){
					if(r){
						$.ajax ({
							type:'POST',
							url:"<%=request.getContextPath()%>/project/process/saveProcessInfo.action?isSubmit=" + isSubmit,
							data : $('#editForm').serialize(),
							dataType : 'json',
							success :function(data) {
								if (isSubmit == 1){
									if(data == true){
										showMessage1('提交成功！');
										var parentTabId = '${activeTabId}';
										var parentWin = aud$getTabIframByTabId(parentTabId);
										parentWin.$("#projectList").datagrid('reload');
										aud$closeTab();
									}else{
										$.messager.alert("提示信息","提交失败!","error");
									}
								}
							}
						})
					}
				});
			} else {
				$.ajax ({
					type:'POST',
					url:"<%=request.getContextPath()%>/project/process/saveProcessInfo.action?isSubmit=" + isSubmit,
					data : $('#editForm').serialize(),
					dataType : 'json',
					success :function(data) {
						if (isSubmit == 1){
							if(data == true){
								showMessage1('提交成功！');
								var parentTabId = '${activeTabId}';
								var parentWin = aud$getTabIframByTabId(parentTabId);
								parentWin.$("#projectList").datagrid('reload');
								aud$closeTab();
							}else{
							  $.messager.alert("提示信息","提交失败!","error");
							}
						}else {
							if(data == true){
								showMessage1('保存成功！');
								var parentTabId = '${activeTabId}';
								var parentWin = aud$getTabIframByTabId(parentTabId);
								parentWin.$("#projectList").datagrid('reload');
							}else{
								$.messager.alert("提示信息","保存失败!","error");
							}
						}
					}
				})
			}
        }

		function doWhithTwo(src){
			var tmp=src.value.length;
			if(tmp/1>1000){
				top.$.messager.show({
					title:'提示消息',
					msg:src.title+'输入不能大于1000字!',
					timeout:5000,
					showType:'slide'
				});
				src.value = src.value.substring(0, 1000);
				src.focus();
				return;
			}
		}

		function bodyResize() {
			setTimeout(function () {
				$('#frameDiv').height($('#mainDiv').height()-45);
			}, 100);
		}

		var datagrid;
		$(function () {
			//$('#frameDiv').height($('#mainDiv').height()-45);
			bodyResize();

			<s:if test="${param.view ne 'view'}">
				$('#processCode').combobox({
					onChange: function (newVal, oldVal) {
						if (newVal == finishCode) {
							$('.finishClass').show();
						} else {
							$('.finishClass').hide();
						}
					}
				});
				$("#processCode").combobox('setValue', $("#processCode").combobox('getValue'));

				if ($("#processCode").combobox('getValue') == finishCode) {
					$('.finishClass').show();
				} else {
					$('.finishClass').hide();
				}
			</s:if>

			if ($('#listProcess')){
				$('#listProcess').attr('src', '${contextPath}/project/process/getProcessList.action?projectId=${plan_form_id}');
			}
		})
	</script>
</body>
</html>
