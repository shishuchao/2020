<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript"
	src="${contextPath}/scripts/portal/ext-base.js"></script>
<script type="text/javascript"
	src="${contextPath}/scripts/portal/ext-all.js"></script>
<link href="${contextPath}/styles/portal/ext-all.css" rel="stylesheet"
	type="text/css">

<script type="text/javascript">
	Ext.onReady(function(){
	Ext.QuickTips.init();
	 var Tree = Ext.tree;
	 var root=new Tree.TreeNode({
         id:'0',
         text:'公式分类',
         draggable:false, //不允许拖拽
       	 leaf:false
	  });
	 var node_0 = root;
	 var node_1=new Tree.TreeNode({
         id:'1',
         text:'系统公式',
         draggable:false, //不允许拖拽
       	 leaf:false
	  });
	  node_0.appendChild(node_1);
	  var node_2=new Tree.TreeNode({
         id:'2',
         text:'区域公式',
         draggable:false, //不允许拖拽
       	 leaf:false
	  });
	  node_0.appendChild(node_2);
	  var node_3=new Tree.TreeNode({
         id:'3',
         text:'单元格公式',
         draggable:false, //不允许拖拽
       	 leaf:false
	  });
	  node_0.appendChild(node_3);	  
     <s:iterator value="typeResult">
      	var node_${typeCode}=new Tree.TreeNode({
          	id:'${id}',
          	qtip:'${typeName}',
          	text:'${typeName}',
          	leaf:false
         });
	</s:iterator>
	<s:iterator value="typeResult">
  		node_${parentCode}.appendChild(node_${typeCode});
	</s:iterator>
	<s:iterator value="result">
		var node_${id}=new Tree.TreeNode({
			id:'${id}',
			qtip:'${cnName}',
			text:'公式：${funName}(${inParamCn})',
			leaf:false,
        	listeners:{
			"click":function(){
					var c = parent.leftTree;
					c.changeCellFormulaFromTree('${funName}');
				}
    		}
		});
  		node_${typeCode}.appendChild(node_${id});
	</s:iterator>
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 bodyBorder:false,
                 rootVisible:false,
                 containerScroll: true});
        treePanel.setRootNode(root);
        treePanel.render();
        root.expand();
      });
</script>
</head>
<body>
<div><input type="button" value="输入公式" onclick="parent.leftTree.openFormulaWizard()"></div>
<div id="tree" style="height: auto; width: 100%;"></div>
</body>
</html>