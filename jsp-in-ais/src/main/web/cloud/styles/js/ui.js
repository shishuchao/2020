/**
** 扩展extjs组件
**/

//usp.ui.GridPanel   继承Ext.grid.GridPanel
Usp.ui.GridPanel=Ext.extend(Ext.grid.GridPanel,{
		//id:Ext.id(),
 		viewConfig: {forceFit: true,enableRowBody:true,showPreview:true},
        bodyStyle:'width:100%',
        border:false,
        //height:Usp.main.getActiveTab().getInnerHeight(),
        //height:Ext.getBody().getHeight()-280,
        autoHeight: true,
        //autoScroll:true,
        autoWidth : true,
        enableColumnMove:false,
        enableColumnHide:false,
        enableColumnResize:true,
        stripeRows:true,
        httpParams:{},
        loadData:function(params){
        var params=params||{};
        this.httpParams=params;
        this.getStore().baseParams=params;
        this.getStore().load({params:params, scripts:true,nocache:true});
        }
});
Ext.reg('uspgrid',Usp.ui.GridPanel);
//
Usp.ui.TreePanel=Ext.extend(Ext.tree.TreePanel,{
		 		 useArrows:true,
                 animate:true,//动画
                 enableDD:false,//拖动
                 border:false,
                 //autoScroll:true,
                 rootVisible:false
});
Ext.reg('usptree',Usp.ui.TreePanel);
//
Usp.ui.ColumnTree=Ext.extend(Ext.ux.tree.ColumnTree,{
		 		 useArrows:true,
                 animate:false,
                 enableDD:false,
                 border:false,
                 //autoScroll:true,
                 rootVisible:false,
       			 title: '&nbsp;'     			 
});
Ext.reg('uspcolumntree',Usp.ui.ColumnTree);
//Usp.ui.ButtonPanel   继承Ext.Panel
Usp.ui.ButtonPanel=Ext.extend(Ext.Panel,{
				//id:Ext.id(),
				layout:"table",
				border: false,
        		width:500,
        		ctCls:'tbtn',
				buttonAlign: "left"
			});


//Usp.ui.FormPanel   继承Ext.form.FormPanel
Usp.ui.FormPanel=Ext.extend(Ext.form.FormPanel,{
		//id:Ext.id(),
		labelAlign: 'right',
        labelWidth: 100,
        frame: true,
        border:false,
        style:'margin-right:1px;',
        bodyStyle:'width:100%'
        });

//Usp.ui.QFormPanel   继承Ext.form.FormPanel
Usp.ui.QFormPanel=Ext.extend(Ext.form.FormPanel,{
		//id:Ext.id(),
		labelAlign: 'right',
        labelWidth: 100,
        frame: true,
        border:false,
        style:'margin-right:1px;',
        bodyStyle:'width:100%'
			});
//Usp.ui.form.SelectDict Ext.form.ComboBox
Usp.ui.SelectDict=Ext.extend(Ext.form.ComboBox,{
		dwrFunction:null,
		mode:'remote',
		dictCode:'0',
		store:null,
		proxy:null,
		displayField:'text',
		valueField:'value',
		triggerAction:'all',
		readOnly:true,
        initComponent : function(){
        Usp.ui.SelectDict.superclass.initComponent.call(this);
       this.doLayout();
    }
			});
Usp.ui.SelectDict.prototype.doLayout=function(){
	var p=new Ext.ux.data.DwrProxy({
	dwrFunction:commonDataOutService.getDataDetailList
	});
	p.on('beforeload', function(dataProxy, params){
	params[dataProxy.loadArgsKey] = [this.dictCode];
					},this);
		this.store = new Ext.data.Store({
	proxy:p,
	reader: new Ext.data.ArrayReader({}, [
        {name: 'value',mapping:'code'},
        {name: 'text',mapping:'name'}
    ])
	});
};
Ext.reg('uspselectdict',Usp.ui.SelectDict);			
//Usp.ui.Panel   继承Ext.Panel
Usp.ui.Panel=Ext.extend(Ext.Panel,{
        frame: false,
        border:false,
        autoScroll:true,
        loadUrl:function(config){
       
        var params=config.params||{};
        this.load({url: config.url,params:params,nocache: true,scripts: true});
        //this.autoLoad={url:url, scripts:true,nocache:true}
        }
			});
Usp.ui.Toolbar=Ext.extend(Ext.Toolbar,{
			});

Usp.ui.Toolbar.Button=Ext.extend(Ext.Toolbar.Button,{
				btnType:null,
				btnStyle:null
				});
//Usp.ui.TabPanel   继承Ext.TabPanel
Usp.ui.TabPanel=Ext.extend(Ext.TabPanel,{
		activeTab:0,
 		border:false,
 		hright:300,
 		enableTabScroll:true,
 		loadUrl:function(config){
        var params=config.params||{};
        this.getActiveTab().load({url: config.url,params:params,nocache: true,scripts: true});
        //this.autoLoad={url:url, scripts:true,nocache:true}
        }
});
Ext.reg('usptabpanel',Usp.ui.TabPanel);

//Usp.ui.TabPanel   继承Ext.TabPanel
Usp.ui.Window=Ext.extend(Ext.Window,{
 		     //id:Ext.id(),
        	 width:800,
        	 height:600,
        	 modal : true, 
			  resizable : true,
			  maximizable:true,
			  layout:'fit', 
			  title:'工作窗口',
			  plain:true,
			  closeAction:'close'
});
Ext.reg('uspwindow',Usp.ui.Window);
//Usp.ui.TabPanel   继承Ext.TabPanel
Usp.ui.popSelField=Ext.extend(Ext.form.TriggerField,{
 		     triggerClass : 'x-form-search-trigger',
 		     readOnly:true,
			 autoShow:true
});
Ext.reg('usppopselfield',Usp.ui.popSelField);

