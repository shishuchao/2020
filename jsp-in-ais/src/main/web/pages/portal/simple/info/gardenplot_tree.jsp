<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="tree"
			style="overflow: auto; height: 100%; width: 100%;"></div>
</body>
</html>

<script type="text/javascript">
	Ext.onReady(function(){
		var Tree = Ext.tree;
		var root = new Tree.TreeNode({
            id:'0',
            text:'学习园地',
            draggable:false});
     <s:iterator id="row" value="treeList">
     	<s:if test="${empty(row.pid) or row.pid=='0'}">
        var node_${row.id} = new Tree.TreeNode({
            id:'${row.id}',
            text:'${row.name}',
            href:'${contextPath}/portal/simple/information/gardenPlotList.action?studyGardenPlot.parent_id=${row.id}&studyGardenPlot.company_id=${user.fdepid}&view=${view}',
            hrefTarget:'childBasefrm',
            draggable:false});
        </s:if>
        <s:else>
      	var node_${row.id} = new Tree.TreeNode({
      		id:'${row.id}',
      		text:'${row.name}',
      		href:'${contextPath}/portal/simple/information/gardenPlotList.action?studyGardenPlot.parent_id=${row.id}&studyGardenPlot.company_id=${user.fdepid}&view=${view}',
      		leaf:false,
      		hrefTarget:'childBasefrm',
      		draggable:false});
      	</s:else>
	</s:iterator>
	<s:iterator id="row1" value="treeList">
		<s:if test="${empty(row1.pid) or row1.pid=='0'}">
		root.appendChild(node_${row1.id});
		</s:if>
		<s:else>
		node_${row1.pid}.appendChild(node_${row1.id});
		</s:else>
	</s:iterator>
		var treePanel = new Tree.TreePanel({
			el:'tree',
            useArrows:true,
            autoScroll:true,
            animate:false,
            enableDD:false,
            border:false,
            containerScroll: true});
        treePanel.setRootNode(root);
        treePanel.render();
        root.expand();
        });
</script>
