<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>组织机构同步情况</title>
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
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/unitary/nc/orgSyncMonitor.action')"/>
				</td>
			</tr>
		</table>
		<table cellpadding=0 cellspacing=1 border=0
			 class="ListTable" align="center" style="width: 60%;">
			<tr >
				<td class="EditHead" style="text-align: center;" colspan="4" >
				    <a class="easyui-linkbutton" iconCls="icon-tip" href="javascript:void(0)" onclick="toTestNCCorpCon()">测试大数据平台组织机构服务连通状态</a>
				    <a class="easyui-linkbutton" iconCls="icon-help" href="javascript:void(0)" onclick="toCompareOrg()">对比组织机构</a>
				</td>
			</tr>
			<tr >
				<td id="consoleTd" class="EditHead" style="height: 400px;text-align: left;vertical-align: top;" colspan="4">
					<s:property escape="false"  value="message"/>
				</td>
			</tr>
		</table>
		
		<script type="text/javascript">
			
			/**
			*	同步管理系统多出来的组织机构到大数据平台
			*/
			function syncOrgToNc(){
				window.location.href="/ais/unitary/nc/syncOrgToNc.action";
			}
		
			/**
			*	删除大数据平台中多余的组织机构
			*/
			function deleteUnSyncOrgInNc(){
				window.location.href="/ais/unitary/nc/deleteUnSyncOrgInNc.action";
			}
		
			/**
			*	测试组织机构服务是否连通
			*/
			function toTestNCCorpCon(){
				window.location.href="/ais/unitary/nc/testNCCorpCon.action";
			}
			
			/**
			*	对比大数据平台和管理系统的组织机构
			*/
			function toCompareOrg(){
				window.location.href="/ais/unitary/nc/compareOrg.action";
			}
			
		</script>
		
	</body>
</html>