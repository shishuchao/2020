<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<title>组织机构设置</title>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
		<script language="Javascript">
function getSelectedValue(id,name)
{
  document.all("paranamevalue").value=name;
  document.all("paraidvalue").value=id;
}
</script>
<script type="text/javascript">
	Ext.onReady(function(){
	 var Tree = Ext.tree;
	  var root = new Ext.tree.AsyncTreeNode({
                    text : '根节点',   
                    draggable : false,
                    expandable:true,   
                    id : '0'  
                });   
    var loader=new Ext.tree.TreeLoader({url:'<%=request.getContextPath()%>/system/uSystemAction!asynOrgType.action'});
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 rootVisible:false, 
                 autoHeight:true,
                 loader:loader,
                rootVisible:false,
                 containerScroll: true});
     
     treePanel.on('beforeload',function(node){
     				//if(node.attributes.id!='rootid')
                   treePanel.loader.url='<%=request.getContextPath()%>/system/uSystemAction!asynOrg.action?nodeid='+node.attributes.id;
               }); 
               treePanel.on("click", function(node, e){ 
             //  if(node.attributes.type!='1'){//现在没有抽调引用的页面，如需要需进行条件判断
               getSelectedValue(node.attributes.id,node.attributes.text);
               //}
               }); 
  
               treePanel.setRootNode(root);   
        treePanel.render();
        root.expand();
      });
</script>
	</head>
	<body>
	<div id="tree"
			style="overflow: auto; height: 100%; width: 100%;"></div>
			<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
	</body>
</html>
