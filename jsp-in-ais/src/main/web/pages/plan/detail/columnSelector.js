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
                ['plan.status_name',"计划状态"],
                ["plan.w_plan_code", "计划编号"],
                ["plan.w_plan_name", "计划名称"], 
                ["plan.w_plan_type_name", "计划类别"], 
                ["plan.w_plan_year", "计划年度"],
                ["plan.w_plan_month", "计划月度"], 
                ["plan.w_plan_excute_month", "开始执行月度"], 
                ["plan.plan_grade_name", "计划等级"], 
                ["plan.pro_type_name", "项目类别"],
                ["plan.pro_type_child_name", "项目子类别"],
                ["plan.audit_dept_name", "审计单位"],
                ["plan.pro_teamleader_name", "项目组长"],
                ["plan.audit_object_name", "被审计单位"],
                ["plan.audit_start_time", "审计期间(起)"],
                ["plan.audit_end_time", "审计期间(止)"],
                ["exec.proInfo.pro_auditleader_name", "项目主审"],
                ["exec.proInfo.currentStageName", "执行阶段"],
                ["exec.proInfo.real_start_time", "启动日期"],
                ["exec.proInfo.real_closed_time", "关闭日期"]
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
                		window.parent.execExport(res);
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