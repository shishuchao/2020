var appcontext='/ais';
var panleHeight = 30;
Ext.BLANK_IMAGE_URL = appcontext+'/cloud/styles/extjs/resources/images/default/s.gif';
Ext.QuickTips.init();
Usp = {
    version : '1.0',
    west:null,
    north:null,
    center:null,
    main:null,
    setText:function(text){
    var sb = Ext.getCmp('statusbar');
    if(isObject(sb))
    sb.setText('<div class="usp-status-text">'+text+"</div>");
	
    },
    setInfo:function(text){
    var sb = Ext.getCmp('statusbar');
    if(isObject(sb))
    sb.setText('<div class="usp-status-info">'+text+"</div>");
    }
};


/**
 * @class Ext.grid.RadioboxSelectionModel
 * @extends Ext.grid.RowSelectionModel
 * A custom selection model that renders a column of checkboxes that can be toggled to select or deselect rows.
 * @constructor
 * @param {Object} config The configuration options
 */
Ext.grid.RadioboxSelectionModel = Ext.extend(Ext.grid.RowSelectionModel, {
    //header: '<div class="x-grid3-hd-radio">&#160;</div>',
    header:null,
    singleSelect:true,
    width: 20,
    sortable: false,
	menuDisabled:true,
    fixed:true,
    dataIndex: '',
    id: 'checker',
    // private
    initEvents : function(){
        Ext.grid.RadioboxSelectionModel.superclass.initEvents.call(this);
        this.grid.on('render', function(){
            var view = this.grid.getView();
            view.mainBody.on('mousedown', this.onMouseDown, this);
        }, this);
    },
    // private
    onMouseDown : function(e, t){
        if(e.button === 0 && t.className == 'x-grid3-row-radio'){ // Only fire if left-click
            e.stopEvent();
            var row = e.getTarget('.x-grid3-row');
            if(row){
                var index = row.rowIndex;
                if(this.isSelected(index)){
                    this.deselectRow(index);
                }else{
                    this.selectRow(index, true);
                }
            }
        }
    },
    // private
    renderer : function(v, p, record){
        return '<div class="x-grid3-row-radio">&#160;</div>';
    }
});
//混合集合的运用，使用在选单上
Usp.sm={
isMuti:false,
datas:new Ext.util.MixedCollection(),
paramId:'',
paramName:''
};
Usp.sm.clear=function(){
this.paramId='';
this.paramName='';
};
  Usp.getTabHeight=function(){
	return Usp.main.getActiveTab().getHeight();
};
Usp.getTabWidth=function(){
	return Usp.main.getActiveTab().getInnerWidth();
};
/**
Usp.gridLoad=function(config){
var com=Ext.getCmp(config.id);
if(isObject(com)){
com.loadData(config.params);
}
else{
Ext.getCmp(config.pid).loadUrl({url:config.url,params:config.params});
}
}
**/
//扩展基类
Usp.BaseClass = function(config){
Ext.apply(this, config);
this.addEvents('uspUpdate');
this.initComponent();
};
Ext.extend(Usp.BaseClass, Ext.util.Observable, {
initComponent : Ext.emptyFn
});
     //创建简单工作界面
 Usp.SinglePanel=Ext.extend(Usp.BaseClass,{
  main:null,
  mainConfig:{
  },
  initComponent : function(){
       Usp.SinglePanel.superclass.initComponent.call(this);
        this.doLayout();
    }
  });
  Usp.SinglePanel.prototype.doLayout=function(){
  this.main= new Usp.ui.Panel(Ext.applyIf({
    style:'margin-right:1px;'
   },this.mainConfig));
  };
  /**
  Usp.SinglePanel.prototype.loadUrl=function(config){
  //url,params
	while(this.main.items.getCount()>0){
  			this.main.remove(this.main.items.first());
  			}
	this.main.loadUrl({
					url:config.url,
					params:config.params
					});
};
**/
 //创建border复杂工作界面
Usp.WorkPanel=Ext.extend(Usp.BaseClass,{
 top:null,
bottom:null,
left:null,
main:null,
right:null,
wp:null,
hasTop : false,
hasLeft: false,
hasRight:false,
hasBottom :false,
mainConfig:{},
leftConfig:{},
initComponent : function(){
        Usp.WorkPanel.superclass.initComponent.call(this);
        this.doLayout();
    }
 });
Usp.WorkPanel.prototype.doLayout=function(){
 if(this.hasLeft){
  this.left = new Usp.ui.Panel(Ext.apply({
            title: '',
            region: 'west',
            split: true,
            width: 200,
            autoScroll:true,
            collapsible:false,
            collapseMode:'mini',
            minSize:40,
            maxSize:400
        }, this.leftConfig));
 } 
 if(this.hasRight){
  this.right = new Usp.ui.Panel({
            title: '&nbsp;',
            region: 'east',
            split: true,
            collapsible: true,
            minSize:40,
            maxSize:400
        });
 }
          this.main= new Usp.ui.Panel(Ext.apply({
          region: 'center',
          height:300,
          autoWidth:true
          }, this.mainConfig));
  this.wp= new Usp.ui.Panel({
            //ctCls:'usp-content',
            //height:Ext.getBody().getHeight()-105,
            height:Ext.getBody().getHeight() + 100,
            layout: 'border',
            autoScroll:'false',
			items: [this.main]
        });
  if(this.hasLeft) this.wp.add(this.left);
  if(this.hasRight) this.wp.add(this.right);
  //if(this.hasTop) this.wp.add(this.top);
  //if(this.hasBottom) this.wp.add(this.bottom);
 };

    //创建列表
