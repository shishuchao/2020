<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>用户同步情况</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 
			class="ListTable" width="100%" align="center">
			<tr class="">
				<td colspan="4" class="EditHead" style="text-align: left;width: 100%;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/unitary/nc/userSyncMonitor.action')"/>
				</td>
			</tr>
		</table>
		<table cellpadding=0 cellspacing=1 border=0
			 class="ListTable" align="center" style="width: 60%;">
			<tr class="">
				<td class="EditHead" style="text-align: center;" colspan="4" >
				    <a class="easyui-linkbutton" iconCls="icon-tip" href="javascript:void(0)" onclick="toTestNCUserCon()">测试大数据平台用户服务连通状态</a>
				    <a class="easyui-linkbutton" iconCls="icon-help" href="javascript:void(0)" onclick="toCompareUser()">对比用户信息</a>
				</td>
			</tr>
			<tr class="">
				<td id="consoleTd" class="EditHead" style="height: 400px;text-align: left;vertical-align: top;" colspan="4">
					<s:property escape="false"  value="message"/>
				</td>
			</tr>
		</table>
		
		<script type="text/javascript">
			
			/**
			*	同步管理系统多出来的用户到联网
			*/
			function syncUserToNc(){
				window.location.href="/ais/unitary/nc/syncUserToNc.action";
			}
		
			/**
			*	删除联网中多余的用户
			*/
			function deleteUnSyncUserInNc(){
				window.location.href="/ais/unitary/nc/deleteUnSyncUserInNc.action";
			}
		
			/**
			*	测试用户服务是否连通
			*/
			function toTestNCUserCon(){
				window.location.href="/ais/unitary/nc/testNCUserCon.action";
			}
			
			/**
			*	对比联网审计和管理系统的用户
			*/
			function toCompareUser(){
				window.location.href="/ais/unitary/nc/compareUser.action";
			}
			
		</script>
	</body>
</html>