<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
  <head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题选择</title> 
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
	 <s:iterator value="ltnList">
	 	<s:if test="${empty (fid) or fid=='0' }">
        var root=new Tree.TreeNode({
               id:'${id}',
               text:'${name}',
               fname:'${fname}',
               fid:'${fid}',
               isSort:'${isSort}',
               draggable:false, //不允许拖拽
               expandable :true,
               checked:false
                                     // icon:'im2.gif'//自定义节点图标
        });
        var node_${id}=root;
       </s:if>
      <s:else>
       	<s:if test="${isSort=='Y'}">
      		var node_${id}=new Tree.TreeNode({id:'${id}',text:'${name}',isSort:'${isSort}',fname:'${fname}',fid:'${fid}'});
      	</s:if>
        <s:else>
  			var node_${id}=new Tree.TreeNode({id:'${id}',text:'${name}',isSort:'${isSort}',fname:'${fname}',fid:'${fid}', checked:false});
        </s:else>
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
                 //loader:loader,
                 rootVisible:false,//是否显示跟节点
                 containerScroll: true
                 });
	 treePanel.on('beforeload',function(node){
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