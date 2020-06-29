<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns:v="urn:schemas-microsoft-com:vml">
	<head>
		<title>编辑流程</title>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<s:head theme="ajax" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="${contextPath}/pages/bpm/designer/inc/webTab/webtab.css">	
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/introcontrol/introcheck.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/introcontrol/introcontrol.js"></script>		
		
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/contextMenu/context.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webflow.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/function.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/movenode.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
		<style>
			body { background-color: white; }
			td { FONT-SIZE: 9pt }
			a,a:visited,a:hover {
			    color: #666;
			    text-decoration: none;
			}
			a:hover {
			    text-decoration: underline;
			}
			img {
			    border: none;
			}
			v\:* { Behavior: url(#default#VML) } 
		</style>
	</head>
	<body onload="redrawVML()" oncontextmenu="cleancontextMenu();return false;" scroll="auto">
		<div id="tt" class="easyui-tabs">
			<div title="流程图例" >
				<div align="left">
					<left>
						<table style="background-color: buttonface;" width="80%">
							<tr style="background-color: white;" align="center">
								<td onclick="cleancontextMenu();return false;" oncontextmenu='flowContextMenu();return false;' valign="top" align="left">
						  			<v:group ID="FlowVML" style="border:0 dotted gray;left:0;top:0;width:1000px;height:1000px;xposition:absolute;" coordsize="1000,1000">
						  			</v:group>
								</td>
							</tr>
						</table>
					</left>
					<textarea style="display:none" id="FlowXML" name="FlowXML" onpropertychange='if(AUTODRAW) redrawVML();' rows="35" cols="80">
						<s:property value="bpmDefinition.xml_webflow" escape="false"/>
					</textarea>
					<textarea style="display:none" rows="35" cols="80"> 
						<s:property value="bpmDefinition.xml_jbpm" escape="false"/>
					</textarea>
				    <s:hidden name="bpmDefinition.id"/>
				    <s:hidden name="bpmDefinition.name"/>
				    <s:hidden name="bpmDefinition.xml_webflow"/>
				    <s:hidden name="bpmDefinition.xml_jbpm"/>
				    <s:hidden name="bpmDefinition.table_code"/>
				    <s:hidden name="bpmDefinition.table_name"/>
				    <s:hidden name="bpmDefinition.form_type"/>
				    <s:hidden name="bpmDefinition.form_name"/>
				    <s:hidden id="formId" name="formId"/>
				</div>
			</div>
			<div title="审批记录" style="padding: 20px;">
				<div align="center">
					<s:if test="listProcessInfo.size > 0">
						<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" 
							style="width: 90%" class="ListTable" align="center">
							<tr align="center" class="titletable1">
								<td>
									<center>
										环节名称
									</center>
								</td>
								<td>
									<center>
										处理人
									</center>
								</td>
								<td>
									<center>
										处理人所在部门
									</center>
								</td>
								<td>
									<center>
										处理意见
									</center>
								</td>
								<td>
									<center>
										处理时间
									</center>
								</td>
								<td>
									<center>
										操作
									</center>
								</td>
							</tr>
							<s:iterator value="listProcessInfo">
								<tr>
									<td class="listtabletr2">
										<center>
											<s:if test="node_back==1">
												<s:property value="taskName" /><font color="red">(回退)</font>
											</s:if>
											<s:else>
												<s:property value="taskName" />
											</s:else>
											</center>
									</td>
									<td class="listtabletr2">
										<center>
											<s:property value="userName" />
										</center>
									</td>
									<td class="listtabletr2">
										<center>
											<s:property value="deptName" />
										</center>
									</td>
									<td class="listtabletr2" width="200px;">
										<span id="commentViewSpan_${id}" style="display:inline;">
											<s:property value="comments" />
										</span>
										<span id="commentEditSpan_${id}" style="display:none;">
											<s:textarea id="comments_${id}" name="comments" cols="300" rows="5"/>
										</span>
									</td>
									<td class="listtabletr2">
										<center>
											<s:date name="createDate" format="yyyy-MM-dd HH:mm:ss" />
										</center>
									</td>
									<td class="listtabletr2" nowrap="nowrap">
										<span id="operateSpan_${id}" style="display:inline;">
											<a href="javascript:void(0);" onclick="modifyComment('${id}')">修改意见</a>
										</span>
										<span id="saveSpan_${id}" style="display:none;">
											<input type="button" style="width:100px;" value="保存" onclick="saveComment('${id}')">
											<input type="button" style="width:100px;" value="取消" onclick="resetComment('${id}')">
											<%-- <button onclick="saveComment('${id}')">保存</button>
											<button onclick="resetComment('${id}')">取消</button> --%>
										</span>
									</td>
								</tr>
							</s:iterator>
						</table>
					</s:if>
				</div>
			</div>
			
		</div>
		<%-- <s:tabbedPanel id='processTabPanel' theme='ajax'>
			<s:div id='graghDiv' label='流程图例' theme='ajax'
				labelposition='top' loadingText="正在加载内容......">
				<center>
					<table style="background-color: buttonface;" width="100%">
						<tr style="background-color: white;" align="center">
							<td onclick="cleancontextMenu();return false;" oncontextmenu='flowContextMenu();return false;' valign="top" align="left">
					  			<v:group ID="FlowVML" style="border:0 dotted gray;left:0;top:0;width:1000px;height:1000px;xposition:absolute;" coordsize="1000,1000">
					  			</v:group>
							</td>
						</tr>
					</table>
				</center>
				<textarea style="display:none" id="FlowXML" name="FlowXML" onpropertychange='if(AUTODRAW) redrawVML();' rows="35" cols="80">
					<s:property value="bpmDefinition.xml_webflow" escape="false"/>
				</textarea>
				<textarea style="display:none" rows="35" cols="80"> 
					<s:property value="bpmDefinition.xml_jbpm" escape="false"/>
				</textarea>
			    <s:hidden name="bpmDefinition.id"/>
			    <s:hidden name="bpmDefinition.name"/>
			    <s:hidden name="bpmDefinition.xml_webflow"/>
			    <s:hidden name="bpmDefinition.xml_jbpm"/>
			    <s:hidden name="bpmDefinition.table_code"/>
			    <s:hidden name="bpmDefinition.table_name"/>
			    <s:hidden name="bpmDefinition.form_type"/>
			    <s:hidden name="bpmDefinition.form_name"/>
			    <s:hidden id="formId" name="formId"/>
			</s:div>
			<s:div id='commentDiv' label='审批记录' theme='ajax'
				labelposition='top' loadingText="正在加载内容......">
				<s:if
					test="listProcessInfo.size > 0">
					<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
						class="ListTable" align="center">
						<tr align="center" class="titletable1">
							<td>
								<center>
									环节名称
								</center>
							</td>
							<td>
								<center>
									处理人
								</center>
							</td>
							<td>
								<center>
									处理人所在部门
								</center>
							</td>
							<td>
								<center>
									处理意见
								</center>
							</td>
							<td>
								<center>
									处理时间
								</center>
							</td>
							<td>
								<center>
									操作
								</center>
							</td>
						</tr>
						<s:iterator value="listProcessInfo">
							<tr>
								<td class="listtabletr2">
									<center>
										<s:if test="node_back==1">
											<s:property value="taskName" /><font color="red">(回退)</font>
										</s:if>
										<s:else>
											<s:property value="taskName" />
										</s:else>
										</center>
								</td>
								<td class="listtabletr2">
									<center>
										<s:property value="userName" />
									</center>
								</td>
								<td class="listtabletr2">
									<center>
										<s:property value="deptName" />
									</center>
								</td>
								<td class="listtabletr2" width="200px;">
									<span id="commentViewSpan_${id}" style="display:inline;">
										<s:property value="comments" />
									</span>
									<span id="commentEditSpan_${id}" style="display:none;">
										<s:textarea id="comments_${id}" name="comments" cols="300" rows="5"/>
									</span>
								</td>
								<td class="listtabletr2">
									<center>
										<s:date name="createDate" format="yyyy-MM-dd HH:mm:ss" />
									</center>
								</td>
								<td class="listtabletr2" nowrap="nowrap">
									<span id="operateSpan_${id}" style="display:inline;">
										<a href="javascript:;" onclick="modifyComment('${id}')">修改意见</a>
									</span>
									<span id="saveSpan_${id}" style="display:none;">
										<button onclick="saveComment('${id}')">保存</button>
										<button onclick="resetComment('${id}')">取消</button>
									</span>
								</td>
							</tr>
						</s:iterator>
					</table>
				</s:if>
			</s:div>
		</s:tabbedPanel> --%>
		<script type="text/javascript">
			
			var BASE_PATH = "${contextPath}/bpm/definition/";
			var BASE_RESOURCE_PATH = "${contextPath}/pages/bpm/designer/";
			var WORKFLOW_READONLY = false;
			var CURR_NODE_NAME= '${currentNodeName}';
			var isRefreshParentPage = '${isRefreshParentPage}';
			if(isRefreshParentPage=='true'){
				window.opener.location.href='${contextPath}/bpm/monitor/list.action?definitionId=${definitionId}';
			}
			
			/**
			*	空白处的右键菜单
			*/
			function flowContextMenu(){
				
			}
			
			/**
			*	右键点击节点菜单
			*/
			function nodeContextMenu(nodeId,nodeType,nodeText){
				if (nodeType!='BeginNode' 
						&& nodeType!='EndNode'
						&& CURR_NODE_NAME==nodeText){
					var menuSrc = '<menu>';
					menuSrc += '<entity id="c0"><description>跳转到...</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/edit_obj.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();jumpToNode("'+nodeId+'","'+nodeType+'","${bpmDefinition.id}");</onClick><contents></contents></entity>';
					menuSrc += '<entity id="c0"><description>更换处理人</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/edit_obj.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();editTaskActor("'+nodeId+'","'+nodeType+'","${bpmDefinition.id}");</onClick><contents></contents></entity>';
					menuSrc +='</menu>';
					showContextMenu(menuSrc);
				}
			}
			
			/**
			*	使流程实例跳转到其它节点
			*/
			function jumpToNode(){
				var dialogURL = BASE_RESOURCE_PATH + '_jumptodedialog.jsp';
				var dialog = window.showModalDialog(dialogURL, window, "dialogWidth:800px; dialogHeight:500px; center:yes; help:no; resizable:no; status:no;") ;
			}
			
			/**
			*	修改当前节点的办理人
			*/
			function editTaskActor(){
				var dialogURL = BASE_RESOURCE_PATH + '_edit_task_actor_dialog.jsp';
				var dialog = window.showModalDialog(dialogURL, window, "dialogWidth:800px; dialogHeight:500px; center:yes; help:no; resizable:no; status:no;") ;
			}
			
			/*
			*	右键点击走向菜单
			*/
			function tranContextMenu(tranId, tranText){
				
			}
			
			/*
			*	使流程实例跳转到指定的节点并设置指定的办理人
			*/
			function jumpToNodeSubmit(nodeText,actorId,actorName){
				var formId = document.getElementById('formId').value;
				//window.location.href="${contextPath}/bpm/monitor/jumpToNode.action?formId="+formId+"&definitionId=${definitionId}&toNode="+encode64(encodeURI(nodeText))+"&actorId="+actorId+"&actorName="+encode64(encodeURI(actorName));
				window.location.href="${contextPath}/bpm/monitor/jumpToNode.action?formId="+formId+"&definitionId=${definitionId}&toNode="+encodeURI(nodeText)+"&actorId="+actorId+"&actorName="+encodeURI(actorName);
			}
			
			/*
			*	修改当前节点任务的办理人
			*/
			function editTaskActorSubmit(actorId,actorName){
				var formId = document.getElementById('formId').value;
				//window.location.href="${contextPath}/bpm/monitor/editTaskActorSubmit.action?currentNodeName="+encode64(encodeURI('${currentNodeName}'))+"&formId="+formId+"&definitionId=${definitionId}&actorId="+actorId+"&actorName="+encode64(encodeURI(actorName));
				window.location.href="${contextPath}/bpm/monitor/editTaskActorSubmit.action?currentNodeName="+encodeURI('${currentNodeName}')+"&formId="+formId+"&definitionId=${definitionId}&actorId="+actorId+"&actorName="+encodeURI(actorName);
			}
			
			/**
			*	修改备注意见
			*/
			function modifyComment(id){
				document.getElementById('commentEditSpan_'+id).style.display='';
				document.getElementById('commentViewSpan_'+id).style.display='none';
				document.getElementById('operateSpan_'+id).style.display='none';
				document.getElementById('saveSpan_'+id).style.display='';
			}
			
			/**
			*	保存备注意见
			*/
			function saveComment(id){
				var dwrResult = 'false';
				var comments = document.getElementById('comments_'+id).value;
				DWREngine.setAsync(false);
				DWRActionUtil.execute(
					{ namespace:'/bpm/monitor', action:'updateTaskComment', executeResult:'false' }, 
					{'info.id':id,'info.comments':comments},
					xxx);
				function xxx(data){
					dwrResult = data['dwrResult'];
				} 
				if(dwrResult != 'true'){
					alert('保存过程中发生未知错误，请稍后再试!');
				}else{
					document.getElementById('commentViewSpan_'+id).innerHTML = comments;
					document.getElementById('commentEditSpan_'+id).style.display='none';
					document.getElementById('commentViewSpan_'+id).style.display='';
					document.getElementById('operateSpan_'+id).style.display='';
					document.getElementById('saveSpan_'+id).style.display='none';
				}
			}
			
			/**
			*	重置备注意见
			*/
			function resetComment(id){
				document.getElementById('commentEditSpan_'+id).style.display='none';
				document.getElementById('commentViewSpan_'+id).style.display='';
				document.getElementById('operateSpan_'+id).style.display='';
				document.getElementById('saveSpan_'+id).style.display='none';
			}
			
		</script>
	</body>
</html>
