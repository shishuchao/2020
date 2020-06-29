<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>新增风险列表</title>
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
 	var currentYear = '${currentYear}';
 	$('#query_collectTaskYear').show();
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'RiskTask',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        whereSql: 'collectTaskYear=\'' + currentYear + '\'',
        order:'asc',
        sort:'taskCode', 
        winWidth:800,
        winHeight:250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            frozenColumns:[[{field:'taskId', title:'选择', checkbox:false, align:'center', show:'false',hidden:true},      
                            {field:'taskCode',title:'编号', width:bodyW*0.08 + 'px',align:'center', sortable:true, hidden:true,show:'false'},
                            {field:'collectTaskYear',title:'年度', width:bodyW*0.08 + 'px',align:'center', sortable:true, type:'custom',target:$('#query_collectTaskYear')[0]},
                            {field:'collectTaskName',title:'风险收集任务', width:bodyW*0.1 + 'px',align:'left', halign:'center', sortable:true, show:'true', oper:'like'}]],
            columns:[[
               {field:'riskDescription',title:'风险描述', width:bodyW*0.14 + 'px',align:'left', halign:'center', sortable:true, show:'false'},
               {field:'taskPname',title:'风险分类', width:bodyW*0.14 + 'px',align:'left', halign:'center', sortable:true, type:'custom',target:$('#queryCond5')[0]},
               {field:'influenceDescription',title:'影响描述', width:bodyW*0.14 + 'px',align:'left', halign:'center', sortable:true, show:'false'},
               {field:'involvedBusiness',title:'涉及业务', width:bodyW*0.14 + 'px',align:'left', halign:'center', sortable:true, show:'false'},
               {field:'affiliatedDeptName',title:'所属单位', width:bodyW*0.14 + 'px',align:'left', halign:'center', sortable:true, type:'custom',target:$('#queryCond1')[0]},
               {field:'majorDutyDeptName',width:bodyW*0.14 + 'px',title:'主责部门', align:'left', halign:'center', sortable:true, type:'custom',target:$('#queryCond2')[0]},
               {field:'createrDeptName',title:'上报部门', width:bodyW*0.14 + 'px',align:'left', halign:'center', sortable:true, type:'custom',target:$('#queryCond3')[0]},
               {field:'createTime',width:bodyW*0.14 + 'px',title:'上报时间', align:'center', sortable:true, type:'custom',target:$('#queryCond4')[0]}
        	]],
        }
    });	
    
    $('#sDTable').datagrid('doCellTip', {
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}
	});
    
    g1.batchSetBtn([
		{'index':1, 'display':false},
		{'index':2, 'display':true},
		{'index':3, 'display':false},
		{'index':4, 'display':false},
		{'index':5, 'display':false},
		{'index':6, 'display':false},
        {'index':7, 'display':false},
        {'index':8, 'display':false}
    ]);
    
    var currentYear = "${currentYear}";
    var offsetYear = 5;
    var yearArr = [];
    for(var i=currentYear-offsetYear; i<parseInt(currentYear)+offsetYear; i++){
        yearArr.push({
            'code':i,
            'name':i
        });
    }
    genSelectOption("query_collectTaskYear", yearArr, currentYear);
    
    var query_status = [{"code":"0","name":"草稿"},{"code":"1","name":"进行中"},{"code":"2","name":"已完成"}];
    genSelectOption("query_status",query_status);
    
    //genSelectOption("query_tradePlate", eval('${tradePlateArr}'));

    // 生成下拉选择
    function genSelectOption(selectObjId, arr, defaultVal){
        try{
            var selectObj = $('#'+selectObjId);
            if(selectObj && selectObj.length && arr && arr.length){
                selectObj.append("<option value=''></option>");
                for(var i=0; i<arr.length; i++){
                    var  ele = arr[i];
                    //alert(ele)
                    if(defaultVal != null && defaultVal == ele.code){
                        selectObj.append("<option value='"+ele.code+"' selected>"+ele.name+"</option>");
                    }else{
                        selectObj.append("<option value='"+ele.code+"'>"+ele.name+"</option>");
                    }
                    
                }
            }
        }catch(e){
            isdebug ? alert('genSelectOption:\n'+e.message) : null;
        }
    } 
});
</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div> 
    
   <select id="query_collectTaskYear" name="query_collectTaskYear" style='width:150px; display:none;'></select>
   
   <div id='queryCond1'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_acceptingUnit' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'所属单位',
				 param:{
				'rootParentId':'0',
				'beanName':'UOrganizationTree',
				'treeId':'fid',
				'treeText':'fname',
				'treeParentId':'fpid',
				'treeOrder':'fcode'
				 }
			})"></a>
   </div>
   
   <div id='queryCond2'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_acceptingDep' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'主责部门',
				 param:{
				'rootParentId':'0',
				'beanName':'UOrganizationTree',
				'treeId':'fid',
				'treeText':'fname',
				'treeParentId':'fpid',
				'treeOrder':'fcode'
				 }
			})"></a>
   </div>
   
   <div id='queryCond3'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_createrDeptId' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'上报部门',
				 param:{
				'rootParentId':'0',
				'beanName':'UOrganizationTree',
				'treeId':'fid',
				'treeText':'fname',
				'treeParentId':'fpid',
				'treeOrder':'fcode'
				 }
			})"></a>
   </div>
   
   <div id='queryCond4'>
 		<input type='text'  name='query_mtq_createTime' class="easyui-datebox noborder clear" editable="false"/>至
 		<input type='text'  name='query_ltq_createTime' class="easyui-datebox noborder clear" editable="false"/>
   </div>
   
   <div id='queryCond5'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_taskPid' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'风险分类',
				 param:{
				'rootParentId':'-1',
				'whereHql':'template_type != \'2\'',
				'beanName':'RiskTaskTemplateTree',
				'treeId':'taskId',
				'treeText':'taskName',
				'treeParentId':'taskPid',
				'treeOrder':'taskCode',
				'treeAtrributes':'template_type'
				 }
			})"></a>
	</div>
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
