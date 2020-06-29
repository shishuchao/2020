<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<title>内部消息列表</title>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>

<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript">
	Ext.onReady(function(){
	 var Tree = Ext.tree;
	 var root =new Ext.tree.TreeNode({id:-1,text:'所有消息'});
	 root.appendChild(new Ext.tree.TreeNode({id:2,text:'未读消息'}));
	 root.appendChild(new Ext.tree.TreeNode({id:1,text:'已读消息'}));
	 root.appendChild(new Ext.tree.TreeNode({id:3,text:'已发消息'}));
	 root.appendChild(new Ext.tree.TreeNode({id:4,text:'已发邮件'}));
	 
   var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 autoHeight:false,                 
                 rootVisible:true,
                 containerScroll: true});
   
         treePanel.on('beforeclick',function(node,e){
                   if(node.attributes.href==undefined){
                	//   alert(node.id);
                   	parent.childBasefrm.location.href='<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag='+node.attributes.id;
                   };
               });  
        treePanel.setRootNode(root); 
        treePanel.render();
        root.expand();
      });
</script>
</head>
<body>
<div id="tree" style="overflow: auto; height: 100%; width: 100%;"></div>
</body>
</html>
