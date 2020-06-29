<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>内控测评目录树</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
			var treePanel;
			Ext.onReady(function(){
				var Tree = Ext.tree;
				var root = new Ext.tree.AsyncTreeNode({
                    text : '${rootCategory.name}',
                    draggable : false,
                    id : '${rootCategory.id}'  
                });
		    	var loader=new Ext.tree.TreeLoader({url:'${contextPath}/nkcp/template/asyCategoryTree.action?categoryId='+root.id});
				treePanel=new Tree.TreePanel({
	                 el:'tree',
	                 useArrows:true,
	                 autoScroll:true,
	                 animate:false,
	                 enableDD:false,
	                 border:false,
	                 rootVisible:true, 
	                 autoHeight:true,
	                 loader:loader,
	                 containerScroll: true
		         });
		     
		     	treePanel.on('beforeload',function(node){
                	treePanel.loader.url='${contextPath}/nkcp/template/asyCategoryTree.action?categoryId='+node.attributes.id;
                });
		     	treePanel.on('beforeclick',function(node,e){
	                if(typeof node.attributes.href=='undefined'){
	                	parent.childBasefrm.location.href='${contextPath}/nkcp/template/tabpanel.action?categoryId='+node.attributes.id;
	                };
                });
		    	treePanel.setRootNode(root);
		        treePanel.render();
		        root.expand();
		    });
		</script>
	</head>
	<body>
		<div id="tree" ></div>
		<br />
		<br />
		<div id="buttonDiv">
			<button onclick="addCategory()">新增</button>
			<button onclick="modifyCategory()">修改</button>
			<button onclick="deleteCategory()">删除</button>
		</div>
		<s:form id="categoryForm" action="saveCategory" namespace="/nkcp/template" >
			<s:hidden id="id" name="rootCategory.id" />
			<s:hidden id="name" name="rootCategory.name" />
			<s:hidden id="pid" name="rootCategory.pid" />
		</s:form>
		<script type="text/javascript">
			/*
			*	新增
			*/	
			function addCategory(){
				var selectedNode = treePanel.getSelectionModel().getSelectedNode();
				if(selectedNode==null 
						|| selectedNode.attributes.id=="-1")	{
			    	alert("请选择一个上级节点!");    
			    	return;
			    }
				document.getElementById('id').value='';
				document.getElementById('name').value = '';
				document.getElementById('pid').value = '';
				var newName = window.showModalDialog('${contextPath}/pages/nkcp/template/edit_category.jsp',window,'dialogWidth:500px;dialogHeight:300px;status:yes');
				if(newName==null || newName==''){
					return ;
				}
				var parentCategoryId = selectedNode.attributes.id;
				document.getElementById('pid').value = parentCategoryId;
				document.getElementById('name').value = newName;
				document.getElementById('categoryForm').submit();
			}
			/*
			*	修改
			*/	
			function modifyCategory(){
				var selectedNode = treePanel.getSelectionModel().getSelectedNode();
				if(selectedNode==null 
						|| selectedNode.attributes.id=="-1")	{
			    	alert("请选择一个节点!");    
			    	return;
			    }
				document.getElementById('id').value = selectedNode.attributes.id;
				document.getElementById('name').value = selectedNode.attributes.name;
				document.getElementById('pid').value = selectedNode.attributes.pid;
				var newName = window.showModalDialog('${contextPath}/pages/nkcp/template/edit_category.jsp',window,'dialogWidth:700px;dialogHeight:450px;status:yes');
				if(newName==null || newName==''){
					return ;
				}
				document.getElementById('name').value = newName;
				document.getElementById('categoryForm').submit();
			}
			/*
			*	删除
			*/	
			function deleteCategory(){
				var selectedNode = treePanel.getSelectionModel().getSelectedNode();
				if(selectedNode==null 
						|| selectedNode.attributes.id=="-1")	{
			    	alert("请选择一个节点!");    
			    	return;
			    }
				if(confirm('确认要删除内控节点吗？执行此操作后节点和它所有的下级节点以及节点的调查项与测试项都将会被删除！')){
					var categoryId = selectedNode.attributes.id;
					window.location.href="/ais/nkcp/template/deleteCategory.action?categoryId="+categoryId;
				}
			}
		</script>
	</body>
</html>
