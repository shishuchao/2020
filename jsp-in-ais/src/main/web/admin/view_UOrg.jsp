<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>查看组织机构</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript">
			//显示信息
		  	if ('' != '${ncError}') {
		  		showMessage1('${ncError}');
		  	}
		  	/* if ('${back}' == '') {
		  		showMessage1('保存成功！');
		  	} */
		</script>
	</head>
	<body>
	<div class="easyui-panel" title="详细信息" fit=true style="overflow: visibility ;">
		<table style="width:97%;border:0" >
				<tr>
					<td>
						<span style="float:right;">
							<s:if test="${view !='1' }">
								<s:if test="${not empty (uOrganization.fid)}">
									<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addTypett('');">增加</a>
									<a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="goToPage('editUOrg.action')">修改</a>
									<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="goToPage('delUOrg.action')">删除</a>
								</s:if>
							</s:if> 
						</span>
					</td>
				</tr>
			</table>
		<s:form id="myForm" action="saveUOrg" namespace="/admin" method="post" theme="simple">	
			<s:hidden name="m_type" value="${m_type}"></s:hidden>
			<s:hidden name="fpid" value="${fpid}"></s:hidden>
			<s:hidden name="m_str"/>
			<s:hidden name="uOrganization.fid" value="%{uOrganization.fid}"></s:hidden>
			<s:hidden name="uOrganization.fpid" value="%{uOrganization.fpid}"></s:hidden>
			<s:hidden name="uOrganization.ftype" value="%{uOrganization.ftype}"></s:hidden>
			<s:hidden name="uOrganization.orgType"/>		
			<table cellpadding=1 cellspacing=1 border=0  class="ListTable">
				<tr >
					<td class="EditHead"  style="width:100px;">
						编码
					</td>
					<td class="editTd"  style="width:200px" >
						<s:text    name="%{uOrganization.fcode}"></s:text>
					</td>
					<td class="EditHead" align="left" style="width:100px" >
						单位/部门名称 
					</td>
					<td class="editTd"  style="width:200px" >
						<s:text  name="%{uOrganization.fname}"></s:text>
					</td>
				</tr>
				<tr>
					<td class="EditHead"style="width:100px;">
						简称
					</td>
					<td class="editTd"style="width:200px">
						<s:text  name="%{uOrganization.flogogram}"></s:text>
					</td>
					<td class="EditHead"   style="width:100px;">
						英文名称
					</td>
					<td class="editTd"style="width:200px">
						<s:text  name="%{uOrganization.alias}"></s:text>
					</td>
				</tr>
				<tr >
				<td class="EditHead"style="width:100px;">
						部门负责人
					</td>
					<td class="editTd"style="width:200px">
						<s:text  name="%{uOrganization.fleader}"></s:text>
					</td>
					<td class="EditHead"style="width:100px;">
						电话
					</td>
					<td class="editTd"style="width:200px">
						<s:text  name="%{uOrganization.fphone}"></s:text>
					</td>
				</tr>
				<tr >
				<td class="EditHead"style="width:100px;">
						手机
					</td>
					<td class="editTd"style="width:200px">
						<s:text name="%{uOrganization.fmobile}"></s:text>
					</td>
					<td class="EditHead"style="width:100px;">
						传真
					</td>
					<td class="editTd"style="width:200px">
						<s:text name="%{uOrganization.ffax}"></s:text>
					</td>
				</tr>
				<tr >
					<td class="EditHead"style="width:100px;">
						单位性质
					</td>
					<td class="editTd" style="width:200px">
						<s:if test="${uOrganization.orgType=='1'}">
							审计部门
						</s:if>
						<s:else>
							非审计部门
						</s:else>
					</td>
					<td class="EditHead"style="width:100px;">
						是否作为管理层级
					</td>
					<td class="editTd" style="width:200px">
						<s:if test="${uOrganization.ftype=='C'}">是</s:if><s:else>否</s:else>
					</td>
				</tr>
				<tr >
					<td class="EditHead" style="width:100px;"colspan="1">所在城市</td>
					<td class="editTd" colspan="1" style="width:200px">
						<s:text  name="%{uOrganization.cityName}"></s:text>
					</td>
					<td class="EditHead" style="width:100px;">所属行业板块</td>
					<td class="editTd" style="width:200px;">
						<s:text name="%{uOrganization.tradePlateName}"></s:text>
					</td>
				</tr>
					<tr>
					<td class="EditHead" style="width:15%;" nowrap>机构级次</td>
					<td class="editTd" style="width:35%;">
						<s:text name="%{uOrganization.levelName}"></s:text>
					</td>
					<td class="EditHead">
						状态
					</td>
					<td class="editTd">
						<s:if test="${uOrganization.orgstate=='Y'}">启用</s:if><s:else>已删除</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						联系人
					</td>
					<td class="editTd" colspan="3">
						<s:text name="%{uOrganization.contactName}"></s:text>
					</td>
				</tr>
			</table>

		</s:form>  
		 </div>	
		<script type="text/javascript">
			${refresh}
			var jspAlert = '${jspAlert}';
			if(jspAlert !=null&&jspAlert == 'zx'){
				showMessage1("您在删除的选项中，有子选项，请先删除子选项!");
			}
			if(jspAlert!=null && jspAlert== 'ry'){
				showMessage1("该机构中还存在人员，请先删除里面的人员!");
			}
			function addTypett(s){
			/*if('${isEditOrg==false}'){
				window.parent.treeFreshFun();			
			}*/
			${refresh}
			 	myForm.m_type.value=s;
			 	myForm.fpid.value='${uOrganization.fid}';
			 	myForm.action='editUOrg.action';
			 	myForm.submit();
			 }
			 function cancel(s){
			 	myForm.action='cancel.action';
			 	document.getElementsByName('m_str')[0].value=s;
			 	myForm.submit();
			 }
			 function goToPage(s){
			 	if(s.indexOf("delUOrg") != -1){
			 		$.messager.confirm("确认","确定要删除吗？",function(result){
						if(result){
							myForm.action=s;
				 			myForm.submit();
						}
					})
			 	}else if(s.indexOf("editUOrg") != -1){
				 	myForm.action=s;
				 	myForm.submit();
			 	}
			 }
		</script>
	</body>
</html>
