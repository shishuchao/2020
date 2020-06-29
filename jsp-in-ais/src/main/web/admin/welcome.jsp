<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>


<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
			<% 
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
response.setHeader("Pragma","no-cache"); //HTTP 1.0 
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
%>  
	  <META   HTTP-EQUIV="Pragma"   CONTENT="no-cache">     
  <META   HTTP-EQUIV="Cache-Control"   CONTENT="no-cache">     
  <META   HTTP-EQUIV="Expires"   CONTENT="0"> 
		<title>组织机构设置</title>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
		<script language="Javascript">
function RightGo(id,name)
{
 parent.childBasefrm.location.href='<%=request.getContextPath()%>/admin/editUOrg.action?view=view&uOrganization.fid='+id;
}
</script>
<script type="text/javascript">
	Ext.onReady(function(){
	 var Tree = Ext.tree;
	  var root = new Ext.tree.AsyncTreeNode({
		  text : '${ empty(name)? "根节点" : name}',   
          draggable : false,   
          id : '${ empty(id)? 0 : id }',
          href:'' 
                });   
    var loader=new Ext.tree.TreeLoader({url:'<%=request.getContextPath()%>/admin/asyUorg.action?message='+root.id});
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 rootVisible:${ empty(id)? 'false' : 'true'},
                 autoHeight:true,
                  loader:loader,
                //是否显示跟节点 rootVisible:false,
                 containerScroll: true});
     
     treePanel.on('beforeload',function(node){
                   treePanel.loader.url='<%=request.getContextPath()%>/admin/asyUorg.action?message='+node.attributes.id;
               }); 
                  treePanel.on("click", function(node, e){
               if(node.attributes.href==''){
               RightGo(node.attributes.id,node.attributes.text);
               }
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
	</body>
</html>