Usp.Grid=Ext.extend(Usp.BaseClass,{
isSelect:0,//0,不选择，1，单选，2，多选，default 0
isRowNo:0,//isRowNo 0，不显示，1，显示，2，分页时叠加，default,0
dataModel:null,
viewModel:null,
grid:null,
pbar:null,
limit:20,
gridConfig:{},
initComponent : function(){
        Usp.Grid.superclass.initComponent.call(this);
        this.doLayout();
    }
});
/**
Usp.Grid.prototype.loadData=function(params){
//Usp.doLoadData(this.grid.getStore(),{params:{start:this.start,limit:this.limit}});
var params=params||{params:{start:this.start,limit:this.limit}};
if(isObject(Usp.main.getActiveTab().qparams)){
this.grid.getStore().baseParams=Usp.main.getActiveTab().qparams[0];
this.grid.getStore().load(Usp.main.getActiveTab().qparams[1]);
}else {
this.grid.loadData(params);
}
};
**/
Usp.Grid.prototype.getGridPanel=function(){
//Usp.setText('单击列表可以选中一行记录');
return this.grid;
}
Usp.Grid.prototype.getFieldValue=function(field){
      var record=this.grid.getSelectionModel().getSelections()[0];
	   if (typeof record != 'undefined') {
	   	return record.get(field);
	   }
        
};
Usp.Grid.prototype.getFieldValues=function(field){
      var record=grid.getGridPanel().getSelectionModel().getSelections()[0];
        return record.get(field);
}
Usp.Grid.prototype.getParams=function(){
return Ext.apply(this.grid.getStore().baseParams,{params:{start:this.pbar.cursor,limit:this.limit}});
};
Usp.Grid.prototype.doLayout=function(){
var cm=[];
var sm=null;
var store=null;
if(this.isRowNo==1)
cm[cm.length]=new Ext.grid.RowNumberer();
if(this.isSelect!=0){
sm=new Ext.grid.CheckboxSelectionModel({singleSelect:this.isSelect==1});
cm[cm.length]=sm;
}
if(isObject(this.viewModel)){
for(var i=0;i<this.viewModel.length;i++){
cm[cm.length]=this.viewModel[i];
}
}
var store = new Ext.data.JsonStore({
       url:this.dataModel.url,
       remoteSort: false,
       totalProperty:'totalRecord',
       root:'result',
       fields:this.dataModel.cells
    });
    var sm1=new Ext.grid.CheckboxSelectionModel();
    this.pbar=new Ext.PagingToolbar({
        pageSize:this.limit,
        store:store,
        displayInfo:true
        });
 
		if(this.isPaging==0){
			this.grid=new Usp.ui.GridPanel(Ext.apply({
 		store: store,
        cm: new Ext.grid.ColumnModel(cm),
        sm:sm},this.gridConfig));
		}else{
			this.grid=new Usp.ui.GridPanel(Ext.apply({
 		store: store,
        cm: new Ext.grid.ColumnModel(cm),
        sm:sm,
        bbar:this.pbar},this.gridConfig));
		}
//注册更新事件
this.grid.on('click',function(){
   this.fireEvent('uspUpdate');
    },this);
this.grid.getStore().on('load',function(){
   this.fireEvent('uspUpdate');
    },this);

this.grid.on('click',function(){

       //var selections=this.grid.getSelectionModel().getSelections();
        // Usp.setText('');
    },this);
if(this.isSelect==1){
store.on('load',function(){ 
var gridEl=this.grid.getEl(); 
 if (typeof gridEl != 'undefined') {
   gridEl.select('div.x-grid3-hd-checker').removeClass('x-grid3-hd-checker'); //删除表头的checkBox 
   gridEl.select("div[class=x-grid3-row-checker]").each(function(x) {
   x.addClass('x-grid3-row-radioBtn');});
 }

},this);
/**
this.grid.on('click',function(){
     var selections=this.grid.getSelectionModel().getSelections();
      var record=selections[0];
        Usp.sm.paramId=record.get('fid');
        Usp.sm.paramName=record.get('fname');
    },this);
    **/ 
}
}

//创建form表单
 Usp.Form=Ext.extend(Usp.BaseClass,{
    formConfig:{},
 	dataModel:null,
	viewModel:null,
	form:null,
	initComponent : function(){
        Usp.Form.superclass.initComponent.call(this);
        this.doLayout();
       
     }
    });
  Usp.Form.prototype.doViewTip=function(){
	this.form.getForm().isValid();
 };
  Usp.Form.prototype.getFormPanel=function(){
	
  return this.form;
 };
 Usp.Form.prototype.doLayout=function(){
var items=[];
   if(isObject(this.viewModel)){
   for(var i=0;i<this.viewModel.cells.length;i++){
   items[i]=getFormItem(this.viewModel.cells[i]);
   }
   }
 this.form=new Usp.ui.FormPanel(Ext.apply({
   items:[{layout:'column',items:items}],
   reader: new Ext.data.JsonReader({root:this.dataModel.root},this.dataModel.cells)
    },this.formConfig));
};
Usp.Form.prototype.loadData=function(params){
//Usp.setText('载入数据中...');
 var params=params||{};
this.form.load({
	url :this.dataModel.url,
	params:params,
	 success : function(form,action) {
	 	//Usp.setText('载入成功！');
		},                
	 failure : function(form,action) {
	 	//Usp.setText('载入成功！');
		}
	});
  this.doViewTip();
};
 Usp.Form.prototype.addField=function(config){
 this.form.add(config);
 };
 //View表单
 Usp.View=Ext.extend(Usp.BaseClass,{
    viewModel:null,
	view:null,
	initComponent : function(){
        Usp.View.superclass.initComponent.call(this);
        this.doLayout();
     }
    });
    Usp.View.prototype.getViewPanel=function(){
    return this.view;
    }
   Usp.View.prototype.doLayout=function(){
    var items1=[];
   if(isObject(this.viewModel)){
   for(var i=0;i<this.viewModel.cells.length;i++){
   items1[items1.length]={html:this.viewModel.cells[i].fieldLabel+':',ctCls:'x-form-label-view'};
   items1[items1.length]={html:this.viewModel.cells[i].value,ctCls:'x-form-item-edit'};
   }
   }
  this.view=new Usp.ui.Panel({
   frame:true,
   border:false,
   layout:'table',
   layoutConfig:{columns:4},
   items:[items1]
   });
   
   }
