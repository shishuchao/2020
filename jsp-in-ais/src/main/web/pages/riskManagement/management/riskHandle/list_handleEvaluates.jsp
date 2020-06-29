<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>风险应对评价</title>
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
    $('#query_year').show();
    $('#query_status').show();
    $('#query_riskLevel').show();
    $('#query_prioritySort').show();
 
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'RiskEvaluateWait',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
      //  whereSql: 'rrs_id=\''+ rrs_id +'\'',
        order:'desc',
        sort:'prioritySort',
        winWidth:800,
        winHeight:250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            columns:[[
               {field:'id', title:'选择', checkbox:false, align:'center', show:'false', hidden:true},
               {field:'evaluateSerialNum',title:'编号', width:bodyW*0.08 + 'px',align:'center', sortable:true, show:'true', oper:'eq'},
               {field:'evaluateYear',title:'年度', width:bodyW*0.05 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_year')[0]},
               {field:'evaluateCompanyName',title:'所属单位', width:bodyW*0.1 + 'px',align:'center', sortable:true, type:'custom', target:$('#queryCond1')[0]},
               {field:'responsibilityDepName',title:'责任部门', width:bodyW*0.1 + 'px',align:'center', sortable:true, type:'custom', target:$('#queryCond2')[0]},
               {field:'riskFatherSortName',title:'风险大类', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'like'},
               {field:'riskSonSortName',title:'风险子类', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'like'},
               
               {field:'riskItemName',title:'风险事项', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'like'},
               {field:'riskLevel',title:'风险等级', width:bodyW*0.08 + 'px',align:'center', sortable:true, type:'custom',target:$('#query_riskLevel')[0],
            	   formatter: function(value, rowData, rowIndex) {
            		   if(value == '0')
            			   return '无风险';
            		   else if(value == '1')
            			   return '低风险';
            		   else if(value == '2')
            			   return '中风险';
            		   else
            			   return '高风险';
            	   }},
               {field:'answerPlotName',title:'应对策略', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'like'},
               {field:'prioritySort',title:'优先顺序', width:bodyW*0.08 + 'px',align:'center', sortable:true, type:'custom',target:$('#query_prioritySort')[0],
            	   formatter: function(value, rowData, rowIndex){
            		   if(value == '0')
            			   return '低';
            		   else if(value == '1')
            			   return '中';
            		   else if(value == '2')
            			   return '高';
            	  }},
               {field:'operation',width:bodyW*0.08 + 'px',title:'操作', align:'center', sortable:false, show:'false', oper:'eq',
            	   formatter: function(value, rowData, rowIndex) {
            		   var url = '${contextPath}/riskManagement/management/riskHandle/evaluateRisk.action?id=' + rowData.id;
            	       return '<a href=\'#\' onclick="handle(\'' + url + '\')">评价</a>';
            	   }
               }
        	]]
        }
    });	
    g1.batchSetBtn([
		{'index':1, 'display':false},
		{'index':2, 'display':false},
		{'index':3, 'display':true},
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
    genSelectOption("query_year", yearArr, currentYear);
    
    var query_riskLevel = [{"code":"0","name":"无风险"},{"code":"1","name":"低风险"},{"code":"2","name":"中风险"},{"code":"3","name":"高风险"}];
    genSelectOption("query_riskLevel",query_riskLevel);
    
    var query_prioritySort = [{"code":"0","name":"低"},{"code":"1","name":"中"},{"code":"2","name":"高"}];
    
    genSelectOption("query_prioritySort", query_prioritySort);

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

	function handle(url) {
		aud$openNewTab('应对风险',url);
	}

</script>
</head>
<body>
    <div id="container" class='easyui-layout' fit='true'>	
        <div region="center">   	 	
            <table id='sDTable'></table>
        </div>
    </div>
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_riskLevel" name="query_riskLevel" style="width:130px;display:none;"></select>
   <select id="query_prioritySort" name="query_prioritySort" style='width:130px; display:none;'></select> 
   
   <div id='queryCond1'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_evaluateCompany' class="noborder editElement clear" readonly/> 
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
		<input type='hidden' name='query_eq_responsibilityDep' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'所属部门',
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
 		<input type='text'  name='query_eq_collectStartTime' class="easyui-datebox noborder clear" editable="false"/>
   </div>
   
   <div id='queryCond4'>
 		<input type='text'  name='query_eq_collectEndTime' class="easyui-datebox noborder clear" editable="false"/>
   </div>
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
