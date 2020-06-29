<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>test</title>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/styles/portal/ext-all.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/portal/ext-base.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/portal/ext-all.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/portal/ext-lang-zh_CN.js"></script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/cncext/grid-examples.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/cncext/forms.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/cncext/combos.css" />
		<SCRIPT LANGUAGE="JavaScript">
Ext.onReady(function(){
	var simple = new Ext.form.FormPanel({
        labelWidth: 250,
        frame:true,
        title: '自定义台账',
        bodyStyle:'padding:5px 5px 0',
        width: Ext.get('mytradionalform').getWidth(),
        autoHeight:true,
        defaults: {width: 550},
        defaultType: 'textfield',
		items: [
            {
                fieldLabel: '专题',
                name: 'customLedger.p_subject',
                value:'${customLedger.p_subject}'
            },{
                fieldLabel: '组',
                name: 'customLedger.p_group',
                value:'${customLedger.p_group}'
            },{
                fieldLabel: '上标题',
                name: 'customLedger.p_headtitle',
                value:'${customLedger.p_headtitle}'
            },{
                fieldLabel: '上标题序列',
                name: 'customLedger.p_headtitle_order',
                value:'${customLedger.p_headtitle_order}'
            },{
                fieldLabel: '下标题',
                name: 'customLedger.p_undertitle',
                value:'${customLedger.p_undertitle}'
            },{
                fieldLabel: '下标题序列',
                name: 'customLedger.p_undertitle_order',
                value:'${customLedger.p_undertitle_order}'
            },{
                fieldLabel: '下标题对应的键值',
                name: 'customLedger.p_key',
                value:'${customLedger.p_key}'
            },{
                xtype:'combo',
                fieldLabel: '下标题对应数据类型',
                store :new Ext.data.SimpleStore({
                       fields: ['customLedger.p_datatype', 'state'],
                       data : [['String','文本类型'],['double','金额类型'],['date','日期类型'],['boolean','布尔类型'],['int','整数类型']]
                }),
                hiddenName: 'customLedger.p_datatype',
                valueField:'customLedger.p_datatype',
                displayField:'state',
                typeAhead: true,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                value:'${customLedger.p_datatype}'
            },{
                xtype:'textarea',
                fieldLabel: '公式',
                name: 'customLedger.p_sum',
                value:'${customLedger.p_sum}'
            },
            {
                xtype:'textarea',
                fieldLabel: '外部数据',
                name: 'customLedger.p_outdata',
                value:'${customLedger.p_outdata}'
            },
            {
                xtype:'combo',
                fieldLabel: '实施阶段',
                store :new Ext.data.SimpleStore({
                       fields: ['customLedger.actualize_closed', 'state'],
                       data : [[1,'是'],[0,'否']]
                }),
                hiddenName: 'customLedger.actualize_closed',
                valueField:'customLedger.actualize_closed',
                displayField:'state',
                typeAhead: true,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                value:'${customLedger.actualize_closed}'
            },
            {
                xtype:'combo',
                fieldLabel: '终结阶段',
                store :new Ext.data.SimpleStore({
                       fields: ['customLedger.report_closed', 'state'],
                       data : [[1,'是'],[0,'否']]
                }),
                hiddenName: 'customLedger.report_closed',
                valueField:'customLedger.report_closed',
                displayField:'state',
                typeAhead: true,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                value:'${customLedger.report_closed}'
            },
            {
                xtype:'combo',
                fieldLabel: '整改跟踪阶段',
                store :new Ext.data.SimpleStore({
                       fields: ['customLedger.rework_closed', 'state'],
                       data : [[1,'是'],[0,'否']]
                }),
                hiddenName: 'customLedger.rework_closed',
                valueField:'customLedger.rework_closed',
                displayField:'state',
                typeAhead: true,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                value:'${customLedger.rework_closed}'
            },
            
            {
               xtype:'hidden',
               name:'customLedger.id',
               value:'${customLedger.id}'
            }
 
        ],
        buttons: [{
            text: '提交',
            handler: function() {
              this.disabled=true;
		      simple.form.doAction('submit',{
		       url:'${pageContext.request.contextPath}/proledger/custom/save.action',
		       method:'post'
		      });
            }
        },{
            text:'返回',
            handler:function(){
            window.location.href='${pageContext.request.contextPath}/pages/ledger/custom/list_proledger_custom.jsp'; 
            }
        }]
 
 
    });
    simple.render('mytradionalform');
});
</SCRIPT>
	</head>
	<body>
		<div id="mytradionalform">
		
		<div>
	</body>
</html>