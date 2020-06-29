<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>问题统计</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/styles/portal/ext-all.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/pages/ledger/ext/ext-base.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/pages/ledger/ext/ext-all.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/portal/ext-lang-zh_CN.js"></script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/cncext/grid-examples.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/cncext/examples.css" />
<script type="text/javascript"
			src="${pageContext.request.contextPath}/pages/ledger/ext/GroupHeaderPlugin.js"></script>
	</head>
	<body>
		<script type="text/javascript">

	Ext.onReady(function(){
	var jsonReader=new Ext.data.JsonReader({
            root: 'list',
            totalProperty: 'pages',
            idProperty: 'id',
            fields: [
                {name: 'ms_code',mapping:'ms_code'},
                {name: 'dg_sjyj',mapping:'dg_sjyj'},
                {name: 'dg_lszg',mapping:'dg_lszg'},
           		{name: 'cg_shifou',mapping:'cg_shifou'},
           		{name: 'cg_yuaanyin',mapping:'cg_yuaanyin'},
           		{name: 'zq_shifou',mapping:'zq_shifou'},
           		{name: 'zq_yuaanyin',mapping:'zq_yuaanyin'},
           		{name: 'fk_shifou',mapping:'fk_shifou'},
                {name: 'fk_neirong',mapping:'fk_neirong'},
                
		        {name: 'zg_shifou',mapping:'zg_shifou'},
           		{name: 'zg_yuaanyin',mapping:'zg_yuaanyin'},
           		{name: 'zg_zgjy',mapping:'zg_zgjy'},
                {name: 'zg_clyj',mapping:'zg_clyj'},
		       
		       
		        {name: 'zheng_zgjy',mapping:'zheng_zgjy'},
           		{name: 'zheng_clyj',mapping:'zheng_clyj'},
                {name: 'zheng_date',mapping:'zheng_date'},
                
                
		        {name: 'formId',mapping:'formId'} 
		         
            ]
        });
    // create the Data Store
    var store = new Ext.data.Store({
        // load using script tags for cross domain, if the data in on the same domain as
        // this page, an HttpProxy would be better
        proxy: new Ext.data.HttpProxy({
            url: '${pageContext.request.contextPath}/proledger/problem/loadJsonStringManu.action?project_id=${project_id}&permission=${permission}'
        }),

        // create reader that reads the Topic records
        reader: jsonReader,

        // turn on remote sorting
        remoteSort: false
    });

    // pluggable renders
   function renderTopic(value, cellmeta, record, rowIndex, columnIndex, store){
          
			if('<%=request.getParameter("isView")%>'!='true'){
		 
               var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/operate/manuExt/editManuLed.action?form_id='+value+'&&project_id=${project_id}&isView=false">审计工作台账</a>';
			   return s;
			}else{
			 
			    var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/operate/manuExt/editManuLed.action?form_id='+value+'&&project_id=${project_id}&isView=true">审计工作台账</a>';
			   return s;
			}
    }


    function renderDate(value){
    	if(value!=null)
        	return value.substr(0,10);
        else
        	return "";
    }

  //底稿穿透页面   
    function diGaoView(value, cellmeta, record, rowIndex, columnIndex, store){
    	 var manuscript_id=record.get("formId");
    	 var s='<a style="cursor:hand" href="javascript:void(0);" onclick="window.open(\'${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId='+manuscript_id+'\',\''
         + '\',\'width=800px,height=700px,toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no\');return false">'+value+'</a>';
	     return s;
    }

    // the column model has information about grid columns
    // dataIndex maps the column to the specific data field in
    // the data store
    var cm = new Ext.grid.ColumnModel({columns: [
    	{
           header: "底稿编号",
           dataIndex: 'ms_code',
           width: 200,
           renderer: diGaoView
        },
        {
           header: "审计意见/建议",
           dataIndex: 'dg_sjyj',
           autoWidth: 150
        },
        {
           header: "落实/整改情况",
           dataIndex: 'dg_lszg',
           autoWidth: 150
        },
        
        
        
        {
           header: "是否上报告初稿",
           dataIndex: 'cg_shifou',
           autoWidth: 100
        },
        {
           header: "未上报告初稿原因",
           dataIndex: 'cg_yuaanyin',
           autoWidth: 150
        }, 
        
        
        {
           header: "是否上征求意见稿",
           dataIndex: 'zq_shifou',
           autoWidth: 100
        },
        {
           header: "未上征求意见稿原因",
           dataIndex: 'zq_yuaanyin',
           autoWidth: 150
        },
        
   
        
        
        
        {
           header: "是否反馈意见",
           dataIndex: 'fk_shifou',
           autoWidth: 100
        },
        {
           header: "反馈内容",
           dataIndex: 'fk_neirong',
           autoWidth: 150
        },
        
        
        {
           header: "是否上报告终稿",
           dataIndex: 'zg_shifou',
           autoWidth: 100
        },
        {
           header: "未上终稿原因",
           dataIndex: 'zg_yuaanyin',
           autoWidth: 150
        },
        
        
        
        
        {
           header: "整改建议",
           dataIndex: 'zg_zgjy',
           autoWidth: 150
        },
        {
           header: "处理意见",
           dataIndex: 'zg_clyj',
           autoWidth: 150
        },
        
        
        
        
        
        {
           header: "整改建议",
           dataIndex: 'zheng_zgjy',
           autoWidth: 150
        },
        {
           header: "处理意见",
           dataIndex: 'zheng_clyj',
           autoWidth: 150
        },
        {
           header: "计划执行时间",
           dataIndex: 'zheng_date',
           autoWidth: 150,
           renderer:renderDate
        },
        
        
    	 
        {
           header:'操作',
           dataIndex: 'formId',
           autoWidth: true,
           align: 'center',
           width:130,
           renderer: renderTopic
        }
        ]
       , rows: [
          [{header: '工作底稿', colspan: 3, align: 'center'},{header: '审计报告初稿', colspan: 2, align: 'center'},{header: '征求意见稿', colspan: 2, align: 'center'},{header: '反馈意见', colspan: 2, align: 'center'},{header: '审计报告终稿', colspan: 4, align: 'center'},{header: '整改情况', colspan: 3, align: 'center'},{header: '',rowspan: 2, align: 'center'}]
        ]
        }
        
        );

    // by default columns are sortable
    cm.defaultSortable = true;

    var grid = new Ext.grid.GridPanel({
        el:'topic-grid',
        autoWidth:true,
        autoHeight:true,
        align:'center',
        store: store,
        cm: cm,
        trackMouseOver:false,
        sm: new Ext.grid.RowSelectionModel({selectRow:Ext.emptyFn}),
        loadMask: true,
        viewConfig: {
            forceFit:true,
            enableRowBody:true,
            showPreview:true
        },
        bbar: new Ext.PagingToolbar({
            pageSize: 20,
            store: store,
            displayInfo: true,
            displayMsg: '显示记录 {0} - {1}，共有{2}条记录',
            emptyMsg: "没有要显示的记录！",
            beforePageText :"当前页",
            afterPageText:"共{0}页"
        }),
        plugins: [new Ext.ux.plugins.GroupHeaderGrid()]
        
    });

    // render it
    grid.render();

    // trigger the data store load
    store.load({params:{start:0, limit:20}});

});
	</script>
		<div id="topic-grid" style="margin-left: 0px"></div>
	</body>
</html>
