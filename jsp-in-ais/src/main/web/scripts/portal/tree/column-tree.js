/*
 * Ext JS Library 2.0
 * Copyright(c) 2006-2007, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

Ext.onReady(function(){
    var tree = new Ext.tree.ColumnTree({
        el:'tree-ct',
        width:552,
        autoHeight:true,
        rootVisible:false,
        autoScroll:true,
        title: 'Example Tasks',
        columns:[{
            header:'Task',
            width:350,
            dataIndex:'task'
        },{
            header:'Duration',
            width:100,
            dataIndex:'duration'
        },{
            header:'Assigned To',
            width:100,
            dataIndex:'user'
        }],

        loader: new Ext.tree.TreeLoader({
            dataUrl:'/ais/pages/operate/template/opr_template_tree.jsp',
			baseParams:{},
            uiProviders:{
                'col': Ext.tree.ColumnNodeUI
            }
        }),

        root: new Ext.tree.AsyncTreeNode({
            text:'Tasks'
        })
    });
    tree.render();
    tree.on('load',function(node){
    	if(node.ui.getTextEl()){
    		var obj=node.ui.getTextEl().parentNode.parentNode.parentNode;
    		if(obj)obj.childNodes[1].childNodes[0].attachEvent('onmouseover',function(){att(obj.childNodes[1].childNodes[0])});
    	}
    });
    tree.on('beforeload',function(node){
    	
     });
    tree.on('beforeappend',function(tree,node,node2){
    	//alert(node2.attributes.task);iconCls
    	if(node2.attributes.leaf){node2.attributes.iconCls='task';}else{node2.attributes.iconCls='task-folder';}
    	if(node2.attributes.leaf){node2.attributes.user="<img src='album.gif'>"+node2.attributes.user;}
		if(node2.attributes&&node2.attributes.user){tree.loader.baseParams={abc:'qqq'};}
		alert(tree.loader.dataUrl+"?"+tree.loader.baseParams);
     });
    tree.on('click',function(node,e){
    	alert(node.attributes.user);
    });
	
});
function att(obj){obj.style.background="red";}
function me(obj){var ss="";for( var s in obj){ss+=" "+s+"=>"+obj[s];ss+="\r\n";}alert(ss);return ss;}
function me_not_null(obj){var ss="";for( var s in obj){if(obj[s]){ss+=" "+s+"=>"+obj[s];ss+="\r\n";}}alert(ss);}