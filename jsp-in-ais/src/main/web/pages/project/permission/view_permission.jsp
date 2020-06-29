<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计结果组件授权</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
			#permissionTable {
				border-collapse:collapse;
				border:solid black; 
				border-width:0 0 0 1px;
				width: <s:property value="(groups.size+2)*100"/>px;
			}
			#permissionTable td {border:solid black;border-width:0 1px 1px 0;padding:2px;text-align: center;}
			#permissionTable .groupType{
				background-color: #F2DDDC;
				font-weight: bold;
				border-width:1px 1px 1px 0;
			}
			#permissionTable .groupName{
				background-color: #FEFE9A;
				font-weight: bold;
				border-width:1px 1px 1px 0;
			}
			#permissionTable .permission{
				background-color: #9ACCFD;
				cursor: pointer;
			}
			#permissionTable .blank{
				background-color: #C0C0C0;
				border-width:1px 1px 1px 0;
				
			}
			#permissionTable .hidden{
				border: 0;
			}
		</style>
	</head>
	
	<body>
		<div id="wrap" style="margin: 10px;text-align: center;">
			<table id="permissionTable" style="text-align:center;margin:0 auto;">
				<tr>
					<td style="border-width:0 0 0 0;text-align: left;">Y轴</td>
				</tr>
				<s:iterator value="groups" status="groupStatus" id="currentGroup">
					<tr>
						<td class="groupType"><s:property value="groupTypeName" /></td>
						<td class="groupName"><s:property value="groupName" /></td>
						<s:bean name="org.apache.struts2.util.Counter" id="counter">
						   <s:param name="first" value="1" />
						   <s:param name="last" value="#groupStatus.count" />
						</s:bean>
						<s:iterator value="#counter" status="counterStatus">
							<s:if test="#groupStatus.index gt #counterStatus.index">
							<s:set name="tdTitle" value="'X:'+groups[#counterStatus.index].groupName+'\r\n'+'Y:'+#currentGroup.groupName"/>
								<td class="permission" title="${tdTitle}" >
									<s:set name="isXCanViewY" value="false" />
									<s:set name="isYCanViewX" value="false" />
									<s:if test="#currentGroup.groupsOfCanView!=null&&groups[#counterStatus.index] in #currentGroup.groupsOfCanView">
										<s:set name="isYCanViewX" value="true" />
									</s:if>
									<s:if test="#currentGroup.groupsOfByView!=null&&groups[#counterStatus.index] in #currentGroup.groupsOfByView">
										<s:set name="isXCanViewY" value="true" />
									</s:if>
									<s:if test="#isXCanViewY && #isYCanViewX">
										<span>X&lt;--&gt;Y</span>
									</s:if>
									<s:elseif test="#isXCanViewY">
										<span>X--&gt;Y</span>
									</s:elseif>
									<s:elseif test="#isYCanViewX">
										<span>X&lt;--Y</span>
									</s:elseif>
									<s:else>
										<span>     </span>
									</s:else>
								</td>
							</s:if>
							<s:if test="#groupStatus.index eq #counterStatus.index">
								<td class="blank">&nbsp;</td>
							</s:if>
							<s:if test="#groupStatus.index ge #counterStatus.index">
								<td class="hidden">&nbsp;</td>
							</s:if>
						</s:iterator>
					</tr>
				</s:iterator>
				<tr>
					<td class="groupType">&nbsp;</td>
					<td class="groupName">分组名称</td>
					<s:iterator value="groups" status="groupStatus">
						<td class="groupName"><s:property value="groupName"/></td>
					</s:iterator>
				</tr>
				<tr>
					<td class="groupType">分组类型</td>
					<td class="groupType">&nbsp;</td>
					<s:iterator value="groups" status="groupStatus">
						<td class="groupType"><s:property value="groupTypeName"/></td>
					</s:iterator>
					<td style="border-width:0 0 1px 0;">X轴</td>
				</tr>
			</table>
			<div align="center">
			<fieldset style="width: 500px;text-align: left;">
				<legend>图例说明：</legend>
				X--&gt;Y表示位于X轴上的项目组可以查看位于Y轴上的项目的审计工作成果<br/>
				X&lt;--Y表示位于Y轴上的项目组可以查看位于X轴上的项目的审计工作成果<br/>
				X&lt;--&gt;Y表示位于X轴上的项目组和位于Y轴上的项目组可以互相查看项目的审计工作成果<br/>
			</fieldset>
			</div>
		</div>
	</body>
</html>
