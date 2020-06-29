<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<s:if test="1>=bpmDefinitionList.size()">
	<s:set name="displayFlag1" value="false" scope="request"></s:set>
</s:if>
<span style="display:${requestScope.displayFlag1=='false' ? 'none' : ''}">审批流程</span>
<s:select name="definition_id" list="bpmDefinitionList" listKey="id"
	listValue="name2Display" onchange="changeCondition('group')"
	display="${requestScope.displayFlag1}"></s:select>
&nbsp;&nbsp;
<s:if test="1>=bpmGroupList.size()">
	<s:set name="displayFlag2" value="false" scope="request"></s:set>
</s:if>
<span style="display:${requestScope.displayFlag2=='false' ? 'none' : ''}">群组</span>
<s:select name="group_id" list="bpmGroupList" listKey="id"
	listValue="name" onchange="changeCondition('no')"
	display="${requestScope.displayFlag2}"></s:select>
&nbsp;&nbsp; 当前节点
<s:select name="fromNode" list="fromNodeList" listKey="name"
	listValue="name" onchange="changeCondition('no')"></s:select>
&nbsp;&nbsp; 下一节点
<s:select name="toNode" list="toNodeList" listKey="to" listValue="name"
	onchange="changeCondition('yes')"></s:select>
&nbsp;&nbsp;
<!-- 必要参数 LIHAIFENG 2007-12-26 -->
<s:hidden id="toNodeStatus" name="toNodeStatus" value="no"></s:hidden>