//创建树界面
 Usp.Tree=Ext.extend(Usp.BaseClass,{
  tree:null,
  treeConfig:{},
  viewModel:null,
  initComponent : function(){
       Usp.Tree.superclass.initComponent.call(this);
        this.doLayout();
        this.tree.root.expand();
        
    }
  });
Usp.Tree.prototype.getTreePanel=function(){
    return this.tree;
    }
  
  Usp.Tree.prototype.doLayout=function(){
  this.tree= new Usp.ui.TreePanel({
    root:new Ext.tree.AsyncTreeNode({
                    text : this.text,   
                    draggable : false,
                    expandable:true,   
					animate : false,
                    id : '0'
                }),
      loader: new Ext.tree.TreeLoader({
            	dataUrl:this.dataUrl,
            	baseParams:this.baseParams
            	})
   });
   //对应值
   if(isObject(this.viewModel)){
     this.tree.on('beforeappend',function(tree,parent,node){
     if(!isNull(this.viewModel.id))
          		node.id=node.attributes[this.viewModel.id];
     if(!isNull(this.viewModel.leaf))
    			node.leaf=isNull(node.attributes[this.viewModel.leaf]) || node.attributes[this.viewModel.leaf]==0?true:false;
     if(!isNull(this.viewModel.text))
    		    node.text=node.attributes[this.viewModel.text];
    			},this);
   }
  };
 //列表树
  Usp.ColumnTree=Ext.extend(Usp.BaseClass,{
  tree:null,
  treeConfig:{
	  collapsible:true,
	  autoHeight:false,
	  height:Ext.getBody().getHeight()-70,
	  autoScroll:true
  },
  viewModel:null,
  initComponent : function(){
       Usp.ColumnTree.superclass.initComponent.call(this);
        this.doLayout();
        this.tree.root.expand();
        
    }
  });
Usp.ColumnTree.prototype.getTreePanel=function(){
    return this.tree;
    }
