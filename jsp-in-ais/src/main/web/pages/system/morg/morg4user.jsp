<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	request.setAttribute("p_item",request.getParameter("p_item"));
 %>

<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<title>组织机构设置</title>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
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
function changeVg(){
//parent.main.location.href='';
<s:url id="vgurl"    action="uSystemAction"  method="getVgList4user" namespace="/system"/>
window.location.href='<s:text name="%{vgurl}"/>';
}
</script>
<script type="text/javascript">
	Ext.onReady(function(){
	 var Tree = Ext.tree;
	  var root = new Ext.tree.AsyncTreeNode({
                    text : '${ empty (p_item) ? '根节点' : company.fname}',   
                    draggable : false,
                    expandable:true,   
                    id : '${ empty (p_item) ? '0' : company.fid}'  
                });   
    var loader=new Ext.tree.TreeLoader({url:'<%=request.getContextPath()%>/system/uSystemAction!asynOrgType.action'});
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 rootVisible:${ empty (p_item) ? 'false' : 'true'}, 
                 autoHeight:true,
                 loader:loader,
                 containerScroll: true});
     
     treePanel.on('beforeload',function(node){
     				//if(node.attributes.id!='0')
                   //treePanel.loader.url='<%=request.getContextPath()%>/system/uSystemAction!asynOrg.action?nodeid='+node.attributes.id+'&nodetype='+node.attributes.type;
                   treePanel.loader.url='<%=request.getContextPath()%>/system/uSystemAction!asynOrg.action?nodeid='+node.attributes.id;
               });
                
               treePanel.on("click", function(node, e){ 
               //if(node.attributes.type!='1'){
               	RightGo(node.attributes.id,node.attributes.text);
               //}
               }); 
  
               treePanel.setRootNode(root);   
        treePanel.render();
        root.expand();
      });
</script>
	</head>
	<body>
	<!-- 
	 <input type="radio" name="rgname" checked="checked"/>组织机构&nbsp;&nbsp;<input type="radio" name="rgname" onclick="changeVg()"/>人员群组
	 -->
	<div id="tree"
			style="overflow: auto; height: 89%; width: 100%;"></div>
	</body>
</html>
