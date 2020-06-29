/*
 * 
 */

Ext.onReady(function(){
    Ext.QuickTips.init();

    var fm = Ext.form;
	var sm = new Ext.grid.CheckboxSelectionModel({handleMouseDown: Ext.emptyFn});

    var cm = new Ext.grid.ColumnModel([
		sm,{
			header:'ID',
			dataIndex:'id',
			width:40,
			sortable :false
		},{
			header: "姓名",
			dataIndex: 'name',
			editor: new fm.TextField({
				allowBlank: false
			})
        },{
			header:'性别',
			dataIndex:'sex',
			width:60,
			align:'center',
			renderer:function(v){
				return '<img src="images/'+v+'.png"/>'+(v=='m'?'男':'女');
			},
			editor:new fm.ComboBox({
				typeAhead: true,
				triggerAction: 'all',
				transform:'sexSelect',
				lazyRender:true,
			    readOnly:true,
				listClass: 'x-combo-list-small'
			})
		},{
			header:'年龄',
			dataIndex:'age',
			width:50,
			align:'right',
			renderer:function(v){
				var code = '<span style="color:';
				if(v<=25){
					code += '#008000';
				}else if(v>25 && v<=30){
					code += '#CC6600';
				}else if(v>30){
					code += '#804000';
				}
				return code+';">'+v+'</span>';
			},
			editor: new fm.NumberField({
				allowBlank:false,
				allowNegative: false,
				allowDecimals: false,
				maxValue:60,
				minValue:18
			})
		},{
			header: "生日",
			dataIndex: 'birth',
			renderer: function(v){
				return v ? v.dateFormat('Y年m月d日') : '';
			},
			editor: new fm.DateField({
				format: 'Y-m-d',
				minValue: '1800-01-01',
				readOnly:true,
				disabledDays: [0, 6],
				disabledDaysText: '请不要选择周末'
			})
        }
    ]);

    cm.defaultSortable = true;

    var Member = Ext.data.Record.create([
           {name: 'id', type: 'int'},
           {name: 'name', type: 'string'},
		   {name: 'sex'},
		   {name: 'age',type:'int'},
           {name: 'birth', type: 'date', dateFormat: 'Y-m-d'}
      ]);

	var store = new Ext.data.JsonStore({
		url:'./member_manage.jsp',
		baseParams:{command:'query'},
		totalProperty:'count',
		root:'members',
		fields:Member,
		pruneModifiedRecords:true,
		sortInfo: {field: "id", direction: "ASC"} //设置默认排序规则, EditorGridPanel在新增加一行却未保存时如果点击header排序会出现'行142字符6983,modified为空或不是对象'
	});

	//表单窗体
	var memberAddWindow;

    var grid = new Ext.grid.EditorGridPanel({
        store: store,
        cm: cm,
        renderTo: 'member_grid',
        resizeable:true,
		width:640,
        height:480,
        title:'员工管理123',
        frame:true,
        clicksToEdit:1,
		sm:sm,
		iconCls:'icon-grid',
		loadMask: true,//遮照效果
		stripeRows:true,//行效果
		tbar:[
		{// 添加按钮
			text:'添加',
			iconCls:'user_add',
			handler:function(){
				var m = new Member({
					name:'新员工',
					sex:'m',
					age:'20',
					birth:new Date().clearTime()
				});
				grid.stopEditing();
				store.insert(0, m);
				grid.startEditing(0, 2);
				store.getAt(0).dirty=true; // 设置该行记录为脏数据(默认为非脏数据),否则在保存时将无法判断该行是否已修改
			}
		},'-',{
			id:'newWindowButton',
			text:'新面板中添加',
			iconCls:'user_add',
			handler:function(){
			    showMemerAddWindow(); //显示表单所在窗体
			}
		},'-',{//删除按钮
			id:'btnDelete',
			text:'删除',
			iconCls:'user_delete',
			handler:function(){
				var sm = grid.getSelectionModel();
				var selected = sm.getSelections();
				var ids = [];
				for(var i=0;i<selected.length;i+=1){
					var member = selected[i].data;
					if(member.id) {
						ids.push(member.id); //如果有ID属性,则表示该行数据是被修改过的,所以需要访问数据库进行删除
					}else{
						//如果没有ID属性,则表示该行数据是新添加的未保存的数据,所以不需要访问数据库进行删除该行
						store.remove(store.getAt(i));
					}
				}
				if(ids.join('')=='') return;
				
				Ext.Msg.confirm('信息','确定要删除所选项吗?',function(btn){
					if(btn=='yes'){
						//发送删除请求
						Ext.lib.Ajax.request(
							'POST',
							'./member_manage.jsp',{
								success:function(request){
									var message = request.responseText;
									Ext.Msg.alert('信息',message);
									store.reload();
								},failure:function(){
									Ext.Msg.alert('错误','删除时出现未知错误.');
								}
							},
							'command=delete&ids='+ids
						);
					}
				});
			}
		},'-',{//保存按钮
			text:'保存',
			iconCls:'save',
			handler:function(){
				var json = [];
				for(i=0,cnt=store.getCount();i<cnt;i+=1){
					var record = store.getAt(i);
					if(record.dirty) // 得到所有修改过的数据
						json.push(record.data);
				}
				if(json.length==0){
					Ext.Msg.alert('信息','没有对数据进行任何更改');
					return;
				}
				
				//发送保存请求
				Ext.lib.Ajax.request(
					'POST',
					'./member_manage.jsp',{
						success:function(request){
							var message = request.responseText;
							Ext.Msg.alert('信息',message);
							store.reload();
							//grid.getView().refresh();
						},
						failure:function(){
							Ext.Msg.alert("错误", "与后台联系的时候出现了问题");
						}
					},
					'command=save&members='+encodeURIComponent(Ext.encode(json))
				);
			}
		},'-'],
	    bbar: new Ext.PagingToolbar({
	        pageSize: 10,
	        store: store,
	        displayInfo: true,
	        displayMsg: '显示第 {0} 条到 {1} 条记录，一共 {2} 条',
	        emptyMsg: "没有记录"
	    })

    });
    store.load({params:{start:0,limit:10}});
	
	
	
	/**
	 * 以下是表单 __________________________________________________
	 * */

	//姓名字段
	var nameField = new Ext.form.TextField({
		fieldLabel:'姓名',
		name:'memberName',
		allowBlank:false,
        anchor:'90%'
	});
	//性别字段
	var sexField = new Ext.form.ComboBox({
		fieldLabel:'性别',
		name:'sex',
		allowBlank:false,
	    mode: 'local',
	    readOnly:true,
	    triggerAction:'all',
	    anchor:'90%',
		store:new Ext.data.SimpleStore({
			fields:['value','text'],
			data:[
				['m','男'],
				['f','女']
			]
		}),
		valueField: 'value',
	    displayField: 'text'
	});
	//年龄字段
	var ageField = new Ext.form.NumberField({
		fieldLabel:'年龄',
		name:'age',
		allowBlank:false,
		allowNegative:false,
		allowDesimals:false,
		maxValue:80,
		minValue:18,
	    anchor:'90%'
	});
	//生日字段
	var birthField = new Ext.form.DateField({
		fieldLabel:'出生日期',
		name:'birth',
		format:'Y-m-d',
		readOnly:true,
	    anchor:'90%'
	});
	//表单对象
    var memberForm = new Ext.FormPanel({
        labelAlign: 'top',
        frame:true,
        title: '添加新员工信息',
        width: 300,
        url:'./member_manage.jsp?command=insert',
        
        items: [{
            layout:'column',// 该FormPanel的layout布局模式为列模式(column),包含2列
            items:[
            {//第一列
                columnWidth:0.5,
                layout: 'form',
                items: [nameField,sexField]
            },{//第二列
                columnWidth:0.5,
                layout: 'form',
                items: [ageField,birthField]
            }]
        }],
        buttons:[{
	        text:'提交',
	        handler:function(){
	        	if(memberForm.getForm().isValid())
		        	memberForm.getForm().submit({
		        		waitMsg:'保存中,请稍后...',
		        		success:function(){
		        			memberForm.getForm().reset();
		        			memberAddWindow.hide();
		        			store.reload();
		        		}
		        	});
	        }
	    },{
	    	text:'取消',
	    	handler:function(){
	    		memberForm.getForm().reset();
	    		memberAddWindow.hide();
	    	}
	    }]
    });
    
    //窗体对象
    function showMemerAddWindow(){
	    if(!memberAddWindow){
			memberAddWindow = new Ext.Window({
			    el:'window_win',
			    layout:'fit',
			    width:300,
			    height:200,
			    closable:false,
			    closeAction:'hide',
		        plain:true,
				resizable:true,
				plain : true,
			    items: [memberForm]
			});
	    }
		memberAddWindow.show(Ext.get('newWindowButton'));
    }
}




);
