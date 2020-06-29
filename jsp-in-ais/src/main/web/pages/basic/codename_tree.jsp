<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<HTML>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">	
		<TITLE> code tree </TITLE>
		
		<link rel="stylesheet" type="text/css" href="../../css/site.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/portal/ext-all.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<script type="text/javascript">
			Ext.onReady(function(){
			 var Tree = Ext.tree;
			 <s:iterator value="l">
			 	<s:if test="${pid=='0'}">
		        var root=new Tree.TreeNode({
		               id:'${id}',
		               text:'<s:property value="name"/>',
		               href:'<%=request.getContextPath()%>/basic/codename/list2.action?codeHead.pid=${id}',
		               hrefTarget:'childBasefrm',
		               draggable:false //不允许拖拽
		                                     // icon:'im2.gif'//自定义节点图标
		        });
		        var node_${id}=root;
		       </s:if>
		      <s:else>
		      	<s:if test="${code=='0'}">
		      		var node_${id}=new Tree.TreeNode({id:'${id}',text:'${name}',leaf:false,href:'<%=request.getContextPath()%>/basic/codename/list2.action?codeHead.pid=${id}',hrefTarget:'childBasefrm'});
		      	</s:if>
		      	<s:else>
		      		var node_${id}=new Tree.TreeNode({id:'${id}',text:'${name}',href:'<%=request.getContextPath()%>/basic/codename/list.action?type=${code}&codeHead.id=${id}',hrefTarget:'childBasefrm'});
		      	</s:else>
		      </s:else> 
			</s:iterator>
			<s:iterator value="l">
				<s:if test="${ pid!='0'}">
				node_${pid}.appendChild(node_${id});
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
		        treePanel.setRootNode(root);
		        treePanel.render();
		        root.expand();
		        treePanel.on('click',function(node,event){
			      	if(node.childNodes.length>0){
			      		event.stopEvent();
			      		href='<%=request.getContextPath()%>/basic/codename/list2.action?codeHead.pid='+node.id;
			      		window.parent.childBasefrm.location.href=href;
			      	}
		      });
		      });
		</script>
	</head>
	
	<body>
		<div id="tree" style="overflow: auto; width: 100%;"></div>
	</body>
</HTML>
