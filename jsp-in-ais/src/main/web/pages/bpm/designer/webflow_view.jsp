<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns:v="urn:schemas-microsoft-com:vml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<TITLE>流程设计器</TITLE>

		<style>
			body { background-color: white; }
			td { FONT-SIZE: 9pt }
		</style>
		<script language="javascript">
			var BASE_PATH = "${contextPath}/bpm/definition/";
			var BASE_RESOURCE_PATH = "${contextPath}/pages/bpm/designer/";
			var WORKFLOW_READONLY = false;
		</script>
		<%
		String opertion = null;
		opertion = request.getParameter("opertion");
		if(opertion==null){
			opertion="";
		}
		%>

		<script language="javascript">
			<s:if test="msg.list.size!=0">
				alert("保存成功");
			</s:if>
			function toSave(){
				if(confirm("是否确定要保存？")) {
				   document.getElementsByName("bpmDefinition.xml_webflow")[0].value = document.definitionForm.FlowXML.value;
				  definitionForm.submit();
				}
			}
			
			function toClose(){
				var flag = confirm("是否关闭流程设计页面？\r\n\r\n请注意：若您之前对节点或流向进行了操作将不会被保存，若想保存，请先点击“取消”按钮，返回流程设计页面，再点击“保存”按钮进行保存！");
				if(flag){
				window.close();
				}
			}
		
			function defTask(nodeId){
			    window.open('${contextPath}/bpm/task/edit.action?bpmDefinition.id='+nodeId,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			}
			function defFieldAccess(nodeId){
			    window.open('${contextPath}/bpm/fieldaccess/list.action?bpmDefinition.id='+nodeId,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			}
			//点击一般的空白页面			
			function flowContextMenu(){
			    var menuSrc = '<menu><entity id="c0"><description>刷新</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/refresh_vml.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();redrawVML();</onClick><contents></contents></entity></menu>';
			    showContextMenu(menuSrc);
			}
			//查看流程属性
			function nodeContextMenu(nodeId,nodeType,nodeText){
			    var menuSrc = '<menu>';
				if('${view}'!='view'){
					menuSrc = menuSrc + '<entity id="c0"><description>编辑节点 ['+nodeText+']</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/edit_obj.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();editNodeBySetVaribles("'+nodeId+'","'+nodeType+'","${bpmDefinition.id}");</onClick><contents></contents></entity>';
				}
			    menuSrc += '<entity id="c2"><description>刷新</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/refresh_vml.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();redrawVML();</onClick><contents></contents></entity></menu>';
			    showContextMenu(menuSrc);
			}
			
			//编辑路径的操作，查看页面没有编辑操作，所以js方法里面什么都不做
			function tranContextMenu(tranId, tranText){
			
			}			
		</script>

		<link rel="stylesheet" type="text/css" href="${contextPath}/pages/bpm/designer/inc/webTab/webtab.css">
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/contextMenu/context.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webflow.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/function.js"></script>
		<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/movenode.js"></script>

		<STYLE>
		v\:* { Behavior: url(#default#VML) } 
		</STYLE>
	</HEAD>

	<BODY onload="redrawVML()" oncontextmenu="cleancontextMenu();return false;" scroll="auto">
		<s:form id="definitionForm" action="save_varibles" cssStyle="margin:0;" theme="simple" method="post" onsubmit="this.defContent.value=document.all.FlowXML.value">
			<table style="background-color: buttonface;" width="100%">
			<%--<s:if test="${view ne 'view'}">--%>
				<%--<%if(!"invaild".equals(opertion)){ %>--%>
					<%--<tr>--%>
						<%--<td>--%>
							<%--<img style="CURSOR:hand" onclick="cleancontextMenu();redrawVML();"--%>
								<%--alt="刷新"--%>
								<%--src="${contextPath}/pages/bpm/designer/inc/contextMenu/images/refresh_vml.gif" [刷新]/>--%>
							<%--<a href="javascript:;" onclick="cleancontextMenu();redrawVML();" style="text-decoration: none; ">[刷新]</a>--%>
							<%--&nbsp;&nbsp;&nbsp;--%>
							<%--<img style="CURSOR:hand" onclick="cleancontextMenu();toSave();"--%>
								<%--alt="保存"--%>
								<%--src="${contextPath}/pages/bpm/designer/inc/contextMenu/images/save.jpg" />--%>
							<%--<a href="javascript:;" onclick="cleancontextMenu();toSave();" style="text-decoration: none; ">[保存]</a>--%>
							<%--&nbsp;&nbsp;&nbsp;--%>
							<%--<img style="CURSOR:hand" onclick="cleancontextMenu();toClose();"--%>
								<%--alt="关闭"--%>
								<%--src="${contextPath}/pages/bpm/designer/inc/contextMenu/images/close.jpg" />--%>
							<%--<a href="javascript:;" onclick="cleancontextMenu();toClose();" style="text-decoration: none; ">[关闭]</a>--%>
							<%--&nbsp;&nbsp;&nbsp;--%>
						<%--</td>--%>
					<%--</tr>--%>
				<%--<%} %>--%>
				<%--</s:if>--%>
				<tr style="background-color: white;">
					<td onclick="cleancontextMenu();return false;" oncontextmenu='flowContextMenu();return false;' valign="top" align="left">
		    			<v:group ID="FlowVML" style="border:0 dotted gray;left:0;top:0;width:1000px;height:1000px;xposition:absolute;" coordsize="1000,1000">
		    			</v:group>
					</td>

				</tr>
				
			</table>
			<textarea style="display:none" id="FlowXML" name="FlowXML" onpropertychange='if(AUTODRAW) redrawVML();' rows="35" cols="80">
 				<s:property value="bpmDefinition.xml_webflow" escape="false"/>
			</textarea>
			<textarea style="display:none" rows="35" cols="80"> 
 				<s:property value="bpmDefinition.xml_jbpm" escape="false"/>
			</textarea>				
		    <s:hidden name="bpmDefinition.id"/>
		    <s:hidden name="bpmDefinition.name"/>
		    <s:hidden name="bpmDefinition.name2Display" />
		    <s:hidden name="bpmDefinition.xml_webflow"/>
		    <s:hidden name="bpmDefinition.xml_jbpm"/>
		    <s:hidden name="bpmDefinition.table_code"/>
		    <s:hidden name="bpmDefinition.table_name"/>
		    <s:hidden name="bpmDefinition.form_type"/>
		    <s:hidden name="bpmDefinition.form_name"/>   
		    <s:hidden name="bpmDefinition.version"/>
		    <s:hidden name="bpmDefinition.is_vaild"/>
		    <s:hidden name="bpmDefinition.jbpm_definition_id"/>
		    <s:hidden name="modifyAttribute" value="true"/>       
		</s:form>
	</BODY>
</HTML>
