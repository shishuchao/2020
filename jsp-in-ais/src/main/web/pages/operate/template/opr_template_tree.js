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
			header: "����",
			dataIndex: 'name',
			editor: new fm.TextField({
				allowBlank: false
			})
        },{
			header:'�Ա�',
			dataIndex:'sex',
			width:60,
			align:'center',
			renderer:function(v){
				return '<img src="images/'+v+'.png"/>'+(v=='m'?'��':'Ů');
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
			header:'����',
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
			header: "����",
			dataIndex: 'birth',
			renderer: function(v){
				return v ? v.dateFormat('Y��m��d��') : '';
			},
			editor: new fm.DateField({
				format: 'Y-m-d',
				minValue: '1800-01-01',
				readOnly:true,
				disabledDays: [0, 6],
				disabledDaysText: '�벻Ҫѡ����ĩ'
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
		sortInfo: {field: "id", direction: "ASC"} //����Ĭ���������, EditorGridPanel��������һ��ȴδ����ʱ������header��������'��142�ַ�6983,modifiedΪ�ջ��Ƕ���'
	});

	//������
	var memberAddWindow;

    var grid = new Ext.grid.EditorGridPanel({
        store: store,
        cm: cm,
        renderTo: 'member_grid',
        resizeable:true,
		width:640,
        height:480,
        title:'Ա������123',
        frame:true,
        clicksToEdit:1,
		sm:sm,
		iconCls:'icon-grid',
		loadMask: true,//����Ч��
		stripeRows:true,//��Ч��
		tbar:[
		{// ��Ӱ�ť
			text:'���',
			iconCls:'user_add',
			handler:function(){
				var m = new Member({
					name:'��Ա��',
					sex:'m',
					age:'20',
					birth:new Date().clearTime()
				});
				grid.stopEditing();
				store.insert(0, m);
				grid.startEditing(0, 2);
				store.getAt(0).dirty=true; // ���ø��м�¼Ϊ������(Ĭ��Ϊ��������),�����ڱ���ʱ���޷��жϸ����Ƿ����޸�
			}
		},'-',{
			id:'newWindowButton',
			text:'����������',
			iconCls:'user_add',
			handler:function(){
			    showMemerAddWindow(); //��ʾ�����ڴ���
			}
		},'-',{//ɾ����ť
			id:'btnDelete',
			text:'ɾ��',
			iconCls:'user_delete',
			handler:function(){
				var sm = grid.getSelectionModel();
				var selected = sm.getSelections();
				var ids = [];
				for(var i=0;i<selected.length;i+=1){
					var member = selected[i].data;
					if(member.id) {
						ids.push(member.id); //�����ID����,���ʾ���������Ǳ��޸Ĺ���,������Ҫ�������ݿ����ɾ��
					}else{
						//���û��ID����,���ʾ��������������ӵ�δ���������,���Բ���Ҫ�������ݿ����ɾ������
						store.remove(store.getAt(i));
					}
				}
				if(ids.join('')=='') return;
				
				Ext.Msg.confirm('��Ϣ','ȷ��Ҫɾ����ѡ����?',function(btn){
					if(btn=='yes'){
						//����ɾ������
						Ext.lib.Ajax.request(
							'POST',
							'./member_manage.jsp',{
								success:function(request){
									var message = request.responseText;
									Ext.Msg.alert('��Ϣ',message);
									store.reload();
								},failure:function(){
									Ext.Msg.alert('����','ɾ��ʱ����δ֪����.');
								}
							},
							'command=delete&ids='+ids
						);
					}
				});
			}
		},'-',{//���水ť
			text:'����',
			iconCls:'save',
			handler:function(){
				var json = [];
				for(i=0,cnt=store.getCount();i<cnt;i+=1){
					var record = store.getAt(i);
					if(record.dirty) // �õ������޸Ĺ�������
						json.push(record.data);
				}
				if(json.length==0){
					Ext.Msg.alert('��Ϣ','û�ж����ݽ����κθ���');
					return;
				}
				
				//���ͱ�������
				Ext.lib.Ajax.request(
					'POST',
					'./member_manage.jsp',{
						success:function(request){
							var message = request.responseText;
							Ext.Msg.alert('��Ϣ',message);
							store.reload();
							//grid.getView().refresh();
						},
						failure:function(){
							Ext.Msg.alert("����", "���̨��ϵ��ʱ�����������");
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
	        displayMsg: '��ʾ�� {0} ���� {1} ����¼��һ�� {2} ��',
	        emptyMsg: "û�м�¼"
	    })

    });
    store.load({params:{start:0,limit:10}});
	
	
	
	/**
	 * �����Ǳ� __________________________________________________
	 * */

	//�����ֶ�
	var nameField = new Ext.form.TextField({
		fieldLabel:'����',
		name:'memberName',
		allowBlank:false,
        anchor:'90%'
	});
	//�Ա��ֶ�
	var sexField = new Ext.form.ComboBox({
		fieldLabel:'�Ա�',
		name:'sex',
		allowBlank:false,
	    mode: 'local',
	    readOnly:true,
	    triggerAction:'all',
	    anchor:'90%',
		store:new Ext.data.SimpleStore({
			fields:['value','text'],
			data:[
				['m','��'],
				['f','Ů']
			]
		}),
		valueField: 'value',
	    displayField: 'text'
	});
	//�����ֶ�
	var ageField = new Ext.form.NumberField({
		fieldLabel:'����',
		name:'age',
		allowBlank:false,
		allowNegative:false,
		allowDesimals:false,
		maxValue:80,
		minValue:18,
	    anchor:'90%'
	});
	//�����ֶ�
	var birthField = new Ext.form.DateField({
		fieldLabel:'��������',
		name:'birth',
		format:'Y-m-d',
		readOnly:true,
	    anchor:'90%'
	});
	//������
    var memberForm = new Ext.FormPanel({
        labelAlign: 'top',
        frame:true,
        title: '�����Ա����Ϣ',
        width: 300,
        url:'./member_manage.jsp?command=insert',
        
        items: [{
            layout:'column',// ��FormPanel��layout����ģʽΪ��ģʽ(column),����2��
            items:[
            {//��һ��
                columnWidth:0.5,
                layout: 'form',
                items: [nameField,sexField]
            },{//�ڶ���
                columnWidth:0.5,
                layout: 'form',
                items: [ageField,birthField]
            }]
        }],
        buttons:[{
	        text:'�ύ',
	        handler:function(){
	        	if(memberForm.getForm().isValid())
		        	memberForm.getForm().submit({
		        		waitMsg:'������,���Ժ�...',
		        		success:function(){
		        			memberForm.getForm().reset();
		        			memberAddWindow.hide();
		        			store.reload();
		        		}
		        	});
	        }
	    },{
	    	text:'ȡ��',
	    	handler:function(){
	    		memberForm.getForm().reset();
	    		memberAddWindow.hide();
	    	}
	    }]
    });
    
    //�������
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
