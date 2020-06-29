<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript"
			src="${contextPath}/scripts/ext/ext-base.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ext/ext-all.js"></script>
		<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<link href="${contextPath}/styles/portal/ext-all.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/styles/main/main.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css">
		<style type="text/css">
.x-tree-node .x-tree-selected {
	background-color: #ffffff;
}
.ListTable {
	BACKGROUND-COLOR: #7CA4E9;
	VERTICAL-ALIGN: center;
	FONT-SIZE: 12px;
	COLOR: #000000;
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
         text:'公式列表',
         draggable:false//, //不允许拖拽
         //icon:'${contextPath}/images/openfoldericon.png'//自定义节点图标
	  });
	 var node_0 = root;
     <s:iterator value="templateMap">
      	var node_${key}=new Tree.TreeNode({
      		//icon: '${contextPath}/images/plusnew.gif',  
          	id:'${key}',
          	qtip:'${value}',
          	text:'${value}',
          	leaf:false
          	});
          	root.appendChild(node_${key});
          	node_${key}.on('contextmenu', function(node,event){
	      		event.preventDefault();
	      		node.select();
	      		rightClick.showAt(event.getXY());
          	});
	</s:iterator>
	<s:iterator value="formulaList">
      	var node_${id}=new Tree.TreeNode({
      		//icon: '${contextPath}/images/atta.gif',  
       		//iconCls: 'your-iconCls', 
          	id:'${id}',
          	text:'${formulaNameCn}',
          	leaf:false,
          	listeners:{
					"click":function(){
          				parent.formulafrm.location.href = '${contextPath}/ccrFormula/editFormula.action?formulaId=${id}';
					}
          		}
      	});
      		node_${id}.on('contextmenu', function(node,event){
      		event.preventDefault();
      		node.select();
      		rightClick_formula.showAt(event.getXY());
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
                 line:true,
                 bodyBorder:false,
                 rootVisible:true,
                 containerScroll: true});
        treePanel.setRootNode(root);
        treePanel.render();
        root.expand();
        
        
        
        var rightClick = new Ext.menu.Menu({
		id:'rightClickCont',
		items:[{
			id:'rMenuAdd',
			text:'添加公式',
			handler:function(){
			var template = treePanel.getSelectionModel().getSelectedNode();
			parent.formulafrm.location.href = '${contextPath}/ccrFormula/editFormula.action?templateId='+template.id;
			}
		}]
	});
      
        var rightClick_formula = new Ext.menu.Menu({
			id:'rightClickFormula',
			items:[{
				id:'rMenuEdit',
				text:'编辑公式' ,
				handler:function(){
					var formulaNode = treePanel.getSelectionModel().getSelectedNode();
					parent.formulafrm.location.href = '${contextPath}/ccrFormula/editFormula.action?formulaId=' + formulaNode.id;
				}
			},{
				id:'rMenuDel',
				text:'删除公式' ,
				handler:function(){
					var formulaNode = treePanel.getSelectionModel().getSelectedNode();
					if(delFormula(formulaNode.id)){
							formulaNode.remove();
						}
				}
			}]
		})
   });
	
		function delFormula(formulaId){
				var flag = false;
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/ccrFormula', action:'deleteFormula', executeResult:'false' }, 
				{ 'formulaId':formulaId},
				xxx);
			    function xxx(data){
			    	if(data['message'] != null && data['message'] != ''){
			    		if(data['message'] == '1'){
			    			alert('公式以被引用，删除未成功！');
			    		}
			    		if(data['message'] == '2'){
			    			alert('成功删除！');
			    			flag = true;
			    		}
			    	}
			    }
			    return flag;
			}

	
</script>
	</head>
	<body>
		<%--<center>
			<table id="tableTitle" width="90%" border=0 cellPadding=0
				cellSpacing=1 bgcolor="#409cce" class=ListTable>
				<tr class="listtablehead">
					<td align="left" class="edithead">
						公式列表
					</td>
				</tr>
			</table>
		</center>
		--%><div id="tree"
			style="height: auto; width: 100%; margin-top: 15; margin-left: 5"></div>
	</body>
</html>