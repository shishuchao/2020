<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="<%=request.getContextPath()%>/resources/css/site.css"
			rel="stylesheet" type="text/css">
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		<script type="text/javascript">
			Ext.onReady(function(){
				var Tree = Ext.tree;
			    var root = new Tree.AsyncTreeNode({
			    	id:'${statistic_category.id}',
					text:'${statistic_category.name}',
					ntype:'${statistic_category.isSort}',
					leaf:false,
					expandable:true,
					expanded:false,
					draggable:false
			    });
		    	var loader = new Ext.tree.TreeLoader({url:'${contextPath}/ledger/problemledger/statisticRreeExpand.action?id=' + root.id});
				var treePanel = new Tree.TreePanel({
					//title:"Extjs静态树",
					el:'container',
					useArrows:true,
					autoScroll:true,
					animate:false,
					enableDD:false,
					border:false,
					bodyBorder:false,
					loader:loader,
					rootVisible:true,
					containerScroll:true
				});
				treePanel.on('beforeload',function(node){
					treePanel.loader.url = '${contextPath}/ledger/problemledger/statisticRreeExpand.action?id=' + node.attributes.id;
            	});  
				treePanel.on('click',function(node){
					window.parent.frames[1].location.href = '${contextPath}/ledger/problemledger/statisticListFrame.action?view=${view}&id=' + node.attributes.id;
            	});  
				treePanel.setRootNode(root);
				treePanel.render();
				root.expand();
			});
		</script>
	</head>

	<body>
		<div id="container" style="height:100%; width: 100%;"></div>
	</body>
</html>