<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function myClick(id){
			parent.main.location.href = "${contextPath}/mng/economyduty/economyDutyAction!selectList.action?audobjid=" + id;
		}
	</script>
</head>
<body>
<div class="TreeView" id="configtree" Checkbox="0" SelectedColor="#FFFF00">
<s:iterator value="treeList" id="tree">
   	<s:if test="${empty(tree.superiorCode) or tree.superiorCode=='0'}">
   		<s:if test="${tree.isClick == 'Y'}">
	   		<p title="${tree.name}" sid="${tree.currentCode}" pid="${tree.superiorCode}" click="myClick('${tree.id}')"></p>
   		</s:if>
   		<s:else>
	   		<p title="${tree.name}" sid="${tree.currentCode}" pid="${tree.superiorCode}"></p>
   		</s:else>
	</s:if>
	<s:else>
   		<s:if test="${tree.isClick == 'Y'}">
	   		<p title="${tree.name}" sid="${tree.currentCode}" pid="${tree.superiorCode}" click="myClick('${tree.id}')"></p>
	   	</s:if>
	   	<s:else>
	   		<p title="${tree.name}" sid="${tree.currentCode}" pid="${tree.superiorCode}"></p>
	   	</s:else>
	</s:else>
</s:iterator>
</div>
</body>
</html>