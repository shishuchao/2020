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
                ["proj.project_code","项目编号"],
                ["proj.project_name", "项目名称"],
                ["proj.pro_year", "项目年度"], 
                ["proj.pro_type_name", "项目类别"], 
                ["proj.pro_type_child_name", "项目子类别"], 
                ["proj.pro_teamleader_name", "项目组长"],
                ["proj.audit_dept_name", "审计单位"], 
                ["proj.audit_object_name", "被审计单位"], 
                ["proj.task_name", "审计事项"], 
                ["dgao.manuscript_code", "底稿编号"], 
                ["dgao.m_audit_dept", "底稿被审计单位"],
                ["ledg.sort_big_name", "问题类别"],
                ["ledg.serial_num", "问题编号"],
                ["ledg.audit_con", "问题标题"],            
                ["ledg.problem_name", "问题点"],
                ["ledg.problem_grade_name", "审计发现类型"],
                ["ledg.problem_money", "发生金额(万元)"],
                ["ledg.problemCount", "发生数量(个)"],
                ["ledg.manuscript_creator_name", "发现人"], 
                ["ledg.manuscript_date", "发现时间"], 
//                ["ledg.ssms", "事实描述"],
//               ["ledg.cljd", "处理决定"]
//                ["ledg.creater_enddate", "问题所属结束日期"],
//                ["ledg.manuscript_creator_name", "问题发现人"],
//                ["ledg.problem_desc", "问题描述"]
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