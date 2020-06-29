<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<!-- edit_authRole.jsp -->
	<title>角色</title>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript">
		
		function myCheck(){
			<s:if test="${user.flevel!='super'}">
				var b = $("#roletemp").combo('getText').trim();
				$("input[name='authRole.fpname']").val(b);
				var s=document.getElementById('fpnameid').value;
				if(typeof(s) == 'undefined' || s == null || s == ""  || s.replace(/(^s*)|(s*$)/g, "").length < 2){
					showMessage2('角色模板选取为必填选项');
				return false;
				}
			</s:if>
			if(document.getElementsByName('authRole.fname')[0].value==""){
				showMessage2('角色名称为必填选项');
				document.getElementsByName('authRole.fname')[0].focus();
				return false;
			}
			var roleType = $("#roleType").combo('getText').trim();
			document.getElementsByName('authRole.fscopename')[0].value=roleType;
			var fscopenameid = document.getElementById('fscopenameid').value;
			if(typeof(fscopenameid) == 'undefined' || fscopenameid == null || fscopenameid == ""  || fscopenameid.replace(/(^s*)|(s*$)/g, "").length < 2){
				showMessage2('角色类型为必填选项');
				return false;
			}
			return true;
		}
		function cancel(){
			parent.closeWin('editPage');
		}
		function subsave(){
			if (!myCheck()) {
				return;
			}
			$.ajax({
				url:'${contextPath}/system/saveAuthRole.action',
				type:'POST',
				async:false,
				data:$('#formid').serialize(),
				success:function(data) {
					if(data == '1'){
						parent.reload();
						self.parent.$('#editPage').window('close');
					}else if(data == '0'){
						showMessage1('角色名称已经存在,请更换其它名称!');
					}
						
				}
			});
		}
		function reset(){
			resetForm('formid');
		}
	</script>
	<s:if test="${not empty(tip)}">
		<script>
			${tip}
		</script>
		<%
			request.setAttribute("tip", null);
		%>
	</s:if>
	<style>
	</style>
</head>
<body style="overflow:hidden;">
	<s:form id="formid" action="saveAuthRole" namespace="/system" method="post" theme="simple" cssStyle="margin-bottom:0px;">
		<s:hidden name="authRole.froleid" value="${authRole.froleid}"></s:hidden>
		<s:hidden name="authRole.fcompanyid" value="${authRole.fcompanyid}"></s:hidden>
		<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable_change" style="margin-bottom: 0px; padding">
			<s:if test="${user.flevel!='super'}">
				<tr>
					<td class="EditHead" style="width:30%;">
						<font color="red">*</font>&nbsp;角色模板选取
					</td>
					<td class="editTd" style="width:70%;">
						<select id="roletemp" name="authRole.fpid" class="easyui-combobox" panelHeight='auto'>
							<option value="">　</option>
							<s:iterator id="lists" value="moduleRoleList">
								<option value="<s:property value='#lists.froleid'/>"><s:property value='#lists.fname'/></option>
							</s:iterator>
						</select>
						<s:hidden name="authRole.fpname" id="fpnameid"></s:hidden>
					</td>
				</tr>
			</s:if>
			<s:else>
				<s:hidden name="authRole.fpid" value="0"></s:hidden>
				<s:hidden name="authRole.fpname" value=""></s:hidden>
			</s:else>
			<tr>
				<td class="EditHead">
					<font color="red">*</font>&nbsp;角色名称
				</td>
				<td class="editTd">
					<s:textfield name="authRole.fname" cssClass="noborder" maxlength="50"
						value="${organization.flogogram}"></s:textfield>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					<font color="red">*</font>&nbsp;角色类型
				</td>
				<td class="editTd">
					<select id="roleType" name="authRole.fscopecode" class="easyui-combobox" panelHeight='auto'>
						<option value="">　</option>
						<option value="mr">角色模板</option>
						<option value="br">业务角色</option>
						<option value="wr">管理角色</option>
					</select>
					<s:hidden name="authRole.fscopename" id="fscopenameid"></s:hidden>
				</td>
			</tr>
			<tr>
				<td class="EditHead">备注</td>
				<td class="editTd">
					<s:textfield name="authRole.fnote" value="${authRole.fnote}" cssClass="noborder" maxlength="50"></s:textfield>
				</td>
			</tr>
		</table>
		 <div class="search_btn">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="subsave()">保存</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-empty'" onclick="reset()">重置</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="cancel()">取消</a>
		</div>
	</s:form>
</body>
</html>