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
		<meta http-equiv="description" content="This is my page">
		<link
			href="${pageContext.request.contextPath}/styles/main/ais4ext.css"
			rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
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
			
<script type="text/javascript">
  function exportExcel(columns){
	      document.getElementById('export').value='true';
	      document.getElementById('itemselector').value=columns;
	      queryform.action="${pageContext.request.contextPath}/proledger/punishment/queryPunishment.action";
	      queryform.submit();
	    }
  function queryForm(){
	      document.getElementById('export').value='false';
	      queryform.action="${pageContext.request.contextPath}/proledger/punishment/searchPunishmentLedger.action";
	      queryform.submit();
	  }
  
  //统计分析
		function analyse(){
		  var project_code= document.getElementsByName("ledgerPunishment.project_code")[0].value;
		  if(project_code==''){
		     project_code="null";
		  }
		  var project_name= document.getElementsByName("ledgerPunishment.project_name")[0].value;
		   if(project_name==''){
		     project_name="null";
		  }
		  var names=project_code+","+project_name;
          var codes="p.project_code,p.project_name";
		  document.getElementsByName("codes")[0].value=codes;
          document.getElementsByName("names")[0].value=names;
		  window.open("${pageContext.request.contextPath}/ledger/ledgerAnalyse/createTableList.action?poName=LedgerPunishment&className=2","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
		}
</script>
	</head>
	<body>
		<s:form id="queryform" action="searchPunishmentLedger" namespace="/proledger/punishment"
				method="post">
				<table id="planTable" cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable">
					<tr class="listtablehead">
						<td align="left" class="listtabletr11">
							项目编号：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="ledgerPunishment.project_code" cssStyle="width:100%" />
						</td>
						<td align="left" class="listtabletr11">
							项目名称：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="ledgerPunishment.project_name" cssStyle="width:100%" />
						</td>
					</tr>
					<tr class="listtablehead">
					    <td align="left" class="listtabletr11">
							被审计单位：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="ledgerPunishment.audit_object_name" cssStyle="width:100%" />
						</td>
						<td align="right" class="listtabletr1" colspan="2">
							<DIV align="right">
								<s:submit value="查询" onclick="queryForm();" cssStyle="width:100"/>
								<s:button value="重置" cssStyle="width:100" onclick="resetbutton();"></s:button>
							    <s:button value="导出Excel" cssStyle="width:100" onclick="showPopWin('${pageContext.request.contextPath}/pages/ledger/punishment/columnSelector.jsp',500,350);" />
							</DIV>
						</td>
					</tr>
			     </table>
		<script type="text/javascript">
	 function resetbutton(){
       document.getElementsByName("ledgerPunishment.project_code")[0].value="";
       document.getElementsByName("ledgerPunishment.project_name")[0].value="";     
       document.getElementsByName("ledgerPunishment.audit_object_name")[0].value="";
	}
	
	Ext.onReady(function(){
	var jsonReader=new Ext.data.JsonReader({
            root: 'list',
            totalProperty: 'pages',
            id: 'threadid',
            fields: [
                {name: 'project_code',mapping:'project_code'},
                {name: 'project_name',mapping:'project_name'},
           		{name: 'audit_object_name',mapping:'audit_object_name'},
                {name: 'audited_name',mapping:'audited_name'},
		        {name: 'isSupervise',mapping:'isSupervise'},
		        {name: 'isJudicatory',mapping:'isJudicatory'},
		        {name: 'adviseMethod',mapping:'adviseMethod'},
                {name: 'practiceMethod',mapping:'practiceMethod'},
		        {name: 'remark_1',mapping:'remark_1'},
		        {name: 'adviseMoney',mapping:'adviseMoney'},
		        {name: 'practiceMoney',mapping:'practiceMoney'},
		        {name: 'remark_2',mapping:'remark_2'}
            ]
        });
    // create the Data Store
    var store = new Ext.data.Store({
        // load using script tags for cross domain, if the data in on the same domain as
        // this page, an HttpProxy would be better
        baseParams:{'ledgerPunishment.project_code':document.getElementsByName("ledgerPunishment.project_code")[0].value,'ledgerPunishment.project_name':document.getElementsByName("ledgerPunishment.project_name")[0].value,'ledgerPunishment.audit_object_name':document.getElementsByName("ledgerPunishment.audit_object_name")[0].value},
        proxy: new Ext.data.HttpProxy({
            method:'POST',
            url: '${pageContext.request.contextPath}/proledger/punishment/queryPunishment.action'
        }),

        // create reader that reads the Topic records
        reader: jsonReader,

        // turn on remote sorting
        remoteSort: false
    });
    
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
           header: "项目编号",
           dataIndex: 'project_code',
           autoWidth: true
        },
        {
           header: "项目名称",
           dataIndex: 'project_name',
           autoWidth: true
        },
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
            pageSize: 15,
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
    store.load({params:{start:0, limit:15}});

});
	</script>
		<div id="topic-grid" style="margin-left: 0px"></div>
		<s:hidden id="export" name="export"></s:hidden>
		<s:hidden id="itemselector" name="itemselector" ></s:hidden>	
		<input type="hidden" name="codes">
		<input type="hidden" name="names">
		</s:form>
	</body>
</html>
