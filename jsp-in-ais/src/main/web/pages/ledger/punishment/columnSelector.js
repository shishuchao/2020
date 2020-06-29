/*
 * Ext JS Library 2.3.0
 * Copyright(c) 2006-2009, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

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
            imagePath:"../../../cloud/styles/extjs/examples/ux/images/",
            toLegend:"已选列",
            fromLegend:"可选列",
            fromData:[
                ["project_code","项目编号"],
                ["project_name", "项目名称"],
                ["audit_object_name", "被审计单位"], 
                ["audited_name", "姓名"], 
                ["isSupervise", "是否移送纪检监察处理"], 
                ["isJudicatory", "是否移送司法机关处理"],
                ["adviseMethod", "建议处罚方式"], 
                ["practiceMethod", "实际处理方式"], 
                ["remark_1", "备注"], 
                ["adviseMoney", "建议惩罚金额"],
                ["practiceMoney", "实际惩罚金额"],
                ["remark_2", "备注"]
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