<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>项目计划列表</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
<script type="text/javascript">
var editFlag = undefined;
var g1;

$(function(){
	var bodyW = $('body').width();    
    var bodyH = $('body').height(); 
 	var key = '${key}'.replaceAll(',','#');
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'WorkPlanDetail',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        whereSql: 'formId in (select value from MultiCountReport where key=\''+key+'\')',
        order:'desc',
        sort:'plan_grade_name',
        winWidth: 800,
        winHeight: 250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
			frozenColumns:[[
			       			{field:'byYearShenPi',title:'计划状态',width:0.08*bodyW+'px',align:'center',
			       				halign:'center',sortable:true,formatter:function(value,rowData,rowIndex){
			       			        if(rowData.status == '4000'){
			       			          return rowData.status_name;
								    }
			       			     	if(rowData.status == '8000'){
			       			          return rowData.status_name;
								    }
			       			     	if(rowData.status == '9000'){
			       			          return rowData.status_name;
								    }
			       			     	if(rowData.status == '1115'){
			       			          return rowData.status_name;
								    }
                                    if(value == '1'){
                                        return "年度已审批";
                                    }else{
                                        return rowData.status_name;
					   			     }
								 },
			       			},
			       			{field:'w_plan_name',title:'项目名称',width:0.15*bodyW+'px', align:'left',halign:'center',sortable:true}
			    		]],
			columns:[[  
				{field:'audit_object_name',
						title:'被审计单位名称',
						width:0.15*bodyW+'px',
						align:'left',
						sortable:true,
						halign:'center'
				},
				{field:'lastAudYear',
					title:'上次审计年度',
					width:0.08*bodyW+'px', 
					align:'center',
					hidden:true,
					halign:'center'
				},
				{field:'lastProTypeName',
					 title:'上次审计类型',
					 width:0.08*bodyW+'px', 
					 align:'center', 
					 hidden:true
				},
				{field:'audit_start_time',
					 title:'审计期间开始',
					 width:0.08*bodyW+'px', 
					 align:'center', 
					 sortable:true,
					 formatter:function(value,rowData,rowIndex){
	   			        if(value != '' && value != null){
		   			        return value.substring(0,10);
	   			        }
					 },
					halign:'center'
				},
				{field:'audit_end_time',
					 title:'审计期间结束',
					 width:0.08*bodyW+'px', 
					 align:'center', 
					 sortable:true,
					 formatter:function(value,rowData,rowIndex){
	   			        if(value != '' && value != null){
		   			        return value.substring(0,10);
	   			        }
					 },
					halign:'center'
				},
				{field:'pro_type_name',
					 title:'审计类型',
					 width:0.08*bodyW+'px', 
					 align:'center', 
					 sortable:true
				},
				{field:'w_plan_year',
					 title:'审计年度',
					 width:0.08*bodyW+'px', 
					 align:'center', 
					 sortable:true,
					halign:'center'
				},
				{field:'w_plan_month',
					 title:'审计月度',
					 width:0.08*bodyW+'px', 
					 align:'center', 
					 sortable:true,
					halign:'center'
				},
				{field:'plan_grade_name',
				     title:'项目类型',
				     width:0.08*bodyW+'px', 
					 align:'center', 
					 sortable:true,
					halign:'center'
				}
			]]
        }
    });	
    g1.batchSetBtn([
		{'index':1, 'display':false},
		{'index':2, 'display':false},
		{'index':3, 'display':false},
		{'index':4, 'display':false},
		{'index':5, 'display':false},
		{'index':6, 'display':false},
        {'index':7, 'display':false},
        {'index':8, 'display':false}
    ]);
    
    $('#sDTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
});

</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
