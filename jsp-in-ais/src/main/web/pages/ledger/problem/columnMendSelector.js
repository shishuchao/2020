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
                ["mend.project_code","项目编号"],
                ["mend.project_name", "项目名称"],
                ["mend.pro_year", "项目年度"], 
                ["mend.pro_type_name", "项目类别"], 
                ["mend.pro_type_child_name", "项目子类别"], 
                ["mend.pro_teamleader_name", "项目组长"],
                ["mend.audit_dept_name", "审计单位"], 
                ["mend.audit_object_name", "被审计单位"], 
                ["mend.sort_big_name", "问题类别"],
                ["mend.sort_small_name", "问题子类别"],
                ["mend.problem_name", "问题点"],
                ["mend.problem_money", "发生数"],
                ["mend.p_unit", "统计单位"],
                ["mend.problem_grade_name", "问题定性"],
                ["mend.mend_term", "整改期限"],
                ["mend.mend_method", "整改方式"],
                ["mend.mend_result", "整改结果"],
                ["mend.examine_creater_name", "检查人"],
                ["foll.follow_p_code", "后续-项目编号"],
                ["foll.follow_p_name", "后续-项目名称"],
                ["foll.follow_p_year", "后续-项目年度"],
                ["foll.follow_audit_object_name", "后续-审计单位"],
                ["foll.f_fact_mend_method_name", "实际整改方式"],
                ["foll.f_fact_mend_thing", "实际整改情况"],
                ["foll.f_mend_opinion_name", "整改评价"]
                
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