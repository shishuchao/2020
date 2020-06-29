<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计项目同步情况</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="EditHead" style="text-align: left;width: 100%;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/unitary/nc/projectSyncMonitor.action')"/>
				</td>
			</tr>
		</table>
		<table cellpadding=0 cellspacing=1 border=0
			 class="ListTable" align="center" style="width: 60%;">
			<tr class="">
				<td class="EditHead" style="text-align: center;" colspan="4" >
				    <a class="easyui-linkbutton" iconCls="icon-tip" href="javascript:void(0)" onclick="toTestNCProjectCon()">测试大数据平台审计项目服务连通状态</a>
				    <a class="easyui-linkbutton" iconCls="icon-help" href="javascript:void(0)" onclick="toCompareProject()">对比审计项目</a>
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
			*	同步管理系统多出来的审计项目到联网
			*/
			function syncProjectToNc(projectStartFormId){
				window.location.href="/ais/unitary/nc/syncProjectToNc.action?projectStartFormId="+projectStartFormId;
			}
		
			/**
			*	测试审计项目服务是否连通
			*/
			function toTestNCProjectCon(){
				window.location.href="/ais/unitary/nc/testNCProjectCon.action";
			}
			
			/**
			*	对比联网审计和管理系统的审计项目
			*/
			function toCompareProject(){
				window.location.href="/ais/unitary/nc/compareProject.action";
			}
			
		</script>
			
	</body>
</html>