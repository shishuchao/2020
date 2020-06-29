<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="${contextPath}/scripts/ext/ext-base.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ext/ext-all.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<link href="${contextPath}/styles/ext/ext-all.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/main/main.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.x-tree-node .x-tree-selected{background-color:#ffffff;}
	.ListTable
		{
			BACKGROUND-COLOR:#7CA4E9;
			VERTICAL-ALIGN:center;
			FONT-SIZE: 12px;
			COLOR:#000000;
			margin: 20px;
		}	
</style>
	<script type="text/javascript">
	var text_id;
	var treePanel;
	Ext.onReady(function(){
	Ext.QuickTips.init();
	 var Tree = Ext.tree;
	 var root=new Tree.TreeNode({
         id:'0',
         text:'标准科目',
         draggable:false //不允许拖拽
                               // icon:'im2.gif'//自定义节点图标
	  });
	 var node_0 = root;
     <s:iterator value="templateMap">
      	var node_${key}=new Tree.TreeNode({
          	id:'${key}',
          	qtip:'${value}',
          	text:'${value}',
          	leaf:false
          	
          	});
          	root.appendChild(node_${key});
	</s:iterator>
	<s:iterator value="formulaList">
      	var node_${id}=new Tree.TreeNode({
          	id:'${id}',
          	text:'${formulaNameCn}',
          	leaf:false,
          	listeners:{
					"dblclick":function(){
								var c =parent.parent.childBasefrm;
								c.openFormulaWizard();
								c.changeCellFormulaFromTree('${formulaName }');
								c.changeCellNoteFromTree('${formulaName }');
								alert('设置成功');
								c.changeCellColor();
					}
          		}
          	
      	});
	</s:iterator>
		<s:iterator value="formulaList">
		 	node_${templateType}.appendChild(node_${id});
		</s:iterator>
	 var treePanel=new Tree.TreePanel({
                 el:'tree',
                 useArrows:true,
                 autoScroll:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 bodyBorder:false,
                 rootVisible:false,
                 containerScroll: true});
        treePanel.setRootNode(root);
        treePanel.render();
        root.expand();
   });
	
		
	
</script>
</head>
<body >
<center>
<table id="tableTitle" width="90%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable >
				<tr class="listtablehead">
					<td align="left" class="edithead">
							公式列表
					</td>
				</tr>
			</table>
			</center>
<div id="tree"
			style="height: auto; width: 100%; margin-top: 15; margin-left: 5" ></div>
</body>
</html>