<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function RightGo(id,name)
{
<s:url id="url"    action="uSystemAction"  method="getUserList" namespace="/system"/>
var url='<s:text name="%{url}"/>';
if(url.indexOf('?')!=-1)
url=url+'&amp;';
else
url=url+'?';
  parent.main.location.href=url+'p_deptid='+id+'&amp;p_deptname='+encodeURIComponent(name);
}
</script>

<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
		<script language="Javascript">
function RightGo(id,name)
{
 parent.childBasefrm.location.href='<%=request.getContextPath()%>/system/uSystemAction!getUserList.action?noMenu4User=t&p_issel=5&p_deptid='+id+'&p_deptname='+name;
}
</script>
<script type="text/javascript">
      	Ext.onReady(function(){
	 var Tree = Ext.tree;
	  var root = new Ext.tree.AsyncTreeNode({
                    text : '根节点',   
                    draggable : false,   
                    id : '0'  
                });   
    var loader=new Ext.tree.TreeLoader({url:'<%=request.getContextPath()%>/system/uSystemAction!asyUorg.action?u='+root.id});
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:false,
                 animate:false,
                 enableDD:false,
                 border:false,
                 rootVisible:false, 
                 autoHeight:true,
                  loader:loader,
                //是否显示跟节点 rootVisible:false,
                 containerScroll: true});
     
     treePanel.on('beforeload',function(node){
                   treePanel.loader.url='<%=request.getContextPath()%>/system/uSystemAction!asyUorg.action?u='+node.attributes.id;
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
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
 	<div id="sellist" class="datalist" ondelrow="reCount()"></div>
	<div id="tree" style="overflow: auto; height: 100%; width: 100%;"></div>
  </body>
</html>