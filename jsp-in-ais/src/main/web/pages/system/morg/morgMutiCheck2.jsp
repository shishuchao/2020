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
		var ids=[];
		var names=[];
function getSelectedValue()
{
  document.all("paraidvalue").value=ids.toString();
  document.all("paranamevalue").value=names.toString();
}
</script>
<script type="text/javascript">
	Ext.onReady(function(){
	 var Tree = Ext.tree;
	  var root = new Ext.tree.AsyncTreeNode({
                    text : '${name}',   
                    draggable : false,
                    expandable:true,
                    checked:false,   
                    id : '${id}'  
                });   
    var loader=new Ext.tree.TreeLoader({url:'<%=request.getContextPath()%>/system/uSystemAction!asynOrgType.action'});
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 autoHeight:true,
                 loader:loader,
                rootVisible:true,
                 containerScroll: true});
     
     treePanel.on('beforeload',function(node){
                   treePanel.loader.url='<%=request.getContextPath()%>/system/uSystemAction!asynOrg.action?nodeid='+node.attributes.id;
               }); 
     treePanel.on('checkchange',function(node,c){
                   if(node.attributes.checked){
                   	ids[ids.length]=node.attributes.id;
                   	names[names.length]=node.attributes.text;
                   }else{
                   		delIds(ids,names,node.attributes.id);
                   }
               }); 
     treePanel.on('load',function(node){
                   aa=node.childNodes;
                   if(aa||aa.length!=0){
                   	for(i=0;i<aa.length;i++){
                   		aa[i].attributes.checked=false;
                   	}
                   }
               }); 
               treePanel.setRootNode(root);   
        treePanel.render();
        root.expand();
      });
      function delIds(ids,names,id){
      	for(i=0;i<ids.length;i++){
      		if(ids[i]==id){
      			ids.splice(i,1);
      			names.splice(i,1);
      			break;
      		}
      	}
      }
</script>
	</head>
	<body>
	<div id="tree"
			style="overflow: auto; height: 100%; width: 100%;"></div>
			<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
	</body>
</html>
