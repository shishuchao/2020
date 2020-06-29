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
                ['daxx.apo.archives_status_name',"归档状态"],
                ["daxx.apo.archives_code", "档案编号"],
                ["daxx.apo.archives_name", "档案名称"],
                ["daxx.apo.archives_unit_name", "实施单位"],
                ["daxx.apo.archives_secrecy_name", "秘密等级"],
                ["daxx.apo.basic_save_year_name", "保存期限（年）"],
                ["daxx.apo.archives_start_man_name", "归档发起人"],
                ["daxx.apo.archives_year", "档案年度"],
                ["daxx.apo.archives_time", "归档日期"],
                ["xmxx.pso.plan_code", "计划编号"],
                ["xmxx.apo.project_name", "项目名称"],
                ["xmxx.planSrc", "计划来源"],
                ["xmxx.pso.plan_type_name", "计划类别"],
                ["xmxx.pso.plan_grade_name", "计划等级"],
                ["xmxx.wpd.w_plan_year", "计划年度"],
                ["xmxx.wpd.w_plan_month", "计划月度"],
                ["xmxx.pso.pro_type_name", "项目类别"],
                ["xmxx.pso.pro_type_child_name", "项目子类别"],
                ["xmxx.pso.audit_dept_name", "审计单位"],
                ["xmxx.pso.audit_object_name", "被审计单位"],
                ["xmxx.pso.audit_start_time", "审计期间（起）"],
                ["xmxx.pso.audit_end_time", "审计期间（止）"],
                ["xmxx.zuzhang", "项目组长"],
                ["xmxx.zhushen", "项目主审"],
                ["xmxx.pso.real_start_time", "启动日期"],
                ["xmxx.pso.real_closed_time", "关闭日期"]
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