<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>内控项目成员列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/gray/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/icon.css" type="text/css"></link>
	</head>
	<body>
		<s:form id="myForm" name="myForm" action="getlistMembers!introcontrolGetlistMembers.action" namespace="/project">
			<s:hidden name="crudId" />
			<input type="hidden" name="stage" id="stage">
			<div align="center">
				<div align="left" style="padding-left:20px">
			    <s:if test="${user_role eq '1' }">
			    	<a onclick="openAddMemberPage()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加内部审计人员</a>
			      	<a onclick="openAddOutMemberPage()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加外部审计人员</a>
			      	<a onclick="openModifyMemberPage()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">&nbsp;编&nbsp;&nbsp;&nbsp;辑</a>
			      	<a onclick="deleteMember()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">&nbsp;删&nbsp;&nbsp;&nbsp;除</a>
			    </s:if>
			      <a onclick="searchEmployee()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">人员搜索</a>
			      <a onclick="window.location.href='${contextPath}/project/getlistMembers!introcontrolGetlistMembers.action?crudId=${crudId}'" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">&nbsp;刷&nbsp;&nbsp;&nbsp;新</a>
			    </div>
			    <div  align="left">
			       <table cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center" >
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						&nbsp;&nbsp;<font style="font-weight:bold">项目组：</font><s:select name="group.groupName" list="#session.grouplist" listKey="groupName" listValue="groupName" headerKey="allGroup" headerValue="-------------全部分组------------"></s:select>&nbsp;&nbsp;
						<a onclick="doSearchGroup()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">&nbsp;过&nbsp;&nbsp;滤</a>
					</td>
				</tr>
			</table>
			    </div>
				<display:table id="member" name="members" pagesize="7" class="its" requestURI="${contextPath}/project/getlistMembers!introcontrolGetlistMembers.action">
					<display:column title="选择" headerClass="center" class="center">
						<s:if test="${member.isOutSystem=='Y' }">
							<input name="memberCheckBox" id="Y" type="checkbox" value="${member.proMemberId}" onclick="changeMemberButtonState(this,'${member.isAddByPlan}','${member.isOutSystem}')"/>
						</s:if>
						<s:else>
							<input name="memberCheckBox" id="${member.role}" type="checkbox" value="${member.proMemberId}" onclick="changeMemberButtonState(this,'${member.isAddByPlan}','${member.isOutSystem}')"/>
						</s:else>
						
					</display:column>
					<display:column property="group.groupTypeName" title="分组类型" headerClass="center" class="center" style="WHITE-SPACE: nowrap"/>
					<display:column property="group.groupName" title="分组名称" headerClass="center" class="center" style="WHITE-SPACE: nowrap" />
					<display:column property="userName" title="姓名" headerClass="center" class="center" style="WHITE-SPACE: nowrap"  />
					<display:column property="roleName" title="项目角色" headerClass="center" class="center" style="WHITE-SPACE: nowrap"   />
					<display:column title="所属单位" headerClass="center" class="center" style="WHITE-SPACE: nowrap"  >
						<s:if test="${member.isOutSystem=='Y'}">
							外部审计人员
						</s:if>
						<s:else>
							${member.belongToUnitName}
						</s:else>
					</display:column>
					<display:column property="sex" title="性别" headerClass="center" class="center" style="WHITE-SPACE: nowrap"/>
					<display:column property="birthday" title="出生日期" headerClass="center" class="center" style="WHITE-SPACE: nowrap"/>
					<display:column property="years" title="参加内控测试年度" headerClass="center" class="center" style="WHITE-SPACE: nowrap" />
					<display:column property="mobileTelephone" title="手机号" headerClass="center" class="center" style="WHITE-SPACE: nowrap" />
					<display:setProperty name="paging.banner.placement" value="bottom" />
				</display:table>
				<br/>
			</div>
		</s:form>
		<script type="text/javascript">
			/*
			* 导出成员
			*/
			function exportM(){
				document.getElementById('myForm').action='${contextPath}/project/exportMembers.action';
				document.getElementById('myForm').submit();
			}
			/**
			*	打开增加外部用户页面
			*/
			function openAddOutSystemMemberPage(){
				window.location.href = '${contextPath}/project/editMember.action?crudId=${crudId}&addMemberOption=outSystem';
			}
			
			/**
				打开添加组员页面
			*/
			function openAddMemberPage(){
			  	window.location.href = '${contextPath}/project/editMember!introcontrolEditMember.action?crudId=${crudId}';
			}
			/**
			打开外部审计组员页面
			*/
			function openAddOutMemberPage(){
			  	window.location.href = '${contextPath}/project/editOutMember.action?crudId=${crudId}&addMemberOption=outSystem';
			}
			/**
				打开检索内部审计人员页面
			*/
			function searchEmployee(){
			  	window.location.href = '${contextPath}/mng/employee/searchEmployee!introcontrolSearchEmployee.action?crudId=${crudId}';
			}

			/**
				删除组员
			*/
			function deleteMember(){
				var ids = document.getElementsByName("memberCheckBox");
				var flag = false;
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						flag = true;
						if(ids[i].id == "zuzhang"){
						   alert("整体组长不能删除！");
						   return;
						}
						if(confirm('确定要删除选定的项目成员吗？')){
							window.location.href="${contextPath}/project/deleteMember!introcontrolDeleteMember.action?crudId=${crudId}&&proMemberId="+ids[i].value;
						}
						break;
					}
				}
				if(!flag){
					alert("请选择要删除的项目成员！");
					return;
				}
			}
			
			/**
				打开修改组员信息页面
			*/
			function openModifyMemberPage(){
				var ids = document.getElementsByName("memberCheckBox");
				var flag = false;
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked==true){
						flag = true;
						var memberId = ids[i].value;
						if(ids[i].id == "Y"){
							alert("外部审计人员只能删除,不能被修改,谢谢！");
							   $("#"+ids[i].id).attr("checked",false);
							   return false;
						}else{
							if(ids[i].id == "zuzhang"){
							   alert("整体项目组长不能被修改！");
							   $("#"+ids[i].id).attr("checked",false);
							   return false;
							}else{
							window.location.href = '${contextPath}/project/editMember!introcontrolEditMember.action?crudId=${crudId}&&proMemberId='+memberId;
							}
							break;
						}
						
					}
				}
				
				if(!flag){
					alert("请选择要修改的项目成员！");
					return;
				}
			}
			
			/*
				改变底部按钮状态
			*/
			function changeMemberButtonState(checkbox,isAddByPlan,isOutSystem){
				if(checkbox.checked){
					var ids = document.getElementsByName("memberCheckBox");
					for(var i=0;i<ids.length;i++){
						if(ids[i].checked && checkbox.value != ids[i].value){
							ids[i].checked=false;
						}
					}
				}
				var deleteButton = document.getElementById('deleteMemberButton');
				var modifyButton = document.getElementById('modifyMemberButton');
				
				deleteButton.disabled=true;
				modifyButton.disabled=true;
				
				if((isAddByPlan!='Y' && checkbox.checked)||(!checkbox.checked)){
					deleteButton.disabled=false;
					if(isOutSystem!='Y'){//外部用户不允许修改,只允许新增和删除
						modifyButton.disabled=false;
					}
				}
				
			}
			
			//检索分组
			function doSearchGroup(){
			  var stageValue = '<s:property value="#request.stage"/>';
			  var stage = document.getElementById('stage');
			  var myForm = document.getElementById('myForm');
			  if("impl" == stageValue){
			     stage.value = "impl";
			  }else{
			     stage.value = "";
			  }
			  myForm.submit();
			}
		</script>
	</body>
</html>