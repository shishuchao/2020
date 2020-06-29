<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>问题展示列表</title>
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
 	var key = '${key}'.replaceAll('!','#');
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'MiddleLedgerProblem',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        whereSql: 'id in (select mcp_value from MultiCountProblem where mcp_key=\''+key+'\')',
        order:'desc',
        sort:'project_name',
        winWidth: 800,
        winHeight: 250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            frozenColumns:[[
    						{field:'id',width:'50', hidden:true, align:'center',title:'主键'},
    						{field:'audit_con',title:'问题标题',width:bodyW*0.14 + 'px',align:'left', halign:'center', sortable:true},
    						{field:'serial_num',title:'问题编号',width:bodyW*0.14 + 'px',align:'center', sortable:true}
    					         ]],
    		columns:[[
    						{field:'problem_all_name',title:'问题类别',width:bodyW*0.13 + 'px',sortable:true, align:'left', halign:'center'},
    						{field:'problem_name',title:'问题点',width:bodyW*0.14 + 'px',halign:'center',align:'left',sortable:true},
    						{field:'problem_money',title:'发生金额(万元)',width:bodyW*0.14 + 'px',halign:'center',align:'right',sortable:true},
    						{field:'problemCount',title:'发生数量(个)',width:bodyW*0.14 + 'px',sortable:true,halign:'center',align:'center'},
    						{field:'problem_grade_name',title:'审计发现类型',width:bodyW*0.14 + 'px',align:'center',sortable:true},
    						{field:'inspection',title:'标记状态',width:bodyW*0.14 + 'px',align:'center',sortable:true,
    							formatter:function(value,rowData,rowIndex){
    						    	if(value == '1'){
    						    	    return '外部门可见';
    								}
    								return "外部门不可见";
    							}
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
    	onlyShowInterrupt:true,
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
