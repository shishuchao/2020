<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
		<title>内控项目小组列表</title>
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
	<body onload="refreshPermissionTab();" class="easyui-layout">
		<s:form action="listGroups!introcontrolListGroups.action" namespace="/project">
			<s:hidden name="crudId" />
			<div region="center" style="padding-left:10px;padding-top:10px">
			   <s:if test="#request.stage != 'impl'">
			    <a href="javascript:void(0)" onclick="openAddGroupPage()" id="addGroupButton" class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加</a>
				<a href="javascript:void(0)" onclick="openModifyGroupPage()" id="modifyGroupButton" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
				<a href="javascript:void(0)" onclick="deleteGroup()" id="deleteGroupButton" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
				<a href="javascript:window.location.href='${contextPath}/project/listGroups!introcontrolListGroups.action?crudId=${crudId}'" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</a>
			   </s:if>
				<display:table id="group" name="groups" pagesize="10"
						class="its" requestURI="${contextPath}/project/listGroups!introcontrolListGroups.action">
					<display:column title="选择" headerClass="center" style="WHITE-SPACE: nowrap" class="center">
						<input name="groupCheckBox" type="checkbox" id="${group.groupType}" value="${group.groupId}" />
					</display:column>
					<display:column property="groupName" title="组名" class="center" headerClass="center"  style="WHITE-SPACE: nowrap"/>
					<display:column property="area" title="所属片区"  class="center" headerClass="center"  style="WHITE-SPACE: nowrap" />
					<display:column property="auditObjectName" title="被审计单位" class="center" headerClass="center" />
					<display:column property="description" title="备注说明" headerClass="center" class="center"/>
					<display:setProperty name="paging.banner.placement" value="bottom" />
				</display:table>
			</div>
		</s:form>
		<script type="text/javascript">
		/**
		*	刷新组间授权的tab
		*/
		function refreshPermissionTab(){
			try{
				window.parent.frames['auditResultPermissionFrame'].location.reload();
			}catch(e){};
		}
		
		/**
			打开添加组页面
		*/
		function openAddGroupPage(){
			window.location.href = '${contextPath}/project/editGroup!introcontrolEditGroup.action?crudId=${crudId}';
		}
		
		/**
			打开修改指定组页面
		*/
		function openModifyGroupPage(){
			var ids = document.getElementsByName("groupCheckBox");
			var flag = false;
			for(var i=0;i<ids.length;i++){
				if(ids[i].checked==true){
				    if(ids[i].id == "zhengti"){
				       alert("整体组不能被修改！");
				       $("#"+ids[i].id).attr("checked",false);
				       return;
				    }
				
					flag = true;
					window.location.href = '${contextPath}/project/editGroup!introcontrolEditGroup.action?crudId=${crudId}&&groupId='+ids[i].value;
					break;
				}
			}
			if(!flag){
				alert("请选择要修改的项目小组！");
				return;
			}
		}
		
		/**
			删除选中的组
		*/
		function deleteGroup(){
			var ids = document.getElementsByName("groupCheckBox");
			var flag = false;
			for(var i=0;i<ids.length;i++){
				if(ids[i].checked==true){
				    if(ids[i].id == "zhengti"){
				       alert("整体组不能被删除！");
				       $("#"+ids[i].id).attr("checked",false);
				       return;
				    }
					flag = true;
					if(!isProGroupCanDelete(ids[i].value)){
						return false;
					}
					if(confirm('确定要删除选定的项目小组吗？')){
						window.location.href="${contextPath}/project/deleteGroup!introcontrolDeleteGroup.action?crudId=${crudId}&&groupId="+ids[i].value;
					}
					break;
				}
			}
			if(!flag){
				alert("请选择要删除的项目小组！");
				return;
			}
		}
		
		/**
		* 是否可以删除指定编号的组
		*/
		function isProGroupCanDelete(groupId){
			var result = 'YES';
			var messages = '';
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/members', action:'isProGroupCanDelete', executeResult:'false' }, 
				{'groupId':groupId},
				xxx);
			function xxx(data){
				result = data['isProGroupCanDelete'];
				messages = data['messages'];
			} 
			if(result=='YES'){
				return true;
			}else{
				alert(messages);
				return false;
			}
		}
		
	
		</script>
	</body>
</html>