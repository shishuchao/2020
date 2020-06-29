<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="ais.project.feedback.model.ProjectFeedbackObject" />
<jsp:directive.page
	import="ais.project.start.model.ProjectStartObject" />
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目报告</title>
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<link
			href="${pageContext.request.contextPath}/styles/main/ais4ext.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>
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
			href="${pageContext.request.contextPath}/pages/cncext/examples.css" />
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>
		<style type="text/css">
        body.x-panel {
            margin-bottom:20px;
        }
        .icon-grid {
            background-image:url(${pageContext.request.contextPath}/pages/cncext/shared/icons/fam/grid.png) !important;
        }
        #button-grid.x-panel-body {
            border:1px solid #99bbe8;
            border-top:0 none;
        }
        .add {
            background-image:url(${pageContext.request.contextPath}/pages/cncext/shared/icons/fam/add.gif) !important;
        }
        .option {
            background-image:url(${pageContext.request.contextPath}/pages/cncext/shared/icons/fam/plugin.gif) !important;
        }
        .remove {
            background-image:url(${pageContext.request.contextPath}/pages/cncext/shared/icons/fam/delete.gif) !important;
        }
        .save {
            background-image:url(${pageContext.request.contextPath}/pages/cncext/shared/icons/save.gif) !important;
        }
    </style>
		<script>
    function loadToDo(){
			//parent.document.all.selectedFrame.style.height=document.body.scrollHeight;
			window.parent.frames['submitFrame'].location.reload();
		}
    </script>

	</head>
	<s:if test="isUseBpm == 'true'">
<%--批量提交		<body onload="loadToDo()">--%>
		<body>
	</s:if>
	<s:else>
		<body>
	</s:else>
	<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
		class="ListTable" width="100%" align="center">
		<tr class="listtablehead">
			<td colspan="5" align="left" class="edithead">
				项目管理==&gt;项目报告反馈意见
			</td>
		</tr>
	</table>
	<s:form name="batch_start_form" action="batchStart"
		namespace="/mng/project/report" method="post">
		<div id="myList" style="margin-left: 15px"></div>
		<script type="text/javascript">
	Ext.onReady(function(){

    //Ext.state.Manager.setProvider(new Ext.state.CookieProvider());

    var myData = [
        <%
	List myList=(List)request.getAttribute("projectFeedbackList");
	for(int i=0;i<myList.size();i++)
	{
		ProjectStartObject  po = (ProjectStartObject)myList.get(i);
		out.print("[");
		//out.print("'<input type=checkbox name=crudIds plancode=\""+po.getPlan_code()+"\" value="+info.getFormId()+">',");
		out.print("'"+po.getProject_name()+"',");
		out.print("'"+po.getPlan_type_name()+"',");
		out.print("'"+po.getPro_type_name()+"',");
		out.print("'"+po.getPlan_grade_name()+"',");
		out.print("'"+po.getPro_starttime()+"',");
		out.print("'"+po.getPro_endtime()+"',");
		out.print("'"+po.getAudit_dept_name()+"',");
		out.print("'"+"<a href=\""+request.getContextPath()+"/project/feedback/idea/edit.action?project_id="+po.getFormId()+"\">反馈意见</a>"+"'");
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
          // {name: 'crudIds'},
           {name: 'plan_name'},
           {name: 'plan_type'},
           {name: 'pro_type'},
           {name: 'plan_grade'},
           {name: 'start_time',type: 'date', dateFormat: 'Y-m-d'},
           {name: 'end_time',type: 'date', dateFormat: 'Y-m-d'},
           {name: 'audit_dept'},
           {name: 'link'}
           
        ]
    });
    store.loadData(myData);

    // create the Grid
    var grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
           // {header: "选择", width: 50, sortable: false,  dataIndex: 'crudIds',hideable:false},
            {header: "项目名称", width: 165, sortable: true,  dataIndex: 'plan_name'},
            {header: "计划类别", width: 100, sortable: true,  dataIndex: 'plan_type'},
            {header: "项目类别", width: 100, sortable: true,  dataIndex: 'pro_type'},
            {header: "计划等级", width: 100, sortable: true,  dataIndex: 'plan_grade'},
            {header: "开始时间", width: 100, sortable: true, renderer: Ext.util.Format.dateRenderer('Y-m-d'), dataIndex: 'start_time'},
            {header: "结束时间", width: 100, sortable: true, renderer: Ext.util.Format.dateRenderer('Y-m-d'), dataIndex: 'end_time'},
          	{header: "所属单位", width: 145, sortable: true,  dataIndex: 'audit_dept'},
           	{id:'link',header: "操作", width: 50, sortable: false,  dataIndex: 'link'}
        ],
        stripeRows: true,
        autoExpandColumn: 'link',
        width: 875,
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

		<br>
		<center>
	  <jsp:include flush="true" page="/pages/bpm/single_submit_bottom.jsp"></jsp:include></center>
	</s:form>

	<body><br><br></body>
</html>
