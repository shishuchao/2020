<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	Ext.onReady(function(){
	 var Tree = Ext.tree;
	 <s:iterator value="m_list">
	 	<s:if test="${empty(parent_id)}">
        var root=new Tree.TreeNode({
               id:'${id}',
               text:'<s:property value="category_name"/>',
               href:'../lawsLib/editMenu.action?m_view=view&nodeid=${id}',
               hrefTarget:'childBasefrm',
               draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
        var node_${id}=root;
       </s:if>
      <s:else>
      	<s:if test="${!isHaveChild}">
      		var node_${id}=new Tree.TreeNode({id:'${id}',text:'${category_name}',href:'../lawsLib/editMenu.action?m_view=view&nodeid=${id}',leaf:true,hrefTarget:'childBasefrm'});
      	</s:if>
      	<s:else>
      		var node_${id}=new Tree.TreeNode({id:'${id}',text:'${category_name}',href:'../lawsLib/editMenu.action?m_view=view&nodeid=${id}',leaf:false,hrefTarget:'childBasefrm'});
      	</s:else>
      </s:else> 
	</s:iterator>
	<s:iterator value="m_list">
		<s:if test="${ not empty(parent_id)}">
		node_${parent_id}.appendChild(node_${id});
		</s:if>
	</s:iterator>
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
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