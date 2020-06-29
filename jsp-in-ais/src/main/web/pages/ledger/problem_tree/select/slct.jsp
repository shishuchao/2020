<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

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
	 <s:iterator value="ltnList">
	 
	 	<s:if test="${empty (fid) or fid=='0' }">
        var root=new Tree.TreeNode({
               id:'${id}',
               text:'<s:property value="name"/>',
               fname:'${fname}',
               fid:'${fid}',
               isSort:'${isSort}',
               draggable:false //不允许拖拽
                                     // icon:'im2.gif'//自定义节点图标
        });
        var node_${id}=root;
       </s:if>
      <s:else>
      		var node_${id}=new Tree.TreeNode({id:'${id}',text:'${name}',isSort:'${isSort}',fname:'${fname}',fid:'${fid}'});
      </s:else> 
	</s:iterator>
	<s:iterator value="ltnList">
		<s:if test="${ not empty (fid) and fid!='0'}">
		node_${fid}.appendChild(node_${id});
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
        	if(node.attributes.isSort&&node.attributes.isSort=='N'){
        		var ids=node.id,text=node.text;
        		var temp=node.attributes.fid;
	        	while(temp&&temp.length!=0&&temp!='0'){
	        		ids+="#"+temp;
	        		text+="#"+node.attributes.fname;
	        		node=node.parentNode;
	        		temp=node.attributes.fid;
	        	}
	        	getSelectedValue(ids,text);
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
<input type=hidden id="paranamevalue">
<input type=hidden id="paraidvalue">
  </body>
</html>