Usp.ColumnTree.prototype.getParams=function(){
return this.tree.loader.baseParams;
};
Usp.ColumnTree.prototype.getFieldValue=function(field){
//alert(isObject(this.tree.getSelectionModel().getSelectedNode().childNodes));
var selectedItem = this.tree.getSelectionModel().getSelectedNode(); 
   if (!selectedItem) 
   return 0;
   else
   return this.tree.getSelectionModel().getSelectedNode().attributes[field];
};
Usp.ColumnTree.prototype.isLeaf=function(field){
var selectedItem = tree.getTreePanel().getSelectionModel().getSelectedNode(); 
   if (!selectedItem) 
   return false;
   else
   return tree.getTreePanel().getSelectionModel().getSelectedNode().attributes[field];
};
Usp.ColumnTree.prototype.doLayout=function(){
this.tree= new Usp.ui.ColumnTree(Ext.apply({
    root:new Ext.tree.AsyncTreeNode({
                    text : this.text,   
                    draggable : false,
                    expandable:true,   
					animate : false,
                    id : '0'  
                }),
     columns:this.viewModel,
     loader: new Ext.tree.TreeLoader({
			dataUrl:this.dataUrl,
			baseParams:this.baseParams,
            baseAttrs:{uiProvider:'col'},
            uiProviders:{'col': Ext.ux.tree.ColumnNodeUI }
        })
   },this.treeConfig));
       this.tree.on('beforeappend',function(tree,parent,node){
    		 
    			},this);
  };
  //tab界面
    Usp.Tab=Ext.extend(Usp.BaseClass,{
  tab:null,
  tabConfig:{},
  initComponent : function(){
        Usp.Tab.superclass.initComponent.call(this);
        this.doLayout();
     }
  });
    Usp.Tab.prototype.doLayout=function(){
   this.tab=new Usp.ui.TabPanel(Ext.apply({},this.tabConfig));
   };
       Usp.Tab.prototype.getTabPanel=function(){
    return this.tab;
    };
 Usp.Tab.prototype.openTab=function(config){
 //id,title,actionUrl,isFrame

 if( typeof config.actionUrl !='undefined' && config.actionUrl!=''){
 if(config.isFrame){
 Ext.apply(config,{html:'<iframe scrolling="no" frameborder="0" width="100%" height="100%" src="'+config.actionUrl+'"></iframe>'});
 //Ext.apply(config,{xtype: 'iframepanel',defaultSrc:config.actionUrl});
 }
 else
 Ext.apply(config,{autoLoad:{url:config.actionUrl, scripts:true,nocache:true}});
 var tab = this.tab.getComponent(config.id);
      	if(!tab){
      		 tab=this.tab.add(Ext.apply({
      				autoHeight:true,
      				autoWidth:true,
      				closable:true
      				},config));
				tab.show();
      		}else{
      			//tab.getUpdater().refresh(); 
      		}
      	this.tab.setActiveTab(tab);
      	}
    };
 //工具栏
   
  Usp.ToolBar=Ext.extend(Usp.BaseClass,{
  toolBar:null,
  initComponent : function(){
        Usp.ToolBar.superclass.initComponent.call(this);
        this.doLayout();
     }
  });
  Usp.ToolBar.prototype.doLayout=function(){
   this.toolBar=new Usp.ui.Toolbar();
   };
    Usp.ToolBar.prototype.getToolPanel=function(){
    return this.toolBar;
    };
        Usp.ToolBar.prototype.addSeparator=function(){
    return this.toolBar.addSeparator();
    };
  Usp.ToolBar.prototype.update=function(styles){
  for(i=0;i<this.toolBar.items.getCount();i++){
  if(this.toolBar.items.get(i).btnType!='-'){
 if(styles[i]=='visible'){
  this.toolBar.items.get(i).setDisabled(false);
  this.toolBar.items.get(i).setIconClass();
  			}
   if(styles[i]=='disabled'){
  this.toolBar.items.get(i).setDisabled(true);
  this.toolBar.items.get(i).setIconClass('usp-img-gray');
  			}
  			}
  			}
   };
        Usp.ToolBar.prototype.addBtn=function(config){
	//btnType,handler,btnStyle
	//btnStyle按钮显示样式,hidden,disabled,visible
		config=Ext.apply(config,{hidden:false,disabled:false});
		if(!isNull(config.btnStyle)&&config.btnStyle=='hidden')
		config=Ext.apply(config,{hidden:true});
		if(!isNull(config.btnStyle)&&config.btnStyle=='disabled')
		config=Ext.apply(config,{disabled:true});
		var iconClass='';
		if(config.disabled)
		iconClass='usp-img-gray';
		switch (config.btnType) {
		case 'ADD':
				this.toolBar.addButton(Ext.apply({text:'增加',icon: appcontext+'/cloud/images/add.gif',iconCls:iconClass},config));
				//this.toolBar.addButton(new Usp.ui.Toolbar.Button(Ext.apply({text:'增加',icon: appcontext+'/cloud/images/add'+imgext+'.gif'},config)));
				break;
		case 'EDIT':
				this.toolBar.add(Ext.apply({text:'修改',icon: appcontext+'/cloud/images/edit.gif',iconCls:iconClass},config));
				break;
		case 'VIEW':
				this.toolBar.add(Ext.apply({text:'查看',icon: appcontext+'/cloud/images/view.gif',iconCls:iconClass},config));
				break;	
		case 'VIEWFANAN':
				this.toolBar.add(Ext.apply({text:'查看方案',icon: appcontext+'/cloud/images/view.gif',iconCls:iconClass},config));
				break;	
				
		case 'DIGAO':
				this.toolBar.add(Ext.apply({text:'审计底稿',icon: appcontext+'/cloud/images/application_view_list.png',iconCls:iconClass},config));
				break;	
		case 'YIDIAN':
				this.toolBar.add(Ext.apply({text:'审计疑点',icon: appcontext+'/cloud/images/application_view_list.png',iconCls:iconClass},config));
				break;
		case 'AllDIGAO':
				this.toolBar.add(Ext.apply({text:'全部底稿',icon: appcontext+'/cloud/images/application_view_list.png',iconCls:iconClass},config));
				break;	
		case 'AllYIDIAN':
				this.toolBar.add(Ext.apply({text:'全部疑点',icon: appcontext+'/cloud/images/application_view_list.png',iconCls:iconClass},config));
				break;
		case 'MYDIGAO':
				this.toolBar.add(Ext.apply({text:'我的底稿',icon: appcontext+'/cloud/images/application_view_list.png',iconCls:iconClass},config));
				break;	
		case 'MYYIDIAN':
				this.toolBar.add(Ext.apply({text:'我的疑点',icon: appcontext+'/cloud/images/application_view_list.png',iconCls:iconClass},config));
				break;
	    case 'DEL':
				this.toolBar.add(Ext.apply({text:'删除',icon: appcontext+'/cloud/images/del.gif',iconCls:iconClass},config));
				break;
		case 'EXP':
				this.toolBar.add(Ext.apply({text:'导出底稿',icon: appcontext+'/cloud/images/exp.gif',iconCls:iconClass},config));
				break;
                
		case 'EXPSINGL':
				this.toolBar.add(Ext.apply({text:'导出单项底稿',icon: appcontext+'/cloud/images/exp.gif',iconCls:iconClass},config));
				break;
		case 'EXPMULTI':
				this.toolBar.add(Ext.apply({text:'导出综合底稿',icon: appcontext+'/cloud/images/exp.gif',iconCls:iconClass},config));
				break;
                
		case 'EXPALL':
				this.toolBar.add(Ext.apply({text:'导出所有',icon: appcontext+'/cloud/images/exp.gif',iconCls:iconClass},config));
				break;
		case 'EXPLIST':
				this.toolBar.add(Ext.apply({text:'导出',icon: appcontext+'/cloud/images/exp.gif',iconCls:iconClass},config));
				break;		
		case 'IMP':
				this.toolBar.add(Ext.apply({text:'导入',icon: appcontext+'/cloud/images/imp.gif',iconCls:iconClass},config));
				break;
		case 'inreport':
				this.toolBar.add(Ext.apply({text:'入报告问题',icon: appcontext+'/cloud/images/imp.gif',iconCls:iconClass},config));
				break;
	   case 'RFH':
				this.toolBar.add(Ext.apply({text:'刷新',icon: appcontext+'/cloud/images/refresh.gif',iconCls:iconClass},config));
				break;
	  case 'HELP':
				this.toolBar.add(Ext.apply({text:'帮助',icon: appcontext+'/cloud/images/help.gif',iconCls:iconClass},config));
				break;
	 case 'COMMENT':
				this.toolBar.add(Ext.apply({text:'底稿反馈意见',icon: appcontext+'/cloud/images/cog_edit.png',iconCls:iconClass},config));
				break;
     case 'OUT':
				this.toolBar.add(Ext.apply({text:'注销',icon: appcontext+'/cloud/images/delete.gif',iconCls:iconClass},config));
				break;
	 case 'CHECK':
				this.toolBar.add(Ext.apply({text:'消除疑点',icon: appcontext+'/cloud/images/plugin.gif',iconCls:iconClass},config));
				break;
	 case 'IN':
				this.toolBar.add(Ext.apply({text:'恢复',icon: appcontext+'/cloud/images/plugin_add.gif',iconCls:iconClass},config));
				break;	
	 case 'PROBLEM':
				this.toolBar.add(Ext.apply({text:'审计问题',icon: appcontext+'/cloud/images/application_view_list.png',iconCls:iconClass},config));
				break;		
	 case 'SUBMIT':
				this.toolBar.add(Ext.apply({text:'提交',icon: appcontext+'/cloud/images/application_go.png',iconCls:iconClass},config));
				break;		
	case 'SEARCH':
				this.toolBar.add(Ext.apply({text:'查询',icon: appcontext+'/cloud/images/lookup.gif',iconCls:iconClass},config));
				break;	
	case 'EMAIL':
				this.toolBar.add(Ext.apply({text:'邮件发送',icon: appcontext+'/cloud/images/email.png',iconCls:iconClass},config));
				break;
	case 'fengong':
				this.toolBar.add(Ext.apply({text:'审计分工',icon: appcontext+'/cloud/images/cog_edit.png',iconCls:iconClass},config));
				break;	
	case 'group':
				this.toolBar.add(Ext.apply({text:'小组批量',icon: appcontext+'/cloud/images/plugin_add.gif',iconCls:iconClass},config));
				break;		
	case 'member':
				this.toolBar.add(Ext.apply({text:'组员批量',icon: appcontext+'/cloud/images/user_comment.png',iconCls:iconClass},config));
				break;		
	case 'EXPFEN':
				this.toolBar.add(Ext.apply({text:'导出分工',icon: appcontext+'/cloud/images/exp.gif',iconCls:iconClass},config));
				break;									
	 case '-':
				this.toolBar.add(Ext.apply({xtype:'tbseparator'},config));
				break;
	 case 'extractive':
			this.toolBar.add(Ext.apply({text:'提取问题',icon: appcontext+'/cloud/images/imp.gif',iconCls:iconClass},config));
			break;
	 case 'changeNum':
				this.toolBar.add(Ext.apply({text:'调整问题编号',icon: appcontext+'/cloud/images/edit.gif',iconCls:iconClass},config));
				break;
	 default:
	    this.toolBar.add(Ext.apply({iconCls:iconClass},config));			
				}
	};
    
    
