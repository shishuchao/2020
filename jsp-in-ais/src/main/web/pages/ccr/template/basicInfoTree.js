Ext.onReady(function(){
	var Tree = Ext.tree;
	//定义根节点的Loader 
	var treeloader = new Tree.TreeLoader({dataUrl:'${contextPath }/ccrTemplate/basicInfoJSON.action?id=0'});
	 //异步加载根节点
	var rootnode = new Tree.AsyncTreeNode({
		id:'0',
		text:'基础信息'
	});
	
	var treePanel = new Tree.TreePanel({
		 
        el:'tree',        //显示区域
        rootVisible:false,     //显示根节点 
        border:false,          //边框
        animate:true,         //动画
        autoScroll:true,      //自动滚动
        enableDD:false,       //拖拽           
        containerScroll:true, 
        loader:treeloader,
        listeners:{
        	'dblclick':function(node,event){
        		if(node.leaf){
        			var c =parent.parent.childBasefrm;
					c.setS(node.text);
					alert('设置成功');
        		}
        	}
        }
	});
	
	//设置根节点
	treePanel.setRootNode(rootnode);
	
	treePanel.on('beforeload',
			function(node){
			treePanel.loader.dataUrl = '${contextPath }/ccrTemplate/basicInfoJSON.action?id='+ node.id;
	});
	treePanel.render();            
	rootnode.expand(false,false); 
});