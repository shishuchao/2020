<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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

	</head>
	<body>
		<script type="text/javascript">

	Ext.onReady(function(){
	Ext.BLANK_IMAGE_URL = '/ais/cloud/styles/extjs/resources/images/default/s.gif';
	var jsonReader=new Ext.data.JsonReader({
            root: 'list',
            totalProperty: 'pages',
            idProperty: 'id',
            fields: [
                {name: 'manuscript_code',mapping:'manuscript_code'},
                {name: 'manuscript_date',mapping:'manuscript_date'},
           		{name: 'sort_big_name',mapping:'sort_big_name'},
                {name: 'sort_small_name',mapping:'sort_small_name'},
                {name: 'problem_name',mapping:'problem_name'},
		        {name: 'problem_money',mapping:'problem_money'},
		        {name: 'p_unit',mapping:'p_unit'},
		        {name: 'problem_grade_name',mapping:'problem_grade_name'},
		        {name: 'isNotMend',mapping:'isNotMend'},
		        {name: 'isModify',mapping:'isModify'},
		        {name: 'manuscript_id',mapping:'manuscript_id'},
		        {name: 'taskAssignName',mapping:'taskAssignName'},
		        {name: 'creater_name',mapping:'creater_name'},
		        {name: 'link',mapping:'id'}
            ]
        });
    // create the Data Store
    var store = new Ext.data.Store({
        // load using script tags for cross domain, if the data in on the same domain as
        // this page, an HttpProxy would be better
        proxy: new Ext.data.HttpProxy({
            url: '${pageContext.request.contextPath}/proledger/problem/loadJsonString.action?project_id=${project_id}&permission=${permission}&isrework=${isrework}&isEdit=${isEdit}'
        }),

        // create reader that reads the Topic records
        reader: jsonReader,

        // turn on remote sorting
        remoteSort: false
    });

    // pluggable renders
    function renderTopic(value, cellmeta, record, rowIndex, columnIndex, store){
            var isModify=record.get("isModify");
            ${isEdit}
            <s:if test="${isEdit=='false'}">
               var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/proledger/problem/edit.action?id='+value+'&&project_id=${project_id}&isView=${isView}&isrework=${isrework}&isEdit=${isEdit}">问题整改</a>';
			   return s;
            </s:if>
            <s:else>
            if(isModify=='true'){
                var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/proledger/problem/edit.action?id='+value+'&&project_id=${project_id}&isView=&isrework=${isrework}">问题整改</a>';
 			   return s;
 			}else{
 			    var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/proledger/problem/edit.action?id='+value+'&&project_id=${project_id}&isView=true&isrework=${isrework}">问题整改</a>';
 			   return s;
 			}
            </s:else>
    }

    function renderDate(value){
    	if(value!=null)
        	return value.substr(0,10);
        else
        	return "";
    }

  //底稿穿透页面   
    function diGaoView(value, cellmeta, record, rowIndex, columnIndex, store){
    	 var manuscript_id=record.get("manuscript_id");
    	 var s='<a style="cursor:hand" href="javascript:void(0);" onclick="window.open(\'${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId='+manuscript_id+'\',\''
         + '\',\'width=800px,height=700px,toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no\');return false">'+value+'</a>';
	     return s;
    }

    // the column model has information about grid columns
    // dataIndex maps the column to the specific data field in
    // the data store
    var cm = new Ext.grid.ColumnModel([
    	{
           header: "底稿编号",
           dataIndex: 'manuscript_code',
           autoWidth: true,
           renderer: diGaoView
        },
    	{
           header: "问题类别",
           dataIndex: 'sort_big_name',
           autoWidth: true
        },
        {
           header: "问题子类别",
           dataIndex: 'sort_small_name',
           autoWidth: true
        },
    	{
           header: "问题点",
           dataIndex: 'problem_name',
           autoWidth: true
        },
        {
           header: "发生数",
           dataIndex: 'problem_money',
           autoWidth: true
        },
        {
            header: "统计单位",
            dataIndex: 'p_unit',
            autoWidth: true
         },
        {
           header: "问题定性",
           dataIndex: 'problem_grade_name',
           autoWidth: true
        },
        {
             header: "分组",
             dataIndex: 'taskAssignName',
             autoWidth: true
        },
        {
              header: "发现人",
              dataIndex: 'creater_name',
              autoWidth: true
        },
        {
            header: "是否整改",
            dataIndex: 'isNotMend',
            autoWidth: true
         },
        {
           header:'操作',
           dataIndex: 'link',
           autoWidth: true,
           align: 'center',
           width:130,
           renderer: renderTopic
        }
        ]);

    // by default columns are sortable
    cm.defaultSortable = true;

    var grid = new Ext.grid.GridPanel({
        el:'topic-grid',
        width:Ext.get('topic-grid').getWidth(),
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
        })
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
