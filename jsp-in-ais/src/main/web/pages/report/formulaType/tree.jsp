<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="${contextPath}/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/portal/ext-all.js"></script>
		<link href="${contextPath}/styles/portal/ext-all.css" rel="stylesheet" type="text/css">

	<script type="text/javascript">
	Ext.onReady(function(){
	Ext.QuickTips.init();
	 var Tree = Ext.tree;
	 var root=new Tree.TreeNode({
         id:'0',
         text:'公式分类',
         href:'about:blank',
         hrefTarget:'childBasefrm',
         draggable:false //不允许拖拽
	  });
	 var node_0 = root;
	 var node_1=new Tree.TreeNode({
         id:'1',
         text:'系统公式',
         href:'${contextPath}/report/formulatype/edit.action?parentCode=1&attributeCode=1',
         hrefTarget:'childBasefrm',
         draggable:false //不允许拖拽
	  });
	  node_0.appendChild(node_1);
	  var node_2=new Tree.TreeNode({
         id:'2',
         text:'区域公式',
         href:'${contextPath}/report/formulatype/edit.action?parentCode=2&attributeCode=2',
         hrefTarget:'childBasefrm',
         draggable:false //不允许拖拽
	  });
	  node_0.appendChild(node_2);
	  var node_3=new Tree.TreeNode({
         id:'3',
         text:'单元格公式',
         href:'${contextPath}/report/formulatype/edit.action?parentCode=3&attributeCode=3',
         hrefTarget:'childBasefrm',
         draggable:false //不允许拖拽
	  });
	  node_0.appendChild(node_3);	  
     <s:iterator value="result">
      	var node_${typeCode}=new Tree.TreeNode({id:'${id}',qtip:'${typeName}',text:'${typeName}',href:'${contextPath}/report/formulatype/view.action?id=${id}&parentCode=${parentCode}&attributeCode=${attributeCode}',leaf:false,hrefTarget:'childBasefrm'});
	</s:iterator>
	<s:iterator value="result">
  		node_${parentCode}.appendChild(node_${typeCode});
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