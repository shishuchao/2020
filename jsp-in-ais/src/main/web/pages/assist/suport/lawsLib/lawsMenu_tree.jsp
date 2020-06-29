<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function getSelectedValue(id,name)
{
  document.all("paranamevalue").value=name;
  document.all("paraidvalue").value=id;
}
</script>
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
               //href:'../lawsLib/editMenu.action?m_view=view&nodeid=${id}',
               //hrefTarget:'childBasefrm',
               draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
        var node_${id}=root;
       </s:if>
      <s:else>
      	<s:if test="${!isHaveChild}">
      		var node_${id}=new Tree.TreeNode({id:'${id}',text:'${category_name}'});
      	</s:if>
      	<s:else>
      		var node_${id}=new Tree.TreeNode({id:'${id}',text:'${category_name}'});
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
        treePanel.addListener("click",function(node){
        	getSelectedValue(node.id,node.text);
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