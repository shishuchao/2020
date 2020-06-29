<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>处理处罚台账</title>
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
function validateDel(value){
		  if(window.confirm('确认删除吗?')){
		    window.location.href="${pageContext.request.contextPath}/proledger/punishment/delete.action?project_id=${project_id}&&id="+value;
		  }
		  else{
		   return false;
		  }
		}

	Ext.onReady(function(){
	var jsonReader=new Ext.data.JsonReader({
            root: 'list',
            totalProperty: 'pages',
            id: 'threadid',
            fields: [
                {name: 'audit_object_name',mapping:'audit_object_name'},
                {name: 'audited_name',mapping:'audited_name'},
		        {name: 'isSupervise',mapping:'isSupervise'},
		        {name: 'isJudicatory',mapping:'isJudicatory'},
		        {name: 'adviseMethod',mapping:'adviseMethod'},
                {name: 'practiceMethod',mapping:'practiceMethod'},
		        {name: 'remark_1',mapping:'remark_1'},
		        {name: 'adviseMoney',mapping:'adviseMoney'},
		        {name: 'practiceMoney',mapping:'practiceMoney'},
		        {name: 'remark_2',mapping:'remark_2'},
		        {name: 'link',mapping:'id'}
            ]
        });
    // create the Data Store
    var store = new Ext.data.Store({
        // load using script tags for cross domain, if the data in on the same domain as
        // this page, an HttpProxy would be better
        proxy: new Ext.data.HttpProxy({
            url: '${pageContext.request.contextPath}/proledger/punishment/loadJsonString.action?project_id=${project_id}'
        }),

        // create reader that reads the Topic records
        reader: jsonReader,

        // turn on remote sorting
        remoteSort: false
    });

    // pluggable renders
    function renderTopic(value){
            <s:if test="isView=='true'">
			</s:if>
			<s:else>
            var s='<a style="cursor:hand" href="${pageContext.request.contextPath}/proledger/punishment/edit.action?id='+value+'&project_id=${project_id}">修改</a> &nbsp;&nbsp;';
		     s+='<a style="cursor:hand" href="javascript:void(0);" onclick="return validateDel(\''+value+'\');">删除</a>';
			return s;
			</s:else>
    }
    
    
     function renderStatus(value){
        if(value=='Y'){
        	return "是";
        }
        else{
        	return "否";
        }
    }

    // the column model has information about grid columns
    // dataIndex maps the column to the specific data field in
    // the data store
    var cm = new Ext.grid.ColumnModel([
 {
    header: "被审计单位",
    dataIndex: 'audit_object_name',
    autoWidth: true
 },
    	{
           header: "姓名",
           dataIndex: 'audited_name',
           autoWidth: true
        },
        {
           header: "是否移送纪检监察处理",
           dataIndex: 'isSupervise',
           renderer: renderStatus,
           autoWidth: true
        },
        {
           header: "是否移送司法机关处理",
           dataIndex: 'isJudicatory',
           renderer: renderStatus,
           autoWidth: true
        },
        {
           header: "建议处罚方式",
           dataIndex: 'adviseMethod',
           autoWidth: true
        },
         {
           header: "实际处理方式",
           dataIndex: 'practiceMethod',
           autoWidth: true
        },
         {
           header: "备注",
           dataIndex: 'remark_1',
           autoWidth: true
        },
         {
           header: "建议惩罚金额",
           dataIndex: 'adviseMoney',
           autoWidth: true
        },
        {
           header: "实际惩罚金额",
           dataIndex: 'practiceMoney',
           autoWidth: true
        },
        {
           header: "备注",
           dataIndex: 'remark_2',
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
		<br>
		<center>
			<s:if test="isView=='true'">

			</s:if>
			<s:else>
				<input type="button" name="add" value="增加"
					onclick="javascript:window.location='<s:url namespace="/proledger/punishment" action="edit"><s:param name="id" value="0"/><s:param name="project_id" value="project_id"/></s:url>'">
			</s:else>
		</center>

	</body>
</html>
