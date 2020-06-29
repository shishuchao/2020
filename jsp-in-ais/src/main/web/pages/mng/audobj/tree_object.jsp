<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript"
					src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">

	<script type="text/javascript">
	Ext.onReady(function(){
	Ext.QuickTips.init();
	 var Tree = Ext.tree;
     <s:iterator value="list">
     	<s:if test="${empty(superiorCode) or superiorCode=='0'}">
        var root=new Tree.TreeNode({
               id:'${id}',
               text:'${name}',
               href:'${contextPath}/mng/audobj/object/${status}.action?auditingObject.id=${id}&superiorCode=${currentCode}&status=${status}',
               hrefTarget:'childBasefrm',
               draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
        var node_${currentCode}=root;
        </s:if>
        <s:else>
      	var node_${currentCode}=new Tree.TreeNode({id:'${id}',qtip:'${name}',text:'${name}',href:'${contextPath}/mng/audobj/object/${status}.action?auditingObject.id=${id}&superiorCode=${currentCode}&status=${status}',leaf:false,hrefTarget:'childBasefrm'});
      	</s:else>
	</s:iterator>
	<s:iterator value="list">
		<s:if test="${empty(superiorCode) or superiorCode=='0'}">
		</s:if>
		<s:else>
		node_${superiorCode}.appendChild(node_${currentCode});
		</s:else>
	</s:iterator>
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 bodyBorder:false,
                //是否显示跟节点 rootVisible:false,
                 containerScroll: true});
        treePanel.setRootNode(root);
        treePanel.render();
        root.expand();
      });
</script>
</head>
<body>
<div id="tree"
			style="height: auto; width: 100%;"></div>
</body>
</html>