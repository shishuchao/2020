<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>基本设置</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	</head>
	<body>
		
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/unitary/ais/basicSetting.action')"/>
				</td>
			</tr>
		</table>
		<s:form id="basicSettingForm" action="saveServerInfo" namespace="/unitary/ais" >
			<s:hidden id="localServerCode" name="localServerInfo.serverCode"/>
			<table id="basicSettingTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable" align="center" style="width: 60%;">
				<tr>
					<td class="ListTableTr11" nowrap="nowrap" style="text-align: left;">
						<br>
						<fieldset>
								<legend>本机服务器设置</legend>
								<br>
								是否启用管理一体化部署：
								<s:if test="${localServerInfo.localServerStatus=='Y'}">
									<s:button value="    是    "  onclick="setLocalStatus('N')"/>
								</s:if>
								<s:else>
									<s:button value="    否    "  onclick="setLocalStatus('Y')"/>
								</s:else>
								
								<font color="red" size="4">&nbsp;&nbsp;&nbsp;&nbsp;注意：此页面只能维护主服务器使用</font>
								<br>
								<br>
								<br>
						</fieldset>
						<br>
						<br>
						<fieldset>
							<legend>主服务器信息</legend>
							<br>
							服务器名称：<s:textfield id="topServerName" name="topServerInfo.serverName" maxlength="50" title="服务器名称" />
							服务器编码：<s:textfield id="topServerCode" name="topServerInfo.serverCode" maxlength="50" title="服务器编码" />
							IP地址：<s:textfield id="topServerHost" name="topServerInfo.host" maxlength="50" title="IP地址" />
							服务端口：<s:textfield id="topServerPort" name="topServerInfo.port" size="5" maxlength="10" title="服务端口" />
							<s:button value="测试是否连通" onclick="testTopAisConn()"/>
							<br>
							<br>
						</fieldset>
						<br>
						<br>
						<br>
						<fieldset>
							<legend>服务器列表</legend>
						<display:table id="row" name="serverList" class="its">
							<display:column property="serverName" title="服务器名称" style="WHITE-SPACE: nowrap" />
							<display:column property="serverCode" title="服务器编码" style="WHITE-SPACE: nowrap" />
							<display:column property="host" title="服务器IP地址" headerClass="center"  style="WHITE-SPACE: nowrap" />
							<display:column property="port" title="服务端口" headerClass="center"  style="WHITE-SPACE: nowrap" />
							<display:column title="是否为主服务器" headerClass="center" class="center" >
								<s:if test="${row.serverType=='ZHUFUWU'}">
									是
								</s:if>
								<s:else>
									否
								</s:else>
							</display:column>
							<display:column title="操作" headerClass="center" class="center" media="html" style="WHITE-SPACE: nowrap">
								<a href="javascript:;" onclick="deleteServer('${row.serverCode}')">删除</a>
								&nbsp;
								<a href="javascript:;" onclick="testAisConn('${row.host}','${row.port}')">测试是否连通</a>
							</display:column>
						</display:table>
						<s:button value="下发服务器列表" onclick="commetServerList()"/>
						说明：一般情况下更改服务器列表后推荐手动进行服务器列表下发操作(非同步，只是时间比较短，几分钟左右),因为系统自动下发周期比较长(几小时左右)。
						</fieldset>
						<br>
						<br>
						<fieldset>
							<legend>新增服务器</legend>
							<br>
							服务器名称：<s:textfield id="serverName" name="currentServerInfo.serverName" maxlength="50" title="服务器名称" />
							服务器编码：<s:textfield id="serverCode" name="currentServerInfo.serverCode" maxlength="50" title="服务器编码" />
							IP地址：<s:textfield id="serverHost" name="currentServerInfo.host" maxlength="50" title="IP地址" />
							服务端口：<s:textfield id="serverPort" name="currentServerInfo.port" size="5" maxlength="10" title="服务端口" />
							<s:button value="测试是否连通" onclick="testNewAisConn()"/>
							<s:submit value="保存到服务器列表" onclick="return saveServerCheck();" />
							<br>
							<br>
							<br>
							<p>
							说明：服务器编码必须是唯一的，并且同一个部署点的服务器编码是不可更改的，即使删除掉重新建立也要保证这个编码一致，否则数据会混乱
							</p>
							<br>
						</fieldset>
						<br />
						<br />
						<br />
					</td>
				</tr>
			</table>
		</s:form>
		
		<script type="text/javascript">
			/**
			* 手动调用服务器列表下发操作
			*/
			function commetServerList(){
				window.location.href = '/ais/unitary/ais/commetServerList.action';
			}
			
			/**
			*	设置本机是否启用一体化
			*/
			function setLocalStatus(status){
				var localServerCode = document.getElementById('localServerCode').value;
				if(localServerCode==''){
					alert('未在服务器列表中发现当前服务器，请先手动添加到服务器列表后再启用一体化!');
					return false;
				}
				window.location.href = '/ais/unitary/ais/setLocalStatus.action?currentServerInfo.localServerStatus='+status;
			}
			
			/**
			*	测试主服务器的联通状况
			*/
			function testTopAisConn(){
				var topServerHost = document.getElementById('topServerHost').value;
				var topServerPort = document.getElementById('topServerPort').value;
				if(topServerHost=='' || topServerPort==''){
					alert('请输入必填项目!');
					return false;
				}
				testAisConn(topServerHost,topServerPort);
			}
			
			/**
			*	测试指定IP和端口的服务器的联通状态
			*/
			function testAisConn(host,port){
				var isAisConnOk = '';
				var message = '';
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/unitary/ais', action:'testAisConn', executeResult:'false' }, 
					{'currentServerInfo.host':host,'currentServerInfo.port':port},
					xxx);
				function xxx(data){
					isAisConnOk = data['isAisConnOk'];
					message = data['message'];
				}
				if(isAisConnOk=='true'){
					alert('连接成功,OK!');
				}else{
					alert(message);
				}
			}
			
			/**
			*	测试新增服务器的连通状态
			*/
			function testNewAisConn(){
				var serverHost = document.getElementById('serverHost').value;
				var serverPort = document.getElementById('serverPort').value;
				if(serverHost=='' || serverPort==''){
					alert('请输入必填项目!');
					return false;
				}
				testAisConn(serverHost,serverPort);
			}
			
			/**
			*	删除指定服务器
			*/
			function deleteServer(serverCode){
				window.location.href = '/ais/unitary/ais/deleteServer.action?currentServerInfo.serverCode='+serverCode;
			}

			/**
			*	保存指定服务器
			*/
			function saveServerCheck(){
				var serverName = document.getElementById('serverName').value;
				var serverCode = document.getElementById('serverCode').value;
				var serverHost = document.getElementById('serverHost').value;
				var serverPort = document.getElementById('serverPort').value;
				if(serverCode=='' || serverName=='' || serverHost=='' || serverPort==''){
					alert('请输入必填项目!');
					return false;
				}
				return true;
			}
			
		</script>
		
	</body>
</html>