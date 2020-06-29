<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=5">
<s:head theme="ajax" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>流程查看</TITLE>

<style>
body { background-color: white; }
td { FONT-SIZE: 9pt }
</style>
<script language="javascript">
var BASE_PATH = "${contextPath}/bpm/definition/";
var BASE_RESOURCE_PATH = "${contextPath}/pages/bpm/designer/";
var WORKFLOW_READONLY = false;
var CURR_NODE_NAME="";
</script>

<script language="javascript">
function defTask(nodeId){
    window.open('${contextPath}/bpm/task/edit.action?bpmDefinition.id='+nodeId,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
}
function defFieldAccess(nodeId){
    window.open('${contextPath}/bpm/fieldaccess/list.action?bpmDefinition.id='+nodeId,'','toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
}
//点击一般的空白页面
function flowContextMenu(){
    //var menuSrc = '<menu><entity id="c0"><description>刷新</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/refresh_vml.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();redrawVML();</onClick><contents></contents></entity></menu>';
    var menuSrc="";
    //showContextMenu(menuSrc);
}
//查看流程属性
function nodeContextMenu(nodeId,nodeType,nodeText){
    //var menuSrc = '<menu><entity id="c0"><description>查看节点 ['+nodeText+']</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/edit_obj.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();viewNode("'+nodeId+'","'+nodeType+'","${bpmDefinition.id}");</onClick><contents></contents></entity>';
    //menuSrc += '<entity id="c2"><description>刷新</description><image>'+BASE_RESOURCE_PATH+'inc/contextMenu/images/refresh_vml.gif</image><fontcolor>'+MenuTextColor_enable+'</fontcolor><onClick>cleancontextMenu();redrawVML();</onClick><contents></contents></entity></menu>';
    var menuSrc="";
    //showContextMenu(menuSrc);
}

//编辑路径的操作，查看页面没有编辑操作，所以js方法里面什么都不做
function tranContextMenu(tranId, tranText){

}
function setcurrnodename(){
	if(window.opener.document.getElementById("curr_node_name"))
		CURR_NODE_NAME = window.opener.document.getElementById("curr_node_name").value;
	else
		CURR_NODE_NAME = '${param.curr_node_name}';
}
</script>

<link rel="stylesheet" type="text/css" href="${contextPath}/pages/bpm/designer/inc/webTab/webtab.css">

<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webTab/webTab.js"></script>
<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/contextMenu/context.js"></script>
<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/webflow.js"></script>
<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/function.js"></script>
<script language="jscript" src="${contextPath}/pages/bpm/designer/inc/movenode.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>

<STYLE>
v\:* { Behavior: url(#default#VML) }
</STYLE>
<script language="javascript">
	function ShowORHideDIV(divid){
		var evt = window.event;
		var eventSrc = evt.target || evt.srcElement;
		var obj=document.getElementById(divid);
		if(obj){
			if(obj.style.display=="none"){
				obj.style.display="block";
				if(divid=="flowimage"){
					eventSrc.innerText="隐藏流程图例";
				}else{
					eventSrc.innerText="隐藏流程信息列表";
				}
			}else{
				obj.style.display="none";
				if(divid=="flowimage"){
					eventSrc.innerText="显示流程图例";
				}else{
					eventSrc.innerText="显示流程信息列表";
				}
			}
		}
	}
</script>
</HEAD>

<BODY onload="setcurrnodename();redrawVML()" oncontextmenu="cleancontextMenu();return false;" scroll="auto">
<s:tabbedPanel id='test' theme='ajax'>
<!--<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%">
			<tr class="listtablehead">
				<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
					<div style="display: inline;width:80%;">
						流程图例
					</div>
					<div style="display: inline;width:20%;text-align: right;">
						<a href="javascript:;" onclick="ShowORHideDIV('flowimage')">隐藏流程图例</a>
					</div>
				</td>
			</tr>
		</table>
-->
<s:div id='image' label='流程图例' theme='ajax'
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
<div ID="me" style="position: absolute;left: 200px; top: 120px;display: none;">
</div>
</center>
注：<br/>
1、当前节点：<span style="height:17px;width:50px;text-align:center;text-valign:middle;border:1px solid black;background-color:#BAF8CA;font-size:13">&nbsp;&nbsp;&nbsp;</span><br/>
2、鼠标移到相应节点上，可以看到节点详细信息
<p/>
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

</s:div>
<!--
	显示流程信息列表
-->
<!--<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
	class="ListTable" width="100%">
	<tr class="listtablehead">
		<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
			<div style="display: inline;width:80%;">
				流程信息列表
			</div>
			<div style="display: inline;width:20%;text-align: right;">
				<a href="javascript:;" onclick="ShowORHideDIV('flowinfo')">隐藏流程信息列表</a>
			</div>
		</td>
	</tr>
</table>
-->
<s:div id='infolist' label='流程信息列表' theme='ajax'
							labelposition='top' loadingText="正在加载内容......">
<s:if
	test="listProcessInfo.size>0">
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
				<td class="listtabletr2">
					<s:property value="comments" />
				</td>
				<td class="listtabletr2">
					<center>
						<s:date name="createDate" format="yyyy-MM-dd HH:mm:ss" />
					</center>
				</td>
			</tr>
			<input name="<s:property value="taskName" />" type="hidden" value="<tr><td class=listtabletr2><s:property value="userName" /></td><td class=listtabletr2><s:property value="deptName" /></td><td class=listtabletr2><s:property value="comments" /></td><td class=listtabletr2><s:date name="createDate" format="yyyy-MM-dd HH:mm:ss" /></td></tr>"/>
		</s:iterator>
	</table>
</s:if>
</s:div>
</s:tabbedPanel>
</BODY>
</HTML>