var BTNTYPE={ADD:'add',EDIT:'edit'};
//打开一个弹出选单
Usp.doSelWindow=function(config){
//url,formPanel,paraId,paraName,title
        var win=new Usp.ui.Window({ 
			  //title:title,
			  autoLoad:{url:config.url, scripts:true,nocache:false},
			  buttons: [{
                    text: '确定',
                    handler: function(){
                     config.formPanel.getForm().findField(config.paraName).setValue(Usp.sm.paramName);
                     config.formPanel.getForm().findField(config.paraId).setValue(Usp.sm.paramId);
                     Usp.sm.clear();
                        win.close();
                    }
                },
                {
                    text: '取消',
                    handler: function(){
                    Usp.sm.clear();
                        win.close();
                    }
                }
                ],
               buttonAlign:'left' 
        	 });
        	 
			 win.show(this);

};
//grid重新装入界面
Usp.doGridLoad=function(config){
    //url,params,id,pid
    var component=Ext.getCmp(config.id);
		if(isObject(component))
		component.loadData(config.params);
		else
			Ext.getCmp(config.pid).loadUrl({url:config.url,params:config.params});
				
			
		};
//tab重新装入界面
Usp.doTabLoad=function(config){
    //url,params,id,pid,tabId
    var component=Ext.getCmp(config.id);
		if(isObject(component))
		component.loadData(config.params);
		else{
		    Ext.getCmp(config.tabId).setActiveTab(Ext.getCmp(config.pid));
		    if(config.isFrame){
 //Ext.getCmp(config.pid).load({html:'<iframe id="ddd" scrolling="auto" frameborder="0" width="100%" height="100%" src="'+config.url+'"></iframe>'});
		  Ext.getCmp(config.pid).body.update('<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+config.url+'"></iframe>');
		  //Ext.getCmp(config.pid).getUpdate().update({html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+config.url+'"></iframe>'});
		    	//Ext.getCmp('hhh').setSrc(config.url); 
		    	}
		    else
				if(typeof(config)!='undefined'&&typeof(config.pid)!='undefined'&&typeof(Ext.getCmp(config.pid))!='undefined'){
					
					Ext.getCmp(config.pid).getUpdater().update({url:config.url,params:config.params});
				}
			if(typeof(config.title)!='undefined'){
				Ext.getCmp(config.pid).setTitle(config.title);
			}
		    
			}
		};
//指定panel装入界面
Usp.doPanelLoadUi=function(config){
	//component,url,params,id,baseParams
	 var delItem=true;
	var component=config.component||Ext.getCmp(config.id);
	if(isObject(component)){
	if(typeof(config.delItem)!='undefined')
	delItem=config.delItem;;
	if(delItem){
	   if(isObject(component.items)){
		while(component.items.getCount()>0){
  			component.remove(component.items.first());
  			}
  			}
  			}
	component.loadUrl({
					url:config.url,
					params:config.params||{}
					});
	 }else {
	 this.doActiveTab(config.url,config.params,config.baseParams);
	 }
	};
//在当前tab中跳转
Usp.doActiveTab=function(actionurl,params,baseParams){
//component,url,params
//alert(Ext.encode(params));
if(isObject(baseParams))
Usp.main.getActiveTab().qparams=baseParams;
 Usp.main.getActiveTab().load({
    url: actionurl,
  nocache: true,
  params:params||{},
    scripts: true
});
};
  //返回当前的tab
  Usp.doBackPanelUi=function(config){
  //component,url,params,id,pid,delItem
  var delItem=true;
  var component=config.component||Ext.getCmp(config.id)||Ext.getCmp(config.pid);
	if(isObject(component)){
	if(typeof(config.delItem)!='undefined')
	delItem=config.delItem;;
	if(delItem){
	   if(isObject(component.items)){
		while(component.items.getCount()>0){
  			component.remove(component.items.first());
  			}
  			}
  		}
	component.loadUrl({
					url:config.url,
					params:config.params||{}
					});
	 }else {
	    Usp.main.getActiveTab().load({
    url: config.url,
  nocache: true,
    //timeout: 30,
    scripts: true,
    params:Usp.main.getActiveTab().qparams
});
	 }

};
 //打开新的tab
 Usp.openTabPanel=function(cmpid,title,actionurl,pcmpid){
 if( typeof actionurl !='undefined' && actionurl!=''){
 var tabP=null;
 var tab=null;
 if(typeof pcmpid !='undefined' && pcmpid!=''){
  tabP=Ext.getCmp(pcmpid);
  tab=tabP.getComponent(cmpid);
  }
 else{
  tabP=Usp.main;
  tab = tabP.getComponent(cmpid);
  }
  
      	if(!tab){
      		 tab=tabP.add({
      				title:title,
      				closable:true,
      				height:500,
      				autoLoad:{url:actionurl, scripts:true,nocache:true}, 
      				id:cmpid
      				/**
      				 listeners: {
      				activate: function(tab) { 
                        tab.getUpdater().refresh(); 
                        }
                      }**/
      				});
				tab.show();
      		}else{
      			//tab.getUpdater().refresh(); 
      		}
      	tabP.setActiveTab(tab);
      	}
    };
    //打开新的tab,组件间的统一跳转
 Usp.doTabPanel=function(config){
 //id,title,url,params,pid,refresh,height
  var params=config.params||{};
  var refresh=config.refresh||false;

 if( typeof config.url !='undefined' && config.url!=''){

 
 var tabP=null;
 var tab=null;
 if(typeof config.pid !='undefined' && config.pid!=''){
  tabP=Ext.getCmp(config.pid);
  tab=tabP.getComponent(config.id);
  }
 else{
  tabP=Usp.main;
  tab = tabP.getComponent(config.id);
  }
  
      	if(!tab){
      	
      		 tab=tabP.add({
      				title:config.title,
      				closable:true,
      				height:config.height||500,
					autoWidth:true,
      				autoLoad:{url:config.url,params:params,scripts:true,nocache:true}, 
      				id:config.id
      				/**
      				 listeners: {
      				activate: function(tab) { 
                        tab.getUpdater().refresh(); 
                        }
                      }**/
      				});
				tab.show();
      		}else{
      		if(refresh)
      			tab.getUpdater().update({url:config.url,params:params}); 
      		}
      	tabP.setActiveTab(tab);
      	}
    };
  //刷新组件
 Usp.refPanel=function(config){
 //id,pid,type,url,params
 //var component=config.component||Ext.getCmp(config.id);
 if(config.type=='uspgrid')
Usp.doGridLoad({url:config.url,params:config.params,id:config.id,pid:config.pid});
else
Usp.doGridLoad({url:config.url,params:config.params,id:config.id,pid:config.pid});
 
 };
 //在iframe中打开新的tab
 Usp.openTabPanelByFrame=function(cmpid,title,actionurl){
 if( typeof actionurl !='undefined' && actionurl!=''){
 var tab = Usp.main.getComponent(cmpid);
      	if(!tab){  
      		 tab=Usp.main.add({
      				title:title,
      				closable:true,
      				id:cmpid,
      				html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src="'+actionurl+'"></iframe>'
      				});
				tab.show();
      		}else{
      			//tab.getUpdater().refresh(); 
      		}
      	Usp.main.setActiveTab(tab);
      	}
    };

//在指定的component上执行方法
Usp.doMethod=function(comid,params){
var com=Ext.get(comid);
if(!isObject(com))
alert(comid+'不是有效的对象.');
else{
alert(com.getStore());
com.getStore().reload();
}
};
function getMask(id){
var cmpid;
if( typeof id !='undefined' && id!='')
cmpid=id
cmpid=Usp.main.getActiveTab().getId()
return new Ext.LoadMask(cmpid, {msg: "业务操作中...",removeMask:true});
}
//grid删除一条数据
Usp.doGridDel=function(config){
//url,params,component
	var mask;
      //Ext.Msg.confirm('111系统提示','确定要删除吗？',function(btn){  
	  
          if(confirm('确定要删除吗？')){
         //mask=getMask(component.getId());
         Ext.Ajax.request({
         	url:config.url,
         	params:config.params,
         	success:function(response){
         	var json=Ext.decode(response.responseText);
         	if(json.success){
         	//mask.hide();
         	config.component.getGridPanel().getStore().reload();
         	}
         	},
         	failure:function(response){
         	//mask.hide();
         	alert('删除失败');
         	}
         });
        //mask.show();
         }
        // });
}

//grid删除多条数据
Usp.doGridDelBatch=function(config){
//url,params,component
	var mask;
      //Ext.Msg.confirm('111系统提示','确定要删除吗？',function(btn){  
	  
         // if(confirm('确定要删除吗？')){
         //mask=getMask(component.getId());
         Ext.Ajax.request({
         	url:config.url,
         	params:config.params,
         	success:function(response){
         	var json=Ext.decode(response.responseText);
         	if(json.success){
         	//mask.hide();
         	//alert(json.msg);  
         	config.component.getGridPanel().getStore().reload();
         	}
         	},
         	failure:function(response){
         	//mask.hide();
         	alert('删除失败');
         	}
         });
        //mask.show();
       //  }
        // });
}


Usp.doGridAction=function(config){
     Ext.Ajax.request({
     	url:config.url,
     	async:false,
     	params:config.params,
     	success:function(response){
     		config.component.getGridPanel().getStore().reload();
     		return true;
     	},
     	failure:function(response){
     		return false;
     	}
     });
}

//提交方法到后台
Usp.doPost=function(config){
//url,params,component,msg
	var mask;
	   if(confirm(config.msg)){
	   	         Ext.Ajax.request({
         	url:config.url,
         	params:config.params,
         	success:function(response){
         	var json=Ext.decode(response.responseText);
         	if(json.success){
         	//mask.hide();
         	config.component.getGridPanel().getStore().reload();
         	}
         	},
         	failure:function(response){
         	//mask.hide();
         	alert('操作失败');
         	}
         });
	   }
}

//刷新数据
Usp.dRefresh=function(config){
　 
         	config.component.getGridPanel().getStore().reload();
       
}


//提交方法到后台
Usp.doPostYD=function(config){
//url,params,component,msg
	var mask;
	 var msg ='';
Ext.Msg.show({
title:'Milton',
msg: 'Have you seen my stapler?',
buttons: {yes: true, no: true, cancel: true},
icon: 'milton-icon',
defaultButton: 'no',
fn: function(btn) {
switch(btn){
case 'yes':
Ext.Msg.prompt('Milton', 'Where is it?', function

(btn,txt) {
 

});
break;
case 'no':
Ext.Msg.alert('Milton', 'Im going to burn the building down!');
break;
case 'cancel':
Ext.Msg.wait('Saving tables to disk...','File Copy');
break;
}
}
})
	
	
}
//tree删除一条数据
Usp.doTreeDel=function(config){
//url,params,component
	var mask;
      Ext.Msg.confirm('系统提示','确定要删除吗？',function(btn){
         if(btn=='yes'){
         mask=getMask();
         Ext.Ajax.request({
         	url:config.url,
         	params:config.params,
         	success:function(response){
         	var json=Ext.decode(response.responseText);
         	if(json.success){
         	mask.hide();
         	alert(json.msg);
         	config.component.getTreePanel().getSelectionModel().getSelectedNode().remove();
         	//config.component.getTreePanel().getLoader().load(config.component.getTreePanel().getNodeById('1'));
         	}
         	},
         	failure:function(response){
         	mask.hide();
         	alert('删除失败');
         	}
         });
        mask.show();
         }
         });
}
/**
usp.doDel=function(actionUrl,params,store){
	var mask;
      Ext.Msg.confirm('系统提示','确定要删除吗？',function(btn){
         if(btn=='yes'){
         mask=getMask();
         Ext.Ajax.request({
         	url:actionUrl,
         	success:function(response){
         	var json=Ext.decode(response.responseText);
         	if(json.success){
         	mask.hide();
         	Ext.Msg.alert('系统提示',json.msg);
         	store.reload();
         	}
         	},
         	failure:function(response){
         	mask.hide();
         	Ext.Msg.alert('系统提示','删除失败');
         	},
         	params:params
         });
        mask.show();
         }
         });
         **/
//列表异步取数
Usp.doLoadData=function(cmp,params,grid){
//alert(Ext.encode(params));
//cmp====store
if(isObject(Usp.main.getActiveTab().qparams)){
cmp.baseParams=Usp.main.getActiveTab().qparams[0];
cmp.load(Usp.main.getActiveTab().qparams[1]);
}else {
cmp.load(params);
}

}
//form表单提交

function formSubmit(formPanel,actionurl,type,callback){
   if(!formPanel.getForm().isValid()){
					Ext.MessageBox.alert('系统消息','数据录入有误。请参看页面的详细错误信息。');
					return;
				}
	formPanel.getForm().submit({
        			url:actionurl,
        			waitTitle:"请等待",
        			waitMsg:'处理进行中...',
        			success:function(form,action){
                           alert(action.result.msg);
                            //Ext.getCmp('glist').getStore().reload();
                            
                            callback(action.result.pkid); 
                        },
                    failure:function(form,action){
                            alert('操作失败.');
                        }
        			
        		});
}
//表单重置
function formReset(form){
form.reset();
form.isValid();  
}
 //注册页面按钮
   //btn
     Usp.BtnBar=Ext.extend(Usp.BaseClass,{
  btnBar:null,
  btnBarConfig:{},
  btn:null,
  initComponent : function(){
        Usp.BtnBar.superclass.initComponent.call(this);
        this.doLayout();
     }
  });
  Usp.BtnBar.prototype.doLayout=function(){
   this.btnBar=new Usp.ui.ButtonPanel(Ext.apply({buttons:this.btn},this.btnBarConfig));
   };
    Usp.BtnBar.prototype.getBtnBarPanel=function(){
    return this.btnBar;
    };
     //注册页面按钮
   Usp.regButton=function(buttons){
   return new Usp.ui.ButtonPanel({buttons:buttons});
   }
//创建form字段
/**
   Usp.createForm=function(layout){
   var items=[];
   if(isObject(layout)){
   for(var i=0;i<layout.cells.length;i++){
   items[i]=getFormItem(layout.cells[i]);
   }
   }
   //alert(items);
  return new Usp.ui.FormPanel({
   items:[{
           layout:'column',items:items}],
    reader: new Ext.data.JsonReader({root:'result'},
				[{name: 'commonDataDetail.id',mapping:'id',type:'string'},
				 {name: 'commonDataDetail.code',mapping:'code',type:'string'},
				 {name: 'commonDataDetail.name',mapping:'name',type:'string'}
					])
    
    });
   }
   **/
//
//创建form表单
 Usp.QForm=Ext.extend(Usp.BaseClass,{
    formConfig:{},
	viewModel:null,
	form:null,
	initComponent : function(){
        Usp.QForm.superclass.initComponent.call(this);
        this.doLayout();
     }
    });
     Usp.QForm.prototype.addField=function(config){
 this.form.add(config);
 };
  Usp.QForm.prototype.doLayout=function(){
	   var items1=[];
   
   for(var i=0;i<this.viewModel.cells.length;i++){
   items1[i]=getQFormItem(this.viewModel.cells[i]);
   }
  this.form=new Usp.ui.FormPanel(Ext.apply({
  			title: '查询',
  			collapsible:true,
			collapsed:true,
			plain: true,
		    buttonAlign:'center',   
             labelAlign:'right',  
                height:225,
				 layout : 'form',
			titleCollapse:true,
			animCollapse:false,
			//collapsed:true,
			border:false,
			bodyBorder:false,
			items:[this.viewModel.qbtn,{layout:'column',items:items1}]
			//buttons: [this.viewModel.qbtn]
				
			
   			},this.formConfig))
			
			;
 };
Usp.QForm.prototype.getFormPanel=function(){
return this.form;
}
       
   function getFormItem(config){
   //alert(config.allowBlank);
   return {
            	layout:'form',
            	columnWidth:!isNull(config.clspan)?config.clspan:0.5,
            	items:[Ext.apply({
            				//fieldLabel:config.fieldLabel,
            				xtype:"textfield",
            				name:config.name,
            				maxLength:0,
            				emptyText:'',
            				stripCharsRe:/(^\s*)|(\s*$)/g,
            				//allowBlank:!isNull(config.allowBlank)?config.allowBlank:true,
            				anchor:'100%'},config)]};
   }
      function getQFormItem(config){
   //alert(config.allowBlank);
   return {
            	layout:'form',
            	columnWidth:!isNull(config.clspan)?config.clspan:0.5,
            	items:[Ext.apply({
            				//fieldLabel:config.fieldLabel,
            				xtype:"textfield",
            				name:config.name,
            				emptyText:'',
            				stripCharsRe:/(^\s*)|(\s*$)/g,
            				//allowBlank:!isNull(config.allowBlank)?config.allowBlank:true,
            				anchor:'100%'},config)]};
   }
//校验
function isSingle(gridPanel){
if(!checkSingle(gridPanel)){
         alert('请选择一条数据进行操作.');
         return false;
         }
     return true;
}
function checkSingle(gridPanel){
var selections=gridPanel.getSelectionModel().getSelections();
         if(selections.length==0 || selections.length>1){
         return false;
         }
     return true;
}
 function isNull(val)
{return(val==null||typeof(val)=="undefined"||val=='');}
   
   function isObject(obj)
{if(isNull(obj))return false;return(typeof(obj)=="object")?true:false;}
function getComid(comid){
 if(comid==null||typeof(comid)=="undefined" || comid=='')
  return Ext.id();
  else return comid;
}
Ext.ns('Usp.ui');