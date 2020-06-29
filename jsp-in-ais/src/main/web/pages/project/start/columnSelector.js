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
                ['proj.is_closed',"状态"],
                ["proj.pso.project_code", "项目编号"],
                ["proj.pso.project_name", "项目名称"], 
                ["proj.pso.plan_type_name", "计划类别"], 
                ["proj.pso.pro_year", "年度"],
                ["proj.month", "月度"], 
                ["proj.excute_month", "执行月度"], 
                ["proj.pso.plan_grade_name", "计划等级"], 
                ["proj.pso.pro_type_name", "项目类别"],
                ["proj.pso.pro_type_child_name", "项目子类别"],
                ["proj.pso.audit_dept_name", "审计单位"],
                ["proj.pso.audit_object_name", "被审计单位"],
                ["proj.pso.audit_start_time", "审计期间(起)"],
                ["proj.pso.audit_end_time", "审计期间(止)"],
                ["proj.jieduan", "执行阶段"],
                ["proj.pso.real_start_time", "启动日期"],
                ["proj.pso.real_start_time", "关闭日期"],
                ["work.TRRS", "投入人数"],
                ["work.XMGZTS", "项目工作天数"],
                ["work.RTS", "人天数"],
                ["blak.SJWTS", "审计问题(条)"],
                ["blak.SJWTJE", "审计问题金额(元)"],
                ["blak.CCSSLF", "查出损失浪费(元)"],
                ["blak.ZJXY", "增加效益(元)"],
                ["blak.DAYAXS", "发现大案要案线索(件)"],
                ["zgcl.TCZGJY", "提出整改建议"],
                ["zgcl.JYBCN", "建议被采纳"],
                ["zgcl.TCCLYJ", "提出处理意见"],
                ["zgcl.YJBCN", "意见被采纳"],
                ["blak.XZCF", "行政处分(人)"],
                ["blak.JJCF", "经济处罚(元)"],
                ["blak.YSJJJCCL", "移送纪检监察处理(人)"],
                ["blak.XSFJGYSAJ", "向司法机关移送案件(件)"],
                ["blak.YSSFJGCL", "移送司法机关处理(人)"]
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