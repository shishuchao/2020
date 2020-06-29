<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>LDAP同步情况</title>
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
				  <!--   <a class="easyui-linkbutton" href="javascript:void(0)" onclick="syncLdapOrgToOrg();">组织机构首次同步</a> -->
					<a class="easyui-linkbutton" href="javascript:void(0)" onclick="syncLdapUserToUser();">人员首次同步</a>
					<a class="easyui-linkbutton" href="javascript:void(0)" onclick="syncLdapOrgToAudit();">被审计单位首次同步</a>
					<a class="easyui-linkbutton" href="javascript:void(0)" onclick="syncZzjgToAudit();">被审计单位首次同步组织机构数据</a> 
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
			*	首次同步Ldap数据
			*/
			function syncLdapOrgToOrg(){
				window.location.href="/ais/ldap/syncLdapOrgToOrg.action";
			}
			/**
			*	人员首次同步Ldap数据
			*/
			function syncLdapUserToUser(){
				window.location.href="/ais/ldap/syncLdapUserToUser.action";
			}
			
			
			/**
			*	被审计单位首次同步Ldap数据
			*/
			function syncLdapOrgToAudit(){
				window.location.href="/ais/ldap/syncLdapOrgToAudit.action";
			}
			

			/**
			*	被审计单位首次同步组织机构数据
			*/
			function syncZzjgToAudit(){
				window.location.href="/ais/ldap/syncZzjgToAudit.action";
			}
			//此方法为测试方法测试跨域post请求
		/* 	function test(){
			 	/* $.ajax({
					url:'http://172.16.104.157:5656/api/OrgMS/GetOrgInfo',
					//async:false,
					type:'post',
					dataType: 'json',//dataType 是 jsonp 而不是 json jsonp不支持POST跨域，所以会自动给你转成GET
					//jsonp:"callback",  //Jquery生成验证参数的名称
					success:function(data) {
						alert(data);
						console.log(data);
					}
				});  */
				
				/*  $.post("http://172.16.104.157:5656/api/orgms/getorginfo", function (result) {
			            alert(result.Data[0].CorpName);
			     });   
			} */
			
			
		</script>
		
	</body>
</html>