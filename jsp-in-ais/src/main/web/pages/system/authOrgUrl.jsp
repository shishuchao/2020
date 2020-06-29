<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>
		<meta http-equiv="X-UA-Compatible" content="IE=5">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/portal/ext-all.css"> 
		<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/portal/ext-base.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/portal/ext-all.js"></script>
		
		<script type="text/javascript">
			Ext.onReady(function(){
			 	var Tree = Ext.tree;
		        var root=new Tree.TreeNode({
		               id:'0',
		               text:'&nbsp;数据授权',
		               draggable:false //不允许拖拽
		                                     // icon:'im2.gif'//自定义节点图标
		        });
				<s:if test="${ empty (view) }">
					<s:iterator value="abmList">
			      		var node_${fmoduleid}=new Tree.TreeNode({id:'${fmoduleid}',text:'${fname}',href:'<s:property value="fcfgclass"/>?fmoduleId=<s:property value="fmoduleid"/>&selectedLoginName=<s:property value="selectName"/>',leaf:true,hrefTarget:'selectspace'});
					</s:iterator>
 				</s:if>
 				<s:else>
				 	<s:iterator value="abmList">
						var node_${fmoduleid}=new Tree.TreeNode({id:'${fmoduleid}',text:'${fname}',href:'<s:property value="fcfgclass"/>?fmoduleId=<s:property value="fmoduleid"/>&selectedLoginName=<s:property value="selectName"/>&view=view&fscopecode=${fscopecode}&companyId=${companyId}',leaf:true,hrefTarget:'selectspace'});
					</s:iterator>
 				</s:else>
				<s:iterator value="abmList">
					root.appendChild(node_${fmoduleid});
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
      			});
		</script>
	</head>
	<body>
		<div id="tree" style="overflow: auto;"></div>
	</body>
</html>