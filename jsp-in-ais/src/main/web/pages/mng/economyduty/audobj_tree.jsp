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
<script type="text/javascript">
	Ext.onReady(function(){
	Ext.QuickTips.init();
	 var Tree = Ext.tree;
     <s:iterator id="tree" value="treeList">
     	<s:if test="${empty(superiorCode) or superiorCode=='0'}">
	        var root = new Tree.TreeNode({
	        	id:'${id}',
	            text:'${name}',
	            <s:if test="${isClick == 'Y'}">
	            href:'${contextPath}/mng/economyduty/economyDutyAction!list.action?audobjid=${id}&status=${param.status}',
	            </s:if>
	            <s:else>
	            href:'${contextPath}/pages/mng/audobj/fail.jsp',
	            </s:else>
	            hrefTarget:'_basefrm',
	            draggable:false //不允许拖拽
				//icon:'im2.gif'//自定义节点图标
	        });
    	    var node_${currentCode}=root;
        </s:if>
        <s:else>
	      	var node_${currentCode} = new Tree.TreeNode({
    	  		id:'${id}',
    	  		qtip:'${name}',
    	  		text:'${name}',
	            <s:if test="${isClick == 'Y'}">
    	  		href:'${contextPath}/mng/economyduty/economyDutyAction!list.action?audobjid=${id}&status=${param.status}',
	            </s:if>
	            <s:else>
	            href:'${contextPath}/pages/mng/audobj/fail.jsp',
	            </s:else>
    	  		leaf:false,
    	  		hrefTarget:'_basefrm'
    	  	});
      	</s:else>
	</s:iterator>
	<s:iterator value="treeList">
		<s:if test="${empty(superiorCode) or superiorCode=='0'}">
		</s:if>
		<s:else>
			node_${superiorCode}.appendChild(node_${currentCode});
		</s:else>
	</s:iterator>
	var treePanel = new Tree.TreePanel({
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
	<div id="tree" style="height: auto; width: 100%;"></div>
</body>
</html>