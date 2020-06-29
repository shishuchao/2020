<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>EHR属性同步情况</title>
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
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ldap/orgSyncMid.action')"/>
				</td>
			</tr>
		</table>
		<table cellpadding=0 cellspacing=1 border=0
			 class="ListTable" align="center" style="width: 60%;">
			<tr >
				<td class="EditHead" style="text-align: center;" colspan="4" >
				    <a class="easyui-linkbutton" href="javascript:void(0)" onclick="syncEhrPropertyToBasic();">ehr属性同步</a>
				</td>
			</tr>
			<tr>
				<td id="consoleTd" class="EditHead" style="height: 400px;text-align: left;vertical-align: top;" colspan="4">
					<s:property escape="false"  value="message"/>
				</td>
			</tr>
		</table>
		
		<script type="text/javascript">
			
			/**
			*	同步ehr人才相关属性
			*/
			function syncEhrPropertyToBasic(){
				window.location.href="/ais/ldap/syncEhrPropertyDataToBasic.action";
			}
		</script>
		
	</body>
</html>