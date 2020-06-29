<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="ais.operate.task.model.AudDoubt" />

<s:text id="title" name="'备忘管理1'"></s:text>



<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>备忘管理</title>
		<link href="/ais/resources/csswin/subModal.css" rel="stylesheet"
			type="text/css" />
		<link href="/ais/styles/main/ais4ext.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="/ais/resources/csswin/common.js"></script>
		<script type="text/javascript" src="/ais/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="/ais/scripts/ais_functions.js"></script>
		<link rel="stylesheet" type="text/css"
			href="/ais/styles/portal/ext-all.css" />
		<script type="text/javascript" src="/ais/scripts/portal/ext-base.js"></script>
		<script type="text/javascript" src="/ais/scripts/portal/ext-all.js"></script>
		<script type="text/javascript"
			src="/ais/scripts/portal/ext-lang-zh_CN.js"></script>
		<link rel="stylesheet" type="text/css"
			href="/ais/pages/cncext/grid-examples.css" />
		<link rel="stylesheet" type="text/css"
			href="/ais/pages/cncext/examples.css" />
		<script type='text/javascript' src='/ais/js/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<style type="text/css">
body.x-panel {
	margin-bottom: 20px;
}

.icon-grid {
	background-image: url(/ais/pages/cncext/shared/icons/fam/grid.png)
		!important;
}

#button-grid.x-panel-body {
	border: 1px solid #99bbe8;
	border-top: 0 none;
}

.add {
	background-image: url(/ais/pages/cncext/shared/icons/fam/add.gif)
		!important;
}

.option {
	background-image: url(/ais/pages/cncext/shared/icons/fam/plugin.gif)
		!important;
}

.remove {
	background-image: url(/ais/pages/cncext/shared/icons/fam/delete.gif)
		!important;
}

.save {
	background-image: url(/ais/pages/cncext/shared/icons/save.gif)
		!important;
}
</style>
	<script type="text/javascript">
          function add(){
             window.location.href='/ais/operate/doubt/editDoubt.action?type=${type}&pro_id=${pro_id}';
           }
     </script>
	</head>
	<body>


		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="5" align="left" class="edithead">
					<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/operate/doubt/search.action')" />
				</td>
			</tr>
		</table>


		<form id="batchStart" name="batch_start_form" onsubmit="return true;"
			action="/ais/mng/project/actualize/batchStart.action" method="post"
			style="">
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						备忘名称:
					</td>
					<!--标题栏-->
					<td align="left" class="listtabletr22">

						<s:textfield name="doubt.doubt_name" cssStyle="width:80%" />
						<!--人员多选-->

					</td>

					<td align="left" class="listtabletr11">
						备忘编码:
					</td>
					<!--标题栏-->
					<td align="left" class="listtabletr22">

						<s:textfield name="doubt.doubt_code" cssStyle="width:80%" />
						<!--组织结构多选-->

					</td>
				</tr>



				<tr class="listtablehead">
					<td align="left" class="listtabletr11">
						提交人:
					</td>
					<!--标题栏-->
					<td align="left" class="listtabletr22">
						<s:buttonText name="doubt.author_name" cssStyle="width:80%"
							hiddenName="doubt.author_code"
							doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=doubt.author_name&paraid=doubt.author_code',600,450)"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="false"
							display="true" doubleDisabled="false" />

						<!--一般文本框-->

					</td>

					<td align="left" class="listtabletr11">
						备忘状态:
					</td>
					<!--标题栏-->
					<td align="left" class="listtabletr22">

						<s:buttonText name="doubt.author_name" cssStyle="width:80%"
							hiddenName="doubt.author_code"
							doubleOnclick="showPopWin('/pages/system/search/mutiselect.jsp?url=/pages/system/userindex.jsp&paraname=doubt.author_name&paraid=doubt.author_code',600,450)"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="false"
							display="true" doubleDisabled="false" />
						<!--人员多选-->

					</td>
				</tr>
				<tr class="listtablehead">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right">

							<input type="submit" id="searchProject_0" value="查询" style=""
								onclick="return declareExport('false');" />

							&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='/ais/operate/doubt/search.action?type=${type}&pro_id=${pro_id}'">
						</DIV>
					</td>
				</tr>
			</table>

			<div id="myList" style="margin-left: 150px"></div>
			<br>
			<div align="center">
				<input type="button" value="增加" onclick="add()" />
				<input type="button" value="编辑" onclick="ops1()" />
				<input type="button" value="删除" onclick="ops1()" />
			</div>
			<script type="text/javascript">
	Ext.onReady(function(){

    //Ext.state.Manager.setProvider(new Ext.state.CookieProvider());

var myData = [
<%
	List myList=(List)request.getAttribute("list");
	for(int i=0;i<myList.size();i++)
	{
		AudDoubt po=(AudDoubt)myList.get(i);
		out.print("[");
		out.print("'<input type=radio name=doubt_id ops=\"mix\"  value="+po.getDoubt_id()+">',");
		out.print("'"+po.getDoubt_name()+"',");
		
		out.print("'"+po.getDoubt_status()+"',");
		out.print("'"+po.getDoubt_code()+"',");
		out.print("'"+po.getDoubt_author()+"',");
		 
		out.print("'"+po.getDoubt_date()+"',");
		out.print("'"+"<a href=\""+request.getContextPath()+"/mng/examproject/members/audProjectMembersInfo/searchTobeDetail.action?formId="+"\" target=\"_blank\">查看</a>&nbsp;"+"'");
		if(i==myList.size()-1)    
			out.print("]");
		else
			out.print("],");
	}
%>
];


    // create the data store
    var store = new Ext.data.SimpleStore({
        fields: [
           {name: 'doubt_id'},
           {name: 'doubt_name'},
           {name: 'doubt_status'},
           {name: 'doubt_code'},
           {name: 'doubt_author'},
           {name: 'doubt_date',type: 'date', dateFormat: 'Y-m-d'},
           {name: 'link'}
           
        ]
    });
    store.loadData(myData);

    // create the Grid
    var grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {header: "选择", width: 50, sortable: false,  dataIndex: 'doubt_id',hideable:false},
            {header: "备忘名称", sortable: true,  dataIndex: 'doubt_name'},
            {header: "备忘状态", sortable: true,  dataIndex: 'doubt_status'},
            {header: "备忘编码", sortable: true,  dataIndex: 'doubt_code'},
            {header: "提交人", sortable: true,  dataIndex: 'doubt_author'},
            {header: "提交日期", sortable: true, renderer: Ext.util.Format.dateRenderer('Y-m-d'), dataIndex: 'doubt_date'},
           	{id:'link',header: "操作", width: 125, sortable: false,  dataIndex: 'link'}
        ],
        stripeRows: true,
        autoExpandColumn: 'link',
        bodyStyle:'100%',
        autoWidth:true,
        viewConfig: {forceFit: true},
        
        autoHeight:true,
        frame:true,
        collapsible: true,
        animCollapse: false,
        title:''
    });

    grid.render('myList');
    grid.getSelectionModel().selectFirstRow();
});
</script>
		</form>
	</body>
</html>
