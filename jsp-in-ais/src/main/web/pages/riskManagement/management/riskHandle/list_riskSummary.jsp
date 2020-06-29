<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>风险汇总表</title>
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
var controlSituationArr;
$(function(){
	var bodyW = $('body').width();    
    var bodyH = $('body').height(); 
    $('#query_year').show();
    $('#query_status').show();
    $('#query_riskLevel').show();
    $('#query_prioritySort').show();
 	
    getControlSituationArr();
    frloadOpen();
    g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#sDTable')[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'RiskEvaluateWait',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'id',
        whereSql: 'status in (\'2\',\'3\',\'4\')',
        order:'desc',
        sort:'prioritySort',
        winWidth:800,
        winHeight:250,
        gridJson:{    
            checkOnSelect:false,
            selectOnCheck:true,
            singleSelect:false,
            onLoadSuccess:frloadClose,
            toolbar:[{
            	text:'入风险库',
				iconCls:'icon-remove',
				handler:function(){
					var ids = '';
					var length = 0;
					var obj = $('#sDTable').datagrid('getChecked');
					$.each(obj,function(i,node){
						if(node.riskSource == '新增') {
							ids += node.riskItem + ',';
							length++;
						}
					});
					if(length == 0 || obj.length != length){
						showMessage1('请选择数据源为‘新增’的数据！');
					}else{
						$.ajax({
							url:'${contextPath}/riskManagement/management/riskHandle/importRiskInventory.action',
							data:{'ids':ids},
							type:'POST',
							async:false,
							success:function(data){
								if(data == '1')
									showMessage1('入风险库成功！');
							}
						});
					}
				}
            }],
            columns:[[
               {field:'id', title:'选择', checkbox:true, align:'center', show:'false'},
               {field:'evaluateSerialNum',title:'编号', width:bodyW*0.1 + 'px',align:'center', sortable:true, oper:'like'},
               {field:'evaluateYear',title:'年度', hidden:true, width:bodyW*0.05 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_year')[0]},
               {field:'affiliatedDeptName',title:'所属单位', width:bodyW*0.1 + 'px',align:'center', sortable:true, type:'custom', target:$('#queryCond1')[0]},
               {field:'responsibilityDepName',title:'责任部门', width:bodyW*0.1 + 'px',align:'center', sortable:true, type:'custom', target:$('#queryCond2')[0]},
               {field:'riskFatherSortName',title:'风险大类', hidden:true, width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'false', oper:'like'},
               {field:'riskSonSortName',title:'风险子类', hidden:true, width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'false', oper:'like'},
               
               {field:'riskItemName',title:'风险事项', width:bodyW*0.1 + 'px',align:'left', haign:'center', sortable:true, show:'true', oper:'like',
            	   formatter: function(value, rowData, rowIndex) {
            		   var url = '${contextPath}/riskManagement/management/riskHandle/edit.action?isView=Y&id=' + rowData.id;
            		   return "<a href='javascript:void(0);' onclick='view(\"" + url + "\")'>" + value + "</a>";
            	   }
               },
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
                {field:'controlSituation',title:'风险控制状态评价', width:bodyW*0.1 + 'px',align:'center', sortable:true, oper:'like',
               	   formatter: function(value, rowData, rowIndex){
               			var result = "";
               			for(i in controlSituationArr){
               				if(controlSituationArr[i].code == value) {
               					result = controlSituationArr[i].name;
               					break;
               				}
               			}
						return result;
               	 }},
               	 {field:'riskSource',title:'来源', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'like'}
        	]]
        }
    });	
    g1.batchSetBtn([
		{'index':1, 'display':true},
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
	
	function getControlSituationArr() {
		$.ajax({
			url:'${contextPath}/riskManagement/management/riskHandle/getControlSituationArr.action',
			async:false,
			type:'POST',
			success:function(data){
				if(data.result == '1') {
					controlSituationArr = eval(data.controlSituation);
				}
			}
		});
	}
	
	function view(url) {
		aud$openNewTab('查看风险详情',url,true);
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
