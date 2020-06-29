<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>项目台账查询</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="description" content="This is my page">
		
		<link
			href="${pageContext.request.contextPath}/styles/main/ais4ext.css"
			rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/styles/portal/ext-all.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/pages/ledger/ext/ext-base.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/pages/ledger/ext/ext-all.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/scripts/portal/ext-lang-zh_CN.js"></script>
			
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>		
			
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/pages/ledger/ext/GroupHeaderPlugin.js"></script>
<%
			String subject = (String) request.getAttribute("subject");
		%>
		<script type="text/javascript">
		function resetbutton(){
	      var form= document.queryform;
	      form.p_code.value="";
	      form.p_name.value="";
	      form.audited_code.value="";
	      form.p_year.value="";
	      form.pro_type.value="";
	      form.pro_type_child.value="";
	}
	    function exportExcel(columns){
	      document.getElementById('export').value='true';
	      document.getElementById('itemselector').value=columns;
	      queryform.action="${contextPath}/proledger/custom/load.action";
	      queryform.submit();
	    }
	    
	    function showColumns(){
	    	var subject=encodeURI(encodeURI("<%=subject%>"));
	    	showPopWin('${pageContext.request.contextPath}/proledger/custom/loadColumns.action?subject='+subject,500,350);
	    }

	    function query(){
	    	 document.getElementById('export').value='false';
	    	 queryform.action="${contextPath}/proledger/custom/searchCustomLedger.action";
		     queryform.submit();
		}
	</script>
	<style type='text/css'>
	#ledgerTable{
		border-collapse:collapse;
		border: 1px solid #99bbe8;
		background-color:white;
		margin:3px 3px 3px 0px;
		font-size:12px;
		width:100%;
	}
	.listtabletr11{
		height:25px;
		text-align:right;
		border: 1px solid #99bbe8;
		background: url("../../images/ais/bg1a.jpg") repeat;
	}
	.listtabletr22{
		height:25px;
		text-align:left;
		border: 1px solid #99bbe8;
	}
	a,input{
		outline:none;
		hide-focus:expression(this.hideFocus=true);
	}
	input,select,textarea{
		font-family: "Tahoma", "新宋体"; 
		font-size:12px;
	}
	input.text, input[type='file']{
	    border:1px solid solid #59bbe8;
		height:18px;
	}
	input.button,input.submit, input[type='button'], input[type='submit']{
		 border:1px solid #59bbe8;
		 padding:2px 2px 0px 2px;
		 FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5);
		 color:#006699;
		 cursor:hand;
	}
	.buttonOver{
		 border:1px solid #59bbe8;
		 padding:2px 2px 0px 2px;
		 FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#D7E7FA);
		 color:#006699;
		 cursor:hand;
	}
	</style>
	</head>
	<body>
		<s:form id="queryform" action="searchCustomLedger"
			namespace="/proledger/custom" method="post">
			<table id="ledgerTable" >
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						项目编号
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="p_code" cssStyle="width:100%" />
					</td>
					<td align="left" class="listtabletr11">
						项目名称
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="p_name" cssStyle="width:100%" />
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						被审计单位
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="audited_code" cssStyle="width:100%" />
					</td>
					<td align="left" class="listtabletr11">
						项目年度
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="p_year" cssStyle="width:100%" />
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						项目类型
					</td>
					<td align="left" class="listtabletr22">
					   <s:doubleselect id="pro_type" doubleId="pro_type_child"
							doubleList="basicUtil.planProjectTypeMap[top]" doubleListKey="code"
							doubleListValue="name" listKey="code" listValue="name"
							name="pro_type" list="basicUtil.planProjectTypeMap.keySet()"
							doubleName="pro_type_child" theme="ufaud_simple"
							templateDir="/strutsTemplate"
							emptyOption="true" />
					
					</td>
					<td align="right" class="listtabletr11" colspan="2">
						<DIV align="right">
							<s:hidden name="subject" value="<%=subject%>"></s:hidden>
							<s:submit value="查询" onclick="query();" cssStyle="width:100" />
							<s:button value="重置" onclick="resetbutton();" cssStyle="width:100" />
							<s:button value="导出Excel" onclick="showColumns();" cssStyle="width:100" />
						</DIV>
					</td>
				</tr>
			</table>
			<script type="text/javascript">
	Ext.onReady(function(){
	var jsonReader=new Ext.data.JsonReader({
            root:'list',
            id:'code',
            totalProperty: 'pages',
            fields: [
			{name:'project_id',mapping:'project_id'},
            {name:'project_code',mapping:'project_code'},
            {name:'project_name',mapping:'project_name'},
            {name:'pro_year',mapping:'pro_year'},
            {name:'pro_type_name',mapping:'pro_type_name'},
            {name:'pro_type_child_name',mapping:'pro_type_child_name'},
            {name:'real_start_time',mapping:'real_start_time'},
            {name:'real_closed_time',mapping:'real_closed_time'},
            {name:'pro_teamleader_name',mapping:'pro_teamleader_name'},
            {name:'audit_dept_name',mapping:'audit_dept_name'},
            {name:'audit_object_name',mapping:'audit_object_name'},
            <s:iterator value="filedList" status="st">
               <s:if test="#st.last">
               {name:'${p_key}',mapping:'${p_key}', type:'int'}
               </s:if>
               <s:else>
               {name:'${p_key}',mapping:'${p_key}',type:'int'},
               </s:else>
		    </s:iterator>
            ]
        });
    // create the Data Store
    var store = new Ext.data.Store({
        // load using script tags for cross domain, if the data in on the same domain as
        // this page, an HttpProxy would be better
        baseParams: {p_code: document.getElementsByName("p_code")[0].value,p_name:document.getElementsByName("p_name")[0].value,audited_code:document.getElementsByName("audited_code")[0].value,p_year:document.getElementsByName("p_year")[0].value,pro_type:document.getElementsByName("pro_type")[0].value,pro_type_child:document.getElementsByName("pro_type_child")[0].value},
        proxy: new Ext.data.HttpProxy({
            method: 'POST',
            url: '${pageContext.request.contextPath}/proledger/custom/load.action?subject='+encodeURI(encodeURI("<%=subject%>"))
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

    //项目穿透页面   
    function projectView(value, cellmeta, record, rowIndex, columnIndex, store){
    	 var project_id=record.get("project_id");
    	 var s='<a style="cursor:hand" href="javascript:void(0);" onclick="window.open(\'${pageContext.request.contextPath}/project/view.action?viewPermission=full&crudId='+project_id+'\',\''
         + '\',\'width=800px,height=700px,toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no\');return false">'+value+'</a>';
	     return s;
    }
    
    
    // the column model has information about grid columns
    // dataIndex maps the column to the specific data field in
    // the data store
    var cm = new Ext.grid.ColumnModel(
    {
     columns:[
             {
               header:'项目编号',
               dataIndex:'project_code',
               width:120
             },
              {
               header:'项目名称',
               dataIndex:'project_name',
               width:120,
               renderer: projectView
             },
             {
                 header:'项目年度',
                 dataIndex:'pro_year',
                 width:120
               },
             {
               header:'项目类别',
               dataIndex:'pro_type_name',
               width:120
            
             },
             {
               header:'审计单位',
               dataIndex:'audit_dept_name',
               width:120
             },
             {
               header:'被审计单位',
               dataIndex:'audit_object_name',
               align: 'center',
               width:120
             },
              <s:iterator value="filedList" status="st1">
              { header: '${p_undertitle}',
                 dataIndex: '${p_key}',
                 width:100}
                <s:if test="#st1.last">
                </s:if>
                <s:else>
                ,
                </s:else>
		    </s:iterator>
        ],
        rows: [
         [<s:property value="id"/>]
        ]
      });

    // by default columns are sortable
    cm.defaultSortable = true;

    var gridGrid =Ext.get("gridGrid");
    var grid = new Ext.grid.GridPanel({
        el:'gridGrid',
        width:gridGrid.getComputedWidth(),
        height:gridGrid.getComputedHeight(),
        store: store,
        cm: cm,
        trackMouseOver:false,
        enableColumnResize:true,
        
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
       height:450,
       items: [grid]
    });
    
    

    // trigger the data store load
    store.load({params:{start:0, limit:15}});

});
	</script>
			<div id="gridGrid" style="width:${requestScope.width}px;height:335px"></div>
			<s:hidden id="export" name="export"></s:hidden>
			<s:hidden id="itemselector" name="itemselector" ></s:hidden>
		</s:form>
	</body>
</html>
