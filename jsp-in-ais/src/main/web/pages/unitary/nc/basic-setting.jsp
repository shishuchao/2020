<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>基本设置</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 
			class="ListTable" width="100%" align="center">
			<tr class="">
				<td colspan="4" class="EditHead" style="text-align: left;width: 100%;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/unitary/nc/basicSetting.action')"/>
				</td>
			</tr>
		</table>
		
		<s:form id="basicSettingForm" action="saveBasicSetting" name="basicSettingForm">
			<s:hidden id="status" name="unitaryNC.status"/>
			<table id="basicSettingTable" cellpadding=0 cellspacing=1 border=0
				 class="ListTable" align="center" style="width: 50%;">
				<tr class="">
					<td class="EditHead" nowrap="nowrap">
						<font color=red>*</font>&nbsp;查询分析系统
					</td>
					<td class="editTd">
						<s:if test="isEdit">
							<s:textfield id="host" name="unitaryNC.host" cssStyle="width:160px" maxlength="50" title="IP地址" />
						</s:if>
						<s:else>
							${unitaryNC.host}
							<s:hidden name="unitaryNC.host"/>
						</s:else>
					</td>
					<td class="EditHead" nowrap="nowrap">
						<font color=red>*</font>端口/应用(如 8080/yonyou)
					</td>
					<td class="editTd" >
						<s:if test="isEdit">
							<s:textfield id="port" name="unitaryNC.port"  maxlength="50" title="端口" />
						</s:if>
						<s:else>
							${unitaryNC.port}
							<s:hidden name="unitaryNC.port"/>
						</s:else>
					</td>
					<td class="EditHead" nowrap="nowrap">
						状态
					</td>
					<td class="editTd" >
						<s:if test="${unitaryNC.status=='Y'}">
							启用
						</s:if>
						<s:else>
							关闭
						</s:else>
					</td>
				</tr>
				<tr >
					<td class="EditHead" style="text-align: center;" colspan="6" >
					
						<s:if test="!isEdit">
						    <a class="easyui-linkbutton" iconCls="icon-edit" href="javascript:void(0)" onclick="toEdit()">编辑</a>
						</s:if>
						<s:else>
						    <a class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="toSave()">保存</a>
						    <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="toCancel()">取消</a>
						</s:else>
						<s:if test="!isEdit">
							<s:if test="${unitaryNC.status=='Y'}">
							    <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="toShutdown()">关闭</a>
							</s:if>
							<s:else>
								<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="toStartup()">启用</a>
							</s:else>
							<a class="easyui-linkbutton" iconCls="icon-tip" href="javascript:void(0)" onclick="toTestCon()">测试连通状态</a>
						</s:if>
						
					</td>
				</tr>
				<tr >
					<td id="consoleTd" class="EditHead" style="height: 400px;text-align: left;vertical-align: top;" colspan="6">
						<s:property escape="false"  value="message"/>
					</td>
				</tr>
			</table>
		</s:form>
		
		<script type="text/javascript">
			
			/**
			*	编辑页面
			*/
			function toEdit(){
				window.location.href="/ais/unitary/nc/basicSetting.action?isEdit=true";
			}
			
			/**
			* 	保存信息
			*/
			function toSave(){
				var host = document.getElementById('host').value;
				var port = document.getElementById('port').value;
				if(host=='' || port==''){
					alert('请输入必填项!');
					return false;
				}
				basicSettingForm.submit();
				return true;
			}
			
			/**
			*	取消编辑
			*/
			function toCancel(){
				window.location.href="/ais/unitary/nc/basicSetting.action";
			}
			
			/**
			*	禁用
			*/
			function toShutdown(){
				document.getElementById('status').value = 'N';
				document.getElementById('basicSettingForm').submit();
			}
			
			/**
			*	启用
			*/
			function toStartup(){
				document.getElementById('status').value = 'Y';
				document.getElementById('basicSettingForm').submit();
			}
			
			/**
			*	测试连接
			*/
			function toTestCon(){
				window.location.href="/ais/unitary/nc/testCon.action";
			}
			
		</script>
		
	</body>
</html>










