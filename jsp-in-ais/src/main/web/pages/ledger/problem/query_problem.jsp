<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>统计台账</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link
			href="${pageContext.request.contextPath}/styles/main/ais4ext.css"
			rel="stylesheet" type="text/css" />
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
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/pages/ledger/ext/GroupHeaderPlugin.js"></script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/pages/ledger/ext/GroupHeaderPlugin.css" />
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript">
		function exportExcel(columns){
		  document.getElementById('export').value='true';
		  document.getElementById('itemselector').value=columns;
		  queryform.action="${pageContext.request.contextPath}/proledger/problem/query.action";
	      queryform.submit();
		}

		function queryForm(){
	    	 document.getElementById('export').value='false';
	    	 queryform.action="${pageContext.request.contextPath}/proledger/problem/searchProblemLedger.action";
		     queryform.submit();
		}
		
		//统计分析
		function analyse(){
		  var project_code= document.getElementsByName("ledgerProblem.project_code")[0].value;
		  if(project_code==''){
		     project_code="null";
		  }
		  var project_name= document.getElementsByName("ledgerProblem.project_name")[0].value;
		   if(project_name==''){
		     project_name="null";
		  }
		  var pro_year= document.getElementsByName("ledgerProblem.pro_year")[0].value;
		   if(pro_year==''){
			   pro_year="null";
		  }
		  var pro_type= document.getElementsByName("ledgerProblem.pro_type")[0].value;
		   if(pro_type==''){
			   pro_type="null";
		  }
		  var pro_type_child= document.getElementsByName("ledgerProblem.pro_type_child")[0].value;
		   if(pro_type_child==''){
			   pro_type_child="null";
		  }
		  var audit_object_name= document.getElementsByName("ledgerProblem.audit_object_name")[0].value;
		   if(audit_object_name==''){
			   audit_object_name="null";
		  }
		  var problem_name= document.getElementsByName("ledgerProblem.problem_name")[0].value;
		   if(problem_name==''){
			   problem_name="null";
		  }
		  var start_time= document.getElementsByName("ledgerProblem.real_start_time")[0].value;
		  var closed_time= document.getElementsByName("ledgerProblem.real_closed_time")[0].value;
		  var real_closed_time='null';
		  if(start_time!=''||closed_time!=''){
			   real_closed_time=start_time+'&'+closed_time;
		  }
		  var problem_grade_code= document.getElementsByName("ledgerProblem.problem_grade_code")[0].value;
		   if(problem_grade_code==''){
			   problem_grade_code="null";
		  }
		  
		  var names=project_code+","+project_name+","+audit_object_name+","+problem_name+","+pro_year+","+pro_type+","+pro_type_child+","+real_closed_time+","+problem_grade_code;
          var codes="l.project_code,l.project_name,l.audit_object_name,l.problem_name,l.pro_year,l.pro_type,l.pro_type_child,pso.real_closed_time,l.problem_grade_code";
		  document.getElementsByName("codes")[0].value=codes;
          document.getElementsByName("names")[0].value=names;
		  window.open("${pageContext.request.contextPath}/ledger/ledgerAnalyse/createTableList.action?poName=LedgerProblem&className=1&isAuth=audit_view","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		}
		
		/*
		* 	选择问题点 
		*/
		function selectProblem(){
	
			showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/ledger/problemledger/problemTreeView.action&paraname=ledgerProblem.problem_name&paraid=ledgerProblem.problem_code',600,450,'审计问题点选择');
	
		}
		</script>
	</head>
	<body>
		<s:form id="queryform" action="searchProblemLedger"
			namespace="/proledger/problem" method="post">
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						项目编号：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="ledgerProblem.project_code"
							cssStyle="width:100%" />
					</td>
					<td align="left" class="listtabletr11">
						项目名称：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="ledgerProblem.project_name"
							cssStyle="width:100%" />
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						项目年度：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="ledgerProblem.pro_year"
							cssStyle="width:100%" />
					</td>
					<td align="left" class="listtabletr11">
						项目类型：
					</td>
					<td align="left" class="listtabletr22">
						<s:doubleselect id="pro_type" doubleId="pro_type_child"
							doubleList="basicUtil.planProjectTypeMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="ledgerProblem.pro_type" list="basicUtil.planProjectTypeMap.keySet()"
							doubleName="ledgerProblem.pro_type_child" theme="ufaud_simple"
							templateDir="/strutsTemplate"
							emptyOption="true" />
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						被审单位：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="ledgerProblem.audit_object_name"
							cssStyle="width:100%" />
					</td>
					<td align="left" class="listtabletr11">
						问题点：
					</td>
					<td align="left" class="listtabletr22">
					 <s:buttonText2 id="problems" hiddenId="ledgerProblem.problem_code"
								name="ledgerProblem.problem_name" cssStyle="width:90%"
								hiddenName="ledgerProblem.problem_code"
								doubleOnclick="selectProblem()"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" />
					</td>
				</tr>
				<tr class="listtablehead">
				    <td align="left" class="listtabletr11">
						查询期间：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="ledgerProblem.real_start_time"
							readonly="true" title="单击选择日期"
					        onclick="calendar()" />至<s:textfield name="ledgerProblem.real_closed_time"
							readonly="true" title="单击选择日期"
					        onclick="calendar()" />
					</td>
					<td align="left" class="listtabletr11">
						问题定性：
					</td>
					<td align="left" class="listtabletr22">
						<s:select list="basicUtil.problemMethodList" listKey="code"
								listValue="name" emptyOption="true"
								name="ledgerProblem.problem_grade_code"></s:select>
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right">
							<s:submit value="查询" onclick="queryForm();" cssStyle="width:100" />
							<s:button value="重置" cssStyle="width:100"
								onclick="resetbutton();"></s:button>
							<s:button value="导出Excel" cssStyle="width:100"
								onclick="showPopWin('${contextPath}/pages/ledger/problem/columnSelector.jsp',500,350);" />
							<s:button value="统计分析" cssStyle="width:100" onclick="analyse();" />
						</DIV>
					</td>
				</tr>
			</table>
			<script type="text/javascript">
    function resetbutton(){
    	document.getElementsByName("ledgerProblem.project_code")[0].value="";
        document.getElementsByName("ledgerProblem.project_name")[0].value="";   
        document.getElementsByName("ledgerProblem.audit_object_name")[0].value="";   
        document.getElementsByName("ledgerProblem.problem_name")[0].value=""; 
        document.getElementsByName("ledgerProblem.pro_year")[0].value=""; 
        document.getElementsByName("ledgerProblem.pro_type")[0].value="";
        document.getElementsByName("ledgerProblem.pro_type_child")[0].value="";
        document.getElementsByName("ledgerProblem.real_start_time")[0].value="";
        document.getElementsByName("ledgerProblem.real_closed_time")[0].value="";
        document.getElementsByName("ledgerProblem.problem_grade_code")[0].value="";
	}

	Ext.onReady(function(){
	var jsonReader=new Ext.data.JsonReader({
            root: 'list',
            totalProperty: 'pages',
            id: 'threadid',
            fields: [
                {name: 'project_code',mapping:'project_code'},
                {name: 'project_name',mapping:'project_name'},
                {name: 'pro_year',mapping:'pro_year'},
                {name: 'pro_type_name',mapping:'pro_type_name'},
                {name: 'pro_type_child_name',mapping:'pro_type_child_name'},
                {name: 'pro_teamleader_name',mapping:'pro_teamleader_name'},
                {name: 'audit_dept_name',mapping:'audit_dept_name'},
                {name: 'audit_object_name',mapping:'audit_object_name'},
                {name: 'manuscript_code',mapping:'manuscript_code'},
                {name: 'm_audit_dept',mapping:'m_audit_dept'},
           		{name: 'sort_big_name',mapping:'sort_big_name'},
                {name: 'sort_small_name',mapping:'sort_small_name'},
		        {name: 'problem_name',mapping:'problem_name'},
		        {name: 'problem_money',mapping:'problem_money'},
		        {name: 'p_unit',mapping:'p_unit'},
		        {name: 'problem_grade_name',mapping:'problem_grade_name'},
		        {name: 'creater_startdate',mapping:'creater_startdate'},
                {name: 'creater_enddate',mapping:'creater_enddate'},
           		{name: 'manuscript_creator_name',mapping:'manuscript_creator_name'},
                {name: 'manuscript_date',mapping:'manuscript_date'},
                {name: 'manuscript_id',mapping:'manuscript_id'},
                {name: 'problem_desc',mapping:'problem_desc'}
            ]
        });
    // create the Data Store
    var store = new Ext.data.Store({

    	baseParams: {'ledgerProblem.project_code': document.getElementsByName("ledgerProblem.project_code")[0].value,'ledgerProblem.project_name':document.getElementsByName("ledgerProblem.project_name")[0].value,'ledgerProblem.audit_object_name':document.getElementsByName("ledgerProblem.audit_object_name")[0].value,'ledgerProblem.problem_name':document.getElementsByName("ledgerProblem.problem_name")[0].value,'ledgerProblem.pro_year':document.getElementsByName("ledgerProblem.pro_year")[0].value,'ledgerProblem.pro_type':document.getElementsByName("ledgerProblem.pro_type")[0].value,'ledgerProblem.pro_type_child':document.getElementsByName("ledgerProblem.pro_type_child")[0].value,'ledgerProblem.real_start_time':document.getElementsByName("ledgerProblem.real_start_time")[0].value,'ledgerProblem.real_closed_time':document.getElementsByName("ledgerProblem.real_closed_time")[0].value,'ledgerProblem.problem_grade_code':document.getElementsByName("ledgerProblem.problem_grade_code")[0].value},
        proxy: new Ext.data.HttpProxy({
            method: 'POST',
            url: '${pageContext.request.contextPath}/proledger/problem/query.action'
        }),

        // create reader that reads the Topic records
        reader: jsonReader,

        // turn on remote sorting
        remoteSort: false
    });
    
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
    var cm = new Ext.grid.ColumnModel(
    {
    columns: [
    	{
           header: "项目编号",
           dataIndex: 'project_code',
           width:150
        },
        {
           header: "项目名称",
           dataIndex: 'project_name',
           width:150
        },
        {
           header: "项目年度",
           dataIndex: 'pro_year',
           width:150
        },
        {
           header: "项目类别",
           dataIndex: 'pro_type_name',
           width:150
        },
        {
           header: "项目子类别",
           dataIndex: 'pro_type_child_name',
           width:150
        },
        {
           header: "项目组长",
           dataIndex: 'pro_teamleader_name',
           width:150
        },
        {
           header: "审计单位",
           dataIndex: 'audit_dept_name',
           width:150
        },
        {
           header: "被审计单位",
           dataIndex: 'audit_object_name',
           width:150
        },
        {
           header: "底稿编号",
           dataIndex: 'manuscript_code',
           renderer: diGaoView,
           width:150
        },
        {
           header: "底稿被审计单位",
           dataIndex: 'm_audit_dept',
           width:150
        },
        {
           header: "问题类别",
           dataIndex: 'sort_big_name',
           width:150
        },
    	{
           header: "问题子类别",
           dataIndex: 'sort_small_name',
           width:150
        },
        {
           header: "问题点",
           dataIndex: 'problem_name',
           width:150
        },
        {
           header: "发生数",
           dataIndex: 'problem_money',
           width:150
        },
        {
            header: "统计单位",
            dataIndex: 'p_unit',
            width:150
         },
        {
           header: "问题定性",
           dataIndex: 'problem_grade_name',
           width:150
        },
        {
           header: "问题发现时间",
           dataIndex: 'manuscript_date',
           renderer: renderDate
        },
        {
           header: "问题所属开始日期",
           dataIndex: 'creater_startdate',
           renderer: renderDate
        },
        {
           header: "问题所属结束日期",
           dataIndex: 'creater_enddate',
           renderer: renderDate
        },
        {
           header: "问题发现人",
           dataIndex: 'manuscript_creator_name',
           width:150
        },
        {
            header: "问题描述",
            dataIndex: 'problem_desc',
            width:150
         }
        ],
        rows: [
          [{header: '项目信息', colspan: 8, align: 'center'},{header: '工作底稿', colspan: 2, align: 'center'},{header: '台账信息', colspan: 11, align: 'center'}]
        ]
    }
   );

    // by default columns are sortable
    cm.defaultSortable = true;

    var gridGrid =Ext.get("gridGrid");
    var grid = new Ext.grid.GridPanel({
        el:'gridGrid',
        width:gridGrid.getComputedWidth(),
        height:gridGrid.getComputedHeight(),
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
        }),
         plugins: [new Ext.ux.plugins.GroupHeaderGrid()]
    });

    // render it
    grid.render();
    
     new Ext.Panel({
       height:380,
       items: [grid]
    });

    // trigger the data store load
    store.load({params:{start:0, limit: 15}});

});
	</script>
			<div id="gridGrid" style="width: 3000px; height: 335px"></div>
			<s:hidden id="export" name="export"></s:hidden>
			<s:hidden id="itemselector" name="itemselector" ></s:hidden>
			<input type="hidden" name="codes">
			<input type="hidden" name="names">
		</s:form>
	</body>
</html>
