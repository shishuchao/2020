<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<HTML>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="../../css/site.css" rel="stylesheet" type="text/css">
		<TITLE> 参数设置导航</TITLE>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/portal/ext-all.css">
		<script type="text/javascript">
			Ext.onReady(function(){
			 var Tree = Ext.tree;
			 var root=new Tree.TreeNode({
		               id:'0',
		               text:'参数设置',
		               draggable:false //不允许拖拽
		        });
			 <s:iterator value="paramTree">
			 var node_${fid}=new Tree.TreeNode({id:'${fid}',text:'${fname}',href:'<%=request.getContextPath()%>/sysparam/sysParamAction!paramList.action?code=${fcode}',hrefTarget:'childBasefrm'});
			</s:iterator>
			<s:iterator value="paramTree">
				<s:if test="${ fpid!='0'}">
				node_${fpid}.appendChild(node_${fid});
				</s:if>
				<s:else>
			root.appendChild(node_${fid});
				</s:else>
			</s:iterator>
			 var treePanel=new Tree.TreePanel({
		                 el:'tree',
		                 useArrows:true,
		                 autoScroll:true,
		                 animate:false,
		                 enableDD:false,
		                 border:false,
		                 containerScroll: true});
		        treePanel.setRootNode(root);
		        treePanel.render();
		        root.expand();
		        treePanel.on('click',function(node,event){
		      	if(node.childNodes!=null && node.childNodes!=''){
		      		event.stopEvent();
		      	}
		      });
		      });
		</script>
	</HEAD>
	<body>
		<div id="tree" style="overflow: auto; width: 100%;"></div>
	</body>
</HTML>
