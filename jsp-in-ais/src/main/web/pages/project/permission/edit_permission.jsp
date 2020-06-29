<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>修改组间授权</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<s:head theme="ajax" />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
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
			#permissionTable .modified{
				background-color: red;
				cursor: pointer;
			}
			
			#permissionTable .primaryPermission{
				display: none;
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
								<td class="permission" title="${tdTitle}" onclick="changePermission(this)">
									<s:set name="isXCanViewY" value="false" />
									<s:set name="isYCanViewX" value="false" />
									<s:if test="#currentGroup.groupsOfCanView!=null&&groups[#counterStatus.index] in #currentGroup.groupsOfCanView">
										<s:set name="isYCanViewX" value="true" />
									</s:if>
									<s:if test="#currentGroup.groupsOfByView!=null&&groups[#counterStatus.index] in #currentGroup.groupsOfByView">
										<s:set name="isXCanViewY" value="true" />
									</s:if>
									<s:if test="#isXCanViewY && #isYCanViewX">
										<span class="primaryPermission">X&lt;--&gt;Y</span>
										<span>X&lt;--&gt;Y</span>
									</s:if>
									<s:elseif test="#isXCanViewY">
										<span class="primaryPermission">X--&gt;Y</span>
										<span>X--&gt;Y</span>
									</s:elseif>
									<s:elseif test="#isYCanViewX">
										<span class="primaryPermission">X&lt;--Y</span>
										<span>X&lt;--Y</span>
									</s:elseif>
									<s:else>
										<span class="primaryPermission">     </span>
										<span>     </span>
									</s:else>
									<s:hidden name="#currentGroup.groupId"/>
									<s:hidden name="groups[#counterStatus.index].groupId"/>
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
			<div id="buttonPanelDiv" style="padding: 20px;">
				<s:if test="${view != 'view' }">
					<s:button value="保存授权结果" onclick="this.style.disabled='disabled';saveChangedPermission()"/>
					<s:button value="刷新授权结果" onclick="window.location.reload()"/>
				</s:if>
			</div>
			
			<div align="center">
			<fieldset style="width: 500px;text-align: left;">
				<legend>图例说明：</legend>
                                         默认不选表示X轴上的项目组与Y轴上的项目组不能互相查看项目的审计成果<br/>
				X--&gt;Y表示位于X轴上的项目组可以查看位于Y轴上的项目的审计工作成果<br/>
				X&lt;--Y表示位于Y轴上的项目组可以查看位于X轴上的项目的审计工作成果<br/>
				X&lt;--&gt;Y表示位于X轴上的项目组和位于Y轴上的项目组可以互相查看项目的审计工作成果<br/>
			</fieldset>
			</div>
		</div>
		<script type="text/javascript">
		
			/*
			* 扩展String类增加trim()方法
			*/
		 	String.prototype.trim= function(){    
				return this.replace(/(^\s*)|(\s*$)/g, "");    
			}

			/*
			* 更改项目组间权限
			*/
			function changePermission(permissionTd){
				var primarySpan = permissionTd.children[0];//原始授权容器
				var currentSpan = permissionTd.children[1];//当前授权容器
				var primaryValue = primarySpan.innerText.trim();//原始值
				var currentValue = currentSpan.innerText.trim();//当前值
				var allValue = new Array();
				allValue[0] = '';//不互看
				allValue[1] = 'X-->Y';//X看Y
				allValue[2] = 'X<--Y';//Y看X
				allValue[3] = 'X<-->Y';//互看
				for(var i=0;i<4;i++){
					if(currentValue==allValue[i]){
						if(i==3){//最后一个值
							currentSpan.innerText=allValue[0];//循环设置
						}else{
							currentSpan.innerText=allValue[i+1];//循环设置
						}
						if(currentSpan.innerText==primaryValue){//等于原来值,不标红,否则标红单元格
							permissionTd.className='permission';
						}else{
							permissionTd.className='modified';
						}
						break;
					}
				}
			}
			
			/*
			* 保存更改的权限设置(标红的单元格)
			*/
			function saveChangedPermission(){
				var permissionTds = document.getElementById('permissionTable').cells;
				var paramString = '';
				var haveModifiedPermission = false;
				for(var i=0;i<permissionTds.length;i++){
					var permissionTd = permissionTds[i];
					if(permissionTd.className=='modified'){
						haveModifiedPermission = true;
						var currentValue = permissionTd.children[1].innerText.trim();//当前授权值
						var groupId = permissionTd.children[3].value;//X小组编号
						var targetGroupId = permissionTd.children[2].value;//Y小组编号
						if(currentValue==''){
							currentValue='X--Y';
						}
						paramString = paramString + groupId + currentValue + targetGroupId + '|';
					}
				}
				if(!haveModifiedPermission){
					top.$.messager.show({
						title:'提示信息',
						msg:'您未设置审计成果组间授权或未对之前设置的组间授权进行变更,无法保存！',
						height:'auto'
					});
					return false;
				}
				var projectFormId = '<s:property value="pso.formId" />';
				//paramString = paramString.replace(/[X,Y]/g,'').replace('<','(').replace('>',')');
				paramString = paramString.replace(/[X,Y]/g,'').replace(/\</g,'(').replace(/\>/g,')');
			
				window.location.href=encodeURI("/ais/project/permission/save.action?pso.formId="+projectFormId+"&permissionString="+paramString);

				/*jQuery.ajax({
					url:'${contextPath}/project/permission/save.action?pso.formId='+projectFormId,
					type:'POST',
					data:form2Json('myForm'),
					dataType:'json',
					async:'false',
					success:function(data){
						 window.location.reload();
					},
					error:function(){
					}
				});*/
			}
		</script>
	</body>
</html>
