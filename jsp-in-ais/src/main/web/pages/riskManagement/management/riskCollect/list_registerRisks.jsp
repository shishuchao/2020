<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>影响程度标准</title>
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
    
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'RiskCollectTask',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        whereSql: 'status!=\'0\' and \',\' || acceptingDep || \',\' like \'%,${user.fdepid},%\'',
        order:'asc',
        sort:'status',
        winWidth:800,
        winHeight:200,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:false,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            columns:[[
               {field:'id', title:'选择', hidden:true, align:'center', show:'false'},
               {field:'sn',title:'编号', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'false'},
               {field:'year',title:'年度', width:bodyW*0.05 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_year')[0]},
               {field:'taskName',title:'风险信息收集任务', width:bodyW*0.15 + 'px',align:'left',halign:'center', sortable:true, oper:'like'},
               {field:'status',width:bodyW*0.05 + 'px',title:'状态', align:'center', sortable:true, type:'custom', target:$('#query_status')[0],
            	   formatter: function(value, rowData, rowIndex) {
            		   if(value == '0')
            			   return '草稿';
            		   else if(value == '1')
            			   return '进行中';
            		   else
            			   return '已完成';
            	   }
               },
               {field:'initiateUnit',width:bodyW*0.15 + 'px',title:'发起单位', align:'left', halign:'center', sortable:true, type:'custom', target:$('#queryCond1')[0],
            	   formatter: function(value, rowData, rowIndex) {
            		   return rowData.initiateUnitName;
            	   }
               },
               {field:'initiateDep',width:bodyW*0.15 + 'px',title:'发起部门', align:'left', halign:'center', sortable:true, type:'custom', target:$('#queryCond2')[0],
            	   formatter: function(value, rowData, rowIndex) { 
            		   return rowData.initiateDepName;
            	   }
               },
			  {field:'acceptingUnit',width:bodyW*0.15 + 'px',title:'接收单位', align:'center', sortable:true, hidden:true,
            	   formatter: function(value, rowData, rowIndex) {
            		   return rowData.acceptingUnitName;
            	   }
               },
               {field:'acceptingDep',width:bodyW*0.1 + 'px',title:'接收部门', align:'center', sortable:true, hidden:true,
            	   formatter: function(value, rowData, rowIndex) {
            		   return rowData.acceptingDepName;
            	   }
               }, 
               {field:'initiateTime',width:bodyW*0.18 + 'px',title:'发起时间', align:'center', sortable:true, type:'custom', target:$('#queryCond3')[0]},
               {field:'operation',width:bodyW*0.07 + 'px',title:'操作', align:'center', sortable:false, show:'false', oper:'eq',
            	   formatter: function(value, rowData, rowIndex) {
            		   var finished;
            		   var url = '${contextPath}/riskManagement/management/riskRegister/edit.action?rctFormId=' + rowData.formId;
            		   $.ajax({
            			  url:'${contextPath}/riskManagement/management/riskRegister/isFinished.action',
            			  type:'POST',
            			  async:false,
            			  data:{'formId':rowData.formId},
            			  success:function(data) {
            				  finished = data;
            			  }
            		   });
            		   if(finished == '1') {
            			   url += '&isView=Y';
            			   return '<a href=\'#\' onclick="view(\'' + url + '\')">查看</a>';
            		   }else{
            			   url = '${contextPath}/riskManagement/management/riskRegister/edit.action?rctFormId=' + rowData.formId + '&rctTaskName=' + rowData.taskName;
            			   return '<a href=\'#\' onclick="handle(\'' + url + '\')">处理</a>';
            		   }
            	   }
               }
        	]]
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
		{'index':2, 'display':false},
		{'index':3, 'display':false},
		{'index':4, 'display':true},
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

	function handle(url) {
		window.location.href=url;
	}
	
	function view(url) {
		aud$openNewTab('查看', url, true);
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
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   
      <div id='queryCond1'>
		<input type='text'  class="noborder editElement clear" readonly/>
		<input type='hidden' name='query_eq_acceptingUnit' class="noborder editElement clear" readonly/> 
		<a class="easyui-linkbutton  editElement" iconCls="icon-search"
			style='border-width:0px;'
			onclick="showSysTree(this,{
				title:'发起单位',
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
				title:'发起部门',
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
 		<input type='text'  name='query_mtq_initiateTime' class="easyui-datebox noborder clear" editable="false"/>至
 		<input type='text'  name='query_ltq_initiateTime' class="easyui-datebox noborder clear" editable="false"/>
   </div>
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
