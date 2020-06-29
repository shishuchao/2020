<%@ page language="java" contentType="text/html;charset=utf-8"%>
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
	//Ext.QuickTips.init();//去除提示
	 var Tree = Ext.tree;
	 var root=new Tree.TreeNode({
               id:'1',
               text:'&nbsp;功能树',
               href:'/ais/system/omAdd.action?isMenu=Y&abf.ffunid=1',
               hrefTarget:'childBasefrm',
               draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
	 <s:iterator value="menulist">
      	<s:if test="${isHaveChild}">
      		var node_${ffunid}=new Tree.TreeNode({id:'${ffunid}',qtip:'${ffundisplay}(${ffunid})',text:'${ffundisplay}(${ffunid})',href:'/ais/system/omEdit.action?view=view&abf.ffunid=${ffunid}',leaf:true,hrefTarget:'childBasefrm'});
      	</s:if>
      	<s:else>
      		var node_${ffunid}=new Tree.TreeNode({id:'${ffunid}',qtip:'${ffundisplay}(${ffunid})',text:'${ffundisplay}(${ffunid})',href:'/ais/system/omEdit.action?view=view&abf.ffunid=${ffunid}',leaf:false,hrefTarget:'childBasefrm'});
      	</s:else>
	</s:iterator>
	<s:iterator value="menulist">
		<s:if test="${fparentid==1}">
		root.appendChild(node_${ffunid});
		</s:if>
		<s:else>
		node_${fparentid}.appendChild(node_${ffunid});
		</s:else>
	</s:iterator>
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                //是否显示跟节点 rootVisible:false,
                 containerScroll: false});
        treePanel.setRootNode(root);
        treePanel.render();
        root.expand();
      });
</script>
</head>
<body>
<div id="tree"
			style=" height: auto; width: 100%;"></div>
</body>
</html>