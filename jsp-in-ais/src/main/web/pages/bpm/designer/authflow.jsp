<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
var WORKFLOW_READONLY = true;
</script>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/pages/bpm/designer/inc/webTab/webtab.css">
		<script language="jscript"
			src="${contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>
		<script language="jscript"
			src="${contextPath}/pages/bpm/designer/inc/contextMenu/context.js"></script>
		<script language="jscript"
			src="${contextPath}/pages/bpm/designer/inc/webflow.js"></script>
		<script language="jscript"
			src="${contextPath}/pages/bpm/designer/inc/function.js"></script>
		<script language="jscript"
			src="${contextPath}/pages/bpm/designer/inc/movenode.js"></script>

		<STYLE>
v\:* { Behavior: url(#default#VML) } 
</STYLE>
	</HEAD>
	<script language="javascript">
function assignTask(nodeId,nodeText,defId,groupId){//zhouting
var url; //弹出窗口的url
if(nodeId == "begin"){ //节点id是degin的时候 
 url = '${contextPath}/bpm/task/edit.action?nodeid=__'+encodeURI(encodeURI(nodeText))+'__&bpmDefinition.id='+defId+'&bpmGroup.id='+groupId+'&begin_nodeId='+nodeId+'';
}else{
 url = '${contextPath}/bpm/task/edit.action?nodeid=__'+encodeURI(encodeURI(nodeText))+'__&bpmDefinition.id='+defId+'&bpmGroup.id='+groupId+'';
   }
    window.open(url,"","toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no,height=600,width=800");
}
function flowContextMenu(){

}

function nodeContextMenu(nodeId,nodeType,nodeText){  //添加分配任务的选项--zhouting
if(nodeType!='BeginNode' && nodeType!='EndNode')
//if(nodeType!='EndNode')
    {  //判断在结束阶段不能分配任务
    var menuSrc = '<menu>';
    menuSrc+= '<entity id="c1"><description>分配任务 ['+nodeText+']</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/task.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();assignTask("'+nodeId+'","'+nodeText+'","${bpmDefinition.id}","<%=request.getParameter("bpmGroup.id")%>");</onClick><contents></contents></entity>';
    menuSrc+= '</menu>';
    showContextMenu(menuSrc);
    }
}

function tranContextMenu(tranId, tranText){

}			
</script>
	<BODY onload="redrawVML()"
		oncontextmenu="cleancontextMenu();return false;" scroll="auto">

		<s:form id="definitionForm" action="save_design" cssStyle="margin:0;"
			theme="simple" method="post"
			onsubmit="this.defContent.value=document.all.FlowXML.value">
			<table style="background-color: buttonface;" width="100%">
				<tr style="background-color: white;">

					<td onclick="cleancontextMenu();return false;"
						oncontextmenu='flowContextMenu();return false;' valign="top"
						align="left">
						<v:group ID="FlowVML"
							style="border:0 dotted gray;left:0;top:0;width:1000px;height:1000px;xposition:absolute;"
							coordsize="1000,1000">
						</v:group>
					</td>

				</tr>
			</table>


			<textarea style="display:none" id="FlowXML" name="FlowXML"
				onpropertychange='if(AUTODRAW) redrawVML();' rows="35" cols="80">
 		<s:property value="bpmDefinition.xml_webflow" escape="false" />
</textarea>
			<s:hidden name="bpmDefinition.id" />
			<s:hidden name="bpmDefinition.name" />
			<s:hidden name="bpmDefinition.xml_webflow" />
			<s:hidden name="bpmDefinition.xml_jbpm" />
		</s:form>

	</BODY>
</HTML>
