   Ext.onReady(function(){

        Ext.QuickTips.init();
        Ext.form.Field.prototype.msgTarget = 'side';
        
        /*
    	 * Ext.ux.ItemSelector Example Code
    	 */
        var isForm = new Ext.form.FormPanel({
            title: '',
            width:496,
            bodyStyle: 'padding:10px;',
            renderTo: 'itemselector',
            items:[{
                xtype:"itemselector",
                name:"itemselector",
                hideLabel:true,
                dataFields:["code", "desc"],
                toData:[],
                msWidth:223,
                msHeight:274,
                valueField:"code",
                displayField:"desc",
                imagePath:"../../cloud/styles/extjs/examples/ux/images/",
                toLegend:"已选列",
                fromLegend:"可选列",
                fromData:[
                  		["proj.project_code", "项目编号"],
                  		["proj.project_name", "项目名称"],
                  		["proj.pro_year", "项目年度"],
                  		["proj.pro_type_name", "项目类别"],
                  		["proj.audit_dept_name", "审计单位"],
                  		["proj.audit_object_name", "被审计单位"],
                  		["xmtz.xmrs", "项目人数"],
                  		["xmtz.xmts", "项目天数"],
                  		["xmtz.rtshj", "人天数合计"],
                  		["xxxx.sjwt", "审计问题（条数）"],
                  		["xxxx.sjwtje", "审计问题金额（万元）"],
                  		["xxxx.ccsslf", "查出损失浪费（万元）"],
                  		["xxxx.zjxy", "增加收益（万元）"],
                  		["xxxx.dayaxs", "发现大案要案线索（条数）"],
                  		["yjjy.tczgjy", "提出整改建议"],
                  		["yjjy.jybcn", "建议被采纳"],
                  		["yjjy.clyj", "提出处理建议"],
                  		["yjjy.yjbcn", "意见被采纳"],
                  		["xxxx.xzcf", "行政处分（条数）"],
                  		["xxxx.jjcf", "经济处分（人）"],
                  		["xxxx.ysjjjccl", "移送纪检监察处理（人）"],
                  		["xxxx.yssfjgaj", "移送司法机关案件（件）"],
                  		["xxxx.yssfjgcl", "移送司法机关（人）"]
                    ],
                toTBar:[{
                    text:"重置",
                    handler:function(){
                        var i=isForm.getForm().findField("itemselector");
                        i.reset.call(i);
                    }
                }]
            }],
            
            buttons: [{
                text: '导出',
                handler: function(){
                    if(isForm.getForm().isValid()){
                    	var res = isForm.getForm().getValues(true);
                    	if(res=='itemselector='){
                    		alert("至少选择一列！");
                    	}else{
                    		window.parent.exportExcel(res);
                            window.parent.hidePopWin(false);
                    	}
                    }
                }
            },{
                text: '取消',
                handler: function(){
                    window.parent.hidePopWin(false);
                }
            }]
        });
        
    });